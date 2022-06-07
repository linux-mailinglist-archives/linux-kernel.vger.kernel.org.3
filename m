Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79257541BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383605AbiFGVxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377506AbiFGU7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:59:43 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB366C8A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:45:00 -0700 (PDT)
X-ASG-Debug-ID: 1654627498-1cf43917f33966c0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id QrVV0e8kIBE4Cwz7; Tue, 07 Jun 2022 14:44:58 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=btLFiUXlrqByYR1DIyy+G6nrdsPdAmYyLow6+1WajEE=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=kMCkFAqaqzd846YJ+lfv
        P4h/NJYwHpSNVC1LQlF8sCQD9tdRu8eU6Qyj6nA3UeEKS+Q9SlxZQGnGHONgBLNRjIqoLyhLGMtJU
        PX5uv5AZczFROzSnYLENhV5Gvejwrk80VJPKT5Zp3M2xPaJ0IR+U/zBt+GENsvWIAsbrV1uxdI=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11859466; Tue, 07 Jun 2022 14:44:58 -0400
Message-ID: <b1100f23-7a75-c5a0-851c-42d62554efa2@cybernetics.com>
Date:   Tue, 7 Jun 2022 14:44:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 08/11] dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 08/11] dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
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
X-Barracuda-Start-Time: 1654627498
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 688
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid double-memset of the same allocated memory in dma_pool_alloc()
when both DMAPOOL_DEBUG is enabled and init_on_alloc=1.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 44038089a41a..c7ec38cb4631 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -356,7 +356,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 			break;
 		}
 	}
-	if (!(mem_flags & __GFP_ZERO))
+	if (!want_init_on_alloc(mem_flags))
 		memset(retval, POOL_POISON_ALLOCATED, pool->size);
 #endif
 	spin_unlock_irqrestore(&pool->lock, flags);
-- 
2.25.1

