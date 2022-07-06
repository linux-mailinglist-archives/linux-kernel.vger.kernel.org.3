Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E73568706
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiGFLoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiGFLoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:44:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB5827FE1;
        Wed,  6 Jul 2022 04:44:08 -0700 (PDT)
Date:   Wed, 06 Jul 2022 11:44:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657107846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQNDvJM0xfToLKfSGT1GOOqjkWUDf95Dg7dwTQ4Av/s=;
        b=0FQNE05YSdfPZsbbjsQWmjpS5Vsl31m58ptTs84yOyiK/zb9roN75dPAWLlp4HrAk1z644
        1SOSjDq3TQTt/3AwKyhc+xzImefgTmeZfL3cPUH7R2/RuXwutjcUmq642BwxS4AVFRMXaJ
        itiAvSKvcpOjTyxa2OuXxzQ0qHfWiD6ctIyncUfKPOQiHHyl828DNcwZaAhGcyPMXCsCob
        jzAosoEcNo8eevKZpjnZ6WezpqeCCfk9GxVTQOi4yqqOHnVXrWF/c9f1+8PwIyxZogwb2q
        jS8jog6p7CO8psLwv5JTi0wikYphVrQXLNZduB1WXoL57aemCJdXlr5V+jKocA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657107846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQNDvJM0xfToLKfSGT1GOOqjkWUDf95Dg7dwTQ4Av/s=;
        b=X0NCsTJnsd4ifShsBRjxssvI0j8BjUHHO00U8TWKCUe2NBSx98+lPIENcCfAu9gdFxq3i8
        ujl7zvcj+h5iDDBw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Fix PEBS data source encoding for ADL
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220629150840.2235741-2-kan.liang@linux.intel.com>
References: <20220629150840.2235741-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <165710784534.15455.9349056485349357540.tip-bot2@tip-bot2>
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

Commit-ID:     ccf170e9d8fdacfe435bbe3749c897c7d86d32f8
Gitweb:        https://git.kernel.org/tip/ccf170e9d8fdacfe435bbe3749c897c7d86d32f8
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 29 Jun 2022 08:08:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 04 Jul 2022 09:23:09 +02:00

perf/x86/intel: Fix PEBS data source encoding for ADL

The PEBS data source encoding for the e-core is different from the
p-core.

Add the pebs_data_source[] in the struct x86_hybrid_pmu to store the
data source encoding for each type of the core.

Add intel_pmu_pebs_data_source_grt() for the e-core.
There is nothing changed for the data source encoding of the p-core,
which still reuse the intel_pmu_pebs_data_source_skl().

Fixes: f83d2f91d259 ("perf/x86/intel: Add Alder Lake Hybrid support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20220629150840.2235741-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   | 51 ++++++++++++++++++++++++++---------
 arch/x86/events/perf_event.h |  6 ++++-
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 07d4a5f..bd8b988 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6241,7 +6241,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.lbr_pt_coexist = true;
-		intel_pmu_pebs_data_source_skl(false);
+		intel_pmu_pebs_data_source_adl();
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
 		x86_pmu.num_topdown_events = 8;
 		x86_pmu.update_topdown_event = adl_update_topdown_event;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index de84385..ba60427 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -94,15 +94,40 @@ void __init intel_pmu_pebs_data_source_nhm(void)
 	pebs_data_source[0x07] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
 }
 
