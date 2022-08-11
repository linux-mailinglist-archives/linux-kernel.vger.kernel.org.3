Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040C65905AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiHKRTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbiHKRSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:18:36 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0093898CAB;
        Thu, 11 Aug 2022 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=fuQcA4wTu7Ik3nFh6Y2lAofauisNGRvSYDvbqZh8MJg=; b=oKjS/SbOkaux6Tj+N8qnWKW+7I
        f3KLbVYtGSw7PE9YbEb9Zqdt8b/thdZgewojF2G3jCgGTQwYqY3D6XYb8xbSCWEFCH9V/IxZe0SHG
        2CsGiLB8PQEGu6AYl8F6Ja6SFIo+bN3fXOPft3pNvKQDL7c9Suzgwr00ReVOJrl1T0zq3j8yDyyGe
        QtCsS/81k+53+7zjfA0PkEIIWPOQNQCZ88pm2SzA4D5PPDpjG9Lw9qOE6dkPU4a6cucALdJxmu6uk
        9Jv4ZVfMruMI20VcPh6Pepi0cR8H8y9X7rPINs17Z9htXDHzujcjJE6gCjygbNOxerpRFZ64UAisa
        UdYBzfMQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlJ-00EAyk-Rj; Thu, 11 Aug 2022 11:14:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlI-000cRG-8s; Thu, 11 Aug 2022 11:14:24 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 11 Aug 2022 11:14:16 -0600
Message-Id: <20220811171417.147697-5-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220811171417.147697-1-logang@deltatee.com>
References: <20220811171417.147697-1-logang@deltatee.com>
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
Subject: [PATCH 4/5] md/raid5: Cleanup prototype of raid5_get_active_stripe()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the three bools in the prototype of raid5_get_active_stripe()
and replace them with a flags parameter.

