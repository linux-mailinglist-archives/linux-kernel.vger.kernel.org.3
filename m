Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861954EA5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiC2DPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiC2DPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:15:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BF0255B8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FD12B81218
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106D5C340EC;
        Tue, 29 Mar 2022 03:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648523628;
        bh=6Go8L6A+oUYqyUiMtA+jg5RYozyFeakYU5qJLj4LNmU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=A3iv0Gdpy9o+uHBDc35FmEjJi7K3igEFYdNdaz4AFzAEL5ceZP9VmjkQXbhXVXNIQ
         S+geB5yFbc84FzLYm9l2oDs9p8JCSWFKAZ6afXasEtPfpJV6AziTvhgEkmqfctjDqj
         SnTQdOjJoUa8Ao7XauM8CKcqBYxYmpRV8UUB3DZY18I09aCcYskQCan0LNonEfGbCs
         KvxuGwS0/uVi4U73qsbDLpopDPiW3e2c8JS+As45s7eWVDxZUUmuLWp1xK2EpzCJ1O
         S4U/6zchxHo4Emcv21upB/yqW67PTWFFPb9LwMUt+Dcm3AzMsFKqUtRMUuIsDFVIsY
         30u2t4FXKQGjg==
Date:   Mon, 28 Mar 2022 20:13:46 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: introduce data read/write showing
 path info
Message-ID: <YkJ5anzBIyQkiHfU@google.com>
References: <20220321223315.3228326-1-jaegeuk@kernel.org>
 <YjkUvRKhyX8AUoTm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjkUvRKhyX8AUoTm@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 change log from v2:
  - fix missing kfree
  - add condition check

 fs/f2fs/file.c              | 58 ++++++++++++++++++++---
 include/trace/events/f2fs.h | 94 +++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 68ddf4c7ca64..51df34f95984 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4329,17 +4329,39 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	const loff_t pos = iocb->ki_pos;
 	ssize_t ret;
 
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	if (f2fs_should_use_dio(inode, iocb, to))
-		return f2fs_dio_read_iter(iocb, to);
+	if (trace_f2fs_dataread_start_enabled()) {
+		char *p = f2fs_kmalloc(F2FS_I_SB(inode), PATH_MAX, GFP_KERNEL);
+		char *path;
+
+		if (!p)
+			goto skip_read_trace;
+
+		path = dentry_path_raw(file_dentry(iocb->ki_filp), p, PATH_MAX);
+		if (IS_ERR(path)) {
+			kfree(p);
+			goto skip_read_trace;
+		}
 
-	ret = filemap_read(iocb, to, 0);
-	if (ret > 0)
-		f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_READ_IO, ret);
+		trace_f2fs_dataread_start(inode, pos, iov_iter_count(to),
+					current->pid, path, current->comm);
+		kfree(p);
+	}
+skip_read_trace:
+	if (f2fs_should_use_dio(inode, iocb, to)) {
+		ret = f2fs_dio_read_iter(iocb, to);
+	} else {
+		ret = filemap_read(iocb, to, 0);
+		if (ret > 0)
+			f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_READ_IO, ret);
+	}
+	if (trace_f2fs_dataread_end_enabled())
+		trace_f2fs_dataread_end(inode, pos, ret);
 	return ret;
 }
 
@@ -4637,14 +4659,36 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* Possibly preallocate the blocks for the write. */
 	target_size = iocb->ki_pos + iov_iter_count(from);
 	preallocated = f2fs_preallocate_blocks(iocb, from, dio);
-	if (preallocated < 0)
+	if (preallocated < 0) {
 		ret = preallocated;
-	else
+	} else {
+		if (trace_f2fs_datawrite_start_enabled()) {
+			char *p = f2fs_kmalloc(F2FS_I_SB(inode),
+						PATH_MAX, GFP_KERNEL);
+			char *path;
+
+			if (!p)
+				goto skip_write_trace;
+			path = dentry_path_raw(file_dentry(iocb->ki_filp),
+								p, PATH_MAX);
+			if (IS_ERR(path)) {
+				kfree(p);
+				goto skip_write_trace;
+			}
+			trace_f2fs_datawrite_start(inode, orig_pos, orig_count,
+					current->pid, path, current->comm);
+			kfree(p);
+		}
+skip_write_trace:
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
2.35.1.1021.g381101b075-goog

