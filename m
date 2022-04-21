Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9782A50A0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356652AbiDUN33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356641AbiDUN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:29:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEF6616D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650547586; x=1682083586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s3H8kUFS5EZ9xdODf2g6cGpmBoLjlpVKIXmQisxr5Gk=;
  b=jbX5/4bZLydHszF38Vpgg3edw8pYrK/oZtY75401ei7Bnjjd/twDfhCt
   cfLN0Tj05F7QD3bYlvPwHfRAgZWwnRn4F7b//k4NlvOq/qdQyLdJTY+Zh
   nhVljezmkt7F+4eQZjALdgyrBGtoEtm6OwOnViKSp1zvV9DhLxEXXOA7M
   ZOTsntxL5YLOAuZwKsM4b67FbFvwXMt/CHFMgc+H6DbXWUzejamptVg69
   WKSYOXTVAFZ4IZOzlq3WlWq3YMr5kyC8GKfVDa+fuz1N5dLWEzoSz/Nvx
   XcoV2bh+eXM5SsqZht/L/i9m0t9a7ic1N+74GNR5KYSodXMeRrisyqldp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244276829"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="244276829"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 06:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="648132714"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2022 06:26:25 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel: Fix PEBS data source encoding for ADL
Date:   Thu, 21 Apr 2022 06:26:17 -0700
Message-Id: <20220421132617.82206-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421132617.82206-1-kan.liang@linux.intel.com>
References: <20220421132617.82206-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   | 41 +++++++++++++++++++++++++++++-------
 arch/x86/events/perf_event.h |  6 ++++++
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ee3ee4b5c53a..66342a176a7d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6240,7 +6240,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.lbr_pt_coexist = true;
-		intel_pmu_pebs_data_source_skl(false);
+		intel_pmu_pebs_data_source_adl();
 		x86_pmu.num_topdown_events = 8;
 		x86_pmu.update_topdown_event = adl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = adl_set_topdown_event_period;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 98370650525d..c58660589502 100644
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
+	memcpy(data_source, pebs_data_source, sizeof(u64) * PERF_PEBS_DATA_SOURCE_MAX);
+	__intel_pmu_pebs_data_source_skl(false, data_source);
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
+	memcpy(data_source, pebs_data_source, sizeof(u64) * PERF_PEBS_DATA_SOURCE_MAX);
+	intel_pmu_pebs_data_source_grt(data_source);
 }
 
 static u64 precise_store_data(u64 status)
@@ -198,7 +223,7 @@ static u64 load_latency_data(struct perf_event *event, u64 status)
 	/*
 	 * use the mapping table for bit 0-3
 	 */
-	val = pebs_data_source[dse.ld_dse];
+	val = hybrid_var(event->pmu, pebs_data_source)[dse.ld_dse];
 
 	/*
 	 * Nehalem models do not support TLB, Lock infos
@@ -264,7 +289,7 @@ static u64 store_latency_data(struct perf_event *event, u64 status)
 	/*
 	 * use the mapping table for bit 0-3
 	 */
-	val = pebs_data_source[dse.st_lat_dse];
+	val = hybrid_var(event->pmu, pebs_data_source)[dse.st_lat_dse];
 
 	if (x86_pmu.pebs_adl_atom_dse)
 		pebs_dse_adl(event, &dse);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 0ed1413b0eb7..63e54f911d2c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -635,6 +635,8 @@ enum {
 	x86_lbr_exclusive_max,
 };
 
+#define PERF_PEBS_DATA_SOURCE_MAX	0x10
+
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
@@ -662,6 +664,8 @@ struct x86_hybrid_pmu {
 	unsigned int			late_ack	:1,
 					mid_ack		:1,
 					enabled_ack	:1;
+
+	u64				pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX];
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
@@ -1407,6 +1411,8 @@ void intel_pmu_pebs_data_source_nhm(void);
 
 void intel_pmu_pebs_data_source_skl(bool pmem);
 
+void intel_pmu_pebs_data_source_adl(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
-- 
2.35.1

