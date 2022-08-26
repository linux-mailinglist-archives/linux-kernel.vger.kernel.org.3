Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1D5A31DD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbiHZWRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345214AbiHZWQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:16:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCFFDB059;
        Fri, 26 Aug 2022 15:16:06 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:16:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552164;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rRzX/sbne1RUALddC9ZAWXfpnQiCuaP0T042bQzezg=;
        b=i/GfG0hzF5vV47IbcbbP/SDHWHOqcKbPVptqfR/d0M8jUMKT4363Uk8Ca4D9T5lF6bOZtC
        YgB59oEpnJODd/mPZiK10L+0Cv3745jynl/UdAyRbMryMqAcO4adcKB3/1+aHTfpAAxN6Q
        F4EtL4N1g2TDj20xo16vjurKTm6DrQ6HXDoivz4dD9T5t4E0JnnP93yhNPfkGgU2JQKsQB
        0ABh4Dp0wJ13J8e0AXkdnUnRlcHO7kyRb6sqyT6hPMgfjAX8K3QbQLhYja9biH2PAv4NgQ
        nPd2MrGWG6Pp1GGBSEIZiqkbQicFzxESi2VIEhVRf8YsVqBSKy0NOGG6pELZeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552164;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rRzX/sbne1RUALddC9ZAWXfpnQiCuaP0T042bQzezg=;
        b=LFzgu1ZODLjRX9ePeXyRiRj4wLcAMSCs/UDEMAvMgXeLro4anHoGkjuj4ilh6tCgRcsXJF
        WoFpZBkq846U3CDQ==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/lbr: Add LbrExtV2 hardware branch
 filter support
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9336af5c9785b8e14c62220fc0e6cfb10ab97de3=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C9336af5c9785b8e14c62220fc0e6cfb10ab97de3=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155216253.401.3296757431619664581.tip-bot2@tip-bot2>
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

Commit-ID:     f4f925dae7419fc7a10af539c073871927ce3a24
Gitweb:        https://git.kernel.org/tip/f4f925dae7419fc7a10af539c073871927ce3a24
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 17:59:55 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:43 +02:00

perf/x86/amd/lbr: Add LbrExtV2 hardware branch filter support

If AMD Last Branch Record Extension Version 2 (LbrExtV2) is detected,
convert the requested branch filter (PERF_SAMPLE_BRANCH_* flags) to the
corresponding hardware filter value and stash it in the event data when
a branch stack is requested. The hardware filter value is also saved in
per-CPU areas for use during event scheduling.

Hardware filtering is provided by the LBR Branch Select register. It has
bits which when set, suppress recording of the following types of branches:

  * CPL = 0 (Kernel only)
  * CPL > 0 (Userspace only)
  * Conditional Branches
  * Near Relative Calls
  * Near Indirect Calls
  * Near Returns
  * Near Indirect Jumps (excluding Near Indirect Calls and Near Returns)
  * Near Relative Jumps (excluding Near Relative Calls)
  * Far Branches

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/9336af5c9785b8e14c62220fc0e6cfb10ab97de3.1660211399.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 21 +++++---
 arch/x86/events/amd/lbr.c  | 94 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index d799628..36bede1 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -542,16 +542,24 @@ static int amd_pmu_cpu_prepare(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 
+	cpuc->lbr_sel = kzalloc_node(sizeof(struct er_account), GFP_KERNEL,
+				     cpu_to_node(cpu));
+	if (!cpuc->lbr_sel)
+		return -ENOMEM;
+
 	WARN_ON_ONCE(cpuc->amd_nb);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return 0;
 
 	cpuc->amd_nb = amd_alloc_nb(cpu);
-	if (!cpuc->amd_nb)
-		return -ENOMEM;
+	if (cpuc->amd_nb)
+		return 0;
 
-	return 0;
+	kfree(cpuc->lbr_sel);
+	cpuc->lbr_sel = NULL;
+
+	return -ENOMEM;
 }
 
 static void amd_pmu_cpu_starting(int cpu)
