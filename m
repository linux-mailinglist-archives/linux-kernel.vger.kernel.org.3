Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F155B13D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIHFLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIHFLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:11:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0627CBB68B;
        Wed,  7 Sep 2022 22:11:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6799B106F;
        Wed,  7 Sep 2022 22:11:32 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F29B63F7B4;
        Wed,  7 Sep 2022 22:11:21 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH V2 6/7] arm64/perf: Add BRBE driver
Date:   Thu,  8 Sep 2022 10:40:45 +0530
Message-Id: <20220908051046.465307-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908051046.465307-1-anshuman.khandual@arm.com>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a BRBE driver which implements all the required helper functions
for struct arm_pmu. Following functions are defined by this driver which
will configure, enable, capture, reset and disable BRBE buffer HW as and
when requested via perf branch stack sampling framework.

- arm64_pmu_brbe_filter()
- arm64_pmu_brbe_enable()
- arm64_pmu_brbe_disable()
- arm64_pmu_brbe_read()
- arm64_pmu_brbe_probe()
- arm64_pmu_brbe_reset()
- arm64_pmu_brbe_supported()

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kernel/perf_event.c |   8 +-
 drivers/perf/Kconfig           |  11 +
 drivers/perf/Makefile          |   1 +
 drivers/perf/arm_pmu_brbe.c    | 448 +++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmu_brbe.h    | 259 +++++++++++++++++++
 include/linux/perf/arm_pmu.h   |  20 ++
 6 files changed, 746 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/arm_pmu_brbe.c
 create mode 100644 drivers/perf/arm_pmu_brbe.h

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 5bfaba8edad1..76d409d9b5f3 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1033,31 +1033,37 @@ static int armv8pmu_filter_match(struct perf_event *event)
 
 static void armv8pmu_brbe_filter(struct pmu_hw_events *hw_event, struct perf_event *event)
 {
+	arm64_pmu_brbe_filter(hw_event, event);
 }
 
 static void armv8pmu_brbe_enable(struct pmu_hw_events *hw_event)
 {
+	arm64_pmu_brbe_enable(hw_event);
 }
 
 static void armv8pmu_brbe_disable(struct pmu_hw_events *hw_event)
 {
+	arm64_pmu_brbe_disable(hw_event);
 }
 
 static void armv8pmu_brbe_read(struct pmu_hw_events *hw_event, struct perf_event *event)
 {
+	arm64_pmu_brbe_read(hw_event, event);
 }
 
 static void armv8pmu_brbe_probe(struct pmu_hw_events *hw_event)
 {
+	arm64_pmu_brbe_probe(hw_event);
 }
 
 static void armv8pmu_brbe_reset(struct pmu_hw_events *hw_event)
 {
+	arm64_pmu_brbe_reset(hw_event);
 }
 
 static bool armv8pmu_brbe_supported(struct perf_event *event)
 {
-	return false;
+	return arm64_pmu_brbe_supported(event);
 }
 
 static void armv8pmu_reset(void *info)
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 1e2d69453771..9fa34a1d3a23 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -183,6 +183,17 @@ config APPLE_M1_CPU_PMU
 	  Provides support for the non-architectural CPU PMUs present on
 	  the Apple M1 SoCs and derivatives.
 
