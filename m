Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4560952DD89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbiESTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbiESTNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:13:32 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8642AF31D;
        Thu, 19 May 2022 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=a1aXJViCfP7pAALseoHANcw2FqCsSQaT53V5yaoF6rw=; b=KpcEWmZvd6ntInu+6ekhtrEkfm
        oSt+4mGWkGaPEJkYCrSAgSLAV+02j1klsLEii1wQoGgwDPDEh/27uI6j40pRFYTxkmuCAZOq+fokJ
        r3ue/VOJdjFIpUnui9OznH345IoqtnqgGziZjNea5moa8ZbkVhP1dKENQZ99km4YT7GtWud6MBhbK
        uG7Jqre03oFdzjjooqDmBbeta8fzZlzWYrBhHKMIZm5Algui6JKtXJZkp2rlKD40koW50QYbxOJmu
        HvDOQQCT1A8zM37z+edu1L+oSS1yHTGP7Rhmh8CKcMLvGS64zt9KR5Kb9Joyeu6j6NR35IvhOXP9g
        deR+lqkg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaF-002TqS-7D; Thu, 19 May 2022 13:13:17 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaD-0004TE-Bb; Thu, 19 May 2022 13:13:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 19 May 2022 13:12:58 -0600
Message-Id: <20220519191311.17119-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519191311.17119-1-logang@deltatee.com>
References: <20220519191311.17119-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v1 02/15] md/raid5-cache: Refactor r5c_is_writeback() to take a struct r5conf
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most calls to r5c_is_writeback() have to dereference conf to get the
log. The log pointer should be protected by RCU, but isn't. Push
the dereference of conf->log into r5c_is_writeback() to reduce
the number of sites that dereference conf->log so this can be improved.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c | 25 ++++++++++++++-----------
 drivers/md/raid5-log.h   |  2 +-
 drivers/md/raid5.c       | 16 ++++++++--------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 83c184eddbda..241c271e836d 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -247,10 +247,14 @@ enum r5l_io_unit_state {
 	IO_UNIT_STRIPE_END = 3,	/* stripes data finished writing to raid */
 };
 
-bool r5c_is_writeback(struct r5l_log *log)
+static bool __r5c_is_writeback(struct r5l_log *log)
 {
-	return (log != NULL &&
-		log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_BACK);
+	return log && log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_BACK;
+}
+
+bool r5c_is_writeback(struct r5conf *conf)
+{
+	return __r5c_is_writeback(conf->log);
 }
 
 static sector_t r5l_ring_add(struct r5l_log *log, sector_t start, sector_t inc)
