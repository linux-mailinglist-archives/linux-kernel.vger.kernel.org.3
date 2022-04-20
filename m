Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA05090DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381954AbiDTT6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381873AbiDTT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:57:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65714094;
        Wed, 20 Apr 2022 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=WhwSGYFZO9kGAfRzt28H/YYsFOtAZPiqsXGEK2+Lavw=; b=PDe+IeOmXMjlqqWIauzVVtEq4P
        JpZtRlG1zJBel2cyyo3kVX/zYDPFwxEO2HEQXvzN7OujO0QGDm1/DyojyzmodZmQn1rMT4yVeSSdK
        4j7VSmiEZmRKdQNAs2sk6bDUlDMPBn1/lwUikM5FbUV+5he8eIqgSvSe3BJRzOBGDRjvWmJ/cyvcb
        G2pTG0fixLageVeGDuxbhKP42yXQC8FHvbqeZcEXDKuot485oiXbi9d9OYoZdoTGSNre+ONLyOJZ8
        8OiTPmkNeHzlthGwlTb5J1i07zvWlV4lKZItBszBN4A16Yl0YUOh8w1fobcoALtWMYY4pfATTHI18
        MGeVgaig==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPq-00CRsI-R0; Wed, 20 Apr 2022 13:55:08 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPq-00096b-4k; Wed, 20 Apr 2022 13:55:06 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 20 Apr 2022 13:54:22 -0600
Message-Id: <20220420195425.34911-10-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420195425.34911-1-logang@deltatee.com>
References: <20220420195425.34911-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 09/12] md/raid5: Keep a reference to last stripe_head for batch
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
index 0c250cc3bfff..28ea7b9b6ab6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -843,7 +843,8 @@ static bool stripe_can_batch(struct stripe_head *sh)
 }
 
 /* we only do back search */
-static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh)
+static void stripe_add_to_batch_list(struct r5conf *conf,
+		struct stripe_head *sh, struct stripe_head *last_sh)
 {
 	struct stripe_head *head;
 	sector_t head_sector, tmp_sec;
@@ -856,15 +857,20 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 		return;
 	head_sector = sh->sector - RAID5_STRIPE_SECTORS(conf);
 
-	hash = stripe_hash_locks_hash(conf, head_sector);
-	spin_lock_irq(conf->hash_locks + hash);
-	head = find_get_stripe(conf, head_sector, conf->generation, hash);
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
+		head = find_get_stripe(conf, head_sector, conf->generation,
+				       hash);
+		spin_unlock_irq(conf->hash_locks + hash);
+		if (!head)
+			return;
+		if (!stripe_can_batch(head))
+			goto out;
+	}
 
 	lock_two_stripes(head, sh);
 	/* clear_batch_ready clear the flag */
@@ -5800,6 +5806,7 @@ enum stripe_result {
 
 struct stripe_request_ctx {
 	bool do_flush;
+	struct stripe_head *batch_last;
 };
 
 static enum stripe_result make_stripe_request(struct mddev *mddev,
@@ -5889,8 +5896,13 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 		return STRIPE_SCHEDULE_AND_RETRY;
 	}
 
-	if (stripe_can_batch(sh))
-		stripe_add_to_batch_list(conf, sh);
+	if (stripe_can_batch(sh)) {
+		stripe_add_to_batch_list(conf, sh, ctx->batch_last);
+		if (ctx->batch_last)
+			raid5_release_stripe(ctx->batch_last);
+		atomic_inc(&sh->count);
+		ctx->batch_last = sh;
+	}
 
 	if (ctx->do_flush) {
 		set_bit(STRIPE_R5C_PREFLUSH, &sh->state);
@@ -5979,6 +5991,18 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 		} else if (res == STRIPE_RETRY) {
 			continue;
 		} else if (res == STRIPE_SCHEDULE_AND_RETRY) {
+			/*
+			 * Must release the reference to batch_last before
+			 * scheduling and waiting for work to be done,
+			 * otherwise the batch_last stripe head could prevent
+			 * raid5_activate_delayed() from making progress
+			 * and thus deadlocking.
+			 */
+			if (ctx.batch_last) {
+				raid5_release_stripe(ctx.batch_last);
+				ctx.batch_last = NULL;
+			}
+
 			schedule();
 			prepare_to_wait(&conf->wait_for_overlap, &w,
 					TASK_UNINTERRUPTIBLE);
@@ -5990,6 +6014,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 
 	finish_wait(&conf->wait_for_overlap, &w);
 
+	if (ctx.batch_last)
+		raid5_release_stripe(ctx.batch_last);
+
 	if (rw == WRITE)
 		md_write_end(mddev);
 	bio_endio(bi);
-- 
2.30.2

