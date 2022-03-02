Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047484CA05D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbiCBJKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbiCBJKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:10:38 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBFEBBE11
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:09:55 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t14so1309163ljh.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 01:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJlJphj19pHMQYt95YLsnPibKceqpy8QQ8JVCGrJtRQ=;
        b=tInBEtFt0p3h+c7tNfx5Zh5J7i741S0aaV9t1mE5ONvgFMmsPFv4uifLH3oXdwhj3H
         axt1JCZvyNiKJ0/vYM8hg6dcXkKgG3Vozwad7kujh99tk+D03b4WuS9c9ekRxzjHBx8L
         WEuj4KCZoctDHxOemeh0ExTvxqOWMvx0DfiM6fRi8PX3bGkbofOrgUsAJaDQXGJ6KDF6
         gkAU/LhgaXyUyAepRCvy0ClpU0CMcoyMa0VG3BOdpV903YvV5bFUw2jsF5m4NYDVUHFQ
         PE6U32BziyyWBk+W+71wG2azjt4eJTZnUYhKSrkQmL4GdZtqZxHXQWt8SbtLxFkv6OQ3
         uamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJlJphj19pHMQYt95YLsnPibKceqpy8QQ8JVCGrJtRQ=;
        b=WO526SKJyuu9PyVikVqY2De/RC5LhqmOmFhkDdYNgXjBcWfAyie1nNn3EXeVpz6yfN
         xErYRyFx5DZCNUTXK3mO3LfkDVpODMxAAfs6l7XT3NN/W4OZIaco3VCMv6lxDA4KK4OD
         CXDmWF566gUgqXqLIZouwIBjr6Dy372YurIcc1m25mPqJsLcEQw2+k1Te+hQ4qw+RtcI
         L6RdNwFv0ZXBTWpgJJ+H6Snh8KEUSyADi57yFK4uaMgMSIiVQo3gUdrkvLmL8XN4CRN7
         RW1f7q5oPlDecElZ7Cpl8IhvfWpDsjzoiGDwWrA813VGXO2k+PirqWKrVMGnhUSa7Qr2
         ttBA==
X-Gm-Message-State: AOAM532PRPK8NhFvcQzTV1Z0CV5245LZzyTRlaCBMFTDujOf6x4YX/m5
        vUbUB1rk60i5f3ySWH+s4seoFaax6Pmuc8A3TceTNA==
X-Google-Smtp-Source: ABdhPJzmNojk0Gh0hEGscVvWr2RVu+yt114mEhYgxYAXLsBMlm4IGOaYJr//7koN5PbxnXOiKNPBEFDzBnZR4+v8spo=
X-Received: by 2002:a2e:a905:0:b0:246:609b:881e with SMTP id
 j5-20020a2ea905000000b00246609b881emr19428340ljq.383.1646212193518; Wed, 02
 Mar 2022 01:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20220301171727.812157-1-dietmar.eggemann@arm.com>
In-Reply-To: <20220301171727.812157-1-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Mar 2022 10:09:42 +0100
Message-ID: <CAKfTPtD6i7oYZuAMYFmxFnRHETUAgKYV1gxoMiMjSksBs6Z=rg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Refactor cpu_util_without()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
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

On Tue, 1 Mar 2022 at 18:17, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Except the 'task has no contribution or is new' condition at the
> beginning of cpu_util_without(), a cpu_util_next(..., dst_cpu = -1)
> call can replace the rest of this function.
>
> The UTIL_EST specific check for a race between select_task_rq_fair()
> and detach_task() in case of an enqueued or running WF_EXEC task has
> to be moved to cpu_util_next().
> This was initially introduced by commit c469933e7721
> ("sched/fair: Fix cpu_util_wake() for 'execl' type workloads").
> UnixBench's `execl` throughput tests were run on the dual socket 40
> CPUs Intel E5-2690 v2 machine to make sure the regression doesn't
> occur again.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

I have only minor comment

