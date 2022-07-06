Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79C4568701
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiGFLoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiGFLoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:44:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D810627CE0;
        Wed,  6 Jul 2022 04:44:08 -0700 (PDT)
Date:   Wed, 06 Jul 2022 11:44:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657107847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEFYBU007DD4PLmQt8y3AsFAOHmZmPExn7Y6lVkCMv4=;
        b=tX3cakeW/xqcT5jIiogADn2KyWNfAPPPWLPUb9E307PucJ0JciM1zNrDVPdjP6XZgn7/5r
        Ok0hOs6oIYq9UwaqboQP4RfSCBUNrOL7APLd6GKJgzVdjMLe7Hq4EQJazTqAq62pXFfkLm
        fctTt/5QLcnqLipUN88kHkn6eu9PHjZtJvXoV2m8MocorXkHcUeR4B5qbdTFW+PCeI/JSH
        o487Tg+rN4uC93Uyodpg43804HKI1ddHdN9wYjgwkEu2J28HkYULXBAWe/wCP/xXNIX0+s
        iM5HvzXcc2mf6i3c16kHQDWSnpTcHLDLgKpE9TdjnM5If+GqRaiQnm6Mhn2pCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657107847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEFYBU007DD4PLmQt8y3AsFAOHmZmPExn7Y6lVkCMv4=;
        b=En06Tie7+1fzYptsHjCsiVXO+Bbb1OG/FLc37A1aKsD2UppKIncoWTLLptsFdOItv9lzr9
        D8hxP2EOFkxEp+BA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Fix PEBS memory access info encoding for ADL
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220629150840.2235741-1-kan.liang@linux.intel.com>
References: <20220629150840.2235741-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <165710784643.15455.8474211628537529974.tip-bot2@tip-bot2>
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

Commit-ID:     39a41278f041e4b7ee6c83caefac845c9b19fc61
Gitweb:        https://git.kernel.org/tip/39a41278f041e4b7ee6c83caefac845c9b19fc61
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 29 Jun 2022 08:08:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 04 Jul 2022 09:23:09 +02:00

perf/x86/intel: Fix PEBS memory access info encoding for ADL

The PEBS memory access latency encoding for the e-core is slightly
different from the p-core. The bit 4 is Lock, while the bit 5 is TLB
access.

Add a new flag to indicate the load/store latency event on a hybrid
platform.
Add a new function pointer to retrieve the latency data for a hybrid
platform. Only implement the new flag and function for the e-core on
ADL. Still use the existing PERF_X86_EVENT_PEBS_LDLAT/STLAT flag for the
p-core on ADL.

Factor out pebs_set_tlb_lock() to set the generic memory data source
information of the TLB access and lock for both load and store latency.

Move the intel_get_event_constraints() to ahead of the :ppp check,
otherwise the new flag never gets a chance to be set for the :ppp
events.

