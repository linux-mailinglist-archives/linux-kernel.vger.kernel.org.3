Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976D94F85CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbiDGRYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346068AbiDGRXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:23:54 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B2025F6;
        Thu,  7 Apr 2022 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=dZhxBNVYkNdmeubh8z4rxDDO+YUbiSHwlMwD0uwOpJo=; b=dyvmiTvDvOJiFM/6xYqOE6F0U7
        Y4rLQmgIa48GLJBIarMMTfRqry5lQP49hTba7Irc8WOPtoxakDztBr7mjwtzHM1gZMT4sHEs6nf3l
        R7zv0D7KBRTcfXAssW741WeBgwKTuW1ntNPMmoCOV50yNQEXfQ2FURpiv0h7Dx4AMdtWPOeVqDaA3
        niqywLT6DVhSMQM3JNChMinxOekmiotuzZbKgJgzECJ/37ZSYAJKmMsOhrxSh/N+j/ccM33UwAp6r
        6HQFLGyDaMd/6Jm/OZHB+b7gUNmeCLliOyj/jF126Aer7cout9XnCZpPDqFlqqVDJSqtkUvlzRyk3
        Ip3S6CVA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRg-002CRg-Th; Thu, 07 Apr 2022 10:57:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRf-0002QD-GM; Thu, 07 Apr 2022 10:57:19 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:57:11 -0600
Message-Id: <20220407165713.9243-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407165713.9243-1-logang@deltatee.com>
References: <20220407165713.9243-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, guoqing.jiang@linux.dev, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v1 5/7] md/raid5: Annotate rdev/replacement access when mddev_lock is held
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mddev_lock should be held during raid5_remove_disk() which is when
the rdev/replacement pointers are modified. So any access to these
pointers marked __rcu should be safe whenever the mddev_lock is held.

There are numerous such access that currently produce sparse warnings.
Add a helper function, rdev_mdlock_deref() that wraps
rcu_dereference_protected() in all these instances.

This annotation fixes a number of sparse warnings.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 65 ++++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0f29a2769cb3..fa955d23c88f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2658,6 +2658,18 @@ static struct md_rdev *rdev_pend_deref(struct md_rdev __rcu *rdev)
 			atomic_read(&rcu_access_pointer(rdev)->nr_pending));
 }
 
