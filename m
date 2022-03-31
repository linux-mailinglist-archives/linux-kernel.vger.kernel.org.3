Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13904EE13C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbiCaTCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiCaTCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:02:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B81C5922
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:00:52 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h63so564984iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+4Q6s+nz8lXymZ+BOvXU5/KOKeu8WdRXCjGxOwJoVk=;
        b=tt0ddvXbaLrRhnLMPFKB+CUYQRwbrnTkwem+khfqNkPvk9+PZ9Pqk0f8AEufs8Xz4D
         3RkbxjeE+/yFlPVFiPG8kkgQNbvt0nmD2UaZQGbaK7uoDs52LwJVqZXvm3g87FJG+a1e
         nBg0ufu1nFCucwjvgOx9KMAQo0ZOXxVEfii34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+4Q6s+nz8lXymZ+BOvXU5/KOKeu8WdRXCjGxOwJoVk=;
        b=3zblqDoI1V262UCLPqWfX/0xr+IZgXFSE5f7lZeSfw04eAwVMIQeyfYEhDYvhkl7ez
         Us7qilhfhqC+WakFDAX1HWgyeqk1pPr3qfbGG5sxk2tmDcmX3qaAv3Wq8T6dyF0vbShQ
         n0gIUPoUrWDBJalBAMBGij8Yx8SHdoslLf1yhriBNZG74N1+HoMarP92P4l7KJlC+7XB
         YX4rfJdbUdtIeatAXCyRoTZoRo8zGRUHIEw+fsmgp3D1mLRiPX59xNDxQHjHRJv97UKM
         sFfxy1YKRA7BP3E/bsG6eSWBWPQFTDTaMkOz/brA8640zUCuVCf5LWXCfKHEkQPUnWuc
         ozVw==
X-Gm-Message-State: AOAM533XVBZ2I7a1FrMVQhsXBR3cysrJV/aDIkUJvrbACnp1TlIblMQA
        z8OtEAsQ35q06isfxmwBaNnIYq3ufvbUFTFCf4rLwQ==
X-Google-Smtp-Source: ABdhPJyA+Q1vsSlqjqQyotsDvuSnYkG6jt00e2fKYyVvlQdKC79hE4aOUz0lhbQvlaLNfHi+c+MDk5MvT7FYhx5Kt1A=
X-Received: by 2002:a05:6638:3798:b0:321:4bf4:6899 with SMTP id
 w24-20020a056638379800b003214bf46899mr3716345jal.257.1648753252092; Thu, 31
 Mar 2022 12:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220330160535.GN8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220330160535.GN8939@worktop.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 31 Mar 2022 15:00:40 -0400
Message-ID: <CAEXW_YQNi42gahbSJ1skadh_8D+Ry6ZOmMqSU5BdidfCbmOtRg@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Fix forceidle balancing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Guenter Roeck <groeck@chromium.org>
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

Hi,

By the way, might be slightly related - we still see crashes with
pick_task_fair() in our kernel even with this change:
https://lkml.org/lkml/2020/11/17/2137

Is it possible that when doing pick_task_fair() especially on a remote
CPU, both the "cfs_rq->curr" and the rbtree's "left" be NULL with core
scheduling? In this case, se will be NULL and can cause crashes right?
I think the code assumes this can never happen.

+Guenter Roeck  kindly debugged pick_task_fair() in a crash as
follows. Copying some details he mentioned in a bug report:

Assembler/source:

  25:   e8 4f 11 00 00          call   0x1179             ; se =
pick_next_entity(cfs_rq, curr);
  2a:*  48 8b 98 60 01 00 00    mov    0x160(%rax),%rbx   ; trapping
instruction [cfs_rq = group_cfs_rq(se);]
  31:   48 85 db                test   %rbx,%rbx
  34:   75 d1                   jne    0x7
  36:   48 89 c7                mov    %rax,%rdi

At 2a: RAX = se == NULL after pick_next_entity(). Looking closely into
pick_next_entity(), it can indeed return NULL if curr is NULL and if
left in pick_next_entity() is NULL. Per line 7:, curr is in %r14 and
indeed 0.

Thoughts?

-Joel


