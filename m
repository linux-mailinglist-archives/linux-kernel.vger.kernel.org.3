Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315D551E274
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444992AbiEFX0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiEFX0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:26:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBEC7092B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 254A461A28
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781F1C385A9;
        Fri,  6 May 2022 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651879384;
        bh=vo5043PSzfcS7GsGaGcTVAsUJxoZIcBgRSYY43iCzdc=;
        h=From:To:Cc:Subject:Date:From;
        b=piVAQ5xZtAgFz/A39pa1ElTPXE+AJsFJg54DWNPBmm3fNG+NW3g/3LIBf0SiGFf+3
         uQqAicY4A5ZowlkxJrW4T+QGJ0XifH8bzIeus41CBTE30fZbMyElybiRRowao5/vyR
         U//6RuRFBDYAk3IGAQ5oBN8DhxqPRyOw+k55aYrlc0jjh0WbJK/8X4auYou9zn1J/1
         2RmCw7Hu1o5F2WaQDB57E+7EMNhFbqrnmwO5AogAfi7OrzaoLvgQ4ep6XaOuUuweFp
         nuJl7fEcZlsvlV090iDxFztzcfUcii/gcjPd3vcLVSEE7tgqSlK+rIYCmLrkexWrVU
         o57aBtLqbyzhg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: kill volatile write support
Date:   Fri,  6 May 2022 16:23:02 -0700
Message-Id: <20220506232302.1264915-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no user, since all can use atomic writes simply.
Let's kill it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |   4 +-
 fs/f2fs/data.c       |   5 --
 fs/f2fs/debug.c      |  10 +---
 fs/f2fs/f2fs.h       |  27 +---------
 fs/f2fs/file.c       | 116 ++-----------------------------------------
 fs/f2fs/segment.c    |   3 +-
 fs/f2fs/verity.c     |   2 +-
 7 files changed, 10 insertions(+), 157 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index beceac9885c3..63ab8c9d674e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1004,9 +1004,7 @@ static void __add_dirty_inode(struct inode *inode, enum inode_type type)
 		return;
 
 	set_inode_flag(inode, flag);
-	if (!f2fs_is_volatile_file(inode))
-		list_add_tail(&F2FS_I(inode)->dirty_list,
-						&sbi->inode_list[type]);
+	list_add_tail(&F2FS_I(inode)->dirty_list, &sbi->inode_list[type]);
 	stat_inc_dirty_inode(sbi, type);
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8763a4690aaf..54a7a8ad994d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2741,11 +2741,6 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 write:
 	if (f2fs_is_drop_cache(inode))
 		goto out;
-	/* we should not write 0'th page having journal header */
-	if (f2fs_is_volatile_file(inode) && (!page->index ||
-			(!wbc->for_reclaim &&
-			f2fs_available_free_memory(sbi, BASE_CHECK))))
-		goto redirty_out;
 
 	/* Dentry/quota blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 65f0bcf498bb..c92625ef16d0 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -92,9 +92,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->nquota_files = sbi->nquota_files;
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->aw_cnt = sbi->atomic_files;
-	si->vw_cnt = atomic_read(&sbi->vw_cnt);
 	si->max_aw_cnt = atomic_read(&sbi->max_aw_cnt);
-	si->max_vw_cnt = atomic_read(&sbi->max_vw_cnt);
 	si->nr_dio_read = get_pages(sbi, F2FS_DIO_READ);
 	si->nr_dio_write = get_pages(sbi, F2FS_DIO_WRITE);
 	si->nr_wb_cp_data = get_pages(sbi, F2FS_WB_CP_DATA);
@@ -511,10 +509,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->flush_list_empty,
 			   si->nr_discarding, si->nr_discarded,
 			   si->nr_discard_cmd, si->undiscard_blks);
-		seq_printf(s, "  - atomic IO: %4d (Max. %4d), "
-			"volatile IO: %4d (Max. %4d)\n",
-			   si->aw_cnt, si->max_aw_cnt,
-			   si->vw_cnt, si->max_vw_cnt);
+		seq_printf(s, "  - atomic IO: %4d (Max. %4d)\n",
+			   si->aw_cnt, si->max_aw_cnt);
 		seq_printf(s, "  - compress: %4d, hit:%8d\n", si->compress_pages, si->compress_page_hit);
 		seq_printf(s, "  - nodes: %4d in %4d\n",
 			   si->ndirty_node, si->node_pages);
@@ -615,9 +611,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	for (i = META_CP; i < META_MAX; i++)
 		atomic_set(&sbi->meta_count[i], 0);
 
-	atomic_set(&sbi->vw_cnt, 0);
 	atomic_set(&sbi->max_aw_cnt, 0);
-	atomic_set(&sbi->max_vw_cnt, 0);
 
 	raw_spin_lock_irqsave(&f2fs_stat_lock, flags);
 	list_add_tail(&si->stat_list, &f2fs_stat_list);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2787797df576..492af5b96de1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -737,7 +737,6 @@ enum {
 	FI_UPDATE_WRITE,	/* inode has in-place-update data */
 	FI_NEED_IPU,		/* used for ipu per file */
 	FI_ATOMIC_FILE,		/* indicate atomic file */
