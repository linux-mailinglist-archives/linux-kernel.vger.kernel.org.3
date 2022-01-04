Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714344849CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiADVYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiADVYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:24:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E48C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 13:24:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA76E615C0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 21:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E221C36AEB;
        Tue,  4 Jan 2022 21:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641331473;
        bh=+cD0bVmur39/mZZYScz/Vt2+aXcvYE362LOr2fvRC2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYF5czKWnVrjw6Z9QZrLoy5tH5IXU9xjedOFuCFTlIU6xETnPpRckp7aYjNFEvK6u
         EoyA+yL7CWPbr+6MM7YNrNUEtwqR9B/SZCK0rqqYJI7T1M/MahE6O5CcdUHViZMfHL
         TL+ClowlfFt2v46HEPN14l3reW/V4AKYbmemzjvS/MtD7MggQMTKdwWaIjoUzevFpI
         G94KXKjeItKOGtXpRcFw/c2Qch+ceKG5Qm56lZ5puRzyzsBH7TVDgsNTJpFA3PwMds
         UiF94osdckYXXMnneiQcVXcMNYIFacO8hiUVFvtOYUNs3pHtmj8AH8avBtI3BfbbCp
         Ul4oyoXCGuxnA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Eric Biggers <ebiggers@google.com>, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/6] f2fs: fix the f2fs_file_write_iter tracepoint
Date:   Tue,  4 Jan 2022 13:24:17 -0800
Message-Id: <20220104212419.1879225-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104212419.1879225-1-jaegeuk@kernel.org>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Pass in the original position and count rather than the position and
count that were updated by the write.  Also use the correct types for
all arguments, in particular the file offset which was being truncated
to 32 bits on 32-bit platforms.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c              |  5 +++--
 include/trace/events/f2fs.h | 12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e1445cf915ea..048db4852b28 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4312,6 +4312,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	const loff_t orig_pos = iocb->ki_pos;
+	const size_t orig_count = iov_iter_count(from);
 	loff_t target_size;
 	int preallocated;
 	ssize_t ret;
@@ -4392,8 +4394,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 out_unlock:
 	inode_unlock(inode);
 out:
-	trace_f2fs_file_write_iter(inode, iocb->ki_pos,
-					iov_iter_count(from), ret);
+	trace_f2fs_file_write_iter(inode, orig_pos, orig_count, ret);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index f8cb916f3595..dcb94d740e12 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -540,17 +540,17 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 
 TRACE_EVENT(f2fs_file_write_iter,
 
-	TP_PROTO(struct inode *inode, unsigned long offset,
-		unsigned long length, int ret),
+	TP_PROTO(struct inode *inode, loff_t offset, size_t length,
+		 ssize_t ret),
 
 	TP_ARGS(inode, offset, length, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(unsigned long, offset)
-		__field(unsigned long, length)
-		__field(int,	ret)
+		__field(loff_t, offset)
+		__field(size_t, length)
+		__field(ssize_t, ret)
 	),
 
 	TP_fast_assign(
@@ -562,7 +562,7 @@ TRACE_EVENT(f2fs_file_write_iter,
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, "
-		"offset = %lu, length = %lu, written(err) = %d",
+		"offset = %lld, length = %zu, written(err) = %zd",
 		show_dev_ino(__entry),
 		__entry->offset,
 		__entry->length,
-- 
2.34.1.448.ga2b2bfdf31-goog

