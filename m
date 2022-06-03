Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6153CA33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244434AbiFCMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiFCMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:50:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384039691;
        Fri,  3 Jun 2022 05:50:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0317A68B05; Fri,  3 Jun 2022 14:49:56 +0200 (CEST)
Date:   Fri, 3 Jun 2022 14:49:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Schaller <misch@google.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New partition on loop device doesn't appear in /dev anymore
 with kernel 5.17.0 and newer (repro script included)
Message-ID: <20220603124956.GA18365@lst.de>
References: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You probably want this attached fix:

---
From b9684a71fca793213378dd410cd11675d973eaa1 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 27 May 2022 07:58:06 +0200
Subject: block, loop: support partitions without scanning

Historically we did distinguish between a flag that surpressed partition
scanning, and a combinations of the minors variable and another flag if
any partitions were supported.  This was generally confusing and doesn't
make much sense, but some corner case uses of the loop driver actually
do want to support manually added partitions on a device that does not
actively scan for partitions.  To make things worsee the loop driver
also wants to dynamically toggle the scanning for partitions on a live
gendisk, which makes the disk->flags updates non-atomic.

Introduce a new GD_SUPPRESS_PART_SCAN bit in disk->state that disables
just scanning for partitions, and toggle that instead of GENHD_FL_NO_PART
in the loop driver.

Fixes: 1ebe2e5f9d68 ("block: remove GENHD_FL_EXT_DEVT")
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20220527055806.1972352-1-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/genhd.c          | 2 ++
 drivers/block/loop.c   | 8 ++++----
 include/linux/blkdev.h | 1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 36532b9318419..27205ae47d593 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -385,6 +385,8 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 
 	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
 		return -EINVAL;
+	if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+		return -EINVAL;
 	if (disk->open_partitions)
 		return -EBUSY;
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 01b4e257016a1..121f96dfc23eb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1102,7 +1102,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	if (partscan)
-		lo->lo_disk->flags &= ~GENHD_FL_NO_PART;
+		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
 	loop_global_unlock(lo, is_loop);
 	if (partscan)
@@ -1198,7 +1198,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	 */
 	lo->lo_flags = 0;
 	if (!part_shift)
-		lo->lo_disk->flags |= GENHD_FL_NO_PART;
+		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
@@ -1308,7 +1308,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (!err && (lo->lo_flags & LO_FLAGS_PARTSCAN) &&
 	     !(prev_lo_flags & LO_FLAGS_PARTSCAN)) {
-		lo->lo_disk->flags &= ~GENHD_FL_NO_PART;
+		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 		partscan = true;
 	}
 out_unlock:
@@ -2009,7 +2009,7 @@ static int loop_add(int i)
 	 * userspace tools. Parameters like this in general should be avoided.
 	 */
 	if (!part_shift)
-		disk->flags |= GENHD_FL_NO_PART;
+		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 	mutex_init(&lo->lo_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index afad3d1d0dac0..691b4c15b8ce1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -147,6 +147,7 @@ struct gendisk {
 #define GD_DEAD				2
 #define GD_NATIVE_CAPACITY		3
 #define GD_ADDED			4
+#define GD_SUPPRESS_PART_SCAN		5
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
-- 
2.30.2

