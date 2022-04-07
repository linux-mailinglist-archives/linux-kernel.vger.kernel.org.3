Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE14F85DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbiDGRYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346116AbiDGRYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:24:07 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD413F1B;
        Thu,  7 Apr 2022 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=FtZ6XZ4sLMZyp/6XFOcX1uRt8DKxESo3vxIZqbe3A+I=; b=GWVWJ5SQ4JmJ4oram3Y9E/GJ/w
        LUN+JrsZMttV4Qr5cPC8+rcGr5psvXVLf6XkYCMgLcBcrQ1KkgiW7B810RC7gI/rNFT65Avcn6fdA
        n6bKKZLddlpXhq4SB6IrstBlmjojZwEeOi2z8W9jzo/6mkKFTleJQWq8cwqCr8d3zofjpC4B9CKtc
        VecN1RE60Nlb4iyxdGuN0lo/P3PDgmrcaz8eipPt6TjkcaCHJFlpUWSHsF21vYjLZ3XYN0YDweRvT
        0M0ugKWNtpT2JcQvUvOsYF5c7FLPF0H19gaA1q28vFz7APXBJ/thiZUmXs8gK8dTMIQS6iTMJmKtI
        sT2zoc+g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG3-002CHm-Aj; Thu, 07 Apr 2022 10:45:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG0-0002Dn-Iy; Thu, 07 Apr 2022 10:45:16 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Shaohua Li <shli@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:45:08 -0600
Message-Id: <20220407164511.8472-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407164511.8472-1-logang@deltatee.com>
References: <20220407164511.8472-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, shli@kernel.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v1 5/8] md/raid5: Keep a reference to last stripe_head for batch
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When batching, every stripe head has to find the previous stripe head to
add to the batch list. This involves taking the hash lock which is
highly contended during IO.

Instead of finding the previous stripe_head each time, store a
reference to the previous stripe_head in a pointer so that it doesn't
require taking the contended lock another time.

The reference to the previous stripe must be released before scheduling
and waiting for work to get done. Otherwise, it can hold up
raid5_activate_delayed() and deadlock.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 51 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f963ffb35484..b852b6439898 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -815,7 +815,8 @@ static bool stripe_can_batch(struct stripe_head *sh)
 }
 
 /* we only do back search */
-static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh)
+static void stripe_add_to_batch_list(struct r5conf *conf,
+		struct stripe_head *sh, struct stripe_head *last_sh)
 {
 	struct stripe_head *head;
 	sector_t head_sector, tmp_sec;
@@ -828,15 +829,20 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 		return;
 	head_sector = sh->sector - RAID5_STRIPE_SECTORS(conf);
 
-	hash = stripe_hash_locks_hash(conf, head_sector);
-	spin_lock_irq(conf->hash_locks + hash);
-	head = __find_stripe(conf, head_sector, conf->generation, hash);
-	spin_unlock_irq(conf->hash_locks + hash);
-
-	if (!head)
-		return;
-	if (!stripe_can_batch(head))
-		goto out;
+	if (last_sh && head_sector == last_sh->sector) {
+		head = last_sh;
+		atomic_inc(&head->count);
+	} else {
+		hash = stripe_hash_locks_hash(conf, head_sector);
+		spin_lock_irq(conf->hash_locks + hash);
+		head = __find_stripe(conf, head_sector, conf->generation,
+				     hash);
+		spin_unlock_irq(conf->hash_locks + hash);
+		if (!head)
+			return;
+		if (!stripe_can_batch(head))
+			goto out;
+	}
 
 	lock_two_stripes(head, sh);
 	/* clear_batch_ready clear the flag */
@@ -5735,6 +5741,7 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 
 static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 {
+	struct stripe_head *batch_last = NULL;
 	struct r5conf *conf = mddev->private;
 	int dd_idx;
 	sector_t new_sector;
@@ -5885,8 +5892,13 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			goto schedule_and_retry;
 		}
 
-		if (stripe_can_batch(sh))
-			stripe_add_to_batch_list(conf, sh);
+		if (stripe_can_batch(sh)) {
+			stripe_add_to_batch_list(conf, sh, batch_last);
+			if (batch_last)
+				raid5_release_stripe(batch_last);
+			atomic_inc(&sh->count);
+			batch_last = sh;
+		}
 
 		if (do_flush) {
 			set_bit(STRIPE_R5C_PREFLUSH, &sh->state);
@@ -5905,6 +5917,18 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 		continue;
 
 schedule_and_retry:
+		/*
+		 * Must release the reference to batch_last before
+		 * scheduling and waiting for work to be done, otherwise
+		 * the batch_last stripe head could prevent
+		 * raid5_activate_delayed() from making progress
+		 * and thus deadlocking.
+		 */
+		if (batch_last) {
+			raid5_release_stripe(batch_last);
+			batch_last = NULL;
+		}
+
 		schedule();
 		prepare_to_wait(&conf->wait_for_overlap, &w,
 				TASK_UNINTERRUPTIBLE);
@@ -5912,6 +5936,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	}
 	finish_wait(&conf->wait_for_overlap, &w);
 
+	if (batch_last)
+		raid5_release_stripe(batch_last);
+
 	if (rw == WRITE)
 		md_write_end(mddev);
 	bio_endio(bi);
-- 
2.30.2

