Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD4E513C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351811AbiD1Uah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351786AbiD1Uad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E538BABBC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDFB361E3F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 20:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143A8C385B0;
        Thu, 28 Apr 2022 20:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651177637;
        bh=+xHEbce0/dCfpAWkZqR+HAGqCT/oo55OCM/lV7yf0yQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMIYHvOu2AUgVMluo9CdyrO/Hm/n6tX3gBn6kyIFFbZ5ymAXHYRl7gx1zU2X6kvWD
         OL+d1D4MPgXvXXCzJ4EmBmDjYxPdYZfpFzwZBDO9PF+vveAblwF5J5vf+FajAxAHSW
         wPdzYhFzivHYEpLxUoURJuWG2imMqqquXRqXshHyQQ4Ab0zc7vkfd/iKuy0s90vEDY
         ooXn+VkT7B0jRfdTJ1VFCBzx8TxB0bfdv70Sk0OwxNFAsj7tbl6zxszCcSNFfWPrz4
         SsBsY1yoof6F8j1IZrzLOYZgZTfMot0/b6A9KzlDGS5T/YFfe6iLElAEhplEdBqXIX
         pbaH8Mo1ca1NQ==
From:   kbusch@kernel.org
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     willy@infradead.org, kernel-team@fb.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] mm/dmapool: link blocks across pages
Date:   Thu, 28 Apr 2022 14:27:14 -0600
Message-Id: <20220428202714.17630-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20220428202714.17630-1-kbusch@kernel.org>
References: <20220428202714.17630-1-kbusch@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Once a page is allocated from a dma_pool, it is never released until the
pool is destroyed. That means it is safe to link free structures across
pages rather than only within them, and removes the need to scan the
'pages' list to find a gap in the cached pages.

This also allows all the blocks within a page to be allocated rather
than the last block being reserved, so it's more memory efficient.

