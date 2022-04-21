Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFC509AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386669AbiDUIdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiDUIc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:32:28 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E528C13EB0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:29:37 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ef4a241cc5so44276117b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5DsAwiLdIzm2TrVJ0U2gFbJkr1AO6nQ1MwuMxT9Gufk=;
        b=JFP/eenSEeqTuECaWL0dZKMDNqCJw3jNgLUk2NBSzBqSGQgws1VPfDGnI67js8+Gj/
         ToGOVRF9nWzAnZxnpTKp+7LvDbO2AhHXyc+SHPgc9gmD3esmm7vaNSKlAFQPcIy7vbWb
         mDfPjZ/sEKcu3wlURN7VHnEBhGA4zm+KSNSBCwdCWtRxj3LfOsrJ2Gd0myLLy0VRBr9Q
         93DLv4mEwExjRdQNGLnKeQzcTxioJPmc9+0CCo6HpJpJguxkR2+pdpKuSxcnkBXvqBXo
         Jnq4kBL5FvgsuyGrxhRI3cQzRZ2Fp2/OpJfesGFXf5r6qKiIrGsoLbWCb+jdvu3Qm1vb
         e+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5DsAwiLdIzm2TrVJ0U2gFbJkr1AO6nQ1MwuMxT9Gufk=;
        b=kpfKWzeoD1urSa+ipCkGWzIs//sjCvNwWLyf8Sk7wp5vVUjBmQimHpeW7NpjclEh/1
         l+mDxBSMjoX9LIeyLsFUDnrmvuKMmpSeDNJ028y2HxrqGyeCcqsh3UjINGnATQdyI7++
         6Tgd0S/NWv/spZJNkOWiWns/3vAGIm12x8IwucfZsugwsuvoHJD+mSMgoX3K1a0JyE4I
         oZHepKySFaiwOLQakmKgVJ7yK2oLs/iBv9xBDz4ZNZaKvFCybiB8WC3g2u8r4xpO5HNd
         fPzGglmKl8DmiMHOc4f5t8z3yKfoDujWtg3gKKqJ3z+zVVAeGoJSwi0mFyg8RlpEgg8z
         /Hbw==
X-Gm-Message-State: AOAM530XXZInXp1npDm8iq9VlVfozWXGvRt64hA4tSL+2oS7/nQe3yrS
        cNWhaFpBIlwbsvdCL4dwQneO3NkCxGxHndeL6M2NVg==
X-Google-Smtp-Source: ABdhPJzoFHPTXfVPQ8gal6T0wp2v6pRDE4EUla+k200AjOTtBOu2t7377CqvR1YjbCj3YIrIB3Vqeot0wsKOQHHQ/OE=
X-Received: by 2002:a0d:fa01:0:b0:2d6:595d:81d4 with SMTP id
 k1-20020a0dfa01000000b002d6595d81d4mr24676462ywf.86.1650529776959; Thu, 21
 Apr 2022 01:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <02350916-aa36-ea53-2c98-91b97f49d27e@arm.com>
 <CAB8ipk-KenZaVWQwWqVMksQXLP5r19BQ1OGAdmwHRbjwv3qFHg@mail.gmail.com>
 <9bb00bcb-f984-1cf6-39aa-c11dcf7f07cb@arm.com> <f100bd49-7a1d-5265-29ce-1092195bb2dd@arm.com>
 <CAB8ipk8v1-jyU0Q0k-EXCArsS6Sh=U+fW6NutW+6m+kQ=LKrJA@mail.gmail.com>
 <CAKfTPtDsNSW0JH4phAtZB7ackJFKuJfAGkhQ7JjWG_C2tzQYSw@mail.gmail.com>
 <24631a27-42d9-229f-d9b0-040ac993b749@arm.com> <CAKfTPtAnHmm0T+FKF251YcjM3Nw66Wqs2a16yU9Ptiip+jyNLA@mail.gmail.com>
 <e536ef07-4dd3-affd-0e27-6ff89a7f647f@arm.com>
