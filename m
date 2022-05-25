Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7F2533E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiEYNkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiEYNkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:40:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2932B6B7FF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653486038; x=1685022038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nq4vG/XBCmLQ1p+V+8H+594mRS962OkuRzYSbH0/w6M=;
  b=QDIuF0M/+fOvFdzh/QCD6wCxbaL35VW+vMdAMoacj4DzpQyzSYeehmMm
   EsxaFQ1Yw6KsshKpPvSqRgyITAijrhezdxZowGsqxNI5Epr2yG8YlZgSc
   Ie3VAZgcN/LV7KqWeq/4MlW8av2HjJCYYlzrvuSOBwa2+mERvx79/p//1
   rK5+asaSe9CP5wCBmxn16W+Sm1faljrOXgD1y+ZQGnmQCxfXfSviN5Gze
   o02KVlmtm1o+wFzMtAR5i4jaYnNeYNh1K/dUnLLoq6/jdn2+I1vkK1UuA
   eLx9+2U3jX0Sort71UoiOTr6xA5/mVCTtKN2MwMEd+hi2/cFyK0mV0oPp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="272633166"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="272633166"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="609136265"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 25 May 2022 06:40:35 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 1/2] perf/x86/intel: Fix PEBS memory access info encoding for ADL
Date:   Wed, 25 May 2022 06:40:21 -0700
Message-Id: <20220525134022.1660684-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Add flag pebs_adl_atom_dse to indicate this case. Swap the
ld_stlb_miss and ld_locked for the e-core of ADL.

Fixes: f83d2f91d259 ("perf/x86/intel: Add Alder Lake Hybrid support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c |  1 +
 arch/x86/events/intel/ds.c   | 32 ++++++++++++++++++++++++++++----
 arch/x86/events/perf_event.h |  3 ++-
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fc7f458eb3de..ee3ee4b5c53a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6233,6 +6233,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.pebs_block = true;
+		x86_pmu.pebs_adl_atom_dse = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 		x86_pmu.flags |= PMU_FL_PEBS_ALL;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 376cc3d66094..98370650525d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -171,7 +171,24 @@ static u64 precise_datala_hsw(struct perf_event *event, u64 status)
 	return dse.val;
 }
 
-static u64 load_latency_data(u64 status)
+static inline void pebs_dse_adl(struct perf_event *event,
+				union intel_x86_pebs_dse *dse)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->cpu_type == hybrid_big)
+		return;
+	/*
+	 * For the atom core on ADL, bit 4: lock, bit 5: TLB access.
+	 * Swap the ld_stlb_miss and ld_locked.
+	 */
+	if (dse->ld_stlb_miss != dse->ld_locked) {
+		dse->ld_stlb_miss = !dse->ld_stlb_miss;
+		dse->ld_locked = !dse->ld_locked;
+	}
+}
+
+static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
 	u64 val;
@@ -190,6 +207,10 @@ static u64 load_latency_data(u64 status)
 		val |= P(TLB, NA) | P(LOCK, NA);
 		return val;
 	}
+
+	if (x86_pmu.pebs_adl_atom_dse)
+		pebs_dse_adl(event, &dse);
+
 	/*
 	 * bit 4: TLB access
 	 * 0 = did not miss 2nd level TLB
@@ -233,7 +254,7 @@ static u64 load_latency_data(u64 status)
 	return val;
 }
 
-static u64 store_latency_data(u64 status)
+static u64 store_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
 	u64 val;
@@ -245,6 +266,9 @@ static u64 store_latency_data(u64 status)
 	 */
 	val = pebs_data_source[dse.st_lat_dse];
 
+	if (x86_pmu.pebs_adl_atom_dse)
+		pebs_dse_adl(event, &dse);
+
 	/*
 	 * bit 4: TLB access
 	 * 0 = did not miss 2nd level TLB
@@ -1443,9 +1467,9 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 	bool fst = fl & (PERF_X86_EVENT_PEBS_ST | PERF_X86_EVENT_PEBS_HSW_PREC);
 
 	if (fl & PERF_X86_EVENT_PEBS_LDLAT)
-		val = load_latency_data(aux);
+		val = load_latency_data(event, aux);
 	else if (fl & PERF_X86_EVENT_PEBS_STLAT)
-		val = store_latency_data(aux);
+		val = store_latency_data(event, aux);
 	else if (fst && (fl & PERF_X86_EVENT_PEBS_HSW_PREC))
 		val = precise_datala_hsw(event, aux);
 	else if (fst)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 150261d929b9..0ed1413b0eb7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -815,7 +815,8 @@ struct x86_pmu {
 			pebs_prec_dist		:1,
 			pebs_no_tlb		:1,
 			pebs_no_isolation	:1,
-			pebs_block		:1;
+			pebs_block		:1,
+			pebs_adl_atom_dse	:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	int		max_pebs_events;
-- 
2.35.1