+config ARM_BRBE_PMU
+	tristate "Enable support for Branch Record Buffer Extension (BRBE)"
+	depends on ARM64 && ARM_PMU
+	default y
+	help
+	  Enable perf support for Branch Record Buffer Extension (BRBE) which
+	  records all branches taken in an execution path. This supports some
+	  branch types and privilege based filtering. It captured additional
+	  relevant information such as cycle count, misprediction and branch
+	  type, branch privilege level etc.
+
 source "drivers/perf/hisilicon/Kconfig"
 
 config MARVELL_CN10K_DDR_PMU
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 57a279c61df5..b81fc134d95f 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
+obj-$(CONFIG_ARM_BRBE_PMU) += arm_pmu_brbe.o
diff --git a/drivers/perf/arm_pmu_brbe.c b/drivers/perf/arm_pmu_brbe.c
new file mode 100644
index 000000000000..d2d546a8eaab
--- /dev/null
+++ b/drivers/perf/arm_pmu_brbe.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Branch Record Buffer Extension Driver.
+ *
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#include "arm_pmu_brbe.h"
+
+#define BRBE_FCR_MASK (BRBFCR_BRANCH_ALL)
+#define BRBE_CR_MASK  (BRBCR_EXCEPTION | BRBCR_ERTN | BRBCR_CC | \
+		       BRBCR_MPRED | BRBCR_E1BRE | BRBCR_E0BRE)
+
+static bool arm64_pmu_brbe_has_priv(struct perf_event *event)
+{
+	return !!(event->hw.flags & ARMPMU_EVT_PRIV);
+}
+
+static void set_brbe_disabled(struct pmu_hw_events *cpuc)
+{
+	cpuc->brbe_nr = 0;
+}
+
+static bool brbe_disabled(struct pmu_hw_events *cpuc)
+{
+	return !cpuc->brbe_nr;
+}
+
+bool arm64_pmu_brbe_supported(struct perf_event *event)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+	struct pmu_hw_events *hw_events = per_cpu_ptr(armpmu->hw_events, event->cpu);
+
+	/*
+	 * If the event does not have at least one of the privilege
+	 * branch filters as in PERF_SAMPLE_BRANCH_PLM_ALL, the core
+	 * perf will adjust its value based on perf event's existing
+	 * privilege level via attr.exclude_[user|kernel|hv].
+	 *
+	 * As event->attr.branch_sample_type might have been changed
+	 * when the event reaches here, it is not possible to figure
+	 * out whether the event originally had HV privilege request
+	 * or got added via the core perf. Just report this situation
+	 * once and continue ignoring if there are other instances.
+	 */
+	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HV)
+		pr_warn_once("does not support hypervisor privilege branch filter\n");
+
+	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_ABORT_TX) {
+		pr_warn_once("does not support aborted transaction branch filter\n");
+		return false;
+	}
+
+	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_NO_TX) {
+		pr_warn_once("does not support non transaction branch filter\n");
+		return false;
+	}
+
+	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_IN_TX) {
+		pr_warn_once("does not support in transaction branch filter\n");
+		return false;
+	}
+	return !brbe_disabled(hw_events);
+}
+
+void arm64_pmu_brbe_probe(struct pmu_hw_events *cpuc)
+{
+	u64 aa64dfr0, brbidr;
+	unsigned int brbe, format, cpu = smp_processor_id();
+
+	aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
+	brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_BRBE_SHIFT);
+	if (!brbe) {
+		pr_info("no implementation found on cpu %d\n", cpu);
+		set_brbe_disabled(cpuc);
+		return;
+	} else if (brbe == ID_AA64DFR0_BRBE) {
+		pr_info("implementation found on cpu %d\n", cpu);
+		cpuc->v1p1 = false;
+	} else if (brbe == ID_AA64DFR0_BRBE_V1P1) {
+		pr_info("implementation (v1p1) found on cpu %d\n", cpu);
+		cpuc->v1p1 = true;
+	}
+
+	brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
+	format = brbe_fetch_format(brbidr);
+	if (format != BRBIDR0_FORMAT_0) {
+		pr_warn("format 0 not implemented\n");
+		set_brbe_disabled(cpuc);
+		return;
+	}
+
+	cpuc->brbe_cc = brbe_fetch_cc_bits(brbidr);
+	if (cpuc->brbe_cc != BRBIDR0_CC_20_BIT) {
+		pr_warn("20-bit counter not implemented\n");
+		set_brbe_disabled(cpuc);
+		return;
+	}
+
+	cpuc->brbe_nr = brbe_fetch_numrec(brbidr);
+	if (!valid_brbe_nr(cpuc->brbe_nr)) {
+		pr_warn("invalid number of records\n");
+		set_brbe_disabled(cpuc);
+		return;
+	}
+}
+
+void arm64_pmu_brbe_enable(struct pmu_hw_events *cpuc)
+{
+	u64 brbfcr, brbcr;
+
+	if (brbe_disabled(cpuc))
+		return;
+
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbfcr &= ~(BRBFCR_BANK_MASK << BRBFCR_BANK_SHIFT);
+	brbfcr &= ~(BRBFCR_ENL | BRBFCR_PAUSED | BRBE_FCR_MASK);
+	brbfcr |= (cpuc->brbfcr & BRBE_FCR_MASK);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	brbcr &= ~BRBE_CR_MASK;
+	brbcr |= BRBCR_FZP;
+	brbcr |= (BRBCR_TS_PHYSICAL << BRBCR_TS_SHIFT);
+	brbcr |= (cpuc->brbcr & BRBE_CR_MASK);
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	isb();
+}
+
+void arm64_pmu_brbe_disable(struct pmu_hw_events *cpuc)
+{
+	u64 brbcr;
+
+	if (brbe_disabled(cpuc))
+		return;
+
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	brbcr &= ~(BRBCR_E0BRE | BRBCR_E1BRE);
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	isb();
+}
+
+static void perf_branch_to_brbfcr(struct pmu_hw_events *cpuc, int branch_type)
+{
+	cpuc->brbfcr = 0;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
+		cpuc->brbfcr |= BRBFCR_BRANCH_ALL;
+		return;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL)
+		cpuc->brbfcr |= (BRBFCR_INDCALL | BRBFCR_DIRCALL);
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		cpuc->brbfcr |= BRBFCR_RTN;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_IND_CALL)
+		cpuc->brbfcr |= BRBFCR_INDCALL;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_COND)
+		cpuc->brbfcr |= BRBFCR_CONDDIR;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_IND_JUMP)
+		cpuc->brbfcr |= BRBFCR_INDIRECT;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_CALL)
+		cpuc->brbfcr |= BRBFCR_DIRCALL;
+}
+
+static void perf_branch_to_brbcr(struct pmu_hw_events *cpuc, int branch_type, bool privilege)
+{
+	cpuc->brbcr = (BRBCR_CC | BRBCR_MPRED);
+
+	if (branch_type & PERF_SAMPLE_BRANCH_USER)
+		cpuc->brbcr |= BRBCR_E0BRE;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_KERNEL) {
+		/*
+		 * This should have been verified earlier.
+		 */
+		WARN_ON(!privilege);
+		cpuc->brbcr |= BRBCR_E1BRE;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_NO_CYCLES)
+		cpuc->brbcr &= ~BRBCR_CC;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_NO_FLAGS)
+		cpuc->brbcr &= ~BRBCR_MPRED;
+
+	if (!privilege)
+		return;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
+		cpuc->brbcr |= BRBCR_EXCEPTION;
+		cpuc->brbcr |= BRBCR_ERTN;
+		return;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL)
+		cpuc->brbcr |= BRBCR_EXCEPTION;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		cpuc->brbcr |= BRBCR_ERTN;
+}
+
+
+void arm64_pmu_brbe_filter(struct pmu_hw_events *cpuc, struct perf_event *event)
+{
+	u64 branch_type = event->attr.branch_sample_type;
+	bool privilege = arm64_pmu_brbe_has_priv(event);
+
+	if (brbe_disabled(cpuc))
+		return;
+
+	perf_branch_to_brbfcr(cpuc, branch_type);
+	perf_branch_to_brbcr(cpuc, branch_type, privilege);
+}
+
+static int brbe_fetch_perf_type(u64 brbinf, bool *new_branch_type)
+{
+	int brbe_type = brbe_fetch_type(brbinf);
+	*new_branch_type = false;
+
+	switch (brbe_type) {
+	case BRBINF_TYPE_UNCOND_DIR:
+		return PERF_BR_UNCOND;
+	case BRBINF_TYPE_INDIR:
+		return PERF_BR_IND;
+	case BRBINF_TYPE_DIR_LINK:
+		return PERF_BR_CALL;
+	case BRBINF_TYPE_INDIR_LINK:
+		return PERF_BR_IND_CALL;
+	case BRBINF_TYPE_RET_SUB:
+		return PERF_BR_RET;
+	case BRBINF_TYPE_COND_DIR:
+		return PERF_BR_COND;
+	case BRBINF_TYPE_CALL:
+		return PERF_BR_CALL;
+	case BRBINF_TYPE_TRAP:
+		return PERF_BR_SYSCALL;
+	case BRBINF_TYPE_RET_EXCPT:
+		return PERF_BR_ERET;
+	case BRBINF_TYPE_IRQ:
+		return PERF_BR_IRQ;
+	case BRBINF_TYPE_DEBUG_HALT:
+		*new_branch_type = true;
+		return PERF_BR_ARM64_DEBUG_HALT;
+	case BRBINF_TYPE_SERROR:
+		return PERF_BR_SERROR;
+	case BRBINF_TYPE_INST_DEBUG:
+		*new_branch_type = true;
+		return PERF_BR_ARM64_DEBUG_INST;
+	case BRBINF_TYPE_DATA_DEBUG:
+		*new_branch_type = true;
+		return PERF_BR_ARM64_DEBUG_DATA;
+	case BRBINF_TYPE_ALGN_FAULT:
+		*new_branch_type = true;
+		return PERF_BR_NEW_FAULT_ALGN;
+	case BRBINF_TYPE_INST_FAULT:
+		*new_branch_type = true;
+		return PERF_BR_NEW_FAULT_INST;
+	case BRBINF_TYPE_DATA_FAULT:
+		*new_branch_type = true;
+		return PERF_BR_NEW_FAULT_DATA;
+	case BRBINF_TYPE_FIQ:
+		*new_branch_type = true;
+		return PERF_BR_ARM64_FIQ;
+	case BRBINF_TYPE_DEBUG_EXIT:
+		*new_branch_type = true;
+		return PERF_BR_ARM64_DEBUG_EXIT;
+	default:
+		pr_warn("unknown branch type captured\n");
+		return PERF_BR_UNKNOWN;
+	}
+}
+
+static int brbe_fetch_perf_priv(u64 brbinf)
+{
+       int brbe_el = brbe_fetch_el(brbinf);
+
+       switch (brbe_el) {
+       case BRBINF_EL_EL0:
+               return PERF_BR_PRIV_USER;
+       case BRBINF_EL_EL1:
+               return PERF_BR_PRIV_KERNEL;
+       case BRBINF_EL_EL2:
+               if (is_kernel_in_hyp_mode())
+                       return PERF_BR_PRIV_KERNEL;
+               return PERF_BR_PRIV_HV;
+       default:
+               pr_warn("unknown branch privilege captured\n");
+               return -1;
+       }
+}
+
+static void capture_brbe_flags(struct pmu_hw_events *cpuc, struct perf_event *event,
+			       u64 brbinf, int idx)
+{
+	int branch_type, type = brbe_record_valid(brbinf);
+	bool new_branch_type;
+
+	if (!branch_sample_no_cycles(event))
+		cpuc->brbe_entries[idx].cycles = brbe_fetch_cycles(brbinf);
+
+	if (branch_sample_type(event)) {
+		branch_type = brbe_fetch_perf_type(brbinf, &new_branch_type);
+		if (new_branch_type) {
+			cpuc->brbe_entries[idx].type = PERF_BR_EXTEND_ABI;
+			cpuc->brbe_entries[idx].new_type = branch_type;
+		} else {
+			cpuc->brbe_entries[idx].type = branch_type;
+		}
+	}
+
+	if (!branch_sample_no_flags(event)) {
+		/*
+		 * BRBINF_LASTFAILED does not indicate that the last transaction
+		 * got failed or aborted during the current branch record itself.
+		 * Rather, this indicates that all the branch records which were
+		 * in transaction until the curret branch record have failed. So
+		 * the entire BRBE buffer needs to be processed later on to find
+		 * all branch records which might have failed.
+		 */
+		cpuc->brbe_entries[idx].abort = brbinf & BRBINF_LASTFAILED;
+
+		/*
+		 * All these information (i.e transaction state and mispredicts)
+		 * are not available for target only branch records.
+		 */
+		if (type != BRBINF_VALID_TARGET) {
+			cpuc->brbe_entries[idx].mispred = brbinf & BRBINF_MPRED;
+			cpuc->brbe_entries[idx].predicted = !(brbinf & BRBINF_MPRED);
+			cpuc->brbe_entries[idx].in_tx = brbinf & BRBINF_TX;
+		}
+	}
+
+	if (branch_sample_priv(event)) {
+		/*
+		 * All these information (i.e branch privilege level) are not
+		 * available for source only branch records.
+		 */
+		if (type != BRBINF_VALID_SOURCE)
+			cpuc->brbe_entries[idx].priv = brbe_fetch_perf_priv(brbinf);
+	}
+}
+
+/*
+ * A branch record with BRBINF_EL1.LASTFAILED set, implies that all
+ * preceding consecutive branch records, that were in a transaction
+ * (i.e their BRBINF_EL1.TX set) have been aborted.
+ *
+ * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
+ * consecutive branch records upto the last record, which were in a
+ * transaction (i.e their BRBINF_EL1.TX set) have been aborted.
+ *
+ * --------------------------------- -------------------
+ * | 00 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
+ * --------------------------------- -------------------
+ * | 01 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
+ * --------------------------------- -------------------
+ * | 02 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
+ * --------------------------------- -------------------
+ * | 03 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 04 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 05 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 1 |
+ * --------------------------------- -------------------
+ * | .. | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
+ * --------------------------------- -------------------
+ * | 61 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 62 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 63 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ *
+ * BRBFCR_EL1.LASTFAILED == 1
+ *
+ * Here BRBFCR_EL1.LASTFAILED failes all those consecutive and also
+ * in transaction branches near the end of the BRBE buffer.
+ */
+static void process_branch_aborts(struct pmu_hw_events *cpuc)
+{
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	bool lastfailed = !!(brbfcr & BRBFCR_LASTFAILED);
+	int idx = cpuc->brbe_nr - 1;
+
+	do {
+		if (cpuc->brbe_entries[idx].in_tx) {
+			cpuc->brbe_entries[idx].abort = lastfailed;
+		} else {
+			lastfailed = cpuc->brbe_entries[idx].abort;
+			cpuc->brbe_entries[idx].abort = false;
+		}
+	} while (idx--, idx >= 0);
+}
+
+void arm64_pmu_brbe_read(struct pmu_hw_events *cpuc, struct perf_event *event)
+{
+	u64 brbinf;
+	int idx;
+
+	if (brbe_disabled(cpuc))
+		return;
+
+	set_brbe_paused();
+	for (idx = 0; idx < cpuc->brbe_nr; idx++) {
+		select_brbe_bank_index(idx);
+		brbinf = get_brbinf_reg(idx);
+		/*
+		 * There are no valid entries anymore on the buffer.
+		 * Abort the branch record processing to save some
+		 * cycles and also reduce the capture/process load
+		 * for the user space as well.
+		 */
+		if (brbe_invalid(brbinf))
+			break;
+
+		if (brbe_valid(brbinf)) {
+			cpuc->brbe_entries[idx].from =  get_brbsrc_reg(idx);
+			cpuc->brbe_entries[idx].to =  get_brbtgt_reg(idx);
+		} else if (brbe_source(brbinf)) {
+			cpuc->brbe_entries[idx].from =  get_brbsrc_reg(idx);
+			cpuc->brbe_entries[idx].to = 0;
+		} else if (brbe_target(brbinf)) {
+			cpuc->brbe_entries[idx].from = 0;
+			cpuc->brbe_entries[idx].to =  get_brbtgt_reg(idx);
+		}
+		capture_brbe_flags(cpuc, event, brbinf, idx);
+	}
+	cpuc->brbe_stack.nr = idx;
+	cpuc->brbe_stack.hw_idx = -1ULL;
+	process_branch_aborts(cpuc);
+}
+
+void arm64_pmu_brbe_reset(struct pmu_hw_events *cpuc)
+{
+	if (brbe_disabled(cpuc))
+		return;
+
+	asm volatile(BRB_IALL);
+	isb();
+}
diff --git a/drivers/perf/arm_pmu_brbe.h b/drivers/perf/arm_pmu_brbe.h
new file mode 100644
index 000000000000..f04975cdc242
--- /dev/null
+++ b/drivers/perf/arm_pmu_brbe.h
@@ -0,0 +1,259 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Branch Record Buffer Extension Helpers.
+ *
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#define pr_fmt(fmt) "brbe: " fmt
+
+#include <linux/perf/arm_pmu.h>
+
+/*
+ * BRBE Instructions
+ *
+ * BRB_IALL : Invalidate the entire buffer
+ * BRB_INJ  : Inject latest branch record derived from [BRBSRCINJ, BRBTGTINJ, BRBINFINJ]
+ */
+#define BRB_IALL __emit_inst(0xD5000000 | sys_insn(1, 1, 7, 2, 4) | (0x1f))
+#define BRB_INJ  __emit_inst(0xD5000000 | sys_insn(1, 1, 7, 2, 5) | (0x1f))
+
+/*
+ * BRBE Buffer Organization
+ *
+ * BRBE buffer is arranged as multiple banks of 32 branch record
+ * entries each. An indivdial branch record in a given bank could
+ * be accessedi, after selecting the bank in BRBFCR_EL1.BANK and
+ * accessing the registers i.e [BRBSRC, BRBTGT, BRBINF] set with
+ * indices [0..31].
+ *
+ * Bank 0
+ *
+ *	---------------------------------	------
+ *	| 00 | BRBSRC | BRBTGT | BRBINF |	| 00 |
+ *	---------------------------------	------
+ *	| 01 | BRBSRC | BRBTGT | BRBINF |	| 01 |
+ *	---------------------------------	------
+ *	| .. | BRBSRC | BRBTGT | BRBINF |	| .. |
+ *	---------------------------------	------
+ *	| 31 | BRBSRC | BRBTGT | BRBINF |	| 31 |
+ *	---------------------------------	------
+ *
+ * Bank 1
+ *
+ *	---------------------------------	------
+ *	| 32 | BRBSRC | BRBTGT | BRBINF |	| 00 |
+ *	---------------------------------	------
+ *	| 33 | BRBSRC | BRBTGT | BRBINF |	| 01 |
+ *	---------------------------------	------
+ *	| .. | BRBSRC | BRBTGT | BRBINF |	| .. |
+ *	---------------------------------	------
+ *	| 63 | BRBSRC | BRBTGT | BRBINF |	| 31 |
+ *	---------------------------------	------
+ */
+#define BRBE_BANK0_IDX_MIN 0
+#define BRBE_BANK0_IDX_MAX 31
+#define BRBE_BANK1_IDX_MIN 32
+#define BRBE_BANK1_IDX_MAX 63
+
+#define RETURN_READ_BRBSRCN(n) \
+	read_sysreg_s(SYS_BRBSRC##n##_EL1)
+
+#define RETURN_READ_BRBTGTN(n) \
+	read_sysreg_s(SYS_BRBTGT##n##_EL1)
+
+#define RETURN_READ_BRBINFN(n) \
+	read_sysreg_s(SYS_BRBINF##n##_EL1)
+
+#define BRBE_REGN_CASE(n, case_macro) \
+	case n: return case_macro(n); break
+
+#define BRBE_REGN_SWITCH(x, case_macro)				\
+	do {							\
+		switch (x) {					\
+		BRBE_REGN_CASE(0, case_macro);			\
+		BRBE_REGN_CASE(1, case_macro);			\
+		BRBE_REGN_CASE(2, case_macro);			\
+		BRBE_REGN_CASE(3, case_macro);			\
+		BRBE_REGN_CASE(4, case_macro);			\
+		BRBE_REGN_CASE(5, case_macro);			\
+		BRBE_REGN_CASE(6, case_macro);			\
+		BRBE_REGN_CASE(7, case_macro);			\
+		BRBE_REGN_CASE(8, case_macro);			\
+		BRBE_REGN_CASE(9, case_macro);			\
+		BRBE_REGN_CASE(10, case_macro);			\
+		BRBE_REGN_CASE(11, case_macro);			\
+		BRBE_REGN_CASE(12, case_macro);			\
+		BRBE_REGN_CASE(13, case_macro);			\
+		BRBE_REGN_CASE(14, case_macro);			\
+		BRBE_REGN_CASE(15, case_macro);			\
+		BRBE_REGN_CASE(16, case_macro);			\
+		BRBE_REGN_CASE(17, case_macro);			\
+		BRBE_REGN_CASE(18, case_macro);			\
+		BRBE_REGN_CASE(19, case_macro);			\
+		BRBE_REGN_CASE(20, case_macro);			\
+		BRBE_REGN_CASE(21, case_macro);			\
+		BRBE_REGN_CASE(22, case_macro);			\
+		BRBE_REGN_CASE(23, case_macro);			\
+		BRBE_REGN_CASE(24, case_macro);			\
+		BRBE_REGN_CASE(25, case_macro);			\
+		BRBE_REGN_CASE(26, case_macro);			\
+		BRBE_REGN_CASE(27, case_macro);			\
+		BRBE_REGN_CASE(28, case_macro);			\
+		BRBE_REGN_CASE(29, case_macro);			\
+		BRBE_REGN_CASE(30, case_macro);			\
+		BRBE_REGN_CASE(31, case_macro);			\
+		default:					\
+			pr_warn("unknown register index\n");	\
+			return -1;				\
+		}						\
+	} while (0)
+
+static inline int buffer_to_brbe_idx(int buffer_idx)
+{
+	return buffer_idx % 32;
+}
+
+static inline u64 get_brbsrc_reg(int buffer_idx)
+{
+	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
+
+	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBSRCN);
+}
+
+static inline u64 get_brbtgt_reg(int buffer_idx)
+{
+	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
+
+	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBTGTN);
+}
+
+static inline u64 get_brbinf_reg(int buffer_idx)
+{
+	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
+
+	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBINFN);
+}
+
+static inline u64 brbe_record_valid(u64 brbinf)
+{
+	return brbinf & (BRBINF_VALID_MASK << BRBINF_VALID_SHIFT);
+}
+
+static inline bool brbe_invalid(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_VALID_INVALID;
+}
+
+static inline bool brbe_valid(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_VALID_ALL;
+}
+
+static inline bool brbe_source(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_VALID_SOURCE;
+}
+
+static inline bool brbe_target(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINF_VALID_TARGET;
+}
+
+static inline int brbe_fetch_cycles(u64 brbinf)
+{
+	/*
+	 * Captured cycle count is unknown and hence
+	 * should not be passed on the user space.
+	 */
+	if (brbinf & BRBINF_CCU)
+		return 0;
+
+	return (brbinf >> BRBINF_CC_SHIFT) & BRBINF_CC_MASK;
+}
+
+static inline int brbe_fetch_type(u64 brbinf)
+{
+	return (brbinf >> BRBINF_TYPE_SHIFT) & BRBINF_TYPE_MASK;
+}
+
+static inline int brbe_fetch_el(u64 brbinf)
+{
+	return (brbinf >> BRBINF_EL_SHIFT) & BRBINF_EL_MASK;
+}
+
+static inline int brbe_fetch_numrec(u64 brbidr)
+{
+	return (brbidr >> BRBIDR0_NUMREC_SHIFT) & BRBIDR0_NUMREC_MASK;
+}
+
+static inline int brbe_fetch_format(u64 brbidr)
+{
+	return (brbidr >> BRBIDR0_FORMAT_SHIFT) & BRBIDR0_FORMAT_MASK;
+}
+
+static inline int brbe_fetch_cc_bits(u64 brbidr)
+{
+	return (brbidr >> BRBIDR0_CC_SHIFT) & BRBIDR0_CC_MASK;
+}
+
+static inline void select_brbe_bank(int bank)
+{
+	static int brbe_current_bank = -1;
+	u64 brbfcr;
+
+	if (brbe_current_bank == bank)
+		return;
+
+	WARN_ON(bank > 1);
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbfcr &= ~(BRBFCR_BANK_MASK << BRBFCR_BANK_SHIFT);
+	brbfcr |= ((bank & BRBFCR_BANK_MASK) << BRBFCR_BANK_SHIFT);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+	brbe_current_bank = bank;
+}
+
+static inline void select_brbe_bank_index(int buffer_idx)
+{
+	switch (buffer_idx) {
+	case BRBE_BANK0_IDX_MIN ... BRBE_BANK0_IDX_MAX:
+		select_brbe_bank(0);
+		break;
+	case BRBE_BANK1_IDX_MIN ... BRBE_BANK1_IDX_MAX:
+		select_brbe_bank(1);
+		break;
+	default:
+		pr_warn("unsupported BRBE index\n");
+	}
+}
+
+static inline bool valid_brbe_nr(int brbe_nr)
+{
+	switch (brbe_nr) {
+	case BRBIDR0_NUMREC_8:
+	case BRBIDR0_NUMREC_16:
+	case BRBIDR0_NUMREC_32:
+	case BRBIDR0_NUMREC_64:
+		return true;
+	default:
+		pr_warn("unsupported BRBE entries\n");
+		return false;
+	}
+}
+
+static inline bool brbe_paused(void)
+{
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+
+	return brbfcr & BRBFCR_PAUSED;
+}
+
+static inline void set_brbe_paused(void)
+{
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+
+	write_sysreg_s(brbfcr | BRBFCR_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+}
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 67f44020a736..3e7757d05146 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -166,6 +166,26 @@ struct arm_pmu {
 	unsigned long acpi_cpuid;
 };
 
+#ifdef CONFIG_ARM_BRBE_PMU
+void arm64_pmu_brbe_filter(struct pmu_hw_events *hw_events, struct perf_event *event);
+void arm64_pmu_brbe_read(struct pmu_hw_events *cpuc, struct perf_event *event);
+void arm64_pmu_brbe_disable(struct pmu_hw_events *cpuc);
+void arm64_pmu_brbe_enable(struct pmu_hw_events *cpuc);
+void arm64_pmu_brbe_probe(struct pmu_hw_events *cpuc);
+void arm64_pmu_brbe_reset(struct pmu_hw_events *cpuc);
+bool arm64_pmu_brbe_supported(struct perf_event *event);
+#else
+static inline void arm64_pmu_brbe_filter(struct pmu_hw_events *hw_events, struct perf_event *event)
+{
+}
+static inline void arm64_pmu_brbe_read(struct pmu_hw_events *cpuc, struct perf_event *event) { }
+static inline void arm64_pmu_brbe_disable(struct pmu_hw_events *cpuc) { }
+static inline void arm64_pmu_brbe_enable(struct pmu_hw_events *cpuc) { }
+static inline void arm64_pmu_brbe_probe(struct pmu_hw_events *cpuc) { }
+static inline void arm64_pmu_brbe_reset(struct pmu_hw_events *cpuc) { }
+static inline bool arm64_pmu_brbe_supported(struct perf_event *event) {return false; }
+#endif
+
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
 
 u64 armpmu_event_update(struct perf_event *event);
-- 
2.25.1

