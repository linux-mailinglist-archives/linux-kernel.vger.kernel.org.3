Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03E7564AAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiGDACi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiGDACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:02:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5760F7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 17:02:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q82so296862pgq.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAgE+V0rSALvg9inKDX9+//WkKD5ATI4AmKS7cWLY8k=;
        b=E6GjjTxg94q/+ZvA3ip2j8YqwA4TDY2ZByIiK27XtCsaje4XbHPTMge/SEzbkklj+4
         +mKXikQhiK8a5mmiSdjvzoPTcTPMt6vJ4VeCNRLeVDZNUVFZUWsSGv6R1Hwo0rfAJgDm
         mw35vT6huuXo3+vxuqMIMg9J22uTWQSdiOgxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAgE+V0rSALvg9inKDX9+//WkKD5ATI4AmKS7cWLY8k=;
        b=XJEL0Ng03GRappnPOBCNdrah9YoXRP5VapXGPmJ+5ppolqsmJTsmEDW2pkPE5x4cLK
         pDoAtiNn+Tn0KvfrhX2dpSOA4kRTzmU/QgHVIfvAP1ul9zbjLbgUdAUzAe0RHBkbWrac
         kwNsMygM58UvvdsuvXJeNsaHTwv6yubv48j1FH4LfARuKHJrvZIToRmF8NhF2mbOW4+q
         LXTim+WIiQ8EyYW2Tnm8ONMKofpgYDI+KhP3ym+/iRdh12WDaWVZxnfYDq8SL8xudPWi
         mWZF8Tw4rCHewZOv5Nk2L1T4IZHCR/ULzRTo5L3T1tIOoj21u/IH74Ibw9W6SmJ3oObx
         QoNw==
X-Gm-Message-State: AJIora8eYbCAWX9be8YZJl6MsKwCJyKD2fDGc+XrPJm4QaNntK/aFdAI
        2pHI7Ct/YuyvRg+2Zm4tyetDQsKSC9NO6Q==
X-Google-Smtp-Source: AGRyM1vj/Wf+i2Kyez01+sGyo2tEE30kwi1fEOFVr33/MMC24hHpmX+psc0s+r9nx5gkX/GOay9gaA==
X-Received: by 2002:a05:6a00:2356:b0:525:4e88:f792 with SMTP id j22-20020a056a00235600b005254e88f792mr33544382pfj.34.1656892956289;
        Sun, 03 Jul 2022 17:02:36 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id 63-20020a621542000000b00525204224afsm20014171pfv.94.2022.07.03.17.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 17:02:36 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Brian Geffon <bgeffon@google.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dm: add message command to disallow device open
Date:   Mon,  4 Jul 2022 10:02:25 +1000
Message-Id: <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220704000225.345536-1-dlunev@chromium.org>
References: <20220704000225.345536-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A message can be passed to device mapper to prohibit open on a certain
mapped device. This makes possible to disallow userspace access to
raw swapped data if the system uses device mapper to encrypt it at rest.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
---

 drivers/md/dm-core.h          |  1 +
 drivers/md/dm-ioctl.c         | 10 ++++++++++
 drivers/md/dm.c               | 12 ++++++++++++
 drivers/md/dm.h               | 10 ++++++++++
 include/uapi/linux/dm-ioctl.h |  5 +++++
 5 files changed, 38 insertions(+)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 4277853c75351..37529b605b7c4 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -140,6 +140,7 @@ struct mapped_device {
 #define DMF_SUSPENDED_INTERNALLY 7
 #define DMF_POST_SUSPENDING 8
 #define DMF_EMULATE_ZONE_APPEND 9
+#define DMF_DISALLOW_OPEN 10
 
 void disable_discard(struct mapped_device *md);
 void disable_write_zeroes(struct mapped_device *md);
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 87310fceb0d86..e35d560aa2ff3 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -815,6 +815,9 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
 	if (dm_test_deferred_remove_flag(md))
 		param->flags |= DM_DEFERRED_REMOVE;
 
+	if (dm_test_disallow_open_flag(md))
+		param->flags |= DM_DISALLOWED_OPEN;
+
 	param->dev = huge_encode_dev(disk_devt(disk));
 
 	/*
@@ -1656,6 +1659,13 @@ static int message_for_md(struct mapped_device *md, unsigned argc, char **argv,
 		}
 		return dm_cancel_deferred_remove(md);
 	}
+	if (!strcasecmp(argv[0], "@disallow_open")) {
+		if (argc != 1) {
+			DMERR("Invalid arguments for @disallow_open");
+			return -EINVAL;
+		}
+		return dm_disallow_open(md);
+	}
 
 	r = dm_stats_message(md, argc, argv, result, maxlen);
 	if (r < 2)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 82957bd460e89..3e53d1bd40f0c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -327,6 +327,7 @@ static int dm_blk_open(struct block_device *bdev, fmode_t mode)
 		goto out;
 
 	if (test_bit(DMF_FREEING, &md->flags) ||
+	    test_bit(DMF_DISALLOW_OPEN, &md->flags) ||
 	    dm_deleting_md(md)) {
 		md = NULL;
 		goto out;
@@ -403,6 +404,12 @@ int dm_cancel_deferred_remove(struct mapped_device *md)
 	return r;
 }
 
+int dm_disallow_open(struct mapped_device *md)
+{
+	set_bit(DMF_DISALLOW_OPEN, &md->flags);
+	return 0;
+}
+
 static void do_deferred_remove(struct work_struct *w)
 {
 	dm_deferred_remove();
@@ -2883,6 +2890,11 @@ int dm_test_deferred_remove_flag(struct mapped_device *md)
 	return test_bit(DMF_DEFERRED_REMOVE, &md->flags);
 }
 
+int dm_test_disallow_open_flag(struct mapped_device *md)
+{
+	return test_bit(DMF_DISALLOW_OPEN, &md->flags);
+}
+
 int dm_suspended(struct dm_target *ti)
 {
 	return dm_suspended_md(ti->table->md);
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 9013dc1a7b002..da27f9dfe1413 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -163,6 +163,16 @@ int dm_test_deferred_remove_flag(struct mapped_device *md);
  */
 void dm_deferred_remove(void);
 
+/*
+ * Test if the device is openable.
+ */
+int dm_test_disallow_open_flag(struct mapped_device *md);
+
+/*
+ * Prevent new open request on the device.
+ */
+int dm_disallow_open(struct mapped_device *md);
+
 /*
  * The device-mapper can be driven through one of two interfaces;
  * ioctl or filesystem, depending which patch you have applied.
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index 2e9550fef90fa..3b4d12d09c005 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -382,4 +382,9 @@ enum {
  */
 #define DM_IMA_MEASUREMENT_FLAG	(1 << 19) /* In */
 
+/*
+ * If set, the device can not be opened.
+ */
+#define DM_DISALLOWED_OPEN	(1 << 20) /* Out */
+
 #endif				/* _LINUX_DM_IOCTL_H */
-- 
2.31.0

