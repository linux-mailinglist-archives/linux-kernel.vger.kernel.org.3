Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2DD5A31DB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345244AbiHZWQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345143AbiHZWQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:16:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2311DD5EB6;
        Fri, 26 Aug 2022 15:16:02 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552161;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctiKVTlD6jzylASXGBdPyhqVyAOegWb/kKjxwGhTH9c=;
        b=K2s4M8NJIo6K5sjSNGHArye0c1k/IgK84aBEGSyaEWUTCOOGVwRZWRnX9iYuUdAEBMqps8
        03Cw/M9y1rtPLHrPR+hZP/GF1NlSZ6bygKfQf00yEtFmax/Wb5eJgovexYNGYsO0iAzKnw
        vIbTzFW7VCHHoQdEmNJVTZXACDfYZbRO1l05j0iGkGKSf8LwvBXY/Pi886YPp7POrC6F0t
        T/9SIRDP+hQRZerlC8fEMuDZZLcUEIjpYRwVobgwp+nxYQ9imwmd7KtRUCnG9jNUffPhiu
        nFuXihwdSyimhEBR1/BAGkYF1yBUR7TjyOvyVe4YnuXdvqhCeJ8W7vQpql221A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552161;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctiKVTlD6jzylASXGBdPyhqVyAOegWb/kKjxwGhTH9c=;
        b=C9Wx/sTIaUTUGBXJNzCcC0ZkuhzP/YNADqyBE8sSTL6Wrx9WPUXpYo0Rypcpdv1zLg7cUR
        scfwgIHxIqkj/TDQ==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/lbr: Add LbrExtV2 software branch
 filter support
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce51de057517f77788abd393c832e8dea616d489c=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ce51de057517f77788abd393c832e8dea616d489c=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155215963.401.15843645403081654554.tip-bot2@tip-bot2>
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

Commit-ID:     f9c732249b110fae9ebf4ce33db4cb3a12c6eae3
Gitweb:        https://git.kernel.org/tip/f9c732249b110fae9ebf4ce33db4cb3a12c6eae3
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 17:59:57 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:44 +02:00

perf/x86/amd/lbr: Add LbrExtV2 software branch filter support

With AMD Last Branch Record Extension Version 2 (LbrExtV2), it is necessary
to process the branch records further as hardware filtering is not granular
enough for identifying certain types of branches. E.g. to record system
calls, one should record far branches. The filter captures both far calls
and far returns but the irrelevant records are filtered out based on the
branch type as seen by the branch classifier.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/e51de057517f77788abd393c832e8dea616d489c.1660211399.git.sandipan.das@amd.com
---
 arch/x86/events/amd/lbr.c | 92 +++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index bb79b43..1a8d27e 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -94,6 +94,50 @@ static __always_inline u64 sign_ext_branch_ip(u64 ip)
 	return (u64)(((s64)ip << shift) >> shift);
 }
 
+static void amd_pmu_lbr_filter(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int br_sel = cpuc->br_sel, type, i, j;
+	bool compress = false;
+	u64 from, to;
+
+	/* If sampling all branches, there is nothing to filter */
+	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
+	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
+		return;
+
+	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
+		from = cpuc->lbr_entries[i].from;
+		to = cpuc->lbr_entries[i].to;
+		type = branch_type(from, to, 0);
+
+		/* If type does not correspond, then discard */
+		if (type == X86_BR_NONE || (br_sel & type) != type) {
+			cpuc->lbr_entries[i].from = 0;	/* mark invalid */
+			compress = true;
+		}
+
+		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
+			cpuc->lbr_entries[i].type = common_branch_type(type);
+	}
+
+	if (!compress)
+		return;
+
+	/* Remove all invalid entries */
+	for (i = 0; i < cpuc->lbr_stack.nr; ) {
+		if (!cpuc->lbr_entries[i].from) {
+			j = i;
+			while (++j < cpuc->lbr_stack.nr)
+				cpuc->lbr_entries[j - 1] = cpuc->lbr_entries[j];
+			cpuc->lbr_stack.nr--;
+			if (!cpuc->lbr_entries[i].from)
+				continue;
+		}
+		i++;
+	}
+}
+
 void amd_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -128,6 +172,9 @@ void amd_pmu_lbr_read(void)
 	 * LBR To[0] always represent the TOS
 	 */
 	cpuc->lbr_stack.hw_idx = 0;
