Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1627541B65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381916AbiFGVpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378749AbiFGUw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:52:26 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B91ADBF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:42:58 -0700 (PDT)
X-ASG-Debug-ID: 1654627376-1cf43917f33965e0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id 9IJWbVWe0kxl8Q4W; Tue, 07 Jun 2022 14:42:56 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=eQM8tN6t62Fopbgjt8uTQgBSZ1EO2wkhvfxABlFtH9o=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=IixmWpGiaqvQUprEzkz0
        RLY8E/16bD+CZb7eDVxwsJJx0WhcGJberWRDEq6vXklSwUFj/Uz/gezadInQpSSObCp8dKbeGiBa7
        w3Y7jLuYeY+HtSBYaVfbLDLoltgTK+A7YCT6QfatyfhhlsxJVy8j/AsCZzK72KxdoC1mOT995M=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11859435; Tue, 07 Jun 2022 14:42:56 -0400
Message-ID: <c918d44b-1822-b076-0833-7645a2079809@cybernetics.com>
Date:   Tue, 7 Jun 2022 14:42:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 05/11] dmapool: improve accuracy of debug statistics
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 05/11] dmapool: improve accuracy of debug statistics
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
X-Barracuda-Start-Time: 1654627376
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "total number of blocks in pool" debug statistic currently does not
take the boundary value into account, so it diverges from the "total
number of blocks in use" statistic when a boundary is in effect.  Add a
calculation for the number of blocks per allocation that takes the
boundary into account, and use it to replace the inaccurate calculation.

This depends on the patch "dmapool: fix boundary comparison" for the
calculated blks_per_alloc value to be correct.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

The added blks_per_alloc value will also be used in the next patch.

 mm/dmapool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 122781fe2c03..d3e5a6151fb4 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -47,6 +47,7 @@ struct dma_pool {		/* the pool */
 	unsigned int size;
 	unsigned int allocation;
 	unsigned int boundary;
+	unsigned int blks_per_alloc;
 	char name[32];
 	struct list_head pools;
 };
@@ -85,8 +86,7 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
 		/* per-pool info, no real statistics yet */
 		size += sysfs_emit_at(buf, size, "%-16s %4zu %4zu %4u %2u\n",
 				      pool->name, blocks,
-				      (size_t) pages *
-				      (pool->allocation / pool->size),
+				      (size_t) pages * pool->blks_per_alloc,
 				      pool->size, pages);
 	}
 	mutex_unlock(&pools_lock);
@@ -159,6 +159,9 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	retval->size = size;
 	retval->boundary = boundary;
 	retval->allocation = allocation;
+	retval->blks_per_alloc =
+		(allocation / boundary) * (boundary / size) +
+		(allocation % boundary) / size;
 
 	INIT_LIST_HEAD(&retval->pools);
 
-- 
2.25.1

