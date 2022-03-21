Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7620C4E2D07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350595AbiCUQAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiCUQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:00:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC46646C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:58:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e16so11130817lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7mUgs+m8exZ6HwuVYJPiPXky7x3MAKe69GVmcZiM3o=;
        b=gA6Ds1KyIRjyVddkrBXC/cDFg4pcMNfxw4/mMFwmt6eAvuq5jTWBCJQybqRXUK+XEa
         zDlYLhqLkfsdn8d0bojKa01DkbrNab6E5NiEfnmw1OD2WNOZ8NiS4jPdvxjNbT7643OG
         0zprN6sB077erwZL32QYyLMbkn8u313O+udcp8PEYgmn/9lPyx3Slf02VzAIAZg9bDW1
         6Jlpy8cHL9ECkwlazabrcOtGvTUaol+p8gQw5wMYIW8e2CXmB/vTIH3pTvYzty0j1uTK
         hA17VQEL/EWu2ors4jNuudS5A+IFbOKJSISABm3FznZoT+UZyS94Dr0j1wy6NoMXix5w
         MZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7mUgs+m8exZ6HwuVYJPiPXky7x3MAKe69GVmcZiM3o=;
        b=8Rk24AZhYxgOeJg+i2xuvW86rans3qm1lH9R7MjJhlnSRi8DL3VDkp6elgkhQq1wsa
         wAQkAAurElHYwHUNhbnjBaLftpEgWYw7Va6L7YTxlkG+YFUrf+zfLbrzuFCSy6N62p4b
         +rDe3YdNu3e5v25dSJvGKkvkBVXq06dx5z7VQUHBapbS82vGCeLVVvZl3Vw5f8HK2hTZ
         ZX+7MteuBv349EWZy2tRxxWqXQ/lPNcsq1gNyIbcDPTt2L5ylmDspwPTwAlZ2STJXb8b
         JQ+zpWv3zgOrllKS7TGXlVJcmZAehz53VfDASToDiUvQZRt33BLSRUSvFIcrhpBdJ9IO
         biYw==
X-Gm-Message-State: AOAM5323/CKiqy6A8vJuCcy5myVwFQj7NE/Wnl9r7ea4ZkIbgnTBZbtY
        iDNlSL4p+33vH/20/WTvmY1m/UnRNppFbewCDWj6xA==
X-Google-Smtp-Source: ABdhPJw6O9zVRm4rAw88kSFcB8Ty8VlOhFbLXhkldzAD+QBjvZvCqyBLN3FR/EYWPSEpW17v/8BGdn2ztnn2lfMWyu4=
X-Received: by 2002:a19:ac42:0:b0:448:1f15:4b18 with SMTP id
 r2-20020a19ac42000000b004481f154b18mr15009631lfc.32.1647878329458; Mon, 21
 Mar 2022 08:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220318163656.954440-1-dietmar.eggemann@arm.com>
In-Reply-To: <20220318163656.954440-1-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Mar 2022 16:58:38 +0100
Message-ID: <CAKfTPtB3sPptYAamOr-SixZLd9PbRXLWQcWQzUB=qTD=0OOtGw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Refactor cpu_util_without()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
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

