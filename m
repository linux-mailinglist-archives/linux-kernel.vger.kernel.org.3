Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD0B57FEAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiGYL7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiGYL7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:59:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C4B95A0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:59:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e16so10208768pfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oqm1d/eTIlpJv+OmPXMU6vk7ZdPB82A1A0vEWM99EJU=;
        b=UncDZ9L+PC6I0zyGeUfFvgD6yxV/71f4sstBEWR8/yMmxRJab4XyUAW4sq+QlVHs0f
         igJKYeMBfjnzD/HIynK2+8Fx4LwtwPxATChueoWN1bgHz4RS68wq7rvwfCBV5qUC8BZT
         DGzQai8hHja1pQOCDZQSP1aK8sR6kF6hbpqTZwTaFbSTVmtT5f6MGFwvRFzH+3T93I4E
         Vk1otdwqcJOxicwhxslLMGg33J77fU25uJIt4b2OiDGHEVsHnPf3e6fo8ZgXMCy0krqn
         hbufjzO1ISuCPSwUnNEVHS6KiaLxu2adPryjHzqs8JreWBK1O3r+1CcyMdPokQkPA/9e
         XmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oqm1d/eTIlpJv+OmPXMU6vk7ZdPB82A1A0vEWM99EJU=;
        b=dMkO9dCK1Kd6jZuzYtScdkyuU4UBwqO0YBRZ4EWpc+w5kLS7xfAVzwVqYBpuEFthWC
         j4vTaMu4kavp4G/VHEEuv9mEhn7JK+JzOZRRe0GYaOkBteTjEKX8dz9owGv1wO3ejphP
         nq6EfoEN0fFr6XvNrKtapAtCszrCaS/Rqp5t2RvIeruIntCWuy2pufOzeLd3klhL/vlj
         CPM/5C9u37kHQUj6A4xroyP0m3Xap9K45dPNJUoYjXGdoXOUd7j9//s2wi1afYDfudLX
         tFMtXctXxVQ7GWMyDJ8pBqWDtok7PZnrvkxXSfEGbZiE6sCqe69eeHjHtKhVcWDRt3xA
         gqhg==
X-Gm-Message-State: AJIora+FcucRnxQwnUFzwPQfygnh0CDxQIJkIYG3BxXqbvF1woN35GBz
        vphc3VjPBABBD+Xg+bTCcAxm9Q35BUoQqenQkLY=
X-Google-Smtp-Source: AGRyM1s9V/7BfOIS5f6IkfwFoqYKST/pYXgyNXr9AAQfQaPrBve3tTunitUypB1eRjpflpDknoFgib4qnquXZ4AzI7Y=
X-Received: by 2002:a05:6a00:1145:b0:52b:78c:fa26 with SMTP id
 b5-20020a056a00114500b0052b078cfa26mr12451519pfm.27.1658750354022; Mon, 25
 Jul 2022 04:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220629194632.1117723-1-qais.yousef@arm.com> <20220629194632.1117723-2-qais.yousef@arm.com>
 <CAB8ipk-PzwsfTzJtfrq6vJJdDNHsnGKrHjFR+527SoxBNQy0YA@mail.gmail.com> <20220721102417.cf6ukxpvkh4grjeh@wubuntu>
In-Reply-To: <20220721102417.cf6ukxpvkh4grjeh@wubuntu>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 25 Jul 2022 19:59:02 +0800
Message-ID: <CAB8ipk98A5XOSXMwmJGugi-9R=TkVNGcvZA3ky_iem_Mg5COOw@mail.gmail.com>
Subject: Re: [PATCH 1/7] sched/uclamp: Fix relationship between uclamp and
 migration margin
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais

On Thu, Jul 21, 2022 at 6:24 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Xuewen
>
> On 07/20/22 15:17, Xuewen Yan wrote:
> > Hi Qais,
> >
> > On Thu, Jun 30, 2022 at 3:47 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > fits_capacity() verifies that a util is within 20% margin of the
> > > capacity of a CPU, which is an attempt to speed up upmigration.
> > >
> > > But when uclamp is used, this 20% margin is problematic because for
> > > example if a task is boosted to 1024, then it will not fit on any CPU
> > > according to fits_capacity() logic.
> > >
> > > Or if a task is boosted to capacity_orig_of(medium_cpu). The task will
> > > end up on big instead on the desired medium CPU.
> >
> > I think it is reasonable. Since the user sets uclamp_min to be greater
> > than 0, the user prefers that the process has better performance cpu.
> > If ignore the margin here, the uclamp_min is meaningless.
>
> Why is it meaningless?
>
> uclamp is a performance hint, not a bandwidth hint.
>
> That is, if the task's util_avg, which represents its bandwidth, is being
> impacted then it should move up.
>
> But if the task is getting the bandwidth it needs, which is again represented
> by its util_avg, then uclamp_min just ensure it is running at the right
> performance level. Performance level is orthogonal to bandwidth.
>
> As long as the medium CPU will run at max performance point, it is fine.

