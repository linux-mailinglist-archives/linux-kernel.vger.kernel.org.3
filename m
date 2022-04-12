Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5F4FCBDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbiDLBZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiDLBZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:25:49 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897319C31
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:23:32 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id f38so30577183ybi.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JMm7jrb08dwa4TNW9El0B969rP5rs/JZ0el348oYQhg=;
        b=hqpTdL0QATE2nRBZcg9/sARzvk++crfDpAB0EJ8/t3kvFMRc3oOYdwDiaMQclM51yq
         dzbn/LyreN2tZmKHjMv444GCF9WOcrieYOATDxHNqefI7RT29WEgN+rEhl6MENEbGKQx
         aMlWfUypfPV1zRZtWmrvvbEsAq2B3dkKWWdNCHiOm1TToXulgzLplLkIFVr9QSiZ5Pgh
         KBzIf/EjkbuUd37WBrSVsJj9g5uUe2YEu7c3dkFSqdO2H6NpCw6HnIm0TrbDp42Ty2DA
         CRT0rr69UcO5H4E3HKJMs0thlWixD26F/vmyyApHfhJzRbLdjkviycao4CsfAiMgEDLA
         0P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JMm7jrb08dwa4TNW9El0B969rP5rs/JZ0el348oYQhg=;
        b=RTOBHBCJK6iBkCL6CpjVsItlLK9tTyX09j7+ecJyj7UsI+ZrMm+84RODQ7BAxPcgIe
         x0Tp3Z2n0PAXxU2hmwZpsCi6djvUyYaRjgW51vvhPeHuwavk6zQOLSOshj1bWTgfF9iI
         VTQ9DnVC+KpR5DR4oZVlHEujxgGFjr+yr+yf5z0t43gKxoz1wlmBNmws9jKpmJDJS/V+
         Su3jT4vwQdXmS6T9dX23aV57o86/MgHMqgXg9MMBdwbDpfvqiqO/ZZKx430nGTZzF5EC
         WuYUmSck64Qc8nj9Hb/U85iAiXq2Nii2BYImiwPWtYIW8dry5rMK0xxAa+rJRFTvzO3I
         aEqA==
X-Gm-Message-State: AOAM532URJgF/MSP3I6NTLIL64/ZeyN3zQ+tKbOBE5BwUOlM3RfZekAF
        z6DazY4gdh3HYdoIZoQ7vF6JmU9xu/PqrD4Gyi5jpQ==
X-Google-Smtp-Source: ABdhPJzhyGVLD2eepDvh6uu3m30+OPZpilHLd2y8VLOCgnkpfz9DZ2joQY+Mpf2bKwX0YZbTioWQ8AmeZ5BkhBp3NSI=
X-Received: by 2002:a25:41cf:0:b0:641:1857:ac7c with SMTP id
 o198-20020a2541cf000000b006411857ac7cmr11832405yba.281.1649726610934; Mon, 11
 Apr 2022 18:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220409135104.3733193-1-wuyun.abel@bytedance.com> <20220409135104.3733193-2-wuyun.abel@bytedance.com>
In-Reply-To: <20220409135104.3733193-2-wuyun.abel@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 11 Apr 2022 18:23:20 -0700
Message-ID: <CABk29NtBL2WovUVcxXW8cF7Nk+UM_AeEJaX_JbQ4Wue-qMvz_w@mail.gmail.com>
Subject: Re: [RFC v2 1/2] sched/fair: filter out overloaded cpus in SIS
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

Thanks for the patch, a few comments:

