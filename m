Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF46852EE43
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350370AbiETOdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350359AbiETOdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:33:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6CB9D4C4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07944B82BC0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B489FC34113;
        Fri, 20 May 2022 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653057191;
        bh=xacMC4zW1CHWhGp06IjYaxkVYCoQxe1rKlvuYx9jfUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6Le8B6g/BG3YQRz3hx668i/W203xmlaVKpoefKvhDcmlTRVp+0B9Jyqmg4LWgJ41
         jBqEGHxmd1KMtAoD33KJoHLW37mVRnQdsGBtPVrvAxLf+1wJ87J8sRTelWMvJxDsR5
         /kfI0gM7emVdpiX79QnYcszX0v61y1EyUpJQpO/undAXvSl7pYLsYQUNcQhiJQ3K5y
         bRA2lwfbFv6K7pq/3iNYXqCD8WiqjisK+jMflh4qNnyeCIT+vCpWObgJxg2gPzJNdS
         6/iPmkZjHb/3LyuMz4VX3+wXz6DHywDioysk6xBstihOv8aXJ984m1pXA1FgPFDC+V
         uT71qLZyh5ENw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/5] habanalabs: do MMU prefetch as deferred work
Date:   Fri, 20 May 2022 17:33:01 +0300
Message-Id: <20220520143304.1906895-2-ogabbay@kernel.org>
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

When user requests to prefetch the MMU translations, the driver will
not block the user until prefetch is done.
Instead, the prefetch work will be delegated to a WQ which will do it
in the background.
This way, the prefetch may progress without blocking the user at all.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 15 ++++++-
 drivers/misc/habanalabs/common/habanalabs.h | 27 +++++++++--
 drivers/misc/habanalabs/common/memory.c     | 31 ++++++++-----
 drivers/misc/habanalabs/common/mmu/mmu.c    | 50 ++++++++++++++++++---
 drivers/misc/habanalabs/gaudi/gaudi.c       |  8 +---
 drivers/misc/habanalabs/goya/goya.c         |  8 +---
 6 files changed, 103 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 0908ac301c70..b4f14c6d3970 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -612,11 +612,18 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_eq_wq;
 	}
 
+	hdev->pf_wq = alloc_workqueue("hl-prefetch", WQ_UNBOUND, 0);
+	if (!hdev->pf_wq) {
+		dev_err(hdev->dev, "Failed to allocate MMU prefetch workqueue\n");
+		rc = -ENOMEM;
+		goto free_ts_free_wq;
+	}
+
 	hdev->hl_chip_info = kzalloc(sizeof(struct hwmon_chip_info),
 					GFP_KERNEL);
 	if (!hdev->hl_chip_info) {
 		rc = -ENOMEM;
-		goto free_ts_free_wq;
+		goto free_pf_wq;
 	}
 
 	rc = hl_mmu_if_set_funcs(hdev);
@@ -655,6 +662,8 @@ static int device_early_init(struct hl_device *hdev)
 	hl_mem_mgr_fini(&hdev->kernel_mem_mgr);
 free_chip_info:
 	kfree(hdev->hl_chip_info);
+free_pf_wq:
+	destroy_workqueue(hdev->pf_wq);
 free_ts_free_wq:
 	destroy_workqueue(hdev->ts_free_obj_wq);
 free_eq_wq:
@@ -695,6 +704,7 @@ static void device_early_fini(struct hl_device *hdev)
 
 	kfree(hdev->hl_chip_info);
 
+	destroy_workqueue(hdev->pf_wq);
 	destroy_workqueue(hdev->ts_free_obj_wq);
 	destroy_workqueue(hdev->eq_wq);
 	destroy_workqueue(hdev->device_reset_work.wq);
