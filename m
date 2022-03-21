Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95FF4E334B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiCUWyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiCUWym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F12445711
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1829E611FC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C76C340E8;
        Mon, 21 Mar 2022 22:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647901997;
        bh=ZfsJa7KwB3etBDc/tSAcSW1LlMyxyzZu1Ck9qqHzboc=;
        h=From:To:Cc:Subject:Date:From;
        b=LgJWbODpxmSVsetElElfC/COlJBgeTo7bxwaViVtkvnY/BwCIctf0l/aPBfz3I8kf
         5/1Z/YkdPpEyfnE8am3xhYnTN7Fm6FhzU+76JOs6+DMU2BTGqmf4PNN7WNmmeJX1Mp
         FxsqcfhYnzRPEqI9yIXLI9egH6NzufNRZzXBytJy4GwBNcof4E9mp4l+ZW3HaStmY1
         yqxX7NhNGleknK7FbhCFZ5IX6gvIojmO1h+5RJEMxNKsZvhFdJ1tTVy9cJAA8mQxDP
         eWkjmvWxlQJpv8+gvSd7t0J/Ye2KUZvhL/OdOmAEPWRpCrwKtt7/0nowQTL0QOw0V1
         Cj1xzY+48+QZQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: introduce data read/write showing path info
Date:   Mon, 21 Mar 2022 15:33:15 -0700
Message-Id: <20220321223315.3228326-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was used in Android for a long time. Let's upstream it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h              | 29 ++++++++++++
 fs/f2fs/file.c              | 43 ++++++++++++++---
 include/trace/events/f2fs.h | 94 +++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3016b6354a68..95de749c9637 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4537,4 +4537,33 @@ static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
+/* Sizes an on-stack array, so careful if sizing this up ! */
+#define MAX_TRACE_PATHBUF_LEN	256
+
+static inline char *f2fs_get_pathname(char *buf, int len, struct inode *inode)
+{
+	char *path;
+	struct dentry *d;
+
+	/*
+	 * d_obtain_alias() will either iput() if it locates an existing
+	 * dentry or transfer the reference to the new dentry created.
+	 * So get an extra reference here.
+	 */
+	ihold(inode);
+	d = d_obtain_alias(inode);
+	if (likely(!IS_ERR(d))) {
+		path = dentry_path_raw(d, buf, len);
+		if (unlikely(IS_ERR(path))) {
+			strcpy(buf, "ERROR");
+			path = buf;
+		}
+		dput(d);
+	} else {
+		strcpy(buf, "ERROR");
+		path = buf;
+	}
+	return path;
+}
+
 #endif /* _LINUX_F2FS_H */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 68ddf4c7ca64..a6a952b7ff91 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4329,17 +4329,32 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	const loff_t pos = iocb->ki_pos;
+	const size_t count = iov_iter_count(to);
 	ssize_t ret;
 
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	if (f2fs_should_use_dio(inode, iocb, to))
-		return f2fs_dio_read_iter(iocb, to);
+	if (trace_f2fs_dataread_start_enabled()) {
+		char *path, pathbuf[MAX_TRACE_PATHBUF_LEN];
+
+		path = f2fs_get_pathname(pathbuf,
+				MAX_TRACE_PATHBUF_LEN,
+				inode);
+		trace_f2fs_dataread_start(inode, pos, count,
+				current->pid, path,
+				current->comm);
+	}
 
-	ret = filemap_read(iocb, to, 0);
-	if (ret > 0)
-		f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_READ_IO, ret);
+	if (f2fs_should_use_dio(inode, iocb, to)) {
+		ret = f2fs_dio_read_iter(iocb, to);
+	} else {
+		ret = filemap_read(iocb, to, 0);
+		if (ret > 0)
+			f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_READ_IO, ret);
+	}
+	trace_f2fs_dataread_end(inode, pos, ret);
 	return ret;
 }
 
@@ -4637,14 +4652,28 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* Possibly preallocate the blocks for the write. */
 	target_size = iocb->ki_pos + iov_iter_count(from);
 	preallocated = f2fs_preallocate_blocks(iocb, from, dio);
