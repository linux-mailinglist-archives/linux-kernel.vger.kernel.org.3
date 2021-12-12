Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6247178E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhLLB0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhLLB0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:26:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFBAC061751
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 17:26:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24487B80C0A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 01:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6921C341C8;
        Sun, 12 Dec 2021 01:26:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mwDdU-000kCd-TQ;
        Sat, 11 Dec 2021 20:26:44 -0500
Message-ID: <20211212012644.746059161@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 11 Dec 2021 20:26:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Keeping <john@metanate.com>
Subject: [for-next][PATCH 01/11] tracing: Make trace_marker{,_raw} stream-like
References: <20211212012617.690710310@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Keeping <john@metanate.com>

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

Link: https://lkml.kernel.org/r/20211207142558.347029-1-john@metanate.com

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e3b8c906b7b4..588de6df473f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4841,6 +4841,12 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
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
@@ -7117,9 +7123,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (tt)
 		event_triggers_post_call(tr->trace_marker_file, tt);
 
-	if (written > 0)
-		*fpos += written;
-
 	return written;
 }
 
@@ -7178,9 +7181,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 
 	__buffer_unlock_commit(buffer, event);
 
-	if (written > 0)
-		*fpos += written;
-
 	return written;
 }
 
@@ -7580,16 +7580,14 @@ static const struct file_operations tracing_free_buffer_fops = {
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
2.33.0
