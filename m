Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906A65AE434
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiIFJ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiIFJ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:28:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA8578A6;
        Tue,  6 Sep 2022 02:28:28 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMKkT35zdznV69;
        Tue,  6 Sep 2022 17:25:53 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 6 Sep
 2022 17:28:25 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <djwong@kernel.org>, <dchinner@redhat.com>
CC:     <chandan.babu@oracle.com>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zengheng4@huawei.com>,
        <weiyongjun1@huawei.com>, <guoxuenan@huawei.com>
Subject: [PATCH -next] xfs: rmap: only XFS_DATA_FORK field would be set shared
Date:   Tue, 6 Sep 2022 17:35:54 +0800
Message-ID: <20220906093554.899222-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

whichfork could be one of the following 3 types:
XFS_DATA_FORK
XFS_ATTR_FORK
XFS_COW_FORK

XFS_COW_FORK is in-memory field instead of on-disk
field, which doesn't need to update in rmap_btree
(already preclude by `xfs_rmap_update_is_needed` ahead).

XFS_ATTR_FORK field doesn't support reflink share.

So here propose to set "whichfork == XFS_DATA_FORK"
as condition.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/xfs/libxfs/xfs_rmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_rmap.c b/fs/xfs/libxfs/xfs_rmap.c
index 094dfc897ebc..74b34a331cf0 100644
--- a/fs/xfs/libxfs/xfs_rmap.c
+++ b/fs/xfs/libxfs/xfs_rmap.c
@@ -2549,7 +2549,7 @@ xfs_rmap_map_extent(
 	if (!xfs_rmap_update_is_needed(tp->t_mountp, whichfork))
 		return;
 
-	if (whichfork != XFS_ATTR_FORK && xfs_is_reflink_inode(ip))
+	if (whichfork == XFS_DATA_FORK && xfs_is_reflink_inode(ip))
 		type = XFS_RMAP_MAP_SHARED;
 
 	__xfs_rmap_add(tp, type, ip->i_ino, whichfork, PREV);
@@ -2568,7 +2568,7 @@ xfs_rmap_unmap_extent(
 	if (!xfs_rmap_update_is_needed(tp->t_mountp, whichfork))
 		return;
 
-	if (whichfork != XFS_ATTR_FORK && xfs_is_reflink_inode(ip))
+	if (whichfork == XFS_DATA_FORK && xfs_is_reflink_inode(ip))
 		type = XFS_RMAP_UNMAP_SHARED;
 
 	__xfs_rmap_add(tp, type, ip->i_ino, whichfork, PREV);
@@ -2593,7 +2593,7 @@ xfs_rmap_convert_extent(
 	if (!xfs_rmap_update_is_needed(mp, whichfork))
 		return;
 
-	if (whichfork != XFS_ATTR_FORK && xfs_is_reflink_inode(ip))
+	if (whichfork == XFS_DATA_FORK && xfs_is_reflink_inode(ip))
 		type = XFS_RMAP_CONVERT_SHARED;
 
 	__xfs_rmap_add(tp, type, ip->i_ino, whichfork, PREV);
-- 
2.25.1

