Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFAD4FCC17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbiDLCBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiDLCBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:01:44 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF082220FF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:59:27 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ebf4b91212so87770067b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwiIQJvm6QAhOYPXgpeWanLwDHpbq2oiWm2CURkvYPw=;
        b=NKzN2SmCd3Sfjq59qbM2LPaDXw+UqLF+34Ke3XRV7T7cSxsDKBHkQKyymHku9PUIaJ
         vAKsfCzhqp6P9bNk4blB+AssidlhV5EOxZ41f9P7ur62ok0iVLgOQ9lFiSosGmHdIdfe
         +ohRgUQOEG8zoOviWrDx9SkH3UiE3yQ2y4rnBWTlTpxfIYFDD+d4X9LyQgoVlu3D0S/h
         SIKJ2qlJFx6QUJrRiP8VXLW/FCE4n341sgdA1AqlDotLov2tUdgXjJiwvcSYUAryw8MM
         rTXRESEsoksTPhrwibu3zEoB6bVZEGNxoCR+dkBAuaN8NbfYy8L8H0ffW6WakqoOtz3B
         6iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwiIQJvm6QAhOYPXgpeWanLwDHpbq2oiWm2CURkvYPw=;
        b=h6zCH0yUSQmyQ6zSabA0U+EgS6sxfrFwQW/V9f7Yk1II82T19WhEdbtKpC3yeZIZ6f
         V9Ai3ZhUJxPg2gP3rhcognse3r3oejP37dxl4KVJPzN0bXhXWQ2/QC4hCbyphD40cwHR
         QTICAN49Ju+0BUh9y/GCMHcGSR8sV7X7T7H4tIESfRmIPoOdCkpy5L5FQBGhuLvGfkK7
         ir6XxFlQQRB8Gn6CR9i+3c8WvBjo9oHf6M2w6sQngPN5LqHiVac7GNKQ0eQGYYK2O9FC
         jiWEwKA5NiMvxhn6+Pq/H6cDgWCSLTYgrcqLt/sdn2yhKFCsCMQSCYXLJFc4ofS0+f/8
         spHQ==
X-Gm-Message-State: AOAM530vRVVA5871dH6plLwqAtzqCzSyGu8fIXfJtHoaayDl0LEV+q4S
        QkyilsBg319nIXCoeu9zlncfnK5/dh2m3y6oPeArcg==
X-Google-Smtp-Source: ABdhPJxsPmOjSzm5GIyDrBWJV5HSefjRyr1UXyfsLfq20pib4jp77XhB1H/BEPxGLkZLVnYcemE+0l0P7Ptjo0ZzUDQ=
X-Received: by 2002:a81:1601:0:b0:2eb:e5ea:60dc with SMTP id
 1-20020a811601000000b002ebe5ea60dcmr15305489yww.167.1649728766718; Mon, 11
 Apr 2022 18:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220409135104.3733193-1-wuyun.abel@bytedance.com> <20220409135104.3733193-3-wuyun.abel@bytedance.com>
In-Reply-To: <20220409135104.3733193-3-wuyun.abel@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 11 Apr 2022 18:59:15 -0700
Message-ID: <CABk29NvE=Fmgo4xqQLfy-K8j0hNS-+ppGdYt37yDUnRJiqjZ5w@mail.gmail.com>
Subject: Re: [RFC v2 2/2] sched/fair: introduce sched-idle balance
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

>
> +static inline bool cfs_rq_busy(struct rq *rq)
> +{
> +       return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running == 1;
> +}
> +
> +static inline bool need_pull_cfs_task(struct rq *rq)
> +{
> +       return rq->cfs.h_nr_running == rq->cfs.idle_h_nr_running;
> +}

Note that this will also return true if there are 0 tasks, which I
don't think is the semantics you intend for its use in
rebalance_domains() below.

