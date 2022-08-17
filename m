Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB059692E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiHQGHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiHQGHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:07:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B53C6DF90
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=G9e1eXFet/1n+mqch3msero3cUeihjkQibHHOgmNHVM=; b=Rjbq716kAe5Ou/J+71N+hGKqTD
        rjBxLPgqVJS/FA+J+eJHtLDxa8091zEn2PBUJiiHocGXYYzeQJCxG6uejC8Iy5Xk7ro5E4sZsszic
        87cufXld7JIGytD0sHUTUwaFEeCr9/yE5jE0QJXOUreiziHvVEGgaW+4i+JqU+mi3nKfi+QuzN+Yi
        +xR2aYL4SLJiTlcSn+V9tssSZfFuUTjKew7RIMHDvykz7jWp+h8lsngSQV27WVm86Y4rzAhFj+fk3
        1uYj7pEeMUQWRKxqs0RrjJ9/oVoCtjrl2nlKlCAx9PPZst3YrhOYbDO16JIZddv8KWK5MeL9skebG
        IC9G7gew==;
Received: from [2a02:1210:321a:af00:5fac:fede:a3b:c715] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOCCY-00BeK1-LI; Wed, 17 Aug 2022 06:06:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dma-pool: don't return errors from dma_atomic_pool_init
Date:   Wed, 17 Aug 2022 08:06:46 +0200
Message-Id: <20220817060647.1032426-3-hch@lst.de>
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

Returning errors from initcalls does not change a thing, thus don't
bother with returning -ENOMEM if one of the pool allocations failed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/pool.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 56f96678934bf..5b07b0379a501 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -195,8 +195,6 @@ static unsigned long calculate_pool_size(unsigned long zone_pages)
 
 static int __init dma_atomic_pool_init(void)
 {
-	int ret = 0;
-
 	/*
 	 * If coherent_pool was not used on the command line, default the pool
 	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
@@ -208,23 +206,17 @@ static int __init dma_atomic_pool_init(void)
 
 	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
 						    GFP_KERNEL);
-	if (!atomic_pool_kernel)
-		ret = -ENOMEM;
 	if (has_managed_dma()) {
 		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
 						GFP_KERNEL | GFP_DMA);
-		if (!atomic_pool_dma)
-			ret = -ENOMEM;
 	}
 	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
 		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
 						GFP_KERNEL | GFP_DMA32);
-		if (!atomic_pool_dma32)
-			ret = -ENOMEM;
 	}
 
 	dma_atomic_pool_debugfs_init();
-	return ret;
+	return 0;
 }
 postcore_initcall(dma_atomic_pool_init);
 
-- 
2.30.2