A minor consequence of this is that the minimum sized structure is
changed from sizeof(int) to sizeof(void *), but I didn't find existing
users requesting that small of a size anyway.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 80 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index ac93f58d4654..34ec8d0e62ea 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -44,6 +44,7 @@
 struct dma_pool {		/* the pool */
 	struct xarray pages;
 	spinlock_t lock;
+	void *next_block;
 	size_t size;
 	struct device *dev;
 	size_t allocation;
@@ -56,7 +57,6 @@ struct dma_page {		/* cacheable header for 'allocation' bytes */
 	void *vaddr;
 	dma_addr_t dma;
 	unsigned int in_use;
-	unsigned int offset;
 };
 
 static DEFINE_MUTEX(pools_lock);
@@ -140,8 +140,8 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 
 	if (size == 0)
 		return NULL;
-	else if (size < 4)
-		size = 4;
+	else if (size < sizeof(void *))
+		size = sizeof(void *);
 
 	size = ALIGN(size, align);
 	allocation = max_t(size_t, size, PAGE_SIZE);
@@ -164,6 +164,7 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	retval->size = size;
 	retval->boundary = boundary;
 	retval->allocation = allocation;
+	retval->next_block = NULL;
 
 	INIT_LIST_HEAD(&retval->pools);
 
@@ -201,18 +202,25 @@ EXPORT_SYMBOL(dma_pool_create);
 
 static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 {
-	unsigned int offset = 0;
 	unsigned int next_boundary = pool->boundary;
+	unsigned int offset = pool->size;
+	void **v = page->vaddr;
+	void *next;
 
-	do {
-		unsigned int next = offset + pool->size;
-		if (unlikely((next + pool->size) >= next_boundary)) {
-			next = next_boundary;
+	while (offset < pool->allocation) {
+		if (offset + pool->size >= next_boundary) {
+			offset = next_boundary;
 			next_boundary += pool->boundary;
+			continue;
 		}
-		*(int *)(page->vaddr + offset) = next;
-		offset = next;
-	} while (offset < pool->allocation);
+
+		next = page->vaddr + offset;
+		*v = next;
+		v = next;
+
+		offset += pool->size;
+	}
+	*v = NULL;
 }
 
 static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
@@ -230,7 +238,6 @@ static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
 #endif
 		pool_initialise_page(pool, page);
 		page->in_use = 0;
-		page->offset = 0;
 	} else {
 		kfree(page);
 		page = NULL;
@@ -301,6 +308,11 @@ void dma_pool_destroy(struct dma_pool *pool)
 }
 EXPORT_SYMBOL(dma_pool_destroy);
 
+static struct dma_page *pool_find_page(struct dma_pool *pool, unsigned long vaddr)
+{
+	return xa_load(&pool->pages, vaddr & ~(pool->allocation - 1));
+}
+
 /**
  * dma_pool_alloc - get a block of consistent memory
  * @pool: dma pool that will produce the block
@@ -316,16 +328,16 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 {
 	unsigned long flags;
 	struct dma_page *page;
-	unsigned long i;
 	size_t offset;
 	void *retval;
 
 	might_alloc(mem_flags);
 
 	spin_lock_irqsave(&pool->lock, flags);
-	xa_for_each(&pool->pages, i, page) {
-		if (page->offset < pool->allocation)
-			goto ready;
+	retval = pool->next_block;
+	if (retval) {
+		page = pool_find_page(pool, (unsigned long)retval);
+		goto ready;
 	}
 
 	/* pool_alloc_page() might sleep, so temporarily drop &pool->lock */
@@ -335,21 +347,26 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	if (!page)
 		return NULL;
 
-	xa_store(&pool->pages, page->vaddr, page, mem_flags);
+	xa_store(&pool->pages, (unsigned long)page->vaddr, page,
+		 mem_flags);
+
 	spin_lock_irqsave(&pool->lock, flags);
+	*(void **)(page->vaddr + pool->allocation - pool->size) =
+						pool->next_block;
+	pool->next_block = page->vaddr;
+	retval = pool->next_block;
 
  ready:
 	page->in_use++;
-	offset = page->offset;
-	page->offset = *(int *)(page->vaddr + offset);
-	retval = offset + page->vaddr;
+	pool->next_block = *(void **)retval;
+	offset = retval - page->vaddr;
 	*handle = offset + page->dma;
 #ifdef	DMAPOOL_DEBUG
 	{
 		int i;
 		u8 *data = retval;
-		/* page->offset is stored in first 4 bytes */
-		for (i = sizeof(page->offset); i < pool->size; i++) {
+		/* next block link is stored in first pointer bytes */
+		for (i = sizeof(void *); i < pool->size; i++) {
 			if (data[i] == POOL_POISON_FREED)
 				continue;
 			if (pool->dev)
@@ -380,11 +397,6 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 }
 EXPORT_SYMBOL(dma_pool_alloc);
 
-static struct dma_page *pool_find_page(struct dma_pool *pool, unsigned long vaddr)
-{
-	return xa_load(pool->pages, vaddr & ~(pool->allocation - 1));
-}
-
 /**
  * dma_pool_free - put block back into dma pool
  * @pool: the dma pool holding the block
@@ -401,7 +413,7 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	unsigned int offset;
 
 	spin_lock_irqsave(&pool->lock, flags);
-	page = pool_find_page(pool, vaddr);
+	page = pool_find_page(pool, (unsigned long)vaddr);
 	if (!page) {
 		spin_unlock_irqrestore(&pool->lock, flags);
 		if (pool->dev)
@@ -428,10 +440,10 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 		return;
 	}
 	{
-		unsigned int chain = page->offset;
-		while (chain < pool->allocation) {
-			if (chain != offset) {
-				chain = *(int *)(page->vaddr + chain);
+		void *v = pool->next_block;
+		while (v) {
+			if (v != vaddr) {
+				v = *(void **)v;
 				continue;
 			}
 			spin_unlock_irqrestore(&pool->lock, flags);
@@ -448,8 +460,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 #endif
 
 	page->in_use--;
-	*(int *)vaddr = page->offset;
-	page->offset = offset;
+	*(void **)vaddr = pool->next_block;
+	pool->next_block = vaddr;
 	/*
 	 * Resist a temptation to do
 	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
-- 
2.30.2

