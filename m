Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F35A80BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiHaO47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiHaO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:56:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE7CCE3B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957747; x=1693493747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gHPh3sEBIfJJjkAbNeqnHdXeqa7zmq3xnXel25hgjnY=;
  b=LIXsg+OE7MHBGwp/CkpuVltOQsqsQtHE7Nu3hV3CB4G1X+xet5B57tQP
   gHCzTOA4jPOsPIYUqFM5KcSTtSG2FxNaRut+kEnrqL5QcFGI5r9999H9c
   TWhelPcHMzllcMqRZnG9sUqZX4aPZwHkljKT0QFzzJIcCbfeGqL1xHbIZ
   17vzU2C5TLXdV0+npaxI79KWCX5apVl9XdwGXcjkeCQu8NBEEXM9il8eD
   5b/68BlgmSbg+TdOBVZ+1DVTY7dxxU4kD+zebEfkq26xWZrGzgcC0NAYb
   uDipqSWf16SKFIM5IrlNzFJncUJdF6W3NY7PXjWwP/hEWGLH9G/BuCjNw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296248198"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296248198"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="614991685"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga007.fm.intel.com with ESMTP; 31 Aug 2022 07:55:45 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/6] perf: Use sample_flags for txn
Date:   Wed, 31 Aug 2022 07:55:14 -0700
Message-Id: <20220831145514.190514-7-kan.liang@linux.intel.com>
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
index 9a10457ff32a..3c6a68d7fe42 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1633,9 +1633,11 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
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
@@ -1785,9 +1787,11 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
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
index 79b44084c15d..d7c9fdd82bc3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1011,7 +1011,6 @@ struct perf_sample_data {
 	u64				addr;
 	struct perf_raw_record		*raw;
 	u64				period;
-	u64				txn;
 
 	/*
 	 * The other fields, optionally {set,used} by
@@ -1020,6 +1019,7 @@ struct perf_sample_data {
 	struct perf_branch_stack	*br_stack;
 	union perf_sample_weight	weight;
 	union  perf_mem_data_src	data_src;
+	u64				txn;
 
 	u64				type;
 	u64				ip;
@@ -1062,7 +1062,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
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