On Wed, Mar 30, 2022 at 12:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Steve reported that ChromeOS encounters the forceidle balancer being
> ran from rt_mutex_setprio()'s balance_callback() invocation and
> explodes.
>
> Now, the forceidle balancer gets queued every time the idle task gets
> selected, set_next_task(), which is strictly too often.
> rt_mutex_setprio() also uses set_next_task() in the 'change' pattern:
>
>         queued = task_on_rq_queued(p); /* p->on_rq == TASK_ON_RQ_QUEUED */
>         running = task_current(rq, p); /* rq->curr == p */
>
>         if (queued)
>                 dequeue_task(...);
>         if (running)
>                 put_prev_task(...);
>
>         /* change task properties */
>
>         if (queued)
>                 enqueue_task(...);
>         if (running)
>                 set_next_task(...);
>
> However, rt_mutex_setprio() will explicitly not run this pattern on
> the idle task (since priority boosting the idle task is quite insane).
> Most other 'change' pattern users are pidhash based and would also not
> apply to idle.
>
> Also, the change pattern doesn't contain a __balance_callback()
> invocation and hence we could have an out-of-band balance-callback,
> which *should* trigger the WARN in rq_pin_lock() (which guards against
> this exact anti-pattern).
>
> So while none of that explains how this happens, it does indicate that
> having it in set_next_task() might not be the most robust option.
>
> Instead, explicitly queue the forceidle balancer from pick_next_task()
> when it does indeed result in forceidle selection. Having it here,
> ensures it can only be triggered under the __schedule() rq->lock
> instance, and hence must be ran from that context.
>
> This also happens to clean up the code a little, so win-win.
>
> Fixes: d2dfa17bc7de ("sched: Trivial forced-newidle balancer")
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  |   16 +++++++++++-----
>  kernel/sched/idle.c  |    1 -
>  kernel/sched/sched.h |    6 ------
>  3 files changed, 11 insertions(+), 12 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5752,6 +5752,8 @@ static inline struct task_struct *pick_t
>
>  extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
>
> +static void queue_core_balance(struct rq *rq);
> +
>  static struct task_struct *
>  pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> @@ -5801,7 +5803,7 @@ pick_next_task(struct rq *rq, struct tas
>                 }
>
>                 rq->core_pick = NULL;
> -               return next;
> +               goto out;
>         }
>
>         put_prev_task_balance(rq, prev, rf);
> @@ -5851,7 +5853,7 @@ pick_next_task(struct rq *rq, struct tas
>                          */
>                         WARN_ON_ONCE(fi_before);
>                         task_vruntime_update(rq, next, false);
> -                       goto done;
> +                       goto out_set_next;
>                 }
>         }
>
> @@ -5970,8 +5972,12 @@ pick_next_task(struct rq *rq, struct tas
>                 resched_curr(rq_i);
>         }
>
> -done:
> +out_set_next:
>         set_next_task(rq, next);
> +out:
> +       if (rq->core->core_forceidle_count && next == rq->idle)
> +               queue_core_balance(rq);
> +
>         return next;
>  }
>
> @@ -6066,7 +6072,7 @@ static void sched_core_balance(struct rq
>
>  static DEFINE_PER_CPU(struct callback_head, core_balance_head);
>
> -void queue_core_balance(struct rq *rq)
> +static void queue_core_balance(struct rq *rq)
>  {
>         if (!sched_core_enabled(rq))
>                 return;
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -434,7 +434,6 @@ static void set_next_task_idle(struct rq
>  {
>         update_idle_core(rq);
>         schedstat_inc(rq->sched_goidle);
> -       queue_core_balance(rq);
>  }
>
>  #ifdef CONFIG_SMP
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1232,8 +1232,6 @@ static inline bool sched_group_cookie_ma
>         return false;
>  }
>
> -extern void queue_core_balance(struct rq *rq);
> -
>  static inline bool sched_core_enqueued(struct task_struct *p)
>  {
>         return !RB_EMPTY_NODE(&p->core_node);
> @@ -1267,10 +1265,6 @@ static inline raw_spinlock_t *__rq_lockp
>         return &rq->__lock;
>  }
>
> -static inline void queue_core_balance(struct rq *rq)
> -{
> -}
> -
>  static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
>  {
>         return true;
