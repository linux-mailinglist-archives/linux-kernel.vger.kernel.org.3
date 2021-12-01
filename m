Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D215E465370
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351615AbhLARBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:01:38 -0500
Received: from foss.arm.com ([217.140.110.172]:42172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243465AbhLARBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:01:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A26314BF;
        Wed,  1 Dec 2021 08:58:15 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99A573F766;
        Wed,  1 Dec 2021 08:58:13 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:58:10 +0000
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
Message-ID: <YaepolizIKkzDQoV@FVFF77S0Q05N>
References: <20211201134909.390490-1-maz@kernel.org>
 <20211201134909.390490-9-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201134909.390490-9-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 01:49:09PM +0000, Marc Zyngier wrote:
> Add a new, weird and wonderful driver for the equally weird Apple
> PMU HW. Although the PMU itself is functional, we don't know much
> about the events yet, so this can be considered as yet another
> random number generator...

It's really frustrating that Apple built this rather than the architected PMU,
because we've generally pushed back on IMPLEMENTATION DEFINED junk in this
area, and supporting this makes it harder to push back on other vendors going
the same route, which I'm not keen on. That, and the usual state of IMP-DEF
stuff making this stupidly painful to reason about. 

I can see that we can get this working bare-metal with DT, but I really don't
want to try to support this in other cases (e.g. in a VM, potentially with
ACPI), or this IMP-DEFness is going to spread more throughout the arm_pmu code.

How does this interact with PMU emulation for a KVM guest?

I have a bunch of comments and questions below.

[...]

> +#define ANY_BUT_0_1			GENMASK(9, 2)
> +#define ONLY_2_TO_7			GENMASK(7, 2)
> +#define ONLY_2_4_6			(BIT(2) | BIT(4) | BIT(6))
> +#define ONLY_5_6_7			GENMASK(7, 5)

For clarity/consistency it might be better to use separate BIT()s for
ONLY_5_6_7 too.

> +/*
> + * Description of the events we actually know about, as well as those with
> + * a specific counter affinity. Yes, this is a grand total of two known
> + * counters, and the rest is anybody's guess.
> + *
> + * Not all counters can count all events. Counters #0 and #1 are wired to
> + * count cycles and instructions respectively, and some events have
> + * bizarre mappings (every other counter, or even *one* counter). These
> + * restrictions equally apply to both P and E cores.
> + *
> + * It is worth noting that the PMUs attached to P and E cores are likely
> + * to be different because the underlying uarches are different. At the
> + * moment, we don't really need to distinguish between the two because we
> + * know next to nothing about the events themselves, and we already have
> + * per cpu-type PMU abstractions.
> + *
> + * If we eventually find out that the events are different across
> + * implementations, we'll have to introduce per cpu-type tables.
> + */
> +enum m1_pmu_events {
> +	M1_PMU_PERFCTR_UNKNOWN_01	= 0x01,
> +	M1_PMU_PERFCTR_CPU_CYCLES	= 0x02,
> +	M1_PMU_PERFCTR_INSTRUCTIONS	= 0x8c,
> +	M1_PMU_PERFCTR_UNKNOWN_8d	= 0x8d,
> +	M1_PMU_PERFCTR_UNKNOWN_8e	= 0x8e,
> +	M1_PMU_PERFCTR_UNKNOWN_8f	= 0x8f,
> +	M1_PMU_PERFCTR_UNKNOWN_90	= 0x90,
> +	M1_PMU_PERFCTR_UNKNOWN_93	= 0x93,
> +	M1_PMU_PERFCTR_UNKNOWN_94	= 0x94,
> +	M1_PMU_PERFCTR_UNKNOWN_95	= 0x95,
> +	M1_PMU_PERFCTR_UNKNOWN_96	= 0x96,
> +	M1_PMU_PERFCTR_UNKNOWN_97	= 0x97,
> +	M1_PMU_PERFCTR_UNKNOWN_98	= 0x98,
> +	M1_PMU_PERFCTR_UNKNOWN_99	= 0x99,
> +	M1_PMU_PERFCTR_UNKNOWN_9a	= 0x9a,
> +	M1_PMU_PERFCTR_UNKNOWN_9b	= 0x9b,
> +	M1_PMU_PERFCTR_UNKNOWN_9c	= 0x9c,
> +	M1_PMU_PERFCTR_UNKNOWN_9f	= 0x9f,
> +	M1_PMU_PERFCTR_UNKNOWN_bf	= 0xbf,
> +	M1_PMU_PERFCTR_UNKNOWN_c0	= 0xc0,
> +	M1_PMU_PERFCTR_UNKNOWN_c1	= 0xc1,
> +	M1_PMU_PERFCTR_UNKNOWN_c4	= 0xc4,
> +	M1_PMU_PERFCTR_UNKNOWN_c5	= 0xc5,
> +	M1_PMU_PERFCTR_UNKNOWN_c6	= 0xc6,
> +	M1_PMU_PERFCTR_UNKNOWN_c8	= 0xc8,
> +	M1_PMU_PERFCTR_UNKNOWN_ca	= 0xca,
> +	M1_PMU_PERFCTR_UNKNOWN_cb	= 0xcb,
> +	M1_PMU_PERFCTR_UNKNOWN_f5	= 0xf5,
> +	M1_PMU_PERFCTR_UNKNOWN_f6	= 0xf6,
> +	M1_PMU_PERFCTR_UNKNOWN_f7	= 0xf7,
> +	M1_PMU_PERFCTR_UNKNOWN_f8	= 0xf8,
> +	M1_PMU_PERFCTR_UNKNOWN_fd	= 0xfd,
> +	M1_PMU_PERFCTR_LAST		= M1_PMU_CFG_EVENT,
> +
> +	/*
> +	 * From this point onwards, these are not actual HW events,
> +	 * but attributes that get stored in hw->config_base.
> +	 */
> +	M1_PMU_CFG_COUNT_USER		= BIT(8),
> +	M1_PMU_CFG_COUNT_KERNEL		= BIT(9),
> +};
> +
> +/*
> + * Per-event affinity table. Most events can be installed on counter
> + * 2-9, but there are a numbre of exceptions. Note that this table
> + * has been created experimentally, and I wouldn't be surprised if more
> + * counters had strange affinities.
> + */
> +static const u16 m1_pmu_event_affinity[M1_PMU_PERFCTR_LAST + 1] = {
> +	[0 ... M1_PMU_PERFCTR_LAST]	= ANY_BUT_0_1,
> +	[M1_PMU_PERFCTR_UNKNOWN_01]	= BIT(7),
> +	[M1_PMU_PERFCTR_CPU_CYCLES]	= ANY_BUT_0_1 | BIT(0),
> +	[M1_PMU_PERFCTR_INSTRUCTIONS]	= BIT(7) | BIT(1),
> +	[M1_PMU_PERFCTR_UNKNOWN_8d]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_8e]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_8f]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_90]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_93]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_94]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_95]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_96]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_97]	= BIT(7),
> +	[M1_PMU_PERFCTR_UNKNOWN_98]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_99]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_9a]	= BIT(7),
> +	[M1_PMU_PERFCTR_UNKNOWN_9b]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_9c]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_9f]	= BIT(7),
> +	[M1_PMU_PERFCTR_UNKNOWN_bf]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_c0]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_c1]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_c4]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_c5]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_c6]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_c8]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_ca]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_cb]	= ONLY_5_6_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_f5]	= ONLY_2_4_6,
> +	[M1_PMU_PERFCTR_UNKNOWN_f6]	= ONLY_2_4_6,
> +	[M1_PMU_PERFCTR_UNKNOWN_f7]	= ONLY_2_4_6,
> +	[M1_PMU_PERFCTR_UNKNOWN_f8]	= ONLY_2_TO_7,
> +	[M1_PMU_PERFCTR_UNKNOWN_fd]	= ONLY_2_4_6,
> +};

