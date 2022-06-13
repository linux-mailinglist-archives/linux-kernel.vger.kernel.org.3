Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B75854844C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiFMKBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbiFMKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:01:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B15081D0F8;
        Mon, 13 Jun 2022 03:01:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51E57D6E;
        Mon, 13 Jun 2022 03:01:41 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.38.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6C013F66F;
        Mon, 13 Jun 2022 03:01:35 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/8] perf: Consolidate branch sample filter helpers
Date:   Mon, 13 Jun 2022 15:31:12 +0530
Message-Id: <20220613100119.684673-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613100119.684673-1-anshuman.khandual@arm.com>
References: <20220613100119.684673-1-anshuman.khandual@arm.com>
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
 include/linux/perf_event.h | 26 ++++++++++++++++++++++++++
 kernel/events/core.c       |  9 ++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index da759560eec5..afd288bc0b56 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1682,4 +1682,30 @@ static inline void perf_lopwr_cb(bool mode)
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
index 80782cddb1da..4ca35d634125 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6952,11 +6952,6 @@ static void perf_output_read(struct perf_output_handle *handle,
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
@@ -7045,7 +7040,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 			     * sizeof(struct perf_branch_entry);
 
 			perf_output_put(handle, data->br_stack->nr);
-			if (perf_sample_save_hw_index(event))
+			if (branch_sample_hw_index(event))
 				perf_output_put(handle, data->br_stack->hw_idx);
 			perf_output_copy(handle, data->br_stack->entries, size);
 		} else {
@@ -7339,7 +7334,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		int size = sizeof(u64); /* nr */
 		if (data->br_stack) {
-			if (perf_sample_save_hw_index(event))
+			if (branch_sample_hw_index(event))
 				size += sizeof(u64);
 
 			size += data->br_stack->nr
-- 
2.25.1

