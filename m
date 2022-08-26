Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FEC5A31E5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbiHZWRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345222AbiHZWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:16:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38650DAA3F;
        Fri, 26 Aug 2022 15:16:07 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:16:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9Mqq/1BAwbcxsY7WgTmcfQEIA1PeuF35Waoayn0GSc=;
        b=m5QwqF50BNJAI4cWAdCjiTY5tX0B8bqDuOM04b9IOpebWSYDlPJVp6J3Q8JuMMzTzbKi0q
        KzFR1FHdhHjoBY/amkVDVCZyxYuMaMKRlq0BGM3pjQAtl5sAsXeeTnFgjCkjbxplKwRCk0
        xScjYOALIuMq7tsHc7AQtabHasVHvBw01n/btzdmYFv781Myo1ym190VRQmAY2HLjVhOXS
        TORQ1yyd7MKvRadVysTrrlGFYQGGufXDONmo5KzQxtk+zg8rj1ngkGJLW4sjVtuf91O9/b
        CwlsB3needLZXFT2HSiDeclJsBSV5orWbcbS2y2FYP63VYsv/M8QymzvRBwFyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9Mqq/1BAwbcxsY7WgTmcfQEIA1PeuF35Waoayn0GSc=;
        b=wee+H3oXufBifuPYglVom//ZgNDt27W7/ekWJFeVTvbc+mrDGyIE9JkSuAKxa0Hm2hFHQc
        CizpBx6QDlQlp6Bg==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/lbr: Add LbrExtV2 branch record support
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd3b8500a3627a0d4d0259b005891ee248f248d91=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cd3b8500a3627a0d4d0259b005891ee248f248d91=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155216401.401.5809694678609694438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ca5b7c0d9621702e107c83216316a6d722878b64
Gitweb:        https://git.kernel.org/tip/ca5b7c0d9621702e107c83216316a6d722878b64
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 17:59:54 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:43 +02:00

perf/x86/amd/lbr: Add LbrExtV2 branch record support

If AMD Last Branch Record Extension Version 2 (LbrExtV2) is detected,
enable it alongside LBR Freeze on PMI when an event requests branch stack
i.e. PERF_SAMPLE_BRANCH_STACK.

Each branch record is represented by a pair of registers, LBR From and LBR
To. The freeze feature prevents any updates to these registers once a PMC
overflows. The contents remain unchanged until the freeze bit is cleared by
the PMI handler.

The branch records are read and copied to sample data before unfreezing.
However, only valid entries are copied. There is no additional register to
denote which of the register pairs represent the top of the stack (TOS)
since internal register renaming always ensures that the first pair (i.e.
index 0) is the one representing the most recent branch and so on.

The LBR registers are per-thread resources and are cleared explicitly
whenever a new task is scheduled in. There are no special implications on
the contents of these registers when transitioning to deep C-states.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/d3b8500a3627a0d4d0259b005891ee248f248d91.1660211399.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c       |  47 +++++--
 arch/x86/events/amd/lbr.c        | 203 ++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h     |   8 +-
 arch/x86/include/asm/msr-index.h |   5 +-
 4 files changed, 252 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index a3aa67b..d799628 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -620,7 +620,7 @@ static inline u64 amd_pmu_get_global_status(void)
 	/* PerfCntrGlobalStatus is read-only */
 	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
 
-	return status & amd_pmu_global_cntr_mask;
+	return status;
 }
 
 static inline void amd_pmu_ack_global_status(u64 status)
@@ -631,8 +631,6 @@ static inline void amd_pmu_ack_global_status(u64 status)
 	 * clears the same bit in PerfCntrGlobalStatus
 	 */
 
-	/* Only allow modifications to PerfCntrGlobalStatus.PerfCntrOvfl */
-	status &= amd_pmu_global_cntr_mask;
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
 }
 
@@ -742,11 +740,17 @@ static void amd_pmu_v2_enable_event(struct perf_event *event)
 	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
 }
 
-static void amd_pmu_v2_enable_all(int added)
+static __always_inline void amd_pmu_core_enable_all(void)
 {
 	amd_pmu_set_global_ctl(amd_pmu_global_cntr_mask);
 }
 
