Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E643F468BF9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhLEPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:47:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37914 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbhLEPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:46:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 489E9B80DBE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5498AC341C4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638718969;
        bh=8x6l6PPka3c2gu9DylALckCsWDtMlJi0+nSbCUIM02I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m4sg7C8lpjDawQFNXxcCnc1lR2/xcuMEgu7XmL5sestsmejf65qhih42NV+lILvBG
         RFNlFAnWtWoJT5a6fIoz5iETcHYNkajawkbXtbcYOWPbFk6r2K6QcGkENCoF9qqG62
         +hgYobVfHAM4+FJrIgdC0BPWiCDu5DvWlL7UHvI+E8kSUtMtBn0uD5jAG2tWX2cOzN
         XYrpl7SpZTz45NbPjSXf6DK6GnKsRd9roq7dkIlDIjlI52QgsrDC5X1jDKqcOkITSA
         xhWYDKDE8Re49VYwi1rvASexGuRs2gQ4TSCsG58R1uJPGLXILk48rgfNqwPU5SWndv
         rsxXNv6h/RgVA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] habanalabs: add helper to get compute context
Date:   Sun,  5 Dec 2021 17:42:34 +0200
Message-Id: <20211205154236.2198481-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205154236.2198481-1-ogabbay@kernel.org>
References: <20211205154236.2198481-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple places where the code needs to get the context's
pointer and increment its ref cnt. This is the proper way instead
of using the compute context pointer in the device structure.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c    | 23 +++++++++++++++++++++
 drivers/misc/habanalabs/common/debugfs.c    | 14 ++++++-------
 drivers/misc/habanalabs/common/device.c     | 13 ++++++------
 drivers/misc/habanalabs/common/habanalabs.h |  1 +
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 8de1217b2ed2..b2884107fa15 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -272,6 +272,29 @@ int hl_ctx_put(struct hl_ctx *ctx)
 	return kref_put(&ctx->refcount, hl_ctx_do_release);
 }
 
+struct hl_ctx *hl_get_compute_ctx(struct hl_device *hdev)
+{
+	struct hl_ctx *ctx = NULL;
+	struct hl_fpriv *hpriv;
+
+	mutex_lock(&hdev->fpriv_list_lock);
+
+	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node) {
+		/* There can only be a single user which has opened the compute device, so exit
+		 * immediately once we find him
+		 */
+		if (!hpriv->is_control) {
+			ctx = hpriv->ctx;
+			hl_ctx_get(hdev, ctx);
+			break;
+		}
+	}
+
+	mutex_unlock(&hdev->fpriv_list_lock);
+
+	return ctx;
+}
+
 /*
  * hl_ctx_get_fence_locked - get CS fence under CS lock
  *
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 9727d82b121f..2e9c31d79d5e 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -327,11 +327,7 @@ static int vm_show(struct seq_file *s, void *data)
 
 	spin_unlock(&dev_entry->ctx_mem_hash_spinlock);
 
-	mutex_lock(&dev_entry->hdev->fpriv_list_lock);
-	ctx = dev_entry->hdev->compute_ctx;
-	if (ctx)
-		hl_ctx_get(dev_entry->hdev, ctx);
-	mutex_unlock(&dev_entry->hdev->fpriv_list_lock);
+	ctx = hl_get_compute_ctx(dev_entry->hdev);
 	if (ctx) {
 		seq_puts(s, "\nVA ranges:\n\n");
 		for (i = HL_VA_RANGE_TYPE_HOST ; i < HL_VA_RANGE_TYPE_MAX ; ++i) {
@@ -443,7 +439,7 @@ static int mmu_show(struct seq_file *s, void *data)
 	if (dev_entry->mmu_asid == HL_KERNEL_ASID_ID)
 		ctx = hdev->kernel_ctx;
 	else
-		ctx = hdev->compute_ctx;
+		ctx = hl_get_compute_ctx(hdev);
 
 	if (!ctx) {
 		dev_err(hdev->dev, "no ctx available\n");
@@ -596,7 +592,7 @@ static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr, u32 size,
 			u64 *phys_addr)
 {
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
-	struct hl_ctx *ctx = hdev->compute_ctx;
+	struct hl_ctx *ctx;
 	struct hl_vm_hash_node *hnode;
 	u64 end_address, range_size;
 	struct hl_userptr *userptr;
@@ -604,6 +600,8 @@ static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr, u32 size,
 	bool valid = false;
 	int i, rc = 0;
 
+	ctx = hl_get_compute_ctx(hdev);
+
 	if (!ctx) {
 		dev_err(hdev->dev, "no ctx available\n");
 		return -EINVAL;
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index bc5736ae6b70..407f6c5020c7 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -961,6 +961,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false,
 								reset_upon_device_release = false;
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
+	struct hl_ctx *ctx;
 	int i, rc;
 
 	if (!hdev->init_done) {
@@ -1101,16 +1102,14 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		hl_cq_reset(hdev, &hdev->completion_queue[i]);
 
-	mutex_lock(&hdev->fpriv_list_lock);
-
 	/* Make sure the context switch phase will run again */
-	if (hdev->compute_ctx) {
-		atomic_set(&hdev->compute_ctx->thread_ctx_switch_token, 1);
-		hdev->compute_ctx->thread_ctx_switch_wait_token = 0;
+	ctx = hl_get_compute_ctx(hdev);
+	if (ctx) {
+		atomic_set(&ctx->thread_ctx_switch_token, 1);
+		ctx->thread_ctx_switch_wait_token = 0;
+		hl_ctx_put(ctx);
 	}
 
-	mutex_unlock(&hdev->fpriv_list_lock);
-
 	/* Finished tear-down, starting to re-initialize */
 
 	if (hard_reset) {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 670fad9b4ca0..eec96e506bb0 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2906,6 +2906,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx);
 void hl_ctx_do_release(struct kref *ref);
 void hl_ctx_get(struct hl_device *hdev,	struct hl_ctx *ctx);
 int hl_ctx_put(struct hl_ctx *ctx);
+struct hl_ctx *hl_get_compute_ctx(struct hl_device *hdev);
 struct hl_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
 int hl_ctx_get_fences(struct hl_ctx *ctx, u64 *seq_arr,
 				struct hl_fence **fence, u32 arr_len);
-- 
2.25.1

