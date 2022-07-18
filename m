Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CADC577AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiGRG2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiGRG2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:28:36 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1245615A3C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:28:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VJdbkNA_1658125690;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VJdbkNA_1658125690)
          by smtp.aliyun-inc.com;
          Mon, 18 Jul 2022 14:28:30 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/dmapool.c: avoid duplicate memset within dma_pool_alloc
Date:   Mon, 18 Jul 2022 14:28:10 +0800
Message-Id: <1658125690-76930-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

In "dma_alloc_from_dev_coherent" and "dma_direct_alloc",
the allocated memory is explicitly set to 0.

A helper function "use_dev_coherent_memory" is introduced here to
determine whether the memory is allocated by "dma_alloc_from_dev_coherent".

And use "get_dma_ops" to determine whether the memory is allocated by
"dma_direct_alloc".

After this modification, memory allocated using "dma_pool_zalloc" can avoid
duplicate memset.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 include/linux/dma-map-ops.h | 5 +++++
 mm/dmapool.c                | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d5b06b..c29948d 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -171,6 +171,10 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, size_t size, int *ret);
+static inline bool use_dev_coherent_memory(struct device *dev)
+{
+	return dev->dma_mem ? true : false;
+}
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
@@ -180,6 +184,7 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
+#define use_dev_coherent_memory(dev) (0)
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
diff --git a/mm/dmapool.c b/mm/dmapool.c
index a7eb5d0..6e03530 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -21,6 +21,7 @@
 
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dmapool.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -372,7 +373,9 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 #endif
 	spin_unlock_irqrestore(&pool->lock, flags);
 
-	if (want_init_on_alloc(mem_flags))
+	if (want_init_on_alloc(mem_flags) &&
+		!use_dev_coherent_memory(pool->dev) &&
+		get_dma_ops(pool->dev))
 		memset(retval, 0, pool->size);
 
 	return retval;
-- 
1.8.3.1

