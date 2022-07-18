Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DDF5780A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiGRLX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiGRLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:23:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743442DE5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:23:53 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LmffY5sjVz1M7wX;
        Mon, 18 Jul 2022 19:21:09 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Jul
 2022 19:23:50 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next RFC] f2fs: fix null-ptr-deref in f2fs_get_dnode_of_data
Date:   Mon, 18 Jul 2022 19:36:09 +0800
Message-ID: <20220718113609.154371-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
To solve above issue, don't mark cow_inode as FI_ATOMIC_FILE.

Fiexes: 3db1de0e582c("f2fs: change the current atomic write way")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/f2fs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 466eb00aa516..735802b6b754 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2062,7 +2062,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 
 	set_inode_flag(inode, FI_ATOMIC_FILE);
-	set_inode_flag(fi->cow_inode, FI_ATOMIC_FILE);
 	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
-- 
2.31.1

