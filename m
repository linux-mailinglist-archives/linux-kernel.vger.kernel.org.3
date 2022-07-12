Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E0571C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiGLOU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiGLOUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:20:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCA1E57243
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:20:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9DF91596;
        Tue, 12 Jul 2022 07:20:16 -0700 (PDT)
Received: from wubuntu (unknown [10.57.86.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ECA03F73D;
        Tue, 12 Jul 2022 07:20:15 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:20:13 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH 1/7] sched/uclamp: Fix relationship between uclamp and
 migration margin
Message-ID: <20220712142013.j6fy77yejupvllah@wubuntu>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
 <20220629194632.1117723-2-qais.yousef@arm.com>
 <CAKfTPtBAOLzYocTEg3KErACSyrAWDU94NdR7EAOnW0gti2GiDQ@mail.gmail.com>
 <20220712102334.6nwkbkilmmup4h4u@wubuntu>
 <CAKfTPtDweeQDRcZb+_ANO6rzZd11vbiatoVxDNwsWPtoCTG+AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDweeQDRcZb+_ANO6rzZd11vbiatoVxDNwsWPtoCTG+AQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/22 15:21, Vincent Guittot wrote:
> On Tue, 12 Jul 2022 at 12:23, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 07/11/22 14:36, Vincent Guittot wrote:
> > > On Wed, 29 Jun 2022 at 21:47, Qais Yousef <qais.yousef@arm.com> wrote:
> > > >
> > > > fits_capacity() verifies that a util is within 20% margin of the
> > > > capacity of a CPU, which is an attempt to speed up upmigration.
> > > >
> > > > But when uclamp is used, this 20% margin is problematic because for
> > > > example if a task is boosted to 1024, then it will not fit on any CPU
> > > > according to fits_capacity() logic.
> > > >
> > > > Or if a task is boosted to capacity_orig_of(medium_cpu). The task will
> > > > end up on big instead on the desired medium CPU.
> > > >
> > > > Similar corner cases exist for uclamp and usage of capacity_of().
> > > > Slightest irq pressure on biggest CPU for example will make a 1024
> > > > boosted task look like it can't fit.
> > > >
> > > > What we really want is for uclamp comparisons to ignore the migration
> > > > margin and capacity pressure, yet retain them for when checking the
> > > > _actual_ util signal.
> > >
> > > I fully agree on the migration margin but I'm a bit more skeptical
> > > about the capacity pressure. If uclam_min is set to ensure a minimum
> > > compute capacity of X for a task but the CPU can't provide such
> > > capacity because of some pressures (I have irq and thermal in mind),
> > > then we should find a better cpu otherwise uclamp_min becomes
> > > meaningless because it doesn't ensure a minimum compute capacity which
> > > usually means a time to execute the work of the thread
> >
> > We need to be careful here about what uclamp_min means.
> >
> > uclamp is a performance hint, not a bandwidth hint. When a task p with:
> >
> >         p->util_avg = 300
> >         p->uclamp_min = 1024
> >
> > what this means is that it needs to run at max performance point as it cares
> > about how long it runs for. Its bandwidth which is defined but util_avg is 300
> > which means there's plenty of idle time on the CPU. As you know better,
> > util_avg of 300 could translate to different runtimes based on the performance
> > point you're operating at.
> >
> > IOW, a uclamp_min of 1024 translates into task placement and frequency
> > selection (biggest CPU and highest achievable OPP for 1024 case). Capacity
> > pressure doesn't impact this selection. Only thermal pressure can actually
> > impact our ability to achieve a performance level. I touched on this topic
> > below.
> >
> > since p->util_avg reflect the true bandwidth of the task, 300 means there's
> > plenty of idle time on that CPU and unless capacity pressure is higher than 724
> > the task will always fit and be able to run at max perf point as uclamp_min
> > hint indicated.
> >
> > Note that by design this means if there are 2 of these tasks whose util_avg is
> > 300 and uclamp_min is 1024, then they both can be packed on the biggest CPU and
> > run at the highest perf point with still plenty of idle time left on that CPU.
> >
> > The keyword here is that uclamp indicates performance level requirements, not
> > bandwidth. We have cpushares, nice values, bandwidth controllers, etc for that.
> 
> That's why I have mentioned that I have thermal pressure and irq in
> mind. I'm speaking about performance level but not about bandwidth and
> time sharing.

irq pressure has no impact on the cpu's ability to get any OPP, no? It purely
reduces the bandwidth availability for CFS tasks AFAIU. So the task's ability
to achieve a performance level has no correlation with irq pressure IMO. Unless
I missed something.

> If the thermal pressure makes the performance of the cpu half of the
> capacity_orig, then you impact the performance  and you don't follow
> the uclamp_min hint anymore.

If we lose half of the performance we are doomed already.

I can't see how one cluster can have a significant 50% loss in its perf without
the whole SoC being under extreme thermal throttling scenarios anyway. That is,
it will be impossible for one cluster to have had lost 50% of its performance
and everything else is still able to run at full performance.

I think the only case that matters is the one highlighted by Xuewen in that RT
email thread.

	https://lore.kernel.org/lkml/20220420135127.o7ttm5tddwvwrp2a@airbuntu/

Which is uclamp_min is set to capacity_orig_of(medium_cpu) but the big CPU
which usually should be able to achieve that perf level is in capacity
inversion.

For example on a system which has

	capacity_orig_of(little) = 400
	capacity_orig_of(medium) = 800
	capacity_orig_of(big)    = 1024

And there's a task p with

	p->util_avg = 300
	p->uclamp_min = 1024

Then the big CPU is the right task placement until thermal pressure is more
than 20% (capacity inversion). Once we reach that point, we can place it on
medium but that doesn't mean its perf requirement is honoured and this 20+%
perf drop will impact perceived performance by this task and there's nothing we
can do about it.

Now if task p has

	p->uclamp_min = 800

then both medium and big cores fit this task perf requirement. But unlike the
above case, once the bigs are in capacity inversion, then mediums are the
correct ones to pick - which is the use case raised by Xuewen in the other RT
vs thermal pressure email thread.

uclamp_min is a hint and best effort. We should try our best, but there's
a complexity to handle. I think we can do something about capacity inversion,
but if we want to do a full proper search when taking into account any amount
of thermal pressure, I think that will be very expensive search.

My assumption here is that if thermal pressure is meaningful, then it's likely
the system is doomed for this best effort to save the day. Only exception IMHO
is capacity inversion case which I think we can handle, but I think that should
be a separate series.

> 
> >
> > >
> > > >
> > > > For example, task p:
> > > >
> > > >         p->util_avg = 300
> > > >         p->uclamp[UCLAMP_MIN] = 1024
> > > >
> > > > Will fit a big CPU. But
> > > >
> > > >         p->util_avg = 900
> > > >         p->uclamp[UCLAMP_MIN] = 1024
> > > >
> > > > will not, this should trigger overutilized state because the big CPU is
> > > > now *actually* being saturated.
> > > >
> > > > Similar reasoning applies to capping tasks with UCLAMP_MAX. For example:
> > > >
> > > >         p->util_avg = 1024
> > > >         p->uclamp[UCLAMP_MAX] = capacity_orig_of(medium_cpu)
> > > >
> > > > Should fit the task on medium cpus without triggering overutilized
> > > > state.
> > > >
> > > > Inlined comments expand more on desired behavior in more scenarios.
> > > >
> > > > Introduce new util_fits_cpu() function which encapsulates the new logic.
> > > > The new function is not used anywhere yet, but will be used to update
> > > > various users of fits_capacity() in later patches.
> > > >
> > > > Fixes: af24bde8df202 ("sched/uclamp: Add uclamp support to energy_compute()")
> > > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > > ---
> > > >  kernel/sched/fair.c | 114 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 114 insertions(+)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index f80ae86bb404..5eecae32a0f6 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -4203,6 +4203,120 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> > > >         trace_sched_util_est_se_tp(&p->se);
> > > >  }
> > > >
> > > > +static inline int util_fits_cpu(unsigned long util,
> > > > +                               unsigned long uclamp_min,
> > > > +                               unsigned long uclamp_max,
> > > > +                               int cpu)
> > > > +{
> > > > +       unsigned long capacity = capacity_of(cpu);
> > > > +       unsigned long capacity_orig;
> > > > +       bool fits, max_capacity;
> > > > +       bool uclamp_max_fits;
> > > > +
> > > > +       /*
> > > > +        * Check if the real util fits without any uclamp boost/cap applied.
> > > > +        */
> > > > +       fits = fits_capacity(util, capacity);
> > > > +
> > > > +       if (!uclamp_is_used())
> > > > +               return fits;
> > > > +
> > > > +       /*
> > > > +        * We must use capacity_orig_of() for comparing against uclamp_min and
> > > > +        * uclamp_max. We only care about capacity pressure (by using
> > > > +        * capacity_of()) for comparing against the real util.
> > >
> > > I don't fully agree on this. see below
> > >
> > > > +        *
> > > > +        * If a task is boosted to 1024 for example, we don't want a tiny
> > > > +        * pressure to skew the check whether it fits a CPU or not.
> > >
> > > But should we look for a CPU with less pressure  ?
> > >
> > > Another example:
> > > Task boosted to capacity_orig_of(medium_cpu) and there is pressure of
> > > this medium CPU. Shouldn't we look for another CPU either a medium
> > > without pressure or a big core if all mediums are under pressure ?
> >
> > Not if the *actual* utilization is small. As I tried to explain above uclamp
> > hints indicates performance level requirements, which will be achieved
> > regardless of the pressure. The only thing I'm worried about here is capacity
> 
> You seem to keep using the RT pressure in your example whereas I'm

I'm rather referring to this similar discussion for RT sched_class vs thermal
pressure, not RT pressure on the rq

	https://lore.kernel.org/lkml/20220420135127.o7ttm5tddwvwrp2a@airbuntu/

> more concerned by the thermal pressure as I mentioned previously. As
> an example the thermal pressure reflects the impact on the performance
> while task is running.

Like we discussed on that RT email thread. If you have a 1024 task, tiny
thermal pressure will make it look like it won't fit anywhere.

I think we can handle capacity inversion case only here in CFS. But like how
the discussion went on that RT thread, we need infrastructure to detect
capacity inversion case.

> 
> > inversion (like we saw for RT), but I think we need more infra structure to
> > handle that case. And as I tried to explain on the RT thread, you can't just
> > subtract thermal pressure because any tiny thermal pressure will mean 1024 hint
> > will always be false. I think this area in general needs to be better defined
> > and handled and I see it out of scope of these fixes.
> >
> > Generally EAS always looks for most energy efficient CPU with max spare
> > capacity. So least busy medium will be picked. And if the mediums are pressued
> > enough that adding this task will cause rq->util_avg to be high,
> > util_fits_cpu() will see that and return false because actual utilization will
> > be within the margin value and we should spell into the big cores then.
> >
> > If there's something simple to do now, I'll be happy to apply it. A simple
> > subtraction of thermal pressure from capacity_orig_of won't cut it.
> >
> > > Otherwise, uclamp_min can become somewhat meaningless because you will
> > > not have the requested min capacity when running. If you really want
> >
> > This can be only true if you interpret uclamp_min as bandwidth hint. Which as
> > I explained above is not what uclamp_min means. Or maybe I misread your words
> > :-)
> 
> TaskA usually runs 4 ms every 8ms but wants to ensure a running time
> around 5ms. Task A asks for a uclamp_min of 768.
> medium cpu capacity_orig is 800 but runs at half its max freq because
> of thermal mitigation then your task will runs more than 8ms

If thermal pressure is 50%, then capacity_of() is 400. A 50% task will have
util_avg of 512, which is much larger than 0.8 * 400. So this is dealt with
already in this code, no?

> 
> >
> > > your task to never go on big core, some cpu affinity would be a better
> > > way to achieve this
> >
> > I hope I cleared this up with my answers above. The actual bandwidth used by
> > the task and available by the CPU is not the same as the performance level.
> >
> > >
> > >
> > > > +        *
> > > > +        * Similarly if a task is capped to capacity_orig_of(little_cpu), it
> > > > +        * should fit a little cpu even if there's some pressure.
> > > > +        *
> > > > +        * Known limitation is when thermal pressure is severe to the point
> > > > +        * where we have capacity inversion. We don't cater for that as the
> > > > +        * system performance will already be impacted severely.
> > > > +        */
> > > > +       capacity_orig = capacity_orig_of(cpu);
> > > > +
> > > > +       /*
> > > > +        * We want to force a task to fit a cpu as implied by uclamp_max.
> > > > +        * But we do have some corner cases to cater for..
> > > > +        *
> > > > +        *
> > > > +        *                                 C=z
> > > > +        *   |                             ___
> > > > +        *   |                  C=y       |   |
> > > > +        *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _  uclamp_max
> > > > +        *   |      C=x        |   |      |   |
> > > > +        *   |      ___        |   |      |   |
> > > > +        *   |     |   |       |   |      |   |    (util somewhere in this region)
> > > > +        *   |     |   |       |   |      |   |
> > > > +        *   |     |   |       |   |      |   |
> > > > +        *   +----------------------------------------
> > > > +        *         cpu0        cpu1       cpu2
> > > > +        *
> > > > +        *   In the above example if a task is capped to a specific performance
> > > > +        *   point, y, then when:
> > > > +        *
> > > > +        *   * util = 80% of x then it does not fit on cpu0 and should migrate
> > > > +        *     to cpu1
> > > > +        *   * util = 80% of y then it is forced to fit on cpu1 to honour
> > > > +        *     uclamp_max request.
> > > > +        *
> > > > +        *   which is what we're enforcing here. A task always fits if
> > > > +        *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> > > > +        *   the normal upmigration rules should withhold still.
> > > > +        *
> > > > +        *   Only exception is when we are on max capacity, then we need to be
> > > > +        *   careful not to block overutilized state. This is so because:
> > > > +        *
> > > > +        *     1. There's no concept of capping at max_capacity! We can't go
> > > > +        *        beyond this performance level anyway.
> > > > +        *     2. The system is being saturated when we're operating near
> > > > +        *        max_capacity, it doesn't make sense to block overutilized.
> > > > +        */
> > > > +       max_capacity = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > >
> > > Is this intermediate variable max_capacity really needed ?
> >
> > I thought it helps with readability and breaks down an otherwise a very long
> > line. Is it harmful?
> 
> uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) &&
> (uclamp_max == SCHED_CAPACITY_SCALE);
> uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> 
> Is the above less readable ?

