Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0237541B44
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382175AbiFGVql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378379AbiFGUvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:51:42 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C23115A43
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:42:10 -0700 (PDT)
X-ASG-Debug-ID: 1654627329-1cf43917f33965c0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id 79iRHZabdgVhHOFB; Tue, 07 Jun 2022 14:42:09 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=QbGgNEs9DYDdDETge9nU6qZiAN8p+i0+8LJZVlYu570=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=jsWpK2MOULqWUEtEYypu
        BZF113V20OKS/bUvhZVyqHKTY3exH3pnTa1QbMsrI0H9CbQGv9hAAG8PzWuG8R9hLqsUNEYUi26EP
        8sXIBWYag6D+3OMUTNSodUaPd+OaQi/fx5JrYEKxj7ulxkltkon72+19JDoSSGToGumE1b7Fto=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11859424; Tue, 07 Jun 2022 14:42:09 -0400
Message-ID: <6eaea467-cc50-acbd-6232-892011fc803c@cybernetics.com>
Date:   Tue, 7 Jun 2022 14:42:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 04/11] dmapool: fix boundary comparison
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 04/11] dmapool: fix boundary comparison
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
X-Barracuda-Start-Time: 1654627329
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the boundary comparison when constructing the list of free blocks
for the case that 'size' is a power of two.  Since 'boundary' is also a
power of two, that would make 'boundary' a multiple of 'size', in which
case a single block would never cross the boundary.  This bug would
cause some of the allocated memory to be wasted (but not leaked).

Example:

size       = 512
boundary   = 2048
allocation = 4096

Address range
   0 -  511
 512 - 1023
1024 - 1535
1536 - 2047 *
2048 - 2559
2560 - 3071
3072 - 3583
3584 - 4095 *

Prior to this fix, the address ranges marked with "*" would not have
been used even though they didn't cross the given boundary.

Fixes: e34f44b3517f ("pool: Improve memory usage for devices which can't cross boundaries")
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index f85d6bde2205..122781fe2c03 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -201,7 +201,7 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 
 	do {
 		unsigned int next = offset + pool->size;
-		if (unlikely((next + pool->size) >= next_boundary)) {
+		if (unlikely((next + pool->size) > next_boundary)) {
 			next = next_boundary;
 			next_boundary += pool->boundary;
 		}
-- 
2.25.1

