Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8B1502791
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349161AbiDOJrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiDOJru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:47:50 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECA378901
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:45:22 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1650015920; bh=Lf5M/7owMt0p8F5u9OJM+aS4FoUeFmgJQU0yNRZHPFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Di1AIj7cUfAYBEoSUGvadGfJocVDFulCIY219fAZY/ST5ZWsPxzmS9VimRra1c5eW
         JKo9u4R7LXUdpfSWRpz2iWFUwdhRPbLb/jXqn4kjIIU5yKl6wqLatp9/XXkhQiLzjg
         5WX244smaLmdNQs9Cihppil4XAACMAtfRz5kUQTE=
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-kernel@vger.kernel.org, kernel@cccheng.net,
        shepjeng@gmail.com, Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v3 3/3] fat: report creation time in statx
Date:   Fri, 15 Apr 2022 17:45:18 +0800
Message-Id: <20220415094518.380543-3-cccheng@synology.com>
In-Reply-To: <20220415094518.380543-1-cccheng@synology.com>
References: <20220415094518.380543-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

creation time is no longer mixed with change time. Add a in-memory
field for it, and report it in statx if supported.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/fat/fat.h   |  1 +
 fs/fat/file.c  | 14 +++++++++++---
 fs/fat/inode.c | 12 ++++++++++--
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 508b4f2a1ffb..e4409ee82ea9 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -126,6 +126,7 @@ struct msdos_inode_info {
 	struct hlist_node i_fat_hash;	/* hash by i_location */
 	struct hlist_node i_dir_hash;	/* hash by i_logstart */
 	struct rw_semaphore truncate_lock; /* protect bmap against truncate */
+	struct timespec64 i_crtime;	/* File creation (birth) time */
 	struct inode vfs_inode;
 };
 
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 178c1dde3488..7a4f617d4928 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -399,13 +399,21 @@ int fat_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+
 	generic_fillattr(mnt_userns, inode, stat);
-	stat->blksize = MSDOS_SB(inode->i_sb)->cluster_size;
+	stat->blksize = sbi->cluster_size;
 
-	if (MSDOS_SB(inode->i_sb)->options.nfs == FAT_NFS_NOSTALE_RO) {
+	if (sbi->options.nfs == FAT_NFS_NOSTALE_RO) {
 		/* Use i_pos for ino. This is used as fileid of nfs. */
-		stat->ino = fat_i_pos_read(MSDOS_SB(inode->i_sb), inode);
+		stat->ino = fat_i_pos_read(sbi, inode);
 	}
+
+	if (sbi->options.isvfat && request_mask & STATX_BTIME) {
+		stat->result_mask |= STATX_BTIME;
+		stat->btime = MSDOS_I(inode)->i_crtime;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fat_getattr);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index f2ac55cd4ea4..23fac3181fa7 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -568,10 +568,14 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 
 	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
 	inode->i_ctime = inode->i_mtime;
-	if (sbi->options.isvfat)
+	if (sbi->options.isvfat) {
 		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
-	else
+		fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
+				  de->cdate, de->ctime_cs);
+	} else {
 		fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime);
+		fat_truncate_crtime(sbi, &inode->i_mtime, &MSDOS_I(inode)->i_crtime);
+	}
 
 	return 0;
 }
@@ -756,6 +760,8 @@ static struct inode *fat_alloc_inode(struct super_block *sb)
 	ei->i_logstart = 0;
 	ei->i_attrs = 0;
 	ei->i_pos = 0;
+	ei->i_crtime.tv_sec = 0;
+	ei->i_crtime.tv_nsec = 0;
 
 	return &ei->vfs_inode;
 }
@@ -887,6 +893,8 @@ static int __fat_write_inode(struct inode *inode, int wait)
 			  &raw_entry->date, NULL);
 	if (sbi->options.isvfat) {
 		__le16 atime;
+		fat_time_unix2fat(sbi, &MSDOS_I(inode)->i_crtime, &raw_entry->ctime,
+				  &raw_entry->cdate, &raw_entry->ctime_cs);
 		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
 				  &raw_entry->adate, NULL);
 	}
-- 
2.34.1

