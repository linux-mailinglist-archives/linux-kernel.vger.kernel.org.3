Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00514E81AF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiCZOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiCZOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:52:28 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F732467EC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 07:50:51 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id Y7kdn2IzuxHdTY7kdnd4rD; Sat, 26 Mar 2022 15:50:49 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 26 Mar 2022 15:50:49 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Subject: [PATCH] block: Fix the maximum minor value is blk_alloc_ext_minor()
Date:   Sat, 26 Mar 2022 15:50:46 +0100
Message-Id: <cc17199798312406b90834e433d2cefe8266823d.1648306232.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc_range(..., min, max, ...) returns values from min to max,
inclusive.

So, NR_EXT_DEVT is a valid idx returned by blk_alloc_ext_minor().

This is an issue because in device_add_disk(), this value is used in:
   ddev->devt = MKDEV(disk->major, disk->first_minor);
and NR_EXT_DEVT is '(1 << MINORBITS)'.

So, should 'disk->first_minor' be NR_EXT_DEVT, it would overflow.

Fixes: 22ae8ce8b892 ("block: simplify bdev/disk lookup in blkdev_get")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))

This patch is completely speculative, but it seems that idr_alloc() and
ida_alloc_range() don't have the same semantic regarding the upper bound.
idr_alloc() looks exclusive, while ida_alloc_range() is inclusive.

We changed from the first one to the other one in the commit in Fixes:.
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index c9a4fc90d3e9..b8b6759d670f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -335,7 +335,7 @@ int blk_alloc_ext_minor(void)
 {
 	int idx;
 
-	idx = ida_alloc_range(&ext_devt_ida, 0, NR_EXT_DEVT, GFP_KERNEL);
+	idx = ida_alloc_range(&ext_devt_ida, 0, NR_EXT_DEVT - 1, GFP_KERNEL);
 	if (idx == -ENOSPC)
 		return -EBUSY;
 	return idx;
-- 
2.32.0

