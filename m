Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2013B5AEEEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiIFPeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbiIFPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:33:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D98C9E0DA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA41CB81632
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC2CC433C1;
        Tue,  6 Sep 2022 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475405;
        bh=0KcpxynN6KpSaDZtgdz9uukK+IoW7jdItYPKJEBe53w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/gHS5KP94dkqdkDKcmJlWGnHPSIIEw1z6f7hl9KichHuicdRVdNlwM1xCbM8mdO3
         DQVuMHXdgWSF78REb36Hfgg5oAGcwVGoCd1QzWAmsageCRJHIeNYaFEODNQbu0Hqrm
         cye8bAwPTtvM3ZUyR6tpkKO7xBPFRqCsWA19NMUUhpU8SG/Wviqc+7C7s9fpWpA0Ou
         IuzfQsS1rdQ3fyV74aVPicd6RxCAz837Up2i/AR5wTSIuaWdP4kzusQNMZEGc06EA+
         Qbf+bdSgPJShmtEYPnAwTko8sTCPMedbvwBkrpy0XtRRoXvg1OG0Y/xnJ0DMTEfB8W
         40Gn1hygyb/+Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 2/9] habanalabs: fix possible hole in device va
Date:   Tue,  6 Sep 2022 17:43:11 +0300
Message-Id: <20220906144318.1890416-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906144318.1890416-1-ogabbay@kernel.org>
References: <20220906144318.1890416-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

cb_map_mem() uses gen_pool_alloc() to get virtual address for
mapping a CB.
The mapping is done in chunks of page size, so if the CB size is
larger, it is possible that the allocated virtual addresses won't
be consecutive.
User retrieves this device VA which returns the virtual address
in the first va_block. If there is a "hole" in the virtual addresses,
user can configure a HW block with a bad device VA.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   | 99 +++----------------
 drivers/misc/habanalabs/common/habanalabs.h   |  7 +-
 2 files changed, 20 insertions(+), 86 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index c3e2568542a1..d16de18863ba 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -18,11 +18,7 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct hl_vm_va_block *va_block, *tmp;
-	dma_addr_t bus_addr;
-	u64 virt_addr;
 	u32 page_size = prop->pmmu.page_size;
-	s32 offset;
 	int rc;
 
 	if (!hdev->supports_cb_mapping) {
@@ -37,106 +33,45 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 		return -EINVAL;
 	}
 
-	INIT_LIST_HEAD(&cb->va_block_list);
-
-	for (bus_addr = cb->bus_address;
-			bus_addr < cb->bus_address + cb->size;
-			bus_addr += page_size) {
-
-		virt_addr = (u64) gen_pool_alloc(ctx->cb_va_pool, page_size);
-		if (!virt_addr) {
-			dev_err(hdev->dev,
-				"Failed to allocate device virtual address for CB\n");
-			rc = -ENOMEM;
-			goto err_va_pool_free;
-		}
+	if (cb->is_mmu_mapped)
+		return 0;
 
-		va_block = kzalloc(sizeof(*va_block), GFP_KERNEL);
-		if (!va_block) {
-			rc = -ENOMEM;
-			gen_pool_free(ctx->cb_va_pool, virt_addr, page_size);
-			goto err_va_pool_free;
-		}
+	cb->roundup_size = roundup(cb->size, page_size);
 
-		va_block->start = virt_addr;
-		va_block->end = virt_addr + page_size - 1;
-		va_block->size = page_size;
-		list_add_tail(&va_block->node, &cb->va_block_list);
+	cb->virtual_addr = (u64) gen_pool_alloc(ctx->cb_va_pool, cb->roundup_size);
+	if (!cb->virtual_addr) {
+		dev_err(hdev->dev, "Failed to allocate device virtual address for CB\n");
+		return -ENOMEM;
 	}
 
 	mutex_lock(&ctx->mmu_lock);
-
-	bus_addr = cb->bus_address;
-	offset = 0;
-	list_for_each_entry(va_block, &cb->va_block_list, node) {
-		rc = hl_mmu_map_page(ctx, va_block->start, bus_addr,
-				va_block->size, list_is_last(&va_block->node,
-							&cb->va_block_list));
-		if (rc) {
-			dev_err(hdev->dev, "Failed to map VA %#llx to CB\n",
-				va_block->start);
-			goto err_va_umap;
-		}
-
-		bus_addr += va_block->size;
-		offset += va_block->size;
+	rc = hl_mmu_map_contiguous(ctx, cb->virtual_addr, cb->bus_address, cb->roundup_size);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to map VA %#llx to CB\n", cb->virtual_addr);
+		goto err_va_umap;
 	}
-
 	rc = hl_mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR | MMU_OP_SKIP_LOW_CACHE_INV);
