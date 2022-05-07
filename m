Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD7451E86F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385856AbiEGQOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiEGQN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:13:56 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8352F252B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 09:10:09 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id m128so17775932ybm.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=we4rKjwEgplzbDTrpQbxkpNgQB9VljuN20ZsFCtp86Q=;
        b=D4t5RDWbbrEuMSwGQ7gGguDQtvpzIhUdzarh4BQFLgqb0a+Jy9DqbV1PdFdKhmLGB2
         RfC4d0mlAqs9ez2eTdeoNsVWJ1r4MA0xkDXJLWaX7A9VxiNf98YsFWoKNyFLFjNnLh6A
         dPQHnJBXoL4jvSTfa2pDqLNN07Wdc61+j6Gm2Cv8wAK0qJiIdilGa0um922ioNKZVnc7
         baAA81O3pLn76YC3G52zWrV/TlDZFDXGUuwsifoEjSpWfQENT0qCYXUKa46yjfN7V+Pi
         zW41W5wabQuYxVjh8oUfFVieMRoVmq8uj9EHyAuDa56itw0GSpEezJWdL8BYbKx8wMzl
         r5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=we4rKjwEgplzbDTrpQbxkpNgQB9VljuN20ZsFCtp86Q=;
        b=iCwKxtz4NiNKbejNgXqEk6CeLmaFiOHGh1ImY5pgRVkFWKzG3sWp/5aXhxENaNyG+2
         RQY3lS7NR59l1lnY86/pSOVIcf8e8uke0x4lYZsuvovtXlcO8f4x4LTzCbtx0QPKcj8A
         oB3JUBkeIUQ4B8kIOpnbG88Wv13ZyltxX88Xjh+ToyDemNS9yIRtdz84xTpE9OK8TAIw
         8lTSbN9crNl543LcBcRf7tIsc3Goa0RpuDRLRFTL9IBM9R86aPHEVxVE1koXRP8/bWlH
         yQMJ+zZ6w7eWliLDVH/B6dt8UmsdtAL3xa/Bjljb8cyrnmekjIBmmmPiVvU2TSNbwC0i
         p75g==
X-Gm-Message-State: AOAM531sMwdWXm3c6D9De+EXT+P8JOU4Wt9eWY96+067IMQuiO6ybU9H
        YXDLMfIkzBiOmz4Aiopro92cItKa/lKWyJ7BhMg=
X-Google-Smtp-Source: ABdhPJxzYkcw6NzTdcPHXTeOE3NzAukn1vKAwhtixAYxbNbmYhh3x7wuQi03Gg2MXeSISRjRRJmC6mFPbbbSt+irhMw=
X-Received: by 2002:a25:182:0:b0:64a:24f:be51 with SMTP id 124-20020a250182000000b0064a024fbe51mr6904384ybb.393.1651939808623;
 Sat, 07 May 2022 09:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