I don't entirely follow what's going on here. Is this a matrix scheme like what
QC had in their IMP-DEF Krait PMUs? See:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/perf_event_v7.c?h=v5.16-rc3#n1286

I'm a bit worried about this, since is this is of that shape, there are
potential constraints on which counters and/or events you can use concurrently,
and if you violate those they can conflict. If so, we need to be *very* careful
about the abstraction we provide to userspace.

[...]

> +/* Low level accessors. No synchronisation. */
> +#define PMU_READ_COUNTER(_idx)						\
> +	case _idx:	return read_sysreg_s(SYS_IMP_APL_PMC## _idx ##_EL1)
> +
> +#define PMU_WRITE_COUNTER(_val, _idx)					\
> +	case _idx:							\
> +		write_sysreg_s(_val, SYS_IMP_APL_PMC## _idx ##_EL1);	\
> +		return
> +
> +static u64 m1_pmu_read_hw_counter(unsigned int index)
> +{
> +	switch (index) {
> +		PMU_READ_COUNTER(0);
> +		PMU_READ_COUNTER(1);
> +		PMU_READ_COUNTER(2);
> +		PMU_READ_COUNTER(3);
> +		PMU_READ_COUNTER(4);
> +		PMU_READ_COUNTER(5);
> +		PMU_READ_COUNTER(6);
> +		PMU_READ_COUNTER(7);
> +		PMU_READ_COUNTER(8);
> +		PMU_READ_COUNTER(9);
> +	}
> +
> +	BUG();
> +}
> +
> +static void m1_pmu_write_hw_counter(u64 val, unsigned int index)
> +{
> +	switch (index) {
> +		PMU_WRITE_COUNTER(val, 0);
> +		PMU_WRITE_COUNTER(val, 1);
> +		PMU_WRITE_COUNTER(val, 2);
> +		PMU_WRITE_COUNTER(val, 3);
> +		PMU_WRITE_COUNTER(val, 4);
> +		PMU_WRITE_COUNTER(val, 5);
> +		PMU_WRITE_COUNTER(val, 6);
> +		PMU_WRITE_COUNTER(val, 7);
> +		PMU_WRITE_COUNTER(val, 8);
> +		PMU_WRITE_COUNTER(val, 9);
> +	}
> +
> +	BUG();
> +}

As an aside, since this pattern has cropped up in a few places, maybe we want
to look into scripting the generation of sysreg banki accessors like this.

[...]

> +static void m1_pmu_configure_counter(unsigned int index, u8 event,
> +				     bool user, bool kernel)
> +{
> +	u64 val, user_bit, kernel_bit;
> +	int shift;
> +
> +	switch (index) {
> +	case 0 ... 7:
> +		user_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL0_0_7));
> +		kernel_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL1_0_7));
> +		break;
> +	case 8 ... 9:
> +		user_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL0_8_9));
> +		kernel_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL1_8_9));
> +		break;

