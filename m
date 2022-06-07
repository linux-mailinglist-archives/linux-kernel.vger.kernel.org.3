Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B8753B7E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiFBLdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiFBLdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:33:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCA124BC2;
        Thu,  2 Jun 2022 04:33:33 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LDP2S5kt8zRhXB;
        Thu,  2 Jun 2022 19:30:24 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 2 Jun
 2022 19:33:31 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] ext4: fix use-after-free in ext4_xattr_set_entry
Date:   Thu, 2 Jun 2022 19:46:51 +0800
Message-ID: <20220602114651.3244889-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hulk Robot reported a issue:
==================================================================
BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x18ab/0x3500
Write of size 4105 at addr ffff8881675ef5f4 by task syz-executor.0/7092

CPU: 1 PID: 7092 Comm: syz-executor.0 Not tainted 4.19.90-dirty #17
Call Trace:
[...]
 memcpy+0x34/0x50 mm/kasan/kasan.c:303
 ext4_xattr_set_entry+0x18ab/0x3500 fs/ext4/xattr.c:1747
 ext4_xattr_ibody_inline_set+0x86/0x2a0 fs/ext4/xattr.c:2205
 ext4_xattr_set_handle+0x940/0x1300 fs/ext4/xattr.c:2386
 ext4_xattr_set+0x1da/0x300 fs/ext4/xattr.c:2498
 __vfs_setxattr+0x112/0x170 fs/xattr.c:149
 __vfs_setxattr_noperm+0x11b/0x2a0 fs/xattr.c:180
 __vfs_setxattr_locked+0x17b/0x250 fs/xattr.c:238
 vfs_setxattr+0xed/0x270 fs/xattr.c:255
 setxattr+0x235/0x330 fs/xattr.c:520
 path_setxattr+0x176/0x190 fs/xattr.c:539
 __do_sys_lsetxattr fs/xattr.c:561 [inline]
 __se_sys_lsetxattr fs/xattr.c:557 [inline]
 __x64_sys_lsetxattr+0xc2/0x160 fs/xattr.c:557
 do_syscall_64+0xdf/0x530 arch/x86/entry/common.c:298
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x459fe9
RSP: 002b:00007fa5e54b4c08 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 000000000051bf60 RCX: 0000000000459fe9
RDX: 00000000200003c0 RSI: 0000000020000180 RDI: 0000000020000140
RBP: 000000000051bf60 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000001009 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc73c93fc0 R14: 000000000051bf60 R15: 00007fa5e54b4d80
[...]
==================================================================

Above issue may happen as follows:
-------------------------------------
ext4_xattr_set
  ext4_xattr_set_handle
    ext4_xattr_ibody_find
      >> s->end < s->base
      >> no EXT4_STATE_XATTR
      >> xattr_check_inode is not executed
    ext4_xattr_ibody_set
      ext4_xattr_set_entry
       >> size_t min_offs = s->end - s->base
       >> UAF in memcpy

we can easily reproduce this problem with the following commands:
    mkfs.ext4 -F /dev/sda
    mount -o debug_want_extra_isize=128 /dev/sda /mnt
    touch /mnt/file
    setfattr -n user.cat -v `seq -s z 4096|tr -d '[:digit:]'` /mnt/file

In ext4_xattr_ibody_find, we have the following assignment logic:
  header = IHDR(inode, raw_inode)
         = raw_inode + EXT4_GOOD_OLD_INODE_SIZE + i_extra_isize
  is->s.base = IFIRST(header)
             = header + sizeof(struct ext4_xattr_ibody_header)
  is->s.end = raw_inode + s_inode_size

Obviously, when the inode does not have EXT4_status_XATTR and its
i_extra_isize is large, is->s.end may be larger than is->s.base.
In this case, the above issue may be triggered.

   EXT4_GOOD_OLD_INODE_SIZE  extra_isize  header   entry   pad   data
|---------------------------|------------|------|---------|---|--------|

As shown above, when adding an xattr to an inode, we must ensure that the
inode_size is not less than EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/inline.c | 3 +++
 fs/ext4/inode.c  | 3 +--
 fs/ext4/xattr.c  | 6 ++++--
 fs/ext4/xattr.h  | 6 ++++++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index cff52ff6549d..b8cec7cb4b08 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -35,6 +35,9 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	struct ext4_inode *raw_inode;
 	int free, min_offs;
 
+	if (!INODE_HAVE_XATTR_SPACE(inode))
+		return 0;
+
 	min_offs = EXT4_SB(inode->i_sb)->s_inode_size -
 			EXT4_GOOD_OLD_INODE_SIZE -
 			EXT4_I(inode)->i_extra_isize -
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3dce7d058985..714fa61d0afb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4685,8 +4685,7 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 	__le32 *magic = (void *)raw_inode +
 			EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize;
 
-	if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize + sizeof(__le32) <=
-	    EXT4_INODE_SIZE(inode->i_sb) &&
+	if (INODE_HAVE_XATTR_SPACE(inode) &&
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
 		return ext4_find_inline_data_nolock(inode);
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 042325349098..4a63f8386910 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2176,8 +2176,9 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	struct ext4_inode *raw_inode;
 	int error;
 
-	if (EXT4_I(inode)->i_extra_isize == 0)
+	if (!INODE_HAVE_XATTR_SPACE(inode))
 		return 0;
+
 	raw_inode = ext4_raw_inode(&is->iloc);
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
@@ -2205,8 +2206,9 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 	struct ext4_xattr_search *s = &is->s;
 	int error;
 
-	if (EXT4_I(inode)->i_extra_isize == 0)
+	if (!INODE_HAVE_XATTR_SPACE(inode))
 		return -ENOSPC;
+
 	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */);
 	if (error)
 		return error;
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 77efb9a627ad..f2b299b347f9 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -95,6 +95,12 @@ struct ext4_xattr_entry {
 
 #define EXT4_ZERO_XATTR_VALUE ((void *)-1)
 
+#define INODE_HAVE_XATTR_SPACE(inode)					\
+	((EXT4_I(inode)->i_extra_isize != 0) &&				\
+	 (EXT4_GOOD_OLD_INODE_SIZE + EXT4_I(inode)->i_extra_isize +	\
+	  sizeof(struct ext4_xattr_ibody_header) + EXT4_XATTR_PAD <=	\
+	  EXT4_INODE_SIZE((inode)->i_sb)))
+
 struct ext4_xattr_info {
 	const char *name;
 	const void *value;
-- 
2.31.1

