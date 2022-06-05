Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB5353DB44
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351028AbiFEKd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351000AbiFEKde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:33:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402C20F42
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 03:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64944B80B83
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A533C3411D;
        Sun,  5 Jun 2022 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654425210;
        bh=43pfI2fNX/XgWaeoltvFW8Xa5vnSwG3DklBikTc57BE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzpOpu58PgtpvF1il+3NLB+nAI2st8KBxlcQJAxZYfRxwD+GYRaezDMb2kGgqcQkc
         Of/DhQsAw2jETux98lWRMm6wRH1G3oXCfxD+K9hTdbwrWxBRNvB8A4CrACRAZ/RbYM
         b8iI9o2CtXhsvXKJIzfOM8xdyvo+1sBKYg+ZrcBal21Xd5BailZ3b07CktfDt45/bz
         Fo92lnMvP4x1vu5EHxZ58mWaUyXf1tr7szrD0dbjS/EFxb5Eu09MjE45PdTy5CBvW4
         KxB7zieX/Ri+TpyEpcq3uIUcEGU2NzF7tQatTFPqDbKBnBD9SarbE1Hnjg1/RFF+6C
         ftA0cBg6fRpww==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 7/7] habanalabs: fix race between hl_get_compute_ctx() and hl_ctx_put()
Date:   Sun,  5 Jun 2022 13:33:16 +0300
Message-Id: <20220605103316.3414541-7-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

hl_get_compute_ctx() is used to get the pointer to the compute context
from the hpriv object.
The function is called in code paths that are not necessarily initiated
by user, so it is possible that a context release process will happen in
parallel.
This can lead to a race condition in which hl_get_compute_ctx()
retrieves the context pointer, and just before it increments the context
refcount, the context object is released and a freed memory is accessed.

To avoid this race, add a mutex to protect the context pointer in hpriv.
With this lock, hl_get_compute_ctx() will be able to detect if the
context has been released or is about to be released.

struct hl_ctx_mgr has a mutex for contexts IDR with a similar "ctx_lock"
name, so rename it to just "lock" to avoid a confusion with the new
lock.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c      | 58 ++++++++++++-------
 drivers/misc/habanalabs/common/device.c       |  1 +
 drivers/misc/habanalabs/common/habanalabs.h   | 11 ++--
 .../misc/habanalabs/common/habanalabs_drv.c   |  2 +
 4 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 6d033aecc8fc..64ac65d9268b 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -125,15 +125,22 @@ void hl_ctx_do_release(struct kref *ref)
 
 	hl_ctx_fini(ctx);
 
-	if (ctx->hpriv)
-		hl_hpriv_put(ctx->hpriv);
+	if (ctx->hpriv) {
+		struct hl_fpriv *hpriv = ctx->hpriv;
+
+		mutex_lock(&hpriv->ctx_lock);
+		hpriv->ctx = NULL;
+		mutex_unlock(&hpriv->ctx_lock);
+
+		hl_hpriv_put(hpriv);
+	}
 
 	kfree(ctx);
 }
 
 int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 {
-	struct hl_ctx_mgr *mgr = &hpriv->ctx_mgr;
+	struct hl_ctx_mgr *ctx_mgr = &hpriv->ctx_mgr;
 	struct hl_ctx *ctx;
 	int rc;
 
@@ -143,9 +150,9 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 		goto out_err;
 	}
 
-	mutex_lock(&mgr->ctx_lock);
-	rc = idr_alloc(&mgr->ctx_handles, ctx, 1, 0, GFP_KERNEL);
-	mutex_unlock(&mgr->ctx_lock);
+	mutex_lock(&ctx_mgr->lock);
+	rc = idr_alloc(&ctx_mgr->handles, ctx, 1, 0, GFP_KERNEL);
+	mutex_unlock(&ctx_mgr->lock);
 
 	if (rc < 0) {
 		dev_err(hdev->dev, "Failed to allocate IDR for a new CTX\n");
@@ -170,9 +177,9 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 	return 0;
 
 remove_from_idr:
-	mutex_lock(&mgr->ctx_lock);
-	idr_remove(&mgr->ctx_handles, ctx->handle);
-	mutex_unlock(&mgr->ctx_lock);
+	mutex_lock(&ctx_mgr->lock);
+	idr_remove(&ctx_mgr->handles, ctx->handle);
+	mutex_unlock(&ctx_mgr->lock);
 free_ctx:
 	kfree(ctx);
 out_err:
@@ -269,6 +276,11 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 	return rc;
 }
 
