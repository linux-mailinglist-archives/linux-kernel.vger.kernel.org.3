Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8414C596923
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiHQGHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiHQGHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:07:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB3B6E2C8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kxT1VSiJCRIBbEikqcrR3SVCTeRiXUVEPoU8mY2X8Eg=; b=uI80PADatxcGITF9IVYXQJh4ig
        WM4M7unUZbIIRo3QFqux+vxJ9HIXCLZK5y0PtYoLhO9UR/aVewm7qJK6ffwMmr21aPnV/VXh91jdP
        /APnoNUnQas/9tLofJDlyB152PNHLKIRS0EtSXPSDiySRoMMV5/9Q+MfhHCg52HU6yu2G4AA50Esn
        zxS6+xc9sv97p/GRnr8mNOa+YuYah/J5i0FYYd5PrMfMZ2kdnwKRfaSMdBspEW5IfihRSpt1CgiPx
        sW1qRTgIUdrZhL84Kpp/H0LxZKa8n2xkkKdirbW6GcMRQNC9OH8pdJe19BOabmZHvVRUhQsNUGMcj
        EnyQ71MA==;
Received: from [2a02:1210:321a:af00:5fac:fede:a3b:c715] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOCCW-00BeHT-2t; Wed, 17 Aug 2022 06:06:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dma-pool: factor out a calculate_pool_size helper
Date:   Wed, 17 Aug 2022 08:06:45 +0200
Message-Id: <20220817060647.1032426-2-hch@lst.de>
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

Add a helper to calculate the pool size from dma_atomic_pool_init,
and fix up the last max_t to use the proper type.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/pool.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 4d40dcce7604b..56f96678934bf 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -184,6 +184,15 @@ static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
 	return pool;
 }
 
+static unsigned long calculate_pool_size(unsigned long zone_pages)
+{
+	unsigned long nr_pages = min_t(unsigned long,
+				       zone_pages / (SZ_1G / SZ_128K),
+				       MAX_ORDER_NR_PAGES);
+
+	return max_t(unsigned long, nr_pages << PAGE_SHIFT, SZ_128K);
+}
+
 static int __init dma_atomic_pool_init(void)
 {
 	int ret = 0;
@@ -192,11 +201,9 @@ static int __init dma_atomic_pool_init(void)
 	 * If coherent_pool was not used on the command line, default the pool
 	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
 	 */
-	if (!atomic_pool_size) {
-		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
-		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
-		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
-	}
+	if (!atomic_pool_size)
+		atomic_pool_size = calculate_pool_size(totalram_pages());
+
 	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
 
 	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
-- 
2.30.2

