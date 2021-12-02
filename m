Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC14667AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359356AbhLBQRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:17:30 -0500
Received: from foss.arm.com ([217.140.110.172]:37252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359197AbhLBQR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:17:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A24C8142F;
        Thu,  2 Dec 2021 08:14:05 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BE813F73B;
        Thu,  2 Dec 2021 08:14:04 -0800 (PST)
Date:   Thu, 2 Dec 2021 16:14:01 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH v2 8/8] drivers/perf: Add Apple icestorm/firestorm CPU
 PMU driver
Message-ID: <Yajwydy37psEPaS2@lakrids>
References: <20211201134909.390490-1-maz@kernel.org>
 <20211201134909.390490-9-maz@kernel.org>
 <YaepolizIKkzDQoV@FVFF77S0Q05N>
 <877dcnm2wt.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dcnm2wt.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:39:46PM +0000, Marc Zyngier wrote:
> On Wed, 01 Dec 2021 16:58:10 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > On Wed, Dec 01, 2021 at 01:49:09PM +0000, Marc Zyngier wrote:
> > > Add a new, weird and wonderful driver for the equally weird Apple
> > > PMU HW. Although the PMU itself is functional, we don't know much
> > > about the events yet, so this can be considered as yet another
> > > random number generator...
> > 
> > It's really frustrating that Apple built this rather than the
> > architected PMU, because we've generally pushed back on
> > IMPLEMENTATION DEFINED junk in this area, and supporting this makes
> > it harder to push back on other vendors going the same route, which
> > I'm not keen on. That, and the usual state of IMP-DEF stuff making
> > this stupidly painful to reason about.
> 
> As much as I agree with you on the stinking aspect of an IMPDEF PMU,
> this doesn't contradicts the architecture. To avoid the spread of this
> madness, forbidding an IMPDEF implementation in the architecture would
> be the right thing to do.

Yeah; I'll see what I can do. ;)

> > I can see that we can get this working bare-metal with DT, but I
> > really don't want to try to support this in other cases (e.g. in a
> > VM, potentially with ACPI), or this IMP-DEFness is going to spread
> > more throughout the arm_pmu code.
> 
> Well, an alternative would be to sidestep the arm_pmu framework
> altogether.  Which would probably suck even more.
> 
> > How does this interact with PMU emulation for a KVM guest?
> 
> It doesn't. No non-architected PMU will get exposed to a KVM guest,
> and the usual "inject an UNDEF exception on IMPDEF access" applies. As
> far as I am concerned, KVM is purely architectural and doesn't need to
> be encumbered with this.

Cool; I think not exposing this into a VM rules out the other issues I
was concerned with, so as long as we're ruling that out I think we're
agreed (and I see no reason for us to try to force this platform to work
with ACPI on bare-metal).

> > > +static const u16 m1_pmu_event_affinity[M1_PMU_PERFCTR_LAST + 1] = {
> > > +	[0 ... M1_PMU_PERFCTR_LAST]	= ANY_BUT_0_1,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_01]	= BIT(7),
> > > +	[M1_PMU_PERFCTR_CPU_CYCLES]	= ANY_BUT_0_1 | BIT(0),
> > > +	[M1_PMU_PERFCTR_INSTRUCTIONS]	= BIT(7) | BIT(1),
> > > +	[M1_PMU_PERFCTR_UNKNOWN_8d]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_8e]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_8f]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_90]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_93]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_94]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_95]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_96]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_97]	= BIT(7),
> > > +	[M1_PMU_PERFCTR_UNKNOWN_98]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_99]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_9a]	= BIT(7),
> > > +	[M1_PMU_PERFCTR_UNKNOWN_9b]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_9c]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_9f]	= BIT(7),
> > > +	[M1_PMU_PERFCTR_UNKNOWN_bf]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_c0]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_c1]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_c4]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_c5]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_c6]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_c8]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_ca]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_cb]	= ONLY_5_6_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_f5]	= ONLY_2_4_6,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_f6]	= ONLY_2_4_6,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_f7]	= ONLY_2_4_6,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_f8]	= ONLY_2_TO_7,
> > > +	[M1_PMU_PERFCTR_UNKNOWN_fd]	= ONLY_2_4_6,
> > > +};
> > 
> > I don't entirely follow what's going on here. Is this a matrix
> > scheme like what QC had in their IMP-DEF Krait PMUs? See:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/perf_event_v7.c?h=v5.16-rc3#n1286
> 
> It is nowhere as complicated as that.

