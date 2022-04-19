Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAF6506CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348463AbiDSMyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiDSMyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:54:51 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DC53701B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:52:08 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id x200so30734590ybe.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09S4L72ei2xncQZ1URK/wAWJ0bgL4/hNB9zyvzF/7c4=;
        b=oXb3nRRbrhOw1Y7lk0ffVsmDbsUIVf1KgfkpvJArKwBsvDZ/0m/2XPktzx4otCaK0U
         +Hk3DX6ZX9D9yn9Rroiaoa3UaXjhChKQ7P5HTlGgIVef3vtf5sefRpYoazvJbSkKizO0
         14vgu6mm57PkJpBu+dlpVZu7V3HpmFD9joDd54uCIpkP/hiVjCwSUT03VRAHlG6LK7/e
         yl3Zc4Bzf7LJi8bOGD6cC7JsTJG2zIdte2CMAxIWvtEow5z3NeyuAHuqGmopfEQ7M6dh
         2fsUbjjtqBKLvzYS+l1oXMOmpqlzsfYSCs30Y4Z33TW0aP9dOfOEYGNLeQmjzyVzM1O+
         HjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09S4L72ei2xncQZ1URK/wAWJ0bgL4/hNB9zyvzF/7c4=;
        b=uR2WekewYz9kD0zSLbzJBZ2cJ6TWr0e8Spgd813da4S3td+VFcqEKFKLVZocr+owh1
         AKId/9KRiOsRI9K8d4oyZdO7tprCE1jYOZKRrYAZJQoND6LvwvfqVEbTgpakhSdutuqm
         uZmpzfJAl9peqMGngs9jMZXKXkdHQ4y1F7FD76z756Fp8BB4JPi3ORUSD5IVSStv/7AK
         t9xP0pZQ3TMy3Ff3asbMFeVBS9CBaeOoZ+FnRWMJdtrCMkf/fvtunNyTLoX552pRdLIv
         0dH1mm66yoAptsGt52O3cEqzTY122K+Xe7yKyp7qlwR/nEYpf9YILJJc2mA6OM7iIpR3
         wQ7A==
X-Gm-Message-State: AOAM533y2uUTumWJXItfQxzofaBuzkYEbBUXtjfbKUqNYYKm/LQcwVDN
        nuqwsQOT++sJiADTtfaRTMaMiROJXJDExK1hBWKsfDUmRA2rxQ==
X-Google-Smtp-Source: ABdhPJwRJMHQhTlBtgIdjF/wTkrvGA8iVrc7+or7YTS3kyDrzG3YI1uOYheEtno5n/PArR5G2kyU1oxLkVsZKAlX3PU=
X-Received: by 2002:a05:6902:1c2:b0:63e:6bd:3a5b with SMTP id
 u2-20020a05690201c200b0063e06bd3a5bmr14055216ybh.424.1650372727879; Tue, 19
 Apr 2022 05:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <02350916-aa36-ea53-2c98-91b97f49d27e@arm.com>
 <CAB8ipk-KenZaVWQwWqVMksQXLP5r19BQ1OGAdmwHRbjwv3qFHg@mail.gmail.com>
 <9bb00bcb-f984-1cf6-39aa-c11dcf7f07cb@arm.com> <f100bd49-7a1d-5265-29ce-1092195bb2dd@arm.com>
 <CAB8ipk8v1-jyU0Q0k-EXCArsS6Sh=U+fW6NutW+6m+kQ=LKrJA@mail.gmail.com>
 <CAKfTPtDsNSW0JH4phAtZB7ackJFKuJfAGkhQ7JjWG_C2tzQYSw@mail.gmail.com> <24631a27-42d9-229f-d9b0-040ac993b749@arm.com>
