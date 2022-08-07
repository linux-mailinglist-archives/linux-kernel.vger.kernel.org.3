Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA41358BB1D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiHGNzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiHGNzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:55:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA36964E2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E5CCB80B8B
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0E9C433C1;
        Sun,  7 Aug 2022 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659880503;
        bh=7oqD+ZDyKh+XtRGLaJuW241YJQVQEz06z2qtrk3OaVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHm1e0kcrGl3vVhcS8SrOg0nDdHW9eN9byboRV5gWIzA1L+qrSxtp9F+0Qg4bYqSi
         VeIzsPJc8AeQdrk0duQaXghTogITqVkGZaGN5MQhPPVDWHzY1SlVCVTKzuMMmos3Iq
         AxO5uBxOX9NMWQrJZqcMV2+iK9JGliiV8oDbXjqeQDSnAdnmXWTYwCt+SsRmWN3GTt
         PKWDrMiUtcXUSeO6plGlQnTD8jXNPToKu+ekiVyr82lxQY7fnB77B96HARehh6Ky8c
         wyc4s47U/EzkaeIUKU6TOwgH3jo07a7CIxSUx/PqwN3hUhAyUd8F/x3NRTpaYflFEq
         V5tMVnNB/YGIA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 5/6] habanalabs: fix H/W block handling for partial unmappings
Date:   Sun,  7 Aug 2022 16:54:51 +0300
Message-Id: <20220807135452.1219894-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220807135452.1219894-1-ogabbay@kernel.org>
References: <20220807135452.1219894-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Several munmap() calls can be done or a mapped H/W block that has a
larger size than a page size.
Releasing the object should be done only when all mapped range is
unmapped.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 14 ++++++++------
 drivers/misc/habanalabs/common/habanalabs.h |  6 ++++--
 drivers/misc/habanalabs/common/memory.c     | 10 +++++++++-
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 69fd3ed7680a..48d3ec8b5c82 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -291,14 +291,16 @@ static int vm_show(struct seq_file *s, void *data)
 		if (ctx->asid != HL_KERNEL_ASID_ID &&
 		    !list_empty(&ctx->hw_block_mem_list)) {
 			seq_puts(s, "\nhw_block mappings:\n\n");
-			seq_puts(s, "    virtual address    size    HW block id\n");
-			seq_puts(s, "-------------------------------------------\n");
+			seq_puts(s,
+				"    virtual address    block size    mapped size    HW block id\n");
+			seq_puts(s,
+				"---------------------------------------------------------------\n");
 			mutex_lock(&ctx->hw_block_list_lock);
-			list_for_each_entry(lnode, &ctx->hw_block_mem_list,
-					    node) {
+			list_for_each_entry(lnode, &ctx->hw_block_mem_list, node) {
 				seq_printf(s,
-					"    0x%-14lx   %-6u      %-9u\n",
-					lnode->vaddr, lnode->size, lnode->id);
+					"    0x%-14lx   %-6u        %-6u             %-9u\n",
+					lnode->vaddr, lnode->block_size, lnode->mapped_size,
+					lnode->id);
 			}
 			mutex_unlock(&ctx->hw_block_list_lock);
 		}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index f495a4b82f73..237a887b3a43 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2063,14 +2063,16 @@ struct hl_vm_hash_node {
  * @node: node to hang on the list in context object.
  * @ctx: the context this node belongs to.
  * @vaddr: virtual address of the HW block.
- * @size: size of the block.
+ * @block_size: size of the block.
+ * @mapped_size: size of the block which is mapped. May change if partial un-mappings are done.
  * @id: HW block id (handle).
  */
 struct hl_vm_hw_block_list_node {
 	struct list_head	node;
 	struct hl_ctx		*ctx;
 	unsigned long		vaddr;
-	u32			size;
+	u32			block_size;
+	u32			mapped_size;
 	u32			id;
 };
 
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index a027fa88889b..5bc704da889d 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1442,6 +1442,13 @@ static void hw_block_vm_close(struct vm_area_struct *vma)
 	struct hl_vm_hw_block_list_node *lnode =
 		(struct hl_vm_hw_block_list_node *) vma->vm_private_data;
 	struct hl_ctx *ctx = lnode->ctx;
+	long new_mmap_size;
+
+	new_mmap_size = lnode->mapped_size - (vma->vm_end - vma->vm_start);
+	if (new_mmap_size > 0) {
+		lnode->mapped_size = new_mmap_size;
+		return;
+	}
 
 	mutex_lock(&ctx->hw_block_list_lock);
 	list_del(&lnode->node);
@@ -1502,7 +1509,8 @@ int hl_hw_block_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 
 	lnode->ctx = ctx;
 	lnode->vaddr = vma->vm_start;
-	lnode->size = block_size;
+	lnode->block_size = block_size;
+	lnode->mapped_size = lnode->block_size;
 	lnode->id = block_id;
 
 	vma->vm_private_data = lnode;
-- 
2.25.1

