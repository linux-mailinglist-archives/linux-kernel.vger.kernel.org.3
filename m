Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AC250657A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbiDSHRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbiDSHRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:17:25 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF8E31DC1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:14:42 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id s33so2030302ybi.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lXtP2hEniXIrZJtGnzd97ErknwmMEGDGM7Fl/js75o=;
        b=TCq6vbFSgI8tPzihxc8+LUVsk+aCPm/ZdzDb72b/DOyF7htS2ufqzcBtpqzUFVZSvO
         Xv1hYt1VoLp9OPgaUJXDvlASlhAvto03ONuo++r6PwmxdGDG6fyumBpD9xjPQi+VLWYA
         0Iwdjmj6SQmfE08CA+j3+C0wqX5VzPfvAfG/oAohdDnJxwunKR/swt8jbCaDjCmLeNL6
         TRLlhbMFMFyOwp5MfEjVheMX+lHCyRRN2ZHNWhhRP+MCjJ53neXyDkLjdpFPIUC6L6gD
         FGLEDiPovEfMUAFuPhibnCmnHeClISRlx+GJJcs7P/sT3gYPo55hsd3fU4kIKZeWFBRt
         jX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lXtP2hEniXIrZJtGnzd97ErknwmMEGDGM7Fl/js75o=;
        b=7d/g97PHZpXPJWs+uilV+pcQqX5M3/jSH/+kOUVd6EA92cZGQYt3qZ0QiU6ZlY66vi
         mjLbnboZTD9/X4NrOEMfszrFFFB6FyktjysPT/pBfL49pKaNNJUncqFJPiaDgtkcivyw
         SeUzOTLh8p+LPtl1f6OHc+1+QrhwLLxL7NSj8LytG7zB5mGvMssTszGlaI5lKjSm/gNS
         FZ253pbU4wQ40lcxlVYNa4MLxb1F7WfjVCmb4y02W3C9FVSUDDH8A47YYrfw7XftAsJL
         fiCs7dfH/7w03EMNO01nwUgsSk0WyDbBKV5if3vBt3CCbeDu74OE9rOi1hNOkLbMh9Qw
         qjvg==
X-Gm-Message-State: AOAM530/LhDTFP2JUgbQvbMnLiT/fJXQN5xNr6tlJspzu96viFZyBJn9
        v54+0Ppdxv3uK5LLb6kyit44j0e6u60vDh/Trb5FUw==
X-Google-Smtp-Source: ABdhPJy8XG4lqdfhHW3uTB3iGt2VcuA1zVZ/dBi6Dj196N+nW07eMWuJejrduw76fcEfcEdtXd+PPaVDui8kzs6ViiU=
X-Received: by 2002:a25:da06:0:b0:645:380a:7ba3 with SMTP id
 n6-20020a25da06000000b00645380a7ba3mr2000710ybf.300.1650352481211; Tue, 19
 Apr 2022 00:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <02350916-aa36-ea53-2c98-91b97f49d27e@arm.com>
 <CAB8ipk-KenZaVWQwWqVMksQXLP5r19BQ1OGAdmwHRbjwv3qFHg@mail.gmail.com>
 <9bb00bcb-f984-1cf6-39aa-c11dcf7f07cb@arm.com> <f100bd49-7a1d-5265-29ce-1092195bb2dd@arm.com>
 <CAB8ipk8v1-jyU0Q0k-EXCArsS6Sh=U+fW6NutW+6m+kQ=LKrJA@mail.gmail.com>
In-Reply-To: <CAB8ipk8v1-jyU0Q0k-EXCArsS6Sh=U+fW6NutW+6m+kQ=LKrJA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Apr 2022 09:14:29 +0200
Message-ID: <CAKfTPtDsNSW0JH4phAtZB7ackJFKuJfAGkhQ7JjWG_C2tzQYSw@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Lukasz Luba <Lukasz.Luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
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

On Sat, 16 Apr 2022 at 04:47, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> Hi Luba  / Dietmar
>
> On Wed, Apr 13, 2022 at 9:26 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >
> >
> >
> > On 4/11/22 15:07, Dietmar Eggemann wrote:
> > > On 11/04/2022 10:52, Xuewen Yan wrote:
> > >> HI Dietmar
> > >>
> > >> On Mon, Apr 11, 2022 at 4:21 PM Dietmar Eggemann
> > >> <dietmar.eggemann@arm.com> wrote:
> > >>>
> > >>> On 07/04/2022 07:19, Xuewen Yan wrote:
> > >>>> There are cases when the cpu max capacity might be reduced due to thermal.
> > >>>> Take into the thermal pressure into account when judge whether the rt task
> > >>>> fits the cpu. And when schedutil govnor get cpu util, the thermal pressure
> > >>>> also should be considered.
> > >>>>
> > >>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > >>>> ---
> > >>>>   kernel/sched/cpufreq_schedutil.c | 1 +
> > >>>>   kernel/sched/rt.c                | 1 +
> > >>>>   2 files changed, 2 insertions(+)
> > >>>>
> > >>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > >>>> index 3dbf351d12d5..285ad51caf0f 100644
> > >>>> --- a/kernel/sched/cpufreq_schedutil.c
> > >>>> +++ b/kernel/sched/cpufreq_schedutil.c
> > >>>> @@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> > >>>>        struct rq *rq = cpu_rq(sg_cpu->cpu);
> > >>>>        unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> > >>>>
> > >>>> +     max -= arch_scale_thermal_pressure(sg_cpu->cpu);
> > >>>
> > >>> max' = arch_scale_cpu_capacity() - arch_scale_thermal_pressure()
> > >>>
> > >>> For the energy part (A) we use max' in compute_energy() to cap sum_util
> > >>> and max_util at max' and to call em_cpu_energy(..., max_util, sum_util,
> > >>> max'). This was done to match (B)'s `policy->max` capping.
> > >>>
> > >>> For the frequency part (B) we have freq_qos_update_request() in:
> > >>>
> > >>> power_actor_set_power()
> > >>>    ...
> > >>>    cdev->ops->set_cur_state()
> > >>>
> > >>>      cpufreq_set_cur_state()
> > >>>        freq_qos_update_request()      <-- !
> > >>>        arch_update_thermal_pressure()
> > >>>
> > >>> restricting `policy->max` which then clamps `target_freq` in:
> > >>>
> > >>>    cpufreq_update_util()
> > >>>      ...
> > >>>      get_next_freq()
> > >>>        cpufreq_driver_resolve_freq()
> > >>>          __resolve_freq()
> > >>>
> > >>
> > >> Do you mean that the "max" here will not affect the frequency
> > >> conversion, so there is no need to change it?
> > >> But is it better to reflect the influence of thermal here?
> > >
> > > I guess your point is that even though max' has no effect on frequency
> > > since QOS caps policy->max anyway, it is still easier to understand the
> > > dependency between schedutil and EAS/EM when it comes to the use of
> > > thermal pressure.
> > >
> > > I agree. The way how the "hidden" policy->max capping guarantees that
> > > schedutil and EAS/EM are doing the same even when only the latter uses
> > > max' is not obvious.
> >
> > +1 here, IMO we shouldn't rely on hidden stuff. There are two which set
> > the thermal pressure, but one is not setting the freq_qos which causes
> > the update of the 'policy->max'. So the schedutil will send that high
> > frequency but that driver would just ignore and clamp internally. In the
> > end we might argue it still works, but is it clean and visible from the
> > code? Funny thing might start to happen then the driver, which might be
> > the last safety net cannot capture this.

