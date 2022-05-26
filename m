Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF017535237
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbiEZQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348193AbiEZQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:36:37 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35484FC7B;
        Thu, 26 May 2022 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=pefqnAQAPzwF0QGui2ZmdTDHAKSVQx30Ff/PluyW8NI=; b=s/6M5aFEhwfoxrUb5VaYNZMBX2
        tS3ngVspS1/pZYA+3WaBs6E87Ivcs/UD+w/Ik1vEZRp4YqbORoSySkftV0/0hKOnU6G6KrQ7zqH1m
        BckEJB7hgiyJ/wg8Q+xpL2JWyN44/QuayvOCy+Zr7YlEEcJeD6smY2qfB0dZVG7lpvcPSenFXsgCm
        qEaf8ewHB7l53HxAVr3eGHhwoQcUntfpr7IY4eD1bTamoxQor0oj1yO3T6wIuE8Uiq/G7F+6BxKFb
        4xYlhCIFFycbUl56/JglWMy3Fbqvt5+Xs+rbzPpkQ6z2jud8C/ZKnmKoI2BABAxbKB3EYNZlLFqt6
        0xkk90IA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTH-008A7V-0y; Thu, 26 May 2022 10:36:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGT8-0008XI-Jf; Thu, 26 May 2022 10:36:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 26 May 2022 10:35:52 -0600
Message-Id: <20220526163604.32736-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526163604.32736-1-logang@deltatee.com>
References: <20220526163604.32736-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, hch@lst.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 05/17] md/raid5-cache: Refactor r5l_wake_reclaim() to take a struct r5conf
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-cache.c | 41 +++++++++++++++++++++-------------------
 drivers/md/raid5-log.h   |  2 +-
 drivers/md/raid5.c       |  2 +-
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index edff4e8d07dc..3427f95cb358 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -326,7 +326,20 @@ void r5c_handle_cached_data_endio(struct r5conf *conf,
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
@@ -349,7 +362,7 @@ void r5c_check_stripe_cache_usage(struct r5conf *conf)
 	 */
 	if (total_cached > conf->min_nr_stripes * 1 / 2 ||
 	    atomic_read(&conf->empty_inactive_list_nr) > 0)
-		r5l_wake_reclaim(conf->log, 0);
+		__r5l_wake_reclaim(conf->log, 0);
 }
 
 /*
@@ -368,7 +381,7 @@ void r5c_check_cached_full_stripe(struct r5conf *conf)
 	if (atomic_read(&conf->r5c_cached_full_stripes) >=
 	    min(R5C_FULL_STRIPE_FLUSH_BATCH(conf),
 		conf->chunk_sectors >> RAID5_STRIPE_SHIFT(conf)))
-		r5l_wake_reclaim(conf->log, 0);
+		__r5l_wake_reclaim(conf->log, 0);
 }
 
 /*
@@ -444,7 +457,7 @@ static inline void r5c_update_log_state(struct r5l_log *log)
 		clear_bit(R5C_LOG_TIGHT, &conf->cache_state);
 
 	if (wake_reclaim)
-		r5l_wake_reclaim(log, 0);
+		__r5l_wake_reclaim(log, 0);
 }
 
 /*
@@ -1087,7 +1100,7 @@ int r5l_write_stripe(struct r5l_log *log, struct stripe_head *sh)
 
 	mutex_unlock(&log->io_mutex);
 	if (wake_reclaim)
-		r5l_wake_reclaim(log, reserve);
+		__r5l_wake_reclaim(log, reserve);
 	return 0;
 }
 
@@ -1239,7 +1252,7 @@ static void __r5l_stripe_write_finished(struct r5l_io_unit *io)
 
 	if (r5l_reclaimable_space(log) > log->max_free_space ||
 	    test_bit(R5C_LOG_TIGHT, &conf->cache_state))
-		r5l_wake_reclaim(log, 0);
+		__r5l_wake_reclaim(log, 0);
 
 	spin_unlock_irqrestore(&log->io_list_lock, flags);
 	wake_up(&log->iounit_wait);
@@ -1564,19 +1577,9 @@ static void r5l_reclaim_thread(struct md_thread *thread)
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
@@ -1588,7 +1591,7 @@ void r5l_quiesce(struct r5l_log *log, int quiesce)
 		mddev = log->rdev->mddev;
 		wake_up(&mddev->sb_wait);
 		kthread_park(log->reclaim_thread->tsk);
-		r5l_wake_reclaim(log, MaxSector);
+		__r5l_wake_reclaim(log, MaxSector);
 		r5l_do_reclaim(log);
 	} else
 		kthread_unpark(log->reclaim_thread->tsk);
diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index 5ace25d11ea4..7594d2d80520 100644
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
index f1b55495de53..0d486f8aaf87 100644
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