+static int hl_ctx_get_unless_zero(struct hl_ctx *ctx)
+{
+	return kref_get_unless_zero(&ctx->refcount);
+}
+
 void hl_ctx_get(struct hl_ctx *ctx)
 {
 	kref_get(&ctx->refcount);
@@ -287,11 +299,15 @@ struct hl_ctx *hl_get_compute_ctx(struct hl_device *hdev)
 	mutex_lock(&hdev->fpriv_list_lock);
 
 	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node) {
+		mutex_lock(&hpriv->ctx_lock);
+		ctx = hpriv->ctx;
+		if (ctx && !hl_ctx_get_unless_zero(ctx))
+			ctx = NULL;
+		mutex_unlock(&hpriv->ctx_lock);
+
 		/* There can only be a single user which has opened the compute device, so exit
-		 * immediately once we find him
+		 * immediately once we find its context or if we see that it has been released
 		 */
-		ctx = hpriv->ctx;
-		hl_ctx_get(ctx);
 		break;
 	}
 
@@ -383,37 +399,37 @@ int hl_ctx_get_fences(struct hl_ctx *ctx, u64 *seq_arr,
 /*
  * hl_ctx_mgr_init - initialize the context manager
  *
- * @mgr: pointer to context manager structure
+ * @ctx_mgr: pointer to context manager structure
  *
  * This manager is an object inside the hpriv object of the user process.
  * The function is called when a user process opens the FD.
  */
-void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr)
+void hl_ctx_mgr_init(struct hl_ctx_mgr *ctx_mgr)
 {
-	mutex_init(&mgr->ctx_lock);
-	idr_init(&mgr->ctx_handles);
+	mutex_init(&ctx_mgr->lock);
+	idr_init(&ctx_mgr->handles);
 }
 
 /*
  * hl_ctx_mgr_fini - finalize the context manager
  *
  * @hdev: pointer to device structure
- * @mgr: pointer to context manager structure
+ * @ctx_mgr: pointer to context manager structure
  *
  * This function goes over all the contexts in the manager and frees them.
  * It is called when a process closes the FD.
  */
-void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr)
+void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *ctx_mgr)
 {
 	struct hl_ctx *ctx;
 	struct idr *idp;
 	u32 id;
 
-	idp = &mgr->ctx_handles;
+	idp = &ctx_mgr->handles;
 
 	idr_for_each_entry(idp, ctx, id)
 		kref_put(&ctx->refcount, hl_ctx_do_release);
 
-	idr_destroy(&mgr->ctx_handles);
-	mutex_destroy(&mgr->ctx_lock);
+	idr_destroy(&ctx_mgr->handles);
+	mutex_destroy(&ctx_mgr->lock);
 }
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index b4f14c6d3970..38e1ad432e51 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -245,6 +245,7 @@ static void hpriv_release(struct kref *ref)
 
 	hl_debugfs_remove_file(hpriv);
 
+	mutex_destroy(&hpriv->ctx_lock);
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
 	if ((!hdev->pldm) && (hdev->pdev) &&
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 3023ecfc19c9..1ab64e8a05c6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1638,12 +1638,12 @@ struct hl_ctx {
 
 /**
  * struct hl_ctx_mgr - for handling multiple contexts.
- * @ctx_lock: protects ctx_handles.
- * @ctx_handles: idr to hold all ctx handles.
+ * @lock: protects ctx_handles.
+ * @handles: idr to hold all ctx handles.
  */
 struct hl_ctx_mgr {
-	struct mutex		ctx_lock;
-	struct idr		ctx_handles;
+	struct mutex	lock;
+	struct idr	handles;
 };
 
 
@@ -1998,6 +1998,8 @@ struct hl_notifier_event {
  * @dev_node: node in the device list of file private data
  * @refcount: number of related contexts.
  * @restore_phase_mutex: lock for context switch and restore phase.
+ * @ctx_lock: protects the pointer to current executing context pointer. TODO: remove for multiple
+ *            ctx per process.
  */
 struct hl_fpriv {
 	struct hl_device		*hdev;
@@ -2011,6 +2013,7 @@ struct hl_fpriv {
 	struct list_head		dev_node;
 	struct kref			refcount;
 	struct mutex			restore_phase_mutex;
+	struct mutex			ctx_lock;
 };
 
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index e182637c2d93..e617cc394ff7 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -137,6 +137,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	mutex_init(&hpriv->notifier_event.lock);
 	mutex_init(&hpriv->restore_phase_mutex);
+	mutex_init(&hpriv->ctx_lock);
 	kref_init(&hpriv->refcount);
 	nonseekable_open(inode, filp);
 
@@ -209,6 +210,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	hl_mem_mgr_fini(&hpriv->mem_mgr);
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 	filp->private_data = NULL;
+	mutex_destroy(&hpriv->ctx_lock);
 	mutex_destroy(&hpriv->restore_phase_mutex);
 	mutex_destroy(&hpriv->notifier_event.lock);
 	put_pid(hpriv->taskpid);
-- 
2.25.1

