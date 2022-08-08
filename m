Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06B58CC63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbiHHQu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbiHHQuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:50:23 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F12AEF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:50:22 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id x7-20020a056e021ca700b002ded2e6331aso7015617ill.20
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=tIPQjG73xQiPMfVUBLX5z8PtyeVm77aa6929Fogn3qM=;
        b=MK33El1PCNkQhQJ7eGi8AqQ6gyfIBwat67Qwx2MjQmCJBYL2+I02AWrwnn3ueNG0Po
         ev6efE+oTtGVUscNy59mozD0w4AncrOfQLYpXQr+1nC0neiKTO4qMn6ROXlagaqM49vk
         MUXC/bdkmEGxI5xQCMTCjihVYAL9u55yYPzawwG4vlWZbdTQRKKpcW2mB6yVPajOe0R8
         tgB145eBV2CT1wtec/uT4dyOtZWLIjUNFiYxrJoFx2G7JgdKqFxWMiB8efI1cZUWepRP
         7gmqd6qIq9RQYC8vhkDcKhEwWqEHtS4q+YWiLSLpEqcvw9NEpwA3wnIE8jDKlhtfmuZY
         fnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=tIPQjG73xQiPMfVUBLX5z8PtyeVm77aa6929Fogn3qM=;
        b=sfLXWzEeMjXc8IlwK0jnASI7ZGLUnAJ5AA73c+wFFqNM/4lWhp6/vK5QmevjgPDZYI
         C9QH/+sOrZ+To7F1ak26CxfEYZqp21ltBOPnr+ukGGTmc6YiUCd/7Eyg/gmbhhDsKEgZ
         S1ZtQuNZWmYw81hwWYbhGQWnT5vGCK1CL54mlM+q2Smptv+wQXOndkxl63espL3HdT1K
         mKORrkY9rw6hY4gSzNJ2Pj2y6AwpFcgqoH+90Vaf1gPv7r1seZCwDfeA6xL/5qz/qmRz
         nknq/OY5ktlWZoWTgcoDIMTs8VNVipqSWJFDkVGIv+bI+OWp5qN+teGNsoq7jFVNn6kw
         YS4w==
X-Gm-Message-State: ACgBeo24ROuaMX8EQZdP4xF3S13yJrGX88uFuaRXhWBehOjqefq5/F1r
        4D8hopfF6j/tUdFQw8AFTBkGS62pe4fw
X-Google-Smtp-Source: AA6agR6VGJ09aJj6UvCCvJiGaldCHiaKxH2Y9A0k69t5pjVVKSnoyGzcEsYlEpnplGeTD14Ox+AL74oum8sm
X-Received: from bg.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b4])
 (user=bgeffon job=sendgmr) by 2002:a05:6638:2685:b0:342:f09c:4dda with SMTP
 id o5-20020a056638268500b00342f09c4ddamr3509768jat.18.1659977421795; Mon, 08
 Aug 2022 09:50:21 -0700 (PDT)
Date:   Mon,  8 Aug 2022 12:50:06 -0400
In-Reply-To: <20220808165006.2451180-1-bgeffon@google.com>
Message-Id: <20220808165006.2451180-2-bgeffon@google.com>
Mime-Version: 1.0
References: <20220808165006.2451180-1-bgeffon@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [RFC PATCH 1/1] zram: Allow rw_page when page isn't written back.
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>
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

Today when a zram device has a backing device we change the ops to
a new set which does not expose a rw_page method. This prevents the
upper layers from trying to issue a synchronous rw. This has the
downside that we penalize every rw even when it could possibly
still be performed as a synchronous rw.

This change will always expose a rw_page function and if the page
has been written back it will return -EOPNOTSUPP which will force the
upper layers to try again with bio.

To safely allow a synchronous read to proceed for pages which have not
yet written back we introduce a new flag ZRAM_NO_WB. On the first
synchronous read if the page is not written back we will set the
ZRAM_NO_WB flag. This flag, which is never cleared, prevents writeback
from ever happening to that page.

This approach works because in the case of zram as a swap backing device
the page is going to be removed from zram shortly thereafter so
preventing writeback is fine. However, if zram is being used as a
generic block device then this might prevent writeback of the page.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 drivers/block/zram/zram_drv.c | 65 +++++++++++++++++++++--------------
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 92cb929a45b7..196392353bd3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -52,9 +52,6 @@ static unsigned int num_devices = 1;
 static size_t huge_class_size;
 
 static const struct block_device_operations zram_devops;
-#ifdef CONFIG_ZRAM_WRITEBACK
-static const struct block_device_operations zram_wb_devops;
-#endif
 
 static void zram_free_page(struct zram *zram, size_t index);
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
@@ -439,7 +436,6 @@ static void reset_bdev(struct zram *zram)
 	filp_close(zram->backing_dev, NULL);
 	zram->backing_dev = NULL;
 	zram->bdev = NULL;
