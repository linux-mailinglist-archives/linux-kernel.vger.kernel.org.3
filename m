Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6358B582A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiG0QIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiG0QIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:08:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 199804AD72
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:08:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71EA7113E;
        Wed, 27 Jul 2022 09:08:43 -0700 (PDT)
Received: from wubuntu (unknown [10.57.12.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D54F3F73B;
        Wed, 27 Jul 2022 09:08:41 -0700 (PDT)
Date:   Wed, 27 Jul 2022 17:08:39 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 1/7] sched/uclamp: Fix relationship between uclamp and
 migration margin
Message-ID: <20220727160839.ahtyp552dw73sddf@wubuntu>
References: <20220629194632.1117723-2-qais.yousef@arm.com>
 <CAKfTPtBAOLzYocTEg3KErACSyrAWDU94NdR7EAOnW0gti2GiDQ@mail.gmail.com>
 <20220712102334.6nwkbkilmmup4h4u@wubuntu>
 <CAKfTPtDweeQDRcZb+_ANO6rzZd11vbiatoVxDNwsWPtoCTG+AQ@mail.gmail.com>
 <20220712142013.j6fy77yejupvllah@wubuntu>
 <CAKfTPtB3pjoFWFP9E6RnH87nshEqJxPdFzX495R_Xju9rCPvEw@mail.gmail.com>
 <20220715103738.ufqv2nhkivlhzy7v@wubuntu>
 <CAKfTPtAXvP-v+A+PgzMAMqqaffxFp+sUuA4NnMDuF91XCSTrVQ@mail.gmail.com>
 <20220721140431.cl73bhn6ydzdhdkm@wubuntu>
 <20220722151300.GA30193@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220722151300.GA30193@vingu-book>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22/22 17:13, Vincent Guittot wrote:
> Le jeudi 21 juil. 2022 ï¿½ 15:04:31 (+0100), Qais Yousef a ï¿½crit :
> > On 07/20/22 09:29, Vincent Guittot wrote:
> > > On Fri, 15 Jul 2022 at 12:37, Qais Yousef <qais.yousef@arm.com> wrote:
> > > >
> > > > On 07/13/22 14:39, Vincent Guittot wrote:
> > > >
> > > > [...]
> > > >
> > > > > > > That's why I have mentioned that I have thermal pressure and irq in
> > > > > > > mind. I'm speaking about performance level but not about bandwidth and
> > > > > > > time sharing.
> > > > > >
> > > > > > irq pressure has no impact on the cpu's ability to get any OPP, no? It purely
> > > > > > reduces the bandwidth availability for CFS tasks AFAIU. So the task's ability
> > > > > > to achieve a performance level has no correlation with irq pressure IMO. Unless
> > > > > > I missed something.
> > > > >
> > > > > The way irq is accounted in pelt might impact the result. TBH, i
> > > > > haven't looked in details what would be the impact
> > > >
> > > > I can't see how irq can impact what performance level we can achieve on any
> > > > CPU. It should just impact bandwidth?
> > > 
> > > It impacts the cpu and task utilization as your task utilization is
> > > expressed in the range of the time not used by IRQ so could be lower
> > > than what you think when you compare with uclamp and decide what to do
> > 
> > I need more helping hand to understand please.
> > 
> > So for the case of uclamp_min = 1024, this request means:
> > 
> > 	When I run, I want to run at max performance point of the system.
> > 
> > Which translates into running at highest frequency on SMP, and highest
> > frequency + biggest CPU on HMP.
> > 
> > If a CPU has irq pressure, how this will prevent the task from running at
> > highest frequency? What am I missing?
> 
> I was thinking of the case of uclamp_min not being 1024. But the real
> task util_avg (ie including the impact of irq pressure) will be always
> lower than the task clock version so the comparison with uclamp_min will
> always be satisfied.

We discussed this offline and for the benefits of the others you are referring
to this comparison:

	if (util < uclamp_min)

rather than the comparison:

	uclamp_min <= capacity_orig

I was thinking you're referring to. Both of which are at the end of the
util_fits_cpu() function:

	if (util < uclamp_min)
		fits = fits && (uclamp_min <= capacity_orig);

IIUC, we agreed there's actually no problem in regard of irq pressure. Let me
know if I am still misunderstanding :-)