@@ -328,7 +332,7 @@ void r5c_check_stripe_cache_usage(struct r5conf *conf)
 {
 	int total_cached;
 
-	if (!r5c_is_writeback(conf->log))
+	if (!r5c_is_writeback(conf))
 		return;
 
 	total_cached = atomic_read(&conf->r5c_cached_partial_stripes) +
@@ -353,7 +357,7 @@ void r5c_check_stripe_cache_usage(struct r5conf *conf)
  */
 void r5c_check_cached_full_stripe(struct r5conf *conf)
 {
-	if (!r5c_is_writeback(conf->log))
+	if (!r5c_is_writeback(conf))
 		return;
 
 	/*
@@ -398,7 +402,7 @@ static sector_t r5c_log_required_to_flush_cache(struct r5conf *conf)
 {
 	struct r5l_log *log = conf->log;
 
-	if (!r5c_is_writeback(log))
+	if (!r5c_is_writeback(conf))
 		return 0;
 
 	return BLOCK_SECTORS *
@@ -420,7 +424,7 @@ static inline void r5c_update_log_state(struct r5l_log *log)
 	sector_t reclaim_space;
 	bool wake_reclaim = false;
 
-	if (!r5c_is_writeback(log))
+	if (!__r5c_is_writeback(log))
 		return;
 
 	free_space = r5l_ring_distance(log, log->log_start,
@@ -449,9 +453,8 @@ static inline void r5c_update_log_state(struct r5l_log *log)
 void r5c_make_stripe_write_out(struct stripe_head *sh)
 {
 	struct r5conf *conf = sh->raid_conf;
-	struct r5l_log *log = conf->log;
 
-	BUG_ON(!r5c_is_writeback(log));
+	BUG_ON(!r5c_is_writeback(conf));
 
 	WARN_ON(!test_bit(STRIPE_R5C_CACHING, &sh->state));
 	clear_bit(STRIPE_R5C_CACHING, &sh->state);
@@ -1429,7 +1432,7 @@ static void r5c_do_reclaim(struct r5conf *conf)
 	int stripes_to_flush;
 	int flushing_partial, flushing_full;
 
-	if (!r5c_is_writeback(log))
+	if (!r5c_is_writeback(conf))
 		return;
 
 	flushing_partial = atomic_read(&conf->r5c_flushing_partial_stripes);
@@ -2644,7 +2647,7 @@ int r5c_try_caching_write(struct r5conf *conf,
 	int ret;
 	uintptr_t refcount;
 
-	BUG_ON(!r5c_is_writeback(log));
+	BUG_ON(!__r5c_is_writeback(log));
 
 	if (!test_bit(STRIPE_R5C_CACHING, &sh->state)) {
 		/*
diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index 270ced4f770f..8a98b5e8c04b 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -11,7 +11,7 @@ void r5l_stripe_write_finished(struct stripe_head *sh);
 int r5l_handle_flush_request(struct r5l_log *log, struct bio *bio);
 void r5l_quiesce(struct r5l_log *log, int quiesce);
 bool r5l_log_disk_error(struct r5conf *conf);
-bool r5c_is_writeback(struct r5l_log *log);
+bool r5c_is_writeback(struct r5conf *conf);
 int r5c_try_caching_write(struct r5conf *conf, struct stripe_head *sh,
 			  struct stripe_head_state *s, int disks);
 void r5c_finish_stripe_write_out(struct r5conf *conf, struct stripe_head *sh,
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5d09256d7f81..bbc0e1101d0f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -224,7 +224,7 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 	BUG_ON(!list_empty(&sh->lru));
 	BUG_ON(atomic_read(&conf->active_stripes)==0);
 
-	if (r5c_is_writeback(conf->log))
+	if (r5c_is_writeback(conf))
 		for (i = sh->disks; i--; )
 			if (test_bit(R5_InJournal, &sh->dev[i].flags))
 				injournal++;
@@ -236,7 +236,7 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 	 *   2. when resync is requested fot the stripe.
 	 */
 	if (test_bit(STRIPE_SYNC_REQUESTED, &sh->state) ||
-	    (conf->quiesce && r5c_is_writeback(conf->log) &&
+	    (conf->quiesce && r5c_is_writeback(conf) &&
 	     !test_bit(STRIPE_HANDLE, &sh->state) && injournal != 0)) {
 		if (test_bit(STRIPE_R5C_CACHING, &sh->state))
 			r5c_make_stripe_write_out(sh);
@@ -274,7 +274,7 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 				md_wakeup_thread(conf->mddev->thread);
 		atomic_dec(&conf->active_stripes);
 		if (!test_bit(STRIPE_EXPANDING, &sh->state)) {
-			if (!r5c_is_writeback(conf->log))
+			if (!r5c_is_writeback(conf))
 				list_add_tail(&sh->lru, temp_inactive_list);
 			else {
 				WARN_ON(test_bit(R5_InJournal, &sh->dev[sh->pd_idx].flags));
@@ -1786,7 +1786,7 @@ static void ops_complete_prexor(void *stripe_head_ref)
 	pr_debug("%s: stripe %llu\n", __func__,
 		(unsigned long long)sh->sector);
 
-	if (r5c_is_writeback(sh->raid_conf->log))
+	if (r5c_is_writeback(sh->raid_conf))
 		/*
 		 * raid5-cache write back uses orig_page during prexor.
 		 * After prexor, it is time to free orig_page
@@ -1905,9 +1905,9 @@ ops_run_biodrain(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
 					tx = async_copy_data(1, wbi, &dev->page,
 							     dev->offset,
 							     dev->sector, tx, sh,
-							     r5c_is_writeback(conf->log));
+							     r5c_is_writeback(conf));
 					if (dev->page != dev->orig_page &&
-					    !r5c_is_writeback(conf->log)) {
+					    !r5c_is_writeback(conf)) {
 						set_bit(R5_SkipCopy, &dev->flags);
 						clear_bit(R5_UPTODATE, &dev->flags);
 						clear_bit(R5_OVERWRITE, &dev->flags);
@@ -5085,7 +5085,7 @@ static void handle_stripe(struct stripe_head *sh)
 	 */
 
 	if (!sh->reconstruct_state && !sh->check_state && !sh->log_io) {
-		if (!r5c_is_writeback(conf->log)) {
+		if (!r5c_is_writeback(conf)) {
 			if (s.to_write)
 				handle_stripe_dirtying(conf, sh, &s, disks);
 		} else { /* write back cache */
@@ -5533,7 +5533,7 @@ static struct stripe_head *__get_priority_stripe(struct r5conf *conf, int group)
 	struct stripe_head *sh, *tmp;
 	struct list_head *handle_list = NULL;
 	struct r5worker_group *wg;
-	bool second_try = !r5c_is_writeback(conf->log) &&
+	bool second_try = !r5c_is_writeback(conf) &&
 		!r5l_log_disk_error(conf);
 	bool try_loprio = test_bit(R5C_LOG_TIGHT, &conf->cache_state) ||
 		r5l_log_disk_error(conf);
-- 
2.30.2

