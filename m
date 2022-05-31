Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1E539618
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242951AbiEaSSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346947AbiEaSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:18:44 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0B8DDE8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:18:42 -0700 (PDT)
X-ASG-Debug-ID: 1654021121-1cf43917f334b070001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id yj29GjpIIDRwn4BW; Tue, 31 May 2022 14:18:41 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=Z2Ky3BhmVZCP6nQJsAzLenh1k2tIAiuPv7c6Ywt4xp0=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=l4gmGdtEEc475y+cPS0i
        b3CXKfRcWn4bzL+nlsGSrpLAqCAgnrQN4vO8XeOkunQPpE6QaJJS41Y/Ya9CMBv8n21a+SHmXaAVC
        XqS+12dpa3XgoD+yv6qzm0y6xH8gkXnhke2W5TRMUbJSCpDTjZ3EVBmeUajwr+X7dja0fJwqU8=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11829213; Tue, 31 May 2022 14:18:41 -0400
Message-ID: <0c6c1548-6e3a-0d8d-4bb7-471fdfb403ca@cybernetics.com>
Date:   Tue, 31 May 2022 14:18:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 05/10] dmapool: debug: prevent endless loop in case of
 corruption
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 05/10] dmapool: debug: prevent endless loop in case of
 corruption
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
X-Barracuda-Start-Time: 1654021121
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent a possible endless loop with DMAPOOL_DEBUG enabled if a buggy
driver corrupts DMA pool memory.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 9e30f4425dea..7a9161d4f7a6 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -426,16 +426,39 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	}
 	{
 		unsigned int chain = page->offset;
+		unsigned int free_blks = 0;
+
 		while (chain < pool->allocation) {
-			if (chain != offset) {
-				chain = *(int *)(page->vaddr + chain);
-				continue;
+			if (unlikely(chain == offset)) {
+				spin_unlock_irqrestore(&pool->lock, flags);
+				dev_err(pool->dev,
+					"%s %s, dma %pad already free\n",
+					__func__, pool->name, &dma);
+				return;
 			}
-			spin_unlock_irqrestore(&pool->lock, flags);
-			dev_err(pool->dev, "%s %s, dma %pad already free\n",
-				__func__, pool->name, &dma);
-			return;
+
+			/*
+			 * A buggy driver could corrupt the freelist by
+			 * use-after-free, buffer overflow, etc.  Besides
+			 * checking for corruption, this also prevents an
+			 * endless loop in case corruption causes a circular
+			 * loop in the freelist.
+			 */
+			if (unlikely(++free_blks + page->in_use >
+				     pool->blks_per_alloc)) {
+ freelist_corrupt:
+				spin_unlock_irqrestore(&pool->lock, flags);
+				dev_err(pool->dev,
+					"%s %s, freelist corrupted\n",
+					__func__, pool->name);
+				return;
+			}
+
+			chain = *(int *)(page->vaddr + chain);
 		}
+		if (unlikely(free_blks + page->in_use !=
+			     pool->blks_per_alloc))
+			goto freelist_corrupt;
 	}
 	memset(vaddr, POOL_POISON_FREED, pool->size);
 #endif
-- 
2.25.1

