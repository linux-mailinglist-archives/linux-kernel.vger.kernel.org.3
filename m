Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B9C514565
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356564AbiD2Jaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiD2Jah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:30:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 863BEC401C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:27:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CD571063;
        Fri, 29 Apr 2022 02:27:19 -0700 (PDT)
Received: from [10.57.14.15] (unknown [10.57.14.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11EAA3F73B;
        Fri, 29 Apr 2022 02:27:16 -0700 (PDT)
Message-ID: <0a8051ec-3ed1-f7a3-3c17-14a1d8320470@arm.com>
Date:   Fri, 29 Apr 2022 10:27:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com, Xuewen Yan <xuewen.yan94@gmail.com>
References: <20220407051932.4071-1-xuewen.yan@unisoc.com>
 <02350916-aa36-ea53-2c98-91b97f49d27e@arm.com>
 <CAB8ipk-KenZaVWQwWqVMksQXLP5r19BQ1OGAdmwHRbjwv3qFHg@mail.gmail.com>
 <9bb00bcb-f984-1cf6-39aa-c11dcf7f07cb@arm.com>
 <f100bd49-7a1d-5265-29ce-1092195bb2dd@arm.com>
 <CAB8ipk8v1-jyU0Q0k-EXCArsS6Sh=U+fW6NutW+6m+kQ=LKrJA@mail.gmail.com>
 <CAKfTPtDsNSW0JH4phAtZB7ackJFKuJfAGkhQ7JjWG_C2tzQYSw@mail.gmail.com>
 <24631a27-42d9-229f-d9b0-040ac993b749@arm.com>
 <CAKfTPtAnHmm0T+FKF251YcjM3Nw66Wqs2a16yU9Ptiip+jyNLA@mail.gmail.com>
 <e536ef07-4dd3-affd-0e27-6ff89a7f647f@arm.com>
 <CAKfTPtBfjnWoiTbhRBj4Ve65ukRdm90ri84dNivKuLDBMWhUAQ@mail.gmail.com>
 <ae98a861-8945-e630-8d4c-8112723d1007@arm.com>
 <CAKfTPtCu4zYchv1d4g-ztw=qR639BS2ncapQxfcwZqkSSQPY0w@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtCu4zYchv1d4g-ztw=qR639BS2ncapQxfcwZqkSSQPY0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/22 08:39, Vincent Guittot wrote:
> On Thu, 21 Apr 2022 at 12:57, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 4/21/22 09:29, Vincent Guittot wrote:
>>> On Tue, 19 Apr 2022 at 16:13, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/19/22 13:51, Vincent Guittot wrote:
>>>>> On Tue, 19 Apr 2022 at 14:01, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 4/19/22 08:14, Vincent Guittot wrote:
>>>>>>> On Sat, 16 Apr 2022 at 04:47, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Hi Luba  / Dietmar
>>>>>>>>
>>>>>>>> On Wed, Apr 13, 2022 at 9:26 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
> 
> [...]
> 
>>>>>> To be precised and maybe fix some potential design issues. We are
>>>>>> talking here about utilization and set max capacity in function:
>>>>>> sugov_get_util()
>>>>>> so fields:
>>>>>>
>>>>>> sugov_cpu::util
>>>>>> sugov_cpu::max /* max capacity */
>>>>>
>>>>> Yes. With this patch ,util will be lower than current thermal
>>>>> mitigation whereas util normally reflects what we need  not what can
>>>>> be provided
>>>>
>>>> This is a different requirements: util has to be max capacity and
>>>> max capacity has to be original max CPU capacity - for the SchedUtil.
>>>> OK, why? What this requirement adds in the design and final values?
>>>
>>> Because the calculation you are proposing is wrong and doesn't make
>>> sense. Util is the average utilization of the cpu that has to be
>>> compared with its original capacity max in order to get the freq that
>>> matches with this utilization.
>>>
>>> We have freq = util / max * max_freq and cpufreq will then capp freq
>>> if mitigation is applied. Once the mitigation disappear, the request
>>> will be back to targeted freq.
>>>
>>> If you replace max by max' = max - arch_scale_thermal_pressure then :
>>>
>>> - by the time you do the calculation, arch_scale_thermal_pressure can
>>> have changed and the result is meaningless. This is true whatever the
>>> pace of updating arch_scale_thermal_pressure
>>
>> The sudden change of the value taken from arch_scale_thermal_pressure
>> I can understand, but there are similar and we live with it. Look at
>> the whole EAS estimations done in a one CPU waku-up event or the uclamp
>> stuff. As far this is not too frequently occurring - we live wit it.
>>
>> I can see your concern here, since you mentioned below that you expect
>> some platforms to hit it in 'khz' rate. This is probably not good, to
>> trigger the kernel so often from HW/FW.
>>
>> That's why I have been struggling to find a 'good' design on this
>> glue layer for Arm FW+kernel. Our FW would probably won't cause such
>> huge notification traffic. A rate e.g. 50-100ms would be enough,
>> especially if we have the per-CPU cpufreq policy. So we might have
>> this 'PELT-like filter or signal' in FW, and just update kernel
> 
> In this case arch_scale_thermal_pressure() doesn't reflect the actual
> thermal pressure but an average which is what thermal_load_avg() is
> also doing.

Exactly. I hope you understand that there is no point of bombarding the
kernel with 'khz' ratio interrupts with information which can be passed
gently.

But there is an issue with this. We would have to go again via
thermal PELT-like characteristics, as you said for the raw
arch_scale_thermal_pressure() 'must not' be used.

> 
>> less often. But then there is an issue with the rising/decaying
>> penalty of the kernel thermal pressure signal.
>>
>> We cannot assume that some SoCs don't do this already.
>>
>> Let's meet in the middle:
>> 1) use the thermal PELT signal in RT:
>> capacity = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu))
> 
> This is what Dietmar and I have been suggested