>  /*
>   * Use locality-friendly rq->overloaded to cache the status of the rq
>   * to minimize the heavy cost on LLC shared data.
> @@ -7837,6 +7867,22 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>         if (kthread_is_per_cpu(p))
>                 return 0;
>
> +       if (unlikely(task_h_idle(p))) {
> +               /*
> +                * Disregard hierarchically idle tasks during sched-idle
> +                * load balancing.
> +                */
> +               if (env->idle == CPU_SCHED_IDLE)
> +                       return 0;
> +       } else if (!static_branch_unlikely(&sched_asym_cpucapacity)) {
> +               /*
> +                * It's not gonna help if stacking non-idle tasks on one
> +                * cpu while leaving some idle.
> +                */
> +               if (cfs_rq_busy(env->src_rq) && !need_pull_cfs_task(env->dst_rq))
> +                       return 0;

These checks don't involve the task at all, so this kind of check
should be pushed into the more general load balance function. But, I'm
not totally clear on the motivation here. If we have cpu A with 1
non-idle task and 100 idle tasks, and cpu B with 1 non-idle task, we
should definitely try to load balance some of the idle tasks from A to
B. idle tasks _do_ get time to run (although little), and this can add
up and cause antagonism to the non-idle task if there are a lot of
idle threads.

>
>  /*
> + * The sched-idle balancing tries to make full use of cpu capacity
> + * for non-idle tasks by pulling them for the unoccupied cpus from
> + * the overloaded ones.
> + *
> + * Return 1 if pulled successfully, 0 otherwise.
> + */
> +static int sched_idle_balance(struct rq *dst_rq)
> +{
> +       struct sched_domain *sd;
> +       struct task_struct *p = NULL;
> +       int dst_cpu = cpu_of(dst_rq), cpu;
> +
> +       sd = rcu_dereference(per_cpu(sd_llc, dst_cpu));
> +       if (unlikely(!sd))
> +               return 0;
> +
> +       if (!atomic_read(&sd->shared->nr_overloaded))
> +               return 0;
> +
> +       for_each_cpu_wrap(cpu, sdo_mask(sd->shared), dst_cpu + 1) {
> +               struct rq *rq = cpu_rq(cpu);
> +               struct rq_flags rf;
> +               struct lb_env env;
> +
> +               if (cpu == dst_cpu || !cfs_rq_overloaded(rq) ||
> +                   READ_ONCE(rq->sched_idle_balance))
> +                       continue;
> +
> +               WRITE_ONCE(rq->sched_idle_balance, 1);
> +               rq_lock_irqsave(rq, &rf);
> +
> +               env = (struct lb_env) {
> +                       .sd             = sd,
> +                       .dst_cpu        = dst_cpu,
> +                       .dst_rq         = dst_rq,
> +                       .src_cpu        = cpu,
> +                       .src_rq         = rq,
> +                       .idle           = CPU_SCHED_IDLE, /* non-idle only */
> +                       .flags          = LBF_DST_PINNED, /* pin dst_cpu */
> +               };
> +
> +               update_rq_clock(rq);
> +               p = detach_one_task(&env);
> +               if (p)
> +                       update_overload_status(rq);
> +
> +               rq_unlock(rq, &rf);
> +               WRITE_ONCE(rq->sched_idle_balance, 0);
> +
> +               if (p) {
> +                       attach_one_task(dst_rq, p);
> +                       local_irq_restore(rf.flags);
> +                       return 1;
> +               }
> +
> +               local_irq_restore(rf.flags);
> +       }
> +
> +       return 0;
> +}

I think this could probably be integrated with the load balancing
function. Your goal is ignore idle tasks for the purpose of pulling
from a remote rq. And I think the above isn't exactly what you want
anyway; detach_tasks/detach_one_task  are just going to iterate the
task list in order. You want to actually look for the non-idle tasks
explicitly.

> @@ -10996,9 +11119,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>
>                 if (sd->flags & SD_BALANCE_NEWIDLE) {
>
> -                       pulled_task = load_balance(this_cpu, this_rq,
> -                                                  sd, CPU_NEWLY_IDLE,
> -                                                  &continue_balancing);
> +                       pulled_task |= load_balance(this_cpu, this_rq,
> +                                                   sd, CPU_NEWLY_IDLE,
> +                                                   &continue_balancing);

Why |= ?

Thanks,
Josh