> ---
>
> There is still a lot of CPU utilization related code. cpu_util_without()
> and cpu_util_next() are very similar. In fact the former can be
> refactored to use a call to the latter to be able to remove some
> redundancy.
>
>  kernel/sched/fair.c | 143 ++++++++++++++++++--------------------------
>  1 file changed, 59 insertions(+), 84 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 16874e112fe6..c084c2e29e40 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6511,6 +6511,64 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         return target;
>  }
>
> +/*
> + * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
> + * to @dst_cpu.
> + */
> +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> +{
> +       struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> +       unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
> +
> +       /*
> +        * If @p migrates from @cpu to another, remove its contribution. Or,
> +        * if @p migrates from another CPU to @cpu, add its contribution. In
> +        * the other cases, @cpu is not impacted by the migration, so the
> +        * util_avg should already be correct.
> +        */
> +       if (task_cpu(p) == cpu && dst_cpu != cpu)
> +               lsub_positive(&util, task_util(p));
> +       else if (task_cpu(p) != cpu && dst_cpu == cpu)
> +               util += task_util(p);
> +
> +       if (sched_feat(UTIL_EST)) {
> +               util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +
> +               /*
> +                * During wake-up, the task isn't enqueued yet and doesn't
> +                * appear in the cfs_rq->avg.util_est.enqueued of any rq,
> +                * so just add it (if needed) to "simulate" what will be
> +                * cpu_util after the task has been enqueued.
> +                */
> +               if (dst_cpu == cpu)
> +                       util_est += _task_util_est(p);
> +

Could you add a comment that explains why the addition above will not
be removed below by the lsub_positive below so it isn't worth trying
to optimize such a case?

> +               /*
> +                * Despite the following checks we still have a small window
> +                * for a possible race, when an execl's select_task_rq_fair()
> +                * races with LB's detach_task():
> +                *
> +                *   detach_task()
> +                *     p->on_rq = TASK_ON_RQ_MIGRATING;
> +                *     ---------------------------------- A
> +                *     deactivate_task()                   \
> +                *       dequeue_task()                     + RaceTime
> +                *         util_est_dequeue()              /
> +                *     ---------------------------------- B
> +                *
> +                * The additional check on "current == p" it's required to
> +                * properly fix the execl regression and it helps in further
> +                * reducing the chances for the above race.
> +                */
> +               if (unlikely(task_on_rq_queued(p) || current == p))
> +                       lsub_positive(&util_est, _task_util_est(p));
> +
> +               util = max(util, util_est);
> +       }
> +
> +       return min(util, capacity_orig_of(cpu));
> +}
> +
>  /*
>   * cpu_util_without: compute cpu utilization without any contributions from *p
>   * @cpu: the CPU which utilization is requested
> @@ -6526,19 +6584,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   */
>  static unsigned long cpu_util_without(int cpu, struct task_struct *p)
>  {
> -       struct cfs_rq *cfs_rq;
> -       unsigned int util;
> -
>         /* Task has no contribution or is new */
>         if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
>                 return cpu_util_cfs(cpu);
>
> -       cfs_rq = &cpu_rq(cpu)->cfs;
> -       util = READ_ONCE(cfs_rq->avg.util_avg);
> -
> -       /* Discount task's util from CPU's util */
> -       lsub_positive(&util, task_util(p));
> -
>         /*
>          * Covered cases:
>          *
> @@ -6560,82 +6609,8 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
>          *    estimation of the spare capacity on that CPU, by just
>          *    considering the expected utilization of tasks already
>          *    runnable on that CPU.

The comment about the covered cases above should be moved in
cpu_util_next() which is where the cases are covered now

> -        *
> -        * Cases a) and b) are covered by the above code, while case c) is
> -        * covered by the following code when estimated utilization is
> -        * enabled.
>          */
> -       if (sched_feat(UTIL_EST)) {
> -               unsigned int estimated =
> -                       READ_ONCE(cfs_rq->avg.util_est.enqueued);
> -
> -               /*
> -                * Despite the following checks we still have a small window
> -                * for a possible race, when an execl's select_task_rq_fair()
> -                * races with LB's detach_task():
> -                *
> -                *   detach_task()
> -                *     p->on_rq = TASK_ON_RQ_MIGRATING;
> -                *     ---------------------------------- A
> -                *     deactivate_task()                   \
> -                *       dequeue_task()                     + RaceTime
> -                *         util_est_dequeue()              /
> -                *     ---------------------------------- B
> -                *
> -                * The additional check on "current == p" it's required to
> -                * properly fix the execl regression and it helps in further
> -                * reducing the chances for the above race.
> -                */
> -               if (unlikely(task_on_rq_queued(p) || current == p))
> -                       lsub_positive(&estimated, _task_util_est(p));
> -
> -               util = max(util, estimated);
> -       }
> -
> -       /*
> -        * Utilization (estimated) can exceed the CPU capacity, thus let's
> -        * clamp to the maximum CPU capacity to ensure consistency with
> -        * cpu_util.
> -        */
> -       return min_t(unsigned long, util, capacity_orig_of(cpu));
> -}
> -
> -/*
> - * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
> - * to @dst_cpu.
> - */
> -static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> -{
> -       struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> -       unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
> -
> -       /*
> -        * If @p migrates from @cpu to another, remove its contribution. Or,
> -        * if @p migrates from another CPU to @cpu, add its contribution. In
> -        * the other cases, @cpu is not impacted by the migration, so the
> -        * util_avg should already be correct.
> -        */
> -       if (task_cpu(p) == cpu && dst_cpu != cpu)
> -               lsub_positive(&util, task_util(p));
> -       else if (task_cpu(p) != cpu && dst_cpu == cpu)
> -               util += task_util(p);
> -
> -       if (sched_feat(UTIL_EST)) {
> -               util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> -
> -               /*
> -                * During wake-up, the task isn't enqueued yet and doesn't
> -                * appear in the cfs_rq->avg.util_est.enqueued of any rq,
> -                * so just add it (if needed) to "simulate" what will be
> -                * cpu_util after the task has been enqueued.
> -                */
> -               if (dst_cpu == cpu)
> -                       util_est += _task_util_est(p);
> -
> -               util = max(util, util_est);
> -       }
> -
> -       return min(util, capacity_orig_of(cpu));
> +       return cpu_util_next(cpu, p, -1);
>  }
>
>  /*
> --
> 2.25.1
>
