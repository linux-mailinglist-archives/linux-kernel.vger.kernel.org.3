Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D4F4A8844
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352106AbiBCQDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:03:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48774 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbiBCQDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:03:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9A82B834DC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EA6C340E8;
        Thu,  3 Feb 2022 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643904224;
        bh=8V+zuFLUMkSUwS4VuIAfl+h5CeD1gnWra53+qgBpfIc=;
        h=From:To:Cc:Subject:Date:From;
        b=rLjQnHPAhzN8TtVhJAS4dR7m/w5Hprh53NGlUMn0gmnqt1vR2eyZ4z+x/s9n96Qba
         qFFqsJ6ZFHdtlfEoUc0fHJYbCcXz2Z9IOeBluf+uBTU4xPZglEEfZ35O6/WetzNmM8
         HMIhAhcLNXNFcoT6m41qt0tX7ZN2+Ct7M5193IulPXjAemz3kLk7wiSrP0Xcksg6M2
         oZm8zldGf9/Bj4bNQyrBusD6Sej+6HGvuWW030sRZyxj5odNbpgbCP//r1A2yYsN1o
         VsoBULe5oCu/op1DDSe5Nz+r4hEp90bO+mhLLwSQsnlpxA+lmIHLIbZleHjrZ3/7+q
         iDqIy3gd/1Hbg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: introduce F2FS_IPU_DEFRAG to allow file defragment in IPU mode
Date:   Fri,  4 Feb 2022 00:03:37 +0800
Message-Id: <20220203160337.27152-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once IPU policy is enabled in some cases:
a) f2fs forces to use F2FS_IPU_FORCE in a small-sized volume
b) user configures IPU policy via sysfs

Then we may fail to defragment file via ioctl due to IPU policy check,
it doesn't make sense, let's introduce a new IPU policy to allow OPU
during file defragmentation, by default use IPU_DEFRAG instead of
IPU_FORCE in small-sized volume for android device.

Ater this change, generic/018 of xfstests will pass.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  3 ++-
 fs/f2fs/data.c                          | 20 +++++++++++++++-----
 fs/f2fs/f2fs.h                          |  3 ++-
 fs/f2fs/file.c                          | 18 +++++++++++-------
 fs/f2fs/segment.h                       |  4 +++-
 fs/f2fs/super.c                         |  2 +-
 6 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index ce8103f522cb..d8abb674ee86 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -55,8 +55,9 @@ Description:	Controls the in-place-update policy.
 		0x04  F2FS_IPU_UTIL
 		0x08  F2FS_IPU_SSR_UTIL
 		0x10  F2FS_IPU_FSYNC
-		0x20  F2FS_IPU_ASYNC,
+		0x20  F2FS_IPU_ASYNC
 		0x40  F2FS_IPU_NOCACHE
