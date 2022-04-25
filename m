Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB450E54C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbiDYQPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbiDYQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:15:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A712119EC1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:12:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5EF31FB;
        Mon, 25 Apr 2022 09:12:23 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AD7B3F774;
        Mon, 25 Apr 2022 09:12:22 -0700 (PDT)
Date:   Mon, 25 Apr 2022 17:12:09 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Message-ID: <20220425161209.ydugtrs3b7gyy3kk@airbuntu>
References: <20220407051932.4071-1-xuewen.yan@unisoc.com>
 <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
 <20220421161509.asz25zmh25eurgrk@airbuntu>
 <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/22 09:31, Xuewen Yan wrote:
> On Fri, Apr 22, 2022 at 12:15 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > Is it okay to share what the capacities of the littles, mediums and bigs on
> > your system? And how they change under worst case scenario thermal pressure?
> > Only IF you have these numbers handy :-)
> 
> Okay, the little/mid/big cpu scale capacity is 350/930/1024, but the
> cpu frequency point is discrete, the big core's high freq point may is
> just a few more than the mid core's highest.
> In this case, once the thermal decrease the scaling_max_freq, the
> maximum frequency of the large core is easily lower than that of the
> medium core.
> Of course, the corner case is due to the frequency design of the soc
> and  our thermal algorithm.

Okay, thanks for the info!

> 
> >
> > Is it actually an indication of a potential other problem if you swing into
> > capacity inversion in the bigs that often? I've seen a lot of systems where the
> > difference between the meds and bigs is small. But frequent inversion could be
> > suspicious still.
> >
> > Do the littles and the mediums experience any significant thermal pressure too?
> 
> In our platform, it's not.

Good.

> > It doesn't seem it'll cause a significant error, but still it seems to me this
> > function wants the original capacity passed to it.
> >
> > There are similar questions to be asked since you modify sg_cpu->max. Every
> > user needs to be audited if they're fine with this change or not.
> >
> > I'm not sure still what we are achieving here. You want to force schedutil not
> > to request higher frequencies if thermal pressure is high? Should schedutil
> > actually care? Shouldn't the cpufreq driver reject this request and pick the
> > next best thing if it can't satisfy it? I could be missing something, I haven't
> > looked that hard tbh :-)
> 
> I changed this just want to make it more responsive to the real
> capacity of the cpu, if it will cause other problems, maybe it would
> be better not to change it.:)

There are others who can give you a better opinion. But AFAICS we're not fixing
anything but risking breaking other things. So I vote for not to change it :)

> > It depends on the severity of the problem. The simplest thing I can suggest is
> > to check if the cpu is in capacity inversion state, and if it is, then make
> > rt_task_fits_capacity() return false always.
> >
> > If we need a generic solution to handle thermal pressure omitting OPPs, then
> > the search needs to become more complex. The proposal in this patch is not
> > adequate because tasks that want to run at capacity_orig_of(cpu) will wrongly
> > omit some cpus because of any tiny thermal pressure. For example if the
> > capacity_orig_of(medium_cpu) = 700, and uclamp_min for RT is set to 700, then
> > any small thermal pressure on mediums will cause these tasks to run on big cpus
> > only, which is not what we want. Especially if these big cpus can end up in
> > capacity inversion later ;-)
> >
> > So if we want to handle this case, then we need to ensure the search returns
> > false only if
> >
> >         1. Thermal pressure results in real OPP to be omitted.
> >         2. Another CPU that can provide this performance level is available.
> >
> > Otherwise we should still fit it on this CPU because it'll give us the closest
> > thing to what was requested.
> >
> > I can think of 2 ways to implement this, but none of them seem particularly
> > pretty :-/
> 
> Maybe as Lukasz Luba said:
> 
> https://lore.kernel.org/all/ae98a861-8945-e630-8d4c-8112723d1007@arm.com/
> 
> > Let's meet in the middle:
> > 1) use the thermal PELT signal in RT:
> > capacity = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu))
> > 2) introduce a more configurable thermal_pressure shifter instead
> > 'sched_thermal_decay_shift', which would allow not only to make the
> > decaying longer, but also shorter when the platform already might do
> > that, to not cause too much traffic.
> 
> But even if this is changed, there will still be the same problem, I
> look forward to Lukasz's patch:)

This will not address my concern unless I missed something.

The best (simplest) way forward IMHO is to introduce a new function

	bool cpu_in_capacity_inversion(int cpu);

(feel free to pick another name) which will detect the scenario you're in. You
can use this function then in rt_task_fits_capacity()

	diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
	index a32c46889af8..d48811a7e956 100644
	--- a/kernel/sched/rt.c
	+++ b/kernel/sched/rt.c
	@@ -462,6 +462,9 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
		if (!static_branch_unlikely(&sched_asym_cpucapacity))
			return true;

	+       if (cpu_in_capacity_inversion(cpu))
	+               return false;
	+
		min_cap = uclamp_eff_value(p, UCLAMP_MIN);
		max_cap = uclamp_eff_value(p, UCLAMP_MAX);

You'll probably need to do something similar in dl_task_fits_capacity().

This might be a bit aggressive though as we'll steer away all RT tasks from
this CPU (as long as there's another CPU that can fit it). I need to think more
about it. But we could do something like this too

	diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
	index a32c46889af8..f2a34946a7ab 100644
	--- a/kernel/sched/rt.c
	+++ b/kernel/sched/rt.c
	@@ -462,11 +462,14 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
		if (!static_branch_unlikely(&sched_asym_cpucapacity))
			return true;
	 
	+       cpu_cap = capacity_orig_of(cpu);
	+
	+       if (cpu_in_capacity_inversion(cpu))
	+               cpu_cap -= thermal_load_avg(cpu_rq(cpu));
	+
		min_cap = uclamp_eff_value(p, UCLAMP_MIN);
		max_cap = uclamp_eff_value(p, UCLAMP_MAX);
	 
	-       cpu_cap = capacity_orig_of(cpu);
	-
		return cpu_cap >= min(min_cap, max_cap);
	 }
	 #else

Thoughts?


Thanks!

--
Qais Yousef