In-Reply-To: <20220505122331.42696-1-wuyun.abel@bytedance.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Sun, 8 May 2022 00:09:57 +0800
Message-ID: <CADjb_WTRYjSD8z0BCE=u322iJmQVuEq5cUMTZO6ij9V-=ViY-w@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 in
Hi Abel,
On Fri, May 6, 2022 at 1:21 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> Try to improve searching efficiency of SIS by filtering out the
> overloaded cpus, and as a result the more overloaded the system
> is, the less cpus will be searched.
>
My understanding is that, this patch aims to address the following issue:
What kind of CPUs should the SIS  scan.
And we also have another patch[1]  from another angle:
How many CPUs should the SIS  scan.
I assume the two direction could both help speed up the SIS process, so
I'm curious what the result would be with both patch applied, and I planned
to run your patch on my system too.
> The overloaded cpus are tracked through LLC shared domain. To
> regulate accesses to the shared data, the update happens mainly
> at the tick. But in order to make it more accurate, we also take
> the task migrations into consideration during load balancing which
> can be quite frequent due to short running workload causing newly-
> idle. Since an overloaded runqueue requires at least 2 non-idle
> tasks runnable, we could have more faith on the "frequent newly-
> idle" case.
>
> Benchmark
> =========
>
> Tests are done in an Intel(R) Xeon(R) Platinum 8260 CPU@2.40GHz
> machine with 2 NUMA nodes each of which has 24 cores with SMT2
> enabled, so 96 CPUs in total.
>
> All of the benchmarks are done inside a normal cpu cgroup in a
Do you have any script that I can leverage to launch the test?
> clean environment with cpu turbo disabled.
I would recommend to apply the following patch(queued for 5.19) if
the intel_pstate driver is loaded, because it seems that there is a
utilization calculation
issue when turbo is disabled:

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 846bb3a78788..2216b24b6f84 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1322,6 +1322,7 @@ static ssize_t store_no_turbo(struct kobject *a,
struct kobj_attribute *b,
  mutex_unlock(&intel_pstate_limits_lock);

  intel_pstate_update_policies();
+ arch_set_max_freq_ratio(global.no_turbo);

  mutex_unlock(&intel_pstate_driver_lock);

--
2.25.1
[cut]
>
> v3:
>   - removed sched-idle balance feature and focus on SIS
>   - take non-CFS tasks into consideration
>   - several fixes/improvement suggested by Josh Don
>
> v2:
>   - several optimizations on sched-idle balancing
>   - ignore asym topos in can_migrate_task
>   - add more benchmarks including SIS efficiency
>   - re-organize patch as suggested by Mel
>
> v1: https://lore.kernel.org/lkml/20220217154403.6497-5-wuyun.abel@bytedance.com/
> v2: https://lore.kernel.org/lkml/20220409135104.3733193-1-wuyun.abel@bytedance.com/
>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/linux/sched/topology.h | 12 ++++++++++
>  kernel/sched/core.c            | 38 ++++++++++++++++++++++++++++++
>  kernel/sched/fair.c            | 43 +++++++++++++++++++++++++++-------
>  kernel/sched/idle.c            |  1 +
>  kernel/sched/sched.h           |  4 ++++
>  kernel/sched/topology.c        |  4 +++-
>  6 files changed, 92 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 56cffe42abbc..95c7ad1e05b5 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -81,8 +81,20 @@ struct sched_domain_shared {
>         atomic_t        ref;
>         atomic_t        nr_busy_cpus;
>         int             has_idle_cores;
> +
> +       /*
> +        * Tracking of the overloaded cpus can be heavy, so start
> +        * a new cacheline to avoid false sharing.
> +        */
Although we put the following items into different cache line compared to
above ones, is it possible that there is still cache false sharing if
CPU1 is reading nr_overloaded_cpus while
CPU2 is updating overloaded_cpus?
> +       atomic_t        nr_overloaded_cpus ____cacheline_aligned;
____cacheline_aligned seems to put nr_overloaded_cpus into data section, which
seems to be unnecessary. Would ____cacheline_internodealigned_in_smp
be more lightweight?
> +       unsigned long   overloaded_cpus[]; /* Must be last */
>  };
>
[cut]
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..79b4ff24faee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6323,7 +6323,9 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> -       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +       struct sched_domain_shared *sds = sd->shared;
> +       int nr, nro, weight = sd->span_weight;
> +       int i, cpu, idle_cpu = -1;
>         struct rq *this_rq = this_rq();
>         int this = smp_processor_id();
>         struct sched_domain *this_sd;
> @@ -6333,7 +6335,23 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>         if (!this_sd)
>                 return -1;
>
> +       nro = atomic_read(&sds->nr_overloaded_cpus);
> +       if (nro == weight)
> +               goto out;
> +
> +       nr = min_t(int, weight, p->nr_cpus_allowed);
> +
> +       /*
> +        * It's unlikely to find an idle cpu if the system is under
> +        * heavy pressure, so skip searching to save a few cycles
> +        * and relieve cache traffic.
> +        */
> +       if (weight - nro < (nr >> 4) && !has_idle_core)
> +               return -1;
In [1] we used util_avg to check if the domain is overloaded and quit
earlier, since util_avg would be
more stable and contains historic data. But I think nr_running in your
patch could be used as
complementary metric and added to update_idle_cpu_scan() in [1] IMO.
> +
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +       if (nro > 1)
> +               cpumask_andnot(cpus, cpus, sdo_mask(sds));
If I understand correctly, this is the core of the optimization: SIS
filters out the busy cores. I wonder if it
is possible to save historic h_nr_running/idle_h_nr_running and use
the average value? (like the calculation
of avg_scan_cost).

>
>         if (sched_feat(SIS_PROP) && !has_idle_core) {
>                 u64 avg_cost, avg_idle, span_avg;
> @@ -6354,7 +6372,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>                 avg_idle = this_rq->wake_avg_idle;
>                 avg_cost = this_sd->avg_scan_cost + 1;
>
> -               span_avg = sd->span_weight * avg_idle;
> +               span_avg = weight * avg_idle;
>                 if (span_avg > 4*avg_cost)
>                         nr = div_u64(span_avg, avg_cost);
>                 else
[cut]
[1]  https://lore.kernel.org/lkml/20220428182442.659294-1-yu.c.chen@intel.com/

-- 
Thanks,
Chenyu
