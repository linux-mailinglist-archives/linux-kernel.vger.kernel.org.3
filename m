Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A4F51ECAA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiEHJxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244834AbiEHJlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:41:18 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4BD1DEC0;
        Sun,  8 May 2022 02:37:26 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2489bFex024590;
        Sun, 8 May 2022 11:37:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Minh Yuan <yuanmingbuaa@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/3] floppy: use a statically allocated error counter
Date:   Sun,  8 May 2022 11:37:07 +0200
Message-Id: <20220508093709.24548-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt handler bad_flp_intr() may cause a UAF on the recently freed
request just to increment the error count. There's no point keeping
that one in the request anyway, and since the interrupt handler uses
a static pointer to the error which cannot be kept in sync with the
pending request, better make it use a static error counter that's
reset for each new request. This reset now happens when entering
redo_fd_request() for a new request via set_next_request().

One initial concern about a single error counter was that errors on
one floppy drive could be reported on another one, but this problem
is not real given that the driver uses a single drive at a time, as
that PC-compatible controllers also have this limitation by using
shared signals. As such the error count is always for the "current"
drive.

Reported-by: Minh Yuan <yuanmingbuaa@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Tested-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index d5b9ff9bcbb2..015841f50f4e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -509,8 +509,8 @@ static unsigned long fdc_busy;
 static DECLARE_WAIT_QUEUE_HEAD(fdc_wait);
 static DECLARE_WAIT_QUEUE_HEAD(command_done);
 
-/* Errors during formatting are counted here. */
-static int format_errors;
+/* errors encountered on the current (or last) request */
+static int floppy_errors;
 
 /* Format request descriptor. */
 static struct format_descr format_req;
@@ -530,7 +530,6 @@ static struct format_descr format_req;
 static char *floppy_track_buffer;
 static int max_buffer_sectors;
 
-static int *errors;
 typedef void (*done_f)(int);
 static const struct cont_t {
 	void (*interrupt)(void);
@@ -1455,7 +1454,7 @@ static int interpret_errors(void)
 			if (drive_params[current_drive].flags & FTD_MSG)
 				DPRINT("Over/Underrun - retrying\n");
 			bad = 0;
-		} else if (*errors >= drive_params[current_drive].max_errors.reporting) {
+		} else if (floppy_errors >= drive_params[current_drive].max_errors.reporting) {
 			print_errors();
 		}
 		if (reply_buffer[ST2] & ST2_WC || reply_buffer[ST2] & ST2_BC)
@@ -2095,7 +2094,7 @@ static void bad_flp_intr(void)
 		if (!next_valid_format(current_drive))
 			return;
 	}
-	err_count = ++(*errors);
+	err_count = ++floppy_errors;
 	INFBOUND(write_errors[current_drive].badness, err_count);
 	if (err_count > drive_params[current_drive].max_errors.abort)
 		cont->done(0);
@@ -2241,9 +2240,8 @@ static int do_format(int drive, struct format_descr *tmp_format_req)
 		return -EINVAL;
 	}
 	format_req = *tmp_format_req;
-	format_errors = 0;
 	cont = &format_cont;
-	errors = &format_errors;
+	floppy_errors = 0;
 	ret = wait_til_done(redo_format, true);
 	if (ret == -EINTR)
 		return -EINTR;
@@ -2759,10 +2757,11 @@ static int set_next_request(void)
 	current_req = list_first_entry_or_null(&floppy_reqs, struct request,
 					       queuelist);
 	if (current_req) {
-		current_req->error_count = 0;
+		floppy_errors = 0;
 		list_del_init(&current_req->queuelist);
+		return 1;
 	}
-	return current_req != NULL;
+	return 0;
 }
 
 /* Starts or continues processing request. Will automatically unlock the
@@ -2821,7 +2820,6 @@ static void redo_fd_request(void)
 		_floppy = floppy_type + drive_params[current_drive].autodetect[drive_state[current_drive].probed_format];
 	} else
 		probing = 0;
-	errors = &(current_req->error_count);
 	tmp = make_raw_rw_request();
 	if (tmp < 2) {
 		request_done(tmp);
-- 
2.17.5