> 
> > 
> > I am assuming that the task is actually small so it will never be able to run
> > at max frequency without this hint, ie: util_avg = 300.
> > 
> > Keep in mind that util_fits_cpu() still verifies that util_avg is within the
> > 80% range of capacity_of() which takes into account all types of pressures.
> > 
> > > 
> > > >
> > > > [...]
> > > >
> > > > > > > more concerned by the thermal pressure as I mentioned previously. As
> > > > > > > an example the thermal pressure reflects the impact on the performance
> > > > > > > while task is running.
> > > > > >
> > > > > > Like we discussed on that RT email thread. If you have a 1024 task, tiny
> > > > > > thermal pressure will make it look like it won't fit anywhere.
> > > > >
> > > > > maybe another big core without pressure. Otherwise if the task can
> > > >
> > > > Isn't thermal pressure per perf domain?
> > > 
> > > From a scheduler PoV, we don't have any rule on this
> > > 
> > > >
> > > > > accept a lower compute capacity why not setting uclamp_min to a lower
> > > > > value like 900
> > > >
> > > > Well if the system has lost its top 10% and you're still running as fast as
> > > > the system can possibly do, what better can you do?
> > > >
> > > > I can't see how comparing uclamp with thermal pressure will help.
> > > >
> > > > In feec() we pick the highest spare capacity CPU. So if the bigs were split
> > > > into 1 per perf domain and truly one of them can become severely throttled
> > > > while the other isn't as you're trying to say, then this distribution will pick
> > > > the highest spare capacity one.
> > > 
> > > The cpu with highest spare capacity might not be the one with highest
> > > performance
> > 
> > True. But all of this is best effort. And I think this is good enough for the
> > common case. I don't mind addressing the thermal problem, but it's not a simple
> > one. And there's a complexity cost that is AFAICS is high.
> > 
> 
> Using capacity_orig_of(cpu) - thermal_load_avg(rq_of(cpu)) seems like
> a simple solution to cover thermal mitigation

It depends on the PoV I'd say. It is whack-a-mole at the moment.

Either way we'll have to improve somehow later. But to make sure we have the
rules cleared up:

	* uclamp_max will always ignore thermal pressure.
	* uclamp_min will consider thermal pressure.

I am not keen on using the thermal_load_avg() as well. It has a long tail that
Lukasz measured in 10s of ms while the actual OPP is in fact available.

Wouldn't it be better to consider instantaneous thermal pressure of
uclamp_min? thermal_load_avg() comparison with util_avg make sense. But
uclamp_min which just needs to check if the performance level is available or
not, the instantaneous one is better IMO.

See below for why uclamp_max should ignore thermal pressure.

> 
> Also I was looking more deeply at your condition and get hard time to
> understand why uclamp_max_fits needs to be false when both
> (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE) ?

It's actually a 'don't care' condition. What we are saying here is that under
these conditions the result should depend only on fits_capacity() result.

Mainly here to ensure we don't prevent overutilized from NEVER triggering  by
default.

> 
> +       max_capacity = (capacity_orig == SCHED_CAPACITY_SCALE) &&
> (uclamp_max == SCHED_CAPACITY_SCALE);
> +       uclamp_max_fits = !max_capacity && (uclamp_max <= capacity_orig);
> +       fits = fits || uclamp_max_fits;
> 
> For task I would have done only :
> 
> +       capacity_orig = capacity_orig_of(cpu) - thermal_load_avg(rq_of(cpu));
> +       uclamp_max_fits = (uclamp_max <= capacity_orig);
>        fits = fits || uclamp_max_fits;

Taking thermal pressure for uclamp_max will break the task placement hint (weak
affinity property). One of the main use cases is to keep background tasks on
little cores even when they're busy tasks. I can understand your argument for
uclamp_min as ignoring thermal pressure is ignoring min performance requirement
to some extent. But taking it for uclamp_max can lead to ignoring the max
performance requirement. ie: allowing it to migrate to a bigger CPU where it
can potentially run at a much higher performance level.

Because of max-aggregation rule, if a task

	p0->util_avg = 500
	p0->uclamp_max = 300

is sharing the rq with

	p1->util_avg = 50
	p1->uclamp_max = 1024

