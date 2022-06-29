Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC35603EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiF2PKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiF2PKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:10:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920273F882
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656515348; x=1688051348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lMUmyI+gjLSPioHjMw+S70QiVaKvopIYhcQaz+VaeCc=;
  b=ihILa3prd0cwPXelwggtP9K2RBxacar+xa7qz1xGElfFl8AjluTHvv7m
   arS+pHKWvSimjFJWqymFdSFsI9kpBcTDIWnkpa75yQne91QjpwczR6T7/
   bY/GdlZ3EPtyM4lw/usuueSCb3EMpGq7uIHtYdeRxH1tzwUVjrY0qnbYt
   NaDlun+NWwEqfLzsKxVVRIv9pZ6BoqG/aENVvgqImaTn45U3N1Xefz247
   5MiVilfaVgsjFbaVIyeH9kHlR77m5T5kamEHckUhDhi3fBeCSuQxgo7Sf
   VV+louuVBtR4VX1GFxB/W/qc7CLT+CBXH1ElvZb8P82KW97gYiem91H7y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="346045175"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="346045175"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 08:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="595266698"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2022 08:08:46 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/2] perf/x86/intel: Fix PEBS memory access info encoding for ADL
Date:   Wed, 29 Jun 2022 08:08:39 -0700
Message-Id: <20220629150840.2235741-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The V1 can be found at
https://lore.kernel.org/lkml/20220421132617.82206-1-kan.liang@linux.intel.com/

Changes since V1:
- Fix the issue that the flag of :ppp load and store latency event is
  overwritten
- Add a new flag and a new function pointer to indicate and handle the
  load/store latency event on a hybrid platform. The e-core and p-eore
  have different data source encoding. I think it should be a cleaner
  way to handle them separately, rather than add multiple if...else in
  a single function in the V1 series.
  It's also easier to be extended if the data source format is changed
  again later.
- Add Reviewed-by from Andi

 arch/x86/events/intel/core.c |  5 ++-
 arch/x86/events/intel/ds.c   | 80 ++++++++++++++++++++++--------------
 arch/x86/events/perf_event.h |  8 ++++
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 759ef244786a..b8788ab30159 100644
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
index 376cc3d66094..de84385de414 100644
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
index 21a5482bcf84..ff6dd189739e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -84,6 +84,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_TOPDOWN		0x04000 /* Count Topdown slots/metrics events */
 #define PERF_X86_EVENT_PEBS_STLAT	0x08000 /* st+stlat data address sampling */
 #define PERF_X86_EVENT_AMD_BRS		0x10000 /* AMD Branch Sampling */
+#define PERF_X86_EVENT_PEBS_LAT_HYBRID	0x20000 /* ld and st lat for hybrid */
 
 static inline bool is_topdown_count(struct perf_event *event)
 {
@@ -460,6 +461,10 @@ struct cpu_hw_events {
 	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_ST)
 
+#define INTEL_HYBRID_LAT_CONSTRAINT(c, n)	\
+	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
+			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID)
+
 /* Event constraint, but match on all event flags too. */
 #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
 	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
@@ -825,6 +830,7 @@ struct x86_pmu {
 	void		(*drain_pebs)(struct pt_regs *regs, struct perf_sample_data *data);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
+	u64		(*pebs_latency_data)(struct perf_event *event, u64 status);
 	unsigned long	large_pebs_flags;
 	u64		rtm_abort_event;
 
@@ -1392,6 +1398,8 @@ void intel_pmu_disable_bts(void);
 
 int intel_pmu_drain_bts_buffer(void);
 
+u64 adl_latency_data_small(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
 extern struct event_constraint intel_atom_pebs_event_constraints[];
-- 
2.35.1