In-Reply-To: <24631a27-42d9-229f-d9b0-040ac993b749@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Apr 2022 14:51:56 +0200
Message-ID: <CAKfTPtAnHmm0T+FKF251YcjM3Nw66Wqs2a16yU9Ptiip+jyNLA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 at 14:01, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 4/19/22 08:14, Vincent Guittot wrote:
> > On Sat, 16 Apr 2022 at 04:47, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >>
> >> Hi Luba  / Dietmar
> >>
> >> On Wed, Apr 13, 2022 at 9:26 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>
> >>>
> >>>
> >>> On 4/11/22 15:07, Dietmar Eggemann wrote:
> >>>> On 11/04/2022 10:52, Xuewen Yan wrote:
> >>>>> HI Dietmar
> >>>>>
> >>>>> On Mon, Apr 11, 2022 at 4:21 PM Dietmar Eggemann
> >>>>> <dietmar.eggemann@arm.com> wrote:
> >>>>>>
> >>>>>> On 07/04/2022 07:19, Xuewen Yan wrote:
> >>>>>>> There are cases when the cpu max capacity might be reduced due to thermal.
> >>>>>>> Take into the thermal pressure into account when judge whether the rt task
> >>>>>>> fits the cpu. And when schedutil govnor get cpu util, the thermal pressure
> >>>>>>> also should be considered.
> >>>>>>>
> >>>>>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> >>>>>>> ---
> >>>>>>>    kernel/sched/cpufreq_schedutil.c | 1 +
> >>>>>>>    kernel/sched/rt.c                | 1 +
> >>>>>>>    2 files changed, 2 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >>>>>>> index 3dbf351d12d5..285ad51caf0f 100644
> >>>>>>> --- a/kernel/sched/cpufreq_schedutil.c
> >>>>>>> +++ b/kernel/sched/cpufreq_schedutil.c
> >>>>>>> @@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >>>>>>>         struct rq *rq = cpu_rq(sg_cpu->cpu);
> >>>>>>>         unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> >>>>>>>
> >>>>>>> +     max -= arch_scale_thermal_pressure(sg_cpu->cpu);
> >>>>>>
> >>>>>> max' = arch_scale_cpu_capacity() - arch_scale_thermal_pressure()
> >>>>>>
> >>>>>> For the energy part (A) we use max' in compute_energy() to cap sum_util
> >>>>>> and max_util at max' and to call em_cpu_energy(..., max_util, sum_util,
> >>>>>> max'). This was done to match (B)'s `policy->max` capping.
> >>>>>>
> >>>>>> For the frequency part (B) we have freq_qos_update_request() in:
> >>>>>>
> >>>>>> power_actor_set_power()
> >>>>>>     ...
> >>>>>>     cdev->ops->set_cur_state()
> >>>>>>
> >>>>>>       cpufreq_set_cur_state()
> >>>>>>         freq_qos_update_request()      <-- !
> >>>>>>         arch_update_thermal_pressure()
> >>>>>>
> >>>>>> restricting `policy->max` which then clamps `target_freq` in:
> >>>>>>
> >>>>>>     cpufreq_update_util()
> >>>>>>       ...
> >>>>>>       get_next_freq()
> >>>>>>         cpufreq_driver_resolve_freq()
> >>>>>>           __resolve_freq()
> >>>>>>
> >>>>>
> >>>>> Do you mean that the "max" here will not affect the frequency
> >>>>> conversion, so there is no need to change it?
> >>>>> But is it better to reflect the influence of thermal here?
> >>>>
> >>>> I guess your point is that even though max' has no effect on frequency
> >>>> since QOS caps policy->max anyway, it is still easier to understand the
> >>>> dependency between schedutil and EAS/EM when it comes to the use of
> >>>> thermal pressure.
> >>>>
> >>>> I agree. The way how the "hidden" policy->max capping guarantees that
> >>>> schedutil and EAS/EM are doing the same even when only the latter uses
> >>>> max' is not obvious.
> >>>
> >>> +1 here, IMO we shouldn't rely on hidden stuff. There are two which set
> >>> the thermal pressure, but one is not setting the freq_qos which causes
> >>> the update of the 'policy->max'. So the schedutil will send that high
> >>> frequency but that driver would just ignore and clamp internally. In the
> >>> end we might argue it still works, but is it clean and visible from the
> >>> code? Funny thing might start to happen then the driver, which might be
> >>> the last safety net cannot capture this.
> >
> > schedutil reflects what scheduler wants not what HW can do. If you
> > start to cap the freq with arch_scale_thermal_pressure() in schedutil,
>
> s/freq/util ?

Isn't it the same at the end if you cap util to orig capacity -
arch_scale_thermal_pressure ?

>
> To be precised and maybe fix some potential design issues. We are
> talking here about utilization and set max capacity in function:
> sugov_get_util()
> so fields:
>
> sugov_cpu::util
> sugov_cpu::max /* max capacity */

Yes. With this patch ,util will be lower than current thermal
mitigation whereas util normally reflects what we need  not what can
be provided

