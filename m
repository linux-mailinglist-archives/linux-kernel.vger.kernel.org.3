Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884B9541BC9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384205AbiFGVyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379078AbiFGVCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:02:01 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E711CB68
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:46:25 -0700 (PDT)
X-ASG-Debug-ID: 1654627583-1cf43917f3396720001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id OBWPxyFZLrQFHE0J; Tue, 07 Jun 2022 14:46:23 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=vcQ5hy/KPkqucbXNbQAJCyvSrO4lyJAHF32hpadfWSw=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=FibAY+bNXDPJpThVea4/
        cKatgfJ/9zkZVzgmJpUaNWz4GlH3d1tP684DpenycawhOTl2oXD9dhnIwNmsEm1uhbqoud6Yi7oNt
        VP+IFIP5LnFsThvuOOC5tFSnFAO0UGzS6gbIQCs6YkRXa4wDmtwWjguWZhXVGIhkw5eOeUBHVQ=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11859479; Tue, 07 Jun 2022 14:46:23 -0400
Message-ID: <6a4fb3c3-e627-6266-7c49-322253abefb9@cybernetics.com>
Date:   Tue, 7 Jun 2022 14:46:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 10/11] dmapool: improve scalability of dma_pool_alloc
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 10/11] dmapool: improve scalability of dma_pool_alloc
From:   Tony Battersby <tonyb@cybernetics.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tony Lindgren <tony@atomide.com>
References: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
In-Reply-To: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654627583
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 3491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_pool_alloc() scales poorly when allocating a large number of pages
because it does a linear scan of all previously-allocated pages before
allocating a new one.  Improve its scalability by maintaining a separate
list of pages that have free blocks ready to (re)allocate.  In big O
notation, this improves the algorithm from O(n) to O(1).

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

Changes since v5:
pool_free_page() no longer exists.
Updated big O usage in description.

 mm/dmapool.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 4e075feb038f..fc9ae0683c20 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -17,6 +17,10 @@
  * least 'size' bytes.  Free blocks are tracked in an unsorted singly-linked
  * list of free blocks within the page.  Used blocks aren't tracked, but we
  * keep a count of how many are currently allocated from each page.
+ *
+ * The avail_page_list keeps track of pages that have one or more free blocks
+ * available to (re)allocate.  Pages are moved in and out of avail_page_list
+ * as their blocks are allocated and freed.
  */
 
 #include <linux/device.h>
@@ -42,6 +46,7 @@
 
 struct dma_pool {		/* the pool */
 	struct list_head page_list;
+	struct list_head avail_page_list;
 	spinlock_t lock;
 	struct device *dev;
 	unsigned int size;
@@ -54,6 +59,7 @@ struct dma_pool {		/* the pool */
 
 struct dma_page {		/* cacheable header for 'allocation' bytes */
 	struct list_head page_list;
+	struct list_head avail_page_link;
 	void *vaddr;
 	dma_addr_t dma;
 	unsigned int in_use;
@@ -155,6 +161,7 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	retval->dev = dev;
 
 	INIT_LIST_HEAD(&retval->page_list);
+	INIT_LIST_HEAD(&retval->avail_page_list);
 	spin_lock_init(&retval->lock);
 	retval->size = size;
 	retval->boundary = boundary;
@@ -311,10 +318,11 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	might_alloc(mem_flags);
 
 	spin_lock_irqsave(&pool->lock, flags);
-	list_for_each_entry(page, &pool->page_list, page_list) {
-		if (page->offset < pool->allocation)
-			goto ready;
-	}
+	page = list_first_entry_or_null(&pool->avail_page_list,
+					struct dma_page,
+					avail_page_link);
+	if (page)
+		goto ready;
 
 	/* pool_alloc_page() might sleep, so temporarily drop &pool->lock */
 	spin_unlock_irqrestore(&pool->lock, flags);
@@ -326,10 +334,13 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	spin_lock_irqsave(&pool->lock, flags);
 
 	list_add(&page->page_list, &pool->page_list);
+	list_add(&page->avail_page_link, &pool->avail_page_list);
  ready:
 	page->in_use++;
 	offset = page->offset;
 	page->offset = *(int *)(page->vaddr + offset);
+	if (page->offset >= pool->allocation)
+		list_del_init(&page->avail_page_link);
 	retval = offset + page->vaddr;
 	*handle = offset + page->dma;
 #ifdef	DMAPOOL_DEBUG
@@ -451,6 +462,13 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 		memset(vaddr, 0, pool->size);
 #endif
 
+	/*
+	 * list_empty() on the page tests if the page is already linked into
+	 * avail_page_list to avoid adding it more than once.
+	 */
+	if (list_empty(&page->avail_page_link))
+		list_add(&page->avail_page_link, &pool->avail_page_list);
+
 	page->in_use--;
 	*(int *)vaddr = page->offset;
 	page->offset = offset;
-- 
2.25.1

