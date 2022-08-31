Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D15A73C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiHaCFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiHaCFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:05:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA8CE08;
        Tue, 30 Aug 2022 19:05:09 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MHS8T0Z5pz1N7cZ;
        Wed, 31 Aug 2022 10:01:29 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 10:05:07 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <djwong@kernel.org>, <sandeen@sandeen.net>, <dchinner@redhat.com>,
        <chandan.babu@oracle.com>, <allison.henderson@oracle.com>,
        <dan.carpenter@oracle.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zengheng4@huawei.com>
Subject: [PATCH v2 -next] xfs: clean up "%Ld/%Lu" which doesn't meet C standard
Date:   Wed, 31 Aug 2022 10:12:48 +0800
Message-ID: <20220831021248.3127300-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 fs/xfs/libxfs/xfs_bmap.c        | 2 +-
 fs/xfs/libxfs/xfs_inode_fork.c  | 4 ++--
 fs/xfs/xfs_inode.c              | 8 ++++----
 fs/xfs/xfs_inode_item_recover.c | 4 ++--
 fs/xfs/xfs_stats.c              | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index e56723dc9cd5..49d0d4ea63fc 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -294,7 +294,7 @@ xfs_check_block(
 			else
 				thispa = XFS_BMBT_PTR_ADDR(mp, block, j, dmxr);
 			if (*thispa == *pp) {
-				xfs_warn(mp, "%s: thispa(%d) == pp(%d) %Ld",
+				xfs_warn(mp, "%s: thispa(%d) == pp(%d) %lld",
 					__func__, j, i,
 					(unsigned long long)be64_to_cpu(*thispa));
 				xfs_err(mp, "%s: ptrs are equal in node\n",
diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
index 9327a4f39206..6b21760184d9 100644
--- a/fs/xfs/libxfs/xfs_inode_fork.c
+++ b/fs/xfs/libxfs/xfs_inode_fork.c
@@ -78,7 +78,7 @@ xfs_iformat_local(
 	 */
 	if (unlikely(size > XFS_DFORK_SIZE(dip, ip->i_mount, whichfork))) {
 		xfs_warn(ip->i_mount,
-	"corrupt inode %Lu (bad size %d for local fork, size = %zd).",
+	"corrupt inode %llu (bad size %d for local fork, size = %zd).",
 			(unsigned long long) ip->i_ino, size,
 			XFS_DFORK_SIZE(dip, ip->i_mount, whichfork));
 		xfs_inode_verifier_error(ip, -EFSCORRUPTED,
@@ -192,7 +192,7 @@ xfs_iformat_btree(
 					XFS_DFORK_SIZE(dip, mp, whichfork) ||
 		     ifp->if_nextents > ip->i_nblocks) ||
 		     level == 0 || level > XFS_BM_MAXLEVELS(mp, whichfork)) {
-		xfs_warn(mp, "corrupt inode %Lu (btree).",
+		xfs_warn(mp, "corrupt inode %llu (btree).",
 					(unsigned long long) ip->i_ino);
 		xfs_inode_verifier_error(ip, -EFSCORRUPTED,
 				"xfs_iformat_btree", dfp, size,
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