-	FI_VOLATILE_FILE,	/* indicate volatile file */
 	FI_FIRST_BLOCK_WRITTEN,	/* indicate #0 data block was written */
 	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
@@ -1747,9 +1746,7 @@ struct f2fs_sb_info {
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
 	atomic_t compr_inode;			/* # of compressed inodes */
 	atomic64_t compr_blocks;		/* # of compressed blocks */
-	atomic_t vw_cnt;			/* # of volatile writes */
 	atomic_t max_aw_cnt;			/* max # of atomic writes */
-	atomic_t max_vw_cnt;			/* max # of volatile writes */
 	unsigned int io_skip_bggc;		/* skip background gc for in-flight IO */
 	unsigned int other_skip_bggc;		/* skip background gc for other reasons */
 	unsigned int ndirty_inode[NR_INODE_TYPE];	/* # of dirty inodes */
@@ -3200,11 +3197,6 @@ static inline bool f2fs_is_atomic_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_ATOMIC_FILE);
 }
 
-static inline bool f2fs_is_volatile_file(struct inode *inode)
-{
-	return is_inode_flag_set(inode, FI_VOLATILE_FILE);
-}
-
 static inline bool f2fs_is_first_block_written(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_FIRST_BLOCK_WRITTEN);
@@ -3823,7 +3815,7 @@ struct f2fs_stat_info {
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
 	int compr_inode;
 	unsigned long long compr_blocks;
-	int aw_cnt, max_aw_cnt, vw_cnt, max_vw_cnt;
+	int aw_cnt, max_aw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
 	unsigned int bimodal, avg_vblocks;
 	int util_free, util_valid, util_invalid;
@@ -3934,17 +3926,6 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		if (cur > max)						\
 			atomic_set(&F2FS_I_SB(inode)->max_aw_cnt, cur);	\
 	} while (0)
-#define stat_inc_volatile_write(inode)					\
-		(atomic_inc(&F2FS_I_SB(inode)->vw_cnt))
-#define stat_dec_volatile_write(inode)					\
-		(atomic_dec(&F2FS_I_SB(inode)->vw_cnt))
-#define stat_update_max_volatile_write(inode)				\
-	do {								\
-		int cur = atomic_read(&F2FS_I_SB(inode)->vw_cnt);	\
-		int max = atomic_read(&F2FS_I_SB(inode)->max_vw_cnt);	\
-		if (cur > max)						\
-			atomic_set(&F2FS_I_SB(inode)->max_vw_cnt, cur);	\
-	} while (0)
 #define stat_inc_seg_count(sbi, type, gc_type)				\
 	do {								\
 		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
@@ -4006,9 +3987,6 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #define stat_add_compr_blocks(inode, blocks)		do { } while (0)
 #define stat_sub_compr_blocks(inode, blocks)		do { } while (0)
 #define stat_update_max_atomic_write(inode)		do { } while (0)
-#define stat_inc_volatile_write(inode)			do { } while (0)
-#define stat_dec_volatile_write(inode)			do { } while (0)
-#define stat_update_max_volatile_write(inode)		do { } while (0)
 #define stat_inc_meta_count(sbi, blkaddr)		do { } while (0)
 #define stat_inc_seg_type(sbi, curseg)			do { } while (0)
 #define stat_inc_block_count(sbi, curseg)		do { } while (0)
@@ -4411,8 +4389,7 @@ static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 static inline bool f2fs_may_compress(struct inode *inode)
 {
 	if (IS_SWAPFILE(inode) || f2fs_is_pinned_file(inode) ||
-				f2fs_is_atomic_file(inode) ||
-				f2fs_is_volatile_file(inode))
+				f2fs_is_atomic_file(inode))
 		return false;
 	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b7d7c609b407..09287876dbb7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1820,13 +1820,6 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 
 	if (f2fs_is_atomic_file(inode))
 		f2fs_abort_atomic_write(inode, true);
-	if (f2fs_is_volatile_file(inode)) {
-		set_inode_flag(inode, FI_DROP_CACHE);
-		filemap_fdatawrite(inode->i_mapping);
-		clear_inode_flag(inode, FI_DROP_CACHE);
-		clear_inode_flag(inode, FI_VOLATILE_FILE);
-		stat_dec_volatile_write(inode);
-	}
 	return 0;
 }
 
