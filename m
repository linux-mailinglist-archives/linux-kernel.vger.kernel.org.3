Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1153B5A80BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiHaO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiHaO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:56:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5CDCCD61
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957747; x=1693493747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qrAa0Is2zPCGKakBa/pG1x7ldNZCFiMTJH5UKK30Rok=;
  b=AkawByBAMe5xj4G2EalPGPLMJRhg/OOYo+nkL/GUvffv511Jlqpnq+7r
   ZqUv3u396p/yb/MmACE3r0YJEzqLKlrl3jJaIlORl35RjgSktawwj8oe6
   pO7YrjzLN7EgJ38JyFV+TrwrnDmpRtoCCIfhWISUinqJq8BbaaZa3n1fq
   m0lv5dHV40yKn8c16X8iQv/V/dChEqh9bd0u0EYJ7l8GezGJTNhmzFQAl
   J/KcFMpEMHz6jKjszluN6nhI1BcsjTt5pe5C5gJX9ICzfq/yQJ6p6j7Gj
   lUmF6JWYagnt8vXflMkwi4teDREm+E1BRJHSldGME4djBTYZO0GQCG2Hf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296248197"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296248197"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="614991684"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga007.fm.intel.com with ESMTP; 31 Aug 2022 07:55:45 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/6] perf: Use sample_flags for data_src
Date:   Wed, 31 Aug 2022 07:55:13 -0700
Message-Id: <20220831145514.190514-6-kan.liang@linux.intel.com>
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

Use the new sample_flags to indicate whether the data_src field is
filled by the PMU driver.

Remove the data_src field from the perf_sample_data_init() to minimize
the number of cache lines touched.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/powerpc/perf/core-book3s.c | 4 +++-
 arch/x86/events/intel/ds.c      | 8 ++++++--
 include/linux/perf_event.h      | 3 +--
 kernel/events/core.c            | 3 +++
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index a5c95a2006ea..6ec7069e6482 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2301,8 +2301,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 		}
 
 		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
-						ppmu->get_mem_data_src)
+						ppmu->get_mem_data_src) {
 			ppmu->get_mem_data_src(&data.data_src, ppmu->flags, regs);
+			data.sample_flags |= PERF_SAMPLE_DATA_SRC;
+		}
 
 		if (event->attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE &&
 						ppmu->get_mem_weight) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e80632a575d1..9a10457ff32a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1540,8 +1540,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	/*
 	 * data.data_src encodes the data source
 	 */
-	if (sample_type & PERF_SAMPLE_DATA_SRC)
+	if (sample_type & PERF_SAMPLE_DATA_SRC) {
 		data->data_src.val = get_data_src(event, pebs->dse);
+		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+	}
 
 	/*
 	 * We must however always use iregs for the unwinder to stay sane; the
@@ -1775,8 +1777,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
 
-		if (sample_type & PERF_SAMPLE_DATA_SRC)
+		if (sample_type & PERF_SAMPLE_DATA_SRC) {
 			data->data_src.val = get_data_src(event, meminfo->aux);
+			data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+		}
 
 		if (sample_type & PERF_SAMPLE_ADDR_TYPE)
 			data->addr = meminfo->address;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c030d1d1c675..79b44084c15d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1012,7 +1012,6 @@ struct perf_sample_data {
 	struct perf_raw_record		*raw;
 	u64				period;
 	u64				txn;
-	union  perf_mem_data_src	data_src;
 
 	/*
 	 * The other fields, optionally {set,used} by
@@ -1020,6 +1019,7 @@ struct perf_sample_data {
 	 */
 	struct perf_branch_stack	*br_stack;
 	union perf_sample_weight	weight;
+	union  perf_mem_data_src	data_src;
 
 	u64				type;
 	u64				ip;
@@ -1062,7 +1062,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->addr = addr;
 	data->raw  = NULL;
 	data->period = period;
-	data->data_src.val = PERF_MEM_NA;
 	data->txn = 0;
 }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0af45db02b3..163e2f478e61 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7411,6 +7411,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
 		data->weight.full = 0;
 
+	if (filtered_sample_type & PERF_SAMPLE_DATA_SRC)
+		data->data_src.val = PERF_MEM_NA;
+
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
-- 
2.35.1

