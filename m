Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0550B5A80B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiHaO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiHaO4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:56:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD033CB5F7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957746; x=1693493746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tKCKqwQ8m8var63qlj80j+a8U1AHxCZ1pQ7hTm4PXaM=;
  b=b/KjTF2KvjSS7qKX/SzPhQfQ8/x7MZc1+nxKI9+y5YiqYFxbSYijqfST
   STBFs0tp0z1Y7GR6OTSRV9KWo8myY8wXT8ZeBjXrdwF2sQOmacR4BKCye
   iQRBKk7zJaig/I9lHmfUizDSbhvLW2odWeuX0iUTco7EM6JkSKuGXNVtS
   UYt3nZn3jCEpJ5Q7/gBO1GpyoklF+DvRdh5w4KxF5XEt0QBGFZNui/b3H
   ZxGLYB4+LfZvXcTW7vVD2Sj/MDJPZe5T7P7dj8yYtIGPQficQ+pt95dsy
   tbeybWD3h4sRslqRyAUku5y91Hv1gz6MJpDyIYyIjOLv+lS44jq8M9BtE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296248194"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296248194"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="614991682"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga007.fm.intel.com with ESMTP; 31 Aug 2022 07:55:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/6] perf: Use sample_flags for branch stack
Date:   Wed, 31 Aug 2022 07:55:11 -0700
Message-Id: <20220831145514.190514-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831145514.190514-1-kan.liang@linux.intel.com>
References: <20220831145514.190514-1-kan.liang@linux.intel.com>
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

Use the new sample_flags to indicate whether the branch stack is filled
by the PMU driver.

Remove the br_stack from the perf_sample_data_init() to minimize the number
of cache lines touched.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/powerpc/perf/core-book3s.c | 1 +
 arch/x86/events/core.c          | 4 +++-
 arch/x86/events/intel/core.c    | 4 +++-
 arch/x86/events/intel/ds.c      | 5 ++++-
 include/linux/perf_event.h      | 4 ++--
 kernel/events/core.c            | 4 ++--
 6 files changed, 15 insertions(+), 7 deletions(-)

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
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f969410d0c90..bb34a28fa71b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1714,8 +1714,10 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
 			data.br_stack = &cpuc->lbr_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+		}
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4fce2bdbbf87..36f95894dd1c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3004,8 +3004,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
 			data.br_stack = &cpuc->lbr_stack;
+			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+		}
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 3af24c4891fb..d5f3007af59d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1645,8 +1645,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 		data->sample_flags |= PERF_SAMPLE_TIME;
 	}
 
-	if (has_branch_stack(event))
+	if (has_branch_stack(event)) {
 		data->br_stack = &cpuc->lbr_stack;
+		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+	}
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
@@ -1796,6 +1798,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
 			data->br_stack = &cpuc->lbr_stack;
+			data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 		}
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b0ebbb1377b9..2aec1765b3d5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1010,7 +1010,6 @@ struct perf_sample_data {
 	u64				sample_flags;
 	u64				addr;
 	struct perf_raw_record		*raw;
-	struct perf_branch_stack	*br_stack;
 	u64				period;
 	union perf_sample_weight	weight;
 	u64				txn;
@@ -1020,6 +1019,8 @@ struct perf_sample_data {
 	 * The other fields, optionally {set,used} by
 	 * perf_{prepare,output}_sample().
 	 */
+	struct perf_branch_stack	*br_stack;
+
 	u64				type;
 	u64				ip;
 	struct {
@@ -1060,7 +1061,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
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