+static void amd_pmu_v2_enable_all(int added)
+{
+	amd_pmu_lbr_enable_all();
+	amd_pmu_core_enable_all();
+}
+
 static void amd_pmu_disable_event(struct perf_event *event)
 {
 	x86_pmu_disable_event(event);
@@ -771,10 +775,15 @@ static void amd_pmu_disable_all(void)
 	amd_pmu_check_overflow();
 }
 
-static void amd_pmu_v2_disable_all(void)
+static __always_inline void amd_pmu_core_disable_all(void)
 {
-	/* Disable all PMCs */
 	amd_pmu_set_global_ctl(0);
+}
+
+static void amd_pmu_v2_disable_all(void)
+{
+	amd_pmu_core_disable_all();
+	amd_pmu_lbr_disable_all();
 	amd_pmu_check_overflow();
 }
 
@@ -877,8 +886,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	pmu_enabled = cpuc->enabled;
 	cpuc->enabled = 0;
 
-	/* Stop counting */
-	amd_pmu_v2_disable_all();
+	/* Stop counting but do not disable LBR */
+	amd_pmu_core_disable_all();
 
 	status = amd_pmu_get_global_status();
 
@@ -886,6 +895,12 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	if (!status)
 		goto done;
 
+	/* Read branch records before unfreezing */
+	if (status & GLOBAL_STATUS_LBRS_FROZEN) {
+		amd_pmu_lbr_read();
+		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
+	}
+
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
@@ -905,6 +920,9 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
+		if (has_branch_stack(event))
+			data.br_stack = &cpuc->lbr_stack;
+
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
 
@@ -918,7 +936,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	 */
 	WARN_ON(status > 0);
 
-	/* Clear overflow bits */
+	/* Clear overflow and freeze bits */
 	amd_pmu_ack_global_status(~status);
 
 	/*
@@ -932,7 +950,7 @@ done:
 
 	/* Resume counting only if PMU is active */
 	if (pmu_enabled)
-		amd_pmu_v2_enable_all(0);
+		amd_pmu_core_enable_all();
 
 	return amd_pmu_adjust_nmi_window(handled);
 }
@@ -1375,7 +1393,14 @@ static int __init amd_core_pmu_init(void)
 	}
 
 	/* LBR and BRS are mutually exclusive features */
