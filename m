Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514055395FF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiEaSOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346882AbiEaSNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:13:51 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1469CC99
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:13:34 -0700 (PDT)
X-ASG-Debug-ID: 1654020812-1cf43917f334afe0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id nHifSkbHIxrhwGDp; Tue, 31 May 2022 14:13:32 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=FrnayQTLRg3bImjySCMn4AK6vTiCgnyfnm+pKLSvhx0=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=G9I1y0Cm5SI5a20B9p45
        Ch/vtXr3T2oFr+6ys40VeK3ubfORXd8KFUN5jCE/6JUWAIy1cBsSzzxHDqoXYj3XE0YBtRWEEJxSV
        VLobdcVMmmCaDWU+U0KnUIuyfrTSUdqRMkNdomm+YVy9APQXHE5/7HR7dEPHZYkExGOv45asZE=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11829190; Tue, 31 May 2022 14:13:32 -0400
Message-ID: <81004e69-d91f-9fbb-2b94-217b48a064c3@cybernetics.com>
Date:   Tue, 31 May 2022 14:13:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 02/10] dmapool: cleanup integer types
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 02/10] dmapool: cleanup integer types
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
X-Barracuda-Start-Time: 1654020812
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 3356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To represent the size of a single allocation, dmapool currently uses
'unsigned int' in some places and 'size_t' in other places.  Standardize
on 'unsigned int' to reduce overhead, but use 'size_t' when counting all
the blocks in the entire pool.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

This puts an upper bound on 'size' of INT_MAX to avoid overflowing the
following comparison in pool_initialise_page():

unsigned int offset = 0;
unsigned int next = offset + pool->size;
if (unlikely((next + pool->size) > ...

'boundary' is passed in as a size_t but gets stored as an unsigned int.
'boundary' values >= 'allocation' do not have any effect, so clipping
'boundary' to 'allocation' keeps it within the range of unsigned int
without affecting anything else.  A few lines above (not in the diff)
you can see that if 'boundary' is passed in as 0 then it is set to
'allocation', so it is nothing new.  For reference, here is the
relevant code after being patched:

	if (!boundary)
		boundary = allocation;
	else if ((boundary < size) || (boundary & (boundary - 1)))
		return NULL;

	boundary = min(boundary, allocation);

 mm/dmapool.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 0f89de408cbe..d7b372248111 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -43,10 +43,10 @@
 struct dma_pool {		/* the pool */
 	struct list_head page_list;
 	spinlock_t lock;
-	size_t size;
+	unsigned int size;
 	struct device *dev;
-	size_t allocation;
-	size_t boundary;
+	unsigned int allocation;
+	unsigned int boundary;
 	char name[32];
 	struct list_head pools;
 };
@@ -80,7 +80,7 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
 	mutex_lock(&pools_lock);
 	list_for_each_entry(pool, &dev->dma_pools, pools) {
 		unsigned pages = 0;
-		unsigned blocks = 0;
+		size_t blocks = 0;
 
 		spin_lock_irq(&pool->lock);
 		list_for_each_entry(page, &pool->page_list, page_list) {
@@ -90,9 +90,10 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
 		spin_unlock_irq(&pool->lock);
 
 		/* per-pool info, no real statistics yet */
-		temp = scnprintf(next, size, "%-16s %4u %4zu %4zu %2u\n",
+		temp = scnprintf(next, size, "%-16s %4zu %4zu %4u %2u\n",
 				 pool->name, blocks,
-				 pages * (pool->allocation / pool->size),
+				 (size_t) pages *
+				 (pool->allocation / pool->size),
 				 pool->size, pages);
 		size -= temp;
 		next += temp;
@@ -139,7 +140,7 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	else if (align & (align - 1))
 		return NULL;
 
-	if (size == 0)
+	if (size == 0 || size > INT_MAX)
 		return NULL;
 	else if (size < 4)
 		size = 4;
@@ -152,6 +153,8 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	else if ((boundary < size) || (boundary & (boundary - 1)))
 		return NULL;
 
+	boundary = min(boundary, allocation);
+
 	retval = kmalloc(sizeof(*retval), GFP_KERNEL);
 	if (!retval)
 		return retval;
@@ -312,7 +315,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 {
 	unsigned long flags;
 	struct dma_page *page;
-	size_t offset;
+	unsigned int offset;
 	void *retval;
 
 	might_alloc(mem_flags);
-- 
2.25.1