When this says 'EL1', presuambly that's counting at EL2 in VHE?

Are there separate EL1 / EL2 controls, or anythign of that sort we need to be
aware of?

[...]

> +/* arm_pmu backend */
> +static void m1_pmu_enable_event(struct perf_event *event)
> +{
> +	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
> +	unsigned long flags;
> +	bool user, kernel;
> +	u8 evt;
> +
> +	evt = event->hw.config_base & M1_PMU_CFG_EVENT;
> +	user = event->hw.config_base & M1_PMU_CFG_COUNT_USER;
> +	kernel = event->hw.config_base & M1_PMU_CFG_COUNT_KERNEL;
> +
> +	raw_spin_lock_irqsave(&cpuc->pmu_lock, flags);

You shouldn't need this locking. The perf core always calls into the HW access
functions with IRQs disabled and we don't do cross-cpu state modification.
Likewise elsewhere in this file.

We pulled similar out of the architectural PMU driver in commit:

2a0e2a02e4b71917 ("arm64: perf: Remove PMU locking")

... though that says non-preemptible when it should say non-interruptible.

I should clean up the 32-bit drivers and remove pmu_hw_events::pmu_lock
entirely.

> +
> +	m1_pmu_disable_counter_interrupt(event->hw.idx);
> +	m1_pmu_disable_counter(event->hw.idx);
> +	isb();
> +
> +	m1_pmu_configure_counter(event->hw.idx, evt, user, kernel);
> +	m1_pmu_enable_counter(event->hw.idx);
> +	m1_pmu_enable_counter_interrupt(event->hw.idx);
> +	isb();
> +
> +	raw_spin_unlock_irqrestore(&cpuc->pmu_lock, flags);
> +}
> +
> +static void __m1_pmu_disable_event(struct perf_event *event)
> +{
> +	m1_pmu_disable_counter_interrupt(event->hw.idx);
> +	m1_pmu_disable_counter(event->hw.idx);
> +	isb();
> +}
> +
> +static void m1_pmu_disable_event(struct perf_event *event)
> +{
> +	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&cpuc->pmu_lock, flags);
> +
> +	__m1_pmu_disable_event(event);
> +
> +	raw_spin_unlock_irqrestore(&cpuc->pmu_lock, flags);
> +}

