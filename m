Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B228F4987F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbiAXSLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:11:12 -0500
Received: from foss.arm.com ([217.140.110.172]:43312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244983AbiAXSLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:11:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C30ED6E;
        Mon, 24 Jan 2022 10:11:04 -0800 (PST)
Received: from [10.57.39.131] (unknown [10.57.39.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 755293F766;
        Mon, 24 Jan 2022 10:11:02 -0800 (PST)
Subject: Re: [RFC V1 07/11] arm64/perf: Add BRBE driver
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        suzuki K Poulose <suzuki.poulose@arm.com>,
        German Gomez <german.gomez@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-8-git-send-email-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <e4b074e7-4e9b-bca3-e2f7-5d9411c6d392@arm.com>
Date:   Mon, 24 Jan 2022 18:11:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642998653-21377-8-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/01/2022 04:30, Anshuman Khandual wrote:
> This adds a BRBE driver which implements all the required helper functions
> for struct arm_pmu. Following functions are defined by this driver which
> will configure, enable, capture, reset and disable BRBE buffer HW as and
> when requested via perf branch stack sampling framework.
> 
> - arm64_pmu_brbe_filter()
> - arm64_pmu_brbe_enable()
> - arm64_pmu_brbe_disable()
> - arm64_pmu_brbe_read()
> - arm64_pmu_brbe_probe()
> - arm64_pmu_brbe_reset()
> - arm64_pmu_brbe_supported()
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
[...]
> +static void perf_branch_to_brbcr(struct pmu_hw_events *cpuc, int branch_type)
> +{
> +	cpuc->brbcr = (BRBCR_CC | BRBCR_MPRED);
> +
> +	if (branch_type & PERF_SAMPLE_BRANCH_USER)
> +		cpuc->brbcr |= BRBCR_E0BRE;
> +
> +	if (branch_type & PERF_SAMPLE_BRANCH_KERNEL) {
> +		/*
> +		 * This should have been verified earlier.
> +		 */
> +		WARN_ON(!perfmon_capable());

If it's verified earlier than that value should be saved. At the moment this can
change depending on whichever process happens to be current when this is called.

I don't think perfmon_capable() should be called outside of the init function
of a PMU or outside of the perf core code. This function gets called on a path
from the PMU add function, where any process can be current.

See https://lore.kernel.org/lkml/20220118100702.GB16547@willie-the-truck/T/#m42df3688e8afa299a7b8dfb7c3f4a785c52bcbed

> +		cpuc->brbcr |= BRBCR_E1BRE;
> +	}
> +
> +	if (branch_type & PERF_SAMPLE_BRANCH_NO_CYCLES)
> +		cpuc->brbcr &= ~BRBCR_CC;
> +
> +	if (branch_type & PERF_SAMPLE_BRANCH_NO_FLAGS)
> +		cpuc->brbcr &= ~BRBCR_MPRED;
> +
> +	if (!perfmon_capable())
> +		return;
> +

This will return here randomly depending on whether a user process or a kernel
process is 'current', resulting in exception samples randomly being enabled
and disabled.

> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
> +		cpuc->brbcr |= BRBCR_EXCEPTION;
> +		cpuc->brbcr |= BRBCR_ERTN;
> +		return;
> +	}
> +
> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL)
> +		cpuc->brbcr |= BRBCR_EXCEPTION;
> +
> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
> +		cpuc->brbcr |= BRBCR_ERTN;
> +}
> +
> +
> +void arm64_pmu_brbe_filter(struct pmu_hw_events *cpuc, struct perf_event *event)
> +{
> +	u64 branch_type = event->attr.branch_sample_type;
> +
> +	if (brbe_disabled(cpuc))
> +		return;
> +
> +	perf_branch_to_brbfcr(cpuc, branch_type);
> +	perf_branch_to_brbcr(cpuc, branch_type);
> +}
> +
> +static int brbe_fetch_perf_type(u64 brbinf)
> +{
> +	int brbe_type = brbe_fetch_type(brbinf);
> +
> +	switch (brbe_type) {
> +	case BRBINF_TYPE_UNCOND_DIR:
> +		return PERF_BR_UNCOND;
> +	case BRBINF_TYPE_INDIR:
> +		return PERF_BR_IND;
> +	case BRBINF_TYPE_DIR_LINK:
> +		return PERF_BR_CALL;
> +	case BRBINF_TYPE_INDIR_LINK:
> +		return PERF_BR_IND_CALL;
> +	case BRBINF_TYPE_RET_SUB:
> +		return PERF_BR_RET;
> +	case BRBINF_TYPE_COND_DIR:
> +		return PERF_BR_COND;
> +	case BRBINF_TYPE_CALL:
> +		return PERF_BR_CALL;
> +	case BRBINF_TYPE_TRAP:
> +		return PERF_BR_SYSCALL;
> +	case BRBINF_TYPE_RET_EXCPT:
> +		return PERF_BR_UNKNOWN;
> +	case BRBINF_TYPE_IRQ:
> +		return PERF_BR_UNKNOWN;
> +	case BRBINF_TYPE_DEBUG_HALT:
> +	case BRBINF_TYPE_SERROR:
> +	case BRBINF_TYPE_INST_DEBUG:
> +	case BRBINF_TYPE_DATA_DEBUG:
> +	case BRBINF_TYPE_ALGN_FAULT:
> +	case BRBINF_TYPE_INST_FAULT:
> +	case BRBINF_TYPE_DATA_FAULT:
> +	case BRBINF_TYPE_FIQ:
> +	case BRBINF_TYPE_DEBUG_EXIT:
> +		return PERF_BR_UNKNOWN;
> +	default:
> +		pr_warn("unknown branch type captured\n");
> +		return PERF_BR_UNKNOWN;
> +	}
> +}
> +
> +static void capture_brbe_flags(struct pmu_hw_events *cpuc, struct perf_event *event,
> +			       u64 brbinf, int idx)
> +{
> +	int type = brbe_record_valid(brbinf);
> +
> +	if (!branch_sample_no_cycles(event))
> +		cpuc->brbe_entries[idx].cycles = brbe_fetch_cycles(brbinf);
> +
> +	if (branch_sample_type(event))
> +		cpuc->brbe_entries[idx].type = brbe_fetch_perf_type(brbinf);
> +
> +	if (!branch_sample_no_flags(event)) {
> +		/*
> +		 * BRBINF_LASTFAILED does not indicate that the last transaction
> +		 * got failed or aborted during the current branch record itself.
> +		 * Rather, this indicates that all the branch records which were
> +		 * in transaction until the curret branch record have failed. So
> +		 * the entire BRBE buffer needs to be processed later on to find
> +		 * all branch records which might have failed.
> +		 */
> +		cpuc->brbe_entries[idx].abort = brbinf & BRBINF_LASTFAILED;
> +
> +		/*
> +		 * All these information (i.e transaction state and mispredicts)
> +		 * are not available for target only branch records.
> +		 */
> +		if (type != BRBINF_VALID_TARGET) {
> +			cpuc->brbe_entries[idx].mispred = brbinf & BRBINF_MPRED;
> +			cpuc->brbe_entries[idx].predicted = !(brbinf & BRBINF_MPRED);
> +			cpuc->brbe_entries[idx].in_tx = brbinf & BRBINF_TX;
> +		}
> +	}
> +}
> +
> +/*
> + * A branch record with BRBINF_EL1.LASTFAILED set, implies that all
> + * preceding consecutive branch records, that were in a transaction
> + * (i.e their BRBINF_EL1.TX set) have been aborted.
> + *
> + * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
> + * consecutive branch records upto the last record, which were in a
> + * transaction (i.e their BRBINF_EL1.TX set) have been aborted.
> + *
> + * --------------------------------- -------------------
> + * | 00 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
> + * --------------------------------- -------------------
> + * | 01 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
> + * --------------------------------- -------------------
> + * | 02 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
> + * --------------------------------- -------------------
> + * | 03 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 04 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 05 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 1 |
> + * --------------------------------- -------------------
> + * | .. | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
> + * --------------------------------- -------------------
> + * | 61 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 62 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 63 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + *
> + * BRBFCR_EL1.LASTFAILED == 1
> + *
> + * Here BRBFCR_EL1.LASTFAILED failes all those consecutive and also
> + * in transaction branches near the end of the BRBE buffer.
> + */
> +static void process_branch_aborts(struct pmu_hw_events *cpuc)
> +{
> +	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +	bool lastfailed = !!(brbfcr & BRBFCR_LASTFAILED);
> +	int idx = cpuc->brbe_nr - 1;
> +
> +	do {
> +		if (cpuc->brbe_entries[idx].in_tx) {
> +			cpuc->brbe_entries[idx].abort = lastfailed;
> +		} else {
> +			lastfailed = cpuc->brbe_entries[idx].abort;
> +			cpuc->brbe_entries[idx].abort = false;
> +		}
> +	} while (idx--, idx >= 0);
> +}
> +
> +void arm64_pmu_brbe_read(struct pmu_hw_events *cpuc, struct perf_event *event)
> +{
> +	u64 brbinf;
> +	int idx;
> +
> +	if (brbe_disabled(cpuc))
> +		return;
> +
> +	set_brbe_paused();
> +	for (idx = 0; idx < cpuc->brbe_nr; idx++) {
> +		select_brbe_bank_index(idx);
> +		brbinf = get_brbinf_reg(idx);
> +		/*
> +		 * There are no valid entries anymore on the buffer.
> +		 * Abort the branch record processing to save some
> +		 * cycles and also reduce the capture/process load
> +		 * for the user space as well.
> +		 */
> +		if (brbe_invalid(brbinf))
> +			break;
> +
> +		if (brbe_valid(brbinf)) {
> +			cpuc->brbe_entries[idx].from =  get_brbsrc_reg(idx);
> +			cpuc->brbe_entries[idx].to =  get_brbtgt_reg(idx);
> +		} else if (brbe_source(brbinf)) {
> +			cpuc->brbe_entries[idx].from =  get_brbsrc_reg(idx);
> +			cpuc->brbe_entries[idx].to = 0;
> +		} else if (brbe_target(brbinf)) {
> +			cpuc->brbe_entries[idx].from = 0;
> +			cpuc->brbe_entries[idx].to =  get_brbtgt_reg(idx);
> +		}
> +		capture_brbe_flags(cpuc, event, brbinf, idx);
> +	}
> +	cpuc->brbe_stack.nr = idx;
> +	cpuc->brbe_stack.hw_idx = -1ULL;
> +	process_branch_aborts(cpuc);
> +}
> +
> +void arm64_pmu_brbe_reset(struct pmu_hw_events *cpuc)
> +{
> +	if (brbe_disabled(cpuc))
> +		return;
> +
> +	asm volatile(BRB_IALL);
> +	isb();
> +}
> diff --git a/drivers/perf/arm_pmu_brbe.h b/drivers/perf/arm_pmu_brbe.h
> new file mode 100644
> index 000000000000..f04975cdc242
> --- /dev/null
> +++ b/drivers/perf/arm_pmu_brbe.h
> @@ -0,0 +1,259 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Branch Record Buffer Extension Helpers.
> + *
> + * Copyright (C) 2021 ARM Limited
> + *
> + * Author: Anshuman Khandual <anshuman.khandual@arm.com>
> + */
> +#define pr_fmt(fmt) "brbe: " fmt
> +
> +#include <linux/perf/arm_pmu.h>
> +
> +/*
> + * BRBE Instructions
> + *
> + * BRB_IALL : Invalidate the entire buffer
> + * BRB_INJ  : Inject latest branch record derived from [BRBSRCINJ, BRBTGTINJ, BRBINFINJ]
> + */
> +#define BRB_IALL __emit_inst(0xD5000000 | sys_insn(1, 1, 7, 2, 4) | (0x1f))
> +#define BRB_INJ  __emit_inst(0xD5000000 | sys_insn(1, 1, 7, 2, 5) | (0x1f))
> +
> +/*
> + * BRBE Buffer Organization
> + *
> + * BRBE buffer is arranged as multiple banks of 32 branch record
> + * entries each. An indivdial branch record in a given bank could
> + * be accessedi, after selecting the bank in BRBFCR_EL1.BANK and
> + * accessing the registers i.e [BRBSRC, BRBTGT, BRBINF] set with
> + * indices [0..31].
> + *
> + * Bank 0
> + *
> + *	---------------------------------	------
> + *	| 00 | BRBSRC | BRBTGT | BRBINF |	| 00 |
> + *	---------------------------------	------
> + *	| 01 | BRBSRC | BRBTGT | BRBINF |	| 01 |
> + *	---------------------------------	------
> + *	| .. | BRBSRC | BRBTGT | BRBINF |	| .. |
> + *	---------------------------------	------
> + *	| 31 | BRBSRC | BRBTGT | BRBINF |	| 31 |
> + *	---------------------------------	------
> + *
> + * Bank 1
> + *
> + *	---------------------------------	------
> + *	| 32 | BRBSRC | BRBTGT | BRBINF |	| 00 |
> + *	---------------------------------	------
> + *	| 33 | BRBSRC | BRBTGT | BRBINF |	| 01 |
> + *	---------------------------------	------
> + *	| .. | BRBSRC | BRBTGT | BRBINF |	| .. |
> + *	---------------------------------	------
> + *	| 63 | BRBSRC | BRBTGT | BRBINF |	| 31 |
> + *	---------------------------------	------
> + */
> +#define BRBE_BANK0_IDX_MIN 0
> +#define BRBE_BANK0_IDX_MAX 31
> +#define BRBE_BANK1_IDX_MIN 32
> +#define BRBE_BANK1_IDX_MAX 63
> +
> +#define RETURN_READ_BRBSRCN(n) \
> +	read_sysreg_s(SYS_BRBSRC##n##_EL1)
> +
> +#define RETURN_READ_BRBTGTN(n) \
> +	read_sysreg_s(SYS_BRBTGT##n##_EL1)
> +
> +#define RETURN_READ_BRBINFN(n) \
> +	read_sysreg_s(SYS_BRBINF##n##_EL1)
> +
> +#define BRBE_REGN_CASE(n, case_macro) \
> +	case n: return case_macro(n); break
> +
> +#define BRBE_REGN_SWITCH(x, case_macro)				\
> +	do {							\
> +		switch (x) {					\
> +		BRBE_REGN_CASE(0, case_macro);			\
> +		BRBE_REGN_CASE(1, case_macro);			\
> +		BRBE_REGN_CASE(2, case_macro);			\
> +		BRBE_REGN_CASE(3, case_macro);			\
> +		BRBE_REGN_CASE(4, case_macro);			\
> +		BRBE_REGN_CASE(5, case_macro);			\
> +		BRBE_REGN_CASE(6, case_macro);			\
> +		BRBE_REGN_CASE(7, case_macro);			\
> +		BRBE_REGN_CASE(8, case_macro);			\
> +		BRBE_REGN_CASE(9, case_macro);			\
> +		BRBE_REGN_CASE(10, case_macro);			\
> +		BRBE_REGN_CASE(11, case_macro);			\
> +		BRBE_REGN_CASE(12, case_macro);			\
> +		BRBE_REGN_CASE(13, case_macro);			\
> +		BRBE_REGN_CASE(14, case_macro);			\
> +		BRBE_REGN_CASE(15, case_macro);			\
> +		BRBE_REGN_CASE(16, case_macro);			\
> +		BRBE_REGN_CASE(17, case_macro);			\
> +		BRBE_REGN_CASE(18, case_macro);			\
> +		BRBE_REGN_CASE(19, case_macro);			\
> +		BRBE_REGN_CASE(20, case_macro);			\
> +		BRBE_REGN_CASE(21, case_macro);			\
> +		BRBE_REGN_CASE(22, case_macro);			\
> +		BRBE_REGN_CASE(23, case_macro);			\
> +		BRBE_REGN_CASE(24, case_macro);			\
> +		BRBE_REGN_CASE(25, case_macro);			\
> +		BRBE_REGN_CASE(26, case_macro);			\
> +		BRBE_REGN_CASE(27, case_macro);			\
> +		BRBE_REGN_CASE(28, case_macro);			\
> +		BRBE_REGN_CASE(29, case_macro);			\
> +		BRBE_REGN_CASE(30, case_macro);			\
> +		BRBE_REGN_CASE(31, case_macro);			\
> +		default:					\
> +			pr_warn("unknown register index\n");	\
> +			return -1;				\
> +		}						\
> +	} while (0)
> +
> +static inline int buffer_to_brbe_idx(int buffer_idx)
> +{
> +	return buffer_idx % 32;
> +}
> +
> +static inline u64 get_brbsrc_reg(int buffer_idx)
> +{
> +	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
> +
> +	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBSRCN);
> +}
> +
> +static inline u64 get_brbtgt_reg(int buffer_idx)
> +{
> +	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
> +
> +	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBTGTN);
> +}
> +
> +static inline u64 get_brbinf_reg(int buffer_idx)
> +{
> +	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
> +
> +	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBINFN);
> +}
> +
> +static inline u64 brbe_record_valid(u64 brbinf)
> +{
> +	return brbinf & (BRBINF_VALID_MASK << BRBINF_VALID_SHIFT);
> +}
> +
> +static inline bool brbe_invalid(u64 brbinf)
> +{
> +	return brbe_record_valid(brbinf) == BRBINF_VALID_INVALID;
> +}
> +
> +static inline bool brbe_valid(u64 brbinf)
> +{
> +	return brbe_record_valid(brbinf) == BRBINF_VALID_ALL;
> +}
> +
> +static inline bool brbe_source(u64 brbinf)
> +{
> +	return brbe_record_valid(brbinf) == BRBINF_VALID_SOURCE;
> +}
> +
> +static inline bool brbe_target(u64 brbinf)
> +{
> +	return brbe_record_valid(brbinf) == BRBINF_VALID_TARGET;
> +}
> +
> +static inline int brbe_fetch_cycles(u64 brbinf)
> +{
> +	/*
> +	 * Captured cycle count is unknown and hence
> +	 * should not be passed on the user space.
> +	 */
> +	if (brbinf & BRBINF_CCU)
> +		return 0;
> +
> +	return (brbinf >> BRBINF_CC_SHIFT) & BRBINF_CC_MASK;
> +}
> +
> +static inline int brbe_fetch_type(u64 brbinf)
> +{
> +	return (brbinf >> BRBINF_TYPE_SHIFT) & BRBINF_TYPE_MASK;
> +}
> +
> +static inline int brbe_fetch_el(u64 brbinf)
> +{
> +	return (brbinf >> BRBINF_EL_SHIFT) & BRBINF_EL_MASK;
> +}
> +
> +static inline int brbe_fetch_numrec(u64 brbidr)
> +{
> +	return (brbidr >> BRBIDR0_NUMREC_SHIFT) & BRBIDR0_NUMREC_MASK;
> +}
> +
> +static inline int brbe_fetch_format(u64 brbidr)
> +{
> +	return (brbidr >> BRBIDR0_FORMAT_SHIFT) & BRBIDR0_FORMAT_MASK;
> +}
> +
> +static inline int brbe_fetch_cc_bits(u64 brbidr)
> +{
> +	return (brbidr >> BRBIDR0_CC_SHIFT) & BRBIDR0_CC_MASK;
> +}
> +
> +static inline void select_brbe_bank(int bank)
> +{
> +	static int brbe_current_bank = -1;
> +	u64 brbfcr;
> +
> +	if (brbe_current_bank == bank)
> +		return;
> +
> +	WARN_ON(bank > 1);
> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +	brbfcr &= ~(BRBFCR_BANK_MASK << BRBFCR_BANK_SHIFT);
> +	brbfcr |= ((bank & BRBFCR_BANK_MASK) << BRBFCR_BANK_SHIFT);
> +	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +	isb();
> +	brbe_current_bank = bank;
> +}
> +
> +static inline void select_brbe_bank_index(int buffer_idx)
> +{
> +	switch (buffer_idx) {
> +	case BRBE_BANK0_IDX_MIN ... BRBE_BANK0_IDX_MAX:
> +		select_brbe_bank(0);
> +		break;
> +	case BRBE_BANK1_IDX_MIN ... BRBE_BANK1_IDX_MAX:
> +		select_brbe_bank(1);
> +		break;
> +	default:
> +		pr_warn("unsupported BRBE index\n");
> +	}
> +}
> +
> +static inline bool valid_brbe_nr(int brbe_nr)
> +{
> +	switch (brbe_nr) {
> +	case BRBIDR0_NUMREC_8:
> +	case BRBIDR0_NUMREC_16:
> +	case BRBIDR0_NUMREC_32:
> +	case BRBIDR0_NUMREC_64:
> +		return true;
> +	default:
> +		pr_warn("unsupported BRBE entries\n");
> +		return false;
> +	}
> +}
> +
> +static inline bool brbe_paused(void)
> +{
> +	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +
> +	return brbfcr & BRBFCR_PAUSED;
> +}
> +
> +static inline void set_brbe_paused(void)
> +{
> +	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +
> +	write_sysreg_s(brbfcr | BRBFCR_PAUSED, SYS_BRBFCR_EL1);
> +	isb();
> +}
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index c4a705d3d054..d401771e7767 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -146,6 +146,26 @@ struct arm_pmu {
>  	unsigned long acpi_cpuid;
>  };
>  
> +#ifdef CONFIG_ARM_BRBE_PMU
> +void arm64_pmu_brbe_filter(struct pmu_hw_events *hw_events, struct perf_event *event);
> +void arm64_pmu_brbe_read(struct pmu_hw_events *cpuc, struct perf_event *event);
> +void arm64_pmu_brbe_disable(struct pmu_hw_events *cpuc);
> +void arm64_pmu_brbe_enable(struct pmu_hw_events *cpuc);
> +void arm64_pmu_brbe_probe(struct pmu_hw_events *cpuc);
> +void arm64_pmu_brbe_reset(struct pmu_hw_events *cpuc);
> +bool arm64_pmu_brbe_supported(struct perf_event *event);
> +#else
> +static inline void arm64_pmu_brbe_filter(struct pmu_hw_events *hw_events, struct perf_event *event)
> +{
> +}
> +static inline void arm64_pmu_brbe_read(struct pmu_hw_events *cpuc, struct perf_event *event) { }
> +static inline void arm64_pmu_brbe_disable(struct pmu_hw_events *cpuc) { }
> +static inline void arm64_pmu_brbe_enable(struct pmu_hw_events *cpuc) { }
> +static inline void arm64_pmu_brbe_probe(struct pmu_hw_events *cpuc) { }
> +static inline void arm64_pmu_brbe_reset(struct pmu_hw_events *cpuc) { }
> +static inline bool arm64_pmu_brbe_supported(struct perf_event *event) {return false; }
> +#endif
> +
>  #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
>  
>  u64 armpmu_event_update(struct perf_event *event);
> 
