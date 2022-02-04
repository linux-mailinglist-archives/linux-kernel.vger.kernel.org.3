Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A54A91AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356201AbiBDAeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355928AbiBDAeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:34:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22D3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:34:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3318ACE21B8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950AAC340E8;
        Fri,  4 Feb 2022 00:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643934854;
        bh=nQnosq7piKjUNQnT37l53MUyvUvNTsbl9ttaBqRjjRk=;
        h=From:To:Cc:Subject:Date:From;
        b=fwOEjSG9Iz3YhR1Dt/UhLkOb6/j8lKCW46HWX3Xz39XLpDGMWWl770h/9m0yk2HSz
         o6D144z6f/e6JVeRLPBVqTWsnS6WWsNgQiW6yQDsuOXbMvSYNPyA75HqhOlf9pvniU
         Hqy6yiqFlgBwHLRB2zFKousi3eIvDOPqAZbiJNTgXf60DU5F1bYxY66tzYgsrft54m
         2Agc8ZO6U5RWzcJrWkdiL5RPttq4UuxvEbGHCXkhBbWFo0zu242xh4Omf7KmvyJH9u
         +P4GG/+4Ki+BVq4+VmxfCRvnkjwWZJS/fvkhEHkzleYWGzXoqXtLtTm21u0shgBpNS
         4GaZqnh29xWPg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: adjust readahead block number during recovery
Date:   Fri,  4 Feb 2022 08:34:10 +0800
Message-Id: <20220204003410.41366-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a fragmented image, entries in dnode block list may locate in
incontiguous physical block address space, however, in recovery flow,
we will always readahead BIO_MAX_VECS size blocks, so in such case,
current readahead policy is low efficient, let's adjust readahead
window size dynamically based on consecutiveness of dnode blocks.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix wrong parameter of min_t/max_t in adjust_por_ra_blocks().
 fs/f2fs/checkpoint.c |  8 ++++++--
 fs/f2fs/f2fs.h       |  6 +++++-
 fs/f2fs/recovery.c   | 27 ++++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 57a2d9164bee..203a1577942d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -282,18 +282,22 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 	return blkno - start;
 }
 
-void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index)
+void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index,
+							unsigned int ra_blocks)
 {
 	struct page *page;
 	bool readahead = false;
 
+	if (ra_blocks == RECOVERY_MIN_RA_BLOCKS)
+		return;
+
 	page = find_get_page(META_MAPPING(sbi), index);
 	if (!page || !PageUptodate(page))
 		readahead = true;
 	f2fs_put_page(page, 0);
 
 	if (readahead)
-		f2fs_ra_meta_pages(sbi, index, BIO_MAX_VECS, META_POR, true);
+		f2fs_ra_meta_pages(sbi, index, ra_blocks, META_POR, true);
 }
 
 static int __f2fs_write_meta_page(struct page *page,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5af415208488..1fa6b3f98a71 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -590,6 +590,9 @@ enum {
 /* number of extent info in extent cache we try to shrink */
 #define EXTENT_CACHE_SHRINK_NUMBER	128
 
+#define RECOVERY_MAX_RA_BLOCKS		BIO_MAX_VECS
+#define RECOVERY_MIN_RA_BLOCKS		1
+
 struct rb_entry {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
 	union {
@@ -3655,7 +3658,8 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type);
 int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			int type, bool sync);
-void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index);
+void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index,
+							unsigned int ra_blocks);
 long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 			long nr_to_write, enum iostat_type io_type);
 void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index f69b685fb2b2..013e99c6671d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -346,6 +346,19 @@ static int recover_inode(struct inode *inode, struct page *page)
 	return 0;
 }
 
+static unsigned int adjust_por_ra_blocks(struct f2fs_sb_info *sbi,
+				unsigned int ra_blocks, unsigned int blkaddr,
+				unsigned int next_blkaddr)
+{
+	if (blkaddr + 1 == next_blkaddr)
+		ra_blocks = min_t(unsigned int, RECOVERY_MAX_RA_BLOCKS,
+							ra_blocks * 2);
+	else if (next_blkaddr % sbi->blocks_per_seg)
+		ra_blocks = max_t(unsigned int, RECOVERY_MIN_RA_BLOCKS,
+							ra_blocks / 2);
+	return ra_blocks;
+}
+
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 				bool check_only)
 {
@@ -353,6 +366,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	struct page *page = NULL;
 	block_t blkaddr;
 	unsigned int loop_cnt = 0;
+	unsigned int ra_blocks = RECOVERY_MAX_RA_BLOCKS;
 	unsigned int free_blocks = MAIN_SEGS(sbi) * sbi->blocks_per_seg -
 						valid_user_blocks(sbi);
 	int err = 0;
@@ -427,11 +441,14 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			break;
 		}
 
+		ra_blocks = adjust_por_ra_blocks(sbi, ra_blocks, blkaddr,
+						next_blkaddr_of_node(page));
+
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
 		f2fs_put_page(page, 1);
 
-		f2fs_ra_meta_pages_cond(sbi, blkaddr);
+		f2fs_ra_meta_pages_cond(sbi, blkaddr, ra_blocks);
 	}
 	return err;
 }
@@ -707,6 +724,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 	struct page *page = NULL;
 	int err = 0;
 	block_t blkaddr;
+	unsigned int ra_blocks = RECOVERY_MAX_RA_BLOCKS;
 
 	/* get node pages in the current segment */
 	curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
@@ -718,8 +736,6 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
 			break;
 
-		f2fs_ra_meta_pages_cond(sbi, blkaddr);
-
 		page = f2fs_get_tmp_page(sbi, blkaddr);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
@@ -762,9 +778,14 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		if (entry->blkaddr == blkaddr)
 			list_move_tail(&entry->list, tmp_inode_list);
 next:
+		ra_blocks = adjust_por_ra_blocks(sbi, ra_blocks, blkaddr,
+						next_blkaddr_of_node(page));
+
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
 		f2fs_put_page(page, 1);
+
+		f2fs_ra_meta_pages_cond(sbi, blkaddr, ra_blocks);
 	}
 	if (!err)
 		f2fs_allocate_new_segments(sbi);
-- 
2.32.0

