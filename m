Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC7858224E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiG0IlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiG0Ik7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:40:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7F7459BB;
        Wed, 27 Jul 2022 01:40:57 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lt6cY6bDSzkYKB;
        Wed, 27 Jul 2022 16:38:21 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 16:40:49 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Jul
 2022 16:40:47 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <djwong@kernel.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <guoxuenan@huawei.com>,
        <liuyongqiang13@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] xfs: fix NULL pointer dereference in xfs_getbmap()
Date:   Wed, 27 Jul 2022 16:52:30 +0800
Message-ID: <20220727085230.4073478-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reproducer:
 1. fallocate -l 100M image
 2. mkfs.xfs -f image
 3. mount image /mnt
 4. setxattr("/mnt", "trusted.overlay.upper", NULL, 0, XATTR_CREATE)
 5. char arg[32] = "\x01\xff\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00"
                   "\x00\x00\x00\x00\x00\x08\x00\x00\x00\xc6\x2a\xf7";
    fd = open("/mnt", O_RDONLY|O_DIRECTORY);
    ioctl(fd, _IOC(_IOC_READ|_IOC_WRITE, 0x58, 0x2c, 0x20), arg);

NULL pointer dereference will occur when race happens between xfs_getbmap()
and xfs_bmap_set_attrforkoff():

         ioctl               |       setxattr
 ----------------------------|---------------------------
 xfs_getbmap                 |
   xfs_ifork_ptr             |
     xfs_inode_has_attr_fork |
       ip->i_forkoff == 0    |
     return NULL             |
   ifp == NULL               |
                             | xfs_bmap_set_attrforkoff
                             |   ip->i_forkoff > 0
   xfs_inode_has_attr_fork   |
     ip->i_forkoff > 0       |
   ifp == NULL               |
   ifp->if_format            |

Fix this by locking i_lock before xfs_ifork_ptr().

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 fs/xfs/xfs_bmap_util.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 74f96e1aa5cd..04d0c2bff67c 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -439,29 +439,28 @@ xfs_getbmap(
 		whichfork = XFS_COW_FORK;
 	else
 		whichfork = XFS_DATA_FORK;
-	ifp = xfs_ifork_ptr(ip, whichfork);
 
 	xfs_ilock(ip, XFS_IOLOCK_SHARED);
 	switch (whichfork) {
 	case XFS_ATTR_FORK:
+		lock = xfs_ilock_attr_map_shared(ip);
 		if (!xfs_inode_has_attr_fork(ip))
-			goto out_unlock_iolock;
+			goto out_unlock_ilock;
 
 		max_len = 1LL << 32;
-		lock = xfs_ilock_attr_map_shared(ip);
 		break;
 	case XFS_COW_FORK:
+		lock = XFS_ILOCK_SHARED;
+		xfs_ilock(ip, lock);
+
 		/* No CoW fork? Just return */
-		if (!ifp)
-			goto out_unlock_iolock;
+		if (!xfs_ifork_ptr(ip, whichfork))
+			goto out_unlock_ilock;
 
 		if (xfs_get_cowextsz_hint(ip))
 			max_len = mp->m_super->s_maxbytes;
 		else
 			max_len = XFS_ISIZE(ip);
-
-		lock = XFS_ILOCK_SHARED;
-		xfs_ilock(ip, lock);
 		break;
 	case XFS_DATA_FORK:
 		if (!(iflags & BMV_IF_DELALLOC) &&
@@ -491,6 +490,8 @@ xfs_getbmap(
 		break;
 	}
 
+	ifp = xfs_ifork_ptr(ip, whichfork);
+
 	switch (ifp->if_format) {
 	case XFS_DINODE_FMT_EXTENTS:
 	case XFS_DINODE_FMT_BTREE:
-- 
2.31.1

