Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8053962C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbiEaSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbiEaSWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:22:24 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD07A81D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:22:22 -0700 (PDT)
X-ASG-Debug-ID: 1654021341-1cf43917f334b0c0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id ZzsyGX4QF38BVlyE; Tue, 31 May 2022 14:22:21 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=eQIejJQOI/tAoaluQWJF6F3pwzd0w/dyu0/0oFwF/ME=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=F5jnWTUFSe+/KQ5AraCn
        x2M3sgS5D7KBF0kTbxgh7aTkSikU4O+wLG1/eYe2hQgBrdXZpcZLc+QHWFzhFiJ92GFCKNWUEd5+3
        oUhgNCdJEQ4T0fqGo8bOwBceIA6Bh8pHjcMOaKZj21/jCvAUBq7twmACoj8fHfQ7+QWinqXjTs=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11829234; Tue, 31 May 2022 14:22:21 -0400
Message-ID: <30fd23ae-7035-5ce3-5643-89a5956f1e79@cybernetics.com>
Date:   Tue, 31 May 2022 14:22:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 08/10] dmapool: cleanup dma_pool_destroy
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 08/10] dmapool: cleanup dma_pool_destroy
From:   Tony Battersby <tonyb@cybernetics.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tony Lindgren <tony@atomide.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
In-Reply-To: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654021341
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2711
X-Barracuda-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a small amount of code duplication between dma_pool_destroy() and
pool_free_page() in preparation for adding more code without having to
duplicate it.  No functional changes.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 8749a9d7927e..58c11dcaa4e4 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -250,14 +250,25 @@ static inline bool is_page_busy(struct dma_page *page)
 	return page->in_use != 0;
 }
 
-static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
+static void pool_free_page(struct dma_pool *pool,
+			   struct dma_page *page,
+			   bool destroying_pool)
 {
+	void *vaddr = page->vaddr;
 	dma_addr_t dma = page->dma;
 
+	if (destroying_pool && is_page_busy(page)) {
+		dev_err(pool->dev,
+			"dma_pool_destroy %s, %p busy\n",
+			pool->name, vaddr);
+		/* leak the still-in-use consistent memory */
+	} else {
 #ifdef	DMAPOOL_DEBUG
-	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
+		memset(vaddr, POOL_POISON_FREED, pool->allocation);
 #endif
-	dma_free_coherent(pool->dev, pool->allocation, page->vaddr, dma);
+		dma_free_coherent(pool->dev, pool->allocation, vaddr, dma);
+	}
+
 	list_del(&page->page_list);
 	kfree(page);
 }
@@ -272,7 +283,7 @@ static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
  */
 void dma_pool_destroy(struct dma_pool *pool)
 {
-	struct dma_page *page, *tmp;
+	struct dma_page *page;
 	bool empty = false;
 
 	if (unlikely(!pool))
@@ -288,15 +299,10 @@ void dma_pool_destroy(struct dma_pool *pool)
 		device_remove_file(pool->dev, &dev_attr_pools);
 	mutex_unlock(&pools_reg_lock);
 
-	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
-		if (is_page_busy(page)) {
-			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
-				pool->name, page->vaddr);
-			/* leak the still-in-use consistent memory */
-			list_del(&page->page_list);
-			kfree(page);
-		} else
-			pool_free_page(pool, page);
+	while ((page = list_first_entry_or_null(&pool->page_list,
+						struct dma_page,
+						page_list))) {
+		pool_free_page(pool, page, true);
 	}
 
 	kfree(pool);
@@ -469,7 +475,7 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	page->offset = offset;
 	/*
 	 * Resist a temptation to do
-	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
+	 *    if (!is_page_busy(page)) pool_free_page(pool, page, false);
 	 * Better have a few empty pages hang around.
 	 */
 	spin_unlock_irqrestore(&pool->lock, flags);
-- 
2.25.1

