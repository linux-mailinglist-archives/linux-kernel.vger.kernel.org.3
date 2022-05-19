Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F6852DD8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbiESTO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244388AbiESTNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:13:44 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A00AFB00;
        Thu, 19 May 2022 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=qJcjGji8b1vGgh3wix0mT+2g/2Wlq5dJpNiBhumcgiA=; b=XShqB5nL8uHseSVPPvVDtX0XsM
        JG798u+SWJm6jSTgvitz/rSUethocgCp2FxnFxtaWzEEu/6hlOq76pQJFcLjZ0MYM+OYd/kjvd1kg
        Doe1M3ThJsTgWBqq7Vy9FHqw7Z/mnPG3YdpDKgLR9BJI40spRHSGOaW0IC+4DFBfhjq8XvW8tWiPx
        liv4hO8hTVsbxUqv7BUkA8z07LvtjJEroWm+tztncITnS7ZBagUtq1quPwOawovWT/SYdZrOtIsqP
        Qn3xIIj0ENYOBdF0gkk76bkpmRO2osxv40xA064HAglyeDKTe+sAsL4Dui9mk0/S+XOKYlnIA38oC
        67lg+eGQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaM-002TqU-GW; Thu, 19 May 2022 13:13:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaD-0004TO-UC; Thu, 19 May 2022 13:13:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 19 May 2022 13:13:01 -0600
Message-Id: <20220519191311.17119-6-logang@deltatee.com>
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
Subject: [PATCH v1 05/15] md/raid5-cache: Refactor r5l_wake_reclaim() to take a struct r5conf
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All calls to r5l_wake_reclaim() have to dereference conf to get the
log. The log pointer should be protected by RCU, but isn't. Push
the dereference of conf->log into r5l_wake_reclaim() to reduce
the number of sites that dereference conf->log so this can be improved.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c | 41 +++++++++++++++++++++-------------------
 drivers/md/raid5-log.h   |  2 +-
 drivers/md/raid5.c       |  2 +-
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 6db8040fb01b..735666f9d793 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -325,7 +325,20 @@ void r5c_handle_cached_data_endio(struct r5conf *conf,
 	}
 }
 
-void r5l_wake_reclaim(struct r5l_log *log, sector_t space);
+static void __r5l_wake_reclaim(struct r5l_log *log, sector_t space)
+{
+	unsigned long target;
+	unsigned long new = (unsigned long)space; /* overflow in theory */
+
+	if (!log)
+		return;
+	do {
+		target = log->reclaim_target;
+		if (new < target)
+			return;
+	} while (cmpxchg(&log->reclaim_target, target, new) != target);
+	md_wakeup_thread(log->reclaim_thread);
+}
 
 /* Check whether we should flush some stripes to free up stripe cache */
 void r5c_check_stripe_cache_usage(struct r5conf *conf)
@@ -348,7 +361,7 @@ void r5c_check_stripe_cache_usage(struct r5conf *conf)
 	 */
 	if (total_cached > conf->min_nr_stripes * 1 / 2 ||
 	    atomic_read(&conf->empty_inactive_list_nr) > 0)
-		r5l_wake_reclaim(conf->log, 0);
+		__r5l_wake_reclaim(conf->log, 0);
 }
 
 /*
@@ -367,7 +380,7 @@ void r5c_check_cached_full_stripe(struct r5conf *conf)
 	if (atomic_read(&conf->r5c_cached_full_stripes) >=
 	    min(R5C_FULL_STRIPE_FLUSH_BATCH(conf),
 		conf->chunk_sectors >> RAID5_STRIPE_SHIFT(conf)))
-		r5l_wake_reclaim(conf->log, 0);
+		__r5l_wake_reclaim(conf->log, 0);
 }
 
 /*
@@ -443,7 +456,7 @@ static inline void r5c_update_log_state(struct r5l_log *log)
 		clear_bit(R5C_LOG_TIGHT, &conf->cache_state);
 
 	if (wake_reclaim)
-		r5l_wake_reclaim(log, 0);
+		__r5l_wake_reclaim(log, 0);
 }
 
 /*
@@ -1085,7 +1098,7 @@ int r5l_write_stripe(struct r5l_log *log, struct stripe_head *sh)
 
 	mutex_unlock(&log->io_mutex);
 	if (wake_reclaim)
-		r5l_wake_reclaim(log, reserve);
+		__r5l_wake_reclaim(log, reserve);
 	return 0;
 }
 
@@ -1237,7 +1250,7 @@ static void __r5l_stripe_write_finished(struct r5l_io_unit *io)
 
 	if (r5l_reclaimable_space(log) > log->max_free_space ||
 	    test_bit(R5C_LOG_TIGHT, &conf->cache_state))
-		r5l_wake_reclaim(log, 0);
+		__r5l_wake_reclaim(log, 0);
 
 	spin_unlock_irqrestore(&log->io_list_lock, flags);
 	wake_up(&log->iounit_wait);
@@ -1562,19 +1575,9 @@ static void r5l_reclaim_thread(struct md_thread *thread)
 	r5l_do_reclaim(log);
 }
 
-void r5l_wake_reclaim(struct r5l_log *log, sector_t space)
+void r5l_wake_reclaim(struct r5conf *conf, sector_t space)
 {
-	unsigned long target;
-	unsigned long new = (unsigned long)space; /* overflow in theory */
-
-	if (!log)
-		return;
-	do {
-		target = log->reclaim_target;
-		if (new < target)
-			return;
-	} while (cmpxchg(&log->reclaim_target, target, new) != target);
-	md_wakeup_thread(log->reclaim_thread);
+	__r5l_wake_reclaim(conf->log, space);
 }
 
 void r5l_quiesce(struct r5l_log *log, int quiesce)
@@ -1586,7 +1589,7 @@ void r5l_quiesce(struct r5l_log *log, int quiesce)
 		mddev = log->rdev->mddev;
 		wake_up(&mddev->sb_wait);
 		kthread_park(log->reclaim_thread->tsk);
-		r5l_wake_reclaim(log, MaxSector);
+		__r5l_wake_reclaim(log, MaxSector);
 		r5l_do_reclaim(log);
 	} else
 		kthread_unpark(log->reclaim_thread->tsk);
diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index ead541075528..3dd59dd4257f 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -18,7 +18,7 @@ void r5c_finish_stripe_write_out(struct r5conf *conf, struct stripe_head *sh,
 				 struct stripe_head_state *s);
 void r5c_release_extra_page(struct stripe_head *sh);
 void r5c_use_extra_page(struct stripe_head *sh);
-void r5l_wake_reclaim(struct r5l_log *log, sector_t space);
+void r5l_wake_reclaim(struct r5conf *conf, sector_t space);
 void r5c_handle_cached_data_endio(struct r5conf *conf,
 				  struct stripe_head *sh, int disks);
 int r5c_cache_data(struct r5l_log *log, struct stripe_head *sh);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 436be2a42cc1..09e768f2d32c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -742,7 +742,7 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 			if (!sh) {
 				set_bit(R5_INACTIVE_BLOCKED,
 					&conf->cache_state);
-				r5l_wake_reclaim(conf->log, 0);
+				r5l_wake_reclaim(conf, 0);
 				wait_event_lock_irq(
 					conf->wait_for_stripe,
 					!list_empty(conf->inactive_list + hash) &&
-- 
2.30.2

