Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8053A5601E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiF2OGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiF2OGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:06:13 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8122AE25
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:06:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31bf3656517so58262577b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJyu8i2d4QZDoE1FBUQiBB/f1QW5ho+U1lWZeiup2zE=;
        b=oKNHB5pDSCnxp/4F30Z4MEgbR750wCXaiDK1QHrBpvQPuPZoDgupUT4cxjCbVJR2vO
         47EnTt1EJliESfhBzk5yZ7h2pBE84rq7tCmFxQFXB8dtex7+KUeI/CJ8STo09Aa3cZij
         CN6krNqbJU+3VhdI+SRie32OqHx2A7jWQ8hCg+wI9MWI8oEzAodwd77ct8DSQ6wKX1QK
         OudVUg05ulm/iNVYyM1wtA2gFtZ5Ne0Pe6ajCa66vzBi5NVqsZysxSCuGV97JfL8x1tk
         sIlhV4P0Z6URgtH9+PT1urYVf0dv4BGgkUCvnGImil4cuNRsPyxpZH42S3oxmAWhcVge
         R8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJyu8i2d4QZDoE1FBUQiBB/f1QW5ho+U1lWZeiup2zE=;
        b=yHgQeoPst/1pVlzUyF+mGzdOXvDC9zFDv0us/ddEfECaMVlY/wb8f9bNTmgHMtxaRp
         iqUt34sv4ubcvaZK4t4m08eE19womBwbvO3ihXOfCNJRvByeNwzAojDsmSVKM8FUbAvz
         VK0RfhjVhgGaCaVR0JnFrqvoIo2Xz/pvSHixc8JGbASfa1KLJqYXSWNlGYyqgAWCJxcM
         jaf6oYtuC+OwJriGnT+493HknDxAXttKmaGmzhNAfSnjOCXO8LVvcZehYq/W4L4uqiRB
         yXLp8Q7+vyVas8puS80JyH84xgNkUlYcMqWi8hJ6dZnjx7roMurFw7FduvANV2VszGAu
         EY1Q==
X-Gm-Message-State: AJIora+yF84HqmYPkWry5Ea7WIx9GQ6IvhUi6weahVhN/JPqjwvW2xGy
        RFXltQDl22i7r4qDXxVYFfU5Bw65W0BNDSBtaJM7VA==
X-Google-Smtp-Source: AGRyM1sJk/OtKqaEHTIvep1tKtHIvSYI7bXBus6iPzQdG3iPlHPNUdYCqIrA45gmYgKEUbDofodbSc2QE4/y4h7Iqdg=
X-Received: by 2002:a81:8305:0:b0:31c:2a42:b01a with SMTP id
 t5-20020a818305000000b0031c2a42b01amr2122895ywf.359.1656511560829; Wed, 29
 Jun 2022 07:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220622094831.22948-1-zhouchengming@bytedance.com>
In-Reply-To: <20220622094831.22948-1-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 29 Jun 2022 16:05:49 +0200
Message-ID: <CAKfTPtAddY0L9c9V8-ZkmGsRQs_LDK4oB-bJZTFSKxx++2wD1A@mail.gmail.com>
Subject: Re: [PATCH] sched: remove redundant cpu_cgrp_subsys->fork()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        rdunlap@infradead.org, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
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

On Wed, 22 Jun 2022 at 11:48, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> We use cpu_cgrp_subsys->fork() to set task group for the new fair task
> in cgroup_post_fork().
>
> Since commit b1e8206582f9 ("sched: Fix yet more sched_fork() races")
> has already set task group for the new fair task in sched_cgroup_fork(),
> so cpu_cgrp_subsys->fork() can be removed.
>
>   cgroup_can_fork()     --> pin parent's sched_task_group
>   sched_cgroup_fork()
>     __set_task_cpu      --> set task group
>   cgroup_post_fork()
>     ss->fork() := cpu_cgroup_fork()     --> set again
>
> After this change, task_change_group_fair() only need to care about
> task cgroup migration, make the code much simplier.
>
> This patch move the task se depth setting to set_task_rq(), which
> is called when task moves across CPUs/groups, is a better place than
> attach_entity_cfs_rq(). The latter is also used when change task's
> sched_class, in which case the group/depth doesn't change actually.
>