This involves the meaning of uclamp, if it guarantees performance
rather than bandwidth, then it is fine:-)

>
> >
> > >
> > > Similar corner cases exist for uclamp and usage of capacity_of().
> > > Slightest irq pressure on biggest CPU for example will make a 1024
> > > boosted task look like it can't fit.
> >
> > I think it can't fit is reasonable. The uclamp_min is limit the
> > util_avg, if the task can fit the cpu with capacity is 1024, which
> > uclamp_min is 1024, How to deal with the task which util is 1024?
> > Maybe your idea is that the biggest cpu can fit any task even if it's
> > util is 1024?
>
> util_fits_cpu() compares util_avg with capacity_of(). So if
>
>         util_avg >= 0.8 * 1024
>
> then it will not fit the cpu. Regardless of what is the uclamp_min value. Only
> exception is if you use uclamp_max, then by design this should force it to fit
> even if util_avg is bigger.

Okay, This also involves the meaning of uclamp. It represents performance. :-)

>
> >
> > >
> > > What we really want is for uclamp comparisons to ignore the migration
> > > margin and capacity pressure, yet retain them for when checking the
> > > _actual_ util signal.
> > >
> > > For example, task p:
> > >
> > >         p->util_avg = 300
> > >         p->uclamp[UCLAMP_MIN] = 1024
> > >
> > > Will fit a big CPU. But
> > >
> > >         p->util_avg = 900
> > >         p->uclamp[UCLAMP_MIN] = 1024
> > >
> > > will not, this should trigger overutilized state because the big CPU is
> > > now *actually* being saturated.
> >
> > Now the code would catch the uclamp before judging the fits_capacity.
> > The two task both can not fit the cpu, why the task(300) can fit the
> > cpu?
>
> Because
>
>         p->util_avg < 0.8 * capacity_of(big_cpu)
> AND
>         p->uclamp_min <= capacity_orig_of(big_cpu)
>
> Why it shouldn't fit?
>
> Please keep in mind that uclamp is a performance hint and not a bandwidth hint.
> It requests for the task to run at a performance level, if we can satisfy that
> request, but it doesn't say that the task is actually occupies that bandwidth.
>
> By design, we want to allow multiple small tasks to be packed on a big core.
> For example if we have
>
>         p0->util_avg = 300
>         p0->uclamp_min = 1024
>
>         p1->util_avg = 300
>         p1->uclamp_min = 1024
>
> Then by design we would like to enable both of these tasks to run on big cores.
>
> Their combined bandwidth is 600, which is well below the available bandwidth.
> And uclamp_min = 1024 just means these task must run at highest frequency on
> the biggest cpu.
>
> feec() will actually take care of deciding whether to pack or spread within
> the big cpu 'cluster'. util_fits_cpu() role is merely to indicate whether this
> cpu is a viable option or not.
>
> Taking any pressure into account will mean any hint to 1024 will almost always
> fail because in the common case there's always some form of pressure on a CPU.
> So even if capacity_of() is 1023, this will make p0 and p1 to trigger
> overutilized state. Which is plain wrong. The tasks are actually small, and the
> fact that uclamp_min is 1024 is a simple request to *attempt* to run it at max
> performance point, which is the biggest core and highest frequency. None of
> these has any correlation to rt/irq pressures.

Okay, Thanks for the the very detailed explanation, I will re-review
this patch from a different angle:-)
Cheers~

