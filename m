Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A023B541B15
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381353AbiFGVka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377683AbiFGUux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:50:53 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7EF18484F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:40:29 -0700 (PDT)
X-ASG-Debug-ID: 1654627227-1cf43917f3396520001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id 7q8f4i5VB5tulwTq; Tue, 07 Jun 2022 14:40:27 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=cPbWsHAkkEQ/IV9PNOMIz+rmz60KjJDA9BYZCB0e3iI=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=J61v7CvSfK8dXjZ+w6d6
        8xsL1vF77oaGreuBYU7E3kJZx8xX3v0D3QVShQw+LlGqoqmzsxMRHMWmX0lcshWXQX6z4NcKT9bI+
        q8x408aTjLn4GMLHAA6WESTFy6mRrWzbZH1Xax48DUgHMZxC7lO4zW3Q1Hp8lmRcXny/TJ7c6w=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11859402; Tue, 07 Jun 2022 14:40:26 -0400
Message-ID: <6c627beb-eb61-5baa-484a-e35567f05e89@cybernetics.com>
Date:   Tue, 7 Jun 2022 14:40:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 02/11] dmapool: use sysfs_emit() instead of scnprintf()
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 02/11] dmapool: use sysfs_emit() instead of scnprintf()
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
X-Barracuda-Start-Time: 1654627227
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1630
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_emit instead of scnprintf, snprintf or sprintf.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

Changes since v5:
This patch was not in v5.

 mm/dmapool.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 0f89de408cbe..1829291f5d70 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -64,18 +64,11 @@ static DEFINE_MUTEX(pools_reg_lock);
 
 static ssize_t pools_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	unsigned temp;
-	unsigned size;
-	char *next;
+	int size;
 	struct dma_page *page;
 	struct dma_pool *pool;
 
-	next = buf;
-	size = PAGE_SIZE;
-
-	temp = scnprintf(next, size, "poolinfo - 0.1\n");
-	size -= temp;
-	next += temp;
+	size = sysfs_emit(buf, "poolinfo - 0.1\n");
 
 	mutex_lock(&pools_lock);
 	list_for_each_entry(pool, &dev->dma_pools, pools) {
@@ -90,16 +83,14 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
 		spin_unlock_irq(&pool->lock);
 
 		/* per-pool info, no real statistics yet */
-		temp = scnprintf(next, size, "%-16s %4u %4zu %4zu %2u\n",
-				 pool->name, blocks,
-				 pages * (pool->allocation / pool->size),
-				 pool->size, pages);
-		size -= temp;
-		next += temp;
+		size += sysfs_emit_at(buf, size, "%-16s %4u %4zu %4zu %2u\n",
+				      pool->name, blocks,
+				      pages * (pool->allocation / pool->size),
+				      pool->size, pages);
 	}
 	mutex_unlock(&pools_lock);
 
-	return PAGE_SIZE - size;
+	return size;
 }
 
 static DEVICE_ATTR_RO(pools);
-- 
2.25.1

