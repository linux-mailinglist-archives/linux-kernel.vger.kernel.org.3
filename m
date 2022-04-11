Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6B4FB5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbiDKIXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiDKIXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:23:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 462033E0DD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:21:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDDEAED1;
        Mon, 11 Apr 2022 01:21:39 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 586A33F73B;
        Mon, 11 Apr 2022 01:21:38 -0700 (PDT)
Message-ID: <02350916-aa36-ea53-2c98-91b97f49d27e@arm.com>
Date:   Mon, 11 Apr 2022 10:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Xuewen Yan <xuewen.yan@unisoc.com>, lukasz.luba@arm.com
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com, xuewen.yan94@gmail.com
References: <20220407051932.4071-1-xuewen.yan@unisoc.com>
Content-Language: en-US
In-Reply-To: <20220407051932.4071-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 07:19, Xuewen Yan wrote:
> There are cases when the cpu max capacity might be reduced due to thermal.
> Take into the thermal pressure into account when judge whether the rt task
> fits the cpu. And when schedutil govnor get cpu util, the thermal pressure
> also should be considered.
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

max' = arch_scale_cpu_capacity() - arch_scale_thermal_pressure()

For the energy part (A) we use max' in compute_energy() to cap sum_util
and max_util at max' and to call em_cpu_energy(..., max_util, sum_util,
max'). This was done to match (B)'s `policy->max` capping.

For the frequency part (B) we have freq_qos_update_request() in:

power_actor_set_power()
  ...
  cdev->ops->set_cur_state()

    cpufreq_set_cur_state()
      freq_qos_update_request()      <-- !
      arch_update_thermal_pressure()

restricting `policy->max` which then clamps `target_freq` in:

  cpufreq_update_util()
    ...
    get_next_freq()
      cpufreq_driver_resolve_freq()
        __resolve_freq()

[...]

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a32c46889af8..d9982ebd4821 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -466,6 +466,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
>  	max_cap = uclamp_eff_value(p, UCLAMP_MAX);
>  
>  	cpu_cap = capacity_orig_of(cpu);
> +	cpu_cap -= arch_scale_thermal_pressure(cpu);
>  
>  	return cpu_cap >= min(min_cap, max_cap);
>  }

IMHO, this should follow what we do with rq->cpu_capacity
(capacity_of(), the remaining capacity for CFS). E.g. we use
capacity_of() in find_energy_efficient_cpu() and select_idle_capacity()
to compare capacities. So we would need a function like
scale_rt_capacity() for RT (minus the rq->avg_rt.util_avg) but then also
one for DL (minus rq->avg_dl.util_avg and rq->avg_rt.util_avg).