+		0x80  F2FS_IPU_DEFRAG
 		====  =================
 
 		Refer segment.h for details.
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b3c152de4bba..94ebee413210 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2462,6 +2462,11 @@ static inline bool check_inplace_update_policy(struct inode *inode,
 
 	if (policy & (0x1 << F2FS_IPU_FORCE))
 		return true;
+	if (policy & (0x1 << F2FS_IPU_DEFRAG)) {
+		if (is_inode_flag_set(inode, FI_DEFRAG_PROCESS))
+			return false;
+		return true;
+	}
 	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
 		return true;
 	if (policy & (0x1 << F2FS_IPU_UTIL) &&
@@ -2530,6 +2535,9 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
 		return true;
 
+	if (is_inode_flag_set(inode, FI_DEFRAG_PROCESS))
+		return true;
+
 	if (fio) {
 		if (page_private_gcing(fio->page))
 			return true;
@@ -3154,8 +3162,8 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 			f2fs_available_free_memory(sbi, DIRTY_DENTS))
 		goto skip_write;
 
-	/* skip writing during file defragment */
-	if (is_inode_flag_set(inode, FI_DO_DEFRAG))
+	/* skip writing in file defragment preparing stage */
+	if (is_inode_flag_set(inode, FI_DEFRAG_PREPARE))
 		goto skip_write;
 
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
@@ -3729,6 +3737,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 	filemap_invalidate_lock(inode->i_mapping);
 
 	set_inode_flag(inode, FI_ALIGNED_WRITE);
+	set_inode_flag(inode, FI_DEFRAG_PROCESS);
 
 	for (; secidx < end_sec; secidx++) {
 		f2fs_down_write(&sbi->pin_sem);
@@ -3737,7 +3746,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
 		f2fs_unlock_op(sbi);
 
-		set_inode_flag(inode, FI_DO_DEFRAG);
+		set_inode_flag(inode, FI_DEFRAG_PREPARE);
 
 		for (blkofs = 0; blkofs < blk_per_sec; blkofs++) {
 			struct page *page;
@@ -3754,7 +3763,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 			f2fs_put_page(page, 1);
 		}
 
-		clear_inode_flag(inode, FI_DO_DEFRAG);
+		clear_inode_flag(inode, FI_DEFRAG_PREPARE);
 
 		ret = filemap_fdatawrite(inode->i_mapping);
 
@@ -3765,7 +3774,8 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 	}
 
 done:
-	clear_inode_flag(inode, FI_DO_DEFRAG);
+	clear_inode_flag(inode, FI_DEFRAG_PREPARE);
+	clear_inode_flag(inode, FI_DEFRAG_PROCESS);
 	clear_inode_flag(inode, FI_ALIGNED_WRITE);
 
 	filemap_invalidate_unlock(inode->i_mapping);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6ddb98ff0b7c..5af415208488 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -737,7 +737,8 @@ enum {
 	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
 	FI_INLINE_DOTS,		/* indicate inline dot dentries */
-	FI_DO_DEFRAG,		/* indicate defragment is running */
+	FI_DEFRAG_PREPARE,	/* indicate defragment is preparing */
+	FI_DEFRAG_PROCESS,	/* indicate defragment is processing */
 	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
 	FI_PREALLOCATED_ALL,	/* all blocks for write were preallocated */
 	FI_HOT_DATA,		/* indicate file is hot */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6ccdd6e347e2..3a573125002b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2559,10 +2559,6 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	bool fragmented = false;
 	int err;
 
-	/* if in-place-update policy is enabled, don't waste time here */
-	if (f2fs_should_update_inplace(inode, NULL))
-		return -EINVAL;
-
 	pg_start = range->start >> PAGE_SHIFT;
 	pg_end = (range->start + range->len) >> PAGE_SHIFT;
 
@@ -2570,6 +2566,13 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	inode_lock(inode);
 
+	/* if in-place-update policy is enabled, don't waste time here */
+	set_inode_flag(inode, FI_DEFRAG_PROCESS);
+	if (f2fs_should_update_inplace(inode, NULL)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	/* writeback all dirty pages in the range */
 	err = filemap_write_and_wait_range(inode->i_mapping, range->start,
 						range->start + range->len - 1);
@@ -2651,7 +2654,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 			goto check;
 		}
 
-		set_inode_flag(inode, FI_DO_DEFRAG);
+		set_inode_flag(inode, FI_DEFRAG_PREPARE);
 
 		idx = map.m_lblk;
 		while (idx < map.m_lblk + map.m_len && cnt < blk_per_seg) {
@@ -2676,15 +2679,16 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		if (map.m_lblk < pg_end && cnt < blk_per_seg)
 			goto do_map;
 
-		clear_inode_flag(inode, FI_DO_DEFRAG);
+		clear_inode_flag(inode, FI_DEFRAG_PREPARE);
 
 		err = filemap_fdatawrite(inode->i_mapping);
 		if (err)
 			goto out;
 	}
 clear_out:
-	clear_inode_flag(inode, FI_DO_DEFRAG);
+	clear_inode_flag(inode, FI_DEFRAG_PREPARE);
 out:
+	clear_inode_flag(inode, FI_DEFRAG_PROCESS);
 	inode_unlock(inode);
 	if (!err)
 		range->len = (u64)total << PAGE_SHIFT;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 0291cd55cf09..9a45f9014dee 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -651,7 +651,8 @@ static inline int utilization(struct f2fs_sb_info *sbi)
  *                     pages over min_fsync_blocks. (=default option)
  * F2FS_IPU_ASYNC - do IPU given by asynchronous write requests.
  * F2FS_IPU_NOCACHE - disable IPU bio cache.
- * F2FS_IPUT_DISABLE - disable IPU. (=default option in LFS mode)
+ * F2FS_IPU_DEFRAG - do IPU except file defragment.
+ * F2FS_IPU_DISABLE - disable IPU. (=default option in LFS mode)
  */
 #define DEF_MIN_IPU_UTIL	70
 #define DEF_MIN_FSYNC_BLOCKS	8
@@ -667,6 +668,7 @@ enum {
 	F2FS_IPU_FSYNC,
 	F2FS_IPU_ASYNC,
 	F2FS_IPU_NOCACHE,
+	F2FS_IPU_DEFRAG,
 };
 
 static inline unsigned int curseg_segno(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9af6c20532ec..cc0429279b4c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3957,7 +3957,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
 		if (f2fs_block_unit_discard(sbi))
 			sm_i->dcc_info->discard_granularity = 1;
-		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE;
+		sm_i->ipu_policy = 1 << F2FS_IPU_DEFRAG;
 	}
 
 	sbi->readdir_ra = 1;
-- 
2.32.0

