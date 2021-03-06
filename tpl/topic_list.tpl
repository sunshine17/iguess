{% for segment in list %}
<div class="segment clear" id="{{ segment.key }}">
    <div class="vote">
        {% if segment.can_vote %}
        <a class="upvote" href="#"></a>
        {% else %}
        <a class="upvote disabled" title="您尚未登陆或已投过票" href="#"></a>
        {% endif %}
        <div class="mark">{{ segment.votedown|default:0|add:segment.voteup|default:0 }}</div>
        {% if segment.can_vote %}
        <a class="downvote" href="#"></a>
        {% else %}
        <a class="downvote disabled" title="您尚未登陆或已投过票" href="#"></a>
        {% endif %}
    </div>
    <div class="rt">
        <p class="sentence">
        {{ segment.sentence }}
        </p>
        <div class="clear" style="padding-bottom:1px">
            {% if segment.has_answered %}
            <a class="btn c-answer" href="#">✓ 看影名</a>
            <span class="hide real-answer">{{ segment.answer }}</span>
            {% else %} {% if segment.has_seen_answer %}
            <a class="btn c-answer" href="#">✗ 看影名</a>
            <span class="hide real-answer">{{ segment.answer }}</span>
            {% else %} {% if segment.is_self_added %}
            <a class="btn c-answer" href="#">看影名</a>
            <span class="hide real-answer">{{ segment.answer }}</span>
            {% else %}
            <span class="answer">
                <form action="/guess" method="post">
                <input name="id" value="{{ segment.key.id }}" type="hidden" />
                <input type="text" name="answer" placeholder="输入电影名，回车" />
                </form>
                <span class="success"></span>
                <span class="fail hide"><span class="message"></span>
                {% if user.logged_in %}
                <a class="btn view-answer" style="display:inline-block; font-size:12px; line-height:20px; height:20px" href="/getanswer?id={{ segment.key.id}}">看答案</a>
                {% endif %}
                </span>
            </span>
            {% endif %} {% endif %} {% endif %}
            <a href="https://profiles.google.com/{{ segment.author.nickname }}" target="_blank" class="author">{{ segment.author.nickname }}</a>
            {% if segment.answered_count or segment.failed_count %}
            <div style="clear:both; color:#aaa;font-size:12px;padding-top:3px">有 {{ segment.failed_count|default:0|add:segment.answered_count|default:0 }} 人进行了尝试，
            {% if segment.answered_count %}
            有 {{ segment.answered_count }} 人答对了
            {% else %}
            但都没有答对
            {% endif %}
            </div>
            {% endif %}
        </div>
    </div>
</div>
{% endfor %}

{% if list_length == items_per_page %}
<a class="page_btn" href="/?page={{ page }}">更多</a>
{% else %}
<p class="no-more">莫有了，要不您来贡献点？</p>
{% endif %}
