Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608374842D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiADNxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:53:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:33230 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233868AbiADNxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:53:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="302977369"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="302977369"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 05:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="472071294"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga006.jf.intel.com with ESMTP; 04 Jan 2022 05:53:29 -0800
From:   peterz@infradead.org
To:     peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hpa@zytor.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel/lbr: Add static_branch for LBR INFO flags
Date:   Tue,  4 Jan 2022 08:51:17 -0800
Message-Id: <1641315077-96661-2-git-send-email-peterz@infradead.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641315077-96661-1-git-send-email-peterz@infradead.org>
References: <1641315077-96661-1-git-send-email-peterz@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Using static_branch to replace the LBR INFO flags to optimize the LBR
INFO parsing.

Tested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

The patch is created by Peter Zijlstra. Kan splited the patch from
the original one, added the description, did tiny modification
(get_lbr_cycles()) and finished tests.

 arch/x86/events/intel/lbr.c | 51 ++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index b7228a1..f8fd255 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -893,37 +893,40 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 	cpuc->lbr_stack.hw_idx = tos;
 }
 
+static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
+static DEFINE_STATIC_KEY_FALSE(x86_lbr_cycles);
+static DEFINE_STATIC_KEY_FALSE(x86_lbr_type);
+
 static __always_inline int get_lbr_br_type(u64 info)
 {
-	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) || !x86_pmu.lbr_br_type)
-		return 0;
+	int type = 0;
 
-	return (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
+	if (static_branch_likely(&x86_lbr_type))
+		type = (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
+
+	return type;
 }
 
 static __always_inline bool get_lbr_mispred(u64 info)
 {
-	if (static_cpu_has(X86_FEATURE_ARCH_LBR) && !x86_pmu.lbr_mispred)
-		return 0;
+	bool mispred = 0;
 
-	return !!(info & LBR_INFO_MISPRED);
-}
-
-static __always_inline bool get_lbr_predicted(u64 info)
-{
-	if (static_cpu_has(X86_FEATURE_ARCH_LBR) && !x86_pmu.lbr_mispred)
-		return 0;
+	if (static_branch_likely(&x86_lbr_mispred))
+		mispred = !!(info & LBR_INFO_MISPRED);
 
-	return !(info & LBR_INFO_MISPRED);
+	return mispred;
 }
 
 static __always_inline u16 get_lbr_cycles(u64 info)
 {
+	u16 cycles = info & LBR_INFO_CYCLES;
+
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
-	    !(x86_pmu.lbr_timed_lbr && info & LBR_INFO_CYC_CNT_VALID))
-		return 0;
+	    (!static_branch_likely(&x86_lbr_cycles) ||
+	     !(info & LBR_INFO_CYC_CNT_VALID)))
+		cycles = 0;
 
-	return info & LBR_INFO_CYCLES;
+	return cycles;
 }
 
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
@@ -951,7 +954,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->from		= from;
 		e->to		= to;
 		e->mispred	= get_lbr_mispred(info);
-		e->predicted	= get_lbr_predicted(info);
+		e->predicted	= !e->mispred;
 		e->in_tx	= !!(info & LBR_INFO_IN_TX);
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
@@ -1718,6 +1721,14 @@ void intel_pmu_lbr_init(void)
 		x86_pmu.lbr_to_cycles = 1;
 		break;
 	}
+
+	if (x86_pmu.lbr_has_info) {
+		/*
+		 * Only used in combination with baseline pebs.
+		 */
+		static_branch_enable(&x86_lbr_mispred);
+		static_branch_enable(&x86_lbr_cycles);
+	}
 }
 
 /*
@@ -1779,6 +1790,12 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_br_type = ecx.split.lbr_br_type;
 	x86_pmu.lbr_nr = lbr_nr;
 
+	if (x86_pmu.lbr_mispred)
+		static_branch_enable(&x86_lbr_mispred);
+	if (x86_pmu.lbr_timed_lbr)
+		static_branch_enable(&x86_lbr_cycles);
+	if (x86_pmu.lbr_br_type)
+		static_branch_enable(&x86_lbr_type);
 
 	arch_lbr_xsave = is_arch_lbr_xsave_available();
 	if (arch_lbr_xsave) {
-- 
2.7.4

