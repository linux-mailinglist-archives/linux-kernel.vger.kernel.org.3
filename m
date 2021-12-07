Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C13946BD95
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbhLGO3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhLGO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:29:46 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F3C08ED87
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=NNJTfT68Mzbdlc+S7RlFBWTtsV0EvnnqIJjDPRCWrq4=; b=7h
        5qo3F2OlSZQkBs7eNO568P9jynvo+O0fyWaKvYTraGToastkrUVxFf213fR/vd+sLj2863L/dAB05
        C030L1hyStHdnHaAmQUHE1nZFgPU5g3U9z98RFj/gYIUd78yQTfzs9vFgEUKrUwQMmokIU9RMLQFV
        +gM/cOPKjdhrFcXDV8yUvZsmM4CfMIcN6K1T3VTMe33LmZEaIr8H1WkIGZ0Oh+4mmE/ghzWUnguTD
        LJufN//N4qX3wdx9zrAMo10DXdkCGyUPI/z47h4Rl2QpRN58ffMRX7/x9IsLN2Ju2syPJ58rM8u1k
        cZ5eGuBA778rOAQ0WDOvN1MWO2qgWXmw==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mubQ1-0007SP-Eq; Tue, 07 Dec 2021 14:26:09 +0000
From:   John Keeping <john@metanate.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Keeping <john@metanate.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] tracing: make trace_marker{,_raw} stream-like
Date:   Tue,  7 Dec 2021 14:25:58 +0000
Message-Id: <20211207142558.347029-1-john@metanate.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracing marker files are write-only streams with no meaningful
concept of file position.  Using stream_open() to mark them as
stream-link indicates this and has the added advantage that a single
file descriptor can now be used from multiple threads without contention
thanks to clearing FMODE_ATOMIC_POS.

Note that this has the potential to break existing userspace by since
both lseek(2) and pwrite(2) will now return ESPIPE when previously lseek
would have updated the stored offset and pwrite would have appended to
the trace.  A survey of libtracefs and several other projects found to
use trace_marker(_raw) [1][2][3] suggests that everyone limits
themselves to calling write(2) and close(2) on these file descriptors so
there is a good chance this will go unnoticed and the benefits of
reduced overhead and lock contention seem worth the risk.

[1] https://github.com/google/perfetto
[2] https://github.com/intel/media-driver/
[3] https://w1.fi/cgit/hostap/

Signed-off-by: John Keeping <john@metanate.com>
---
Resending as requested at [1].

[1] https://lore.kernel.org/all/20211207090347.15822d87@gandalf.local.home/

 kernel/trace/trace.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 88de94da596b1..7c91103ac1a04 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4834,6 +4834,12 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int tracing_mark_open(struct inode *inode, struct file *filp)
+{
+	stream_open(inode, filp);
+	return tracing_open_generic_tr(inode, filp);
+}
+
 static int tracing_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -7110,9 +7116,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (tt)
 		event_triggers_post_call(tr->trace_marker_file, tt);
 
-	if (written > 0)
-		*fpos += written;
-
 	return written;
 }
 
@@ -7171,9 +7174,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 
 	__buffer_unlock_commit(buffer, event);
 
-	if (written > 0)
-		*fpos += written;
-
 	return written;
 }
 
@@ -7573,16 +7573,14 @@ static const struct file_operations tracing_free_buffer_fops = {
 };
 
 static const struct file_operations tracing_mark_fops = {
-	.open		= tracing_open_generic_tr,
+	.open		= tracing_mark_open,
 	.write		= tracing_mark_write,
-	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
 
 static const struct file_operations tracing_mark_raw_fops = {
-	.open		= tracing_open_generic_tr,
+	.open		= tracing_mark_open,
 	.write		= tracing_mark_raw_write,
-	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
 
-- 
2.34.1