-void __init intel_pmu_pebs_data_source_skl(bool pmem)
+static void __init __intel_pmu_pebs_data_source_skl(bool pmem, u64 *data_source)
 {
 	u64 pmem_or_l4 = pmem ? LEVEL(PMEM) : LEVEL(L4);
 
-	pebs_data_source[0x08] = OP_LH | pmem_or_l4 | P(SNOOP, HIT);
-	pebs_data_source[0x09] = OP_LH | pmem_or_l4 | REM | P(SNOOP, HIT);
-	pebs_data_source[0x0b] = OP_LH | LEVEL(RAM) | REM | P(SNOOP, NONE);
-	pebs_data_source[0x0c] = OP_LH | LEVEL(ANY_CACHE) | REM | P(SNOOPX, FWD);
-	pebs_data_source[0x0d] = OP_LH | LEVEL(ANY_CACHE) | REM | P(SNOOP, HITM);
+	data_source[0x08] = OP_LH | pmem_or_l4 | P(SNOOP, HIT);
+	data_source[0x09] = OP_LH | pmem_or_l4 | REM | P(SNOOP, HIT);
+	data_source[0x0b] = OP_LH | LEVEL(RAM) | REM | P(SNOOP, NONE);
+	data_source[0x0c] = OP_LH | LEVEL(ANY_CACHE) | REM | P(SNOOPX, FWD);
+	data_source[0x0d] = OP_LH | LEVEL(ANY_CACHE) | REM | P(SNOOP, HITM);
+}
+
+void __init intel_pmu_pebs_data_source_skl(bool pmem)
+{
+	__intel_pmu_pebs_data_source_skl(pmem, pebs_data_source);
+}
+
+static void __init intel_pmu_pebs_data_source_grt(u64 *data_source)
+{
+	data_source[0x05] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HIT);
+	data_source[0x06] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
+	data_source[0x08] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOPX, FWD);
+}
+
+void __init intel_pmu_pebs_data_source_adl(void)
+{
+	u64 *data_source;
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].pebs_data_source;
+	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
+	__intel_pmu_pebs_data_source_skl(false, data_source);
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
+	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
+	intel_pmu_pebs_data_source_grt(data_source);
 }
 
 static u64 precise_store_data(u64 status)
@@ -198,7 +223,7 @@ u64 adl_latency_data_small(struct perf_event *event, u64 status)
 
 	dse.val = status;
 
-	val = pebs_data_source[dse.ld_dse];
+	val = hybrid_var(event->pmu, pebs_data_source)[dse.ld_dse];
 
 	/*
 	 * For the atom core on ADL,
@@ -214,7 +239,7 @@ u64 adl_latency_data_small(struct perf_event *event, u64 status)
 	return val;
 }
 
-static u64 load_latency_data(u64 status)
+static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
 	u64 val;
@@ -224,7 +249,7 @@ static u64 load_latency_data(u64 status)
 	/*
 	 * use the mapping table for bit 0-3
 	 */
-	val = pebs_data_source[dse.ld_dse];
+	val = hybrid_var(event->pmu, pebs_data_source)[dse.ld_dse];
 
 	/*
 	 * Nehalem models do not support TLB, Lock infos
@@ -263,7 +288,7 @@ static u64 load_latency_data(u64 status)
 	return val;
 }
 
-static u64 store_latency_data(u64 status)
+static u64 store_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
 	u64 val;
@@ -273,7 +298,7 @@ static u64 store_latency_data(u64 status)
 	/*
 	 * use the mapping table for bit 0-3
 	 */
-	val = pebs_data_source[dse.st_lat_dse];
+	val = hybrid_var(event->pmu, pebs_data_source)[dse.st_lat_dse];
 
 	pebs_set_tlb_lock(&val, dse.st_lat_stlb_miss, dse.st_lat_locked);
 
@@ -1459,9 +1484,9 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 	bool fst = fl & (PERF_X86_EVENT_PEBS_ST | PERF_X86_EVENT_PEBS_HSW_PREC);
 
 	if (fl & PERF_X86_EVENT_PEBS_LDLAT)
-		val = load_latency_data(aux);
+		val = load_latency_data(event, aux);
 	else if (fl & PERF_X86_EVENT_PEBS_STLAT)
-		val = store_latency_data(aux);
+		val = store_latency_data(event, aux);
 	else if (fl & PERF_X86_EVENT_PEBS_LAT_HYBRID)
 		val = x86_pmu.pebs_latency_data(event, aux);
 	else if (fst && (fl & PERF_X86_EVENT_PEBS_HSW_PREC))
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2d11445..ca2f8bf 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -644,6 +644,8 @@ enum {
 	x86_lbr_exclusive_max,
 };
 
+#define PERF_PEBS_DATA_SOURCE_MAX	0x10
+
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
@@ -671,6 +673,8 @@ struct x86_hybrid_pmu {
 	unsigned int			late_ack	:1,
 					mid_ack		:1,
 					enabled_ack	:1;
+
+	u64				pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX];
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
@@ -1508,6 +1512,8 @@ void intel_pmu_pebs_data_source_nhm(void);
 
 void intel_pmu_pebs_data_source_skl(bool pmem);
 
+void intel_pmu_pebs_data_source_adl(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
