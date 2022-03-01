Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471E04C90E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiCAQtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbiCAQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:47:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDF1F41334;
        Tue,  1 Mar 2022 08:47:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C2DF1042;
        Tue,  1 Mar 2022 08:47:00 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BF2A3F73D;
        Tue,  1 Mar 2022 08:47:00 -0800 (PST)
Date:   Tue, 1 Mar 2022 16:46:58 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] arch_topology: obtain cpu capacity using
 information from CPPC
Message-ID: <Yh5OAsYVBWWko+CH@arm.com>
References: <20210824105651.28660-1-ionela.voinescu@arm.com>
 <20210824105651.28660-3-ionela.voinescu@arm.com>
 <CAJZ5v0hkgWQqOzfdv4kr6rxz9eMsOgHkMYj0cZpO7yC+=SnQfg@mail.gmail.com>
 <20210826175138.GA22165@arm.com>
 <CAJZ5v0i9Ys67E8TvWzJG+NaODKsEMsJiHrF9KM77Lk4L-3OOsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i9Ys67E8TvWzJG+NaODKsEMsJiHrF9KM77Lk4L-3OOsA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Apologies for the delay.

On Thursday 26 Aug 2021 at 20:32:52 (+0200), Rafael J. Wysocki wrote:
> On Thu, Aug 26, 2021 at 7:51 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >
> > Thanks for the review, Rafael!
> >
> > On Wednesday 25 Aug 2021 at 19:54:26 (+0200), Rafael J. Wysocki wrote:
> > > On Tue, Aug 24, 2021 at 12:57 PM Ionela Voinescu
> > > <ionela.voinescu@arm.com> wrote:
> > > >
> > > > Define topology_init_cpu_capacity_cppc() to use highest performance
> > > > values from _CPC objects to obtain and set maximum capacity information
> > > > for each CPU. acpi_cppc_processor_probe() is a good point at which to
> > > > trigger the initialization of CPU (u-arch) capacity values, as at this
> > > > point the highest performance values can be obtained from each CPU's
> > > > _CPC objects. Architectures can therefore use this functionality
> > > > through arch_init_invariance_cppc().
> > > >
> > > > The performance scale used by CPPC is a unified scale for all CPUs in
> > > > the system. Therefore, by obtaining the raw highest performance values
> > > > from the _CPC objects, and normalizing them on the [0, 1024] capacity
> > > > scale, used by the task scheduler, we obtain the CPU capacity of each
> > > > CPU.
> > > >
> > > > While an ACPI Notify(0x85) could alert about a change in the highest
> > > > performance value, which should in turn retrigger the CPU capacity
> > > > computations, this notification is not currently handled by the ACPI
> > > > processor driver. When supported, a call to arch_init_invariance_cppc()
> > > > would perform the update.
> > > >
> > > > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > > Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  drivers/base/arch_topology.c  | 37 +++++++++++++++++++++++++++++++++++
> > > >  include/linux/arch_topology.h |  4 ++++
> > > >  2 files changed, 41 insertions(+)
> > > >
> > > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > > > index 921312a8d957..358e22cd629e 100644
> > > > --- a/drivers/base/arch_topology.c
> > > > +++ b/drivers/base/arch_topology.c
> > > > @@ -306,6 +306,43 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> > > >         return !ret;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_ACPI_CPPC_LIB
> > > > +#include <acpi/cppc_acpi.h>
> > > > +
> > > > +void topology_init_cpu_capacity_cppc(void)
> > > > +{
> > > > +       struct cppc_perf_caps perf_caps;
> > > > +       int cpu;
> > > > +
> > > > +       if (likely(acpi_disabled || !acpi_cpc_valid()))
> > > > +               return;
> > > > +
> > > > +       raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
> > > > +                              GFP_KERNEL);
> > > > +       if (!raw_capacity)
> > > > +               return;
> > > > +
> > > > +       for_each_possible_cpu(cpu) {
> > > > +               if (!cppc_get_perf_caps(cpu, &perf_caps)) {
> > > > +                       raw_capacity[cpu] = perf_caps.highest_perf;
> > >
> > > From experience, I would advise doing some sanity checking on the
> > > per_caps values before using them here.
> > >
> >
> > cppc_get_perf_caps() already returns -EFAULT if highest_perf is 0, and
> > I'm not sure if I can make any other assumptions about what a sane
> > highest_perf value would need to be here.
> 
> Well, it cannot be less than lowest_perf or nominal_perf or
> guaranteed_perf, for instance.
> 

True! I'll push a v3 with this change tomorrow, after I rebase and
re-test on 5.17-rc6.

I've not checked for guaranteed performance as according to the
specification it's optional and it's designed to be between lowest_perf and
nominal_perf. If guaranteed performance is/will be used anywhere, it should
have its own validation against lower/nominal/highest.

Therefore I think checking that we have a highest_perf value higher or equal
to both nominal_perf and lowest_perf is the right balance in validation.

> > Did you have anything else in mind for sanity checking?
> >
> > > Also note that highest_perf may not be sustainable, so would using
> > > highest_perf as raw_capacity[] always work as expected?
> > >
> >
> > Yes, in my opinion using it is better than the alternative, using the
> > nominal performance value. This highest performance value helps obtain
> > the maximum capacity of a CPU on a scale [0, 1024] when referenced to
> > the highest performance of the biggest CPU in the system. There is no
> > assumption in the task scheduler that this capacity is sustainable.
> 
> That's true, but there are consequences if it is the case.  Namely,
> you may find that the big CPUs run at the highest performance for a
> small fraction of time, so most of the time they may appear to be
> underutilized no matter how many tasks are packed on them, which then
> will influence the utilization metrics of those tasks.
> 

Yes, there are no perfect solutions, and whether one exposes nominal or
highest performance there will be consequences. But I think the task
scheduler has progressed to cope better with unavailable capacity.

For example, after the PELT changes at [1], CPUs won't seem underutilized
if they are always running, even if they are not running at the highest
frequency. Before these changes to PELT, the utilization of a CPU was
capped to the current capacity of the CPU. So in that case, if the
nominal_perf was 70% of highest_perf and the CPU was only running at
nominal_freq, its utilization could not exceed 716 (big CPU). But after
[1] if the CPU had no idle time, it does exceed 716 and could be marked
as overutilized. That utilization doesn't really have a meaning (we
don't know how utilized the CPU would have been if it would have run at
boosted frequencies) but it does not have to, as long as it signals the
need of an action: migrate tasks to another CPU, possibly disable EAS.

[1]
https://lore.kernel.org/lkml/tip-23127296889fe84b0762b191b5d041e8ba6f2599@git.kernel.org/

> It may be better to use guaranteed_perf or some value between it at
> the highest for this reason.
> 

Guaranteed performance is a tricky one:
"
Guaranteed Performance Register conveys to OSPM a Guaranteed Performance
level, which is the current maximum sustained performance level of a
processor, taking into account all known external constraints (power
budgeting, thermal constraints, AC vs DC power source, etc.). All
processors are expected to be able to sustain their guaranteed
performance levels simultaneously. The guaranteed performance level is
required to fall in the range [Lowest Performance, Nominal performance],
inclusive.
"

In my experience everyone interprets this differently and therefore
platform providers could populate this vastly differently. One could
argue that the only true guaranteed performance is the lowest
performance as it's the only one potentially sustainable under any power
and especially thermal conditions. As well one could argue that it could
be closer or equal to nominal performance, but that is the case only if
one considers thermal effects unlikely. Therefore it may be that it's
highly unreliable as a generic source of capacity information.


Therefore, I'm still leaning towards keeping the use of highest_perf in
this case due to the scheduler's ability to cope with unavailable
capacity but also because it reflects better u-arch differences between
CPUs.

Thank you,
Ionela.

> > Using lower values (nominal performance) would shorten the scale and
> > make smaller CPUs seem bigger than they are. Also, using highest
> > performance gives a better indication of micro-architectural
> > differences in performance between CPUs, which plays a role in scaling
> > utilization, even if some of the performance levels are not sustainable
> > (which is platform dependent).
