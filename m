Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3E4E48BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiCVV75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiCVV7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:59:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DF8B849
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:58:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so15585936ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qCgb1rQ2NSk0/+tpvGzgIXhekPoKGmbH5RRhGZElgeQ=;
        b=AC4IZ0WRGywgszT2I5C1P7dkLhuWoxBlmhwDw53CtgGHdsX1XZuBCegossGZ4XTGVh
         6S4N4oQaQdhlMdrBCgGhf4lQ2pnJagMl/jGZztRvWWHTymvbJJJFcyQHhAndqjxSU3Wk
         fXrGZdl1QEPw7YKhm+mCPGOHOwyW2uHeZOQtvP+gyGxAXBXjzJtdTcL+0tE6ySD0c7P/
         8zdQ56X4s24Fz+wk+QFGQo/Z3kT50NzTGZjZ66ukn/OHGkR3IiwQZDXADaAJ1HcxiCt1
         vjA2m00j2/b1z8aBVM7zJbifXusEo/fG0mt3Lfj5NmfV4twBUoUpDVdv+deCPPlfE1j9
         IkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qCgb1rQ2NSk0/+tpvGzgIXhekPoKGmbH5RRhGZElgeQ=;
        b=0oODN+eassDHLISfj5+o2s1G9aA1ZmejP32jlXAauQNG/iVQLXzKO8eU/oouqgHnxO
         yLqJ2BqZs0ivYjvyrKi+QGvyTO6QpVTVTTngP1yPd7RQ0Qo0wcAR8eEQ8jPmRspHSWYx
         TF0YSrVePMbtbXtkmhjUuSK++mOFEcrZV0+AgbQd4VSe7izBqE9aURe+zshHxA+3+4KC
         lUDs6QpSmNIigYrhAyvRBvv581WtQ7tUhSrUJlXMhRYZC9N0Oi9sZsHMwvRrlmEu48Hp
         yOOGRegkIjkKAN1mFTsxJML8YS5dqNiRAtoncDTfSio81j3WVSOn3zBfVj7Dxy+GQPZz
         n2uw==
X-Gm-Message-State: AOAM532xGG2aXPbzjCvAIJld6sNGk4RT87zg4AvQVe3+Qm3cGnNVF+QE
        rtC8Vo3QfJ8JReDXqUwv0bA+ubVummKi
X-Google-Smtp-Source: ABdhPJyTdOXDPQvbHdvKPmPexGJUYUoBc9yHFZ2ap2avIfYjKIg2RKMrG2cddv1xdLke9d6CIuYnATU3Fcja
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:49:910f:4d0:9fd7])
 (user=bgeffon job=sendgmr) by 2002:a05:6902:c8:b0:633:ee0c:bca2 with SMTP id
 i8-20020a05690200c800b00633ee0cbca2mr14920563ybs.82.1647986305071; Tue, 22
 Mar 2022 14:58:25 -0700 (PDT)
Date:   Tue, 22 Mar 2022 14:58:21 -0700
In-Reply-To: <20220315172221.9522-1-bgeffon@google.com>
Message-Id: <20220322215821.1196994-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20220315172221.9522-1-bgeffon@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2] zram: Add a huge_idle writeback mode
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

Idle writeback specifically has the advantage that a refault is
unlikely given that the page has been swapped for some amount of
time without being refaulted.

Huge writeback has the advantage that you're guaranteed to get
the maximum benefit from a single page writeback, that is, you're
reclaiming one full page of memory. Pages which are compressed in
zram being written back result in some benefit which is always
less than a page size because of the fact that it was compressed.

The primary use of this is for minimizing refaults in situations
where the device has to be sensitive to storage endurance. On
ChromeOS we have devices with slow eMMC and repeated writes and
refaults can negatively affect performance and endurance.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  5 +++++
 drivers/block/zram/zram_drv.c               | 10 ++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 54fe63745ed8..c73b16930449 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -343,6 +343,11 @@ Admin can request writeback of those idle pages at right timing via::
 
 With the command, zram will writeback idle pages from memory to the storage.
 
+Additionally, if a user choose to writeback only huge and idle pages
+this can be accomplished with::
+
+        echo huge_idle > /sys/block/zramX/writeback
+
 If an admin wants to write a specific page in zram device to the backing device,
 they could write a page index into the interface.
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e9474b02012d..8562a7cce558 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -639,8 +639,8 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 #define PAGE_WB_SIG "page_index="
 
 #define PAGE_WRITEBACK 0
-#define HUGE_WRITEBACK 1
-#define IDLE_WRITEBACK 2
+#define HUGE_WRITEBACK (1<<0)
+#define IDLE_WRITEBACK (1<<1)
 
 
 static ssize_t writeback_store(struct device *dev,
@@ -660,6 +660,8 @@ static ssize_t writeback_store(struct device *dev,
 		mode = IDLE_WRITEBACK;
 	else if (sysfs_streq(buf, "huge"))
 		mode = HUGE_WRITEBACK;
+	else if (sysfs_streq(buf, "huge_idle"))
+		mode = IDLE_WRITEBACK | HUGE_WRITEBACK;
 	else {
 		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
 			return -EINVAL;
@@ -721,10 +723,10 @@ static ssize_t writeback_store(struct device *dev,
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
2.35.1.894.gb6a874cedc-goog

