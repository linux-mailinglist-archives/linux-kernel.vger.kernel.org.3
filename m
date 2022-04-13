Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69F34FF793
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiDMN2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiDMN2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:28:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D82D4EF6E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:26:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52FBB1595;
        Wed, 13 Apr 2022 06:26:00 -0700 (PDT)
Received: from [10.57.8.248] (unknown [10.57.8.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 744CA3F73B;
        Wed, 13 Apr 2022 06:25:58 -0700 (PDT)
Message-ID: <f100bd49-7a1d-5265-29ce-1092195bb2dd@arm.com>
Date:   Wed, 13 Apr 2022 14:25:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, di.shen@unisoc.com
References: <20220407051932.4071-1-xuewen.yan@unisoc.com>
 <02350916-aa36-ea53-2c98-91b97f49d27e@arm.com>
 <CAB8ipk-KenZaVWQwWqVMksQXLP5r19BQ1OGAdmwHRbjwv3qFHg@mail.gmail.com>
 <9bb00bcb-f984-1cf6-39aa-c11dcf7f07cb@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <9bb00bcb-f984-1cf6-39aa-c11dcf7f07cb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/22 15:07, Dietmar Eggemann wrote:
> On 11/04/2022 10:52, Xuewen Yan wrote:
>> HI Dietmar
>>
>> On Mon, Apr 11, 2022 at 4:21 PM Dietmar Eggemann
>> <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 07/04/2022 07:19, Xuewen Yan wrote:
>>>> There are cases when the cpu max capacity might be reduced due to thermal.
>>>> Take into the thermal pressure into account when judge whether the rt task
>>>> fits the cpu. And when schedutil govnor get cpu util, the thermal pressure
>>>> also should be considered.
>>>>
>>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>>>> ---
>>>>   kernel/sched/cpufreq_schedutil.c | 1 +
>>>>   kernel/sched/rt.c                | 1 +
>>>>   2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>>> index 3dbf351d12d5..285ad51caf0f 100644
>>>> --- a/kernel/sched/cpufreq_schedutil.c
>>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>>> @@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>>>>        struct rq *rq = cpu_rq(sg_cpu->cpu);
>>>>        unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
>>>>
>>>> +     max -= arch_scale_thermal_pressure(sg_cpu->cpu);
>>>
>>> max' = arch_scale_cpu_capacity() - arch_scale_thermal_pressure()
>>>
>>> For the energy part (A) we use max' in compute_energy() to cap sum_util
>>> and max_util at max' and to call em_cpu_energy(..., max_util, sum_util,
>>> max'). This was done to match (B)'s `policy->max` capping.
>>>
>>> For the frequency part (B) we have freq_qos_update_request() in:
>>>
>>> power_actor_set_power()
>>>    ...
>>>    cdev->ops->set_cur_state()
>>>
>>>      cpufreq_set_cur_state()
>>>        freq_qos_update_request()      <-- !
>>>        arch_update_thermal_pressure()
>>>
>>> restricting `policy->max` which then clamps `target_freq` in:
>>>
>>>    cpufreq_update_util()
>>>      ...
>>>      get_next_freq()
>>>        cpufreq_driver_resolve_freq()
>>>          __resolve_freq()
>>>
>>
>> Do you mean that the "max" here will not affect the frequency
>> conversion, so there is no need to change it?
>> But is it better to reflect the influence of thermal here?
> 
> I guess your point is that even though max' has no effect on frequency
> since QOS caps policy->max anyway, it is still easier to understand the
> dependency between schedutil and EAS/EM when it comes to the use of
> thermal pressure.
> 
> I agree. The way how the "hidden" policy->max capping guarantees that
> schedutil and EAS/EM are doing the same even when only the latter uses
> max' is not obvious.

+1 here, IMO we shouldn't rely on hidden stuff. There are two which set
the thermal pressure, but one is not setting the freq_qos which causes
the update of the 'policy->max'. So the schedutil will send that high
frequency but that driver would just ignore and clamp internally. In the
end we might argue it still works, but is it clean and visible from the
code? Funny thing might start to happen then the driver, which might be
the last safety net cannot capture this.

We also should be OK with energy estimation and the CPU capacity vs.
task utilization comparisons, since the thermal pressure is accounted
there* (until the thermal is controlled in kernel not in FW, which is
something where we are heading with scmi-cpufreq mentioned in this
cover letter [1]).

> 
> I just wanted to mention the historical reason why the code looks like
> it does today.
> 
>>> [...]
>>>
>>>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>>>> index a32c46889af8..d9982ebd4821 100644
>>>> --- a/kernel/sched/rt.c
>>>> +++ b/kernel/sched/rt.c
>>>> @@ -466,6 +466,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
>>>>        max_cap = uclamp_eff_value(p, UCLAMP_MAX);
>>>>
>>>>        cpu_cap = capacity_orig_of(cpu);
>>>> +     cpu_cap -= arch_scale_thermal_pressure(cpu);
>>>>
>>>>        return cpu_cap >= min(min_cap, max_cap);
>>>>   }
>>>
>>> IMHO, this should follow what we do with rq->cpu_capacity
>>> (capacity_of(), the remaining capacity for CFS). E.g. we use
>>> capacity_of() in find_energy_efficient_cpu() and select_idle_capacity()
>>> to compare capacities. So we would need a function like
>>> scale_rt_capacity() for RT (minus the rq->avg_rt.util_avg) but then also
>>> one for DL (minus rq->avg_dl.util_avg and rq->avg_rt.util_avg).
>>
>> It's a really good idea. And do you already have the corresponding patch?
>> If there is, can you tell me the corresponding link?
> 
> No, I don't have any code for this. Should be trivial though. But the
> issue is that the update would probably have to be decoupled from CFS
> load_balance (update_group_capacity()) and the use cases in RT/DL are
> only valid for asymmetric CPU capacity systems.

Having in mind those I would vote for fixing it incrementally.
Thus, IMHO this patch is good for taking it. Later we might think how
to better estimate the real CPU capacity visible from RT and DL classes.
In this shape it is good for many systems which only use RT,
but not DL class. Those systems w/ RT and w/o DL might suffer on some
asymmetric CPU platforms where medium cores have capacity e.g. 850 and
thermal pressure reduced the big cores capacity by 250 making them 774.

Regards,
Lukasz

[1] 
https://lore.kernel.org/linux-pm/20211007080729.8262-1-lukasz.luba@arm.com/
