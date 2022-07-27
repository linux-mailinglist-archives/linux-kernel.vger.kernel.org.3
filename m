Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3C5834B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbiG0VJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbiG0VIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:08:36 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4D9664E9;
        Wed, 27 Jul 2022 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=GybQ1tw6aSCqyvxdAGuholV0PW9F5aoNumffRpM3f7A=; b=jCG+I/yxG+oDqZg6L9ScjODwtT
        JdPENCkRIfSQtVe94AbTWE4S0mXXmwUAtzpbI3hzDeeIba6yfnp+yrtcjab1NzMn0A2ifv/5uKj5D
        xt336YhrbnsjxsPYgjrqz+QCuRjYJqSjIwVYILOm9+a8D6y0f+/nJkwJYL495itUwgj4379gAV6UB
        URD0jfBRYYKnAHypRHSzcHn19rHQH1lD6eMBOLyin9aKx3e7F9zy+PAXgO7LOppo1DMhNbae1mAAZ
        Bfo8j0VuhL9l5bLaC8BYV1cf2HdQAel1wIwm4HzZMLsR7rGp9TeDKqFM2EhdUFxpkqtkQR45KAR2J
        2SORJqNw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oGoEH-001pyC-Bs; Wed, 27 Jul 2022 15:06:06 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oGoEF-000VI9-69; Wed, 27 Jul 2022 15:06:03 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 27 Jul 2022 15:06:00 -0600
Message-Id: <20220727210600.120221-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220727210600.120221-1-logang@deltatee.com>
References: <20220727210600.120221-1-logang@deltatee.com>
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
Subject: [PATCH 5/5] md/raid5: Ensure batch_last is released before sleeping for quiesce
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition exists where if raid5_quiesce() is called in the
middle of a request that has set batch_last, it will deadlock.

batch_last will hold a reference to a stripe when raid5_quiesce() is
called. This will cause the next raid5_get_active_stripe() call to
sleep waiting for the quiesce to finish, but the raid5_quiesce() thread
will wait for active_stripes to go to zero which will never happen
because request thread is waiting for the quiesce to stop.

Fix this by creating a special __raid5_get_active_stripe() function
which takes the request context and clears the last_batch before
sleeping.

While we're at it, change the arguments of raid5_get_active_stripe()
to bools.

Fixes: 4fcbd9abb6f2 ("md/raid5: Keep a reference to last stripe_head for batch")
Reported-by: David Sloan <David.Sloan@eideticom.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 36 ++++++++++++++++++++++++++++--------
 drivers/md/raid5.h |  2 +-
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0a8687fd1748..421bac221a74 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -800,9 +800,9 @@ static bool is_inactive_blocked(struct r5conf *conf, int hash)
 	return active < (conf->max_nr_stripes * 3 / 4);
 }
 
-struct stripe_head *
-raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
-			int previous, int noblock, int noquiesce)
+static struct stripe_head *__raid5_get_active_stripe(struct r5conf *conf,
+		struct stripe_request_ctx *ctx, sector_t sector,
+		bool previous, bool noblock, bool noquiesce)
 {
 	struct stripe_head *sh;
 	int hash = stripe_hash_locks_hash(conf, sector);
@@ -812,9 +812,22 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 	spin_lock_irq(conf->hash_locks + hash);
 
 retry:
-	wait_event_lock_irq(conf->wait_for_quiescent,
-			    conf->quiesce == 0 || noquiesce,
-			    *(conf->hash_locks + hash));
+	if (!noquiesce && conf->quiesce) {
+		/*
+		 * Must release the reference to batch_last before waiting,
+		 * on quiesce, otherwise the batch_last will hold a reference
+		 * to a stripe and raid5_quiesce() will deadlock waiting for
+		 * active_stripes to go to zero.
+		 */
+		if (ctx && ctx->batch_last) {
+			raid5_release_stripe(ctx->batch_last);
+			ctx->batch_last = NULL;
+		}
+
+		wait_event_lock_irq(conf->wait_for_quiescent, !conf->quiesce,
+				    *(conf->hash_locks + hash));
+	}
+
 	sh = find_get_stripe(conf, sector, conf->generation - previous, hash);
 	if (sh)
 		goto out;
@@ -850,6 +863,13 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 	return sh;
 }
 
+struct stripe_head *raid5_get_active_stripe(struct r5conf *conf,
+		sector_t sector, bool previous, bool noblock, bool noquiesce)
+{
+	return __raid5_get_active_stripe(conf, NULL, sector, previous, noblock,
+					 noquiesce);
+}
+
 static bool is_full_stripe_write(struct stripe_head *sh)
 {
 	BUG_ON(sh->overwrite_disks > (sh->disks - sh->raid_conf->max_degraded));
@@ -5992,8 +6012,8 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 	pr_debug("raid456: %s, sector %llu logical %llu\n", __func__,
 		 new_sector, logical_sector);
 
-	sh = raid5_get_active_stripe(conf, new_sector, previous,
-				     (bi->bi_opf & REQ_RAHEAD), 0);
+	sh = __raid5_get_active_stripe(conf, ctx, new_sector, previous,
+				       (bi->bi_opf & REQ_RAHEAD), 0);
 	if (unlikely(!sh)) {
 		/* cannot get stripe, just give-up */
 		bi->bi_status = BLK_STS_IOERR;
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 638d29863503..a5082bed83c8 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -812,7 +812,7 @@ extern sector_t raid5_compute_sector(struct r5conf *conf, sector_t r_sector,
 				     struct stripe_head *sh);
 extern struct stripe_head *
 raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
-			int previous, int noblock, int noquiesce);
+			bool previous, bool noblock, bool noquiesce);
 extern int raid5_calc_degraded(struct r5conf *conf);
 extern int r5c_journal_mode_set(struct mddev *mddev, int journal_mode);
 #endif
-- 
2.30.2

