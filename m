Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD453DB45
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351054AbiFEKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348259AbiFEKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:33:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F1920BFE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 03:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61BC660EFE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DAEC3411C;
        Sun,  5 Jun 2022 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654425208;
        bh=gUF0BvUbkpuae9WJ80GO/5Sy6X5SQaf38gV0CMUM2Lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCLMvJTIYTwtjDRKhIRHOZGrDsXI1xKQFaZ6N1+FV5WbVK1Nj4t/UlQNqRPrPfD8q
         HdoFbkEZvvMivcQ9QomGBD0WziZOR4pa6NUowdpPasSnD0JpXNYn6UGEoAk6AxWKOW
         esAJbGC8hunHpCQZqbi2/luYC2fu7erEdknhTN0qIsN2nw+3yqxiuHRjX1YMuSh1d8
         lJ09yxgArAhgA1b453pBYZ/xEz3FN4oG93rUlPparQl4VszxDW9UlSM/BLOBlCsrRl
         Gw8rL3MXCsQIDjH0Gt8IVkfjYoBEj0LmN5sSpGy5VaV+kbj8W3Z9GWRBvstASrZze6
         PiKTpr0vGHcGA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 6/7] habanalabs: keep a record of completed CS outcomes
Date:   Sun,  5 Jun 2022 13:33:15 +0300
Message-Id: <20220605103316.3414541-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220605103316.3414541-1-ogabbay@kernel.org>
References: <20220605103316.3414541-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

Often, the user is not interested in the completion timestamp of all
command submissions.
A common situation is, for example, when the user submits a burst of,
possibly, several thousands of commands, then request the completion
timestamp of only couple of specific key commands from all the burst.
The problem is that currently, the outcome of the early commands may be
lost, due to a large amount of later commands, that the user does not
really care about.

This patch creates a separate store with the outcomes of commands the
user has mark explicitly as interested in. This store does not mix the
marked commands with the unmarked ones, hence the data there will
survive for much longer.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 113 ++++++++++++++++--
 drivers/misc/habanalabs/common/context.c      |   9 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  37 ++++++
 3 files changed, 147 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 22109be06139..47b49cbf67ab 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -34,6 +34,84 @@ static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				enum hl_cs_wait_status *status, s64 *timestamp);
 static void cs_do_release(struct kref *ref);
 
