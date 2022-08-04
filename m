Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935E4589CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbiHDNic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239894AbiHDNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA2546DB6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B6BB61857
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D27C43470;
        Thu,  4 Aug 2022 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659620307;
        bh=hN2vEO4O/RvdzytpOp5hZlT0WPlhC+8EIeeNd6NtzWM=;
        h=From:To:Cc:Subject:Date:From;
        b=vEO7LCpnnTN4wEaaBckHs4gKI2ONgjZrC9+As7jIamWjQfiMMDB96I0MtAo5BcRt5
         OafC53uM3ndnZfUx63ff1gb79www5f2Ql09t3Ef8AdWNz+tQH7dEY30c9BpqQyZARu
         utou3Tj4q0xZvGbKtjTOcHFZiNx09rvr742ZoyMziKSTHJKw3Ml319QBiuAQVEgMCy
         Yl6pw89TJqJSmNdAKl9xwdRtrGtaDJxk48K7r+wamUIVFqrRIIwK7hexRoz6L9YNB1
         iAREsXnKnCNEUJ1TNjsv6yzaOjuqMobMrKo5d5hVTur6cSDf3Z1JbNPfmU0AR48xdw
         mNTCyx1H8fLzg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: clean up f2fs_abort_atomic_write()
Date:   Thu,  4 Aug 2022 21:38:21 +0800
Message-Id: <20220804133821.13956-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao.yu@oppo.com>

f2fs_abort_atomic_write() has checked whether current inode is
atomic_write one or not, it's redundant to check in its caller,
remove it for cleanup.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/file.c    |  9 +++------
 fs/f2fs/inode.c   |  3 +--
 fs/f2fs/segment.c | 27 ++++++++++++++-------------
 fs/f2fs/super.c   |  3 +--
 4 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0c984718f3c5..24f5b02c78e7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1822,8 +1822,7 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 			atomic_read(&inode->i_writecount) != 1)
 		return 0;
 
-	if (f2fs_is_atomic_file(inode))
-		f2fs_abort_atomic_write(inode, true);
+	f2fs_abort_atomic_write(inode, true);
 	return 0;
 }
 
@@ -1837,8 +1836,7 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
 	 * until all the writers close its file. Since this should be done
 	 * before dropping file lock, it needs to do in ->flush.
 	 */
-	if (f2fs_is_atomic_file(inode) &&
-			F2FS_I(inode)->atomic_write_task == current)
+	if (F2FS_I(inode)->atomic_write_task == current)
 		f2fs_abort_atomic_write(inode, true);
 	return 0;
 }
@@ -2124,8 +2122,7 @@ static int f2fs_ioc_abort_atomic_write(struct file *filp)
 
 	inode_lock(inode);
 
-	if (f2fs_is_atomic_file(inode))
-		f2fs_abort_atomic_write(inode, true);
+	f2fs_abort_atomic_write(inode, true);
 
 	inode_unlock(inode);
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index fc55f5bd1fcc..6d11c365d7b4 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -744,8 +744,7 @@ void f2fs_evict_inode(struct inode *inode)
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	int err = 0;
 
-	if (f2fs_is_atomic_file(inode))
-		f2fs_abort_atomic_write(inode, true);
+	f2fs_abort_atomic_write(inode, true);
 
 	trace_f2fs_evict_inode(inode);
 	truncate_inode_pages_final(&inode->i_data);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f14c5a807312..72ce00ebcede 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -190,19 +190,20 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
-	if (f2fs_is_atomic_file(inode)) {
-		if (clean)
-			truncate_inode_pages_final(inode->i_mapping);
-		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
-		iput(fi->cow_inode);
-		fi->cow_inode = NULL;
-		release_atomic_write_cnt(inode);
-		clear_inode_flag(inode, FI_ATOMIC_FILE);
-
-		spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
-		sbi->atomic_files--;
-		spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
-	}
+	if (!f2fs_is_atomic_file(inode))
+		return;
+
+	if (clean)
+		truncate_inode_pages_final(inode->i_mapping);
+	clear_inode_flag(fi->cow_inode, FI_COW_FILE);
+	iput(fi->cow_inode);
+	fi->cow_inode = NULL;
+	release_atomic_write_cnt(inode);
+	clear_inode_flag(inode, FI_ATOMIC_FILE);
+
+	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
+	sbi->atomic_files--;
+	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 }
 
 static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1c6203798fb4..1a0578a3f4e4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1411,8 +1411,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			atomic_inc(&inode->i_count);
 			spin_unlock(&inode->i_lock);
 
-			if (f2fs_is_atomic_file(inode))
-				f2fs_abort_atomic_write(inode, true);
+			f2fs_abort_atomic_write(inode, true);
 
 			/* should remain fi->extent_tree for writepage */
 			f2fs_destroy_extent_node(inode);
-- 
2.36.1