>
> >
> > >
> > > Similar reasoning applies to capping tasks with UCLAMP_MAX. For example:
> > >
> > >         p->util_avg = 1024
> > >         p->uclamp[UCLAMP_MAX] = capacity_orig_of(medium_cpu)
> > >
> > > Should fit the task on medium cpus without triggering overutilized
> > > state.
> >
> > I fully agree with this! But there is a problem, How to do when there
> > is RT pressure or irq pressure?
> > Maybe it is better to compare the uclamp_max with the capacity_of(cpu)
> > instead of the capacity_origin?
>
> No. This IS the problem I am trying to fix with this series. UCLAMP_MAX limits
> the performance level the task can obtain.
>
> The fact that there's RT or irq pressure doesn't prevent this task from being
> capped to that performance level.
>
> Beside this will break the ability to use uclamp as a weak affinity.
>
> Setting uclamp_max to capacity_orig_of(little_cpu), as one would do for
> background tasks for instance, will enable EAS to consider the little cores as
> a viable candidate and select it if it is the most energy efficient CPU.
> Which is an intended design use case.
>
> If we start failing to do this randomly because of spurious RT and irq
> pressure, the benefit of the hint will be significantly reduced.
> And then it *will* become meaningless.

I agree with you, but I'm still a bit concerned that such a setup will
cause performance issues.
As you say, may one want the background tasks running on the little
cpus, he can use cpuset to control them completely.
When there are many processes in the system, if such processes always
fit small cores, do we need to consider more when load balancing?

>
> >
> > >
> > > Inlined comments expand more on desired behavior in more scenarios.
> > >
> > > Introduce new util_fits_cpu() function which encapsulates the new logic.
> > > The new function is not used anywhere yet, but will be used to update
> > > various users of fits_capacity() in later patches.
> > >
> > > Fixes: af24bde8df202 ("sched/uclamp: Add uclamp support to energy_compute()")
> > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > ---
> > >  kernel/sched/fair.c | 114 ++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 114 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index f80ae86bb404..5eecae32a0f6 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4203,6 +4203,120 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> > >         trace_sched_util_est_se_tp(&p->se);
> > >  }
> > >
> > > +static inline int util_fits_cpu(unsigned long util,
> > > +                               unsigned long uclamp_min,
> > > +                               unsigned long uclamp_max,
> > > +                               int cpu)
> > > +{
> >
> > May the function name is not proper when the uclamp is unused.
>
> Are you suggesting to rename it? What name do you have in mind?
> I think this is a suitable name, but open for suggestions :-)

Okay:-)