+
+	/* Perform further software filtering */
+	amd_pmu_lbr_filter();
 }
 
 static const int lbr_select_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
@@ -136,8 +183,8 @@ static const int lbr_select_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
 	[PERF_SAMPLE_BRANCH_HV_SHIFT]		= LBR_IGNORE,
 
 	[PERF_SAMPLE_BRANCH_ANY_SHIFT]		= LBR_ANY,
-	[PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT]	= LBR_REL_CALL | LBR_IND_CALL,
-	[PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT]	= LBR_RETURN,
+	[PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT]	= LBR_REL_CALL | LBR_IND_CALL | LBR_FAR,
+	[PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT]	= LBR_RETURN | LBR_FAR,
 	[PERF_SAMPLE_BRANCH_IND_CALL_SHIFT]	= LBR_IND_CALL,
 	[PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT]	= LBR_NOT_SUPP,
 	[PERF_SAMPLE_BRANCH_IN_TX_SHIFT]	= LBR_NOT_SUPP,
@@ -150,8 +197,6 @@ static const int lbr_select_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
 
 	[PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT]	= LBR_NOT_SUPP,
 	[PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT]	= LBR_NOT_SUPP,
-
-	[PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT]	= LBR_NOT_SUPP,
 };
 
 static int amd_pmu_lbr_setup_filter(struct perf_event *event)
@@ -165,6 +210,41 @@ static int amd_pmu_lbr_setup_filter(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return -EOPNOTSUPP;
 
+	if (br_type & PERF_SAMPLE_BRANCH_USER)
+		mask |= X86_BR_USER;
+
+	if (br_type & PERF_SAMPLE_BRANCH_KERNEL)
+		mask |= X86_BR_KERNEL;
+
+	/* Ignore BRANCH_HV here */
+
+	if (br_type & PERF_SAMPLE_BRANCH_ANY)
+		mask |= X86_BR_ANY;
+
+	if (br_type & PERF_SAMPLE_BRANCH_ANY_CALL)
+		mask |= X86_BR_ANY_CALL;
+
+	if (br_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		mask |= X86_BR_RET | X86_BR_IRET | X86_BR_SYSRET;
+
+	if (br_type & PERF_SAMPLE_BRANCH_IND_CALL)
+		mask |= X86_BR_IND_CALL;
+
+	if (br_type & PERF_SAMPLE_BRANCH_COND)
+		mask |= X86_BR_JCC;
+
+	if (br_type & PERF_SAMPLE_BRANCH_IND_JUMP)
+		mask |= X86_BR_IND_JMP;
+
+	if (br_type & PERF_SAMPLE_BRANCH_CALL)
+		mask |= X86_BR_CALL | X86_BR_ZERO_CALL;
+
+	if (br_type & PERF_SAMPLE_BRANCH_TYPE_SAVE)
+		mask |= X86_BR_TYPE_SAVE;
+
+	reg->reg = mask;
+	mask = 0;
+
 	for (i = 0; i < PERF_SAMPLE_BRANCH_MAX_SHIFT; i++) {
 		if (!(br_type & BIT_ULL(i)))
 			continue;
@@ -220,13 +300,15 @@ void amd_pmu_lbr_reset(void)
 void amd_pmu_lbr_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event_extra *reg = &event->hw.branch_reg;
 
 	if (!x86_pmu.lbr_nr)
 		return;
 
 	if (has_branch_stack(event)) {
 		cpuc->lbr_select = 1;
-		cpuc->lbr_sel->config = event->hw.branch_reg.config;
+		cpuc->lbr_sel->config = reg->config;
+		cpuc->br_sel = reg->reg;
 	}
 
 	perf_sched_cb_inc(event->ctx->pmu);
