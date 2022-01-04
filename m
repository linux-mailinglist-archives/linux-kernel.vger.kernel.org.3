Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B706A4849CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiADVYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiADVYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:24:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98786C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 13:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A353615C0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 21:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903E7C36AE0;
        Tue,  4 Jan 2022 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641331472;
        bh=QaQAAMBUqG+y0KgQZ5h783BXHPubPbNfRTxo2K7MZnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBKH6kSPJOUkTsxvsD7etYzV0VbCyGZeA8cg1OsoalNWIfmY5A8NiU+lA5qsZx82g
         u/T4iZlLCAL5oU3cjebSIIsAqN84BS64MHhvHndcIW2quHZtrA6ESrYOvqlUpv2lzo
         vR8XStaAsdgSUlXx+tSq0bmjCP7+iCEeY81qgwzC4R8tzfsCJ0tZf5q8iQemklqkvA
         o7rYb16fOXdN2dCMJzovpODu4MT5qZS0FhPXsJ2E1XjudV6KqmcxzALzGmweYoTfyP
         s9tzYsrvcxf4J1UQN3TNP/Cov7FJ2p9hiRq17NjooNL3SssV4KpV3zu2WJXpUzbRfT
         NXCKNG6p+pGhg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] f2fs: do not expose unwritten blocks to user by DIO
Date:   Tue,  4 Jan 2022 13:24:16 -0800
Message-Id: <20220104212419.1879225-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104212419.1879225-1-jaegeuk@kernel.org>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DIO preallocates physical blocks before writing data, but if an error occurrs
or power-cut happens, we can see block contents from the disk. This patch tries
to fix it by 1) turning to buffered writes for DIO into holes, 2) truncating
unwritten blocks from error or power-cut.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c  |  5 ++++-
 fs/f2fs/f2fs.h  |  5 +++++
 fs/f2fs/file.c  | 27 ++++++++++++++++++---------
 fs/f2fs/inode.c |  8 ++++++++
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3db0f3049b90..9c867de1ec29 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1543,8 +1543,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 					flag != F2FS_GET_BLOCK_DIO);
 				err = __allocate_data_block(&dn,
 							map->m_seg_type);
-				if (!err)
+				if (!err) {
+					if (flag == F2FS_GET_BLOCK_PRE_DIO)
+						file_need_truncate(inode);
 					set_inode_flag(inode, FI_APPEND_WRITE);
+				}
 			}
 			if (err)
 				goto sync_out;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6f196621f772..d7435fcb9658 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -654,6 +654,7 @@ enum {
 #define FADVISE_KEEP_SIZE_BIT	0x10
 #define FADVISE_HOT_BIT		0x20
 #define FADVISE_VERITY_BIT	0x40
+#define FADVISE_TRUNC_BIT	0x80
 
 #define FADVISE_MODIFIABLE_BITS	(FADVISE_COLD_BIT | FADVISE_HOT_BIT)
 
@@ -681,6 +682,10 @@ enum {
 #define file_is_verity(inode)	is_file(inode, FADVISE_VERITY_BIT)
 #define file_set_verity(inode)	set_file(inode, FADVISE_VERITY_BIT)
 
+#define file_should_truncate(inode)	is_file(inode, FADVISE_TRUNC_BIT)
+#define file_need_truncate(inode)	set_file(inode, FADVISE_TRUNC_BIT)
+#define file_dont_truncate(inode)	clear_file(inode, FADVISE_TRUNC_BIT)
+
 #define DEF_DIR_LEVEL		0
 
 enum {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 808a7c24d993..e1445cf915ea 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1687,6 +1687,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
 		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
+		file_dont_truncate(inode);
 
 		up_write(&sbi->pin_sem);
 
@@ -4257,6 +4258,13 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter)
 	/* If it will be an out-of-place direct write, don't bother. */
 	if (dio && f2fs_lfs_mode(sbi))
 		return 0;
+	/*
+	 * Don't preallocate holes aligned to DIO_SKIP_HOLES which turns into
+	 * buffered IO, if DIO meets any holes.
+	 */
+	if (dio && i_size_read(inode) &&
+		(F2FS_BYTES_TO_BLK(pos) < F2FS_BLK_ALIGN(i_size_read(inode))))
+		return 0;
 
 	/* No-wait I/O can't allocate blocks. */
 	if (iocb->ki_flags & IOCB_NOWAIT)
@@ -4292,8 +4300,8 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	ret = f2fs_map_blocks(inode, &map, 1, flag);
-	/* -ENOSPC is only a fatal error if no blocks could be allocated. */
-	if (ret < 0 && !(ret == -ENOSPC && map.m_len > 0))
+	/* -ENOSPC|-EDQUOT are fine to report the number of allocated blocks. */
+	if (ret < 0 && !((ret == -ENOSPC || ret == -EDQUOT) && map.m_len > 0))
 		return ret;
 	if (ret == 0)
 		set_inode_flag(inode, FI_PREALLOCATED_ALL);
@@ -4359,20 +4367,21 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* Possibly preallocate the blocks for the write. */
 	target_size = iocb->ki_pos + iov_iter_count(from);
 	preallocated = f2fs_preallocate_blocks(iocb, from);
-	if (preallocated < 0) {
+	if (preallocated < 0)
 		ret = preallocated;
-		goto out_unlock;
-	}
-
-	ret = __generic_file_write_iter(iocb, from);
+	else
+		ret = __generic_file_write_iter(iocb, from);
 
 	/* Don't leave any preallocated blocks around past i_size. */
-	if (preallocated > 0 && i_size_read(inode) < target_size) {
+	if (preallocated && i_size_read(inode) < target_size) {
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
-		f2fs_truncate(inode);
+		if (!f2fs_truncate(inode))
+			file_dont_truncate(inode);
 		filemap_invalidate_unlock(inode->i_mapping);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	} else {
+		file_dont_truncate(inode);
 	}
 
 	clear_inode_flag(inode, FI_PREALLOCATED_ALL);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0f8b2df3e1e0..6998eb1d6bdb 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -544,6 +544,14 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		goto bad_inode;
 	}
 	f2fs_set_inode_flags(inode);
+
+	if (file_should_truncate(inode)) {
+		ret = f2fs_truncate(inode);
+		if (ret)
+			goto bad_inode;
+		file_dont_truncate(inode);
+	}
+
 	unlock_new_inode(inode);
 	trace_f2fs_iget(inode);
 	return inode;
-- 
2.34.1.448.ga2b2bfdf31-goog

