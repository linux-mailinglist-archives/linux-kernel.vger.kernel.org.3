Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E756B5089D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379211AbiDTNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiDTNyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:54:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4176A39141
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:51:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19B123A;
        Wed, 20 Apr 2022 06:51:37 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6687A3F5A1;
        Wed, 20 Apr 2022 06:51:36 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:51:27 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     dietmar.eggemann@arm.com, lukasz.luba@arm.com, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, di.shen@unisoc.com,
        xuewen.yan94@gmail.com
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Message-ID: <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
References: <20220407051932.4071-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220407051932.4071-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewen

Thanks for sending the patch. RT relationship with thermal pressure is an
interesting topic :)

On 04/07/22 13:19, Xuewen Yan wrote:
> There are cases when the cpu max capacity might be reduced due to thermal.
> Take into the thermal pressure into account when judge whether the rt task
> fits the cpu. And when schedutil govnor get cpu util, the thermal pressure
> also should be considered.

It would help to explain the mode of failure you're seeing here. What are you
seeing?

> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 1 +
>  kernel/sched/rt.c                | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 3dbf351d12d5..285ad51caf0f 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
>  	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
>  
> +	max -= arch_scale_thermal_pressure(sg_cpu->cpu);

Wouldn't this break the call to irq_scale_capacity() in effective_cpu_util()?

>  	sg_cpu->max = max;
>  	sg_cpu->bw_dl = cpu_bw_dl(rq);
>  	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu), max,
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a32c46889af8..d9982ebd4821 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -466,6 +466,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
>  	max_cap = uclamp_eff_value(p, UCLAMP_MAX);
>  
>  	cpu_cap = capacity_orig_of(cpu);
> +	cpu_cap -= arch_scale_thermal_pressure(cpu);

Hmm I'm not a fan of this. By default all RT tasks have uclamp_min = 1024 to
keep the default behavior of the system running at max performance point.

With this change, any tiny thermal pressure means all RT tasks will fail to fit
on the biggest CPU. While this hint is not meant to be bullet proof, but it
shouldn't break that easily either. The highest performance point will still be
on this CPU. The only exception is capacity inversion where the bigs
performance goes below the mediums' under severe thermal circumstances. But
then there are 2 issues.

	1. This patch doesn't help with this case. It simply reverts to putting
	   tasks 'randomly' and  might still end up on this CPU. I can't see
	   how this is better.
	2. If we are under such severe thermal pressure, then things must be
	   falling over badly anyway and I'm not sure we can still satisfy the
	   perf requirements these tasks want anyway. Unless you're trying to
	   keep these CPUs less busy to alleviate thermal pressure? This patch
	   will not help achieving that either. Or I'm unable to see it if it
	   does.

It'd be good to explain the problem you're seeing and how this patch helped
you.

The only thing I can think of is that you have uclamp_min set to the medium
CPUs capacity but due to thermal pressure they might fail to run at highest
frequency hence by forcing them NOT to fit on mediums you essentially make them
run on the bigs where they get a better chance of getting the perf they want.


Thanks

--
Qais Yousef


>  
>  	return cpu_cap >= min(min_cap, max_cap);
>  }
> -- 
> 2.25.1
> 
