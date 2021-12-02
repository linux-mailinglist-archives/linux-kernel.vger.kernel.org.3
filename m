Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEEB466ACE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348737AbhLBUTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:19:40 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:62491 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348698AbhLBUTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:19:31 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id ssUvmqRgBozlissUvmqm80; Thu, 02 Dec 2021 21:16:07 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 02 Dec 2021 21:16:07 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] xen-blkfront: Use the bitmap API when applicable
Date:   Thu,  2 Dec 2021 21:16:04 +0100
Message-Id: <d6f31db1d2542e1b4ba66d4cea80d3891678aa5a.1638476031.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
open-coded arithmetic in allocator arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Use 'bitmap_copy()' to avoid an explicit 'memcpy()'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1 --> v2: change another kfree into bitmap_free
---
 drivers/block/xen-blkfront.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 700c765a759a..69cf13608ce0 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -442,22 +442,20 @@ static int xlbd_reserve_minors(unsigned int minor, unsigned int nr)
 	if (end > nr_minors) {
 		unsigned long *bitmap, *old;
 
-		bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
-				 GFP_KERNEL);
+		bitmap = bitmap_zalloc(end, GFP_KERNEL);
 		if (bitmap == NULL)
 			return -ENOMEM;
 
 		spin_lock(&minor_lock);
 		if (end > nr_minors) {
 			old = minors;
-			memcpy(bitmap, minors,
-			       BITS_TO_LONGS(nr_minors) * sizeof(*bitmap));
+			bitmap_copy(bitmap, minors, nr_minors);
 			minors = bitmap;
 			nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;
 		} else
 			old = bitmap;
 		spin_unlock(&minor_lock);
-		kfree(old);
+		bitmap_free(old);
 	}
 
 	spin_lock(&minor_lock);
@@ -2610,7 +2608,7 @@ static void __exit xlblk_exit(void)
 
 	xenbus_unregister_driver(&blkfront_driver);
 	unregister_blkdev(XENVBD_MAJOR, DEV_NAME);
-	kfree(minors);
+	bitmap_free(minors);
 }
 module_exit(xlblk_exit);
 
-- 
2.30.2

