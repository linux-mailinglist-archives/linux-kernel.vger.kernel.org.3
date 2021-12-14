Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE07473B76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhLNDXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:23:24 -0500
Received: from prt-mail.chinatelecom.cn ([42.123.76.226]:38641 "EHLO
        chinatelecom.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229766AbhLNDXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:23:23 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 22:23:22 EST
HMM_SOURCE_IP: 172.18.0.218:40440.34997284
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-182.42.116.25 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id 329C32801B4;
        Tue, 14 Dec 2021 11:15:51 +0800 (CST)
X-189-SAVE-TO-SEND: +renlei1@chinatelecom.cn
Received: from  ([172.18.0.218])
        by app0025 with ESMTP id 30ac11a29d4845bbaf02b14e60180864 for djwong@kernel.org;
        Tue, 14 Dec 2021 11:15:57 CST
X-Transaction-ID: 30ac11a29d4845bbaf02b14e60180864
X-Real-From: renlei1@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: renlei1@chinatelecom.cn
From:   renlei1@chinatelecom.cn
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ren Lei <renlei1@chinatelecom.cn>
Subject: [PATCH] xfs: not allow rename if src is quota enabled and project IDs are different
Date:   Tue, 14 Dec 2021 11:15:17 +0800
Message-Id: <20211214031517.508012-1-renlei1@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ren Lei <renlei1@chinatelecom.cn>

xfs not allow rename if target is using project inheritance and
project IDs are different to avoid tree quota mechanism not work.

But if only src with directory quota enabled, rename to other directory
without quota enabled can succeed and skip quota mechanism. which might
result to unexpected quota behavior.

This patch fix this by disable rename if src is using project inheritance
and the project IDs are not the same.

following steps can easy reproduce this issue:
1. first init a directory quota /mnt/test
	mount -o prjquota /dev/sdb  /mnt
	mkdir /mnt/test
	echo 1:/mnt/test >> /etc/projects
	echo test:1 >> /etc/projid
	xfs_quota -x -c 'project -s test' /mnt
	xfs_quota -x -c 'limit -p bhard=10m test' /mnt

2. fill /mnt/test with tesfile util directory full:
	[root@rhost1 test]# dd if=/dev/zero of=/mnt/test/testfile
	dd: writing to '/mnt/test/testfile': No space left on device

3. mv testfile out to /mnt,  test is empty but cannot create files:
	[root@rhost1 test]# mv testfile ../
	[root@rhost1 test]# ls -a
	.  ..
	[root@rhost1 test]# touch aaa
	touch: cannot touch 'aaa': Disk quota exceeded

Signed-off-by: Ren Lei <renlei1@chinatelecom.cn>
---
 fs/xfs/xfs_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 6771f357ad2c..f8c115b014f9 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3177,7 +3177,8 @@ xfs_rename(
 	 * into our tree when the project IDs are the same; else the
 	 * tree quota mechanism would be circumvented.
 	 */
-	if (unlikely((target_dp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
+	if (unlikely((target_dp->i_diflags & XFS_DIFLAG_PROJINHERIT ||
+		     src_dp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
 		     target_dp->i_projid != src_ip->i_projid)) {
 		error = -EXDEV;
 		goto out_trans_cancel;
-- 
2.27.0

