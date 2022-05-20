Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D43352EE44
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350380AbiETOd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344652AbiETOdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:33:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB11F169E12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72D16B82BC3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C187C385A9;
        Fri, 20 May 2022 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653057193;
        bh=eeOLXSp/8TxjfZxuDVigi1nb9eyaXycXAZzcxGaw7m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oB6deMzOsaJ3AR+/BPDRv1PTZX0dtPydZwX+VYOkLLz5+azsX7drSqg4MupCFbUkO
         0eUHd6ibCz5Dn08few84GFxCOk6YQ4hOctPWqt4Z/4MC7v5q3jJelDPbOWkjXVW2Yk
         zrEbMnj5QQNsCYzwFlI7RtgvGfoSMllLtzn4DW85DIT4CoQf54M/AtRdWaTPDwjt2T
         teJjXzTCjocEBkqJE/CL6Gg/1Lcv4GCMK4aQa+hsDRy2M9A3OQFhW/7AtIJabCPrF+
         24eKDTUlIz39y+9a3Wv+cLAEUZ05h+w56GvWgv87tD6LDEpSXl74TtugRCB0VB0OZw
         zisZEFAO+2Swg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 3/5] habanalabs: remove hdev from hl_ctx_get args
Date:   Fri, 20 May 2022 17:33:02 +0300
Message-Id: <20220520143304.1906895-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520143304.1906895-1-ogabbay@kernel.org>
References: <20220520143304.1906895-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

This argument is unused by the function.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_buffer.c     |  2 +-
 drivers/misc/habanalabs/common/command_submission.c | 12 ++++++------
 drivers/misc/habanalabs/common/context.c            |  4 ++--
 drivers/misc/habanalabs/common/habanalabs.h         |  2 +-
 drivers/misc/habanalabs/common/memory.c             |  4 ++--
 drivers/misc/habanalabs/common/mmu/mmu.c            |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 1fac72c38c87..e13b2b39c058 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -283,7 +283,7 @@ static int hl_cb_mmap_mem_alloc(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *ar
 	cb->buf->mappable_size = cb->size;
 	cb->buf->private = cb;
 
-	hl_ctx_get(cb_args->hdev, cb->ctx);
+	hl_ctx_get(cb->ctx);
 
 	if (cb_args->map_cb) {
 		if (ctx_id == HL_KERNEL_ASID_ID) {
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 41206c5d6e7b..d8b6a2a4b210 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -805,7 +805,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	}
 
 	/* increment refcnt for context */
-	hl_ctx_get(hdev, ctx);
+	hl_ctx_get(ctx);
 
 	cs->ctx = ctx;
 	cs->submitted = false;
@@ -1830,7 +1830,7 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 
 	handle->count = count;
 
-	hl_ctx_get(hdev, hpriv->ctx);
+	hl_ctx_get(hpriv->ctx);
 	handle->ctx = hpriv->ctx;
 	mgr = &hpriv->ctx->sig_mgr;
 
@@ -2524,7 +2524,7 @@ static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	if (timestamp)
 		*timestamp = 0;
 
-	hl_ctx_get(hdev, ctx);
+	hl_ctx_get(ctx);
 
 	fence = hl_ctx_get_fence(ctx, seq);
 
@@ -2715,7 +2715,7 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	mcs_data.fence_arr = fence_arr;
 	mcs_data.arr_len = seq_arr_len;
 
-	hl_ctx_get(hdev, ctx);
+	hl_ctx_get(ctx);
 
 	/* wait (with timeout) for the first CS to be completed */
 	mcs_data.timeout_jiffies = hl_usecs64_to_jiffies(args->in.timeout_us);
@@ -2958,7 +2958,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	timeout = hl_usecs64_to_jiffies(timeout_us);
 
-	hl_ctx_get(hdev, ctx);
+	hl_ctx_get(ctx);
 
 	cq_cb = hl_cb_get(cb_mmg, cq_counters_handle);
 	if (!cq_cb) {
@@ -3107,7 +3107,7 @@ static int _hl_interrupt_wait_ioctl_user_addr(struct hl_device *hdev, struct hl_
 
 	timeout = hl_usecs64_to_jiffies(timeout_us);
 
-	hl_ctx_get(hdev, ctx);
+	hl_ctx_get(ctx);
 
 	pend = kzalloc(sizeof(*pend), GFP_KERNEL);
 	if (!pend) {
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index c6360e33bce8..ed2cfd0c6e99 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -262,7 +262,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 	return rc;
 }
 
-void hl_ctx_get(struct hl_device *hdev, struct hl_ctx *ctx)
+void hl_ctx_get(struct hl_ctx *ctx)
 {
 	kref_get(&ctx->refcount);
 }
@@ -284,7 +284,7 @@ struct hl_ctx *hl_get_compute_ctx(struct hl_device *hdev)
 		 * immediately once we find him
 		 */
 		ctx = hpriv->ctx;
-		hl_ctx_get(hdev, ctx);
+		hl_ctx_get(ctx);
 		break;
 	}
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 632037b29922..99cbed5ef0e6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3085,7 +3085,7 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv);
 void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx);
 int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx);
 void hl_ctx_do_release(struct kref *ref);
-void hl_ctx_get(struct hl_device *hdev,	struct hl_ctx *ctx);
+void hl_ctx_get(struct hl_ctx *ctx);
 int hl_ctx_put(struct hl_ctx *ctx);
 struct hl_ctx *hl_get_compute_ctx(struct hl_device *hdev);
 struct hl_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 087a55654a4d..663dd7e589d4 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1522,7 +1522,7 @@ int hl_hw_block_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 	vma->vm_ops = &hw_block_vm_ops;
 	vma->vm_private_data = lnode;
 
-	hl_ctx_get(hdev, ctx);
+	hl_ctx_get(ctx);
 
 	rc = hdev->asic_funcs->hw_block_mmap(hdev, vma, block_id, block_size);
 	if (rc) {
@@ -1832,7 +1832,7 @@ static int export_dmabuf_common(struct hl_ctx *ctx,
 	}
 
 	hl_dmabuf->ctx = ctx;
-	hl_ctx_get(hdev, hl_dmabuf->ctx);
+	hl_ctx_get(hl_dmabuf->ctx);
 
 	*dmabuf_fd = fd;
 
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index ae9b4923c32b..f3734718d94f 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -708,7 +708,7 @@ int hl_mmu_prefetch_cache_range(struct hl_ctx *ctx, u32 flags, u32 asid, u64 va,
 	 * as actual prefetch is done in a WQ we must get the context (and put it
 	 * at the end of the work function)
 	 */
-	hl_ctx_get(ctx->hdev, ctx);
+	hl_ctx_get(ctx);
 	queue_work(ctx->hdev->pf_wq, &handle_pf_work->pf_work);
 
 	return 0;
-- 
2.25.1