Good to hear!

> > I'm a bit worried about this, since is this is of that shape, there
> > are potential constraints on which counters and/or events you can
> > use concurrently, and if you violate those they can conflict. If so,
> > we need to be *very* careful about the abstraction we provide to
> > userspace.
> 
> The HW does have placement constraints (this is what this per-event
> bitmap is expressing), but the counting seems completely independent
> as long as you find an ad-hoc counter to place the event. Which means
> that if you try and count (for example) 4 events that would only fit
> in {5,6,7}, we'll say NO to the fourth one.
> 
> As I say somewhere in a comment, we could do a better job if we had a
> global view of the events to be counted, and split them in batches
> that the core perf would then schedule.

For better or worse I don't think there's a good way to do that due to
the way the core perf event lists are managed. You basically have a
choice between either stopping prematurely or iterating over *all* the
events redundantly (which is potentially very expensive and
deliberately avoided today).

If (as I understand from the above) the constraints are independent then 
I don't think there's anything we can do in the PMU driver.

> If you think any of this somehow breaks the userspace ABI, please let
> me know (my understand of perf is pretty limited...).

As long as there are no cross-event or cross-counter constraints, then I
don't think there's a userspace ABI problem here.

[...]

> > > +static void m1_pmu_configure_counter(unsigned int index, u8 event,
> > > +				     bool user, bool kernel)
> > > +{
> > > +	u64 val, user_bit, kernel_bit;
> > > +	int shift;
> > > +
> > > +	switch (index) {
> > > +	case 0 ... 7:
> > > +		user_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL0_0_7));
> > > +		kernel_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL1_0_7));
> > > +		break;
> > > +	case 8 ... 9:
> > > +		user_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL0_8_9));
> > > +		kernel_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL1_8_9));
> > > +		break;
> > 
> > When this says 'EL1', presuambly that's counting at EL2 in VHE?
> 
> It does.
> 
> > Are there separate EL1 / EL2 controls, or anythign of that sort we need to be
> > aware of?
> 
> No, there is a single, per-counter control for EL0 and EL2. I couldn't
> get the counters to report anything useful while a guest was running,
> but that doesn't mean such control doesn't exist.

Ok. We might need to require the exclude_guest flag for now, assuming
the perf tool automatically sets that.

[...]

> > > +	state = read_sysreg_s(SYS_IMP_APL_PMCR0_EL1);
> > > +	overflow = read_sysreg_s(SYS_IMP_APL_PMSR_EL1);
> > 
> > I assume the overflow behaviour is free-running rather than stopping?
> 
> Configurable, apparently. At the moment, I set it to stop on overflow.
> Happy to change the behaviour though.

The architected PMU continues counting upon overflow (which prevents
losing counts around the overlflow occurring), so I'd prefer that.

Is that behaviour per-counter, or for the PMU as a whole?

[...]

> > > +static int m1_pmu_device_probe(struct platform_device *pdev)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = arm_pmu_device_probe(pdev, m1_pmu_of_device_ids, NULL);
> > > +	if (!ret) {
> > > +		/*
> > > +		 * If probe succeeds, taint the kernel as this is all
> > > +		 * undocumented, implementation defined black magic.
> > > +		 */
> > > +		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > 
> > Hmmm... that means we're always going to TAINT on this HW with an appropriate
> > DT, which could mask other reasons TAINT_CPU_OUT_OF_SPEC would be set, even
> > where the user isn't using the PMU.
> > 
> > Maybe we should have a cmdline option to opt-in to using the IMP-DEF PMU (and
> > only tainting in that case)?
> 
> I'd rather taint on first use. Requiring a command-line argument for
> this seems a bit over the top...

That does sound nicer.

That said, if we've probed the thing, we're going to be poking it to
reset it (including out of idle), even if the user hasn't tried to use
it, so I'm not sure what's best after all...

Thanks,
Mark.
