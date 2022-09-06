Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8809E5AE360
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiIFIry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiIFIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:47:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7C20E1D;
        Tue,  6 Sep 2022 01:44:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B00A5139F;
        Tue,  6 Sep 2022 01:44:28 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F3763F73D;
        Tue,  6 Sep 2022 01:44:19 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] perf: Consolidate branch sample filter helpers
Date:   Tue,  6 Sep 2022 14:14:14 +0530
Message-Id: <20220906084414.396220-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides the branch type filtering requests, 'event.attr.branch_sample_type'
also contains various flags indicating which additional information should
be captured, along with the base branch record. These flags help configure
the underlying hardware, and capture the branch records appropriately when
required e.g after PMU interrupt. But first, this moves an existing helper
perf_sample_save_hw_index() into the header before adding some more helpers
for other branch sample filter flags.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Hello Peter,

Could you please consider taking this patch along with others on the perf
ABI series. This patch has been part of the original BRBE driver series,
which will have one less patch to include going forward. Thank you.

- Anshuman

This applies on v6.0-rc4 but after applying the following patch series

https://lore.kernel.org/all/20220824044822.70230-1-anshuman.khandual@arm.com/

 include/linux/perf_event.h | 26 ++++++++++++++++++++++++++
 kernel/events/core.c       |  9 ++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ee8b9ecdc03b..236375938eeb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1684,4 +1684,30 @@ static inline void perf_lopwr_cb(bool mode)
 }
 #endif
 
+#ifdef CONFIG_PERF_EVENTS
+static inline bool branch_sample_no_flags(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_NO_FLAGS;
+}
+
+static inline bool branch_sample_no_cycles(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_NO_CYCLES;
+}
+
+static inline bool branch_sample_type(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_TYPE_SAVE;
+}
+
+static inline bool branch_sample_hw_index(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
+}
+
+static inline bool branch_sample_priv(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
+}
+#endif /* CONFIG_PERF_EVENTS */
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..ff62d357a27b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6967,11 +6967,6 @@ static void perf_output_read(struct perf_output_handle *handle,
 		perf_output_read_one(handle, event, enabled, running);
 }
 
-static inline bool perf_sample_save_hw_index(struct perf_event *event)
-{
-	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
-}
-
 void perf_output_sample(struct perf_output_handle *handle,
 			struct perf_event_header *header,
 			struct perf_sample_data *data,
@@ -7060,7 +7055,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 			     * sizeof(struct perf_branch_entry);
 
 			perf_output_put(handle, data->br_stack->nr);
-			if (perf_sample_save_hw_index(event))
+			if (branch_sample_hw_index(event))
 				perf_output_put(handle, data->br_stack->hw_idx);
 			perf_output_copy(handle, data->br_stack->entries, size);
 		} else {
@@ -7354,7 +7349,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		int size = sizeof(u64); /* nr */
 		if (data->br_stack) {
-			if (perf_sample_save_hw_index(event))
+			if (branch_sample_hw_index(event))
 				size += sizeof(u64);
 
 			size += data->br_stack->nr
-- 
2.25.1

