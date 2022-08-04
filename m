Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3243F589D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbiHDOHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiHDOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:07:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B1F3E759
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659622071; x=1691158071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F8Xk3fmwmXsxJ3Ym8nZPGCvvfLcoeVMWvtdBSeVr7WY=;
  b=XntEzysEj3yVomrZ6CFnStBhbsHHCCLFFEM/U5sXfqwm1/9EPmBMyIZ3
   EhwupQk4GTKkEiY7Wqy2PonAWm8lxsi0gwkOPsMMV8/VVMO5wp70yGTqy
   yNTGsKldL3+2zDfNfWdMZb5kHg9bjy6MLadPRLVrPsNlMrwjjwl5jiA8q
   VX72K8PuxM10dSjzHoU/qaKIeZQp3AAOIME0Uu7GfrVWuoNViM+mWy0yI
   DL9op3t0M3Jk8GP2MN/7d1OoSAm7nFCTMtMWDYswSyfJXPS/Aybex7sCG
   fuj79HWDUhGce+xTIhSgDy+FHY8JITJVCAjduMYlgLRGBw8cVeeZn0TUQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="276857522"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="276857522"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 07:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="662544278"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2022 07:07:40 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH] perf/x86/intel: Optimize the access of the fixed counter control reg
Date:   Thu,  4 Aug 2022 07:07:29 -0700
Message-Id: <20220804140729.2951259-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

All the fixed counters share a fixed control register. The current perf
reads and re-writes the fixed control register for each fixed counter
disable/enable, which is unnecessary.

When changing the fixed control register, the entire PMU must be
disabled via the global control register. The changing cannot be taken
effect until the entire PMU is re-enabled. Only updating the fixed
control register once right before the entire PMU re-enabling is enough.

The read of the fixed control register is not necessary either. The
value can be cached in the per CPU cpu_hw_events.

Test results:

Counting all the fixed counters with the perf bench sched pipe as below
on a SPR machine.

 $perf stat -e cycles,instructions,ref-cycles,slots --no-inherit --
  taskset -c 1 perf bench sched pipe

The Total elapsed time reduces from 5.36s (without the patch) to 4.99s
(with the patch), which is ~6.9% improvement.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 22 +++++++++++++---------
 arch/x86/events/perf_event.h |  4 ++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 45024abd929f..9e0ed28c9477 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2189,6 +2189,12 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	intel_pmu_lbr_enable_all(pmi);
+
+	if (cpuc->fixed_ctrl_val != cpuc->active_fixed_ctrl_val) {
+		wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cpuc->fixed_ctrl_val);
+		cpuc->active_fixed_ctrl_val = cpuc->fixed_ctrl_val;
+	}
+
 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL,
 	       intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
 
@@ -2406,9 +2412,10 @@ static inline void intel_clear_masks(struct perf_event *event, int idx)
 
 static void intel_pmu_disable_fixed(struct perf_event *event)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	u64 ctrl_val, mask;
 	int idx = hwc->idx;
+	u64 mask;
 
 	if (is_topdown_idx(idx)) {
 		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -2425,9 +2432,7 @@ static void intel_pmu_disable_fixed(struct perf_event *event)
 	intel_clear_masks(event, idx);
 
 	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
-	rdmsrl(hwc->config_base, ctrl_val);
-	ctrl_val &= ~mask;
-	wrmsrl(hwc->config_base, ctrl_val);
+	cpuc->fixed_ctrl_val &= ~mask;
 }
 
 static void intel_pmu_disable_event(struct perf_event *event)
@@ -2697,8 +2702,9 @@ static void intel_pmu_read_event(struct perf_event *event)
 
 static void intel_pmu_enable_fixed(struct perf_event *event)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	u64 ctrl_val, mask, bits = 0;
+	u64 mask, bits = 0;
 	int idx = hwc->idx;
 
 	if (is_topdown_idx(idx)) {
@@ -2742,10 +2748,8 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 		mask |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
 	}
 
-	rdmsrl(hwc->config_base, ctrl_val);
-	ctrl_val &= ~mask;
-	ctrl_val |= bits;
-	wrmsrl(hwc->config_base, ctrl_val);
+	cpuc->fixed_ctrl_val &= ~mask;
+	cpuc->fixed_ctrl_val |= bits;
 }
 
 static void intel_pmu_enable_event(struct perf_event *event)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 21a5482bcf84..0a616c729aa5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -270,6 +270,10 @@ struct cpu_hw_events {
 	u64			active_pebs_data_cfg;
 	int			pebs_record_size;
 
+	/* Intel Fixed counter configuration */
+	u64			fixed_ctrl_val;
+	u64			active_fixed_ctrl_val;
+
 	/*
 	 * Intel LBR bits
 	 */
-- 
2.35.1

