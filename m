Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B140F5ADD76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiIFClH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiIFClF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:41:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDF665555
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 19:41:03 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MM8hP0FfLznV6N;
        Tue,  6 Sep 2022 10:38:29 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 10:40:59 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 10:40:58 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>, <chenwandun@huawei.com>
Subject: [PATCH] iommu/dma: speedup memory allocation in __iommu_dma_alloc_pages
Date:   Tue, 6 Sep 2022 10:39:02 +0800
Message-ID: <20220906023902.133103-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found kcompactd was excessively running in Android, after
some debug, found some order-9 allocations in iommu/dma.

It splits contiguous page to single page in dma allocation,
that means it is not necessary to alloc contiguous page, what
is more, allocation for high order may cause direct memory
reclaim and compaction, result in poor performance.

In this patch, try to alloc memory by alloc_pages_bulk_array_node
first, speedup memory allocation by saving unnecessary direct
memory reclaim and compaction, fallback to original path when
failed, beside remove __GFP_DIRECT_RECLAIM for costly order.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/iommu/dma-iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f90251572a5d..b8463934d806 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -720,7 +720,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 		unsigned int count, unsigned long order_mask, gfp_t gfp)
 {
 	struct page **pages;
-	unsigned int i = 0, nid = dev_to_node(dev);
+	unsigned int i, nid = dev_to_node(dev);
 
 	order_mask &= (2U << MAX_ORDER) - 1;
 	if (!order_mask)
@@ -736,6 +736,11 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	/* It makes no sense to muck about with huge pages */
 	gfp &= ~__GFP_COMP;
 
+	i = alloc_pages_bulk_array_node(gfp, nid, count, pages);
+	if (count == i)
+		return pages;
+	count -= i;
+
 	while (count) {
 		struct page *page = NULL;
 		unsigned int order_size;
@@ -753,6 +758,10 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 			order_size = 1U << order;
 			if (order_mask > order_size)
 				alloc_flags |= __GFP_NORETRY;
+
+			if (order > PAGE_ALLOC_COSTLY_ORDER)
+				alloc_flags &= ~__GFP_DIRECT_RECLAIM;
+
 			page = alloc_pages_node(nid, alloc_flags, order);
 			if (!page)
 				continue;
-- 
2.25.1