-	if (amd_pmu_lbr_init() && !amd_brs_init()) {
+	if (!amd_pmu_lbr_init()) {
+		/* LBR requires flushing on context switch */
+		x86_pmu.sched_task = amd_pmu_lbr_sched_task;
+		static_call_update(amd_pmu_branch_hw_config, amd_pmu_lbr_hw_config);
+		static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_reset);
+		static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
+		static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
+	} else if (!amd_brs_init()) {
 		/*
 		 * BRS requires special event constraints and flushing on ctxsw.
 		 */
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 4e5b5d3..1dea66f 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -4,6 +4,209 @@
 
 #include "../perf_event.h"
 
+struct branch_entry {
+	union {
+		struct {
+			u64	ip:58;
+			u64	ip_sign_ext:5;
+			u64	mispredict:1;
+		} split;
+		u64		full;
+	} from;
+
+	union {
+		struct {
+			u64	ip:58;
+			u64	ip_sign_ext:3;
+			u64	reserved:1;
+			u64	spec:1;
+			u64	valid:1;
+		} split;
+		u64		full;
+	} to;
+};
+
+static __always_inline void amd_pmu_lbr_set_from(unsigned int idx, u64 val)
+{
+	wrmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2, val);
+}
+
+static __always_inline void amd_pmu_lbr_set_to(unsigned int idx, u64 val)
+{
+	wrmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2 + 1, val);
+}
+
+static __always_inline u64 amd_pmu_lbr_get_from(unsigned int idx)
+{
+	u64 val;
+
+	rdmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2, val);
+
+	return val;
+}
+
+static __always_inline u64 amd_pmu_lbr_get_to(unsigned int idx)
+{
+	u64 val;
+
+	rdmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2 + 1, val);
+
+	return val;
+}
+
+static __always_inline u64 sign_ext_branch_ip(u64 ip)
+{
+	u32 shift = 64 - boot_cpu_data.x86_virt_bits;
+
+	return (u64)(((s64)ip << shift) >> shift);
+}
+
+void amd_pmu_lbr_read(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_branch_entry *br = cpuc->lbr_entries;
+	struct branch_entry entry;
+	int out = 0, i;
+
+	if (!cpuc->lbr_users)
+		return;
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		entry.from.full	= amd_pmu_lbr_get_from(i);
+		entry.to.full	= amd_pmu_lbr_get_to(i);
+
+		/* Check if a branch has been logged */
+		if (!entry.to.split.valid)
+			continue;
+
+		perf_clear_branch_entry_bitfields(br + out);
+
+		br[out].from	= sign_ext_branch_ip(entry.from.split.ip);
+		br[out].to	= sign_ext_branch_ip(entry.to.split.ip);
+		br[out].mispred	= entry.from.split.mispredict;
+		br[out].predicted = !br[out].mispred;
+		out++;
+	}
+
+	cpuc->lbr_stack.nr = out;
+
+	/*
+	 * Internal register renaming always ensures that LBR From[0] and
+	 * LBR To[0] always represent the TOS
+	 */
+	cpuc->lbr_stack.hw_idx = 0;
+}
+
+static int amd_pmu_lbr_setup_filter(struct perf_event *event)
+{
+	/* No LBR support */
+	if (!x86_pmu.lbr_nr)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+int amd_pmu_lbr_hw_config(struct perf_event *event)
+{
+	int ret = 0;
+
+	/* LBR is not recommended in counting mode */
+	if (!is_sampling_event(event))
+		return -EINVAL;
+
+	ret = amd_pmu_lbr_setup_filter(event);
+	if (!ret)
+		event->attach_state |= PERF_ATTACH_SCHED_CB;
+
+	return ret;
+}
+
+void amd_pmu_lbr_reset(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int i;
+
+	if (!x86_pmu.lbr_nr)
+		return;
+
+	/* Reset all branch records individually */
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		amd_pmu_lbr_set_from(i, 0);
+		amd_pmu_lbr_set_to(i, 0);
+	}
+
+	cpuc->last_task_ctx = NULL;
+	cpuc->last_log_id = 0;
+}
+
+void amd_pmu_lbr_add(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (!x86_pmu.lbr_nr)
+		return;
+
+	perf_sched_cb_inc(event->ctx->pmu);
+
+	if (!cpuc->lbr_users++ && !event->total_time_running)
+		amd_pmu_lbr_reset();
+}
+
+void amd_pmu_lbr_del(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (!x86_pmu.lbr_nr)
+		return;
+
+	cpuc->lbr_users--;
+	WARN_ON_ONCE(cpuc->lbr_users < 0);
+	perf_sched_cb_dec(event->ctx->pmu);
+}
+
+void amd_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/*
+	 * A context switch can flip the address space and LBR entries are
+	 * not tagged with an identifier. Hence, branches cannot be resolved
+	 * from the old address space and the LBR records should be wiped.
+	 */
+	if (cpuc->lbr_users && sched_in)
+		amd_pmu_lbr_reset();
+}
+
+void amd_pmu_lbr_enable_all(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 dbg_ctl, dbg_extn_cfg;
+
+	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
+		return;
+
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
+}
+
+void amd_pmu_lbr_disable_all(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 dbg_ctl, dbg_extn_cfg;
+
+	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
+		return;
+
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+
+	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+}
+
 __init int amd_pmu_lbr_init(void)
 {
 	union cpuid_0x80000022_ebx ebx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 82e8a6d..e893041 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1233,6 +1233,14 @@ static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 int amd_pmu_init(void);
 
 int amd_pmu_lbr_init(void);
+void amd_pmu_lbr_reset(void);
+void amd_pmu_lbr_read(void);
+void amd_pmu_lbr_add(struct perf_event *event);
+void amd_pmu_lbr_del(struct perf_event *event);
+void amd_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
+void amd_pmu_lbr_enable_all(void);
+void amd_pmu_lbr_disable_all(void);
+int amd_pmu_lbr_hw_config(struct perf_event *event);
 
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6674bdb..109c404 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -585,6 +585,9 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Last Branch Record MSRs */
+#define MSR_AMD64_LBR_SELECT			0xc000010e
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
@@ -756,6 +759,8 @@
 #define MSR_AMD_DBG_EXTN_CFG		0xc000010f
 #define MSR_AMD_SAMP_BR_FROM		0xc0010300
 
+#define DBG_EXTN_CFG_LBRV2EN		BIT_ULL(6)
+
 #define MSR_IA32_MPERF			0x000000e7
 #define MSR_IA32_APERF			0x000000e8
 
