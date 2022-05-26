Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93F153523B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbiEZQhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348177AbiEZQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:36:33 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9395F3ED04;
        Thu, 26 May 2022 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=LVPA3vmvSA7P6Ad1y1+3/RRw2c624cA8sePqr/TnEdw=; b=f9jflO1yh9JgjMhbxeu7BjEpsG
        /V9H282fl47jauXwBDloKk90psGADmHwCxu28KuTSfnjQPl6I/lDSgp5WVkkL3EOcsi/lfIjA4HR7
        6fY7Jc8IWziqY1uMaIb2pWNBStgerHsH7fU+0o3ZQz24NthR/e/vCuhzwiy2S8Dhurx0TNFnY8V0u
        LhPIO+a1E2CWdJ8z2aXRXxjGTqmY65gzOvFoF6A0sJMxI3QdHqKTlZHHIHCLn6RR86G1th3X4uIIX
        MtQBe4Wf5OpWVXK/XWkgoyIjr4Kk44JlNPwZjC9k66FMENeneJsUh+8rBPzmtjeT23oN5sVxAK6op
        PQJk/FWA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTF-008A7T-C3; Thu, 26 May 2022 10:36:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTA-0008Xn-E1; Thu, 26 May 2022 10:36:16 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 26 May 2022 10:36:00 -0600
Message-Id: <20220526163604.32736-14-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526163604.32736-1-logang@deltatee.com>
References: <20220526163604.32736-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 13/17] md/raid5-cache: Add RCU protection to conf->log accesses
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mdadm test 21raid5cache randomly fails with NULL pointer accesses
of conf->log when run repeatedly. conf->log was sort of protected with
RCU, but most dereferences were not done with the correct functions.

Add rcu_read_locks(), rcu_dereference_protected() and rcu_access_pointers()
calls to the appropriate places and mark the pointer with __rcu.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c | 132 +++++++++++++++++++++++++++------------
 drivers/md/raid5-log.h   |  14 ++---
 drivers/md/raid5.c       |   4 +-
 drivers/md/raid5.h       |   2 +-
 4 files changed, 102 insertions(+), 50 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 6349cfaae2c8..7c56ee977c3a 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -180,7 +180,12 @@ static bool r5c_is_writeback(struct r5l_log *log)
 
 bool r5c_conf_is_writeback(struct r5conf *conf)
 {
-	return r5c_is_writeback(conf->log);
+	bool ret;
+
+	rcu_read_lock();
+	ret = r5c_is_writeback(rcu_dereference(conf->log));
+	rcu_read_unlock();
+	return ret;
 }
 
 static sector_t r5l_ring_add(struct r5l_log *log, sector_t start, sector_t inc)
@@ -266,12 +271,23 @@ static void __r5l_wake_reclaim(struct r5l_log *log, sector_t space)
 	md_wakeup_thread(log->reclaim_thread);
 }
 
