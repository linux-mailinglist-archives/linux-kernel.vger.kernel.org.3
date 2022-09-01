Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486CD5A983D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiIANNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiIANMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EDE193E1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662037812; x=1693573812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VAYkyqDSnodGS6K9hdzSBPYe+K9VppgK0hQVX5QVscs=;
  b=VBygMV7Ee0/BrtlPtMBrQFW2Bv4dpze2dFOqN9xam1hAbfegS1VN4QVi
   QXGaVsTyC8H5yJXI7oZMolPW+tQfQnyVFFMhGs+k7Ax2B5uXSXdxL6Xxd
   VGUiLtj2oFavl71oWAYwWqIXkgTPF3TZyywMc9cRSEyfjH3DAapYFET++
   xUWobEcenC0dr58sigHL2KyWl77KRexnIo8A0oNhg6EbwJTRqyxhMjYA9
   tt/IouGRxG0Ltew3T2545RlQpcT1LEWZ34o3KlWiYznwfhTU3kZyylegW
   dRPDcFEySh/eQpuCJ4FlCxKEBP3XFD6+mMcAoX4/RtMYqpQueTnheJ2rJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="321858103"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="321858103"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="612485385"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 06:10:05 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, namhyung@kernel.org,
        ravi.bangoria@amd.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 5/6] perf: Use sample_flags for data_src
Date:   Thu,  1 Sep 2022 06:09:58 -0700
Message-Id: <20220901130959.1285717-6-kan.liang@linux.intel.com>
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
index f66a4905cc87..985bbbab057f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1543,8 +1543,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
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
@@ -1778,8 +1780,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
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
index 06a587b5faa9..6849f10dfc7e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1013,7 +1013,6 @@ struct perf_sample_data {
 	struct perf_raw_record		*raw;
 	u64				period;
 	u64				txn;
-	union  perf_mem_data_src	data_src;
 
 	/*
 	 * The other fields, optionally {set,used} by
@@ -1021,6 +1020,7 @@ struct perf_sample_data {
 	 */
 	struct perf_branch_stack	*br_stack;
 	union perf_sample_weight	weight;
+	union  perf_mem_data_src	data_src;
 
 	u64				type;
 	u64				ip;
@@ -1063,7 +1063,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
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

