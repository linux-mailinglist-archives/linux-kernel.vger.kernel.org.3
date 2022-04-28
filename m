Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD0513C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351800AbiD1Uaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351778AbiD1Uad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E388FB3DD0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8105D61EA6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 20:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CA5C385AE;
        Thu, 28 Apr 2022 20:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651177636;
        bh=XcOgdobXiRnviEnEO6IcybAikHz//gyRwvBdGJCP8FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAuH7zyYe5bigw7Qa8RfZWPDemFG33Ks2B5R68YgVZO1Agee3rUABaQiXncs9O1gF
         BC9u5rhdPLsWwBfMQtCDg5z1r1zdqc/NaFoXZ7L88lZmv+Th+UWIk4L2pVoPa7nTFF
         ajNe5jkZVSgAN7wwCj4bMyexrfrXBLdPrNEZVnzCiTI3XfB7oL9Y1qSuM/Y9OTACw6
         10vDHg7PCWyvxlhhaWMWzr0NylIE4FYNCZz5tLTWW+1I5G+jYDpVdNfGtklSa8xlmc
         4x0xpNQtoi+VImEBKM0ePI2A7y8TZLdA4HEISwAXZOzI18WfD1e/yTc/G5LTCza6qd
         fTReaxOlDkkkw==
From:   kbusch@kernel.org
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     willy@infradead.org, kernel-team@fb.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] mm/dmapool: replace linked list with xarray
Date:   Thu, 28 Apr 2022 14:27:13 -0600
Message-Id: <20220428202714.17630-2-kbusch@kernel.org>
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

Store the cached dma pool pages in an xarray instead of a linked list.
This allows constant lookup time to free the page, lockless iteration
while displaying the attributes, and frees up space in 'struct dma_page'.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index a7eb5d0eb2da..ac93f58d4654 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -35,13 +35,14 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/xarray.h>
 
 #if defined(CONFIG_DEBUG_SLAB) || defined(CONFIG_SLUB_DEBUG_ON)
 #define DMAPOOL_DEBUG 1
 #endif
 
 struct dma_pool {		/* the pool */
-	struct list_head page_list;
+	struct xarray pages;
 	spinlock_t lock;
 	size_t size;
 	struct device *dev;
@@ -52,7 +53,6 @@ struct dma_pool {		/* the pool */
 };
 
 struct dma_page {		/* cacheable header for 'allocation' bytes */
-	struct list_head page_list;
 	void *vaddr;
 	dma_addr_t dma;
 	unsigned int in_use;
@@ -81,13 +81,12 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
 	list_for_each_entry(pool, &dev->dma_pools, pools) {
 		unsigned pages = 0;
 		unsigned blocks = 0;
+		unsigned long i;
 
-		spin_lock_irq(&pool->lock);
-		list_for_each_entry(page, &pool->page_list, page_list) {
+		xa_for_each(&pool->pages, i, page) {
 			pages++;
 			blocks += page->in_use;
 		}
-		spin_unlock_irq(&pool->lock);
 
 		/* per-pool info, no real statistics yet */
 		temp = scnprintf(next, size, "%-16s %4u %4zu %4zu %2u\n",
@@ -160,7 +159,7 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 
 	retval->dev = dev;
 
-	INIT_LIST_HEAD(&retval->page_list);
+	xa_init(&retval->pages);
 	spin_lock_init(&retval->lock);
 	retval->size = size;
 	retval->boundary = boundary;
@@ -252,7 +251,6 @@ static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
 	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
 #endif
 	dma_free_coherent(pool->dev, pool->allocation, page->vaddr, dma);
-	list_del(&page->page_list);
 	kfree(page);
 }
 
@@ -266,8 +264,9 @@ static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
  */
 void dma_pool_destroy(struct dma_pool *pool)
 {
-	struct dma_page *page, *tmp;
+	struct dma_page *page;
 	bool empty = false;
+	unsigned long i;
 
 	if (unlikely(!pool))
 		return;
@@ -282,7 +281,8 @@ void dma_pool_destroy(struct dma_pool *pool)
 		device_remove_file(pool->dev, &dev_attr_pools);
 	mutex_unlock(&pools_reg_lock);
 
-	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
+	xa_for_each(&pool->pages, i, page) {
+		xa_erase(&pool->pages, i);
 		if (is_page_busy(page)) {
 			if (pool->dev)
 				dev_err(pool->dev, "%s %s, %p busy\n", __func__,
@@ -291,12 +291,12 @@ void dma_pool_destroy(struct dma_pool *pool)
 				pr_err("%s %s, %p busy\n", __func__,
 				       pool->name, page->vaddr);
 			/* leak the still-in-use consistent memory */
-			list_del(&page->page_list);
 			kfree(page);
 		} else
 			pool_free_page(pool, page);
 	}
 
+	xa_destroy(&pool->pages);
 	kfree(pool);
 }
 EXPORT_SYMBOL(dma_pool_destroy);
@@ -316,13 +316,14 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 {
 	unsigned long flags;
 	struct dma_page *page;
+	unsigned long i;
 	size_t offset;
 	void *retval;
 
 	might_alloc(mem_flags);
 
 	spin_lock_irqsave(&pool->lock, flags);
-	list_for_each_entry(page, &pool->page_list, page_list) {
+	xa_for_each(&pool->pages, i, page) {
 		if (page->offset < pool->allocation)
 			goto ready;
 	}
@@ -334,9 +335,9 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	if (!page)
 		return NULL;
 
+	xa_store(&pool->pages, page->vaddr, page, mem_flags);
 	spin_lock_irqsave(&pool->lock, flags);
 
-	list_add(&page->page_list, &pool->page_list);
  ready:
 	page->in_use++;
 	offset = page->offset;
@@ -379,17 +380,9 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 }
 EXPORT_SYMBOL(dma_pool_alloc);
 
-static struct dma_page *pool_find_page(struct dma_pool *pool, dma_addr_t dma)
+static struct dma_page *pool_find_page(struct dma_pool *pool, unsigned long vaddr)
 {
-	struct dma_page *page;
-
-	list_for_each_entry(page, &pool->page_list, page_list) {
-		if (dma < page->dma)
-			continue;
-		if ((dma - page->dma) < pool->allocation)
-			return page;
-	}
-	return NULL;
+	return xa_load(pool->pages, vaddr & ~(pool->allocation - 1));
 }
 
 /**
@@ -408,7 +401,7 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	unsigned int offset;
 
 	spin_lock_irqsave(&pool->lock, flags);
-	page = pool_find_page(pool, dma);
+	page = pool_find_page(pool, vaddr);
 	if (!page) {
 		spin_unlock_irqrestore(&pool->lock, flags);
 		if (pool->dev)
-- 
2.30.2

