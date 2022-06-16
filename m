Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F954EA05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378338AbiFPTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377835AbiFPTT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:19:57 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA798563BC;
        Thu, 16 Jun 2022 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=+sFRsvcRJw5+XZa6wPRtbYNbke+bt1JLaoOmg4B6nNg=; b=ei86I8EjHZRTzA4R/BJ+vogoH5
        zEVvDNyXhKP+R2MkZHLDgyjBGm8DfVwFM0HXw5NwAyK/XhVeNhzTpsu0FwAD6aqhkXPK5ACs3YULP
        Wh0vLWlYcgF8pJtsvjTJpQnhbbRwWG5pVGhBUmXZW0tYIFgj+ZzlzZwVnR9b5YedJ8aLIM0lX2Hei
        g8OVXc06jmvzsUrBeH2m8t7D+dQPIu9sbdFpg3oKJoEKdp23a/HLHihtRBmbh8dk5aV4HNbBJG9Yp
        DbS6qD0qUV22CRc0QobuS8Dd5r+IXzt0L5EOhX9M5anUMGNa+SFOsdRGpzInZygq8/x21NxZZo2kY
        145YgRiQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v20-0092ii-OX; Thu, 16 Jun 2022 13:19:53 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1v-0006FM-G8; Thu, 16 Jun 2022 13:19:47 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 16 Jun 2022 13:19:36 -0600
Message-Id: <20220616191945.23935-7-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220616191945.23935-1-logang@deltatee.com>
References: <20220616191945.23935-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 06/15] md/raid5: Factor out helper from raid5_make_request() loop
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the inner loop of raid5_make_request() into it's own helper
called make_stripe_request().

The helper returns a number of statuses: SUCCESS, RETRY,
SCHEDULE_AND_RETRY and FAIL. This makes the code a bit easier to
understand and allows the SCHEDULE_AND_RETRY path to be made common.

A context structure is added to contain do_flush. It will be used
more in subsequent patches for state that needs to be kept
outside the loop.

No functional changes intended. This will be cleaned up further in
subsequent patches to untangle the gen_lock and do_prepare logic
further.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 231 ++++++++++++++++++++++++++-------------------
 1 file changed, 133 insertions(+), 98 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 1bbf87d15bc8..26ef292842de 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5786,17 +5786,139 @@ static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
 					  sector >= reshape_sector;
 }
 
