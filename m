Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1FF59EC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiHWTXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiHWTXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:23:10 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00735135AF0;
        Tue, 23 Aug 2022 11:05:01 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-32a09b909f6so400929707b3.0;
        Tue, 23 Aug 2022 11:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7wKGoZnic5LNVksHZqOyLyRJxA/khS3FDx7SnbOPfSk=;
        b=24SAA5iB0GtU3ppNSW6ocMoHnb5q2gRsIoE/SoDUQqdtPcXth8wwclokUmCBagwNDk
         ogtuTpTvdq1PYQEgr08EJmBRg4PqkaYf1+VaMwfNE9JGZJkrDRkM0v146PjgzbHyvbGV
         ZBBr8rbt+CDHAR+JZOhc3ZlS4z3B38kwRBZ+Qlo93le4POTP2Xvn3wOOyXT83W+iu/NI
         IkMT9tkICRzPQ/Msbq85I0x2N4A8j/ubIqfbp3xGbc63FiJ/IVmNPeoz206siB1GU65h
         G8rh5S51z4h2ppDdJa9IEURhYoixhpd11T9cTS4efVqgMjkMGtlC4FoJvAOgbfNoULDy
         bc/w==
X-Gm-Message-State: ACgBeo1jy9On7ZBFeAmWk3SDH8CUkeFJSX6A/INJvGYI+ttiuzVsTnpN
        tXXeESsCQ1cquWrFaYa503ldg6ai0V+paxM6B8Q=
X-Google-Smtp-Source: AA6agR5bJErDIx47Az9fb4XE1uDN119UnaityOWnQElZjnOMZ0i23r0BIxfoRglwuZWVZypvWOlUby9Uw+M+A+DEZA4=
X-Received: by 2002:a25:c204:0:b0:692:72b9:a778 with SMTP id
 s4-20020a25c204000000b0069272b9a778mr25476145ybf.81.1661277900880; Tue, 23
 Aug 2022 11:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220816130629.3178-1-lukasz.luba@arm.com>
In-Reply-To: <20220816130629.3178-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 20:04:49 +0200
Message-ID: <CAJZ5v0jR2RozeV301u4g90-BpNqkQMRrN=dgaOkJ7veVZ02=aw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: schedutil: Move max CPU capacity to sugov_policy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 3:06 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> There is no need to keep the max CPU capacity in the per_cpu instance.
> Furthermore, there is no need to check and update that variable
> (sg_cpu->max) every time in the frequency change request, which is part
> of hot path. Instead use struct sugov_policy to store that information.
> Initialize the max CPU capacity during the setup and start callback.
> We can do that since all CPUs in the same frequency domain have the same
> max capacity (capacity setup and thermal pressure are based on that).
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Changes v2:
> - collected ACK from Viresh
> - re-based on top of latest mainline where the previously conflicting
>   change is now merged
>
>  kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 1207c78f85c1..9161d1136d01 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -25,6 +25,9 @@ struct sugov_policy {
>         unsigned int            next_freq;
>         unsigned int            cached_raw_freq;
>
> +       /* max CPU capacity, which is equal for all CPUs in freq. domain */
> +       unsigned long           max;
> +
>         /* The next fields are only needed if fast switch cannot be used: */
>         struct                  irq_work irq_work;
>         struct                  kthread_work work;
> @@ -48,7 +51,6 @@ struct sugov_cpu {
>
>         unsigned long           util;
>         unsigned long           bw_dl;
> -       unsigned long           max;
>
>         /* The field below is for single-CPU policies only: */
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -158,7 +160,6 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>         struct rq *rq = cpu_rq(sg_cpu->cpu);
>
> -       sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
>         sg_cpu->bw_dl = cpu_bw_dl(rq);
>         sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
>                                           FREQUENCY_UTIL, NULL);
> @@ -253,6 +254,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>   */
>  static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
>  {
> +       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         unsigned long boost;
>
>         /* No boost currently required */
> @@ -280,7 +282,8 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
>          * sg_cpu->util is already in capacity scale; convert iowait_boost
>          * into the same scale so we can compare.
>          */
> -       boost = (sg_cpu->iowait_boost * sg_cpu->max) >> SCHED_CAPACITY_SHIFT;
> +       boost = sg_cpu->iowait_boost * sg_policy->max;
> +       boost >>= SCHED_CAPACITY_SHIFT;
>         boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
>         if (sg_cpu->util < boost)
>                 sg_cpu->util = boost;
> @@ -337,7 +340,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>         if (!sugov_update_single_common(sg_cpu, time, flags))
>                 return;
>
> -       next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
> +       next_f = get_next_freq(sg_policy, sg_cpu->util, sg_policy->max);
>         /*
>          * Do not reduce the frequency if the CPU has not been idle
>          * recently, as the reduction is likely to be premature then.
> @@ -373,6 +376,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>                                      unsigned int flags)
>  {
>         struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> +       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         unsigned long prev_util = sg_cpu->util;
>
>         /*
> @@ -399,7 +403,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>                 sg_cpu->util = prev_util;
>
>         cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
> -                                  map_util_perf(sg_cpu->util), sg_cpu->max);
> +                                  map_util_perf(sg_cpu->util),
> +                                  sg_policy->max);
>
>         sg_cpu->sg_policy->last_freq_update_time = time;
>  }
> @@ -408,25 +413,19 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  {
>         struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         struct cpufreq_policy *policy = sg_policy->policy;
> -       unsigned long util = 0, max = 1;
> +       unsigned long util = 0;
>         unsigned int j;
>
>         for_each_cpu(j, policy->cpus) {
>                 struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> -               unsigned long j_util, j_max;
>
>                 sugov_get_util(j_sg_cpu);
>                 sugov_iowait_apply(j_sg_cpu, time);
> -               j_util = j_sg_cpu->util;
> -               j_max = j_sg_cpu->max;
>
> -               if (j_util * max > j_max * util) {
> -                       util = j_util;
> -                       max = j_max;
> -               }
> +               util = max(j_sg_cpu->util, util);
>         }
>
> -       return get_next_freq(sg_policy, util, max);
> +       return get_next_freq(sg_policy, util, sg_policy->max);
>  }
>
>  static void
> @@ -752,7 +751,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>  {
>         struct sugov_policy *sg_policy = policy->governor_data;
>         void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
> -       unsigned int cpu;
> +       unsigned int cpu = cpumask_first(policy->cpus);
>
>         sg_policy->freq_update_delay_ns = sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
>         sg_policy->last_freq_update_time        = 0;
> @@ -760,6 +759,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>         sg_policy->work_in_progress             = false;
>         sg_policy->limits_changed               = false;
>         sg_policy->cached_raw_freq              = 0;
> +       sg_policy->max                          = arch_scale_cpu_capacity(cpu);
>
>         sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
>
> --

Applied as 6.1 material, thanks!
