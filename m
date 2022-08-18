Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A90598AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345359AbiHRSQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiHRSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:16:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB90CD512
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660846566; x=1692382566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v6A93LjE2dNH8Mj7op2GhgnKZwH9TxO51WykoAIHs7A=;
  b=PE7HOcb4q0LNmnuwlGgVcRYeC99TofPwZ4MiR02Nz9PMxRZl4tgNU4bK
   l3E8LIXGPyiwCLAvMBO5b3Im+fsB200tgCoo7iebJqIDz3oT85le340UT
   35xXXkgIKn6o2DZL46dSU5Kt8qBIZjH56aoe7mIKNHdSfBPeBno8a/Wj3
   wKsUlsMzh8M+bN8DANVwHq0fKB5A3CpiTO+muK02jghrH1ytXQdxgosPp
   CaorY51CJ+fLYe85cCLvuK7hGvVWQ6MP8yeyDjt+5dy0tJIGXvYp36U4V
   WfzywT1RwaFaLbuR00TCzGRExuamygP9hedeyOUQUR71+v54/lS7lXkGt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="294113524"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="294113524"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 11:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="711048711"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2022 11:16:05 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Jianfeng Gao <jianfeng.gao@intel.com>
Subject: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error for Alder Lake N
Date:   Thu, 18 Aug 2022 11:15:30 -0700
Message-Id: <20220818181530.2355034-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Add a model check to return the e-core CPU type for Alder Lake N.

Factor out x86_pmu_get_this_hybrid_cpu_type().

Fixes: c2a960f7c574 ("perf/x86: Add new Alder Lake and Raptor Lake support")
Reported-by: Jianfeng Gao <jianfeng.gao@intel.com>
Tested-by: Jianfeng Gao <jianfeng.gao@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 15 +++++++++++----
 arch/x86/events/intel/core.c |  8 ++++----
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0b19ffaa2dee..94cdf7e76b86 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2076,6 +2076,16 @@ void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu)
 	cpuctx->ctx.pmu = pmu;
 }
 
+u8 x86_pmu_get_this_hybrid_cpu_type(void)
+{
+	u8 cpu_type = get_this_hybrid_cpu_type();
+
+	if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
+		return x86_pmu.get_hybrid_cpu_type();
+
+	return cpu_type;
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2175,13 +2185,10 @@ static int __init init_hw_perf_events(void)
 		if (err)
 			goto out2;
 	} else {
-		u8 cpu_type = get_this_hybrid_cpu_type();
+		u8 cpu_type = x86_pmu_get_this_hybrid_cpu_type();
 		struct x86_hybrid_pmu *hybrid_pmu;
 		int i, j;
 
-		if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
-			cpu_type = x86_pmu.get_hybrid_cpu_type();
-
 		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 217c5695cbb0..1d57cf0be806 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4267,6 +4267,9 @@ static int adl_hw_config(struct perf_event *event)
 
 static u8 adl_get_hybrid_cpu_type(void)
 {
+	if (boot_cpu_data.x86_model == INTEL_FAM6_ALDERLAKE_N)
+		return hybrid_small;
+
 	return hybrid_big;
 }
 
@@ -4430,13 +4433,10 @@ static void flip_smm_bit(void *data)
 static bool init_hybrid_pmu(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
-	u8 cpu_type = get_this_hybrid_cpu_type();
+	u8 cpu_type = x86_pmu_get_this_hybrid_cpu_type();
 	struct x86_hybrid_pmu *pmu = NULL;
 	int i;
 
-	if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
-		cpu_type = x86_pmu.get_hybrid_cpu_type();
-
 	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 		if (x86_pmu.hybrid_pmu[i].cpu_type == cpu_type) {
 			pmu = &x86_pmu.hybrid_pmu[i];
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ba30f24bec41..c1bf7e6af6a0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1176,6 +1176,8 @@ void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 
 void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu);
 
+u8 x86_pmu_get_this_hybrid_cpu_type(void);
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
-- 
2.35.1

