Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEB6496DC8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiAVT6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiAVT6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD558C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:58:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CFC460EC6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A60C004E1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881480;
        bh=9KRxCq7hfWexZ4iTmqxltCzhJkE71ELLg8bzhDixBgI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UU8oNebY8eIY6+yx/O8kJ8iy1RaKLv9ul01WsfSRGi50k/9Rqm8XgJGRS4vP6MORY
         uZ6Ah77txLhKwDQpw4og0cn/SD+TyYep/8KQDBRbk+gnN4fxCma8GownoyqXuqlhXL
         k047FMM893slqGqc+XCCs5uP0FTtu6rB4sVYs7t5v6El2A8sTF7u/H9ugOTBDvp3Ip
         mgSdsqvuwvwSMoXKnMQ+lVcXbGCqUMK/zfVBEQID+KTeG311Q/MSf1lYiajsq8MmJD
         59aL1Cxn/BeHwjPanBX+qksr877YsQK38CwGOYXBgWz1oURyTq15J8JgwVjnjm5heU
         sbpWt85gNgpJA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 19/30] habanalabs: don't free phys_pg_pack inside lock
Date:   Sat, 22 Jan 2022 21:57:20 +0200
Message-Id: <20220122195731.934494-19-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freeing phys_pg_pack includes calling to scrubbing functions of the
device's memory, taking locks and possibly even calling reset.

This is not something that should be done while holding a device-wide
spinlock.

Therefore, save the relevant objects on a local linked-list and after
releasing the spinlock, traverse that list and free the phys_pg_pack
objects.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  3 +++
 drivers/misc/habanalabs/common/memory.c     | 16 +++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6c7a60210416..9c8374d88907 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1738,6 +1738,8 @@ struct hl_vm_hw_block_list_node {
  * @pages: the physical page array.
  * @npages: num physical pages in the pack.
  * @total_size: total size of all the pages in this list.
+ * @node: used to attach to deletion list that is used when all the allocations are cleared
+ *        at the teardown of the context.
  * @mapping_cnt: number of shared mappings.
  * @exporting_cnt: number of dma-buf exporting.
  * @asid: the context related to this list.
@@ -1753,6 +1755,7 @@ struct hl_vm_phys_pg_pack {
 	u64			*pages;
 	u64			npages;
 	u64			total_size;
+	struct list_head	node;
 	atomic_t		mapping_cnt;
 	u32			exporting_cnt;
 	u32			asid;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index c1eefaebacb6..4a5d3a179765 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2607,11 +2607,12 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
  */
 void hl_vm_ctx_fini(struct hl_ctx *ctx)
 {
-	struct hl_device *hdev = ctx->hdev;
-	struct hl_vm *vm = &hdev->vm;
 	struct hl_vm_phys_pg_pack *phys_pg_list;
+	struct hl_device *hdev = ctx->hdev;
 	struct hl_vm_hash_node *hnode;
+	struct hl_vm *vm = &hdev->vm;
 	struct hlist_node *tmp_node;
+	struct list_head free_list;
 	struct hl_mem_in args;
 	int i;
 
@@ -2644,19 +2645,24 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 
 	mutex_unlock(&ctx->mmu_lock);
 
+	INIT_LIST_HEAD(&free_list);
+
 	spin_lock(&vm->idr_lock);
 	idr_for_each_entry(&vm->phys_pg_pack_handles, phys_pg_list, i)
 		if (phys_pg_list->asid == ctx->asid) {
 			dev_dbg(hdev->dev,
 				"page list 0x%px of asid %d is still alive\n",
 				phys_pg_list, ctx->asid);
-			atomic64_sub(phys_pg_list->total_size,
-					&hdev->dram_used_mem);
-			free_phys_pg_pack(hdev, phys_pg_list);
+
+			atomic64_sub(phys_pg_list->total_size, &hdev->dram_used_mem);
 			idr_remove(&vm->phys_pg_pack_handles, i);
+			list_add(&phys_pg_list->node, &free_list);
 		}
 	spin_unlock(&vm->idr_lock);
 
+	list_for_each_entry(phys_pg_list, &free_list, node)
+		free_phys_pg_pack(hdev, phys_pg_list);
+
 	va_range_fini(hdev, ctx->va_range[HL_VA_RANGE_TYPE_DRAM]);
 	va_range_fini(hdev, ctx->va_range[HL_VA_RANGE_TYPE_HOST]);
 
-- 
2.25.1