In-Reply-To: <e536ef07-4dd3-affd-0e27-6ff89a7f647f@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 21 Apr 2022 10:29:25 +0200
Message-ID: <CAKfTPtBfjnWoiTbhRBj4Ve65ukRdm90ri84dNivKuLDBMWhUAQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Lukasz Luba <Lukasz.Luba@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com, Xuewen Yan <xuewen.yan94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 at 16:13, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 4/19/22 13:51, Vincent Guittot wrote:
> > On Tue, 19 Apr 2022 at 14:01, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 4/19/22 08:14, Vincent Guittot wrote:
> >>> On Sat, 16 Apr 2022 at 04:47, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >>>>
> >>>> Hi Luba  / Dietmar
> >>>>
> >>>> On Wed, Apr 13, 2022 at 9:26 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 4/11/22 15:07, Dietmar Eggemann wrote:
> >>>>>> On 11/04/2022 10:52, Xuewen Yan wrote:
> >>>>>>> HI Dietmar
> >>>>>>>
> >>>>>>> On Mon, Apr 11, 2022 at 4:21 PM Dietmar Eggemann
> >>>>>>> <dietmar.eggemann@arm.com> wrote:
> >>>>>>>>
> >>>>>>>> On 07/04/2022 07:19, Xuewen Yan wrote:
> >>>>>>>>> There are cases when the cpu max capacity might be reduced due to thermal.
> >>>>>>>>> Take into the thermal pressure into account when judge whether the rt task
> >>>>>>>>> fits the cpu. And when schedutil govnor get cpu util, the thermal pressure
> >>>>>>>>> also should be considered.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> >>>>>>>>> ---
> >>>>>>>>>     kernel/sched/cpufreq_schedutil.c | 1 +
> >>>>>>>>>     kernel/sched/rt.c                | 1 +
> >>>>>>>>>     2 files changed, 2 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >>>>>>>>> index 3dbf351d12d5..285ad51caf0f 100644
> >>>>>>>>> --- a/kernel/sched/cpufreq_schedutil.c
> >>>>>>>>> +++ b/kernel/sched/cpufreq_schedutil.c
> >>>>>>>>> @@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >>>>>>>>>          struct rq *rq = cpu_rq(sg_cpu->cpu);
> >>>>>>>>>          unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> >>>>>>>>>
> >>>>>>>>> +     max -= arch_scale_thermal_pressure(sg_cpu->cpu);
> >>>>>>>>
> >>>>>>>> max' = arch_scale_cpu_capacity() - arch_scale_thermal_pressure()
> >>>>>>>>
> >>>>>>>> For the energy part (A) we use max' in compute_energy() to cap sum_util
> >>>>>>>> and max_util at max' and to call em_cpu_energy(..., max_util, sum_util,
> >>>>>>>> max'). This was done to match (B)'s `policy->max` capping.
> >>>>>>>>
> >>>>>>>> For the frequency part (B) we have freq_qos_update_request() in:
> >>>>>>>>
> >>>>>>>> power_actor_set_power()
> >>>>>>>>      ...
> >>>>>>>>      cdev->ops->set_cur_state()
> >>>>>>>>
> >>>>>>>>        cpufreq_set_cur_state()
> >>>>>>>>          freq_qos_update_request()      <-- !
> >>>>>>>>          arch_update_thermal_pressure()
> >>>>>>>>
> >>>>>>>> restricting `policy->max` which then clamps `target_freq` in:
> >>>>>>>>
> >>>>>>>>      cpufreq_update_util()
> >>>>>>>>        ...
> >>>>>>>>        get_next_freq()
> >>>>>>>>          cpufreq_driver_resolve_freq()
> >>>>>>>>            __resolve_freq()
> >>>>>>>>
> >>>>>>>
> >>>>>>> Do you mean that the "max" here will not affect the frequency
> >>>>>>> conversion, so there is no need to change it?
> >>>>>>> But is it better to reflect the influence of thermal here?
> >>>>>>
> >>>>>> I guess your point is that even though max' has no effect on frequency
> >>>>>> since QOS caps policy->max anyway, it is still easier to understand the
> >>>>>> dependency between schedutil and EAS/EM when it comes to the use of
> >>>>>> thermal pressure.
> >>>>>>
> >>>>>> I agree. The way how the "hidden" policy->max capping guarantees that
> >>>>>> schedutil and EAS/EM are doing the same even when only the latter uses
> >>>>>> max' is not obvious.
> >>>>>
> >>>>> +1 here, IMO we shouldn't rely on hidden stuff. There are two which set
> >>>>> the thermal pressure, but one is not setting the freq_qos which causes
> >>>>> the update of the 'policy->max'. So the schedutil will send that high
> >>>>> frequency but that driver would just ignore and clamp internally. In the
> >>>>> end we might argue it still works, but is it clean and visible from the
> >>>>> code? Funny thing might start to happen then the driver, which might be
> >>>>> the last safety net cannot capture this.
> >>>
> >>> schedutil reflects what scheduler wants not what HW can do. If you
> >>> start to cap the freq with arch_scale_thermal_pressure() in schedutil,
> >>
> >> s/freq/util ?
> >
> > Isn't it the same at the end if you cap util to orig capacity -
> > arch_scale_thermal_pressure ?
>
> No, as I have showed you in the example calculation the 'max_freq'
> is always taken as a start then scaled by current 'util/max'.
> If the 'max' was 1024 in both cases, then you might claim that
> we made a mistake and end up with obviously too low frequency.
>
> That's why I asked you to be precised with your statements in the
> description while mentioning variables and signals.
>
> >
> >>
> >> To be precised and maybe fix some potential design issues. We are
> >> talking here about utilization and set max capacity in function:
> >> sugov_get_util()
> >> so fields:
> >>
> >> sugov_cpu::util
> >> sugov_cpu::max /* max capacity */
> >
> > Yes. With this patch ,util will be lower than current thermal
> > mitigation whereas util normally reflects what we need  not what can
> > be provided
>
> This is a different requirements: util has to be max capacity and
> max capacity has to be original max CPU capacity - for the SchedUtil.
> OK, why? What this requirement adds in the design and final values?