+enum stripe_result {
+	STRIPE_SUCCESS = 0,
+	STRIPE_RETRY,
+	STRIPE_SCHEDULE_AND_RETRY,
+	STRIPE_FAIL,
+};
+
+struct stripe_request_ctx {
+	/* the request had REQ_PREFLUSH, cleared after the first stripe_head */
+	bool do_flush;
+};
+
+static enum stripe_result make_stripe_request(struct mddev *mddev,
+		struct r5conf *conf, struct stripe_request_ctx *ctx,
+		sector_t logical_sector, struct bio *bi, int seq)
+{
+	const int rw = bio_data_dir(bi);
+	enum stripe_result ret;
+	struct stripe_head *sh;
+	sector_t new_sector;
+	int previous = 0;
+	int dd_idx;
+
+	if (unlikely(conf->reshape_progress != MaxSector)) {
+		/*
+		 * Spinlock is needed as reshape_progress may be
+		 * 64bit on a 32bit platform, and so it might be
+		 * possible to see a half-updated value
+		 * Of course reshape_progress could change after
+		 * the lock is dropped, so once we get a reference
+		 * to the stripe that we think it is, we will have
+		 * to check again.
+		 */
+		spin_lock_irq(&conf->device_lock);
+		if (ahead_of_reshape(mddev, logical_sector,
+				     conf->reshape_progress)) {
+			previous = 1;
+		} else {
+			if (ahead_of_reshape(mddev, logical_sector,
+					     conf->reshape_safe)) {
+				spin_unlock_irq(&conf->device_lock);
+				return STRIPE_SCHEDULE_AND_RETRY;
+			}
+		}
+		spin_unlock_irq(&conf->device_lock);
+	}
+
+	new_sector = raid5_compute_sector(conf, logical_sector, previous,
+					  &dd_idx, NULL);
+	pr_debug("raid456: %s, sector %llu logical %llu\n", __func__,
+		 new_sector, logical_sector);
+
+	sh = raid5_get_active_stripe(conf, new_sector, previous,
+				     (bi->bi_opf & REQ_RAHEAD), 0);
+	if (unlikely(!sh)) {
+		/* cannot get stripe, just give-up */
+		bi->bi_status = BLK_STS_IOERR;
+		return STRIPE_FAIL;
+	}
+
+	if (unlikely(previous)) {
+		/*
+		 * Expansion might have moved on while waiting for a
+		 * stripe, so we must do the range check again.
+		 * Expansion could still move past after this
+		 * test, but as we are holding a reference to
+		 * 'sh', we know that if that happens,
+		 *  STRIPE_EXPANDING will get set and the expansion
+		 * won't proceed until we finish with the stripe.
+		 */
+		int must_retry = 0;
+		spin_lock_irq(&conf->device_lock);
+		if (!ahead_of_reshape(mddev, logical_sector,
+				      conf->reshape_progress))
+			/* mismatch, need to try again */
+			must_retry = 1;
+		spin_unlock_irq(&conf->device_lock);
+		if (must_retry) {
+			ret = STRIPE_SCHEDULE_AND_RETRY;
+			goto out_release;
+		}
+	}
+
+	if (read_seqcount_retry(&conf->gen_lock, seq)) {
+		/* Might have got the wrong stripe_head by accident */
+		ret = STRIPE_RETRY;
+		goto out_release;
+	}
+
+	if (test_bit(STRIPE_EXPANDING, &sh->state) ||
+	    !add_stripe_bio(sh, bi, dd_idx, rw, previous)) {
+		/*
+		 * Stripe is busy expanding or add failed due to
+		 * overlap. Flush everything and wait a while.
+		 */
+		md_wakeup_thread(mddev->thread);
+		ret = STRIPE_SCHEDULE_AND_RETRY;
+		goto out_release;
+	}
+
+	if (stripe_can_batch(sh))
+		stripe_add_to_batch_list(conf, sh);
+
+	if (ctx->do_flush) {
+		set_bit(STRIPE_R5C_PREFLUSH, &sh->state);
+		/* we only need flush for one stripe */
+		ctx->do_flush = false;
+	}
+
+	set_bit(STRIPE_HANDLE, &sh->state);
+	clear_bit(STRIPE_DELAYED, &sh->state);
+	if ((!sh->batch_head || sh == sh->batch_head) &&
+	    (bi->bi_opf & REQ_SYNC) &&
+	    !test_and_set_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
+		atomic_inc(&conf->preread_active_stripes);
+
+	release_stripe_plug(mddev, sh);
+	return STRIPE_SUCCESS;
+
+out_release:
+	raid5_release_stripe(sh);
+	return ret;
+}
+
 static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 {
 	struct r5conf *conf = mddev->private;
-	int dd_idx;
-	sector_t new_sector;
 	sector_t logical_sector, last_sector;
-	struct stripe_head *sh;
+	struct stripe_request_ctx ctx = {};
 	const int rw = bio_data_dir(bi);
+	enum stripe_result res;
 	DEFINE_WAIT(w);
 	bool do_prepare;
-	bool do_flush = false;
 
 	if (unlikely(bi->bi_opf & REQ_PREFLUSH)) {
 		int ret = log_handle_flush_request(conf, bi);
@@ -5812,7 +5934,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 		 * if r5l_handle_flush_request() didn't clear REQ_PREFLUSH,
 		 * we need to flush journal device
 		 */
-		do_flush = bi->bi_opf & REQ_PREFLUSH;
+		ctx.do_flush = bi->bi_opf & REQ_PREFLUSH;
 	}
 
 	if (!md_write_start(mddev, bi))
@@ -5852,117 +5974,30 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	md_account_bio(mddev, &bi);
 	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
 	for (; logical_sector < last_sector; logical_sector += RAID5_STRIPE_SECTORS(conf)) {
-		int previous;
 		int seq;
 
 		do_prepare = false;
 	retry:
 		seq = read_seqcount_begin(&conf->gen_lock);
-		previous = 0;
 		if (do_prepare)
 			prepare_to_wait(&conf->wait_for_overlap, &w,
 				TASK_UNINTERRUPTIBLE);
-		if (unlikely(conf->reshape_progress != MaxSector)) {
-			/* spinlock is needed as reshape_progress may be
-			 * 64bit on a 32bit platform, and so it might be
-			 * possible to see a half-updated value
-			 * Of course reshape_progress could change after
-			 * the lock is dropped, so once we get a reference
-			 * to the stripe that we think it is, we will have
-			 * to check again.
-			 */
-			spin_lock_irq(&conf->device_lock);
-			if (ahead_of_reshape(mddev, logical_sector,
-					     conf->reshape_progress)) {
-				previous = 1;
-			} else {
-				if (ahead_of_reshape(mddev, logical_sector,
-						     conf->reshape_safe)) {
-					spin_unlock_irq(&conf->device_lock);
-					schedule();
-					do_prepare = true;
-					goto retry;
-				}
-			}
-			spin_unlock_irq(&conf->device_lock);
-		}
-
-		new_sector = raid5_compute_sector(conf, logical_sector,
-						  previous,
-						  &dd_idx, NULL);
-		pr_debug("raid456: raid5_make_request, sector %llu logical %llu\n",
-			(unsigned long long)new_sector,
-			(unsigned long long)logical_sector);
 
-		sh = raid5_get_active_stripe(conf, new_sector, previous,
-				       (bi->bi_opf & REQ_RAHEAD), 0);
-		if (unlikely(!sh)) {
-			/* cannot get stripe, just give-up */
-			bi->bi_status = BLK_STS_IOERR;
+		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
+					  bi, seq);
+		if (res == STRIPE_FAIL)
 			break;
-		}
-
-		if (unlikely(previous)) {
-			/* expansion might have moved on while waiting for a
-			 * stripe, so we must do the range check again.
-			 * Expansion could still move past after this
-			 * test, but as we are holding a reference to
-			 * 'sh', we know that if that happens,
-			 *  STRIPE_EXPANDING will get set and the expansion
-			 * won't proceed until we finish with the stripe.
-			 */
-			int must_retry = 0;
-			spin_lock_irq(&conf->device_lock);
-			if (!ahead_of_reshape(mddev, logical_sector,
-					      conf->reshape_progress))
-				/* mismatch, need to try again */
-				must_retry = 1;
-			spin_unlock_irq(&conf->device_lock);
-			if (must_retry) {
-				raid5_release_stripe(sh);
-				schedule();
-				do_prepare = true;
-				goto retry;
-			}
-		}
 
-		if (read_seqcount_retry(&conf->gen_lock, seq)) {
-			/* Might have got the wrong stripe_head by accident */
-			raid5_release_stripe(sh);
+		if (res == STRIPE_RETRY)
 			goto retry;
-		}
 
-		if (test_bit(STRIPE_EXPANDING, &sh->state) ||
-		    !add_stripe_bio(sh, bi, dd_idx, rw, previous)) {
-			/*
-			 * Stripe is busy expanding or add failed due to
-			 * overlap. Flush everything and wait a while.
-			 */
-			md_wakeup_thread(mddev->thread);
-			raid5_release_stripe(sh);
+		if (res == STRIPE_SCHEDULE_AND_RETRY) {
 			schedule();
 			do_prepare = true;
 			goto retry;
 		}
-
-		if (stripe_can_batch(sh))
-			stripe_add_to_batch_list(conf, sh);
-
-		if (do_flush) {
-			set_bit(STRIPE_R5C_PREFLUSH, &sh->state);
-			/* we only need flush for one stripe */
-			do_flush = false;
-		}
-
-		set_bit(STRIPE_HANDLE, &sh->state);
-		clear_bit(STRIPE_DELAYED, &sh->state);
-		if ((!sh->batch_head || sh == sh->batch_head) &&
-		    (bi->bi_opf & REQ_SYNC) &&
-		    !test_and_set_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
-			atomic_inc(&conf->preread_active_stripes);
-
-		release_stripe_plug(mddev, sh);
 	}
+
 	finish_wait(&conf->wait_for_overlap, &w);
 
 	if (rw == WRITE)
-- 
2.30.2

