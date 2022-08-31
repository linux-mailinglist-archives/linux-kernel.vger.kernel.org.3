Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9C5A80B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiHaO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiHaO4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:56:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE150C9908
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957745; x=1693493745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gus0aTfcf/kp+LWpuOTpUd2EeTfjQ4el7EkieP/ZXEM=;
  b=dQJKP/efKft1nayRq671sysuHwluVv3Uycj9VKcMMrkYNpC/HZ9KQ5Cn
   ONBNsWNtiGwNRSaGAA8qhLjdMzsBinwgiMSw3wqbsGq4mp/m9Q4WBNzdY
   ASV9cdTpxvxWiErnjpcppOAVgWKOSwDyBkJA99IwQmBgUO8VN+TGpjIFz
   lH0ENvU4AViTnL0U+k3o/vueSrakl+/uAPZnSoKdEmxXcPF2Gvcry6pZv
   tS1UTRXwfSoZdqVm6d0PDn2mZY0bmozhU7nwZLxpqvsbRvtgagKcGWPHc
   PmRAFFF+sxZHN1irqQO8sZ7xC6OJovKdikbFdkaY6Qzg+oid+WRoydMR+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296248192"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296248192"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="614991679"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga007.fm.intel.com with ESMTP; 31 Aug 2022 07:55:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/6] perf: Add sample_flags to indicate the PMU-filled sample data
Date:   Wed, 31 Aug 2022 07:55:09 -0700
Message-Id: <20220831145514.190514-2-kan.liang@linux.intel.com>
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

On some platforms, some data e.g., timestamps, can be retrieved from
the PMU driver. Usually, the data from the PMU driver is more accurate.
The current perf kernel should output the PMU-filled sample data if
it's available.

To check the availability of the PMU-filled sample data, the current
perf kernel initializes the related fields in the
perf_sample_data_init(). When outputting a sample, the perf checks
whether the field is updated by the PMU driver. If yes, the updated
value will be output. If not, the perf uses an SW way to calculate the
value or just outputs the initialized value if an SW way is unavailable
either.

With more and more data being provided by the PMU driver, more fields
has to be initialized in the perf_sample_data_init(). That will
increase the number of cache lines touched in perf_sample_data_init()
and be harmful to the performance.

Add new "sample_flags" to indicate the PMU-filled sample data. The PMU
driver should set the corresponding PERF_SAMPLE_ flag when the field is
updated. The initialization of the corresponding field is not required
anymore. The following patches will make use of it and remove the
corresponding fields from the perf_sample_data_init(), which will
further minimize the number of cache lines touched.

Only clear the sample flags that have already been done by the PMU
driver in the perf_prepare_sample() for the PERF_RECORD_SAMPLE. For the
other PERF_RECORD_ event type, the sample data is not available.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h |  2 ++
 kernel/events/core.c       | 17 +++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ee8b9ecdc03b..b0ebbb1377b9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1007,6 +1007,7 @@ struct perf_sample_data {
 	 * Fields set by perf_sample_data_init(), group so as to
 	 * minimize the cachelines touched.
 	 */
+	u64				sample_flags;
 	u64				addr;
 	struct perf_raw_record		*raw;
 	struct perf_branch_stack	*br_stack;
@@ -1056,6 +1057,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 					 u64 addr, u64 period)
 {
 	/* remaining struct members initialized in perf_prepare_sample() */
+	data->sample_flags = 0;
 	data->addr = addr;
 	data->raw  = NULL;
 	data->br_stack = NULL;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..c9b9cb79231a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6794,11 +6794,10 @@ static void perf_aux_sample_output(struct perf_event *event,
 
 static void __perf_event_header__init_id(struct perf_event_header *header,
 					 struct perf_sample_data *data,
-					 struct perf_event *event)
+					 struct perf_event *event,
+					 u64 sample_type)
 {
-	u64 sample_type = event->attr.sample_type;
-
-	data->type = sample_type;
+	data->type = event->attr.sample_type;
 	header->size += event->id_header_size;
 
 	if (sample_type & PERF_SAMPLE_TID) {
@@ -6827,7 +6826,7 @@ void perf_event_header__init_id(struct perf_event_header *header,
 				struct perf_event *event)
 {
 	if (event->attr.sample_id_all)
-		__perf_event_header__init_id(header, data, event);
+		__perf_event_header__init_id(header, data, event, event->attr.sample_type);
 }
 
 static void __perf_event__output_id_sample(struct perf_output_handle *handle,
@@ -7303,6 +7302,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			 struct pt_regs *regs)
 {
 	u64 sample_type = event->attr.sample_type;
+	u64 filtered_sample_type;
 
 	header->type = PERF_RECORD_SAMPLE;
 	header->size = sizeof(*header) + event->header_size;
@@ -7310,7 +7310,12 @@ void perf_prepare_sample(struct perf_event_header *header,
 	header->misc = 0;
 	header->misc |= perf_misc_flags(regs);
 
-	__perf_event_header__init_id(header, data, event);
+	/*
+	 * Clear the sample flags that have already been done by the
+	 * PMU driver.
+	 */
+	filtered_sample_type = sample_type & ~data->sample_flags;
+	__perf_event_header__init_id(header, data, event, filtered_sample_type);
 
 	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);
-- 
2.35.1

