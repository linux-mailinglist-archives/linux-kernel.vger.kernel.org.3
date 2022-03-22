Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A14E3571
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiCVASA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiCVAR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39C3507C8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E9C6159B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E64C340F2;
        Tue, 22 Mar 2022 00:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647908030;
        bh=+4TOZbSuiHhhVC6/l0W8hpztfMomHwoKJ+uz5Ef5PpE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=KThaO0PyS0juTLfssp2ZvPRrnmLvFz31+dHhkEfKgxjjurpb9ZvyGWZMg14HtUu5Z
         Uw3r9lFGD+8J8gccPUNJjG//FdQdapv+1Cbl7ByvSnPlzdxCl+AOW/tMLW9LdOxmp6
         5vkHuTwI7r+OkJCn6ak0mvhOP6Y0I/Kmhum/KVSCT8PofxUX5HFNnoWNnDrBSkGgv2
         npRL3MVCwqzW4TH/pZCgPHqd7tafVJ82RT+P7NLlMyKyoDzzXX6Svx+xgoXgEUC6SG
         7h3r4wM3Udde6xJ04Nk+CzmitvJWOgIkvZUES2npT94ieBQ6H8dupPyUTZOIBnwQP4
         /c/FBNle8SBWg==
Date:   Mon, 21 Mar 2022 17:13:49 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: introduce data read/write showing path info
Message-ID: <YjkUvRKhyX8AUoTm@google.com>
References: <20220321223315.3228326-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321223315.3228326-1-jaegeuk@kernel.org>
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

 Change log from v1:
  - remove unnecessary path lookup

 fs/f2fs/file.c              | 48 ++++++++++++++++---
 include/trace/events/f2fs.h | 94 +++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 68ddf4c7ca64..19bc916c1eb7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4329,17 +4329,34 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
+		char *path, *p = kmalloc(PATH_MAX, GFP_KERNEL);
+		if (!p)
+			goto skip_read_trace;
+
+		path = dentry_path_raw(file_dentry(iocb->ki_filp), p, PATH_MAX);
+		if (IS_ERR(path))
+			goto skip_read_trace;
 
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
+	trace_f2fs_dataread_end(inode, pos, ret);
 	return ret;
 }
 
@@ -4637,14 +4654,31 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* Possibly preallocate the blocks for the write. */
 	target_size = iocb->ki_pos + iov_iter_count(from);
 	preallocated = f2fs_preallocate_blocks(iocb, from, dio);
-	if (preallocated < 0)
+	if (preallocated < 0) {
 		ret = preallocated;
-	else
+	} else {
+		if (trace_f2fs_datawrite_start_enabled()) {
+			char *path, *p = kmalloc(PATH_MAX, GFP_KERNEL);
+			if (!p)
+				goto skip_write_trace;
+			path = dentry_path_raw(file_dentry(iocb->ki_filp),
+								p, PATH_MAX);
+			if (IS_ERR(path))
+				goto skip_write_trace;
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
2.35.1.894.gb6a874cedc-goog

