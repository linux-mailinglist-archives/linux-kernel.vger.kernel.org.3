Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459A3543900
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245300AbiFHQ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbiFHQ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:28:07 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E2F1FE395;
        Wed,  8 Jun 2022 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=enIxJ5v9ACciSDcbKo4f77+u9p7j5hZmKDxT0M/PsFQ=; b=b26miDOrIqVWsruAmedFYfWHQl
        LF/Bp+qPAqA8KKdn9y9ywLycJrcpHIR3L8UilWGHJDbtVJPdlPObKTmO7sy4T9VKaUwkymibfXMNw
        0Av5p6R45I/QF8FBmIUAqGrMFJsqp9bA69WUFo9CI3UgFqp646JV017S/KE+kYETxyXOzm6HDTUaC
        AKvVe8rDRNuNjGVeEQXkDi2UhkQ0tL3U9bkqBcoQWRLYVzJ8VbB+y2FWd5/ET+puG4hnTeO3th9V+
        fpciXQODiuRH7DBDNpomW+fHRvO6Vijf//M/nDMN2w5hiecFPVFaflFeP9smms4LLbG4NRSTfMb12
        XYaWP0Mg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXM-0026n9-1K; Wed, 08 Jun 2022 10:28:04 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXH-000bdh-MG; Wed, 08 Jun 2022 10:27:59 -0600
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
Date:   Wed,  8 Jun 2022 10:27:54 -0600
Message-Id: <20220608162756.144600-10-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608162756.144600-1-logang@deltatee.com>
References: <20220608162756.144600-1-logang@deltatee.com>
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
Subject: [PATCH v4 09/11] md: Use enum for overloaded magic numbers used by mddev->curr_resync
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comments in the code document special values used for
mddev->curr_resync. Make this clearer by using an enum to label these
values.

The only functional change is a couple places use the wrong comparison
operator that implied 3 is another special value. They are all
fixed to imply that 3 or greater is an active resync.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 40 ++++++++++++++++++----------------------
 drivers/md/md.h | 15 +++++++++++++++
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5c8efef13881..42923832c077 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5001,7 +5001,7 @@ static ssize_t
 sync_speed_show(struct mddev *mddev, char *page)
 {
 	unsigned long resync, dt, db;
-	if (mddev->curr_resync == 0)
+	if (mddev->curr_resync == MD_RESYNC_NONE)
 		return sprintf(page, "none\n");
 	resync = mddev->curr_mark_cnt - atomic_read(&mddev->recovery_active);
 	dt = (jiffies - mddev->resync_mark) / HZ;
@@ -5020,8 +5020,8 @@ sync_completed_show(struct mddev *mddev, char *page)
 	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		return sprintf(page, "none\n");
 
-	if (mddev->curr_resync == 1 ||
-	    mddev->curr_resync == 2)
+	if (mddev->curr_resync == MD_RESYNC_YIELDED ||
+	    mddev->curr_resync == MD_RESYNC_DELAYED)
 		return sprintf(page, "delayed\n");
 
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||
@@ -8018,7 +8018,7 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 		max_sectors = mddev->dev_sectors;
 
 	resync = mddev->curr_resync;
-	if (resync <= 3) {
+	if (resync < MD_RESYNC_ACTIVE) {
 		if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
 			/* Still cleaning up */
 			resync = max_sectors;
@@ -8027,7 +8027,7 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 	else
 		resync -= atomic_read(&mddev->recovery_active);
 
-	if (resync == 0) {
+	if (resync == MD_RESYNC_NONE) {
 		if (test_bit(MD_RESYNCING_REMOTE, &mddev->recovery)) {
 			struct md_rdev *rdev;
 
@@ -8051,7 +8051,7 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 		}
 		return 0;
 	}
-	if (resync < 3) {
+	if (resync < MD_RESYNC_ACTIVE) {
 		seq_printf(seq, "\tresync=DELAYED");
 		return 1;
 	}
@@ -8729,13 +8729,7 @@ void md_do_sync(struct md_thread *thread)
 
 	mddev->last_sync_action = action ?: desc;
 
-	/* we overload curr_resync somewhat here.
-	 * 0 == not engaged in resync at all
-	 * 2 == checking that there is no conflict with another sync
-	 * 1 == like 2, but have yielded to allow conflicting resync to
-	 *		commence
-	 * other == active in resync - this many blocks
-	 *
+	/*
 	 * Before starting a resync we must have set curr_resync to
 	 * 2, and then checked that every "conflicting" array has curr_resync
 	 * less than ours.  When we find one that is the same or higher
@@ -8747,7 +8741,7 @@ void md_do_sync(struct md_thread *thread)
 
 	do {
 		int mddev2_minor = -1;
-		mddev->curr_resync = 2;
+		mddev->curr_resync = MD_RESYNC_DELAYED;
 
 	try_again:
 		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
@@ -8759,12 +8753,14 @@ void md_do_sync(struct md_thread *thread)
 			&&  mddev2->curr_resync
 			&&  match_mddev_units(mddev, mddev2)) {
 				DEFINE_WAIT(wq);
-				if (mddev < mddev2 && mddev->curr_resync == 2) {
+				if (mddev < mddev2 &&
+				    mddev->curr_resync == MD_RESYNC_DELAYED) {
 					/* arbitrarily yield */
-					mddev->curr_resync = 1;
+					mddev->curr_resync = MD_RESYNC_YIELDED;
 					wake_up(&resync_wait);
 				}
-				if (mddev > mddev2 && mddev->curr_resync == 1)
+				if (mddev > mddev2 &&
+				    mddev->curr_resync == MD_RESYNC_YIELDED)
 					/* no need to wait here, we can wait the next
 					 * time 'round when curr_resync == 2
 					 */
@@ -8792,7 +8788,7 @@ void md_do_sync(struct md_thread *thread)
 				finish_wait(&resync_wait, &wq);
 			}
 		}
-	} while (mddev->curr_resync < 2);
+	} while (mddev->curr_resync < MD_RESYNC_DELAYED);
 
 	j = 0;
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
@@ -8876,7 +8872,7 @@ void md_do_sync(struct md_thread *thread)
 			 desc, mdname(mddev));
 		mddev->curr_resync = j;
 	} else
