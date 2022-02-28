Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C629C4C6A47
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiB1L0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiB1LZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:25:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8879470CFA;
        Mon, 28 Feb 2022 03:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=M2FO1C0E3y5wnThcaXaTdgam/uJGVxAboWlaGO6oosE=; b=S4v2IawSdiBSpSoN/k/1UbIn/i
        W4eBDaVi1G5nJGiUsqYrCHEh9Gj6a2td/l/hhLSP5IU3aXF0L71p0BqRFXIRYnzmHu+tNWXAGC1GQ
        VszWGxosBMBRwKSXmiUEgN/XvZJ5f7Flc7j3uUMqVrxGkYq6/dVbPOdEocz5CnJRDqLQihsAZ9NsD
        Y35ePQ0GfRWZXv9H5AHDr1V2tU82A2kEi6Qjl/CWISuYFAZOxMLLWfX7YmA7okYjS1C5HhhbgQP1h
        M83SY8onRybRwwy0CfzKGhlbETwY378VH2GFxQQEKn9yVsisnQ5LFM9I+mArlA/IcVvsvuTLmKHgn
        Tvar9Z7A==;
Received: from [2.53.163.181] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOe9X-00BqXa-IG; Mon, 28 Feb 2022 11:25:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] raid5: initialize the stripe_head embeeded bios as needed
Date:   Mon, 28 Feb 2022 13:25:03 +0200
Message-Id: <20220228112503.841449-5-hch@lst.de>
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

Use bio_init to initialize the bios when needed to the full state
instead of a partial initialization plus later setting of dev and op
and bio_reset.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8891aaba65964..8bd5f06390ea1 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1060,6 +1060,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 	int i, disks = sh->disks;
 	struct stripe_head *head_sh = sh;
 	struct bio_list pending_bios = BIO_EMPTY_LIST;
+	struct r5dev *dev;
 	bool should_defer;
 
 	might_sleep();
@@ -1094,8 +1095,9 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			op_flags |= REQ_SYNC;
 
 again:
-		bi = &sh->dev[i].req;
-		rbi = &sh->dev[i].rreq; /* For writing to replacement */
+		dev = &sh->dev[i];
+		bi = &dev->req;
+		rbi = &dev->rreq; /* For writing to replacement */
 
 		rcu_read_lock();
 		rrdev = rcu_dereference(conf->disks[i].replacement);
@@ -1171,8 +1173,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 
 			set_bit(STRIPE_IO_STARTED, &sh->state);
 
-			bio_set_dev(bi, rdev->bdev);
-			bio_set_op_attrs(bi, op, op_flags);
+			bio_init(bi, rdev->bdev, &dev->vec, 1, op | op_flags);
 			bi->bi_end_io = op_is_write(op)
 				? raid5_end_write_request
 				: raid5_end_read_request;
@@ -1238,8 +1239,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 
 			set_bit(STRIPE_IO_STARTED, &sh->state);
 
-			bio_set_dev(rbi, rrdev->bdev);
-			bio_set_op_attrs(rbi, op, op_flags);
+			bio_init(rbi, rrdev->bdev, &dev->rvec, 1, op | op_flags);
 			BUG_ON(!op_is_write(op));
 			rbi->bi_end_io = raid5_end_write_request;
 			rbi->bi_private = sh;
@@ -2294,7 +2294,6 @@ static struct stripe_head *alloc_stripe(struct kmem_cache *sc, gfp_t gfp,
 	int disks, struct r5conf *conf)
 {
 	struct stripe_head *sh;
-	int i;
 
 	sh = kmem_cache_zalloc(sc, gfp);
 	if (sh) {
@@ -2307,12 +2306,6 @@ static struct stripe_head *alloc_stripe(struct kmem_cache *sc, gfp_t gfp,
 		atomic_set(&sh->count, 1);
 		sh->raid_conf = conf;
 		sh->log_start = MaxSector;
-		for (i = 0; i < disks; i++) {
-			struct r5dev *dev = &sh->dev[i];
-
-			bio_init(&dev->req, NULL, &dev->vec, 1, 0);
-			bio_init(&dev->rreq, NULL, &dev->rvec, 1, 0);
-		}
 
 		if (raid5_has_ppl(conf)) {
 			sh->ppl_page = alloc_page(gfp);
@@ -2677,7 +2670,6 @@ static void raid5_end_read_request(struct bio * bi)
 		(unsigned long long)sh->sector, i, atomic_read(&sh->count),
 		bi->bi_status);
 	if (i == disks) {
-		bio_reset(bi, NULL, 0);
 		BUG();
 		return;
 	}
@@ -2785,7 +2777,7 @@ static void raid5_end_read_request(struct bio * bi)
 		}
 	}
 	rdev_dec_pending(rdev, conf->mddev);
-	bio_reset(bi, NULL, 0);
+	bio_uninit(bi);
 	clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
 	raid5_release_stripe(sh);
@@ -2823,7 +2815,6 @@ static void raid5_end_write_request(struct bio *bi)
 		(unsigned long long)sh->sector, i, atomic_read(&sh->count),
 		bi->bi_status);
 	if (i == disks) {
-		bio_reset(bi, NULL, 0);
 		BUG();
 		return;
 	}
@@ -2860,7 +2851,7 @@ static void raid5_end_write_request(struct bio *bi)
 	if (sh->batch_head && bi->bi_status && !replacement)
 		set_bit(STRIPE_BATCH_ERR, &sh->batch_head->state);
 
-	bio_reset(bi, NULL, 0);
+	bio_uninit(bi);
 	if (!test_and_clear_bit(R5_DOUBLE_LOCKED, &sh->dev[i].flags))
 		clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
-- 
2.30.2