>
> >
> > > +       unsigned long capacity = capacity_of(cpu);
> > > +       unsigned long capacity_orig;
> > > +       bool fits, max_capacity;
> > > +       bool uclamp_max_fits;
> > > +
> > > +       /*
> > > +        * Check if the real util fits without any uclamp boost/cap applied.
> > > +        */
> > > +       fits = fits_capacity(util, capacity);
> > > +
> > > +       if (!uclamp_is_used())
> > > +               return fits;
> > > +
> > > +       /*
> > > +        * We must use capacity_orig_of() for comparing against uclamp_min and
> > > +        * uclamp_max. We only care about capacity pressure (by using
> > > +        * capacity_of()) for comparing against the real util.
> > > +        *
> > > +        * If a task is boosted to 1024 for example, we don't want a tiny
> > > +        * pressure to skew the check whether it fits a CPU or not.
> > > +        *
> > > +        * Similarly if a task is capped to capacity_orig_of(little_cpu), it
> > > +        * should fit a little cpu even if there's some pressure.
> > > +        *
> > > +        * Known limitation is when thermal pressure is severe to the point
> > > +        * where we have capacity inversion. We don't cater for that as the
> > > +        * system performance will already be impacted severely.
> > > +        */
> > > +       capacity_orig = capacity_orig_of(cpu);
> > > +
> > > +       /*
> > > +        * We want to force a task to fit a cpu as implied by uclamp_max.
> > > +        * But we do have some corner cases to cater for..
> > > +        *
> > > +        *
> > > +        *                                 C=z
> > > +        *   |                             ___
> > > +        *   |                  C=y       |   |
> > > +        *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _  uclamp_max
> > > +        *   |      C=x        |   |      |   |
> > > +        *   |      ___        |   |      |   |
> > > +        *   |     |   |       |   |      |   |    (util somewhere in this region)
> > > +        *   |     |   |       |   |      |   |
> > > +        *   |     |   |       |   |      |   |
> > > +        *   +----------------------------------------
> > > +        *         cpu0        cpu1       cpu2
> > > +        *
> > > +        *   In the above example if a task is capped to a specific performance
> > > +        *   point, y, then when:
> > > +        *
> > > +        *   * util = 80% of x then it does not fit on cpu0 and should migrate
> > > +        *     to cpu1
> > > +        *   * util = 80% of y then it is forced to fit on cpu1 to honour
> > > +        *     uclamp_max request.
> > > +        *
> > > +        *   which is what we're enforcing here. A task always fits if
> > > +        *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> > > +        *   the normal upmigration rules should withhold still.
> > > +        *
> > > +        *   Only exception is when we are on max capacity, then we need to be
> > > +        *   careful not to block overutilized state. This is so because:
> > > +        *
> > > +        *     1. There's no concept of capping at max_capacity! We can't go
> > > +        *        beyond this performance level anyway.
> > > +        *     2. The system is being saturated when we're operating near
> > > +        *        max_capacity, it doesn't make sense to block overutilized.
> > > +        */
> > > +       max_capacity = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > > +       uclamp_max_fits = !max_capacity && (uclamp_max <= capacity_orig);
> > > +       fits = fits || uclamp_max_fits;
> >
> > As I said above, Using the capacity_orig may ignore the rt/irq pressure.
> > If we have two or more middle cpus, we can select the cpu whose rt/irq
> > pressure is smaller.
> > If using the capacity_orig, the first MID cpu is always the candidate.
>
> I hope my explanation above addressed that too. rt/irq has no impact on the
> task's ability to achieve the required performance level from uclamp hint PoV.
> We still use util_avg to compare with rt/irq pressure as usual. so if rt/irq
> pose any issue to the task's ability to obtain the required bandwidth that will
> be taken into account. But if util_avg is happy with that level of rt/irq
> pressure, then uclamp only cares about being able to achieve the performance
> level on that cpu, which doesn't care about rt/irq pressure.
>
> >
> > > +
> > > +       /*
> > > +        *
> > > +        *                                 C=z
> > > +        *   |                             ___       (region a, capped, util >= uclamp_max)
> > > +        *   |                  C=y       |   |
> > > +        *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _ uclamp_max
> > > +        *   |      C=x        |   |      |   |
> > > +        *   |      ___        |   |      |   |      (region b, uclamp_min <= util <= uclamp_max)
> > > +        *   |_ _ _|_ _|_ _ _ _| _ | _ _ _| _ | _ _ _ _ _ uclamp_min
> > > +        *   |     |   |       |   |      |   |
> > > +        *   |     |   |       |   |      |   |      (region c, boosted, util < uclamp_min)
> > > +        *   +----------------------------------------
> > > +        *         cpu0        cpu1       cpu2
> > > +        *
> > > +        * a) If util > uclamp_max, then we're capped, we don't care about
> > > +        *    actual fitness value here. We only care if uclamp_max fits
> > > +        *    capacity without taking margin/pressure into account.
> > > +        *    See comment above.
> > > +        *
> > > +        * b) If uclamp_min <= util <= uclamp_max, then the normal
> > > +        *    fits_capacity() rules apply. Except we need to ensure that we
> > > +        *    enforce we remain within uclamp_max, see comment above.
> > > +        *
> > > +        * c) If util < uclamp_min, then we are boosted. Same as (b) but we
> > > +        *    need to take into account the boosted value fits the CPU without
> > > +        *    taking margin/pressure into account.
> > > +        *
> > > +        * Cases (a) and (b) are handled in the 'fits' variable already. We
> > > +        * just need to consider an extra check for case (c) after ensuring we
> > > +        * handle the case uclamp_min > uclamp_max.
> > > +        */
> > > +       uclamp_min = min(uclamp_min, uclamp_max);
> > > +       if (util < uclamp_min)
> > > +               fits = fits && (uclamp_min <= capacity_orig);
> >
> > As said above, I think the uclamp_min should consider the margin.
>
> Addressed above ;-)

Okay, I would revisit the patch:-)

Thanks~
BR
---
xw-yan


>
>
> Thanks!
>
> --
> Qais Yousef
>
> >
> > > +
> > > +       return fits;
> > > +}
> > > +
> > >  static inline int task_fits_capacity(struct task_struct *p,
> > >                                      unsigned long capacity)
> > >  {
> > > --
> > > 2.25.1
> > >
> >
> > Thanks!
> > BR
> > ---
> > xuewen.yan
