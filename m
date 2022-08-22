Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159AB59B911
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiHVGNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiHVGNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:13:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3380626AFD
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=14V5NYSXhcjjUsP6WVWqoNQXmx5UyXub98RZEVfPGbA=; b=pd/N68ec5jwTNIf10L8eWwd+ij
        8w75w94Q+3BAre/2LFeYgudFNai/rxhUoMYfysZMD6FVz/fxWO39GDEbhlQ6aCN0RqwtGH/Ivb8uF
        KxlK2n3ZptJcCTayUutBpu8JD4APbNpiv4CpxjJ8PWxbZMARMPkDcYmxITF8nYWlhkFpgqgE82BOX
        a9SqyYP1RAMYjYeZObmBn64v5XndDuGXmqEQqFlmu7UaRi6dNGZj1i/xobBUsAZh5fo+e6dJXCGM8
        1mMfrcI6FwN2Je4R1Ijvfe5A/H99eKZcaAntIpS/Ghw+wnAzClFJBl7bwqMKM5b2ziSOuRANmNWOV
        Quk9pavQ==;
Received: from [2001:4bb8:198:6528:7eb3:3a42:932d:eeba] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ0gL-005KcN-Lo; Mon, 22 Aug 2022 06:13:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Date:   Mon, 22 Aug 2022 08:12:55 +0200
Message-Id: <20220822061255.151688-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822061255.151688-1-hch@lst.de>
References: <20220822061255.151688-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Michal Hocko <mhocko@suse.com>
---
 kernel/dma/pool.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 4b4c59d05e436..2a6c71311a175 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -192,28 +192,40 @@ static size_t calculate_pool_size(unsigned long zone_pages)
 	return max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
 }
 
+static struct gen_pool * __init __maybe_unused zone_pool_init(int zone_idx,
+		gfp_t gfp)
+{
+	struct pglist_data *pgdat;
+	unsigned long nr_pages = 0;
+
+	for_each_online_pgdat(pgdat)
+		nr_pages += zone_managed_pages(&pgdat->node_zones[zone_idx]);
+
+	if (!nr_pages)
+		return NULL;
+
+	return __dma_atomic_pool_init(calculate_pool_size(nr_pages), gfp);
+}
+
 static int __init dma_atomic_pool_init(void)
 {
+#ifdef CONFIG_ZONE_DMA
+	atomic_pool_dma = zone_pool_init(ZONE_DMA, GFP_DMA);
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	atomic_pool_dma32 = zone_pool_init(ZONE_DMA32, GFP_DMA32);
+#endif
+
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