+/*
+ * This helper wraps rcu_dereference_protected() and should be used
+ * when it is known that the mddev_lock() is held. This is safe
+ * seeing raid5_remove_disk() has the same lock held.
+ */
+static struct md_rdev *rdev_mdlock_deref(struct mddev *mddev,
+					 struct md_rdev __rcu *rdev)
+{
+	return rcu_dereference_protected(rdev,
+			lockdep_is_held(&mddev->reconfig_mutex));
+}
+
 static void raid5_end_read_request(struct bio * bi)
 {
 	struct stripe_head *sh = bi->bi_private;
@@ -7635,10 +7647,11 @@ static int raid5_run(struct mddev *mddev)
 
 	for (i = 0; i < conf->raid_disks && conf->previous_raid_disks;
 	     i++) {
-		rdev = conf->disks[i].rdev;
+		rdev = rdev_mdlock_deref(mddev, conf->disks[i].rdev);
 		if (!rdev && conf->disks[i].replacement) {
 			/* The replacement is all we have yet */
-			rdev = conf->disks[i].replacement;
+			rdev = rdev_mdlock_deref(mddev,
+						 conf->disks[i].replacement);
 			conf->disks[i].replacement = NULL;
 			clear_bit(Replacement, &rdev->flags);
 			rcu_assign_pointer(conf->disks[i].rdev, rdev);
@@ -7874,36 +7887,38 @@ static int raid5_spare_active(struct mddev *mddev)
 {
 	int i;
 	struct r5conf *conf = mddev->private;
-	struct disk_info *tmp;
+	struct md_rdev *rdev, *replacement;
 	int count = 0;
 	unsigned long flags;
 
 	for (i = 0; i < conf->raid_disks; i++) {
-		tmp = conf->disks + i;
-		if (tmp->replacement
-		    && tmp->replacement->recovery_offset == MaxSector
-		    && !test_bit(Faulty, &tmp->replacement->flags)
-		    && !test_and_set_bit(In_sync, &tmp->replacement->flags)) {
+		rdev = rdev_mdlock_deref(mddev, conf->disks[i].rdev);
+		replacement = rdev_mdlock_deref(mddev,
+						conf->disks[i].replacement);
+		if (replacement
+		    && replacement->recovery_offset == MaxSector
+		    && !test_bit(Faulty, &replacement->flags)
+		    && !test_and_set_bit(In_sync, &replacement->flags)) {
 			/* Replacement has just become active. */
-			if (!tmp->rdev
-			    || !test_and_clear_bit(In_sync, &tmp->rdev->flags))
+			if (!rdev
+			    || !test_and_clear_bit(In_sync, &rdev->flags))
 				count++;
-			if (tmp->rdev) {
+			if (rdev) {
 				/* Replaced device not technically faulty,
 				 * but we need to be sure it gets removed
 				 * and never re-added.
 				 */
-				set_bit(Faulty, &tmp->rdev->flags);
+				set_bit(Faulty, &rdev->flags);
 				sysfs_notify_dirent_safe(
-					tmp->rdev->sysfs_state);
+					rdev->sysfs_state);
 			}
-			sysfs_notify_dirent_safe(tmp->replacement->sysfs_state);
-		} else if (tmp->rdev
-		    && tmp->rdev->recovery_offset == MaxSector
-		    && !test_bit(Faulty, &tmp->rdev->flags)
-		    && !test_and_set_bit(In_sync, &tmp->rdev->flags)) {
+			sysfs_notify_dirent_safe(replacement->sysfs_state);
+		} else if (rdev
+		    && rdev->recovery_offset == MaxSector
+		    && !test_bit(Faulty, &rdev->flags)
+		    && !test_and_set_bit(In_sync, &rdev->flags)) {
 			count++;
-			sysfs_notify_dirent_safe(tmp->rdev->sysfs_state);
+			sysfs_notify_dirent_safe(rdev->sysfs_state);
 		}
 	}
 	spin_lock_irqsave(&conf->device_lock, flags);
@@ -7968,6 +7983,7 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	}
 	*rdevp = NULL;
 	if (!test_bit(RemoveSynchronized, &rdev->flags)) {
+		lockdep_assert_held(&mddev->reconfig_mutex);
 		synchronize_rcu();
 		if (atomic_read(&rdev->nr_pending)) {
 			/* lost the race, try later */
@@ -8008,6 +8024,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 	int ret, err = -EEXIST;
 	int disk;
 	struct disk_info *p;
+	struct md_rdev *tmp;
 	int first = 0;
 	int last = conf->raid_disks - 1;
 
@@ -8065,7 +8082,8 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 	}
 	for (disk = first; disk <= last; disk++) {
 		p = conf->disks + disk;
-		if (test_bit(WantReplacement, &p->rdev->flags) &&
+		tmp = rdev_mdlock_deref(mddev, p->rdev);
+		if (test_bit(WantReplacement, &tmp->flags) &&
 		    p->replacement == NULL) {
 			clear_bit(In_sync, &rdev->flags);
 			set_bit(Replacement, &rdev->flags);
@@ -8356,6 +8374,7 @@ static void end_reshape(struct r5conf *conf)
 static void raid5_finish_reshape(struct mddev *mddev)
 {
 	struct r5conf *conf = mddev->private;
+	struct md_rdev *rdev;
 
 	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
 
@@ -8367,10 +8386,12 @@ static void raid5_finish_reshape(struct mddev *mddev)
 			for (d = conf->raid_disks ;
 			     d < conf->raid_disks - mddev->delta_disks;
 			     d++) {
-				struct md_rdev *rdev = conf->disks[d].rdev;
+				rdev = rdev_mdlock_deref(mddev,
+							 conf->disks[d].rdev);
 				if (rdev)
 					clear_bit(In_sync, &rdev->flags);
-				rdev = conf->disks[d].replacement;
+				rdev = rdev_mdlock_deref(mddev,
+						conf->disks[d].replacement);
 				if (rdev)
 					clear_bit(In_sync, &rdev->flags);
 			}
-- 
2.30.2

