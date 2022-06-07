Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4955C541BB7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383203AbiFGVwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377130AbiFGU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:57:33 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C395201FF3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:44:21 -0700 (PDT)
X-ASG-Debug-ID: 1654627459-1cf43917f3396680001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id ytKMQdwzzCTN1huP; Tue, 07 Jun 2022 14:44:19 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=ko90FEQrFc3kr/EXmZEbhsh++NujIvq49Z2hdvGupnI=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=WUGhF+zc7hcw6JoFhMVn
        sGaBwqMKrtT0LAsXqUcUj76iU06x+W8kn/yVArt8p4dHAKYUv4FvRp/bnqdKNITJ8eZ4h4+G4cdWa
        MiUopTVPkmkKCknVE11Zis2M2WKnboszBLWCavFSHLU31NMgSYjzMIvvxF7fzNbz4pg+2PoWvM=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11859456; Tue, 07 Jun 2022 14:44:19 -0400
Message-ID: <06f83492-1eaf-16c4-31b0-1f148995ee59@cybernetics.com>
Date:   Tue, 7 Jun 2022 14:44:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 07/11] dmapool: ignore init_on_free when DMAPOOL_DEBUG
 enabled
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 07/11] dmapool: ignore init_on_free when DMAPOOL_DEBUG
 enabled
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
X-Barracuda-Start-Time: 1654627459
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1450
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
DMAPOOL_DEBUG will memset the memory anyway, so speed thing up by
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
index facdb3571976..44038089a41a 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -406,8 +406,6 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	}
 
 	offset = vaddr - page->vaddr;
-	if (want_init_on_free())
-		memset(vaddr, 0, pool->size);
 #ifdef	DMAPOOL_DEBUG
 	if ((dma - page->dma) != offset) {
 		spin_unlock_irqrestore(&pool->lock, flags);
@@ -452,6 +450,9 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
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