-	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
 }
@@ -543,17 +539,6 @@ static ssize_t backing_dev_store(struct device *dev,
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
 	zram->nr_pages = nr_pages;
-	/*
-	 * With writeback feature, zram does asynchronous IO so it's no longer
-	 * synchronous device so let's remove synchronous io flag. Othewise,
-	 * upper layer(e.g., swap) could wait IO completion rather than
-	 * (submit and return), which will cause system sluggish.
-	 * Furthermore, when the IO function returns(e.g., swap_readpage),
-	 * upper layer expects IO was done so it could deallocate the page
-	 * freely but in fact, IO is going on so finally could cause
-	 * use-after-free when the IO is really done.
-	 */
-	zram->disk->fops = &zram_wb_devops;
 	up_write(&zram->init_lock);
 
 	pr_info("setup backing device %s\n", file_name);
@@ -722,7 +707,8 @@ static ssize_t writeback_store(struct device *dev,
 
 		if (zram_test_flag(zram, index, ZRAM_WB) ||
 				zram_test_flag(zram, index, ZRAM_SAME) ||
-				zram_test_flag(zram, index, ZRAM_UNDER_WB))
+				zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
+				zram_test_flag(zram, index, ZRAM_NO_WB))
 			goto next;
 
 		if (mode & IDLE_WRITEBACK &&
@@ -1226,6 +1212,10 @@ static void zram_free_page(struct zram *zram, size_t index)
 		goto out;
 	}
 
+	if (zram_test_flag(zram, index, ZRAM_NO_WB)) {
+		zram_clear_flag(zram, index, ZRAM_NO_WB);
+	}
+
 	/*
 	 * No memory is allocated for same element filled pages.
 	 * Simply clear same page flag.
@@ -1654,6 +1644,40 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
 	index = sector >> SECTORS_PER_PAGE_SHIFT;
 	offset = (sector & (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
 
+#ifdef CONFIG_ZRAM_WRITEBACK
+	/*
+	 * With writeback feature, zram does asynchronous IO so it's no longer
+	 * synchronous device so let's remove synchronous io flag. Othewise,
+	 * upper layer(e.g., swap) could wait IO completion rather than
+	 * (submit and return), which will cause system sluggish.
+	 * Furthermore, when the IO function returns(e.g., swap_readpage),
+	 * upper layer expects IO was done so it could deallocate the page
+	 * freely but in fact, IO is going on so finally could cause
+	 * use-after-free when the IO is really done.
+	 *
+	 * If the page is not currently written back then we may proceed to
+	 * read the page synchronously, otherwise, we must fail with
+	 * -EOPNOTSUPP to force the upper layers to use a normal bio.
+	 */
+	zram_slot_lock(zram, index);
+	if (zram_test_flag(zram, index, ZRAM_WB) ||
+			zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
+		zram_slot_unlock(zram, index);
+		/* We cannot proceed with synchronous read */
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Don't allow the page to be written back while we read it,
+	 * this flag is never cleared. It shouldn't be a problem that
+	 * we don't clear this flag because in the case of swap this
+	 * page will be removed shortly after this read anyway.
+	 */
+	if (op == REQ_OP_READ)
+		zram_set_flag(zram, index, ZRAM_NO_WB);
+	zram_slot_unlock(zram, index);
+#endif
+
 	bv.bv_page = page;
 	bv.bv_len = PAGE_SIZE;
 	bv.bv_offset = 0;
@@ -1827,15 +1851,6 @@ static const struct block_device_operations zram_devops = {
 	.owner = THIS_MODULE
 };
 
-#ifdef CONFIG_ZRAM_WRITEBACK
-static const struct block_device_operations zram_wb_devops = {
-	.open = zram_open,
-	.submit_bio = zram_submit_bio,
-	.swap_slot_free_notify = zram_slot_free_notify,
-	.owner = THIS_MODULE
-};
-#endif
-
 static DEVICE_ATTR_WO(compact);
 static DEVICE_ATTR_RW(disksize);
 static DEVICE_ATTR_RO(initstate);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 158c91e54850..20e4c6a579e0 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -50,6 +50,7 @@ enum zram_pageflags {
 	ZRAM_UNDER_WB,	/* page is under writeback */
 	ZRAM_HUGE,	/* Incompressible page */
 	ZRAM_IDLE,	/* not accessed page since last idle marking */
+	ZRAM_NO_WB,	/* Do not allow page to be written back */
 
 	__NR_ZRAM_PAGEFLAGS,
 };
-- 
2.37.1.559.g78731f0fdb-goog