Ah I see, I thought you want to combine it all in one line.

I can change it I guess. I just think it gives the check a meaningful name and
compiler will toss the variable away anyway.


Cheers

--
Qais Yousef

> 
> Vincent
> >
> >
> > Thanks!
> >
> > --
> > Qais Yousef
> >
> > >
> > > > +       uclamp_max_fits = !max_capacity && (uclamp_max <= capacity_orig);
> > > > +       fits = fits || uclamp_max_fits;
> > > > +
> > > > +       /*
> > > > +        *
> > > > +        *                                 C=z
> > > > +        *   |                             ___       (region a, capped, util >= uclamp_max)
> > > > +        *   |                  C=y       |   |
> > > > +        *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _ uclamp_max
> > > > +        *   |      C=x        |   |      |   |
> > > > +        *   |      ___        |   |      |   |      (region b, uclamp_min <= util <= uclamp_max)
> > > > +        *   |_ _ _|_ _|_ _ _ _| _ | _ _ _| _ | _ _ _ _ _ uclamp_min
> > > > +        *   |     |   |       |   |      |   |
> > > > +        *   |     |   |       |   |      |   |      (region c, boosted, util < uclamp_min)
> > > > +        *   +----------------------------------------
> > > > +        *         cpu0        cpu1       cpu2
> > > > +        *
> > > > +        * a) If util > uclamp_max, then we're capped, we don't care about
> > > > +        *    actual fitness value here. We only care if uclamp_max fits
> > > > +        *    capacity without taking margin/pressure into account.
> > > > +        *    See comment above.
> > > > +        *
> > > > +        * b) If uclamp_min <= util <= uclamp_max, then the normal
> > > > +        *    fits_capacity() rules apply. Except we need to ensure that we
> > > > +        *    enforce we remain within uclamp_max, see comment above.
> > > > +        *
> > > > +        * c) If util < uclamp_min, then we are boosted. Same as (b) but we
> > > > +        *    need to take into account the boosted value fits the CPU without
> > > > +        *    taking margin/pressure into account.
> > > > +        *
> > > > +        * Cases (a) and (b) are handled in the 'fits' variable already. We
> > > > +        * just need to consider an extra check for case (c) after ensuring we
> > > > +        * handle the case uclamp_min > uclamp_max.
> > > > +        */
> > > > +       uclamp_min = min(uclamp_min, uclamp_max);
> > > > +       if (util < uclamp_min)
> > > > +               fits = fits && (uclamp_min <= capacity_orig);
> > > > +
> > > > +       return fits;
> > > > +}
> > > > +
> > > >  static inline int task_fits_capacity(struct task_struct *p,
> > > >                                      unsigned long capacity)
> > > >  {
> > > > --
> > > > 2.25.1
> > > >
