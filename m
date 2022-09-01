Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F885A983C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiIANN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiIANMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534DB1836E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662037820; x=1693573820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qpsqdIXip8GJMg2qH7wz01QFOLYcLgSpec40aEnpF+8=;
  b=ZtYnvCWbtxMRYeKSvU9aqxLfH68XjZpT+3DteiDJ2QBzQTo0Lrk6/jLq
   ijOu980969Lzxxq6lgG0GvjNF7XuvHT1ZvRok8H5hKazg9MFkoNF1gUfc
   4lGp2zei37xrIJeVFgjoNZ2/pMd1/OSZt6/hjaEsEcT8AWGrE14d63J8U
   4mpddRscV/hT3Ufdc8qLCJTlOlGE0H3cGBxoIphL2JvM7xC00W2iTbDWY
   l6mMhU9ZrTdQJ/Ls4rXLANetE3Zg9d8R+OjwCNlNVb4wAXb8MT1zS1J//
   /krToRpPiXQ0TlY0aI/+8BnS3ry7ChoRu8JEUMjpCFbaVVhZzIn/hQCGu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="321858106"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="321858106"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:10:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="612485395"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 06:10:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, namhyung@kernel.org,
        ravi.bangoria@amd.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 6/6] perf: Use sample_flags for txn
Date:   Thu,  1 Sep 2022 06:09:59 -0700
Message-Id: <20220901130959.1285717-7-kan.liang@linux.intel.com>
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

Use the new sample_flags to indicate whether the txn field is filled by
the PMU driver.

Remove the txn field from the perf_sample_data_init() to minimize the
number of cache lines touched.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 8 ++++++--
 include/linux/perf_event.h | 3 +--
 kernel/events/core.c       | 3 +++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 985bbbab057f..cbcb5c2e832c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1636,9 +1636,11 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 			data->weight.full = intel_get_tsx_weight(pebs->tsx_tuning);
 			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
-		if (sample_type & PERF_SAMPLE_TRANSACTION)
+		if (sample_type & PERF_SAMPLE_TRANSACTION) {
 			data->txn = intel_get_tsx_transaction(pebs->tsx_tuning,
 							      pebs->ax);
+			data->sample_flags |= PERF_SAMPLE_TRANSACTION;
+		}
 	}
 
 	/*
@@ -1788,9 +1790,11 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (sample_type & PERF_SAMPLE_ADDR_TYPE)
 			data->addr = meminfo->address;
 
-		if (sample_type & PERF_SAMPLE_TRANSACTION)
+		if (sample_type & PERF_SAMPLE_TRANSACTION) {
 			data->txn = intel_get_tsx_transaction(meminfo->tsx_tuning,
 							  gprs ? gprs->ax : 0);
+			data->sample_flags |= PERF_SAMPLE_TRANSACTION;
+		}
 	}
 
 	if (format_size & PEBS_DATACFG_XMMS) {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6849f10dfc7e..581880ddb9ef 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1012,7 +1012,6 @@ struct perf_sample_data {
 	u64				addr;
 	struct perf_raw_record		*raw;
 	u64				period;
-	u64				txn;
 
 	/*
 	 * The other fields, optionally {set,used} by
@@ -1021,6 +1020,7 @@ struct perf_sample_data {
 	struct perf_branch_stack	*br_stack;
 	union perf_sample_weight	weight;
 	union  perf_mem_data_src	data_src;
+	u64				txn;
 
 	u64				type;
 	u64				ip;
@@ -1063,7 +1063,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->addr = addr;
 	data->raw  = NULL;
 	data->period = period;
-	data->txn = 0;
 }
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 163e2f478e61..15d27b14c827 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7414,6 +7414,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (filtered_sample_type & PERF_SAMPLE_DATA_SRC)
 		data->data_src.val = PERF_MEM_NA;
 
+	if (filtered_sample_type & PERF_SAMPLE_TRANSACTION)
+		data->txn = 0;
+
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
-- 
2.35.1

