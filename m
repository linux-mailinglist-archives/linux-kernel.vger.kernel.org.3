Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE7559CE05
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbiHWBrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiHWBrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:47:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4DD5A828;
        Mon, 22 Aug 2022 18:47:20 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MBX7p61Ttz1N7TJ;
        Tue, 23 Aug 2022 09:43:50 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 09:47:18 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <djwong@kernel.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zengheng4@huawei.com>
Subject: [PATCH -next] xfs: remove "%Lu" which doesn't meet C standard
Date:   Tue, 23 Aug 2022 09:55:17 +0800
Message-ID: <20220823015517.4160583-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The "%Lu" specifier, which represents long long unsigned,
doesn't meet C language standard, and even more,
it makes people easily mistake with "%lu", which represent
long unsigned. So replace "%Lu" with "llu".

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/xfs/xfs_inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 28493c8e9bb2..b3eeeae3afe1 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3119,7 +3119,7 @@ xfs_iflush(
 	if (XFS_TEST_ERROR(dip->di_magic != cpu_to_be16(XFS_DINODE_MAGIC),
 			       mp, XFS_ERRTAG_IFLUSH_1)) {
 		xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
-			"%s: Bad inode %Lu magic number 0x%x, ptr "PTR_FMT,
+			"%s: Bad inode %llu magic number 0x%x, ptr "PTR_FMT,
 			__func__, ip->i_ino, be16_to_cpu(dip->di_magic), dip);
 		goto flush_out;
 	}
@@ -3129,7 +3129,7 @@ xfs_iflush(
 		    ip->i_df.if_format != XFS_DINODE_FMT_BTREE,
 		    mp, XFS_ERRTAG_IFLUSH_3)) {
 			xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
-				"%s: Bad regular inode %Lu, ptr "PTR_FMT,
+				"%s: Bad regular inode %llu, ptr "PTR_FMT,
 				__func__, ip->i_ino, ip);
 			goto flush_out;
 		}
@@ -3140,7 +3140,7 @@ xfs_iflush(
 		    ip->i_df.if_format != XFS_DINODE_FMT_LOCAL,
 		    mp, XFS_ERRTAG_IFLUSH_4)) {
 			xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
-				"%s: Bad directory inode %Lu, ptr "PTR_FMT,
+				"%s: Bad directory inode %llu, ptr "PTR_FMT,
 				__func__, ip->i_ino, ip);
 			goto flush_out;
 		}
@@ -3158,7 +3158,7 @@ xfs_iflush(
 	if (XFS_TEST_ERROR(ip->i_forkoff > mp->m_sb.sb_inodesize,
 				mp, XFS_ERRTAG_IFLUSH_6)) {
 		xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
-			"%s: bad inode %Lu, forkoff 0x%x, ptr "PTR_FMT,
+			"%s: bad inode %llu, forkoff 0x%x, ptr "PTR_FMT,
 			__func__, ip->i_ino, ip->i_forkoff, ip);
 		goto flush_out;
 	}
-- 
2.25.1