There is a difference: Dietmar was asking which signal should
be used, while you made a statement 'must not' be used.

That's why I proposed to meet in the middle - which is not perfect
solution, because:
1) by default this 'sched_thermal_decay_shift' boot parameter would be
    set to 0, so engineers might not be aware of this and it's impact;
    they would have to be pointed to it when the play with RT tasks
2) it would not only affect RT 'view' to the current situation of real
    CPU capacity but also CFS 'view' on it. But they might be interested
    in different 'view':
    a) RT - more instantaneous, since it's more latency focused, while
    b) CFS - more smooth, since it tries to be more balanced

I've prepared two patches [1][2] and notebook [3] with experiments for
the new thermal pressure signal raising/decaying characteristics. That
might help them to understand.

> 
>> 2) introduce a more configurable thermal_pressure shifter instead
>> 'sched_thermal_decay_shift', which would allow not only to make the
>> decaying longer, but also shorter when the platform already might do
>> that, to not cause too much traffic.
>>
>>>
>>> - you change the range of capacity to max'= max -
>>> arch_scale_thermal_pressure and you scale it to max_freq. if util >
>>> max', then you will ask for max_freq whatever the util being really
>>> close to max or not. Also you will ask for max freq even if util is
>>> close but below max' whereas the mitigation doesn't impact utilization
>>
>> It's already there, even w/o patch. That's why I gave you the examples.
> 
> Not sure how to understand this above.
> 
> utilization can already goes above but this reflects a reality that
> the task could need more capacity than the current cpu capacity

We have issues with this for the CPU rq utilization. IMO it deserves
be re-visited and somehow fixed, especially when we have the uclamp
tasks. It's a topic for different discussion. The signal which
we are using in the SchedUtil is 'not ideal'. I don't have time
to make those plots from experiments. We can return to this topic
later.