+static struct r5l_log *get_log_for_io(struct r5conf *conf)
+{
+	/*
+	 * rcu_dereference_protected is safe because the array will be
+	 * quiesced before log_exit() so it can't be called while
+	 * an IO is in progress.
+	 */
+	return rcu_dereference_protected(conf->log, true);
+}
+
 /* Check whether we should flush some stripes to free up stripe cache */
 void r5c_check_stripe_cache_usage(struct r5conf *conf)
 {
+	struct r5l_log *log = get_log_for_io(conf);
 	int total_cached;
 
-	if (!r5c_is_writeback(conf->log))
+	if (!r5c_is_writeback(log))
 		return;
 
 	total_cached = atomic_read(&conf->r5c_cached_partial_stripes) +
@@ -287,7 +303,7 @@ void r5c_check_stripe_cache_usage(struct r5conf *conf)
 	 */
 	if (total_cached > conf->min_nr_stripes * 1 / 2 ||
 	    atomic_read(&conf->empty_inactive_list_nr) > 0)
-		__r5l_wake_reclaim(conf->log, 0);
+		__r5l_wake_reclaim(log, 0);
 }
 
 /*
@@ -296,7 +312,9 @@ void r5c_check_stripe_cache_usage(struct r5conf *conf)
  */
 void r5c_check_cached_full_stripe(struct r5conf *conf)
 {
-	if (!r5c_is_writeback(conf->log))
+	struct r5l_log *log = get_log_for_io(conf);
+
+	if (!r5c_is_writeback(log))
 		return;
 
 	/*
@@ -306,7 +324,7 @@ void r5c_check_cached_full_stripe(struct r5conf *conf)
 	if (atomic_read(&conf->r5c_cached_full_stripes) >=
 	    min(R5C_FULL_STRIPE_FLUSH_BATCH(conf),
 		conf->chunk_sectors >> RAID5_STRIPE_SHIFT(conf)))
-		__r5l_wake_reclaim(conf->log, 0);
+		__r5l_wake_reclaim(log, 0);
 }
 
 /*
@@ -388,7 +406,7 @@ static inline void r5c_update_log_state(struct r5l_log *log)
 void r5c_make_stripe_write_out(struct stripe_head *sh)
 {
 	struct r5conf *conf = sh->raid_conf;
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = get_log_for_io(conf);
 
 	BUG_ON(!r5c_is_writeback(log));
 
@@ -630,7 +648,7 @@ static void r5c_disable_writeback_async(struct work_struct *work)
 
 	/* wait superblock change before suspend */
 	wait_event(mddev->sb_wait,
-		   conf->log == NULL ||
+		   !rcu_access_pointer(conf->log) ||
 		   (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags) &&
 		    (locked = mddev_trylock(mddev))));
 	if (locked) {
@@ -928,7 +946,7 @@ static inline void r5l_add_no_space_stripe(struct r5l_log *log,
  */
 int r5l_write_stripe(struct r5conf *conf, struct stripe_head *sh)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = get_log_for_io(conf);
 	int write_disks = 0;
 	int data_pages, parity_pages;
 	int reserve;
@@ -1026,7 +1044,8 @@ int r5l_write_stripe(struct r5conf *conf, struct stripe_head *sh)
 
 void r5l_write_stripe_run(struct r5conf *conf)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = get_log_for_io(conf);
+
 	if (!log)
 		return;
 	mutex_lock(&log->io_mutex);
@@ -1036,7 +1055,7 @@ void r5l_write_stripe_run(struct r5conf *conf)
 
 int r5l_handle_flush_request(struct r5conf *conf, struct bio *bio)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = get_log_for_io(conf);
 
 	if (log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_THROUGH) {
 		/*
@@ -1224,7 +1243,7 @@ static void r5l_log_flush_endio(struct bio *bio)
  */
 void r5l_flush_stripe_to_raid(struct r5conf *conf)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = get_log_for_io(conf);
 	bool do_flush;
 
 	if (!log || !log->need_cache_flush)
@@ -1339,7 +1358,7 @@ void r5c_flush_cache(struct r5conf *conf, int num)
 	struct stripe_head *sh, *next;
 
 	lockdep_assert_held(&conf->device_lock);
-	if (!conf->log)
+	if (!rcu_access_pointer(conf->log))
 		return;
 
 	count = 0;
@@ -1358,9 +1377,8 @@ void r5c_flush_cache(struct r5conf *conf, int num)
 	}
 }
 
-static void r5c_do_reclaim(struct r5conf *conf)
+static void r5c_do_reclaim(struct r5conf *conf, struct r5l_log *log)
 {
-	struct r5l_log *log = conf->log;
 	struct stripe_head *sh;
 	int count = 0;
 	unsigned long flags;
@@ -1488,22 +1506,28 @@ static void r5l_reclaim_thread(struct md_thread *thread)
 {
 	struct mddev *mddev = thread->mddev;
 	struct r5conf *conf = mddev->private;
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log;
 
+	/*
+	 * This is safe, because the reclaim thread will be stopped before
+	 * the log is freed in log_exit()
+	 */
+	log = rcu_dereference_protected(conf->log, true);
 	if (!log)
 		return;
-	r5c_do_reclaim(conf);
+
+	r5c_do_reclaim(conf, log);
 	r5l_do_reclaim(log);
 }
 
 void r5l_wake_reclaim(struct r5conf *conf, sector_t space)
 {
-	__r5l_wake_reclaim(conf->log, space);
+	__r5l_wake_reclaim(get_log_for_io(conf), space);
 }
 
 void r5l_quiesce(struct r5conf *conf, int quiesce)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = get_log_for_io(conf);
 	struct mddev *mddev;
 
 	if (quiesce) {
@@ -2461,16 +2485,20 @@ static void r5l_write_super(struct r5l_log *log, sector_t cp)
 static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
 {
 	struct r5conf *conf;
-	int ret;
+	struct r5l_log *log;
+	int ret = 0;
 
 	spin_lock(&mddev->lock);
 	conf = mddev->private;
-	if (!conf || !conf->log) {
-		spin_unlock(&mddev->lock);
-		return 0;
-	}
+	if (!conf)
+		goto out_spin_unlock;
 
-	switch (conf->log->r5c_journal_mode) {
+	rcu_read_lock();
+	log = rcu_dereference(conf->log);
+	if (!log)
+		goto out;
+
+	switch (log->r5c_journal_mode) {
 	case R5C_JOURNAL_MODE_WRITE_THROUGH:
 		ret = snprintf(
 			page, PAGE_SIZE, "[%s] %s\n",
@@ -2486,6 +2514,10 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
 	default:
 		ret = 0;
 	}
+
+out:
+	rcu_read_unlock();
+out_spin_unlock:
 	spin_unlock(&mddev->lock);
 	return ret;
 }
@@ -2499,13 +2531,15 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
 int r5c_journal_mode_set(struct mddev *mddev, int mode)
 {
 	struct r5conf *conf;
+	struct r5l_log *log;
+	int ret = 0;
 
 	if (mode < R5C_JOURNAL_MODE_WRITE_THROUGH ||
 	    mode > R5C_JOURNAL_MODE_WRITE_BACK)
 		return -EINVAL;
 
 	conf = mddev->private;
-	if (!conf || !conf->log)
+	if (!conf || !rcu_access_pointer(conf->log))
 		return -ENODEV;
 
 	if (raid5_calc_degraded(conf) > 0 &&
@@ -2513,12 +2547,19 @@ int r5c_journal_mode_set(struct mddev *mddev, int mode)
 		return -EINVAL;
 
 	mddev_suspend(mddev);
-	conf->log->r5c_journal_mode = mode;
+	rcu_read_lock();
+	log = rcu_dereference(conf->log);
+	if (log) {
+		log->r5c_journal_mode = mode;
+		pr_debug("md/raid:%s: setting r5c cache mode to %d: %s\n",
+			 mdname(mddev), mode, r5c_journal_mode_str[mode]);
+	} else {
+		ret = -ENODEV;
+	}
+	rcu_read_unlock();
 	mddev_resume(mddev);
 
-	pr_debug("md/raid:%s: setting r5c cache mode to %d: %s\n",
-		 mdname(mddev), mode, r5c_journal_mode_str[mode]);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(r5c_journal_mode_set);
 
@@ -2564,7 +2605,7 @@ int r5c_try_caching_write(struct r5conf *conf,
 			  struct stripe_head_state *s,
 			  int disks)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = get_log_for_io(conf);
 	int i;
 	struct r5dev *dev;
 	int to_cache = 0;
@@ -2731,7 +2772,7 @@ void r5c_finish_stripe_write_out(struct r5conf *conf,
 				 struct stripe_head *sh,
 				 struct stripe_head_state *s)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = get_log_for_io(conf);
 	int i;
 	int do_wakeup = 0;
 	sector_t tree_index;
@@ -2814,7 +2855,7 @@ void r5c_finish_stripe_write_out(struct r5conf *conf,
 
 int r5c_cache_data(struct r5conf *conf, struct stripe_head *sh)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = get_log_for_io(conf);
 	int pages = 0;
 	int reserve;
 	int i;
@@ -2870,7 +2911,7 @@ int r5c_cache_data(struct r5conf *conf, struct stripe_head *sh)
 /* check whether this big stripe is in write back cache. */
 bool r5c_big_stripe_cached(struct r5conf *conf, sector_t sect)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log = get_log_for_io(conf);
 	sector_t tree_index;
 	void *slot;
 
@@ -2880,6 +2921,7 @@ bool r5c_big_stripe_cached(struct r5conf *conf, sector_t sect)
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	tree_index = r5c_tree_index(conf, sect);
 	slot = radix_tree_lookup(&log->big_stripe_tree, tree_index);
+
 	return slot != NULL;
 }
 
@@ -2960,30 +3002,38 @@ static int r5l_load_log(struct r5l_log *log)
 
 int r5l_start(struct r5conf *conf)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log;
 	int ret;
 
+	log = rcu_dereference_protected(conf->log,
+			lockdep_is_held(&conf->mddev->reconfig_mutex));
 	if (!log)
 		return 0;
 
 	ret = r5l_load_log(log);
 	if (ret)
 		r5l_exit_log(conf);
+
 	return ret;
 }
 
 void r5c_update_on_rdev_error(struct mddev *mddev, struct md_rdev *rdev)
 {
 	struct r5conf *conf = mddev->private;
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log;
 
+	rcu_read_lock();
+	log = rcu_dereference(conf->log);
 	if (!log)
-		return;
+		goto out;
 
 	if ((raid5_calc_degraded(conf) > 0 ||
 	     test_bit(Journal, &rdev->flags)) &&
-	    conf->log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_BACK)
+	    log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_BACK)
 		schedule_work(&log->disable_writeback_work);
+
+out:
+	rcu_read_unlock();
 }
 
 int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
@@ -3091,15 +3141,17 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 
 void r5l_exit_log(struct r5conf *conf)
 {
-	struct r5l_log *log = conf->log;
+	struct r5l_log *log;
 
-	conf->log = NULL;
-	synchronize_rcu();
+	lockdep_assert_held(&conf->mddev->reconfig_mutex);
+	log = rcu_replace_pointer(conf->log, NULL, 1);
 
 	/* Ensure disable_writeback_work wakes up and exits */
 	wake_up(&conf->mddev->sb_wait);
 	flush_work(&log->disable_writeback_work);
 	md_unregister_thread(&log->reclaim_thread);
+	synchronize_rcu();
+
 	mempool_exit(&log->meta_pool);
 	bioset_exit(&log->bs);
 	mempool_exit(&log->io_pool);
diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index 5948c41f1f2e..5b910e2d4279 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -133,7 +133,7 @@ static inline int log_stripe(struct stripe_head *sh, struct stripe_head_state *s
 {
 	struct r5conf *conf = sh->raid_conf;
 
-	if (conf->log) {
+	if (rcu_access_pointer(conf->log)) {
 		if (!test_bit(STRIPE_R5C_CACHING, &sh->state)) {
 			/* writing out phase */
 			if (s->waiting_extra_page)
@@ -154,7 +154,7 @@ static inline void log_stripe_write_finished(struct stripe_head *sh)
 {
 	struct r5conf *conf = sh->raid_conf;
 
-	if (conf->log)
+	if (rcu_access_pointer(conf->log))
 		r5l_stripe_write_finished(sh);
 	else if (raid5_has_ppl(conf))
 		ppl_stripe_write_finished(sh);
@@ -162,7 +162,7 @@ static inline void log_stripe_write_finished(struct stripe_head *sh)
 
 static inline void log_write_stripe_run(struct r5conf *conf)
 {
-	if (conf->log)
+	if (rcu_access_pointer(conf->log))
 		r5l_write_stripe_run(conf);
 	else if (raid5_has_ppl(conf))
 		ppl_write_stripe_run(conf);
@@ -170,7 +170,7 @@ static inline void log_write_stripe_run(struct r5conf *conf)
 
 static inline void log_flush_stripe_to_raid(struct r5conf *conf)
 {
-	if (conf->log)
+	if (rcu_access_pointer(conf->log))
 		r5l_flush_stripe_to_raid(conf);
 	else if (raid5_has_ppl(conf))
 		ppl_write_stripe_run(conf);
@@ -180,7 +180,7 @@ static inline int log_handle_flush_request(struct r5conf *conf, struct bio *bio)
 {
 	int ret = -ENODEV;
 
-	if (conf->log)
+	if (rcu_access_pointer(conf->log))
 		ret = r5l_handle_flush_request(conf, bio);
 	else if (raid5_has_ppl(conf))
 		ret = ppl_handle_flush_request(bio);
@@ -190,7 +190,7 @@ static inline int log_handle_flush_request(struct r5conf *conf, struct bio *bio)
 
 static inline void log_quiesce(struct r5conf *conf, int quiesce)
 {
-	if (conf->log)
+	if (rcu_access_pointer(conf->log))
 		r5l_quiesce(conf, quiesce);
 	else if (raid5_has_ppl(conf))
 		ppl_quiesce(conf, quiesce);
@@ -198,7 +198,7 @@ static inline void log_quiesce(struct r5conf *conf, int quiesce)
 
 static inline void log_exit(struct r5conf *conf)
 {
-	if (conf->log)
+	if (rcu_access_pointer(conf->log))
 		r5l_exit_log(conf);
 	else if (raid5_has_ppl(conf))
 		ppl_exit_log(conf);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4b25a0262cb5..93b4b69650bb 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7937,7 +7937,7 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct md_rdev *tmp;
 
 	print_raid5_conf(conf);
-	if (test_bit(Journal, &rdev->flags) && conf->log) {
+	if (test_bit(Journal, &rdev->flags) && rcu_access_pointer(conf->log)) {
 		mddev_suspend(mddev);
 		log_exit(conf);
 		mddev_resume(mddev);
@@ -8019,7 +8019,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 	int last = conf->raid_disks - 1;
 
 	if (test_bit(Journal, &rdev->flags)) {
-		if (conf->log)
+		if (rcu_access_pointer(conf->log))
 			return -EBUSY;
 
 		rdev->raid_disk = 0;
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 638d29863503..04fe5b6f679c 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -684,7 +684,7 @@ struct r5conf {
 	struct r5worker_group	*worker_groups;
 	int			group_cnt;
 	int			worker_cnt_per_group;
-	struct r5l_log		*log;
+	struct r5l_log		__rcu *log;
 	void			*log_private;
 
 	spinlock_t		pending_bios_lock;
-- 
2.30.2