Because the calculation you are proposing is wrong and doesn't make
sense. Util is the average utilization of the cpu that has to be
compared with its original capacity max in order to get the freq that
matches with this utilization.

We have freq = util / max * max_freq and cpufreq will then capp freq
if mitigation is applied. Once the mitigation disappear, the request
will be back to targeted freq.

If you replace max by max' = max - arch_scale_thermal_pressure then :

- by the time you do the calculation, arch_scale_thermal_pressure can
have changed and the result is meaningless. This is true whatever the
pace of updating arch_scale_thermal_pressure

- you change the range of capacity to max'= max -
arch_scale_thermal_pressure and you scale it to max_freq. if util >
max', then you will ask for max_freq whatever the util being really
close to max or not. Also you will ask for max freq even if util is
close but below max' whereas the mitigation doesn't impact utilization

>
> >
> >>
> >>> you will loose some opportunity to run at higher frequency because
> >>> arch_scale_thermal_pressure() is transient and might change just after
> >>> using it. This means that you will stay at lower freq after mitigation
> >>> stops until a new cpufreq_update_util() happens. ANd I don't vene
> >>> mentioned when thermal mitigation is managed by HW at a much higher
> >>> frequency than what Linux can handle
> >>>
> >>> arch_scale_thermal_pressure() must not be used but thermal_load_avg()
> >>> like scale_rt_capacity() what Dietmar suggested
> >>>
> >>
> >> First, I would like to see your view to this topic and why you are
> >> making such strong statements. I have slightly different view and
> >> made dozen of experiments with this thermal pressure in last ~2-3y.
> >>
> >> The code flow is like this and operates on those fields from above:
> >>
> >> util, max <--- sugov_get_util()
> >> util <--- sugov_iowait_apply()  <--- util, max /* ignore this now */
> >>
> >> get_next_freq():
> >> util <--- map_util_perf() <--- util (1)
> >> freq <--- map_util_freq() <--- util, max, max_freq (2)
> >>
> >>
> >> At (1) we add +25% util, at (2) we do the conversion to frequency:
> >> freq = max_freq * util / max
> >>
> >> As you can see with the patch we would still end up with bigger
> >> frequency than max_freq (since it can happen: max < util).
> >> It's also true currently in mainline, when
> >> max=1024 and util=1024+256=1280
> >> I would be similar if we cap max capacity:
> >> max=800 and util=800+200=1000
> >
> > It's not because you end up with a similar value that it's ok. You
> > can't use one side to compensate for the other one. 1.25 is there to
> > provide spare cycles to a change in the cpu load (load meaning what is
> > running on the cpu not load_avg)
>
> It's different. You've made a hard statement that we are going to break
> this frequency selected value, while IMO we aren't. It would behave
> the same. I don't compensate anything, the divider ('max') has changed
> as well. The patch sets 'sg_cpu->max' not just uses 'max' locally, so
> it produces lower 'util' but then might have 'max=1024'. It's not the
> case.
>
> >
> >> but then in both cases are multiplied by 'max_freq' in (2)
> >>
> >> As you can see this is not the situation that you have described, is it?
> >> And the transient or non-transient is minor here IMO.
> >
> > If max is 512 then util = 640 which is much lower than 1024.
>
> What scenario is this?
> Is 1024 the utilization that we might have from the CPU rq?
> What is the original CPU capacity, 1024?
>
> >
> >>
> >> Secondly, you have mentioned the mitigation in HW and issue between
> >> instantaneous vs. PELT-one thermal pressure information. This is
> >> something that I'm stretching my head for long. I'm trying to
> >> develop this for new Arm FW thermal. You have mentioned:
> >> 'thermal mitigation is managed by HW at a much higher
> >> frequency than what Linux can handle' - I would be also more
> >> precised here: HW or FW? How often the HW can change max freq or
> >> how often FW can change that? If we don't have those numbers
> >> than statement: 'a much higher' doesn't help in solving this
> >
> > By much higher means that Linux can't react fast enough and should not
> > try to sync because it's a lost game
>
> As I said, 'much higher' is not a number to base a design on it.

