Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545F85A657C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiH3Ntp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiH3Nsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:48:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B831037F6;
        Tue, 30 Aug 2022 06:46:42 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MH7mg5DSGzlWYp;
        Tue, 30 Aug 2022 21:43:15 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 21:46:38 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <djwong@kernel.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zengheng4@huawei.com>
Subject: [PATCH -next] xfs: remove "%Ld" which doesn't meet C standard
Date:   Tue, 30 Aug 2022 21:54:22 +0800
Message-ID: <20220830135422.2734749-1-zengheng4@huawei.com>
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

The "%Ld" specifier, which represents long long unsigned,
doesn't meet C language standard, and even more,
it makes people easily mistake with "%ld", which represent
long unsigned. So replace "%Ld" with "lld".

Do the same with "%Lu".

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/xfs/xfs_inode_item_recover.c | 4 ++--
 fs/xfs/xfs_stats.c              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_inode_item_recover.c b/fs/xfs/xfs_inode_item_recover.c
index d28ffaebd067..0e5dba2343ea 100644
--- a/fs/xfs/xfs_inode_item_recover.c
+++ b/fs/xfs/xfs_inode_item_recover.c
@@ -321,7 +321,7 @@ xlog_recover_inode_commit_pass2(
 	 */
 	if (XFS_IS_CORRUPT(mp, !xfs_verify_magic16(bp, dip->di_magic))) {
 		xfs_alert(mp,
-	"%s: Bad inode magic number, dip = "PTR_FMT", dino bp = "PTR_FMT", ino = %Ld",
+	"%s: Bad inode magic number, dip = "PTR_FMT", dino bp = "PTR_FMT", ino = %lld",
 			__func__, dip, bp, in_f->ilf_ino);
 		error = -EFSCORRUPTED;
 		goto out_release;
@@ -329,7 +329,7 @@ xlog_recover_inode_commit_pass2(
 	ldip = item->ri_buf[1].i_addr;
 	if (XFS_IS_CORRUPT(mp, ldip->di_magic != XFS_DINODE_MAGIC)) {
 		xfs_alert(mp,
-			"%s: Bad inode log record, rec ptr "PTR_FMT", ino %Ld",
+			"%s: Bad inode log record, rec ptr "PTR_FMT", ino %lld",
 			__func__, item, in_f->ilf_ino);
 		error = -EFSCORRUPTED;
 		goto out_release;
diff --git a/fs/xfs/xfs_stats.c b/fs/xfs/xfs_stats.c
index 70d38b77682b..90a77cd3ebad 100644
--- a/fs/xfs/xfs_stats.c
+++ b/fs/xfs/xfs_stats.c
@@ -74,7 +74,7 @@ int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
 		defer_relog += per_cpu_ptr(stats, i)->s.defer_relog;
 	}
 
-	len += scnprintf(buf + len, PATH_MAX-len, "xpc %Lu %Lu %Lu\n",
+	len += scnprintf(buf + len, PATH_MAX-len, "xpc %llu %llu %llu\n",
 			xs_xstrat_bytes, xs_write_bytes, xs_read_bytes);
 	len += scnprintf(buf + len, PATH_MAX-len, "defer_relog %llu\n",
 			defer_relog);
-- 
2.25.1

