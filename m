Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7723B4F85D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbiDGRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346076AbiDGRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:23:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787213F16;
        Thu,  7 Apr 2022 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=aKEoBvf3MpywGH/zk0JIbq0R6s1oOUuIxCnmt/DU/to=; b=qVvUkxTcCMuJ1LxddexP9ltzA6
        uGj8NdwWHzpyNy0biEN9+fOoh5kJJQd7rZ/A5nNQUhbe/u3UL7AVClFiCWdjHC/n2/FjtUSK0dMHw
        8OG2WOShOeHtK1PAMfAXpPsO1b+Oy5Kod101dMzaoQbD8VXPe+J/XLv0+eKsUQ+nw6i4P5OFgYCao
        ycuVM1aQlQh6w5xkEYbJY+Q/f3QgU/oiHZ7LZoktKRDWHPdSHBrG9Iq1x2H5VC+0T2WShdd4+pemC
        V0/fDOD3+LywdNYJHBldnFI+BM1Xo7dhfK9OD3z3zNx5PpAqSxYr+cpFHoRyIPG8jFP8TbgkKT4F7
        29XDLdCQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRf-002CRh-KQ; Thu, 07 Apr 2022 10:57:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRf-0002Q7-5w; Thu, 07 Apr 2022 10:57:19 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:57:09 -0600
Message-Id: <20220407165713.9243-4-logang@deltatee.com>
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
Subject: [PATCH v1 3/7] md/raid5: Add __rcu annotation to struct disk_info
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdev and replacement are protected in some circumstances with
rcu_dereference and synchronize_rcu (in raid5_remove_disk()). However,
they were not annotated with __rcu so a sparse warning is emitted for
every rcu_dereference() call.

Add the __rcu annotation and fix up the initialization with
RCU_INIT_POINTER, all pointer modifications with rcu_assign_pointer(),
a few cases where the pointer value is tested with rcu_access_pointer()
and one case where READ_ONCE() is used instead of rcu_dereference(),
a case in print_raid5_conf() that should have rcu_dereference() and
rcu_read_[un]lock() calls.