>  /*
> + * It would be very unlikely to find an unoccupied cpu when system is heavily
> + * overloaded. Even if we could, the cost might bury the benefit.
> + */
> +static inline bool sched_domain_overloaded(struct sched_domain *sd, int nr_overloaded)
> +{
> +       return nr_overloaded > sd->span_weight - (sd->span_weight >> 4);
> +}
> +
> +/*
>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>   * average idle time for this rq (as found in rq->avg_idle).
> @@ -6291,7 +6300,7 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> -       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +       int i, cpu, idle_cpu = -1, nr = INT_MAX, nro;
>         struct rq *this_rq = this_rq();
>         int this = smp_processor_id();
>         struct sched_domain *this_sd;
> @@ -6301,7 +6310,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>         if (!this_sd)
>                 return -1;
>
> +       nro = atomic_read(&sd->shared->nr_overloaded);
> +       if (sched_domain_overloaded(sd, nro))
> +               return -1;

This early bail out doesn't seem to be related to the main idea of
your patch. Apart from deciding the exact heuristic value for what is
considered too unlikely to find an idle cpu, this doesn't work well
with tasks constrained by affinity; a task may have a small affinity
mask containing idle cpus it may wake onto, even if most of the node
is overloaded.

>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +       if (nro)
> +               cpumask_andnot(cpus, cpus, sdo_mask(sd->shared));

To prevent us from exhausting our search attempts too quickly, this
only needs to go under the sched_feat(SIS_PROP) && !has_idle_core case
below. But by doing this unconditionally here, I guess your secondary
goal is to reduce total search cost in both cases. Just wondering, did
you observe significant time spent here that you are trying to
optimize? By reducing our search space by the overload mask, it is
important that the mask is relatively up to date, or else we could
miss an opportunity to find an idle cpu.

>         if (sched_feat(SIS_PROP) && !has_idle_core) {
>                 u64 avg_cost, avg_idle, span_avg;
> @@ -7018,6 +7033,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>
>         return newidle_balance(rq, rf) != 0;
>  }
> +
> +static inline bool cfs_rq_overloaded(struct rq *rq)
> +{
> +       return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running > 1;
> +}

Why > 1 instead of > 0? If a cpu is running 1 non-idle task and any
number of idle tasks, I'd think it is still "occupied" in the way
you've defined. We'd want to steer wakeups to cpus running 0 non-idle
tasks.

> +static void update_overload_status(struct rq *rq)
> +{
> +       struct sched_domain_shared *sds;
> +       bool overloaded = cfs_rq_overloaded(rq);
> +       int cpu = cpu_of(rq);
> +
> +       lockdep_assert_rq_held(rq);
> +
> +       if (rq->overloaded == overloaded)
> +               return;
> +
> +       rcu_read_lock();
> +       sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +       if (unlikely(!sds))
> +               goto unlock;
> +
> +       if (overloaded) {
> +               cpumask_set_cpu(cpu, sdo_mask(sds));
> +               atomic_inc(&sds->nr_overloaded);
> +       } else {
> +               cpumask_clear_cpu(cpu, sdo_mask(sds));
> +               atomic_dec(&sds->nr_overloaded);
> +       }

Why are these cpu mask writes not atomic?

> +
> +       rq->overloaded = overloaded;
> +unlock:
> +       rcu_read_unlock();
> +}
> +
> +#else
> +
> +static inline void update_overload_status(struct rq *rq) { }
> +
>  #endif /* CONFIG_SMP */
>
>  static unsigned long wakeup_gran(struct sched_entity *se)
> @@ -7365,6 +7425,8 @@ done: __maybe_unused;
>         if (new_tasks > 0)
>                 goto again;
>
> +       update_overload_status(rq);
> +
>         /*
>          * rq is about to be idle, check if we need to update the
>          * lost_idle_time of clock_pelt
> @@ -11183,6 +11245,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>         if (static_branch_unlikely(&sched_numa_balancing))
>                 task_tick_numa(rq, curr);
>
> +       update_overload_status(rq);
>         update_misfit_status(curr, rq);
>         update_overutilized_status(task_rq(curr));

I'd caution about using task_tick and pick_next_task_fair as the
places we set and clear overload.

Some issues with task_tick:
- ticks may be disabled in NO_HZ_FULL (an issue if we define overload
as > 0 non-idle tasks)
- most ticks will have the same state, so somewhat redundant checking.
Could use an edge based trigger instead, such as enqueue/dequeue
(somewhat similar to rq->rd->overload).

With pick_next_task_fair():
- there's a window between a thread dequeuing, and then scheduler
running through to the end of pick_next_task_fair(), during which we
falsely observe the cpu as overloaded
- this breaks with core scheduling, since we may use pick_task_fair
rather than pick_next_task_fair

Thanks,
Josh