+static void hl_push_cs_outcome(struct hl_device *hdev,
+			       struct hl_cs_outcome_store *outcome_store,
+			       u64 seq, ktime_t ts, int error)
+{
+	struct hl_cs_outcome *node;
+	unsigned long flags;
+
+	/*
+	 * CS outcome store supports the following operations:
+	 * push outcome - store a recent CS outcome in the store
+	 * pop outcome - retrieve a SPECIFIC (by seq) CS outcome from the store
+	 * It uses 2 lists: used list and free list.
+	 * It has a pre-allocated amount of nodes, each node stores
+	 * a single CS outcome.
+	 * Initially, all the nodes are in the free list.
+	 * On push outcome, a node (any) is taken from the free list, its
+	 * information is filled in, and the node is moved to the used list.
+	 * It is possible, that there are no nodes left in the free list.
+	 * In this case, we will lose some information about old outcomes. We
+	 * will pop the OLDEST node from the used list, and make it free.
+	 * On pop, the node is searched for in the used list (using a search
+	 * index).
+	 * If found, the node is then removed from the used list, and moved
+	 * back to the free list. The outcome data that the node contained is
+	 * returned back to the user.
+	 */
+
+	spin_lock_irqsave(&outcome_store->db_lock, flags);
+
+	if (list_empty(&outcome_store->free_list)) {
+		node = list_last_entry(&outcome_store->used_list,
+				       struct hl_cs_outcome, list_link);
+		hash_del(&node->map_link);
+		dev_dbg(hdev->dev, "CS %llu outcome was lost\n", node->seq);
+	} else {
+		node = list_last_entry(&outcome_store->free_list,
+				       struct hl_cs_outcome, list_link);
+	}
+
+	list_del_init(&node->list_link);
+
+	node->seq = seq;
+	node->ts = ts;
+	node->error = error;
+
+	list_add(&node->list_link, &outcome_store->used_list);
+	hash_add(outcome_store->outcome_map, &node->map_link, node->seq);
+
+	spin_unlock_irqrestore(&outcome_store->db_lock, flags);
+}
+
+static bool hl_pop_cs_outcome(struct hl_cs_outcome_store *outcome_store,
+			       u64 seq, ktime_t *ts, int *error)
+{
+	struct hl_cs_outcome *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&outcome_store->db_lock, flags);
+
+	hash_for_each_possible(outcome_store->outcome_map, node, map_link, seq)
+		if (node->seq == seq) {
+			*ts = node->ts;
+			*error = node->error;
+
+			hash_del(&node->map_link);
+			list_del_init(&node->list_link);
+			list_add(&node->list_link, &outcome_store->free_list);
+
+			spin_unlock_irqrestore(&outcome_store->db_lock, flags);
+
+			return true;
+		}
+
+	spin_unlock_irqrestore(&outcome_store->db_lock, flags);
+
+	return false;
+}
+
 static void hl_sob_reset(struct kref *ref)
 {
 	struct hl_hw_sob *hw_sob = container_of(ref, struct hl_hw_sob,
@@ -678,7 +756,6 @@ static void cs_do_release(struct kref *ref)
 	 */
 	hl_debugfs_remove_cs(cs);
 
-	hl_ctx_put(cs->ctx);
 
 	/* We need to mark an error for not submitted because in that case
 	 * the hl fence release flow is different. Mainly, we don't need
@@ -698,8 +775,14 @@ static void cs_do_release(struct kref *ref)
 			div_u64(jiffies - cs->submission_time_jiffies, HZ));
 	}
 
-	if (cs->timestamp)
+	if (cs->timestamp) {
 		cs->fence->timestamp = ktime_get();
+		hl_push_cs_outcome(hdev, &cs->ctx->outcome_store, cs->sequence,
+				   cs->fence->timestamp, cs->fence->error);
+	}
+
+	hl_ctx_put(cs->ctx);
+
 	complete_all(&cs->fence->completion);
 	complete_multi_cs(hdev, cs);
 
@@ -2325,8 +2408,9 @@ static int hl_wait_for_fence(struct hl_ctx *ctx, u64 seq, struct hl_fence *fence
 				s64 *timestamp)
 {
 	struct hl_device *hdev = ctx->hdev;
+	ktime_t timestamp_kt;
 	long completion_rc;
-	int rc = 0;
+	int rc = 0, error;
 
 	if (IS_ERR(fence)) {
 		rc = PTR_ERR(fence);
@@ -2338,12 +2422,17 @@ static int hl_wait_for_fence(struct hl_ctx *ctx, u64 seq, struct hl_fence *fence
 	}
 
 	if (!fence) {
-		dev_dbg(hdev->dev,
+		if (!hl_pop_cs_outcome(&ctx->outcome_store, seq, &timestamp_kt, &error)) {
+			dev_dbg(hdev->dev,
 			"Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
 				seq, ctx->cs_sequence);
 
-		*status = CS_WAIT_STATUS_GONE;
-		return 0;
+			*status = CS_WAIT_STATUS_GONE;
+			return 0;
+		}
+
+		completion_rc = 1;
+		goto report_results;
 	}
 
 	if (!timeout_us) {
@@ -2358,18 +2447,20 @@ static int hl_wait_for_fence(struct hl_ctx *ctx, u64 seq, struct hl_fence *fence
 				&fence->completion, timeout);
 	}
 
+	error = fence->error;
+	timestamp_kt = fence->timestamp;
+
+report_results:
 	if (completion_rc > 0) {
 		*status = CS_WAIT_STATUS_COMPLETED;
 		if (timestamp)
-			*timestamp = ktime_to_ns(fence->timestamp);
+			*timestamp = ktime_to_ns(timestamp_kt);
 	} else {
 		*status = CS_WAIT_STATUS_BUSY;
 	}
 
-	if (fence->error == -ETIMEDOUT)
-		rc = -ETIMEDOUT;
-	else if (fence->error == -EIO)
-		rc = -EIO;
+	if (error == -ETIMEDOUT || error == -EIO)
+		rc = error;
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index ed2cfd0c6e99..6d033aecc8fc 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -181,7 +181,7 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 
 int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 {
-	int rc = 0;
+	int rc = 0, i;
 
 	ctx->hdev = hdev;
 
@@ -197,6 +197,13 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 	if (!ctx->cs_pending)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&ctx->outcome_store.used_list);
+	INIT_LIST_HEAD(&ctx->outcome_store.free_list);
+	hash_init(ctx->outcome_store.outcome_map);
+	for (i = 0; i < ARRAY_SIZE(ctx->outcome_store.nodes_pool); ++i)
+		list_add(&ctx->outcome_store.nodes_pool[i].list_link,
+			 &ctx->outcome_store.free_list);
+
 	hl_hw_block_mem_init(ctx);
 
 	if (is_kernel_ctx) {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 7a46f36518fe..3023ecfc19c9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1535,6 +1535,40 @@ struct hl_dmabuf_priv {
 	uint64_t			device_address;
 };
 
+#define HL_CS_OUTCOME_HISTORY_LEN 256
+
+/**
+ * struct hl_cs_outcome - represents a single completed CS outcome
+ * @list_link: link to either container's used list or free list
+ * @map_link: list to the container hash map
+ * @ts: completion ts
+ * @seq: the original cs sequence
+ * @error: error code cs completed with, if any
+ */
+struct hl_cs_outcome {
+	struct list_head list_link;
+	struct hlist_node map_link;
+	ktime_t ts;
+	u64 seq;
+	int error;
+};
+
+/**
+ * struct hl_cs_outcome_store - represents a limited store of completed CS outcomes
+ * @outcome_map: index of completed CS searcheable by sequence number
+ * @used_list: list of outcome objects currently in use
+ * @free_list: list of outcome objects currently not in use
+ * @nodes_pool: a static pool of preallocated outcome objects
+ * @db_lock: any operation on the store must take this lock
+ */
+struct hl_cs_outcome_store {
+	DECLARE_HASHTABLE(outcome_map, 8);
+	struct list_head used_list;
+	struct list_head free_list;
+	struct hl_cs_outcome nodes_pool[HL_CS_OUTCOME_HISTORY_LEN];
+	spinlock_t db_lock;
+};
+
 /**
  * struct hl_ctx - user/kernel context.
  * @mem_hash: holds mapping from virtual address to virtual memory area
@@ -1545,6 +1579,8 @@ struct hl_dmabuf_priv {
  * @refcount: reference counter for the context. Context is released only when
  *		this hits 0l. It is incremented on CS and CS_WAIT.
  * @cs_pending: array of hl fence objects representing pending CS.
+ * @outcome_store: storage data structure used to remember ouitcomes of completed
+ *                 command submissions for a long time after CS id wraparound.
  * @va_range: holds available virtual addresses for host and dram mappings.
  * @mem_hash_lock: protects the mem_hash.
  * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifying the
@@ -1580,6 +1616,7 @@ struct hl_ctx {
 	struct hl_device		*hdev;
 	struct kref			refcount;
 	struct hl_fence			**cs_pending;
+	struct hl_cs_outcome_store	outcome_store;
 	struct hl_va_range		*va_range[HL_VA_RANGE_TYPE_MAX];
 	struct mutex			mem_hash_lock;
 	struct mutex			mmu_lock;
-- 
2.25.1