-
 	mutex_unlock(&ctx->mmu_lock);
 
 	cb->is_mmu_mapped = true;
-
 	return rc;
 
 err_va_umap:
-	list_for_each_entry(va_block, &cb->va_block_list, node) {
-		if (offset <= 0)
-			break;
-		hl_mmu_unmap_page(ctx, va_block->start, va_block->size,
-				offset <= va_block->size);
-		offset -= va_block->size;
-	}
-
-	rc = hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
-
 	mutex_unlock(&ctx->mmu_lock);
-
-err_va_pool_free:
-	list_for_each_entry_safe(va_block, tmp, &cb->va_block_list, node) {
-		gen_pool_free(ctx->cb_va_pool, va_block->start, va_block->size);
-		list_del(&va_block->node);
-		kfree(va_block);
-	}
-
+	gen_pool_free(ctx->cb_va_pool, cb->virtual_addr, cb->roundup_size);
 	return rc;
 }
 
 static void cb_unmap_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 {
 	struct hl_device *hdev = ctx->hdev;
-	struct hl_vm_va_block *va_block, *tmp;
 
 	mutex_lock(&ctx->mmu_lock);
-
-	list_for_each_entry(va_block, &cb->va_block_list, node)
-		if (hl_mmu_unmap_page(ctx, va_block->start, va_block->size,
-				list_is_last(&va_block->node,
-						&cb->va_block_list)))
-			dev_warn_ratelimited(hdev->dev,
-					"Failed to unmap CB's va 0x%llx\n",
-					va_block->start);
-
+	hl_mmu_unmap_contiguous(ctx, cb->virtual_addr, cb->roundup_size);
 	hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
-
 	mutex_unlock(&ctx->mmu_lock);
 
-	list_for_each_entry_safe(va_block, tmp, &cb->va_block_list, node) {
-		gen_pool_free(ctx->cb_va_pool, va_block->start, va_block->size);
-		list_del(&va_block->node);
-		kfree(va_block);
-	}
+	gen_pool_free(ctx->cb_va_pool, cb->virtual_addr, cb->roundup_size);
 }
 
 static void cb_fini(struct hl_device *hdev, struct hl_cb *cb)
@@ -378,7 +313,6 @@ int hl_cb_destroy(struct hl_mem_mgr *mmg, u64 cb_handle)
 static int hl_cb_info(struct hl_mem_mgr *mmg,
 			u64 handle, u32 flags, u32 *usage_cnt, u64 *device_va)
 {
-	struct hl_vm_va_block *va_block;
 	struct hl_cb *cb;
 	int rc = 0;
 
@@ -390,9 +324,8 @@ static int hl_cb_info(struct hl_mem_mgr *mmg,
 	}
 
 	if (flags & HL_CB_FLAGS_GET_DEVICE_VA) {
-		va_block = list_first_entry(&cb->va_block_list, struct hl_vm_va_block, node);
-		if (va_block) {
-			*device_va = va_block->start;
+		if (cb->is_mmu_mapped) {
+			*device_va = cb->virtual_addr;
 		} else {
 			dev_err(mmg->dev, "CB is not mapped to the device's MMU\n");
 			rc = -EINVAL;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 01426e1306ee..5083c5098941 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -917,11 +917,11 @@ struct hl_mmap_mem_buf {
  * @buf: back pointer to the parent mappable memory buffer
  * @debugfs_list: node in debugfs list of command buffers.
  * @pool_list: node in pool list of command buffers.
- * @va_block_list: list of virtual addresses blocks of the CB if it is mapped to
- *                 the device's MMU.
  * @kernel_address: Holds the CB's kernel virtual address.
+ * @virtual_addr: Holds the CB's virtual address.
  * @bus_address: Holds the CB's DMA address.
  * @size: holds the CB's size.
+ * @roundup_size: holds the cb size after roundup to page size.
  * @cs_cnt: holds number of CS that this CB participates in.
  * @is_pool: true if CB was acquired from the pool, false otherwise.
  * @is_internal: internally allocated
@@ -933,10 +933,11 @@ struct hl_cb {
 	struct hl_mmap_mem_buf	*buf;
 	struct list_head	debugfs_list;
 	struct list_head	pool_list;
-	struct list_head	va_block_list;
 	void			*kernel_address;
+	u64			virtual_addr;
 	dma_addr_t		bus_address;
 	u32			size;
+	u32			roundup_size;
 	atomic_t		cs_cnt;
 	u8			is_pool;
 	u8			is_internal;
-- 
2.25.1