@@ -2100,15 +2093,10 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
 	inode_lock(inode);
 
-	if (f2fs_is_volatile_file(inode)) {
-		ret = -EINVAL;
-		goto err_out;
-	}
-
 	if (f2fs_is_atomic_file(inode)) {
 		ret = f2fs_commit_atomic_write(inode);
 		if (ret)
-			goto err_out;
+			goto unlock_out;
 
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 		if (!ret)
@@ -2116,108 +2104,12 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	} else {
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
-err_out:
+unlock_out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
 }
 
-static int f2fs_ioc_start_volatile_write(struct file *filp)
-{
-	struct inode *inode = file_inode(filp);
-	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
-	int ret;
-
-	if (!inode_owner_or_capable(mnt_userns, inode))
-		return -EACCES;
-
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
-
-	ret = mnt_want_write_file(filp);
-	if (ret)
-		return ret;
-
-	inode_lock(inode);
-
-	if (f2fs_is_volatile_file(inode))
-		goto out;
-
-	ret = f2fs_convert_inline_inode(inode);
-	if (ret)
-		goto out;
-
-	stat_inc_volatile_write(inode);
-	stat_update_max_volatile_write(inode);
-
-	set_inode_flag(inode, FI_VOLATILE_FILE);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
-out:
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
-	return ret;
-}
-
-static int f2fs_ioc_release_volatile_write(struct file *filp)
-{
-	struct inode *inode = file_inode(filp);
-	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
-	int ret;
-
-	if (!inode_owner_or_capable(mnt_userns, inode))
-		return -EACCES;
-
-	ret = mnt_want_write_file(filp);
-	if (ret)
-		return ret;
-
-	inode_lock(inode);
-
-	if (!f2fs_is_volatile_file(inode))
-		goto out;
-
-	if (!f2fs_is_first_block_written(inode)) {
-		ret = truncate_partial_data_page(inode, 0, true);
-		goto out;
-	}
-
-	ret = punch_hole(inode, 0, F2FS_BLKSIZE);
-out:
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
-	return ret;
-}
-
-static int f2fs_ioc_abort_volatile_write(struct file *filp)
-{
-	struct inode *inode = file_inode(filp);
-	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
-	int ret;
-
-	if (!inode_owner_or_capable(mnt_userns, inode))
-		return -EACCES;
-
-	ret = mnt_want_write_file(filp);
-	if (ret)
-		return ret;
-
-	inode_lock(inode);
-
-	if (f2fs_is_atomic_file(inode))
-		f2fs_abort_atomic_write(inode, true);
-	if (f2fs_is_volatile_file(inode)) {
-		clear_inode_flag(inode, FI_VOLATILE_FILE);
-		stat_dec_volatile_write(inode);
-		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
-	}
-
-	inode_unlock(inode);
-
-	mnt_drop_write_file(filp);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
-	return ret;
-}
-
 static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -4174,11 +4066,9 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
 		return f2fs_ioc_commit_atomic_write(filp);
 	case F2FS_IOC_START_VOLATILE_WRITE:
-		return f2fs_ioc_start_volatile_write(filp);
 	case F2FS_IOC_RELEASE_VOLATILE_WRITE:
-		return f2fs_ioc_release_volatile_write(filp);
 	case F2FS_IOC_ABORT_VOLATILE_WRITE:
-		return f2fs_ioc_abort_volatile_write(filp);
+		return -EOPNOTSUPP;
 	case F2FS_IOC_SHUTDOWN:
 		return f2fs_ioc_shutdown(filp, arg);
 	case FITRIM:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 268f341d8963..0a4180f64291 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3173,8 +3173,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			return CURSEG_COLD_DATA;
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
-				f2fs_is_atomic_file(inode) ||
-				f2fs_is_volatile_file(inode))
+				f2fs_is_atomic_file(inode))
 			return CURSEG_HOT_DATA;
 		return f2fs_rw_hint_to_seg_type(inode->i_write_hint);
 	} else {
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 3d793202cc9f..5ac7e756a1bb 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -128,7 +128,7 @@ static int f2fs_begin_enable_verity(struct file *filp)
 	if (f2fs_verity_in_progress(inode))
 		return -EBUSY;
 
-	if (f2fs_is_atomic_file(inode) || f2fs_is_volatile_file(inode))
+	if (f2fs_is_atomic_file(inode))
 		return -EOPNOTSUPP;
 
 	/*
-- 
2.36.0.512.ge40c2bad7a-goog

