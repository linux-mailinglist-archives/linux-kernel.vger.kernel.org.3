Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEAE4DA10D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350525AbiCORXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350457AbiCORXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:23:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6636C583B8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:22:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e589b1f3c4so21973667b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zv11HNoiWOaRRTcqPWCnh8JAjyULAP9JPJTQwBFMsq8=;
        b=hdjiCLcdTxNnHZIaxKXevD6wYpO4tJh9hNr16sLmYoU8hjyEAcWwRvTquD+BH/awZT
         QLFX7uBm4fu+DPIzrGDgqlpefYngLQ9bEkwjiA0CLhYIE54t20c3UDQVZG4v0e099xN0
         Ei/r3R+uge9e6P7mnUO82X+e+KhGuDYDONXf56eiWG2tLERvhGurNdZkkhUXVr+751RA
         PTsQ2W47lyNo8NTp5PPpg5sfys0Wth1CJll3ZWrO7pEp2rg5ZzqbPRGT7a6gC3QIDPGx
         pYpYVbH36L9vQLQVJd0qLcDMi3ZksltTqaFU/Kwa/U28pkNhamkT2z8IQ098seipUSE6
         QzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zv11HNoiWOaRRTcqPWCnh8JAjyULAP9JPJTQwBFMsq8=;
        b=M7xixXDV5GQ/DmI8jBrS84/ngcColX5+KVV0qCdacutr3u8wcqBGNbMZQcflI9sE/g
         wS3N/DVOJxucW6x1WaZn3TbrWYTRBlaEFk2u8lwdv53GZEawr9LDNZsJA3QPXFkrzL19
         Qz5kfkmTT0PVOhTJgTSAqTQkNlfHDIvW3vqTz0mIvnjgH4ybdI+HSHvuXxWqUrTLWoog
         OJl9yB6Qk+WVLzA/dMK0GucVK274iDf+A/k5NW8VR3wqcX+q721Q7ZihpZlBHqbCjuiL
         gj0MJYk5OY9MFxB1sGdnbkwS/NyS3XqALXXHoBQlKS8QKpBsDMYYfnB4GzFlUaGzFaj/
         xD8w==
X-Gm-Message-State: AOAM5319lAVf3PZqYLKH1YI6bsIV1iz8sVRVXs/9pzLzf3mndXNp06m0
        vSLbpNenphLjinbfMXzD56m7RVMqgU8+
X-Google-Smtp-Source: ABdhPJywcoZma40GAuW6oHJQVBRIny/76kd1dbuidR6OYH4azzLPaSlrpAwem9MCflCBOgpSxDrnlhVoRxp+
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:213:25c1:7451:8743])
 (user=bgeffon job=sendgmr) by 2002:a25:dd03:0:b0:633:3cd1:8f1d with SMTP id
 u3-20020a25dd03000000b006333cd18f1dmr10363049ybg.617.1647364952603; Tue, 15
 Mar 2022 10:22:32 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:22:21 -0700
Message-Id: <20220315172221.9522-1-bgeffon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] zram: Add a huge_idle writeback mode
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today it's only possible to write back as a page, idle, or huge.
A user might want to writeback pages which are huge and idle first
as these idle pages do not require decompression and make a good
first pass for writeback.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 Documentation/admin-guide/blockdev/zram.rst |  6 ++++++
 drivers/block/zram/zram_drv.c               | 10 ++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 3e11926a4df9..af1123bfaf92 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -343,6 +343,12 @@ Admin can request writeback of those idle pages at right timing via::
 
 With the command, zram writeback idle pages from memory to the storage.
 
+Additionally, if a user choose to writeback only huge and idle pages
+this can be accomplished with::
+
+        echo huge_idle > /sys/block/zramX/writeback
+
+
 If admin want to write a specific page in zram device to backing device,
 they could write a page index into the interface.
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cb253d80d72b..f196902ae554 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -643,8 +643,8 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 #define PAGE_WB_SIG "page_index="
 
 #define PAGE_WRITEBACK 0
-#define HUGE_WRITEBACK 1
-#define IDLE_WRITEBACK 2
+#define HUGE_WRITEBACK (1<<0)
+#define IDLE_WRITEBACK (1<<1)
 
 
 static ssize_t writeback_store(struct device *dev,
@@ -664,6 +664,8 @@ static ssize_t writeback_store(struct device *dev,
 		mode = IDLE_WRITEBACK;
 	else if (sysfs_streq(buf, "huge"))
 		mode = HUGE_WRITEBACK;
+	else if (sysfs_streq(buf, "huge_idle"))
+		mode = IDLE_WRITEBACK | HUGE_WRITEBACK;
 	else {
 		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
 			return -EINVAL;
@@ -725,10 +727,10 @@ static ssize_t writeback_store(struct device *dev,
 				zram_test_flag(zram, index, ZRAM_UNDER_WB))
 			goto next;
 
-		if (mode == IDLE_WRITEBACK &&
+		if (mode & IDLE_WRITEBACK &&
 			  !zram_test_flag(zram, index, ZRAM_IDLE))
 			goto next;
-		if (mode == HUGE_WRITEBACK &&
+		if (mode & HUGE_WRITEBACK &&
 			  !zram_test_flag(zram, index, ZRAM_HUGE))
 			goto next;
 		/*
-- 
2.35.1.723.g4982287a31-goog