-	if (preallocated < 0)
+	if (preallocated < 0) {
 		ret = preallocated;
-	else
+	} else {
+		if (trace_f2fs_datawrite_start_enabled()) {
+			char *path, pathbuf[MAX_TRACE_PATHBUF_LEN];
+
+			path = f2fs_get_pathname(pathbuf,
+					MAX_TRACE_PATHBUF_LEN,
+					inode);
+			trace_f2fs_datawrite_start(inode, orig_pos, orig_count,
+					current->pid, path,
+					current->comm);
+		}
 		/* Do the actual write. */
 		ret = dio ?
 			f2fs_dio_write_iter(iocb, from, &may_need_sync):
 			f2fs_buffered_write_iter(iocb, from);
 
+		if (trace_f2fs_datawrite_end_enabled())
+			trace_f2fs_datawrite_end(inode, orig_pos, ret);
+	}
+
 	/* Don't leave any preallocated blocks around past i_size. */
 	if (preallocated && i_size_read(inode) < target_size) {
 		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index f701bb23f83c..11f6b7147be2 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2068,6 +2068,100 @@ TRACE_EVENT(f2fs_fiemap,
 		__entry->ret)
 );
 
+DECLARE_EVENT_CLASS(f2fs__rw_start,
+
+	TP_PROTO(struct inode *inode, loff_t offset, int bytes,
+			pid_t pid, char *pathname, char *command),
+
+	TP_ARGS(inode, offset, bytes, pid, pathname, command),
+
+	TP_STRUCT__entry(
+		__string(pathbuf, pathname)
+		__field(loff_t, offset)
+		__field(int, bytes)
+		__field(loff_t, i_size)
+		__string(cmdline, command)
+		__field(pid_t, pid)
+		__field(ino_t, ino)
+	),
+
+	TP_fast_assign(
+		/*
+		 * Replace the spaces in filenames and cmdlines
+		 * because this screws up the tooling that parses
+		 * the traces.
+		 */
+		__assign_str(pathbuf, pathname);
+		(void)strreplace(__get_str(pathbuf), ' ', '_');
+		__entry->offset = offset;
+		__entry->bytes = bytes;
+		__entry->i_size = i_size_read(inode);
+		__assign_str(cmdline, command);
+		(void)strreplace(__get_str(cmdline), ' ', '_');
+		__entry->pid = pid;
+		__entry->ino = inode->i_ino;
+	),
+
+	TP_printk("entry_name %s, offset %llu, bytes %d, cmdline %s,"
+		" pid %d, i_size %llu, ino %lu",
+		__get_str(pathbuf), __entry->offset, __entry->bytes,
+		__get_str(cmdline), __entry->pid, __entry->i_size,
+		(unsigned long) __entry->ino)
+);
+
+DECLARE_EVENT_CLASS(f2fs__rw_end,
+
+	TP_PROTO(struct inode *inode, loff_t offset, int bytes),
+
+	TP_ARGS(inode, offset, bytes),
+
+	TP_STRUCT__entry(
+		__field(ino_t,	ino)
+		__field(loff_t,	offset)
+		__field(int,	bytes)
+	),
+
+	TP_fast_assign(
+		__entry->ino		= inode->i_ino;
+		__entry->offset		= offset;
+		__entry->bytes		= bytes;
+	),
+
+	TP_printk("ino %lu, offset %llu, bytes %d",
+		(unsigned long) __entry->ino,
+		__entry->offset, __entry->bytes)
+);
+
+DEFINE_EVENT(f2fs__rw_start, f2fs_dataread_start,
+
+	TP_PROTO(struct inode *inode, loff_t offset, int bytes,
+		pid_t pid, char *pathname, char *command),
+
+	TP_ARGS(inode, offset, bytes, pid, pathname, command)
+);
+
+DEFINE_EVENT(f2fs__rw_end, f2fs_dataread_end,
+
+	TP_PROTO(struct inode *inode, loff_t offset, int bytes),
+
+	TP_ARGS(inode, offset, bytes)
+);
+
+DEFINE_EVENT(f2fs__rw_start, f2fs_datawrite_start,
+
+	TP_PROTO(struct inode *inode, loff_t offset, int bytes,
+		pid_t pid, char *pathname, char *command),
+
+	TP_ARGS(inode, offset, bytes, pid, pathname, command)
+);
+
+DEFINE_EVENT(f2fs__rw_end, f2fs_datawrite_end,
+
+	TP_PROTO(struct inode *inode, loff_t offset, int bytes),
+
+	TP_ARGS(inode, offset, bytes)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
2.35.1.894.gb6a874cedc-goog