The commit message needs some minor fixes but apart from this

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/core.c  | 27 ++++-----------------------
>  kernel/sched/fair.c  | 31 +------------------------------
>  kernel/sched/sched.h |  6 ++----
>  3 files changed, 7 insertions(+), 57 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c16f8cc5de08..f44bc5b889ab 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -481,8 +481,7 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
>   *                             p->se.load, p->rt_priority,
>   *                             p->dl.dl_{runtime, deadline, period, flags, bw, density}
>   *  - sched_setnuma():         p->numa_preferred_nid
> - *  - sched_move_task()/
> - *    cpu_cgroup_fork():       p->sched_task_group
> + *  - sched_move_task():       p->sched_task_group
>   *  - uclamp_update_active()   p->uclamp*
>   *
>   * p->state <- TASK_*:
> @@ -10098,7 +10097,7 @@ void sched_release_group(struct task_group *tg)
>         spin_unlock_irqrestore(&task_group_lock, flags);
>  }
>
> -static void sched_change_group(struct task_struct *tsk, int type)
> +static void sched_change_group(struct task_struct *tsk)
>  {
>         struct task_group *tg;
>
> @@ -10114,7 +10113,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         if (tsk->sched_class->task_change_group)
> -               tsk->sched_class->task_change_group(tsk, type);
> +               tsk->sched_class->task_change_group(tsk);
>         else
>  #endif
>                 set_task_rq(tsk, task_cpu(tsk));
> @@ -10145,7 +10144,7 @@ void sched_move_task(struct task_struct *tsk)
>         if (running)
>                 put_prev_task(rq, tsk);
>
> -       sched_change_group(tsk, TASK_MOVE_GROUP);
> +       sched_change_group(tsk);
>
>         if (queued)
>                 enqueue_task(rq, tsk, queue_flags);
> @@ -10223,23 +10222,6 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
>         sched_unregister_group(tg);
>  }
>
> -/*
> - * This is called before wake_up_new_task(), therefore we really only
> - * have to set its group bits, all the other stuff does not apply.
> - */
> -static void cpu_cgroup_fork(struct task_struct *task)
> -{
> -       struct rq_flags rf;
> -       struct rq *rq;
> -
> -       rq = task_rq_lock(task, &rf);
> -
> -       update_rq_clock(rq);
> -       sched_change_group(task, TASK_SET_GROUP);
> -
> -       task_rq_unlock(rq, task, &rf);
> -}
> -
>  static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
>  {
>         struct task_struct *task;
> @@ -11136,7 +11118,6 @@ struct cgroup_subsys cpu_cgrp_subsys = {
>         .css_released   = cpu_cgroup_css_released,
>         .css_free       = cpu_cgroup_css_free,
>         .css_extra_stat_show = cpu_extra_stat_show,
> -       .fork           = cpu_cgroup_fork,
>         .can_attach     = cpu_cgroup_can_attach,
>         .attach         = cpu_cgroup_attach,
>         .legacy_cftypes = cpu_legacy_files,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8bed75757e65..fdb9125fe34e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11325,14 +11325,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
>  {
>         struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
> -#ifdef CONFIG_FAIR_GROUP_SCHED
> -       /*
> -        * Since the real-depth could have been changed (only FAIR
> -        * class maintain depth value), reset depth properly.
> -        */
> -       se->depth = se->parent ? se->parent->depth + 1 : 0;
> -#endif
> -
>         /* Synchronize entity with its cfs_rq */
>         update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>         attach_entity_load_avg(cfs_rq, se);
> @@ -11431,15 +11423,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>  }
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -static void task_set_group_fair(struct task_struct *p)
> -{
> -       struct sched_entity *se = &p->se;
> -
> -       set_task_rq(p, task_cpu(p));
> -       se->depth = se->parent ? se->parent->depth + 1 : 0;
> -}
> -
> -static void task_move_group_fair(struct task_struct *p)
> +static void task_change_group_fair(struct task_struct *p)
>  {
>         detach_task_cfs_rq(p);
>         set_task_rq(p, task_cpu(p));
> @@ -11451,19 +11435,6 @@ static void task_move_group_fair(struct task_struct *p)
>         attach_task_cfs_rq(p);
>  }
>
> -static void task_change_group_fair(struct task_struct *p, int type)
> -{
> -       switch (type) {
> -       case TASK_SET_GROUP:
> -               task_set_group_fair(p);
> -               break;
> -
> -       case TASK_MOVE_GROUP:
> -               task_move_group_fair(p);
> -               break;
> -       }
> -}
> -
>  void free_fair_sched_group(struct task_group *tg)
>  {
>         int i;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 317480d535b0..8433e22da3ab 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1901,6 +1901,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
>         set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
>         p->se.cfs_rq = tg->cfs_rq[cpu];
>         p->se.parent = tg->se[cpu];
> +       p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
>  #endif
>
>  #ifdef CONFIG_RT_GROUP_SCHED
> @@ -2163,11 +2164,8 @@ struct sched_class {
>
>         void (*update_curr)(struct rq *rq);
>
> -#define TASK_SET_GROUP         0
> -#define TASK_MOVE_GROUP                1
> -
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -       void (*task_change_group)(struct task_struct *p, int type);
> +       void (*task_change_group)(struct task_struct *p);
>  #endif
>  };
>
> --
> 2.36.1
>
