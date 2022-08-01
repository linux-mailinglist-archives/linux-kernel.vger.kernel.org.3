Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76545867F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiHALOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiHALOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:14:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144FC6245
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:14:08 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LxFlM5JbRzWfRP;
        Mon,  1 Aug 2022 19:10:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 1 Aug
 2022 19:14:05 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v2] f2fs: fix null-ptr-deref in f2fs_get_dnode_of_data
Date:   Mon, 1 Aug 2022 19:26:04 +0800
Message-ID: <20220801112604.3406642-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is issue as follows when test f2fs atomic write:
F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th superblock
F2FS-fs (loop0): invalid crc_offset: 0
F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=1, run fsck to fix.
F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=2, run fsck to fix.
==================================================================
BUG: KASAN: null-ptr-deref in f2fs_get_dnode_of_data+0xac/0x16d0
Read of size 8 at addr 0000000000000028 by task rep/1990

CPU: 4 PID: 1990 Comm: rep Not tainted 5.19.0-rc6-next-20220715 #266
Call Trace:
 <TASK>
 dump_stack_lvl+0x6e/0x91
 print_report.cold+0x49a/0x6bb
 kasan_report+0xa8/0x130
 f2fs_get_dnode_of_data+0xac/0x16d0
 f2fs_do_write_data_page+0x2a5/0x1030
 move_data_page+0x3c5/0xdf0
 do_garbage_collect+0x2015/0x36c0
 f2fs_gc+0x554/0x1d30
 f2fs_balance_fs+0x7f5/0xda0
 f2fs_write_single_data_page+0xb66/0xdc0
 f2fs_write_cache_pages+0x716/0x1420
 f2fs_write_data_pages+0x84f/0x9a0
 do_writepages+0x130/0x3a0
 filemap_fdatawrite_wbc+0x87/0xa0
 file_write_and_wait_range+0x157/0x1c0
 f2fs_do_sync_file+0x206/0x12d0
 f2fs_sync_file+0x99/0xc0
 vfs_fsync_range+0x75/0x140
 f2fs_file_write_iter+0xd7b/0x1850
 vfs_write+0x645/0x780
 ksys_write+0xf1/0x1e0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

As 3db1de0e582c commit changed atomic write way which new a cow_inode for
atomic write file, and also mark cow_inode as FI_ATOMIC_FILE.
When f2fs_do_write_data_page write cow_inode will use cow_inode's cow_inode
which is NULL. Then will trigger null-ptr-deref.
To solve above issue, introduce FI_COW_FILE flag for COW inode.

Fiexes: 3db1de0e582c("f2fs: change the current atomic write way")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/f2fs/f2fs.h    | 6 ++++++
 fs/f2fs/file.c    | 2 +-
 fs/f2fs/segment.c | 5 +++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8579b59b8a05..101f0064ee25 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -758,6 +758,7 @@ enum {
 	FI_ENABLE_COMPRESS,	/* enable compression in "user" compression mode */
 	FI_COMPRESS_RELEASED,	/* compressed blocks were released */
 	FI_ALIGNED_WRITE,	/* enable aligned write */
+	FI_COW_FILE,		/* indicate COW file */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -3207,6 +3208,11 @@ static inline bool f2fs_is_atomic_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_ATOMIC_FILE);
 }
 
+static inline bool f2fs_is_cow_file(struct inode *inode)
+{
+	return is_inode_flag_set(inode, FI_COW_FILE);
+}
+
 static inline bool f2fs_is_first_block_written(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_FIRST_BLOCK_WRITTEN);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a90184900698..973a479f9a3d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2062,7 +2062,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 
 	set_inode_flag(inode, FI_ATOMIC_FILE);
-	set_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
+	set_inode_flag(fi->cow_inode, FI_COW_FILE);
 	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 44a04a832e24..6d5fc221ef35 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -193,7 +193,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (f2fs_is_atomic_file(inode)) {
 		if (clean)
 			truncate_inode_pages_final(inode->i_mapping);
-		clear_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
+		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
 		iput(fi->cow_inode);
 		fi->cow_inode = NULL;
 		clear_inode_flag(inode, FI_ATOMIC_FILE);
@@ -3166,7 +3166,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			return CURSEG_COLD_DATA;
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
-				f2fs_is_atomic_file(inode))
+				f2fs_is_atomic_file(inode) ||
+				f2fs_is_cow_file(inode))
 			return CURSEG_HOT_DATA;
 		return f2fs_rw_hint_to_seg_type(inode->i_write_hint);
 	} else {
-- 
2.31.1