But that gives you the constraint that you can't expect to be always
synced with up to date value which is the most important here. This
means that  cpu_cap -= arch_scale_thermal_pressure(cpu) can be wrong
just after you computed it and your decision is wrong.


> We need real numbers from real platforms. Currently we have two
> places where the thermal pressure is set:
> 1) cpufreq_cooling.c [1]
> 2) Qcom driver [2]
> (we might have 3rd soon for Arm SCMI+FW)

I don't have details but i have khz in mind

>
> For the 2nd I would like to see numbers. For the 1st one when
> kernel thermal is used (which supports higher number of platforms
> comparing to Qcom driver) as it's by design kernel tries to control
> thermal, so changes are not that frequent.
>
> As for now, I can see in experiments the 1st is suffering long decay
> delays and also corner cases with long idle CPUs.
>
> >
> >> problem that Xuewen (and others) faces. IMO it's not technical
> >> argument for blocking the patch and incremental development.
> >>
> >> It's about timing, when we talk about thermal pressure signals and
> >> those two information. For the PELT-one there are also two use cases:
> >> raising time and decay time (where we're actually increasing the
> >> visible capacity of the CPU). The decay period is quite long,
> >> e.g.
> >> Thermal pressure of 140 is removed, signal should converge to 0 from 140
> >> in 130ms (90% decayed),
> >> in 230ms (fully decayed).
> >> The default kernel code allows to slow down the decay period, which is
> >> a derivative from current global PELT default setting.
> >> We can slow it down, but we cannot make it to react faster (BTW I made
> >> such change to compare experiments). It's not always good to have
> >> such long delays.
> >>
> >> For asymmetric CPUs that I was describing and also Xuewen, where mid
> >> core might be faster than big, we need this information in RT class.
> >> Android is such system, so the situation is real (DL is not used there).
> >> You have questioned this that:
> >> 'arch_scale_thermal_pressure() must not be used'
> >> I wouldn't be so sure for the RT change.
> >> Are you sure about that? Do you have experiments for it? I would
> >> like to see them. I have run dozen of experiments and measurements
> >> for this thermal pressure information on a few platforms. How
> >> they behave on those task placements and what are the thermal
> >> signal decay delay impacts. I'm still not sure which one is
> >> best and thus not proposed any changes. But I'll refactor my
> >> test code and send a patch with trace event for the new
> >> topology_update_thermal_pressure(), which then allows to compare
> >> those two designs and nasty timings issues. We would than see
> >> how often (if 'much higher' is true) platforms set this value.
> >> Currently, in mainline there are two clients which set this
> >> value.
> >>
> >> I've been investigating this PELT signal ~1-2 year ago and found
> >> an issue when it's actually updated with delays for the long idle CPU.
> >> When one CPU was running fast and thermal throttling kicked in, while
> >> the other was idle, the idle one didn't have recent thermal information,
> >> but could be picked as a candidate because visible capacity was ~max
> >> possible - which is wrong because they both share the clock.
> >> Check the function others_have_blocked() and the design around it.
> >>
> >> That's why I'm a bit more careful with statements that one type of
> >> information is better that other.
> >>
> >> Furthermore, check the code in rt_task_fits_capacity(), there is no
> >> PELT signal from the RT task. There is only uclamp_eff_value() from
> >> task 'p', which is not PELT information. So all involved variables
> >> are not PELT, why you recommend the PELT thermal pressure here?
> >>
> >> As I said, this patch for the RT class is an incremental step into the
> >> right direction.
> >>
> >>
>
> You haven't answered my questions, which are about technical details of
> your recommendations and statements.
>
> I'm trying to help Xuewen to solve his/her issues with the RT class
> incrementally. I don't want to push him/her into a deep dark water
> of PELT signals, to what variable compare them, corner cases when they
> are (or not) updated or completely not implemented. I'm not even sure
> if those extra complexities make sense for the RT/DL (since they
> make some difference on big.mid.little specific platforms but not for
> the rest).
