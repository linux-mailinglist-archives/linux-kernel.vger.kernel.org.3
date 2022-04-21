Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC350A5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiDUQ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiDUQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:18:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 539AD101C7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:15:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D885153B;
        Thu, 21 Apr 2022 09:15:16 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 728203F73B;
        Thu, 21 Apr 2022 09:15:14 -0700 (PDT)
Date:   Thu, 21 Apr 2022 17:15:09 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Message-ID: <20220421161509.asz25zmh25eurgrk@airbuntu>
References: <20220407051932.4071-1-xuewen.yan@unisoc.com>
 <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21/22 16:07, Xuewen Yan wrote:
> Hi Qais
> 
> On Wed, Apr 20, 2022 at 9:51 PM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > Hi Xuewen
> >
> > Thanks for sending the patch. RT relationship with thermal pressure is an
> > interesting topic :)
> >
> > On 04/07/22 13:19, Xuewen Yan wrote:
> > > There are cases when the cpu max capacity might be reduced due to thermal.
> > > Take into the thermal pressure into account when judge whether the rt task
> > > fits the cpu. And when schedutil govnor get cpu util, the thermal pressure
> > > also should be considered.
> >
> > It would help to explain the mode of failure you're seeing here. What are you
> > seeing?
> 
> I used in Android scenario, there are many RT processes in the
> Android. I do not want to set the sched_uclamp_util_min_rt_default to
> 1024, it would make the power consumption very high.
> I used a compromise method, setting the value of
> sysctl_sched_uclamp_util_min_rt_default to be bigger than the small
> core capacity but not so that the frequency of the big core becomes
> very high.
> But when there are there clusters on the soc, the big core's capacity
> often become smaller than the middle core, when this happens, I want
> the RT can run on the middle cores instead of the on the big core
> always.
> When consider the thermal pressure, it could relieve this phenomenon.

Thanks for the explanation. It's worth putting some of this in the changelog in
the next versions.

So the problem is as I suspected, but capacity inversion is the major cause of
grief.

Is it okay to share what the capacities of the littles, mediums and bigs on
your system? And how they change under worst case scenario thermal pressure?
Only IF you have these numbers handy :-)

Is it actually an indication of a potential other problem if you swing into
capacity inversion in the bigs that often? I've seen a lot of systems where the
difference between the meds and bigs is small. But frequent inversion could be
suspicious still.

Do the littles and the mediums experience any significant thermal pressure too?

> >
> > >
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > ---
> > >  kernel/sched/cpufreq_schedutil.c | 1 +
> > >  kernel/sched/rt.c                | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 3dbf351d12d5..285ad51caf0f 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> > >       struct rq *rq = cpu_rq(sg_cpu->cpu);
> > >       unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> > >
> > > +     max -= arch_scale_thermal_pressure(sg_cpu->cpu);
> >
> > Wouldn't this break the call to irq_scale_capacity() in effective_cpu_util()?
> >
> > >       sg_cpu->max = max;
> > >       sg_cpu->bw_dl = cpu_bw_dl(rq);
> > >       sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu), max,
> 
> It would destory the irq_scale_capacity, but indeed the cpu max
> capacity has changed, is it better to use the real cpu caopacity?
> 
>                           max - irq
>             U' = irq + --------- * U
>                            max
> I can't imagine how much of an impact this will have at the moment.

It doesn't seem it'll cause a significant error, but still it seems to me this
function wants the original capacity passed to it.

There are similar questions to be asked since you modify sg_cpu->max. Every
user needs to be audited if they're fine with this change or not.

I'm not sure still what we are achieving here. You want to force schedutil not
to request higher frequencies if thermal pressure is high? Should schedutil
actually care? Shouldn't the cpufreq driver reject this request and pick the
next best thing if it can't satisfy it? I could be missing something, I haven't
looked that hard tbh :-)

> 
> > > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > > index a32c46889af8..d9982ebd4821 100644
> > > --- a/kernel/sched/rt.c
> > > +++ b/kernel/sched/rt.c
> > > @@ -466,6 +466,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> > >       max_cap = uclamp_eff_value(p, UCLAMP_MAX);
> > >
> > >       cpu_cap = capacity_orig_of(cpu);
> > > +     cpu_cap -= arch_scale_thermal_pressure(cpu);
> >
> > Hmm I'm not a fan of this. By default all RT tasks have uclamp_min = 1024 to
> > keep the default behavior of the system running at max performance point.
> >
> > With this change, any tiny thermal pressure means all RT tasks will fail to fit
> > on the biggest CPU. While this hint is not meant to be bullet proof, but it
> > shouldn't break that easily either. The highest performance point will still be
> > on this CPU. The only exception is capacity inversion where the bigs
> > performance goes below the mediums' under severe thermal circumstances. But
> > then there are 2 issues.
> >
> >         1. This patch doesn't help with this case. It simply reverts to putting
> >            tasks 'randomly' and  might still end up on this CPU. I can't see
> >            how this is better.
> >         2. If we are under such severe thermal pressure, then things must be
> >            falling over badly anyway and I'm not sure we can still satisfy the
> >            perf requirements these tasks want anyway. Unless you're trying to
> >            keep these CPUs less busy to alleviate thermal pressure? This patch
> >            will not help achieving that either. Or I'm unable to see it if it
> >            does.
> 
> Yes，It is the problem that would lead to, maybe it need more
> consideration just like select the cpus which have min overutil.

It depends on the severity of the problem. The simplest thing I can suggest is
to check if the cpu is in capacity inversion state, and if it is, then make
rt_task_fits_capacity() return false always.

If we need a generic solution to handle thermal pressure omitting OPPs, then
the search needs to become more complex. The proposal in this patch is not
adequate because tasks that want to run at capacity_orig_of(cpu) will wrongly
omit some cpus because of any tiny thermal pressure. For example if the
capacity_orig_of(medium_cpu) = 700, and uclamp_min for RT is set to 700, then
any small thermal pressure on mediums will cause these tasks to run on big cpus
only, which is not what we want. Especially if these big cpus can end up in
capacity inversion later ;-)

So if we want to handle this case, then we need to ensure the search returns
false only if

	1. Thermal pressure results in real OPP to be omitted.
	2. Another CPU that can provide this performance level is available.

Otherwise we should still fit it on this CPU because it'll give us the closest
thing to what was requested.

I can think of 2 ways to implement this, but none of them seem particularly
pretty :-/


Thanks

--
Qais Yousef