-		mddev->curr_resync = 3; /* no longer delayed */
+		mddev->curr_resync = MD_RESYNC_ACTIVE; /* no longer delayed */
 	mddev->curr_resync_completed = j;
 	sysfs_notify_dirent_safe(mddev->sysfs_completed);
 	md_new_event();
@@ -9011,14 +9007,14 @@ void md_do_sync(struct md_thread *thread)
 
 	if (!test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 	    !test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
-	    mddev->curr_resync > 3) {
+	    mddev->curr_resync >= MD_RESYNC_ACTIVE) {
 		mddev->curr_resync_completed = mddev->curr_resync;
 		sysfs_notify_dirent_safe(mddev->sysfs_completed);
 	}
 	mddev->pers->sync_request(mddev, max_sectors, &skipped);
 
 	if (!test_bit(MD_RECOVERY_CHECK, &mddev->recovery) &&
-	    mddev->curr_resync > 3) {
+	    mddev->curr_resync >= MD_RESYNC_ACTIVE) {
 		if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
 			if (test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
 				if (mddev->curr_resync >= mddev->recovery_cp) {
@@ -9082,7 +9078,7 @@ void md_do_sync(struct md_thread *thread)
 	} else if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
 		mddev->resync_min = mddev->curr_resync_completed;
 	set_bit(MD_RECOVERY_DONE, &mddev->recovery);
-	mddev->curr_resync = 0;
+	mddev->curr_resync = MD_RESYNC_NONE;
 	spin_unlock(&mddev->lock);
 
 	wake_up(&resync_wait);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 82465a4b1588..2dcfff5572dd 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -288,6 +288,21 @@ struct serial_info {
 	sector_t _subtree_last; /* highest sector in subtree of rb node */
 };
 
+/*
+ * mddev->curr_resync stores the current sector of the resync but
+ * also has some overloaded values.
+ */
+enum {
+	/* No resync in progress */
+	MD_RESYNC_NONE = 0,
+	/* Yielded to allow another conflicting resync to commence */
+	MD_RESYNC_YIELDED = 1,
+	/* Delayed to check that there is no conflict with another sync */
+	MD_RESYNC_DELAYED = 2,
+	/* Any value greater than or equal to this is in an active resync */
+	MD_RESYNC_ACTIVE = 3,
+};
+
 struct mddev {
 	void				*private;
 	struct md_personality		*pers;
-- 
2.30.2

