Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73009498505
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbiAXQkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:40:41 -0500
Received: from foss.arm.com ([217.140.110.172]:40058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243793AbiAXQkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:40:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E2C5101E;
        Mon, 24 Jan 2022 08:40:24 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6981B3F793;
        Mon, 24 Jan 2022 08:40:23 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, konrad@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tientzu@chromium.org, guozhengkui@vivo.com
Subject: [PATCH 1/3] swiotlb: Simplify debugfs setup
Date:   Mon, 24 Jan 2022 16:40:17 +0000
Message-Id: <278f7915ed3ad8768c6cad671ce8f1a3d4ec085c.1643028164.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1643028164.git.robin.murphy@arm.com>
References: <cover.1643028164.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugfs functions are already stubbed out for !CONFIG_DEBUG_FS, so we
can remove most of the #ifdefs, just keeping one to manually optimise
away the initcall when it would do nothing. We can also simplify the
code itself by factoring out the directory creation and realising that
the global io_tlb_default_mem now makes debugfs_dir redundant.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/swiotlb.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..bdce89e053bd 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,9 +36,7 @@
 #include <linux/scatterlist.h>
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
-#ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
-#endif
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 #include <linux/io.h>
 #include <linux/of.h>
@@ -758,47 +756,29 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
-#ifdef CONFIG_DEBUG_FS
-static struct dentry *debugfs_dir;
-
-static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
+static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
+					 const char *dirname)
 {
+	mem->debugfs = debugfs_create_dir(dirname, io_tlb_default_mem.debugfs);
+	if (!mem->nslabs)
+		return;
+
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
 }
 
-static int __init swiotlb_create_default_debugfs(void)
+static int __init __maybe_unused swiotlb_create_default_debugfs(void)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-
-	debugfs_dir = debugfs_create_dir("swiotlb", NULL);
-	if (mem->nslabs) {
-		mem->debugfs = debugfs_dir;
-		swiotlb_create_debugfs_files(mem);
-	}
+	swiotlb_create_debugfs_files(&io_tlb_default_mem, "swiotlb");
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
 late_initcall(swiotlb_create_default_debugfs);
-
 #endif
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 
-#ifdef CONFIG_DEBUG_FS
-static void rmem_swiotlb_debugfs_init(struct reserved_mem *rmem)
-{
-	struct io_tlb_mem *mem = rmem->priv;
-
-	mem->debugfs = debugfs_create_dir(rmem->name, debugfs_dir);
-	swiotlb_create_debugfs_files(mem);
-}
-#else
-static void rmem_swiotlb_debugfs_init(struct reserved_mem *rmem)
-{
-}
-#endif
-
 struct page *swiotlb_alloc(struct device *dev, size_t size)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
@@ -860,7 +840,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 		rmem->priv = mem;
 
-		rmem_swiotlb_debugfs_init(rmem);
+		swiotlb_create_debugfs_files(mem, rmem->name);
 	}
 
 	dev->dma_io_tlb_mem = mem;
-- 
2.28.0.dirty