On Fri, 18 Mar 2022 at 17:37, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Except the 'task has no contribution or is new' condition at the
> beginning of cpu_util_without(), which it shares with the load and
> runnable counterpart functions, a cpu_util_next(..., dst_cpu = -1)
> call can replace the rest of it.
>
> The UTIL_EST specific check that task util_est has to be subtracted
> from the CPU one in case of an enqueued (or current (to cater for the
> wakeup - lb race)) task has to be moved to cpu_util_next().
> This was initially introduced by commit c469933e7721
> ("sched/fair: Fix cpu_util_wake() for 'execl' type workloads").
> UnixBench's `execl` throughput tests were run on the dual socket 40
> CPUs Intel E5-2690 v2 to make sure it doesn't regress again.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>
> There is still a lot of CPU utilization related code. cpu_util_without()
> and cpu_util_next() are very similar. In fact the former can be
> refactored to use a call to the latter to be able to remove some
> redundancy.
>
> v1->v2:
>
> (1) Reword comments in cpu_util_next() so they also apply when called
>     by cpu_util_without().
>
> (2) Incorporate comment from cpu_util_without() into comments in
>     cpu_util_next().
>
> I kept the '|| current == p' part in the UTIL_EST specific check to
> close the wakeup - lb race for WF_EXEC tasks even though I couldn't
> recreate it, neither on mainline nor on commit c469933e7721 (v4.20).
>
>  kernel/sched/fair.c | 157 ++++++++++++++++----------------------------
>  1 file changed, 57 insertions(+), 100 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 89d21fda106c..1c3cf84bb81a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6543,108 +6543,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  }
>
>  /*
> - * cpu_util_without: compute cpu utilization without any contributions from *p
> - * @cpu: the CPU which utilization is requested
> - * @p: the task which utilization should be discounted
> - *
> - * The utilization of a CPU is defined by the utilization of tasks currently
> - * enqueued on that CPU as well as tasks which are currently sleeping after an
> - * execution on that CPU.
> - *
> - * This method returns the utilization of the specified CPU by discounting the
> - * utilization of the specified task, whenever the task is currently
> - * contributing to the CPU utilization.
> - */
> -static unsigned long cpu_util_without(int cpu, struct task_struct *p)
> -{
> -       struct cfs_rq *cfs_rq;
> -       unsigned int util;
> -
> -       /* Task has no contribution or is new */
> -       if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
> -               return cpu_util_cfs(cpu);
> -
> -       cfs_rq = &cpu_rq(cpu)->cfs;
> -       util = READ_ONCE(cfs_rq->avg.util_avg);
> -
> -       /* Discount task's util from CPU's util */
> -       lsub_positive(&util, task_util(p));
> -
> -       /*
> -        * Covered cases:
> -        *
> -        * a) if *p is the only task sleeping on this CPU, then:
> -        *      cpu_util (== task_util) > util_est (== 0)
> -        *    and thus we return:
> -        *      cpu_util_without = (cpu_util - task_util) = 0
> -        *
> -        * b) if other tasks are SLEEPING on this CPU, which is now exiting
> -        *    IDLE, then:
> -        *      cpu_util >= task_util
> -        *      cpu_util > util_est (== 0)
> -        *    and thus we discount *p's blocked utilization to return:
> -        *      cpu_util_without = (cpu_util - task_util) >= 0
> -        *
> -        * c) if other tasks are RUNNABLE on that CPU and
> -        *      util_est > cpu_util
> -        *    then we use util_est since it returns a more restrictive
> -        *    estimation of the spare capacity on that CPU, by just
> -        *    considering the expected utilization of tasks already
> -        *    runnable on that CPU.
> -        *
> -        * Cases a) and b) are covered by the above code, while case c) is
> -        * covered by the following code when estimated utilization is
> -        * enabled.
> -        */
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
> + * Predicts what cpu_util(@cpu) would return if @p was removed from @cpu
> + * (@dst_cpu = -1) or migrated to @dst_cpu.
>   */
>  static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
>  {
>         struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> -       unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
> +       unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
>
>         /*
> -        * If @p migrates from @cpu to another, remove its contribution. Or,
> -        * if @p migrates from another CPU to @cpu, add its contribution. In
> -        * the other cases, @cpu is not impacted by the migration, so the
> -        * util_avg should already be correct.
> +        * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its
> +        * contribution. If @p migrates from another CPU to @cpu add its
> +        * contribution. In all the other cases @cpu is not impacted by the
> +        * migration so its util_avg is already correct.
>          */
>         if (task_cpu(p) == cpu && dst_cpu != cpu)
>                 lsub_positive(&util, task_util(p));
> @@ -6652,16 +6563,40 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
>                 util += task_util(p);
>
>         if (sched_feat(UTIL_EST)) {
> +               unsigned long util_est;
> +
>                 util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
>
>                 /*
> -                * During wake-up, the task isn't enqueued yet and doesn't
> -                * appear in the cfs_rq->avg.util_est.enqueued of any rq,
> -                * so just add it (if needed) to "simulate" what will be
> -                * cpu_util after the task has been enqueued.
> +                * During wake-up @p isn't enqueued yet and doesn't contribute
> +                * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
> +                * If @dst_cpu == @cpu add it to "simulate" cpu_util after @p
> +                * has been enqueued.
> +                *
> +                * During exec (@dst_cpu = -1) @p is enqueued and does
> +                * contribute to cpu_rq(cpu)->cfs.util_est.enqueued.
> +                * Remove it to "simulate" cpu_util without @p's contribution.
> +                *
> +                * Despite the task_on_rq_queued(@p) check there is still a
> +                * small window for a possible race when an exec
> +                * select_task_rq_fair() races with LB's detach_task().
> +                *
> +                *   detach_task()
> +                *     deactivate_task()
> +                *       p->on_rq = TASK_ON_RQ_MIGRATING;
> +                *       -------------------------------- A
> +                *       dequeue_task()                    \
> +                *         dequeue_task_fair()              + Race Time
> +                *           util_est_dequeue()            /
> +                *       -------------------------------- B
> +                *
> +                * The additional check "current == p" is required to further
> +                * reduce the race window.
>                  */
>                 if (dst_cpu == cpu)
>                         util_est += _task_util_est(p);
> +               else if (unlikely(task_on_rq_queued(p) || current == p))
> +                       lsub_positive(&util_est, _task_util_est(p));
>
>                 util = max(util, util_est);
>         }
> @@ -6669,6 +6604,28 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
>         return min(util, capacity_orig_of(cpu));
>  }
>
> +/*
> + * cpu_util_without: compute cpu utilization without any contributions from *p
> + * @cpu: the CPU which utilization is requested
> + * @p: the task which utilization should be discounted
> + *
> + * The utilization of a CPU is defined by the utilization of tasks currently
> + * enqueued on that CPU as well as tasks which are currently sleeping after an
> + * execution on that CPU.
> + *
> + * This method returns the utilization of the specified CPU by discounting the
> + * utilization of the specified task, whenever the task is currently
> + * contributing to the CPU utilization.
> + */
> +static unsigned long cpu_util_without(int cpu, struct task_struct *p)
> +{
> +       /* Task has no contribution or is new */
> +       if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
> +               return cpu_util_cfs(cpu);
> +
> +       return cpu_util_next(cpu, p, -1);
> +}
> +
>  /*
>   * compute_energy(): Estimates the energy that @pd would consume if @p was
>   * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
> --
> 2.25.1
>
