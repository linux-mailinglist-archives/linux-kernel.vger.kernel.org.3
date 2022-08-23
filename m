Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B259D293
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbiHWHtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbiHWHtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:49:10 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558765303B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:49:09 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3375488624aso328593447b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gkTv/YGwhJTqg/p3oOyoM/xZAMhxT0emHgJFd/ZlWrw=;
        b=J1mdr+Q5/cVen63OGc+HWdVQlrO7HB6b5Rrs7uP96aARfyhzvtCb+74Bessg5Zo3Vo
         Z8lcKD6fXNdyVnFWMnoSeOPmvrgfPfM3C7ohVwZpUficL4acI8at9z5oQaUXc+pVjbgM
         RU3fbcWFd/rHgv2Lm3/Iv7q5671HXpf1KhKzVObKD3Jxk8BvA8oSbkQ/0FcAK9/RTdkb
         hJWAARIkpkpbUBvqeK+JkT348O6RsSX707uwtkm+nAWao/XOdI11MYnHDqriKFtLKv/w
         r8caJaPKHKEDKJQi9JEEpk+0ug/iJ4k2ck9asxddo2RCaB00ASv/vwckYrG4UYBYhzpF
         uPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gkTv/YGwhJTqg/p3oOyoM/xZAMhxT0emHgJFd/ZlWrw=;
        b=54FoadXAVaU+agbIVL2oju0Ig04Jy+gv3MoiGrkDvceqe3IILX9DFyK7cJ3rhLjGvu
         q6lhkfdinb1xZrjVcpeMtaa24YaiTxu7FIvGGKkHq5BHS8z1nJf+K5UCyLk4a/CgxNCj
         HVNvP3q/1Zky4NBjtkRd/APerizK0qpsBlf+fw/1lQXYgLnM+pgpxj3E7X6c0uZni9vO
         98OeEP7+7SY4POqfcAZNRE+aG23pAybEUaWcPRVDLeaUSNWmt7QbNG4BMt4TQvxGqYQ5
         C3W9n6F4ulVdRY7425PrpY3HrVHelaJLpXoQaDAi03FvLyIrXjNDia5pfwsPW1/GkAI9
         +uYg==
X-Gm-Message-State: ACgBeo1JBC4ypA+N8DKvvzmYr9fMLQj/Nr4v9hsjLMe9nWk1prGQbpm7
        aORKIN6vJZOMTZ5vtnrB6deu+eUA2jCUzlAsGvvFQQ==
X-Google-Smtp-Source: AA6agR6DS/h4oR9B1CJsG8XWGAPHcBewErV/nGrsYtjvSaNyAdxVtePB65KE1ytP14DJEVKlkUX55ktRabrT6IZ8e7w=
X-Received: by 2002:a05:6902:1105:b0:695:c284:a76b with SMTP id
 o5-20020a056902110500b00695c284a76bmr6697273ybu.300.1661240948491; Tue, 23
 Aug 2022 00:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220818124805.601-1-zhouchengming@bytedance.com> <20220818124805.601-9-zhouchengming@bytedance.com>
In-Reply-To: <20220818124805.601-9-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Aug 2022 09:48:56 +0200
Message-ID: <CAKfTPtBV76BwzLiNbubOzzk94W=+7+7abKY18tmmxNaEvd192g@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] sched/fair: move task sched_avg attach to enqueue_task_fair()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 at 14:48, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> When wake_up_new_task(), we use post_init_entity_util_avg() to init
> util_avg/runnable_avg based on cpu's util_avg at that time, and
> attach task sched_avg to cfs_rq.
>
> Since enqueue_task_fair() -> enqueue_entity() -> update_load_avg()
> loop will do attach, we can move this work to update_load_avg().
>
> wake_up_new_task(p)
>   post_init_entity_util_avg(p)
>     attach_entity_cfs_rq()  --> (1)
>   activate_task(rq, p)
>     enqueue_task() := enqueue_task_fair()
>       enqueue_entity() loop
>         update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
>           if (!se->avg.last_update_time && (flags & DO_ATTACH))
>             attach_entity_load_avg()  --> (2)
>
> This patch move attach from (1) to (2), update related comments too.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c319b0bd2bc1..93d7c7b110dd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -799,8 +799,6 @@ void init_entity_runnable_average(struct sched_entity *se)
>         /* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
>  }
>
> -static void attach_entity_cfs_rq(struct sched_entity *se);
> -
>  /*
>   * With new tasks being created, their initial util_avgs are extrapolated
>   * based on the cfs_rq's current util_avg:
> @@ -863,8 +861,6 @@ void post_init_entity_util_avg(struct task_struct *p)
>                 se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
>                 return;
>         }
> -
> -       attach_entity_cfs_rq(se);
>  }
>
>  #else /* !CONFIG_SMP */
> @@ -4002,8 +3998,7 @@ static void migrate_se_pelt_lag(struct sched_entity *se) {}
>   * @cfs_rq: cfs_rq to update
>   *
>   * The cfs_rq avg is the direct sum of all its entities (blocked and runnable)
> - * avg. The immediate corollary is that all (fair) tasks must be attached, see
> - * post_init_entity_util_avg().
> + * avg. The immediate corollary is that all (fair) tasks must be attached.
>   *
>   * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
>   *
> @@ -4236,8 +4231,8 @@ static void remove_entity_load_avg(struct sched_entity *se)
>
>         /*
>          * tasks cannot exit without having gone through wake_up_new_task() ->
> -        * post_init_entity_util_avg() which will have added things to the
> -        * cfs_rq, so we can remove unconditionally.
> +        * enqueue_task_fair() which will have added things to the cfs_rq,
> +        * so we can remove unconditionally.
>          */
>
>         sync_entity_load_avg(se);
> --
> 2.37.2
>
