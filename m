Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BF5A8029
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiHaO1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiHaO1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:27:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD405FA6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661956030; x=1693492030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f/tx4HstoWexwW7NwofC2BOF+4rhY/cdACr3KY5fi9E=;
  b=BFwCGtA2Wp457WP4xKJrsEfXAXv8nRLQsrQfR8ayh17ZbbLFY5043HaP
   Mvgf8vUyvR6MIH/mHSuYsgkyBo5bW8FiVKk18Vws/EdTApq/rWzf8dfIT
   jWjBk//87BWBWYDJ5a0x34ke/Xxz0U9z3NGljYhiVUWGVokbM8H/RqRPC
   6S0/xCD8FacRqQvY4f4WyQAyqH2N9UTqsX9QPVB2udIRR/uS4lYkDMUYq
   wqLrcVK6iBgpuTQxVcp/9+hRIOok5c0NHcSo2jdbvYGYTtGWGIRLZEvxM
   jdh5Pi/Sf9VKTfxnliXiMWr2V9Bs8JLKB2a1yxgi/EVMX8lGac752reCP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="282431543"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="282431543"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="680434966"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2022 07:27:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        zhengjun.xing@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Jianfeng Gao <jianfeng.gao@intel.com>
Subject: [PATCH V2] perf/x86/intel: Fix unchecked MSR access error for Alder Lake N
Date:   Wed, 31 Aug 2022 07:27:02 -0700
Message-Id: <20220831142702.153110-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

For some Alder Lake N machine, the below unchecked MSR access error may be
triggered.

[ 0.088017] rcu: Hierarchical SRCU implementation.
[ 0.088017] unchecked MSR access error: WRMSR to 0x38f (tried to write
0x0001000f0000003f) at rIP: 0xffffffffb5684de8 (native_write_msr+0x8/0x30)
[ 0.088017] Call Trace:
[ 0.088017] <TASK>
[ 0.088017] __intel_pmu_enable_all.constprop.46+0x4a/0xa0

The Alder Lake N only has e-cores. The X86_FEATURE_HYBRID_CPU flag is
not set. The perf cannot retrieve the correct CPU type via
get_this_hybrid_cpu_type(). The model specific get_hybrid_cpu_type() is
hardcode to p-core. The wrong CPU type is given to the PMU of the
Alder Lake N.

Since Alder Lake N isn't in fact a hybrid CPU, remove ALDERLAKE_N from
the rest of {ALDER,RAPTOP}LAKE and create a non-hybrid PMU setup.

The differences between Gracemont and the previous Tremont are,
- Number of GP counters
- Load and store latency Events
- PEBS event_constraints
- Instruction Latency support
- Data source encoding
- Memory access latency encoding

Fixes: c2a960f7c574 ("perf/x86: Add new Alder Lake and Raptor Lake support")
Reported-by: Jianfeng Gao <jianfeng.gao@intel.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Remove ALDERLAKE_N from the rest of {ALDER,RAPTOP}LAKE and create a
non-hybrid PMU setup.

 arch/x86/events/intel/core.c | 40 +++++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c   |  9 ++++++--
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2db93498ff71..4fce2bdbbf87 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2102,6 +2102,15 @@ static struct extra_reg intel_tnt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+EVENT_ATTR_STR(mem-loads,	mem_ld_grt,	"event=0xd0,umask=0x5,ldlat=3");
+EVENT_ATTR_STR(mem-stores,	mem_st_grt,	"event=0xd0,umask=0x6");
+
+static struct attribute *grt_mem_attrs[] = {
+	EVENT_PTR(mem_ld_grt),
+	EVENT_PTR(mem_st_grt),
+	NULL
+};
+
 static struct extra_reg intel_grt_extra_regs[] __read_mostly = {
 	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
 	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
@@ -5974,6 +5983,36 @@ __init int intel_pmu_init(void)
 		name = "Tremont";
 		break;
 
+	case INTEL_FAM6_ALDERLAKE_N:
+		x86_pmu.mid_ack = true;
+		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
+		       sizeof(hw_cache_event_ids));
+		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
+		       sizeof(hw_cache_extra_regs));
+		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
+
+		x86_pmu.event_constraints = intel_slm_event_constraints;
+		x86_pmu.pebs_constraints = intel_grt_pebs_event_constraints;
+		x86_pmu.extra_regs = intel_grt_extra_regs;
+
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.pebs_block = true;
+		x86_pmu.lbr_pt_coexist = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
+
+		intel_pmu_pebs_data_source_grt();
+		x86_pmu.pebs_latency_data = adl_latency_data_small;
+		x86_pmu.get_event_constraints = tnt_get_event_constraints;
+		x86_pmu.limit_period = spr_limit_period;
+		td_attr = tnt_events_attrs;
+		mem_attr = grt_mem_attrs;
+		extra_attr = nhm_format_attr;
+		pr_cont("Gracemont events, ");
+		name = "gracemont";
+		break;
+
 	case INTEL_FAM6_WESTMERE:
 	case INTEL_FAM6_WESTMERE_EP:
 	case INTEL_FAM6_WESTMERE_EX:
@@ -6318,7 +6357,6 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 		/*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba60427caa6d..6ce73b4ae2f3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -110,13 +110,18 @@ void __init intel_pmu_pebs_data_source_skl(bool pmem)
 	__intel_pmu_pebs_data_source_skl(pmem, pebs_data_source);
 }
 
-static void __init intel_pmu_pebs_data_source_grt(u64 *data_source)
+static void __init __intel_pmu_pebs_data_source_grt(u64 *data_source)
 {
 	data_source[0x05] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HIT);
 	data_source[0x06] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
 	data_source[0x08] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOPX, FWD);
 }
 
+void __init intel_pmu_pebs_data_source_grt(void)
+{
+	__intel_pmu_pebs_data_source_grt(pebs_data_source);
+}
+
 void __init intel_pmu_pebs_data_source_adl(void)
 {
 	u64 *data_source;
@@ -127,7 +132,7 @@ void __init intel_pmu_pebs_data_source_adl(void)
 
 	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
 	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
-	intel_pmu_pebs_data_source_grt(data_source);
+	__intel_pmu_pebs_data_source_grt(data_source);
 }
 
 static u64 precise_store_data(u64 status)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ba3d24a6a4ec..266143abcbd8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1516,6 +1516,8 @@ void intel_pmu_pebs_data_source_skl(bool pmem);
 
 void intel_pmu_pebs_data_source_adl(void);
 
+void intel_pmu_pebs_data_source_grt(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
-- 
2.35.1