Fixes: f83d2f91d259 ("perf/x86/intel: Add Alder Lake Hybrid support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20220629150840.2235741-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c |  5 +-
 arch/x86/events/intel/ds.c   | 80 +++++++++++++++++++++--------------
 arch/x86/events/perf_event.h |  8 ++++-
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 45024ab..07d4a5f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4141,6 +4141,8 @@ tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 {
 	struct event_constraint *c;
 
+	c = intel_get_event_constraints(cpuc, idx, event);
+
 	/*
 	 * :ppp means to do reduced skid PEBS,
 	 * which is available on PMC0 and fixed counter 0.
@@ -4153,8 +4155,6 @@ tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 		return &counter0_constraint;
 	}
 
-	c = intel_get_event_constraints(cpuc, idx, event);
-
 	return c;
 }
 
@@ -6242,6 +6242,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(false);
+		x86_pmu.pebs_latency_data = adl_latency_data_small;
 		x86_pmu.num_topdown_events = 8;
 		x86_pmu.update_topdown_event = adl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = adl_set_topdown_event_period;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 376cc3d..de84385 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -171,6 +171,49 @@ static u64 precise_datala_hsw(struct perf_event *event, u64 status)
 	return dse.val;
 }
 
+static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
+{
+	/*
+	 * TLB access
+	 * 0 = did not miss 2nd level TLB
+	 * 1 = missed 2nd level TLB
+	 */
+	if (tlb)
+		*val |= P(TLB, MISS) | P(TLB, L2);
+	else
+		*val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
+
+	/* locked prefix */
+	if (lock)
+		*val |= P(LOCK, LOCKED);
+}
+
+/* Retrieve the latency data for e-core of ADL */
+u64 adl_latency_data_small(struct perf_event *event, u64 status)
+{
+	union intel_x86_pebs_dse dse;
+	u64 val;
+
+	WARN_ON_ONCE(hybrid_pmu(event->pmu)->cpu_type == hybrid_big);
+
+	dse.val = status;
+
+	val = pebs_data_source[dse.ld_dse];
+
+	/*
+	 * For the atom core on ADL,
+	 * bit 4: lock, bit 5: TLB access.
+	 */
+	pebs_set_tlb_lock(&val, dse.ld_locked, dse.ld_stlb_miss);
+
+	if (dse.ld_data_blk)
+		val |= P(BLK, DATA);
+	else
+		val |= P(BLK, NA);
+
+	return val;
+}
+
 static u64 load_latency_data(u64 status)
 {
 	union intel_x86_pebs_dse dse;
@@ -190,21 +233,8 @@ static u64 load_latency_data(u64 status)
 		val |= P(TLB, NA) | P(LOCK, NA);
 		return val;
 	}
-	/*
-	 * bit 4: TLB access
-	 * 0 = did not miss 2nd level TLB
-	 * 1 = missed 2nd level TLB
-	 */
-	if (dse.ld_stlb_miss)
-		val |= P(TLB, MISS) | P(TLB, L2);
-	else
-		val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
 
-	/*
-	 * bit 5: locked prefix
-	 */
-	if (dse.ld_locked)
-		val |= P(LOCK, LOCKED);
+	pebs_set_tlb_lock(&val, dse.ld_stlb_miss, dse.ld_locked);
 
 	/*
 	 * Ice Lake and earlier models do not support block infos.
@@ -245,21 +275,7 @@ static u64 store_latency_data(u64 status)
 	 */
 	val = pebs_data_source[dse.st_lat_dse];
 
-	/*
-	 * bit 4: TLB access
-	 * 0 = did not miss 2nd level TLB
-	 * 1 = missed 2nd level TLB
-	 */
-	if (dse.st_lat_stlb_miss)
-		val |= P(TLB, MISS) | P(TLB, L2);
-	else
-		val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
-
-	/*
-	 * bit 5: locked prefix
-	 */
-	if (dse.st_lat_locked)
-		val |= P(LOCK, LOCKED);
+	pebs_set_tlb_lock(&val, dse.st_lat_stlb_miss, dse.st_lat_locked);
 
 	val |= P(BLK, NA);
 
@@ -781,8 +797,8 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 
 struct event_constraint intel_grt_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
-	INTEL_PLD_CONSTRAINT(0x5d0, 0xf),
-	INTEL_PSD_CONSTRAINT(0x6d0, 0xf),
+	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0xf),
+	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xf),
 	EVENT_CONSTRAINT_END
 };
 
@@ -1446,6 +1462,8 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 		val = load_latency_data(aux);
 	else if (fl & PERF_X86_EVENT_PEBS_STLAT)
 		val = store_latency_data(aux);
+	else if (fl & PERF_X86_EVENT_PEBS_LAT_HYBRID)
+		val = x86_pmu.pebs_latency_data(event, aux);
 	else if (fst && (fl & PERF_X86_EVENT_PEBS_HSW_PREC))
 		val = precise_datala_hsw(event, aux);
 	else if (fst)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1ca6200..2d11445 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -84,6 +84,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_TOPDOWN		0x04000 /* Count Topdown slots/metrics events */
 #define PERF_X86_EVENT_PEBS_STLAT	0x08000 /* st+stlat data address sampling */
 #define PERF_X86_EVENT_AMD_BRS		0x10000 /* AMD Branch Sampling */
+#define PERF_X86_EVENT_PEBS_LAT_HYBRID	0x20000 /* ld and st lat for hybrid */
 
 static inline bool is_topdown_count(struct perf_event *event)
 {
@@ -461,6 +462,10 @@ struct cpu_hw_events {
 	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_ST)
 
+#define INTEL_HYBRID_LAT_CONSTRAINT(c, n)	\
+	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
+			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID)
+
 /* Event constraint, but match on all event flags too. */
 #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
 	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
@@ -826,6 +831,7 @@ struct x86_pmu {
 	void		(*drain_pebs)(struct pt_regs *regs, struct perf_sample_data *data);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
+	u64		(*pebs_latency_data)(struct perf_event *event, u64 status);
 	unsigned long	large_pebs_flags;
 	u64		rtm_abort_event;
 
@@ -1393,6 +1399,8 @@ void intel_pmu_disable_bts(void);
 
 int intel_pmu_drain_bts_buffer(void);
 
+u64 adl_latency_data_small(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
 extern struct event_constraint intel_atom_pebs_event_constraints[];
