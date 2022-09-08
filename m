Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C125B1DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiIHMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiIHMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:50:50 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFB1D3468
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:50:46 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id y1-20020a056602200100b006893cd97da9so11184107iod.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=OSiiUGLRIfq+vepm0vqg84Qq4WC9cX3015kZoVtJjwg=;
        b=gbJnz91nFa8X8hyQY9FW+AgwwvnIVWCUcxMkw17/xoagEJskEH7QQffjscIGLy7K+k
         xEM7BpHOCLQdCcTo9Lt3hrlqiLG1TyAl7fisd/7vteGn6Sg6TDRKpUSxCsU8rzqP19Jf
         HHAgNApy8T5P/9ZgFsKcaF4aLhFTFxYz7zQGPq5uzY4tWxyd8AFkXXiBn5uAp+11m9xY
         rMPZHwrO9gAfytoyxPxGMSlgzPDbfrCqoli8VThT6uehfaIH13zUJ5SjlUo2O5HMPBBn
         cazOxcKvQ76eZw0uC7F+/QzrETcozsBQ9e9FK0cXivP64hlMtoz+TUrA8iV5VfIv5hwa
         05rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=OSiiUGLRIfq+vepm0vqg84Qq4WC9cX3015kZoVtJjwg=;
        b=j0hhu3HEGhrYwS6hKi5Y5CFeoH/ALreSt2dpvdc+CqMJ/gOdJMw6Fsg4uHYsgVqJXU
         efjap3pGgxRP6cX18bubUWoGP2zKbx3MvI5bMOO01hQCi+A9Vk0vQkWvEiDTn463du4a
         MoP0rMasL0x+LWlyzw6kn7FRL9XqvCc9T0WXy0dRhJQ5+IEZ1C9NDr3Mnu79R2+YYW+O
         ATfMBJ1QX4u7j6oUQtAXCJq+SPtK8mfUvqV2RIsnHNBth5TZdZ/yU/HxdXbNfKcbdBZc
         UaJWIW9fl1c3zbsAnpPj2mCY1X/vf7NeL7rXkSOI98SDYA2D3YrxLC1nC64NDOWPImJj
         FLmA==
X-Gm-Message-State: ACgBeo2s7ws53qDr6NETDKF0GBLYs+hk+bPU1P9q8iBW8XkP8oa6bvDW
        y1ftf+oG7cmqpUrWQWKWX3mUc7rZdcGf
X-Google-Smtp-Source: AA6agR7X+KJs9M4HnSlcOLkLN+1xwYYWCrghj/R6JFYtigKnJK9HFvI4gt87055ZlwBSe3CD58pGJcSnnsoT
X-Received: from bg.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b4])
 (user=bgeffon job=sendgmr) by 2002:a05:6638:dc5:b0:350:b314:5ab1 with SMTP id
 m5-20020a0566380dc500b00350b3145ab1mr5020117jaj.256.1662641446435; Thu, 08
 Sep 2022 05:50:46 -0700 (PDT)
Date:   Thu,  8 Sep 2022 08:50:37 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220908125037.1119114-1-bgeffon@google.com>
Subject: [RESEND RFC] zram: Allow rw_page when page isn't written back.
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Rom Lemarchand <romlem@google.com>, linux-mm@kvack.org,
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
still be performed as a synchronous rw. By the very nature of
zram all writes are synchronous so it's unfortunate to have to
accept this limitation.

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

This proposal is still very much RFC, feedback would be appreciated.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 drivers/block/zram/zram_drv.c | 68 +++++++++++++++++++++--------------
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 92cb929a45b7..22b69e8b6042 100644
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
@@ -309,7 +306,8 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 		 */
 		zram_slot_lock(zram, index);
 		if (zram_allocated(zram, index) &&
-				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
+				!zram_test_flag(zram, index, ZRAM_UNDER_WB) &&
+				!zram_test_flag(zram, index, ZRAM_NO_WB)) {
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 			is_idle = !cutoff || ktime_after(cutoff, zram->table[index].ac_time);
 #endif
@@ -439,7 +437,6 @@ static void reset_bdev(struct zram *zram)
 	filp_close(zram->backing_dev, NULL);
 	zram->backing_dev = NULL;
 	zram->bdev = NULL;
-	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
 }
@@ -543,17 +540,6 @@ static ssize_t backing_dev_store(struct device *dev,
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
@@ -722,7 +708,8 @@ static ssize_t writeback_store(struct device *dev,
 
 		if (zram_test_flag(zram, index, ZRAM_WB) ||
 				zram_test_flag(zram, index, ZRAM_SAME) ||
-				zram_test_flag(zram, index, ZRAM_UNDER_WB))
+				zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
+				zram_test_flag(zram, index, ZRAM_NO_WB))
 			goto next;
 
 		if (mode & IDLE_WRITEBACK &&
@@ -1226,6 +1213,10 @@ static void zram_free_page(struct zram *zram, size_t index)
 		goto out;
 	}
 
+	if (zram_test_flag(zram, index, ZRAM_NO_WB)) {
+		zram_clear_flag(zram, index, ZRAM_NO_WB);
+	}
+
 	/*
 	 * No memory is allocated for same element filled pages.
 	 * Simply clear same page flag.
@@ -1654,6 +1645,40 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
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
@@ -1827,15 +1852,6 @@ static const struct block_device_operations zram_devops = {
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
2.37.2.789.g6183377224-goog