> 
>>
>> BTW, isn't true that the utilization of the Little CPU rq can reach
>> 1024 today after your change to the PELT when there is no idle time,
>> even when cpu max capacity is e.g. 300?
> 
> yes
> 
>> Before that change the utilization of a throttled CPU rq would converge
>> to the current capacity of the CPU, am I right?
> 
> yes
> 
>>
>> Is it this commit:
>> 23127296889fe84b0762b191
>>
>>>
>>>>
>>>>>
>>>>>>
> 
> [...]
> 
>>>>>
>>>>>> but then in both cases are multiplied by 'max_freq' in (2)
>>>>>>
>>>>>> As you can see this is not the situation that you have described, is it?
>>>>>> And the transient or non-transient is minor here IMO.
>>>>>
>>>>> If max is 512 then util = 640 which is much lower than 1024.
>>>>
>>>> What scenario is this?
>>>> Is 1024 the utilization that we might have from the CPU rq?
>>>> What is the original CPU capacity, 1024?
>>
>> Is this 1024 the utilization of the CPU runqueue because since
>> the new PELT we can have it bigger than CPU capacity?
>>
>>>>
>>>>>
>>>>>>
>>>>>> Secondly, you have mentioned the mitigation in HW and issue between
>>>>>> instantaneous vs. PELT-one thermal pressure information. This is
>>>>>> something that I'm stretching my head for long. I'm trying to
>>>>>> develop this for new Arm FW thermal. You have mentioned:
>>>>>> 'thermal mitigation is managed by HW at a much higher
>>>>>> frequency than what Linux can handle' - I would be also more
>>>>>> precised here: HW or FW? How often the HW can change max freq or
>>>>>> how often FW can change that? If we don't have those numbers
>>>>>> than statement: 'a much higher' doesn't help in solving this
>>>>>
>>>>> By much higher means that Linux can't react fast enough and should not
>>>>> try to sync because it's a lost game
>>>>
>>>> As I said, 'much higher' is not a number to base a design on it.
>>>
>>> But that gives you the constraint that you can't expect to be always
>>> synced with up to date value which is the most important here. This
>>> means that  cpu_cap -= arch_scale_thermal_pressure(cpu) can be wrong
>>> just after you computed it and your decision is wrong.
>>
>> This is hypothetical situation when the value can change in such
>> noisy way on some platform. But I understand your concern.
>>
>>>
>>>
>>>> We need real numbers from real platforms. Currently we have two
>>>> places where the thermal pressure is set:
>>>> 1) cpufreq_cooling.c [1]
>>>> 2) Qcom driver [2]
>>>> (we might have 3rd soon for Arm SCMI+FW)
>>>
>>> I don't have details but i have khz in mind
>>
>> If such traffic of interrupts in khz is true for driver in 2)
>> then it's a bit concerning.
>>
>> Although, smarter platforms shouldn't suffer due to design forced to one
>> corner case platform.
>>
>>>
>>>>
>>>> For the 2nd I would like to see numbers. For the 1st one when
>>>> kernel thermal is used (which supports higher number of platforms
>>>> comparing to Qcom driver) as it's by design kernel tries to control
>>>> thermal, so changes are not that frequent.
>>>>
>>>> As for now, I can see in experiments the 1st is suffering long decay
>>>> delays and also corner cases with long idle CPUs.
>>>>
>>>>>
> 
> [...]
> 
>>>> I'm trying to help Xuewen to solve his/her issues with the RT class
>>>> incrementally. I don't want to push him/her into a deep dark water
>>>> of PELT signals, to what variable compare them, corner cases when they
>>>> are (or not) updated or completely not implemented. I'm not even sure
>>>> if those extra complexities make sense for the RT/DL (since they
>>>> make some difference on big.mid.little specific platforms but not for
>>>> the rest).
>>
>> As I said we need a way forward, this issue of capacity inversion
>> on big.mid.little is there. It was for ~2-3years and is going to be
>> even bigger in future. So please don't block it and prepare/share the
>> numbers for the corner case platforms.
> 
> I don't want to block anything but just want a solution that is
> coherent with the whole design and not just a fix for one UC

Good, but forcing to use PELT-like signal for all platforms for
RT tasks might not be a fix either.

It wasn't in this RT code at mainline to take the thermal pressure into
account, but you made a strong statement that one of two signals
'must' not be used (without any data from RT experiments for a few
platforms). You also added argument that there might be 'khz' high
rate of frequency changes on some platform (which might be actually
a corner case or even not possible because fastest DVFS that is
possible today IIRC is ~500-1000us).

In my team we spend hundreds/year (or even thousands) of hours on
research (with experiments and code modifications) in those fields:
scheduler, thermal, firmware. Even when we have the data internally,
we don't say we are 100% sure in all cases for all platforms.

We are trying to engage our partners, with this whole GKI movement, to
go with their patches upstream and have a discussion there. No wonder
they are afraid. I hope you understand this.

Regards,
Lukasz

[1] https://lore.kernel.org/lkml/20220427080806.1906-1-lukasz.luba@arm.com/
[2] 
https://lore.kernel.org/lkml/20220429091245.12423-1-lukasz.luba@arm.com/T/#u
[3] 
https://nbviewer.org/github/lukaszluba-arm/lisa/blob/public_tests/thermal_pressure_delays-all-ipa.ipynb
