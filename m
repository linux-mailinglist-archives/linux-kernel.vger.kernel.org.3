Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCF5A80BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiHaO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiHaO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:56:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED73CC325
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957746; x=1693493746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Th+Kkqmd56IzaaVSmR68ZC7TOhiCUwkMlU7+pGxLX04=;
  b=byQbywdEU8GlG3NCPVYyPvYYKMIynmvZYF3PAbuxqvFetJu7zO1L447k
   j9O3z+TCMkBle+0F770qAs4e0cROjIYiVxDpgSqpLW/5VSrVpHGOSIo4i
   8lzlvogYUW2HmlULQ7b9rcWbhyey4Hxt9fT4Qcyn8gbm+igP4OWRTH648
   ansSJVZzFipCS3cA3MraFnfegHFtTtfuYj4ywaHUuk8axw8iMjFNL5ihS
   rbQeOJtdfUOJLICF2l0umIsseE4hvRXcJaiqtRbSm61hxcOVRe1UcQcDg
   UcqeYZ8YSg8WIIFvsTf55/1DeXzeqpj/JXqBfToN5oWxHQeiE9V43TFwU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296248196"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296248196"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="614991683"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga007.fm.intel.com with ESMTP; 31 Aug 2022 07:55:45 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/6] perf: Use sample_flags for weight
Date:   Wed, 31 Aug 2022 07:55:12 -0700
Message-Id: <20220831145514.190514-5-kan.liang@linux.intel.com>
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

Use the new sample_flags to indicate whether the weight field is filled
by the PMU driver.

Remove the weight field from the perf_sample_data_init() to minimize the
number of cache lines touched.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/powerpc/perf/core-book3s.c |  5 +++--
 arch/x86/events/intel/ds.c      | 10 +++++++---
 include/linux/perf_event.h      |  3 +--
 kernel/events/core.c            |  3 +++
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 1ad1efdb33f9..a5c95a2006ea 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2305,9 +2305,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			ppmu->get_mem_data_src(&data.data_src, ppmu->flags, regs);
 
 		if (event->attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE &&
-						ppmu->get_mem_weight)
+						ppmu->get_mem_weight) {
 			ppmu->get_mem_weight(&data.weight.full, event->attr.sample_type);
-
+			data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+		}
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
 	} else if (period) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index d5f3007af59d..e80632a575d1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1532,8 +1532,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	/*
 	 * Use latency for weight (only avail with PEBS-LL)
 	 */
-	if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE))
+	if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE)) {
 		data->weight.full = pebs->lat;
+		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+	}
 
 	/*
 	 * data.data_src encodes the data source
@@ -1625,9 +1627,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 
 	if (x86_pmu.intel_cap.pebs_format >= 2) {
 		/* Only set the TSX weight when no memory weight. */
-		if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll)
+		if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll) {
 			data->weight.full = intel_get_tsx_weight(pebs->tsx_tuning);
-
+			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+		}
 		if (sample_type & PERF_SAMPLE_TRANSACTION)
 			data->txn = intel_get_tsx_transaction(pebs->tsx_tuning,
 							      pebs->ax);
@@ -1769,6 +1772,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 				data->weight.var1_dw = (u32)(weight & PEBS_LATENCY_MASK) ?:
 					intel_get_tsx_weight(meminfo->tsx_tuning);
 			}
+			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
 
 		if (sample_type & PERF_SAMPLE_DATA_SRC)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2aec1765b3d5..c030d1d1c675 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1011,7 +1011,6 @@ struct perf_sample_data {
 	u64				addr;
 	struct perf_raw_record		*raw;
 	u64				period;
-	union perf_sample_weight	weight;
 	u64				txn;
 	union  perf_mem_data_src	data_src;
 
@@ -1020,6 +1019,7 @@ struct perf_sample_data {
 	 * perf_{prepare,output}_sample().
 	 */
 	struct perf_branch_stack	*br_stack;
+	union perf_sample_weight	weight;
 
 	u64				type;
 	u64				ip;
@@ -1062,7 +1062,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->addr = addr;
 	data->raw  = NULL;
 	data->period = period;
-	data->weight.full = 0;
 	data->data_src.val = PERF_MEM_NA;
 	data->txn = 0;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 104c0c9f4e6f..f0af45db02b3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7408,6 +7408,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 		header->size += size;
 	}
 
+	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+		data->weight.full = 0;
+
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
-- 
2.35.1

