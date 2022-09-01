Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33B95A9838
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiIANNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiIANMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4382E0B7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662037810; x=1693573810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aYEJXQp4LMSuhaEYUhvioL84bOLWTKxZFDPBy+R5Et4=;
  b=ky84W9liK7jSws8XccfKU4c91lAQwAU7AI1y22LMaT1V+QBDKOVlndhI
   N3E9B+Z60JxI6XM/AvXRMSd7c7p3I4nXQWRSYSULHv3zuzeYtAGhBgGr/
   8RejXa1rZFNVre0WL0n3KpvUme7QsbLPHu4BDhDJfkm4I4e/qaMuLaV96
   OLQLAm0hwnVIY7DQRKFbFQrG3j5cwTqr3pgyjo8GesSHGZbiELIUB4pm7
   zy97CQaAsOmc9qxm9n/jM/p2kA13VhEpITQd8C5CVoJsItvMOxtLBPAg5
   P+amzdgT1/Xp/PJUw0/h56vfRvj+VxLuBgfvSeTASDiJve2NQsVXBapA1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="321858097"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="321858097"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="612485357"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 06:10:03 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, namhyung@kernel.org,
        ravi.bangoria@amd.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/6] perf: Use sample_flags for branch stack
Date:   Thu,  1 Sep 2022 06:09:56 -0700
Message-Id: <20220901130959.1285717-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901130959.1285717-1-kan.liang@linux.intel.com>
References: <20220901130959.1285717-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Use the new sample_flags to indicate whether the branch stack is filled
by the PMU driver.

Remove the br_stack from the perf_sample_data_init() to minimize the number
of cache lines touched.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/powerpc/perf/core-book3s.c | 1 +
 arch/x86/events/amd/core.c      | 4 +++-
 arch/x86/events/core.c          | 4 +++-
 arch/x86/events/intel/core.c    | 4 +++-
 arch/x86/events/intel/ds.c      | 5 ++++-
 include/linux/perf_event.h      | 4 ++--
 kernel/events/core.c            | 4 ++--
 7 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 13919eb96931..1ad1efdb33f9 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2297,6 +2297,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			cpuhw = this_cpu_ptr(&cpu_hw_events);
 			power_pmu_bhrb_read(event, cpuhw);
 			data.br_stack = &cpuhw->bhrb_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 		}
 
 		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9fbdfbcaf25a..8b70237c33f7 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -929,8 +929,10 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
 			data.br_stack = &cpuc->lbr_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+		}
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c3d6d139a3c1..b30b8bbcd1e2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1701,8 +1701,10 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
 			data.br_stack = &cpuc->lbr_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+		}
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7c1e3d36bc65..b5c02627a155 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3017,8 +3017,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
 			data.br_stack = &cpuc->lbr_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+		}
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 01cbe26225c2..5dcfd2de6ef8 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1648,8 +1648,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 		data->sample_flags |= PERF_SAMPLE_TIME;
 	}
 
-	if (has_branch_stack(event))
+	if (has_branch_stack(event)) {
 		data->br_stack = &cpuc->lbr_stack;
+		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+	}
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
@@ -1799,6 +1801,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
 			data->br_stack = &cpuc->lbr_stack;
+			data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 		}
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0978165a2d87..1e12e79454e0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1011,7 +1011,6 @@ struct perf_sample_data {
 	u64				sample_flags;
 	u64				addr;
 	struct perf_raw_record		*raw;
-	struct perf_branch_stack	*br_stack;
 	u64				period;
 	union perf_sample_weight	weight;
 	u64				txn;
@@ -1021,6 +1020,8 @@ struct perf_sample_data {
 	 * The other fields, optionally {set,used} by
 	 * perf_{prepare,output}_sample().
 	 */
+	struct perf_branch_stack	*br_stack;
+
 	u64				type;
 	u64				ip;
 	struct {
@@ -1061,7 +1062,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->sample_flags = 0;
 	data->addr = addr;
 	data->raw  = NULL;
-	data->br_stack = NULL;
 	data->period = period;
 	data->weight.full = 0;
 	data->data_src.val = PERF_MEM_NA;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9b9cb79231a..104c0c9f4e6f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7052,7 +7052,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
-		if (data->br_stack) {
+		if (data->sample_flags & PERF_SAMPLE_BRANCH_STACK) {
 			size_t size;
 
 			size = data->br_stack->nr
@@ -7358,7 +7358,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		int size = sizeof(u64); /* nr */
-		if (data->br_stack) {
+		if (data->sample_flags & PERF_SAMPLE_BRANCH_STACK) {
 			if (perf_sample_save_hw_index(event))
 				size += sizeof(u64);
 
-- 
2.35.1

