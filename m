Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FFC54D3F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349256AbiFOVsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349199AbiFOVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:48:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D8C31936
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:48:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A8FED21C78;
        Wed, 15 Jun 2022 21:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655329701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+AQQSlVk+fSJITgKnnsJ5wBaPXuhI3QTlk71W+lS3oc=;
        b=m+75E/r6wBapN8CETWbwyPqvABVKjUrOKzFg+pXI56Vk73Ob+DNU8Z+WfkWIx+YiImqoQg
        YXO1IMYIph0tjM0Zmr1FL34L69zbmVe53ih2+aSCY1LCxeE7GIEEHj5FcPC6VSnlzipjJT
        lhb5UU0Z6nZXsz0h5C0taAaZCY2DkKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655329701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+AQQSlVk+fSJITgKnnsJ5wBaPXuhI3QTlk71W+lS3oc=;
        b=UTvo1zeOPEy7YZAasBZv//49ZTZBekcWIXfCmsMhvGaCVCQBtJ4eYP+99ZypkezGZ6VEGe
        hi9fVCrr+NGq9wDQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7FEA52C141;
        Wed, 15 Jun 2022 21:48:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 488C5A062E; Wed, 15 Jun 2022 23:48:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mm@kvack.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] init: Initialize noop_backing_dev_info early
Date:   Wed, 15 Jun 2022 23:48:15 +0200
Message-Id: <20220615214815.6901-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017; h=from:subject; bh=CpJWbSIYFZYcag4s2az1UMRk8wDOxjizLqrAjKGRp3k=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqlOWxMUw9dJBYt29kpYriHaWIDduB7ePRtEiPYh7 ZIrpgjeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqpTlgAKCRCcnaoHP2RA2dcJCA Db4aB2N/z0lLRkbNukzUm1gEmycT/P+u2H//CdmC658dFoBqbuwjnDQNQu1Wks8ptiEw5Xxz65a7wA J19W2fqEKg/9Y1LcPS0XOWFMZyD41UOIFCbHHXOMIIqNvBSYLRAsD8cy79RFOIIk1N7SCE6niAgaGg vzVYwsiVv+S48UHU2fb7zAHl6/l4Wa5oUqORFegex4WlWA9dkknjFie0Q/86Xx+qpjBG2gzoYIWojI 0Adz1tI7PCdZrugOQKvVI1ccxnj1Tc6V3vLE2zhy5ww3zWKXgi8R3MQFy4VSx+s8bMLU1WgdwS4YrO Z5NtjdxG3AFRkvQppxvefq+ZrZM/jK
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

noop_backing_dev_info is used by superblocks of various
pseudofilesystems such as kdevtmpfs. After commit 10e14073107d
("writeback: Fix inode->i_io_list not be protected by inode->i_lock
error") this broke because __mark_inode_dirty() started to access more
fields from noop_backing_dev_info and this led to crashes inside
locked_inode_to_wb_and_lock_list() called from __mark_inode_dirty().
Fix the problem by initializing noop_backing_dev_info before the
filesystems get mounted.

Fixes: 10e14073107d ("writeback: Fix inode->i_io_list not be protected by inode->i_lock error")
Reported-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reported-and-tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/base/init.c         |  2 ++
 include/linux/backing-dev.h |  2 ++
 mm/backing-dev.c            | 11 ++---------
 3 files changed, 6 insertions(+), 9 deletions(-)

Since this bug prevents some machines from booting, I plan to push this patch
to Linus unless someone objects soon... Review is welcome :).

diff --git a/drivers/base/init.c b/drivers/base/init.c
index d8d0fe687111..397eb9880cec 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/memory.h>
 #include <linux/of.h>
+#include <linux/backing-dev.h>
 
 #include "base.h"
 
@@ -20,6 +21,7 @@
 void __init driver_init(void)
 {
 	/* These are the core pieces */
+	bdi_init(&noop_backing_dev_info);
 	devtmpfs_init();
 	devices_init();
 	buses_init();
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 2bd073fa6bb5..f0baef68f90f 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -119,6 +119,8 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
 
 extern struct backing_dev_info noop_backing_dev_info;
 
+extern int bdi_init(struct backing_dev_info *bdi);
+
 /**
  * writeback_in_progress - determine whether there is writeback in progress
  * @wb: bdi_writeback of interest
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index ff60bd7d74e0..95550b8fa7fe 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -231,20 +231,13 @@ static __init int bdi_class_init(void)
 }
 postcore_initcall(bdi_class_init);
 
-static int bdi_init(struct backing_dev_info *bdi);
-
 static int __init default_bdi_init(void)
 {
-	int err;
-
 	bdi_wq = alloc_workqueue("writeback", WQ_MEM_RECLAIM | WQ_UNBOUND |
 				 WQ_SYSFS, 0);
 	if (!bdi_wq)
 		return -ENOMEM;
-
-	err = bdi_init(&noop_backing_dev_info);
-
-	return err;
+	return 0;
 }
 subsys_initcall(default_bdi_init);
 
@@ -781,7 +774,7 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
-static int bdi_init(struct backing_dev_info *bdi)
+int bdi_init(struct backing_dev_info *bdi)
 {
 	int ret;
 
-- 
2.35.3