@@ -891,6 +901,9 @@ static void cleanup_resources(struct hl_device *hdev, bool hard_reset, bool fw_r
 	/* Go over all the queues, release all CS and their jobs */
 	hl_cs_rollback_all(hdev, skip_wq_flush);
 
+	/* flush the MMU prefetch workqueue */
+	flush_workqueue(hdev->pf_wq);
+
 	/* Release all pending user interrupts, each pending user interrupt
 	 * holds a reference to user context
 	 */
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 8977ec67dba7..632037b29922 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1402,8 +1402,7 @@ struct hl_asic_funcs {
 					u32 flags);
 	int (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
 				u32 flags, u32 asid, u64 va, u64 size);
-	int (*mmu_prefetch_cache_range)(struct hl_device *hdev, u32 flags, u32 asid, u64 va,
-				u64 size);
+	int (*mmu_prefetch_cache_range)(struct hl_ctx *ctx, u32 flags, u32 asid, u64 va, u64 size);
 	int (*send_heartbeat)(struct hl_device *hdev);
 	int (*debug_coresight)(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
 	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask_arr,
@@ -2476,6 +2475,24 @@ struct hl_mmu_funcs {
 };
 
 /**
+ * struct hl_prefetch_work - prefetch work structure handler
+ * @pf_work: actual work struct.
+ * @ctx: compute context.
+ * @va: virtual address to pre-fetch.
+ * @size: pre-fetch size.
+ * @flags: operation flags.
+ * @asid: ASID for maintenance operation.
+ */
+struct hl_prefetch_work {
+	struct work_struct	pf_work;
+	struct hl_ctx		*ctx;
+	u64			va;
+	u64			size;
+	u32			flags;
+	u32			asid;
+};
+
+/*
  * number of user contexts allowed to call wait_for_multi_cs ioctl in
  * parallel
  */
@@ -2648,6 +2665,7 @@ struct hl_reset_info {
  *         context.
  * @eq_wq: work queue of event queue for executing work in process context.
  * @ts_free_obj_wq: work queue for timestamp registration objects release.
+ * @pf_wq: work queue for MMU pre-fetch operations.
  * @kernel_ctx: Kernel driver context structure.
  * @kernel_queues: array of hl_hw_queue.
  * @cs_mirror_list: CS mirror list for TDR.
@@ -2760,6 +2778,7 @@ struct hl_reset_info {
  * @supports_wait_for_multi_cs: true if wait for multi CS is supported
  * @is_compute_ctx_active: Whether there is an active compute context executing.
  * @compute_ctx_in_release: true if the current compute context is being released.
+ * @supports_mmu_prefetch: true if prefetch is supported, otherwise false.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2781,6 +2800,7 @@ struct hl_device {
 	struct workqueue_struct		**cq_wq;
 	struct workqueue_struct		*eq_wq;
 	struct workqueue_struct		*ts_free_obj_wq;
+	struct workqueue_struct		*pf_wq;
 	struct hl_ctx			*kernel_ctx;
 	struct hl_hw_queue		*kernel_queues;
 	struct list_head		cs_mirror_list;
@@ -2882,6 +2902,7 @@ struct hl_device {
 	u8				stream_master_qid_arr_size;
 	u8				is_compute_ctx_active;
 	u8				compute_ctx_in_release;
+	u8				supports_mmu_prefetch;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
@@ -3163,7 +3184,7 @@ int hl_mmu_unmap_contiguous(struct hl_ctx *ctx, u64 virt_addr, u32 size);
 int hl_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard, u32 flags);
 int hl_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
 					u32 flags, u32 asid, u64 va, u64 size);
-int hl_mmu_prefetch_cache_range(struct hl_device *hdev, u32 flags, u32 asid, u64 va, u64 size);
+int hl_mmu_prefetch_cache_range(struct hl_ctx *ctx, u32 flags, u32 asid, u64 va, u64 size);
 u64 hl_mmu_get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte);
 u64 hl_mmu_get_hop_pte_phys_addr(struct hl_ctx *ctx, struct hl_mmu_properties *mmu_prop,
 					u8 hop_idx, u64 hop_addr, u64 virt_addr);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index ecf3c094242a..087a55654a4d 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1102,21 +1102,24 @@ static int get_paddr_from_handle(struct hl_ctx *ctx, struct hl_mem_in *args,
  *   map a device virtual block to this pages and return the start address of
  *   this block.
  */
-static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
-		u64 *device_addr)
+static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device_addr)
 {
-	struct hl_device *hdev = ctx->hdev;
-	struct hl_vm *vm = &hdev->vm;
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
+	enum hl_va_range_type va_range_type = 0;
+	struct hl_device *hdev = ctx->hdev;
 	struct hl_userptr *userptr = NULL;
+	u32 handle = 0, va_block_align;
 	struct hl_vm_hash_node *hnode;
+	struct hl_vm *vm = &hdev->vm;
 	struct hl_va_range *va_range;
-	enum vm_type *vm_type;
+	bool is_userptr, do_prefetch;
 	u64 ret_vaddr, hint_addr;
-	u32 handle = 0, va_block_align;
+	enum vm_type *vm_type;
 	int rc;
-	bool is_userptr = args->flags & HL_MEM_USERPTR;
-	enum hl_va_range_type va_range_type = 0;
+
+	/* set map flags */
+	is_userptr = args->flags & HL_MEM_USERPTR;
+	do_prefetch = hdev->supports_mmu_prefetch && (args->flags & HL_MEM_PREFETCH);
 
 	/* Assume failure */
 	*device_addr = 0;
@@ -1250,15 +1253,19 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	if (rc)
 		goto map_err;
 
-	if (args->flags & HL_MEM_PREFETCH) {
-		rc = hl_mmu_prefetch_cache_range(hdev, *vm_type, ctx->asid, ret_vaddr,
+	mutex_unlock(&ctx->mmu_lock);
+
+	/*
+	 * prefetch is done upon user's request. it is performed in WQ as and so can
+	 * be outside the MMU lock. the operation itself is already protected by the mmu lock
+	 */
+	if (do_prefetch) {
+		rc = hl_mmu_prefetch_cache_range(ctx, *vm_type, ctx->asid, ret_vaddr,
 							phys_pg_pack->total_size);
 		if (rc)
 			goto map_err;
 	}
 
-	mutex_unlock(&ctx->mmu_lock);
-
 	ret_vaddr += phys_pg_pack->offset;
 
 	hnode->ptr = vm_type;
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 04e53af4c67f..ae9b4923c32b 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -665,15 +665,53 @@ int hl_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
 	return rc;
 }
 
-int hl_mmu_prefetch_cache_range(struct hl_device *hdev, u32 flags, u32 asid, u64 va, u64 size)
+static void hl_mmu_prefetch_work_function(struct work_struct *work)
 {
-	int rc;
+	struct hl_prefetch_work *pfw = container_of(work, struct hl_prefetch_work, pf_work);
+	struct hl_ctx *ctx = pfw->ctx;
 
-	rc = hdev->asic_funcs->mmu_prefetch_cache_range(hdev, flags, asid, va, size);
-	if (rc)
-		dev_err_ratelimited(hdev->dev, "MMU cache range prefetch failed\n");
+	if (!hl_device_operational(ctx->hdev, NULL))
+		goto put_ctx;
 
-	return rc;
+	mutex_lock(&ctx->mmu_lock);
+
+	ctx->hdev->asic_funcs->mmu_prefetch_cache_range(ctx, pfw->flags, pfw->asid,
+								pfw->va, pfw->size);
+
+	mutex_unlock(&ctx->mmu_lock);
+
+put_ctx:
+	/*
+	 * context was taken in the common mmu prefetch function- see comment there about
+	 * context handling.
+	 */
+	hl_ctx_put(ctx);
+	kfree(pfw);
+}
+
+int hl_mmu_prefetch_cache_range(struct hl_ctx *ctx, u32 flags, u32 asid, u64 va, u64 size)
+{
+	struct hl_prefetch_work *handle_pf_work;
+
+	handle_pf_work = kmalloc(sizeof(*handle_pf_work), GFP_KERNEL);
+	if (!handle_pf_work)
+		return -ENOMEM;
+
+	INIT_WORK(&handle_pf_work->pf_work, hl_mmu_prefetch_work_function);
+	handle_pf_work->ctx = ctx;
+	handle_pf_work->va = va;
+	handle_pf_work->size = size;
+	handle_pf_work->flags = flags;
+	handle_pf_work->asid = asid;
+
+	/*
+	 * as actual prefetch is done in a WQ we must get the context (and put it
+	 * at the end of the work function)
+	 */
+	hl_ctx_get(ctx->hdev, ctx);
+	queue_work(ctx->hdev->pf_wq, &handle_pf_work->pf_work);
+
+	return 0;
 }
 
 u64 hl_mmu_get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte)
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1c388537de33..96a83317b302 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9174,12 +9174,6 @@ static void gaudi_get_valid_dram_page_orders(struct hl_info_dev_memalloc_page_si
 	info->page_order_bitmask = 0;
 }
 
-static int gaudi_mmu_prefetch_cache_range(struct hl_device *hdev, u32 flags, u32 asid, u64 va,
-						u64 size)
-{
-	return 0;
-}
-
 static ssize_t infineon_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
@@ -9244,7 +9238,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.write_pte = gaudi_write_pte,
 	.mmu_invalidate_cache = gaudi_mmu_invalidate_cache,
 	.mmu_invalidate_cache_range = gaudi_mmu_invalidate_cache_range,
-	.mmu_prefetch_cache_range = gaudi_mmu_prefetch_cache_range,
+	.mmu_prefetch_cache_range = NULL,
 	.send_heartbeat = gaudi_send_heartbeat,
 	.debug_coresight = gaudi_debug_coresight,
 	.is_device_idle = gaudi_is_device_idle,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index f2d4362f6a46..4cde505a7416 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5428,12 +5428,6 @@ static int goya_get_monitor_dump(struct hl_device *hdev, void *data)
 	return -EOPNOTSUPP;
 }
 
-static int goya_mmu_prefetch_cache_range(struct hl_device *hdev, u32 flags, u32 asid, u64 va,
-					u64 size)
-{
-	return 0;
-}
-
 static int goya_scrub_device_dram(struct hl_device *hdev, u64 val)
 {
 	return -EOPNOTSUPP;
@@ -5480,7 +5474,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.write_pte = goya_write_pte,
 	.mmu_invalidate_cache = goya_mmu_invalidate_cache,
 	.mmu_invalidate_cache_range = goya_mmu_invalidate_cache_range,
-	.mmu_prefetch_cache_range = goya_mmu_prefetch_cache_range,
+	.mmu_prefetch_cache_range = NULL,
 	.send_heartbeat = goya_send_heartbeat,
 	.debug_coresight = goya_debug_coresight,
 	.is_device_idle = goya_is_device_idle,
-- 
2.25.1