then p1 will cause the CPU to run at

	rq->util_avg = 550

we need to keep p0 on the smallest fitting CPU for it to be *more* effective
hint.

There's room for more improvements in this regard that hopefully I'll be
sending another patch series later to address. But from fits_capacity() PoV,
I think thermal pressure shouldn't impact uclamp_max as it's an upper limit and
it's okay if we get slightly below.

> 
> and I would use a different one for cpu_overutlized in orde to discard the test
> with uclamp_max if uclamp_max one equals SCHED_CAPACITY_SCALE
> 
> +       uclamp_max_fits = (uclamp_max <= capacity_orig) && (uclamp_max != SCHED_CAPACITY_SCALE);

I need to think more about it, but I think this is doable. Not sure if
necessary. I liked keeping the logic encapsulated in one function.

I'll probably go with that, but will report back if I find something else when
working on v2.

> 
> and I don't think that we should compare uclamp_min <= capacity_orig for
> cpu_overutlized() but only for task to detect misfit one because uclamp_min is
> a performance hint not a bandwidth as you said previously.

In principle, yes. But AFAIK we can't trigger misfit migration without setting
overutilized?

If we start considering thermal pressure for uclamp_min, then we need to be
careful as we could 'accidentally' trigger overutilized if thermal pressure is
a little bit high on the big core. We must suppress this scenarios unless we're
in capacity inversion.

I had something simple to detect capacity inversion for cfs

	https://lore.kernel.org/lkml/20220503144352.lxduzhl6jq6xdhw2@airbuntu/

might go for something like this and see how we can improve in v2 discussion

when comparing against capacity_orig_of() we could never trigger overutilized
on big CPU as uclamp_min will always fit on big cpus. But with thermal
pressure taken into account, it becomes possible for uclamp_min = 1024 task to
trigger overutilized.

> 
> > > 
> > > >
> > > > fits_capacity() just says this CPU is a candidate that we can consider.
> > > >
> > > > [...]
> > > >
> > > > > > > TaskA usually runs 4 ms every 8ms but wants to ensure a running time
> > > > > > > around 5ms. Task A asks for a uclamp_min of 768.
> > > > > > > medium cpu capacity_orig is 800 but runs at half its max freq because
> > > > > > > of thermal mitigation then your task will runs more than 8ms
> > > > > >
> > > > > > If thermal pressure is 50%, then capacity_of() is 400. A 50% task will have
> > > > > > util_avg of 512, which is much larger than 0.8 * 400. So this is dealt with
> > > > > > already in this code, no?
> > > > >
> > > > > May be my example is not perfect but apply a mitigation of 20% and you
> > > > > fall in the case
> > > >
> > > >         capacity_orig_of(medium) = 800
> > > >         capacity_of(medium) = 800 * 0.8 - sum_of_(irq, rt) pressure :: <= 640
> > > >
> > > >         migration_margin * capacity_of(medium) = 0.8 * 640 = 512 === p->util_avg
> > > >
> > > > So this task will struggle still to run on the medium even under 20% pressure.
> > > 
> > > you are nitpicking. 19.75% should be ok
> > 
> > I was just trying to highlight it took a bit of effort to reach to the corner
> > case. Which indicates the corner case is specific.
> 
> hmmm 19%.75% is not a corner case, i was just lazy to compute the exact number
> 
> > 
> > > 
> > > >
> > > > I can see your point for sure that we could have scenarios where we should pick
> > > > a bigger CPU. But my counter point is that if there's a meaningful thermal
> > > > pressure we are screwed already and uclamp can't save the day.
> > > 
> > > uclamp can save it by triggering the search of another cpu with lower pressure
> > 
> > How would you do that?
> > 
> > If a task hints towards uclamp_min = 1024. If there's 1% pressure on all cpus,
> > is triggering overutilized right? What's tripping me off is how would you do
> > that fallback gracefully?
> > 
> 
> As proposed above, you should use different rules for cpu_overutilized
> and task fits cpus to make a difference beteen overutlized cpu and misfit task

I'm not sure if we can separate them yet because misfit migration requires both
conditions to be true. But I've done too much multi-tasking already this week.
I'll look at this more closely as I work on v2 in case I missed something.


Thanks!

--
Qais Yousef