@@ -589,13 +597,14 @@ static void amd_pmu_cpu_starting(int cpu)
 
 static void amd_pmu_cpu_dead(int cpu)
 {
-	struct cpu_hw_events *cpuhw;
+	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
+
+	kfree(cpuhw->lbr_sel);
+	cpuhw->lbr_sel = NULL;
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
 
-	cpuhw = &per_cpu(cpu_hw_events, cpu);
-
 	if (cpuhw->amd_nb) {
 		struct amd_nb *nb = cpuhw->amd_nb;
 
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 1dea66f..bb79b43 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -4,6 +4,39 @@
 
 #include "../perf_event.h"
 
+/* LBR Branch Select valid bits */
+#define LBR_SELECT_MASK		0x1ff
+
+/*
+ * LBR Branch Select filter bits which when set, ensures that the
+ * corresponding type of branches are not recorded
+ */
+#define LBR_SELECT_KERNEL		0	/* Branches ending in CPL = 0 */
+#define LBR_SELECT_USER			1	/* Branches ending in CPL > 0 */
+#define LBR_SELECT_JCC			2	/* Conditional branches */
+#define LBR_SELECT_CALL_NEAR_REL	3	/* Near relative calls */
+#define LBR_SELECT_CALL_NEAR_IND	4	/* Indirect relative calls */
+#define LBR_SELECT_RET_NEAR		5	/* Near returns */
+#define LBR_SELECT_JMP_NEAR_IND		6	/* Near indirect jumps (excl. calls and returns) */
+#define LBR_SELECT_JMP_NEAR_REL		7	/* Near relative jumps (excl. calls) */
+#define LBR_SELECT_FAR_BRANCH		8	/* Far branches */
+
+#define LBR_KERNEL	BIT(LBR_SELECT_KERNEL)
+#define LBR_USER	BIT(LBR_SELECT_USER)
+#define LBR_JCC		BIT(LBR_SELECT_JCC)
+#define LBR_REL_CALL	BIT(LBR_SELECT_CALL_NEAR_REL)
+#define LBR_IND_CALL	BIT(LBR_SELECT_CALL_NEAR_IND)
+#define LBR_RETURN	BIT(LBR_SELECT_RET_NEAR)
+#define LBR_REL_JMP	BIT(LBR_SELECT_JMP_NEAR_REL)
+#define LBR_IND_JMP	BIT(LBR_SELECT_JMP_NEAR_IND)
+#define LBR_FAR		BIT(LBR_SELECT_FAR_BRANCH)
+#define LBR_NOT_SUPP	-1	/* unsupported filter */
+#define LBR_IGNORE	0
+
+#define LBR_ANY		\
+	(LBR_JCC | LBR_REL_CALL | LBR_IND_CALL | LBR_RETURN |	\
+	 LBR_REL_JMP | LBR_IND_JMP | LBR_FAR)
+
 struct branch_entry {
 	union {
 		struct {
@@ -97,12 +130,56 @@ void amd_pmu_lbr_read(void)
 	cpuc->lbr_stack.hw_idx = 0;
 }
 
+static const int lbr_select_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
+	[PERF_SAMPLE_BRANCH_USER_SHIFT]		= LBR_USER,
+	[PERF_SAMPLE_BRANCH_KERNEL_SHIFT]	= LBR_KERNEL,
+	[PERF_SAMPLE_BRANCH_HV_SHIFT]		= LBR_IGNORE,
+
+	[PERF_SAMPLE_BRANCH_ANY_SHIFT]		= LBR_ANY,
+	[PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT]	= LBR_REL_CALL | LBR_IND_CALL,
+	[PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT]	= LBR_RETURN,
+	[PERF_SAMPLE_BRANCH_IND_CALL_SHIFT]	= LBR_IND_CALL,
+	[PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT]	= LBR_NOT_SUPP,
+	[PERF_SAMPLE_BRANCH_IN_TX_SHIFT]	= LBR_NOT_SUPP,
+	[PERF_SAMPLE_BRANCH_NO_TX_SHIFT]	= LBR_NOT_SUPP,
+	[PERF_SAMPLE_BRANCH_COND_SHIFT]		= LBR_JCC,
+
+	[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT]	= LBR_NOT_SUPP,
+	[PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT]	= LBR_IND_JMP,
+	[PERF_SAMPLE_BRANCH_CALL_SHIFT]		= LBR_REL_CALL,
+
+	[PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT]	= LBR_NOT_SUPP,
+	[PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT]	= LBR_NOT_SUPP,
+
+	[PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT]	= LBR_NOT_SUPP,
+};
+
 static int amd_pmu_lbr_setup_filter(struct perf_event *event)
 {
+	struct hw_perf_event_extra *reg = &event->hw.branch_reg;
+	u64 br_type = event->attr.branch_sample_type;
+	u64 mask = 0, v;
+	int i;
+
 	/* No LBR support */
 	if (!x86_pmu.lbr_nr)
 		return -EOPNOTSUPP;
 
+	for (i = 0; i < PERF_SAMPLE_BRANCH_MAX_SHIFT; i++) {
+		if (!(br_type & BIT_ULL(i)))
+			continue;
+
+		v = lbr_select_map[i];
+		if (v == LBR_NOT_SUPP)
+			return -EOPNOTSUPP;
+
+		if (v != LBR_IGNORE)
+			mask |= v;
+	}
+
+	/* Filter bits operate in suppress mode */
+	reg->config = mask ^ LBR_SELECT_MASK;
+
 	return 0;
 }
 
@@ -137,6 +214,7 @@ void amd_pmu_lbr_reset(void)
 
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
+	wrmsrl(MSR_AMD64_LBR_SELECT, 0);
 }
 
 void amd_pmu_lbr_add(struct perf_event *event)
@@ -146,6 +224,11 @@ void amd_pmu_lbr_add(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return;
 
+	if (has_branch_stack(event)) {
+		cpuc->lbr_select = 1;
+		cpuc->lbr_sel->config = event->hw.branch_reg.config;
+	}
+
 	perf_sched_cb_inc(event->ctx->pmu);
 
 	if (!cpuc->lbr_users++ && !event->total_time_running)
@@ -159,6 +242,9 @@ void amd_pmu_lbr_del(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return;
 
+	if (has_branch_stack(event))
+		cpuc->lbr_select = 0;
+
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	perf_sched_cb_dec(event->ctx->pmu);
@@ -180,11 +266,17 @@ void amd_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
 void amd_pmu_lbr_enable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 dbg_ctl, dbg_extn_cfg;
+	u64 lbr_select, dbg_ctl, dbg_extn_cfg;
 
 	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
 		return;
 
+	/* Set hardware branch filter */
+	if (cpuc->lbr_select) {
+		lbr_select = cpuc->lbr_sel->config & LBR_SELECT_MASK;
+		wrmsrl(MSR_AMD64_LBR_SELECT, lbr_select);
+	}
+
 	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
 	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 
