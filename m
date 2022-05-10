Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0ED52230B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348376AbiEJRsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344641AbiEJRsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:48:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69A742C181D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:44:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30D6D12FC;
        Tue, 10 May 2022 10:44:47 -0700 (PDT)
Received: from [10.57.4.48] (unknown [10.57.4.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F45B3F73D;
        Tue, 10 May 2022 10:44:44 -0700 (PDT)
Message-ID: <37357c86-bab7-d0c7-88d0-ace63ccdb6c8@arm.com>
Date:   Tue, 10 May 2022 18:44:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Content-Language: en-US
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com, Xuewen Yan <xuewen.yan94@gmail.com>
References: <20220421161509.asz25zmh25eurgrk@airbuntu>
 <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
 <20220425161209.ydugtrs3b7gyy3kk@airbuntu>
 <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
 <20220426092142.lppfj5eqgt3d24nb@airbuntu>
 <CAB8ipk_tM8WhZOLwURkqyi5XDSNJ=twOg1Zub=dsTB_b9N9BRg@mail.gmail.com>
 <20220427105844.otru4yohja4s23ye@wubuntu>
 <CAB8ipk-QAE2_J_kpUVRcq-4KJ0cSGc1JT2oQhdzvrjDu25HsRQ@mail.gmail.com>
 <20220503144352.lxduzhl6jq6xdhw2@airbuntu>
 <CAB8ipk--Y8HxetcmUhBmtWq6Mmd726QmDbcbibGLERJw_PUqkQ@mail.gmail.com>
 <20220510145625.t5py7atlhgojsfyf@wubuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220510145625.t5py7atlhgojsfyf@wubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/22 15:56, Qais Yousef wrote:
> Hi Xuewen
> 
> On 05/09/22 10:29, Xuewen Yan wrote:
> 
> [...]
> 
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index a68482d66535..44c7c2598d87 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -8399,16 +8399,37 @@ static unsigned long scale_rt_capacity(int cpu)
>>>
>>>   static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>>>   {
>>> +       unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
>>>          unsigned long capacity = scale_rt_capacity(cpu);
>>>          struct sched_group *sdg = sd->groups;
>>> +       struct rq *rq = cpu_rq(cpu);
>>>
>>> -       cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
>>> +       rq->cpu_capacity_orig = capacity_orig;
>>>
>>>          if (!capacity)
>>>                  capacity = 1;
>>>
>>> -       cpu_rq(cpu)->cpu_capacity = capacity;
>>> -       trace_sched_cpu_capacity_tp(cpu_rq(cpu));
>>> +       rq->cpu_capacity = capacity;
>>> +       trace_sched_cpu_capacity_tp(rq);
>>> +
>>> +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
>>> +               unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
>>
>> Indeed, I prefer arch_thermal_pressure here, because the
>> thermal_load_avg would change over time,
>> but the inv_cap's update period may could not keep up with his changes.
> 
> If that's what works for you, I think that's fine. Vincent, Lukasz you okay
> with that?

To properly answer this question we probably have to analyze the timings
and this update path - how often it is actually called. Keep in mind
we are going to solve CPU capacity inversion for RT class, which
contains latency sensitive tasks. In this approach the information
about HW status is coming from this CFS load balance path.
What if that load balance is not called that often as RT might require?
What if there is a light load on CPUs, but GPU caused them to throttle,
reducing capacity by a decent chunk e.g. 50%?
That would translate to some RT periodic task which takes 2ms every
8ms to take 4ms, while maybe on other less power hungry CPU it could
take 3ms.

The usage of thermal_load_avg() in the scale_rt_capacity() looks OK
for the CFS, but might not be from the RT class point of view.
The RT class might want to realize faster that CPUs have changed the
capacity.
Maybe it's OK with that patch [1] and boot config shifter=-5, but in
default boot config for shifter=0 we can suffer for hundreds of ms
running on lower capacity cpu (which is quite high number of frames
nowadays).

Without a research and experiments data I'm afraid this is too
big step to make, with this CFS load balance path.

> 
>>
>>> +
>>> +               rq->cpu_capacity_inverted = 0;
>>> +
>>> +               for_each_possible_cpu(cpu) {
>>> +                       unsigned long cap = arch_scale_cpu_capacity(cpu);
>>> +
>>> +                       if (capacity_orig <= cap)
>>> +                               continue;

The search loop here assumes that other CPUs (fortunately not in the
same freq domain) don't suffer due to reduced capacity. This might be
not true - when we have ~1 Watt budget for all CPUs in the system and
single big core can use 3-4W at max or single mid core ~1.2W.

>>> +
>>> +                       if (cap > inv_cap) {
>>> +                               rq->cpu_capacity_inverted = inv_cap;
>>> +                               break;
>>> +                       }
>>> +               }
>>> +
>>> +       }
>>>
>>>          sdg->sgc->capacity = capacity;
>>>          sdg->sgc->min_capacity = capacity;
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index 8dccb34eb190..bfe84c870bf9 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -992,6 +992,7 @@ struct rq {
>>>
>>>          unsigned long           cpu_capacity;
>>>          unsigned long           cpu_capacity_orig;
>>> +       unsigned long           cpu_capacity_inverted;
>>>
>>>          struct callback_head    *balance_callback;
>>>
>>> @@ -2807,6 +2808,11 @@ static inline unsigned long capacity_orig_of(int cpu)
>>>          return cpu_rq(cpu)->cpu_capacity_orig;
>>>   }
>>>
>>> +static inline unsigned long cpu_in_capacity_inversion(int cpu)
>>> +{
>>> +       return cpu_rq(cpu)->cpu_capacity_inverted;
>>> +}
>>> +
>>>   /**
>>>    * enum cpu_util_type - CPU utilization type
>>>    * @FREQUENCY_UTIL:    Utilization used to select frequency
>>>
>>>
>>> --->8---
>>
>> The patch is amazing for me, and the complexity is not too high. Would
>> you please push the patch?
>> I think the idea is yours, I don't want to use it as my patch v2.
> 
> I'd be happy to add a commit message so that you can include it in your v2.
> 
> First, I'd like to hear from Vincent and Lukasz they're happy with this
> approach.
> 
> I've been trying to think how we can do this generically but can't find an
> alternative to the extra loop or additional fallback_cpu_mask. Maybe the mask
> is okay if we protect it with sched_asymmetric_cpucapacity static key..
> 

I'm sorry Qais, I see that you are trying to bring this
real-CPU-capacity information into RT, but the source and quality of
this information IMO might matter. I cannot help you w/o experiment
results of your proposed approach.

Regards,
Lukasz

[1] https://lore.kernel.org/lkml/20220429091245.12423-1-lukasz.luba@arm.com/
