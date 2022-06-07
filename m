Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2692D541C83
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383354AbiFGWBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379058AbiFGVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:02:00 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DEA188E66
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:46:17 -0700 (PDT)
X-ASG-Debug-ID: 1654627544-1cf43917f3396710001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id u3h3PzNcv3GISwVG; Tue, 07 Jun 2022 14:45:44 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=fJQpcCRHMP3bElV7sUkA+QTTFc8Tk97S5Mqvw1QDnTQ=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=ghina6onuUS2ov/P3hH9
        L5dEdD+6sGEHGT4vP9jtWoQ5eCxd6dCBxtPoExAZw2K5opBuq2H/Z4oCWx5J1HX8r2nziqL09VDv3
        7e7fCgDlngbrr1wSqKCea76X8QbWpcNpautqqHUnpKW3+01/yk5/iaywpvmAI7fEdg/W5S6oPo=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11859468; Tue, 07 Jun 2022 14:45:44 -0400
Message-ID: <11b7e3cd-c929-654c-1f45-1abe9a6f6a98@cybernetics.com>
Date:   Tue, 7 Jun 2022 14:45:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 09/11] dmapool: cleanup dma_pool_destroy
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 09/11] dmapool: cleanup dma_pool_destroy
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
X-Barracuda-Start-Time: 1654627544
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2336
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pool_free_page() is called only from dma_pool_destroy(), so inline it
and make it less generic since we know that the pool is being destroyed.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

Changes since v5:
Take the opposite approach and inline pool_free_page() into
dma_pool_destroy() instead of moving the is_page_busy() check into
pool_free_page().

 mm/dmapool.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index c7ec38cb4631..4e075feb038f 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -241,18 +241,6 @@ static inline bool is_page_busy(struct dma_page *page)
 	return page->in_use != 0;
 }
 
-static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
-{
-	dma_addr_t dma = page->dma;
-
-#ifdef	DMAPOOL_DEBUG
-	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
-#endif
-	dma_free_coherent(pool->dev, pool->allocation, page->vaddr, dma);
-	list_del(&page->page_list);
-	kfree(page);
-}
-
 /**
  * dma_pool_destroy - destroys a pool of dma memory blocks.
  * @pool: dma pool that will be destroyed
@@ -280,14 +268,22 @@ void dma_pool_destroy(struct dma_pool *pool)
 	mutex_unlock(&pools_reg_lock);
 
 	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
+		void *vaddr = page->vaddr;
+
 		if (is_page_busy(page)) {
 			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
-				pool->name, page->vaddr);
+				pool->name, vaddr);
 			/* leak the still-in-use consistent memory */
-			list_del(&page->page_list);
-			kfree(page);
-		} else
-			pool_free_page(pool, page);
+		} else {
+#ifdef	DMAPOOL_DEBUG
+			memset(vaddr, POOL_POISON_FREED, pool->allocation);
+#endif
+			dma_free_coherent(pool->dev,
+					  pool->allocation,
+					  vaddr,
+					  page->dma);
+		}
+		kfree(page);
 	}
 
 	kfree(pool);
@@ -459,8 +455,7 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	*(int *)vaddr = page->offset;
 	page->offset = offset;
 	/*
-	 * Resist a temptation to do
-	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
+	 * Resist a temptation to free unused pages immediately.
 	 * Better have a few empty pages hang around.
 	 */
 	spin_unlock_irqrestore(&pool->lock, flags);
-- 
2.25.1

