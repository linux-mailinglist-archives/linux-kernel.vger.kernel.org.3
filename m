Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057FD539628
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbiEaSVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346991AbiEaSUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:20:54 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2779C2DF
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:20:53 -0700 (PDT)
X-ASG-Debug-ID: 1654021252-1cf43917f334b0a0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id ozEi06WftSCDC9Dn; Tue, 31 May 2022 14:20:52 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=UMD3peLOU8xJDRQl6tZsqYH8OxWwTPFkkNKZO4VgqaY=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=rydeBuE75zkiJLNnZRfb
        /WOveUINnngDKbuBAnssoipJio6AJ8XrL7lA7d2NMt/+12EgQmGf8wBBwWfKyMEadPRL7VtaKsi4T
        JRDTXjFqiek64nTQq0wNQegdcxjMhWIPs7A+BZAqIBPh7j1EN9i6chqiPkEMvl7Zyb2O2XsC+w=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11829220; Tue, 31 May 2022 14:20:52 -0400
Message-ID: <d7499103-95c4-a002-cb6c-c8c5e3375a8d@cybernetics.com>
Date:   Tue, 31 May 2022 14:20:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 06/10] dmapool: ignore init_on_free when DMAPOOL_DEBUG enabled
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 06/10] dmapool: ignore init_on_free when DMAPOOL_DEBUG enabled
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
X-Barracuda-Start-Time: 1654021252
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two cases:

1) In the normal case that the memory is being freed correctly, then
DMAPOOL_DEBUG will memset the memory anyway, so speed things up by
avoiding a double-memset of the same memory.

2) In the abnormal case that DMAPOOL_DEBUG detects that a driver passes
incorrect parameters to dma_pool_free() (e.g. double-free, invalid
free, mismatched vaddr/dma, etc.), then that is a kernel bug, and we
don't want to clear the passed-in possibly-invalid memory pointer
because we can't be sure that the memory is really free.  So don't clear
it just because init_on_free=1.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 7a9161d4f7a6..49019ef6dd83 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -415,8 +415,6 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	}
 
 	offset = vaddr - page->vaddr;
-	if (want_init_on_free())
-		memset(vaddr, 0, pool->size);
 #ifdef	DMAPOOL_DEBUG
 	if ((dma - page->dma) != offset) {
 		spin_unlock_irqrestore(&pool->lock, flags);
@@ -461,6 +459,9 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 			goto freelist_corrupt;
 	}
 	memset(vaddr, POOL_POISON_FREED, pool->size);
+#else
+	if (want_init_on_free())
+		memset(vaddr, 0, pool->size);
 #endif
 
 	page->in_use--;
-- 
2.25.1