schedutil reflects what scheduler wants not what HW can do. If you
start to cap the freq with arch_scale_thermal_pressure() in schedutil,
you will loose some opportunity to run at higher frequency because
arch_scale_thermal_pressure() is transient and might change just after
using it. This means that you will stay at lower freq after mitigation
stops until a new cpufreq_update_util() happens. ANd I don't vene
mentioned when thermal mitigation is managed by HW at a much higher
frequency than what Linux can handle

arch_scale_thermal_pressure() must not be used but thermal_load_avg()
like scale_rt_capacity() what Dietmar suggested

> >
> > We also should be OK with energy estimation and the CPU capacity vs.
> > task utilization comparisons, since the thermal pressure is accounted
> > there* (until the thermal is controlled in kernel not in FW, which is
> > something where we are heading with scmi-cpufreq mentioned in this
> > cover letter [1]).
>
> IMO, If so, we don't want to modify the original code, but also need to
> consider the impact of thermal, maybe it is possible to add a new
> macro definition
> like this:
>
> #define arch_scale_cpu_capacity_except_thermal()
> (arch_scale_cpu_capacity() - arch_scale_thermal_pressure())
>
> >
> > >
> > > I just wanted to mention the historical reason why the code looks like
> > > it does today.
> > >
> > >>> [...]
> > >>>
> > >>>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > >>>> index a32c46889af8..d9982ebd4821 100644
> > >>>> --- a/kernel/sched/rt.c
> > >>>> +++ b/kernel/sched/rt.c
> > >>>> @@ -466,6 +466,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> > >>>>        max_cap = uclamp_eff_value(p, UCLAMP_MAX);
> > >>>>
> > >>>>        cpu_cap = capacity_orig_of(cpu);
> > >>>> +     cpu_cap -= arch_scale_thermal_pressure(cpu);
> > >>>>
> > >>>>        return cpu_cap >= min(min_cap, max_cap);
> > >>>>   }
> > >>>
> > >>> IMHO, this should follow what we do with rq->cpu_capacity
> > >>> (capacity_of(), the remaining capacity for CFS). E.g. we use
> > >>> capacity_of() in find_energy_efficient_cpu() and select_idle_capacity()
> > >>> to compare capacities. So we would need a function like
> > >>> scale_rt_capacity() for RT (minus the rq->avg_rt.util_avg) but then also
> > >>> one for DL (minus rq->avg_dl.util_avg and rq->avg_rt.util_avg).
> > >>
> > >> It's a really good idea. And do you already have the corresponding patch?
> > >> If there is, can you tell me the corresponding link?
> > >
> > > No, I don't have any code for this. Should be trivial though. But the
> > > issue is that the update would probably have to be decoupled from CFS
> > > load_balance (update_group_capacity()) and the use cases in RT/DL are
> > > only valid for asymmetric CPU capacity systems.
> >
> > Having in mind those I would vote for fixing it incrementally.
> > Thus, IMHO this patch is good for taking it. Later we might think how
> > to better estimate the real CPU capacity visible from RT and DL classes.
> > In this shape it is good for many systems which only use RT,
> > but not DL class. Those systems w/ RT and w/o DL might suffer on some
> > asymmetric CPU platforms where medium cores have capacity e.g. 850 and
> > thermal pressure reduced the big cores capacity by 250 making them 774.
> >
>
> Your mean is that before there is better way to handle RT capacity, we
> can take this patch temporarily?
> If so, I can update the patch which will just fix the rt.c.
>
> In fact, in the mobile phone usage scenario where the cpu contains 3
> clusters (small/middle/big),
> the capacity of the big core's capacity will be smaller than that of
> the middle core due to the thermal effect.
> At this time, we do not want the big core CPU to be used as an RT
> task's alternative cpu.
>
> > Regards,
> > Lukasz
> >
> > [1]
> > https://lore.kernel.org/linux-pm/20211007080729.8262-1-lukasz.luba@arm.com/
>
>
> BR
> xuewen.yan
