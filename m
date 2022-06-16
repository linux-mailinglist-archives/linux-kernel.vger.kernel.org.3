Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7954EA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378297AbiFPTU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344222AbiFPTT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:19:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F7A562CB;
        Thu, 16 Jun 2022 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=3Uqcpcl0CPGmjy0b4vTBk8sx7NGeb3GvH+io4l8BPMQ=; b=ILiKayANW5q6goqHnKasqhbTej
        zarImsshAZ3Zop2+A7zmQGtEDDrdn7HVai36FWFTL/tA5N4SFomS8XUaMHseeHtBNg4M8nNN+Ysfq
        a68aSws0hSnh/4tlyeH7DVnN07G3V0KVQogZn78R2VCuGCYxO58HoUZYki1V/8BQhFkGpIu0RC9D6
        NRd0Tg2MWCGDyIQ6q8DPv2pWTCdVzbk9rWLKxU7waGN89Sb29dJIKzBMjZKtHzINh6EajdXSIiBhZ
        EYMwJYL4DeatNKovUwd81owHJWSOrFX+MHSFoRviQCL/N85ZVwC24HTuhzzMZF0urms7XPF6tJOGX
        anBl6psw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1y-0092il-Qu; Thu, 16 Jun 2022 13:19:51 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1v-0006FD-53; Thu, 16 Jun 2022 13:19:47 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 16 Jun 2022 13:19:33 -0600
Message-Id: <20220616191945.23935-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220616191945.23935-1-logang@deltatee.com>
References: <20220616191945.23935-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, hch@lst.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 03/15] md/raid5: Refactor raid5_make_request loop
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break immediately if raid5_get_active_stripe() returns NULL and deindent
the rest of the loop. Annotate this check with an unlikely().

This makes the code easier to read and reduces the indentation level.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/md/raid5.c | 109 +++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 6e53b8490fff..25db747c5856 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5901,68 +5901,69 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 
 		sh = raid5_get_active_stripe(conf, new_sector, previous,
 				       (bi->bi_opf & REQ_RAHEAD), 0);
-		if (sh) {
-			if (unlikely(previous)) {
-				/* expansion might have moved on while waiting for a
-				 * stripe, so we must do the range check again.
-				 * Expansion could still move past after this
-				 * test, but as we are holding a reference to
-				 * 'sh', we know that if that happens,
-				 *  STRIPE_EXPANDING will get set and the expansion
-				 * won't proceed until we finish with the stripe.
-				 */
-				int must_retry = 0;
-				spin_lock_irq(&conf->device_lock);
-				if (!ahead_of_reshape(mddev, logical_sector,
-						      conf->reshape_progress))
-					/* mismatch, need to try again */
-					must_retry = 1;
-				spin_unlock_irq(&conf->device_lock);
-				if (must_retry) {
-					raid5_release_stripe(sh);
-					schedule();
-					do_prepare = true;
-					goto retry;
-				}
-			}
-			if (read_seqcount_retry(&conf->gen_lock, seq)) {
-				/* Might have got the wrong stripe_head
-				 * by accident
-				 */
-				raid5_release_stripe(sh);
-				goto retry;
-			}
+		if (unlikely(!sh)) {
+			/* cannot get stripe, just give-up */
+			bi->bi_status = BLK_STS_IOERR;
+			break;
+		}
 
-			if (test_bit(STRIPE_EXPANDING, &sh->state) ||
-			    !add_stripe_bio(sh, bi, dd_idx, rw, previous)) {
-				/* Stripe is busy expanding or
-				 * add failed due to overlap.  Flush everything
-				 * and wait a while
-				 */
-				md_wakeup_thread(mddev->thread);
+		if (unlikely(previous)) {
+			/* expansion might have moved on while waiting for a
+			 * stripe, so we must do the range check again.
+			 * Expansion could still move past after this
+			 * test, but as we are holding a reference to
+			 * 'sh', we know that if that happens,
+			 *  STRIPE_EXPANDING will get set and the expansion
+			 * won't proceed until we finish with the stripe.
+			 */
+			int must_retry = 0;
+			spin_lock_irq(&conf->device_lock);
+			if (!ahead_of_reshape(mddev, logical_sector,
+					      conf->reshape_progress))
+				/* mismatch, need to try again */
+				must_retry = 1;
+			spin_unlock_irq(&conf->device_lock);
+			if (must_retry) {
 				raid5_release_stripe(sh);
 				schedule();
 				do_prepare = true;
 				goto retry;
 			}
-			if (do_flush) {
-				set_bit(STRIPE_R5C_PREFLUSH, &sh->state);
-				/* we only need flush for one stripe */
-				do_flush = false;
-			}
+		}
 
-			set_bit(STRIPE_HANDLE, &sh->state);
-			clear_bit(STRIPE_DELAYED, &sh->state);
-			if ((!sh->batch_head || sh == sh->batch_head) &&
-			    (bi->bi_opf & REQ_SYNC) &&
-			    !test_and_set_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
-				atomic_inc(&conf->preread_active_stripes);
-			release_stripe_plug(mddev, sh);
-		} else {
-			/* cannot get stripe for read-ahead, just give-up */
-			bi->bi_status = BLK_STS_IOERR;
-			break;
+		if (read_seqcount_retry(&conf->gen_lock, seq)) {
+			/* Might have got the wrong stripe_head by accident */
+			raid5_release_stripe(sh);
+			goto retry;
+		}
+
+		if (test_bit(STRIPE_EXPANDING, &sh->state) ||
+		    !add_stripe_bio(sh, bi, dd_idx, rw, previous)) {
+			/*
+			 * Stripe is busy expanding or add failed due to
+			 * overlap. Flush everything and wait a while.
+			 */
+			md_wakeup_thread(mddev->thread);
+			raid5_release_stripe(sh);
+			schedule();
+			do_prepare = true;
+			goto retry;
 		}
+
+		if (do_flush) {
+			set_bit(STRIPE_R5C_PREFLUSH, &sh->state);
+			/* we only need flush for one stripe */
+			do_flush = false;
+		}
+
+		set_bit(STRIPE_HANDLE, &sh->state);
+		clear_bit(STRIPE_DELAYED, &sh->state);
+		if ((!sh->batch_head || sh == sh->batch_head) &&
+		    (bi->bi_opf & REQ_SYNC) &&
+		    !test_and_set_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
+			atomic_inc(&conf->preread_active_stripes);
+
+		release_stripe_plug(mddev, sh);
 	}
 	finish_wait(&conf->wait_for_overlap, &w);
 
-- 
2.30.2

