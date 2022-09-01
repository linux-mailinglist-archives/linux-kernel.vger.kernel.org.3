Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0965A9845
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiIANNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiIANMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A72D193F8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662037812; x=1693573812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aIu9wyISiFJZ1L6Y2dnIVdHXNqiCTMNU09sP58Dafk4=;
  b=VWPHRZtu6jG8Lja37eapVhh4xOrKpLbkHfhfylCPUmatSHlnUO20tckK
   nyVkhAjgas3vHCqbpbk158/CYmxrzUYMwuBxH07i1nSlQC7QBVLJuz6uK
   mk9EYXJkUHkNzJtb+KK9asKVOzw/o/7PrfVWXNJpwTaw9jdZalrVDxUhw
   m+r+voCEQUanH5tVVXcVUsMFNrGk8v5jND/8dRBVjdylM+LJfqd+UINfF
   CiocX8Q7JRXeMbfJXM+zi20f4/L0FRlXVElONIu/fPY+NeosDg52uWs6W
   qxj3YZaI3FKehgX4WKJYjU3bdcqxX9FbQZZ89fuVWoHr+JX16AHT5rUW4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="321858102"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="321858102"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="612485377"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 06:10:04 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, namhyung@kernel.org,
        ravi.bangoria@amd.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/6] perf: Use sample_flags for weight
Date:   Thu,  1 Sep 2022 06:09:57 -0700
Message-Id: <20220901130959.1285717-5-kan.liang@linux.intel.com>
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
index 5dcfd2de6ef8..f66a4905cc87 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1535,8 +1535,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
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
@@ -1628,9 +1630,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 
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
@@ -1772,6 +1775,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 				data->weight.var1_dw = (u32)(weight & PEBS_LATENCY_MASK) ?:
 					intel_get_tsx_weight(meminfo->tsx_tuning);
 			}
+			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
 
 		if (sample_type & PERF_SAMPLE_DATA_SRC)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1e12e79454e0..06a587b5faa9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1012,7 +1012,6 @@ struct perf_sample_data {
 	u64				addr;
 	struct perf_raw_record		*raw;
 	u64				period;
-	union perf_sample_weight	weight;
 	u64				txn;
 	union  perf_mem_data_src	data_src;
 
@@ -1021,6 +1020,7 @@ struct perf_sample_data {
 	 * perf_{prepare,output}_sample().
 	 */
 	struct perf_branch_stack	*br_stack;
+	union perf_sample_weight	weight;
 
 	u64				type;
 	u64				ip;
@@ -1063,7 +1063,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
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