As with m1_pmu_enable_event(), I don't believe the locking is necessary here.

> +static irqreturn_t m1_pmu_handle_irq(struct arm_pmu *cpu_pmu)
> +{
> +	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
> +	irqreturn_t ret = IRQ_HANDLED;
> +	struct pt_regs *regs;
> +	u64 overflow, state;
> +	unsigned long flags;
> +	int idx;
> +
> +	raw_spin_lock_irqsave(&cpuc->pmu_lock, flags);

Likewise, no need for a lock here, and certainly not an irqsave!

Same comment for subsequent usage in this file.

> +	state = read_sysreg_s(SYS_IMP_APL_PMCR0_EL1);
> +	overflow = read_sysreg_s(SYS_IMP_APL_PMSR_EL1);

I assume the overflow behaviour is free-running rather than stopping?

> +	if (!overflow) {
> +		ret = IRQ_NONE;
> +		goto out;
> +	}
> +
> +	regs = get_irq_regs();
> +
> +	for (idx = 0; idx < cpu_pmu->num_events; idx++) {
> +		struct perf_event *event = cpuc->events[idx];
> +		struct perf_sample_data data;
> +
> +		if (!event)
> +			continue;
> +
> +		armpmu_event_update(event);
> +		perf_sample_data_init(&data, 0, event->hw.last_period);
> +		if (!armpmu_event_set_period(event))
> +			continue;
> +
> +		if (perf_event_overflow(event, &data, regs))
> +			__m1_pmu_disable_event(event);
> +	}
> +
> +out:
> +	state &= ~PMCR0_IACT;
> +	write_sysreg_s(state, SYS_IMP_APL_PMCR0_EL1);
> +	isb();
> +
> +	raw_spin_unlock_irqrestore(&cpuc->pmu_lock, flags);
> +
> +	return ret;
> +}

[...]

> +static int m1_pmu_device_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = arm_pmu_device_probe(pdev, m1_pmu_of_device_ids, NULL);
> +	if (!ret) {
> +		/*
> +		 * If probe succeeds, taint the kernel as this is all
> +		 * undocumented, implementation defined black magic.
> +		 */
> +		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> +	}
> +
> +	return ret;
> +}

Hmmm... that means we're always going to TAINT on this HW with an appropriate
DT, which could mask other reasons TAINT_CPU_OUT_OF_SPEC would be set, even
where the user isn't using the PMU.

Maybe we should have a cmdline option to opt-in to using the IMP-DEF PMU (and
only tainting in that case)?

Thanks,
Mark.
