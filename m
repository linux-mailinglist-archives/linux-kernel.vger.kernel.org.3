Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7784C6A45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiB1L0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiB1LZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:25:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE107093B;
        Mon, 28 Feb 2022 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=djgmmQVix6RbiuedWtBxbgyXzTpXsqAC3FYilI/M53w=; b=uUdAUZygK92o46V/8dceQuPkby
        jYfCmyMVk1TVc+6EFylRYFtVqwm8PDIDztONatKs+QZoxBlqFFJ8dkYA3FodLiXU9wPCMsP+ghiGu
        glrTTKQI6JxZ8Nj9Rw7wU/KxZSXQWMTlIRSd2JrsJ3sUfbwcvRxSyPmnQ44G2Q5TrmfPbH38yjdh+
        F3Ve3nQVdsKlzzfg4icXLOdu4I9wthUStaAF0k+kTGdz6Y2RPEvBX4A0XBDEDrm/eBJXktalIwTvB
        FSbcdaeYnpotGd4psu381N52w5U8a0MbDFSgBxFim/MbB7yMAn9vxoqZYmD1KkfHLv8ezKQ0YP9wa
        0KCCAmYA==;
Received: from [2.53.163.181] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOe9U-00BqVh-96; Mon, 28 Feb 2022 11:25:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] raid5-cache: statically allocate the recovery ra bio
Date:   Mon, 28 Feb 2022 13:25:02 +0200
Message-Id: <20220228112503.841449-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228112503.841449-1-hch@lst.de>
References: <20220228112503.841449-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to preallocate the bio and reset it when use.  Just
allocate it on-stack and use a bvec places next to the pages used for
it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-cache.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 8907d18c225a9..a7d50ff9020a8 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1623,10 +1623,10 @@ struct r5l_recovery_ctx {
 	 * just copy data from the pool.
 	 */
 	struct page *ra_pool[R5L_RECOVERY_PAGE_POOL_SIZE];
+	struct bio_vec ra_bvec[R5L_RECOVERY_PAGE_POOL_SIZE];
 	sector_t pool_offset;	/* offset of first page in the pool */
 	int total_pages;	/* total allocated pages */
 	int valid_pages;	/* pages with valid data */
-	struct bio *ra_bio;	/* bio to do the read ahead */
 };
 
 static int r5l_recovery_allocate_ra_pool(struct r5l_log *log,
@@ -1634,11 +1634,6 @@ static int r5l_recovery_allocate_ra_pool(struct r5l_log *log,
 {
 	struct page *page;
 
-	ctx->ra_bio = bio_alloc_bioset(NULL, BIO_MAX_VECS, 0, GFP_KERNEL,
-				       &log->bs);
-	if (!ctx->ra_bio)
-		return -ENOMEM;
-
 	ctx->valid_pages = 0;
 	ctx->total_pages = 0;
 	while (ctx->total_pages < R5L_RECOVERY_PAGE_POOL_SIZE) {
@@ -1650,10 +1645,8 @@ static int r5l_recovery_allocate_ra_pool(struct r5l_log *log,
 		ctx->total_pages += 1;
 	}
 
-	if (ctx->total_pages == 0) {
-		bio_put(ctx->ra_bio);
+	if (ctx->total_pages == 0)
 		return -ENOMEM;
-	}
 
 	ctx->pool_offset = 0;
 	return 0;
@@ -1666,7 +1659,6 @@ static void r5l_recovery_free_ra_pool(struct r5l_log *log,
 
 	for (i = 0; i < ctx->total_pages; ++i)
 		put_page(ctx->ra_pool[i]);
-	bio_put(ctx->ra_bio);
 }
 
 /*
@@ -1679,15 +1671,19 @@ static int r5l_recovery_fetch_ra_pool(struct r5l_log *log,
 				      struct r5l_recovery_ctx *ctx,
 				      sector_t offset)
 {
-	bio_reset(ctx->ra_bio, log->rdev->bdev, REQ_OP_READ);
-	ctx->ra_bio->bi_iter.bi_sector = log->rdev->data_offset + offset;
+	struct bio bio;
+	int ret;
+
+	bio_init(&bio, log->rdev->bdev, ctx->ra_bvec,
+		 R5L_RECOVERY_PAGE_POOL_SIZE, REQ_OP_READ);
+	bio.bi_iter.bi_sector = log->rdev->data_offset + offset;
 
 	ctx->valid_pages = 0;
 	ctx->pool_offset = offset;
 
 	while (ctx->valid_pages < ctx->total_pages) {
-		bio_add_page(ctx->ra_bio,
-			     ctx->ra_pool[ctx->valid_pages], PAGE_SIZE, 0);
+		__bio_add_page(&bio, ctx->ra_pool[ctx->valid_pages], PAGE_SIZE,
+			       0);
 		ctx->valid_pages += 1;
 
 		offset = r5l_ring_add(log, offset, BLOCK_SECTORS);
@@ -1696,7 +1692,9 @@ static int r5l_recovery_fetch_ra_pool(struct r5l_log *log,
 			break;
 	}
 
-	return submit_bio_wait(ctx->ra_bio);
+	ret = submit_bio_wait(&bio);
+	bio_uninit(&bio);
+	return ret;
 }
 
 /*
-- 
2.30.2

