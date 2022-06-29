Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DC8560423
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiF2PKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiF2PKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:10:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845283F89A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656515349; x=1688051349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QZF8IaOxkPAMJPjGMCFyiK1pRd6Rsiv7xy75tz7bCmg=;
  b=CEnQ9E7r+IzP61j2R2ZmxLjFsoTtN8uaGtxQ8WHQkcA4pAr3Zm+/uG9B
   1OSHou5wezz1e0nOzWyVZwxmcW96xjtNaAYdjp6W2NMXma0x4KRsEIdRi
   uinEC90YcKRupDBAImQLawApRfRbMYL68fib5hE6jwGQUY4/RmNVg+4d8
   P6+5ur+hxxSHyhL6vAIGXBQaE6atDLuIYtmn1gc/uRtYAZ3025chlvO5t
   IyaUsK1lpgcgiVb7OjuXoIyrX7a+U8JUnsujlWnKZ6R3DqPBkKje1fLSu
   elQw6JQOJCtRjoiazMF4A+U9+cGL0z5+G7Kb+kO82w7mIW/0GMZDD10bG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="346045177"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="346045177"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 08:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="595266701"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2022 08:08:46 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/2] perf/x86/intel: Fix PEBS data source encoding for ADL
Date:   Wed, 29 Jun 2022 08:08:40 -0700
Message-Id: <20220629150840.2235741-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629150840.2235741-1-kan.liang@linux.intel.com>
References: <20220629150840.2235741-1-kan.liang@linux.intel.com>
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

The PEBS data source encoding for the e-core is different from the
p-core.

Add the pebs_data_source[] in the struct x86_hybrid_pmu to store the
data source encoding for each type of the core.

Add intel_pmu_pebs_data_source_grt() for the e-core.
There is nothing changed for the data source encoding of the p-core,
which still reuse the intel_pmu_pebs_data_source_skl().

Fixes: f83d2f91d259 ("perf/x86/intel: Add Alder Lake Hybrid support")
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The V1 can be found at
https://lore.kernel.org/lkml/20220421132617.82206-2-kan.liang@linux.intel.com/

Changes since V1:
- Rebase on patch 1 accordingly
- Add Reviewed-by from Andi

 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   | 51 +++++++++++++++++++++++++++---------
 arch/x86/events/perf_event.h |  6 +++++
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b8788ab30159..7638ed3672fa 100644
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
index de84385de414..ba60427caa6d 100644
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
index ff6dd189739e..821098aebf78 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -643,6 +643,8 @@ enum {
 	x86_lbr_exclusive_max,
 };
 
+#define PERF_PEBS_DATA_SOURCE_MAX	0x10
+
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
@@ -670,6 +672,8 @@ struct x86_hybrid_pmu {
 	unsigned int			late_ack	:1,
 					mid_ack		:1,
 					enabled_ack	:1;
+
+	u64				pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX];
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
@@ -1507,6 +1511,8 @@ void intel_pmu_pebs_data_source_nhm(void);
 
 void intel_pmu_pebs_data_source_skl(bool pmem);
 
+void intel_pmu_pebs_data_source_adl(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
-- 
2.35.1

