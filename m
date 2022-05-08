Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1073451ECB5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiEHJy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiEHJlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:41:22 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C011DEC0;
        Sun,  8 May 2022 02:37:32 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2489bFv6024591;
        Sun, 8 May 2022 11:37:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Minh Yuan <yuanmingbuaa@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/3] ataflop: use a statically allocated error counters
Date:   Sun,  8 May 2022 11:37:08 +0200
Message-Id: <20220508093709.24548-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220508093709.24548-1-w@1wt.eu>
References: <20220508093709.24548-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last driver making use of fd_request->error_count, which
is easy to get wrong as was shown in floppy.c. We don't need to keep
it there, it can be moved to the atari_floppy_struct instead, so let's
do this.

Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Minh Yuan <yuanmingbuaa@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/ataflop.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 5d819a466e2f..e232cc4fd444 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -303,6 +303,7 @@ static struct atari_floppy_struct {
 	int ref;
 	int type;
 	struct blk_mq_tag_set tag_set;
+	int error_count;
 } unit[FD_MAX_UNITS];
 
 #define	UD	unit[drive]
@@ -705,14 +706,14 @@ static void fd_error( void )
 	if (!fd_request)
 		return;
 
-	fd_request->error_count++;
-	if (fd_request->error_count >= MAX_ERRORS) {
+	unit[SelectedDrive].error_count++;
+	if (unit[SelectedDrive].error_count >= MAX_ERRORS) {
 		printk(KERN_ERR "fd%d: too many errors.\n", SelectedDrive );
 		fd_end_request_cur(BLK_STS_IOERR);
 		finish_fdc();
 		return;
 	}
-	else if (fd_request->error_count == RECALIBRATE_ERRORS) {
+	else if (unit[SelectedDrive].error_count == RECALIBRATE_ERRORS) {
 		printk(KERN_WARNING "fd%d: recalibrating\n", SelectedDrive );
 		if (SelectedDrive != -1)
 			SUD.track = -1;
@@ -1491,7 +1492,7 @@ static void setup_req_params( int drive )
 	ReqData = ReqBuffer + 512 * ReqCnt;
 
 	if (UseTrackbuffer)
-		read_track = (ReqCmd == READ && fd_request->error_count == 0);
+		read_track = (ReqCmd == READ && unit[drive].error_count == 0);
 	else
 		read_track = 0;
 
@@ -1520,6 +1521,7 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_RESOURCE;
 	}
 	fd_request = bd->rq;
+	unit[drive].error_count = 0;
 	blk_mq_start_request(fd_request);
 
 	atari_disable_irq( IRQ_MFP_FDC );
-- 
2.17.5

