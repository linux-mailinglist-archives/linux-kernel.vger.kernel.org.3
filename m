Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B600A5A0926
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiHYGum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbiHYGu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1977F2A246
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B11F9619CB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DD0C433C1;
        Thu, 25 Aug 2022 06:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661410224;
        bh=DrccC7ylO4/DdFvmZTVW+Z5UzGv6H0Hfddj9XoE84jQ=;
        h=From:To:Cc:Subject:Date:From;
        b=vMYz/2zaFP9uEgMNuOEPMkRu9PguAD1D1rxxyHprSe/VPrNk1xtZgGrAPzMNRdrda
         l4ryTTwabGVYVi0Hr40Npc6nZsbAT9xdeiORi6fcX8CLRttQNni1uAtqN5aKZL9Cig
         MLZl9h25w8489NEKe04mS2pEkScpm5w7a5fWrfG8eQyCiR235g/31KazkDf2mkiafG
         Buxl3Auj2pwjd/gD6PK2WO8JjvCpVMGU2hf2hymT6IQRQfv/562BI0OXuYXpypSfqV
         SDWhFRLpy2oxAQ97CdvgWUeyRI4m4qhfRW/HWw+19xTUFfdINsEovZP5ZWzOxhCp60
         3OncKen3d5krA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: account swapfile inodes
Date:   Thu, 25 Aug 2022 14:50:14 +0800
Message-Id: <20220825065014.1842769-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao.yu@oppo.com>

In order to check count of opened swapfile inodes.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/data.c  | 2 ++
 fs/f2fs/debug.c | 3 +++
 fs/f2fs/f2fs.h  | 9 ++++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0869fbbb5516..66f34cd559c6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3970,6 +3970,7 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (ret < 0)
 		return ret;
 
+	stat_inc_swapfile_inode(inode);
 	set_inode_flag(inode, FI_PIN_FILE);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return ret;
@@ -3979,6 +3980,7 @@ static void f2fs_swap_deactivate(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 
+	stat_dec_swapfile_inode(inode);
 	clear_inode_flag(inode, FI_PIN_FILE);
 }
 #else
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index c01471573977..88231d393b7c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -135,6 +135,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->inline_inode = atomic_read(&sbi->inline_inode);
 	si->inline_dir = atomic_read(&sbi->inline_dir);
 	si->compr_inode = atomic_read(&sbi->compr_inode);
+	si->swapfile_inode = atomic_read(&sbi->swapfile_inode);
 	si->compr_blocks = atomic64_read(&sbi->compr_blocks);
 	si->append = sbi->im[APPEND_INO].ino_num;
 	si->update = sbi->im[UPDATE_INO].ino_num;
@@ -385,6 +386,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->inline_dir);
 		seq_printf(s, "  - Compressed Inode: %u, Blocks: %llu\n",
 			   si->compr_inode, si->compr_blocks);
+		seq_printf(s, "  - Swapfile Inode: %u\n",
+			   si->swapfile_inode);
 		seq_printf(s, "  - Orphan/Append/Update Inode: %u, %u, %u\n",
 			   si->orphans, si->append, si->update);
 		seq_printf(s, "\nMain area: %d segs, %d secs %d zones\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 088c3d1574b8..408d8034ed74 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1765,6 +1765,7 @@ struct f2fs_sb_info {
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
 	atomic_t compr_inode;			/* # of compressed inodes */
 	atomic64_t compr_blocks;		/* # of compressed blocks */
+	atomic_t swapfile_inode;		/* # of swapfile inodes */
 	atomic_t max_aw_cnt;			/* max # of atomic writes */
 	unsigned int io_skip_bggc;		/* skip background gc for in-flight IO */
 	unsigned int other_skip_bggc;		/* skip background gc for other reasons */
@@ -3863,7 +3864,7 @@ struct f2fs_stat_info {
 	int nr_issued_ckpt, nr_total_ckpt, nr_queued_ckpt;
 	unsigned int cur_ckpt_time, peak_ckpt_time;
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
-	int compr_inode;
+	int compr_inode, swapfile_inode;
 	unsigned long long compr_blocks;
 	int aw_cnt, max_aw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
@@ -3952,6 +3953,10 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		(atomic64_add(blocks, &F2FS_I_SB(inode)->compr_blocks))
 #define stat_sub_compr_blocks(inode, blocks)				\
 		(atomic64_sub(blocks, &F2FS_I_SB(inode)->compr_blocks))
+#define stat_inc_swapfile_inode(inode)					\
+		(atomic_inc(&F2FS_I_SB(inode)->swapfile_inode))
+#define stat_dec_swapfile_inode(inode)					\
+		(atomic_dec(&F2FS_I_SB(inode)->swapfile_inode))
 #define stat_inc_meta_count(sbi, blkaddr)				\
 	do {								\
 		if (blkaddr < SIT_I(sbi)->sit_base_addr)		\
@@ -4036,6 +4041,8 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #define stat_dec_compr_inode(inode)			do { } while (0)
 #define stat_add_compr_blocks(inode, blocks)		do { } while (0)
 #define stat_sub_compr_blocks(inode, blocks)		do { } while (0)
+#define stat_inc_swapfile_inode(inode)			do { } while (0)
+#define stat_dec_swapfile_inode(inode)			do { } while (0)
 #define stat_update_max_atomic_write(inode)		do { } while (0)
 #define stat_inc_meta_count(sbi, blkaddr)		do { } while (0)
 #define stat_inc_seg_type(sbi, curseg)			do { } while (0)
-- 
2.25.1