At the same time, drop the distinction with __raid5_get_active_stripe().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c |  3 ++-
 drivers/md/raid5.c       | 49 +++++++++++++++++++++-------------------
 drivers/md/raid5.h       | 12 +++++++++-
 3 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index f4e1cc1ece43..5e35a7321ded 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1923,7 +1923,8 @@ r5c_recovery_alloc_stripe(
 {
 	struct stripe_head *sh;
 
-	sh = raid5_get_active_stripe(conf, stripe_sect, 0, noblock, 0);
+	sh = raid5_get_active_stripe(conf, NULL, stripe_sect,
+				     noblock ? R5_GAS_NOBLOCK : 0);
 	if (!sh)
 		return NULL;  /* no more stripe available */
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 1288ef9e1571..7e7205bb40f1 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -800,19 +800,20 @@ static bool is_inactive_blocked(struct r5conf *conf, int hash)
 	return active < (conf->max_nr_stripes * 3 / 4);
 }
 
-static struct stripe_head *__raid5_get_active_stripe(struct r5conf *conf,
+struct stripe_head *raid5_get_active_stripe(struct r5conf *conf,
 		struct stripe_request_ctx *ctx, sector_t sector,
-		bool previous, bool noblock, bool noquiesce)
+		unsigned int flags)
 {
 	struct stripe_head *sh;
 	int hash = stripe_hash_locks_hash(conf, sector);
+	int previous = !!(flags & R5_GAS_PREVIOUS);
 
 	pr_debug("get_stripe, sector %llu\n", (unsigned long long)sector);
 
 	spin_lock_irq(conf->hash_locks + hash);
 
 	for (;;) {
-		if (!noquiesce && conf->quiesce) {
+		if (!(flags & R5_GAS_NOQUIESCE) && conf->quiesce) {
 			/*
 			 * Must release the reference to batch_last before
 			 * waiting, on quiesce, otherwise the batch_last will
@@ -848,7 +849,7 @@ static struct stripe_head *__raid5_get_active_stripe(struct r5conf *conf,
 				set_bit(R5_ALLOC_MORE, &conf->cache_state);
 		}
 
-		if (noblock)
+		if (flags & R5_GAS_NOBLOCK)
 			break;
 
 		set_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
@@ -863,13 +864,6 @@ static struct stripe_head *__raid5_get_active_stripe(struct r5conf *conf,
 	return sh;
 }
 
-struct stripe_head *raid5_get_active_stripe(struct r5conf *conf,
-		sector_t sector, bool previous, bool noblock, bool noquiesce)
-{
-	return __raid5_get_active_stripe(conf, NULL, sector, previous, noblock,
-					 noquiesce);
-}
-
 static bool is_full_stripe_write(struct stripe_head *sh)
 {
 	BUG_ON(sh->overwrite_disks > (sh->disks - sh->raid_conf->max_degraded));
@@ -4636,7 +4630,8 @@ static void handle_stripe_expansion(struct r5conf *conf, struct stripe_head *sh)
 			sector_t bn = raid5_compute_blocknr(sh, i, 1);
 			sector_t s = raid5_compute_sector(conf, bn, 0,
 							  &dd_idx, NULL);
-			sh2 = raid5_get_active_stripe(conf, s, 0, 1, 1);
+			sh2 = raid5_get_active_stripe(conf, NULL, s,
+				R5_GAS_NOBLOCK | R5_GAS_NOQUIESCE);
 			if (sh2 == NULL)
 				/* so far only the early blocks of this stripe
 				 * have been requested.  When later blocks
@@ -5273,7 +5268,9 @@ static void handle_stripe(struct stripe_head *sh)
 	/* Finish reconstruct operations initiated by the expansion process */
 	if (sh->reconstruct_state == reconstruct_state_result) {
 		struct stripe_head *sh_src
-			= raid5_get_active_stripe(conf, sh->sector, 1, 1, 1);
+			= raid5_get_active_stripe(conf, NULL, sh->sector,
+					R5_GAS_PREVIOUS | R5_GAS_NOBLOCK |
+					R5_GAS_NOQUIESCE);
 		if (sh_src && test_bit(STRIPE_EXPAND_SOURCE, &sh_src->state)) {
 			/* sh cannot be written until sh_src has been read.
 			 * so arrange for sh to be delayed a little
@@ -5823,7 +5820,7 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 		DEFINE_WAIT(w);
 		int d;
 	again:
-		sh = raid5_get_active_stripe(conf, logical_sector, 0, 0, 0);
+		sh = raid5_get_active_stripe(conf, NULL, logical_sector, 0);
 		prepare_to_wait(&conf->wait_for_overlap, &w,
 				TASK_UNINTERRUPTIBLE);
 		set_bit(R5_Overlap, &sh->dev[sh->pd_idx].flags);
@@ -5978,7 +5975,7 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 	enum stripe_result ret;
 	struct stripe_head *sh;
 	sector_t new_sector;
-	int previous = 0;
+	int previous = 0, flags = 0;
 	int seq, dd_idx;
 
 	seq = read_seqcount_begin(&conf->gen_lock);
@@ -6012,8 +6009,11 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 	pr_debug("raid456: %s, sector %llu logical %llu\n", __func__,
 		 new_sector, logical_sector);
 
-	sh = __raid5_get_active_stripe(conf, ctx, new_sector, previous,
-				       (bi->bi_opf & REQ_RAHEAD), 0);
+	if (previous)
+		flags |= R5_GAS_PREVIOUS;
+	if (bi->bi_opf & REQ_RAHEAD)
+		flags |= R5_GAS_NOBLOCK;
+	sh = raid5_get_active_stripe(conf, ctx, new_sector, flags);
 	if (unlikely(!sh)) {
 		/* cannot get stripe, just give-up */
 		bi->bi_status = BLK_STS_IOERR;
@@ -6362,7 +6362,8 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 	for (i = 0; i < reshape_sectors; i += RAID5_STRIPE_SECTORS(conf)) {
 		int j;
 		int skipped_disk = 0;
-		sh = raid5_get_active_stripe(conf, stripe_addr+i, 0, 0, 1);
+		sh = raid5_get_active_stripe(conf, NULL, stripe_addr+i,
+					     R5_GAS_NOQUIESCE);
 		set_bit(STRIPE_EXPANDING, &sh->state);
 		atomic_inc(&conf->reshape_stripes);
 		/* If any of this stripe is beyond the end of the old
@@ -6411,7 +6412,8 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 	if (last_sector >= mddev->dev_sectors)
 		last_sector = mddev->dev_sectors - 1;
 	while (first_sector <= last_sector) {
-		sh = raid5_get_active_stripe(conf, first_sector, 1, 0, 1);
+		sh = raid5_get_active_stripe(conf, NULL, first_sector,
+				R5_GAS_PREVIOUS | R5_GAS_NOQUIESCE);
 		set_bit(STRIPE_EXPAND_SOURCE, &sh->state);
 		set_bit(STRIPE_HANDLE, &sh->state);
 		raid5_release_stripe(sh);
@@ -6531,9 +6533,10 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 
 	md_bitmap_cond_end_sync(mddev->bitmap, sector_nr, false);
 
-	sh = raid5_get_active_stripe(conf, sector_nr, 0, 1, 0);
+	sh = raid5_get_active_stripe(conf, NULL, sector_nr,
+				     R5_GAS_NOBLOCK);
 	if (sh == NULL) {
-		sh = raid5_get_active_stripe(conf, sector_nr, 0, 0, 0);
+		sh = raid5_get_active_stripe(conf, NULL, sector_nr, 0);
 		/* make sure we don't swamp the stripe cache if someone else
 		 * is trying to get access
 		 */
@@ -6596,8 +6599,8 @@ static int  retry_aligned_read(struct r5conf *conf, struct bio *raid_bio,
 			/* already done this stripe */
 			continue;
 
-		sh = raid5_get_active_stripe(conf, sector, 0, 1, 1);
-
+		sh = raid5_get_active_stripe(conf, NULL, sector,
+				R5_GAS_NOBLOCK | R5_GAS_NOQUIESCE);
 		if (!sh) {
 			/* failed to get a stripe - must wait */
 			conf->retry_read_aligned = raid_bio;
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 4be2feb9e74a..e873938a6125 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -809,8 +809,18 @@ sector_t raid5_compute_blocknr(struct stripe_head *sh, int i, int previous);
 void raid5_release_stripe(struct stripe_head *sh);
 sector_t raid5_compute_sector(struct r5conf *conf, sector_t r_sector,
 		int previous, int *dd_idx, struct stripe_head *sh);
+
+struct stripe_request_ctx;
+/* get stripe from previous generation (when reshaping) */
+#define R5_GAS_PREVIOUS		(1 << 0)
+/* do not block waiting for a free stripe */
+#define R5_GAS_NOBLOCK		(1 << 1)
+/* do not block waiting for quiesce to be released */
+#define R5_GAS_NOQUIESCE	(1 << 2)
 struct stripe_head *raid5_get_active_stripe(struct r5conf *conf,
-		sector_t sector, bool previous, bool noblock, bool noquiesce);
+		struct stripe_request_ctx *ctx, sector_t sector,
+		unsigned int flags);
+
 int raid5_calc_degraded(struct r5conf *conf);
 int r5c_journal_mode_set(struct mddev *mddev, int journal_mode);
 #endif
-- 
2.30.2