>
> > you will loose some opportunity to run at higher frequency because
> > arch_scale_thermal_pressure() is transient and might change just after
> > using it. This means that you will stay at lower freq after mitigation
> > stops until a new cpufreq_update_util() happens. ANd I don't vene
> > mentioned when thermal mitigation is managed by HW at a much higher
> > frequency than what Linux can handle
> >
> > arch_scale_thermal_pressure() must not be used but thermal_load_avg()
> > like scale_rt_capacity() what Dietmar suggested
> >
>
> First, I would like to see your view to this topic and why you are
> making such strong statements. I have slightly different view and
> made dozen of experiments with this thermal pressure in last ~2-3y.
>
> The code flow is like this and operates on those fields from above:
>
> util, max <--- sugov_get_util()
> util <--- sugov_iowait_apply()  <--- util, max /* ignore this now */
>
> get_next_freq():
> util <--- map_util_perf() <--- util (1)
> freq <--- map_util_freq() <--- util, max, max_freq (2)
>
>
> At (1) we add +25% util, at (2) we do the conversion to frequency:
> freq = max_freq * util / max
>
> As you can see with the patch we would still end up with bigger
> frequency than max_freq (since it can happen: max < util).
> It's also true currently in mainline, when
> max=1024 and util=1024+256=1280
> I would be similar if we cap max capacity:
> max=800 and util=800+200=1000

It's not because you end up with a similar value that it's ok. You
can't use one side to compensate for the other one. 1.25 is there to
provide spare cycles to a change in the cpu load (load meaning what is
running on the cpu not load_avg)

> but then in both cases are multiplied by 'max_freq' in (2)
>
> As you can see this is not the situation that you have described, is it?
> And the transient or non-transient is minor here IMO.

If max is 512 then util = 640 which is much lower than 1024.

>
> Secondly, you have mentioned the mitigation in HW and issue between
> instantaneous vs. PELT-one thermal pressure information. This is
> something that I'm stretching my head for long. I'm trying to
> develop this for new Arm FW thermal. You have mentioned:
> 'thermal mitigation is managed by HW at a much higher
> frequency than what Linux can handle' - I would be also more
> precised here: HW or FW? How often the HW can change max freq or
> how often FW can change that? If we don't have those numbers
> than statement: 'a much higher' doesn't help in solving this

By much higher means that Linux can't react fast enough and should not
try to sync because it's a lost game

> problem that Xuewen (and others) faces. IMO it's not technical
> argument for blocking the patch and incremental development.
>
> It's about timing, when we talk about thermal pressure signals and
> those two information. For the PELT-one there are also two use cases:
> raising time and decay time (where we're actually increasing the
> visible capacity of the CPU). The decay period is quite long,
> e.g.
> Thermal pressure of 140 is removed, signal should converge to 0 from 140
> in 130ms (90% decayed),
> in 230ms (fully decayed).
> The default kernel code allows to slow down the decay period, which is
> a derivative from current global PELT default setting.
> We can slow it down, but we cannot make it to react faster (BTW I made
> such change to compare experiments). It's not always good to have
> such long delays.
>
> For asymmetric CPUs that I was describing and also Xuewen, where mid
> core might be faster than big, we need this information in RT class.
> Android is such system, so the situation is real (DL is not used there).
> You have questioned this that:
> 'arch_scale_thermal_pressure() must not be used'
> I wouldn't be so sure for the RT change.
> Are you sure about that? Do you have experiments for it? I would
> like to see them. I have run dozen of experiments and measurements
> for this thermal pressure information on a few platforms. How
> they behave on those task placements and what are the thermal
> signal decay delay impacts. I'm still not sure which one is
> best and thus not proposed any changes. But I'll refactor my
> test code and send a patch with trace event for the new
> topology_update_thermal_pressure(), which then allows to compare
> those two designs and nasty timings issues. We would than see
> how often (if 'much higher' is true) platforms set this value.
> Currently, in mainline there are two clients which set this
> value.
>
> I've been investigating this PELT signal ~1-2 year ago and found
> an issue when it's actually updated with delays for the long idle CPU.
> When one CPU was running fast and thermal throttling kicked in, while
> the other was idle, the idle one didn't have recent thermal information,
> but could be picked as a candidate because visible capacity was ~max
> possible - which is wrong because they both share the clock.
> Check the function others_have_blocked() and the design around it.
>
> That's why I'm a bit more careful with statements that one type of
> information is better that other.
>
> Furthermore, check the code in rt_task_fits_capacity(), there is no
> PELT signal from the RT task. There is only uclamp_eff_value() from
> task 'p', which is not PELT information. So all involved variables
> are not PELT, why you recommend the PELT thermal pressure here?
>
> As I said, this patch for the RT class is an incremental step into the
> right direction.
>
>
