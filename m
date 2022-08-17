Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C18596927
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbiHQGHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiHQGHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:07:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E362B6DAD8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YeVjNbbCyrLCxeeK773ZS2fix2ZWLAllDEe+iliUr6U=; b=qyzt4l7OjJR+cqPnAdP1H52KVF
        ZtymnxPGxQJY6FrrzO45Z07Uvw3hQMjAwqaDmUElj2oGcIgAi99VTn95ndxQ0Z9K01Yl49E9OPJid
        rRtUTfhzDcjDfl7k3L7flbRjq0hUOtpXEg9J4/QVp+IbG/KjrNLHqIVL1AXJXhUS4xvHCOJhdKOxm
        pdYazmxiwhplroAwbFACcxL/lcfY27JmT9RaQuQC6iaC7+RAQOdR0qX54LHzhfhnlrlZaUFSES5W7
        qAYTGyYYRssGkvAMzglkvEShEppsTN49j7+ELzA/4b4AwhlzMW+wVmoFF2dggbwETQSiuK3T3693B
        HUzVlq5Q==;
Received: from [2a02:1210:321a:af00:5fac:fede:a3b:c715] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOCCb-00BeL0-6y; Wed, 17 Aug 2022 06:06:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Date:   Wed, 17 Aug 2022 08:06:47 +0200
Message-Id: <20220817060647.1032426-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817060647.1032426-1-hch@lst.de>
References: <20220817060647.1032426-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limit the sizing of the atomic pools for allocations from
ZONE_DMA and ZONE_DMA32 based on the number of pages actually
present in those zones instead of the total memory.

Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
Reported-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/pool.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 5b07b0379a501..f629c6dfd8555 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -193,28 +193,46 @@ static unsigned long calculate_pool_size(unsigned long zone_pages)
 	return max_t(unsigned long, nr_pages << PAGE_SHIFT, SZ_128K);
 }
 
+#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA32)
+static unsigned long __init nr_managed_pages(int zone_idx)
+{
+	struct pglist_data *pgdat;
+	unsigned long nr_pages = 0;
+
+	for_each_online_pgdat(pgdat)
+		nr_pages += zone_managed_pages(&pgdat->node_zones[zone_idx]);
+	return nr_pages;
+}
+#endif /* CONFIG_ZONE_DMA || CONFIG_ZONE_DMA32 */
+
 static int __init dma_atomic_pool_init(void)
 {
+	unsigned long nr_zone_dma_pages, nr_zone_dma32_pages;
+
+#ifdef CONFIG_ZONE_DMA
+	nr_zone_dma_pages = nr_managed_pages(ZONE_DMA);
+	if (nr_zone_dma_pages)
+		atomic_pool_dma = __dma_atomic_pool_init(
+				calculate_pool_size(nr_zone_dma_pages),
+				GFP_DMA);
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	nr_zone_dma32_pages = nr_managed_pages(ZONE_DMA32);
+	if (nr_zone_dma32_pages)
+		atomic_pool_dma32 = __dma_atomic_pool_init(
+				calculate_pool_size(nr_zone_dma32_pages),
+				GFP_DMA32);
+#endif
 	/*
 	 * If coherent_pool was not used on the command line, default the pool
 	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
 	 */
 	if (!atomic_pool_size)
 		atomic_pool_size = calculate_pool_size(totalram_pages());
-
-	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
-
 	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
 						    GFP_KERNEL);
-	if (has_managed_dma()) {
-		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA);
-	}
-	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
-		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA32);
-	}
 
+	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
 	dma_atomic_pool_debugfs_init();
 	return 0;
 }
-- 
2.30.2