Additional sparse issues will be fixed up in further commits.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 46 ++++++++++++++++++++++++++--------------------
 drivers/md/raid5.h |  3 ++-
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index c0e373a02d3a..4815f5351818 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6288,7 +6288,7 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 	 */
 	rcu_read_lock();
 	for (i = 0; i < conf->raid_disks; i++) {
-		struct md_rdev *rdev = READ_ONCE(conf->disks[i].rdev);
+		struct md_rdev *rdev = rcu_dereference(conf->disks[i].rdev);
 
 		if (rdev == NULL || test_bit(Faulty, &rdev->flags))
 			still_degraded = 1;
@@ -7320,11 +7320,11 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 		if (test_bit(Replacement, &rdev->flags)) {
 			if (disk->replacement)
 				goto abort;
-			disk->replacement = rdev;
+			RCU_INIT_POINTER(disk->replacement, rdev);
 		} else {
 			if (disk->rdev)
 				goto abort;
-			disk->rdev = rdev;
+			RCU_INIT_POINTER(disk->rdev, rdev);
 		}
 
 		if (test_bit(In_sync, &rdev->flags)) {
@@ -7631,11 +7631,11 @@ static int raid5_run(struct mddev *mddev)
 			rdev = conf->disks[i].replacement;
 			conf->disks[i].replacement = NULL;
 			clear_bit(Replacement, &rdev->flags);
-			conf->disks[i].rdev = rdev;
+			rcu_assign_pointer(conf->disks[i].rdev, rdev);
 		}
 		if (!rdev)
 			continue;
-		if (conf->disks[i].replacement &&
+		if (rcu_access_pointer(conf->disks[i].replacement) &&
 		    conf->reshape_progress != MaxSector) {
 			/* replacements and reshape simply do not mix. */
 			pr_warn("md: cannot handle concurrent replacement and reshape.\n");
@@ -7836,8 +7836,8 @@ static void raid5_status(struct seq_file *seq, struct mddev *mddev)
 
 static void print_raid5_conf (struct r5conf *conf)
 {
+	struct md_rdev *rdev;
 	int i;
-	struct disk_info *tmp;
 
 	pr_debug("RAID conf printout:\n");
 	if (!conf) {
@@ -7848,14 +7848,16 @@ static void print_raid5_conf (struct r5conf *conf)
 	       conf->raid_disks,
 	       conf->raid_disks - conf->mddev->degraded);
 
+	rcu_read_lock();
 	for (i = 0; i < conf->raid_disks; i++) {
 		char b[BDEVNAME_SIZE];
-		tmp = conf->disks + i;
-		if (tmp->rdev)
+		rdev = rcu_dereference(conf->disks[i].rdev);
+		if (rdev)
 			pr_debug(" disk %d, o:%d, dev:%s\n",
-			       i, !test_bit(Faulty, &tmp->rdev->flags),
-			       bdevname(tmp->rdev->bdev, b));
+			       i, !test_bit(Faulty, &rdev->flags),
+			       bdevname(rdev->bdev, b));
 	}
+	rcu_read_unlock();
 }
 
 static int raid5_spare_active(struct mddev *mddev)
@@ -7906,8 +7908,9 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct r5conf *conf = mddev->private;
 	int err = 0;
 	int number = rdev->raid_disk;
-	struct md_rdev **rdevp;
+	struct md_rdev __rcu **rdevp;
 	struct disk_info *p = conf->disks + number;
+	struct md_rdev *tmp;
 
 	print_raid5_conf(conf);
 	if (test_bit(Journal, &rdev->flags) && conf->log) {
@@ -7925,9 +7928,9 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 		log_exit(conf);
 		return 0;
 	}
-	if (rdev == p->rdev)
+	if (rdev == rcu_access_pointer(p->rdev))
 		rdevp = &p->rdev;
-	else if (rdev == p->replacement)
+	else if (rdev == rcu_access_pointer(p->replacement))
 		rdevp = &p->replacement;
 	else
 		return 0;
@@ -7947,7 +7950,8 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	if (!test_bit(Faulty, &rdev->flags) &&
 	    mddev->recovery_disabled != conf->recovery_disabled &&
 	    !has_failed(conf) &&
-	    (!p->replacement || p->replacement == rdev) &&
+	    (!rcu_access_pointer(p->replacement) ||
+	     rcu_access_pointer(p->replacement) == rdev) &&
 	    number < conf->raid_disks) {
 		err = -EBUSY;
 		goto abort;
@@ -7958,7 +7962,7 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 		if (atomic_read(&rdev->nr_pending)) {
 			/* lost the race, try later */
 			err = -EBUSY;
-			*rdevp = rdev;
+			rcu_assign_pointer(*rdevp, rdev);
 		}
 	}
 	if (!err) {
@@ -7966,17 +7970,19 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 		if (err)
 			goto abort;
 	}
-	if (p->replacement) {
+
+	tmp = rcu_access_pointer(p->replacement);
+	if (tmp) {
 		/* We must have just cleared 'rdev' */
-		p->rdev = p->replacement;
-		clear_bit(Replacement, &p->replacement->flags);
+		rcu_assign_pointer(p->rdev, tmp);
+		clear_bit(Replacement, &tmp->flags);
 		smp_mb(); /* Make sure other CPUs may see both as identical
 			   * but will never see neither - if they are careful
 			   */
-		p->replacement = NULL;
+		rcu_assign_pointer(p->replacement, NULL);
 
 		if (!err)
-			err = log_modify(conf, p->rdev, true);
+			err = log_modify(conf, tmp, true);
 	}
 
 	clear_bit(WantReplacement, &rdev->flags);
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 61bc2e1f1b4e..638d29863503 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -473,7 +473,8 @@ enum {
  */
 
 struct disk_info {
-	struct md_rdev	*rdev, *replacement;
+	struct md_rdev	__rcu *rdev;
+	struct md_rdev  __rcu *replacement;
 	struct page	*extra_page; /* extra page to use in prexor */
 };
 
-- 
2.30.2

