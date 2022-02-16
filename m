Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2470A4B7E47
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbiBPDJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:09:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbiBPDJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:09:22 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C7C4843;
        Tue, 15 Feb 2022 19:09:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4b8YJf_1644980946;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V4b8YJf_1644980946)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 11:09:07 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     xfs <linux-xfs@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 3/3] xfs: introduce xfs_bremapi_from_cowfork()
Date:   Wed, 16 Feb 2022 11:08:54 +0800
Message-Id: <20220216030854.30180-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220216030854.30180-1-hsiangkao@linux.alibaba.com>
References: <20220216030854.30180-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, xfs_reflink_end_cow_extent() will unconditionally unmap
the corresponding old extent and remap an extent from COW fork.
However, it seems somewhat ineffective since the old bmbt records can
be directly updated for many cases instead.

This patch uses introduced xfs_bmap_update_extent_real() in the
previous patch for most extent inclusive cases or it will fall back
to the old way if such replacement is not possible.

Actually, we're planing to use a modified alway-cow like atomic write
approach internally, therefore it'd be nice to do some optimization
to reduce some metadata overhead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 116 ++++++++++++++++++++++++++++++++++++---
 fs/xfs/libxfs/xfs_bmap.h |   3 +
 fs/xfs/xfs_reflink.c     |  19 +------
 3 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 8eb1d1ed7b75..f74ab489d9c8 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5880,6 +5880,113 @@ xfs_bmap_collapse_extents(
 	return error;
 }
 
+/* Deferred mapping is only for real extents in the data fork. */
+static bool
+xfs_bmap_is_update_needed(
+	struct xfs_bmbt_irec	*bmap)
+{
+	return  bmap->br_startblock != HOLESTARTBLOCK &&
+		bmap->br_startblock != DELAYSTARTBLOCK;
+}
+
+/* del is an extent from COW fork */
+int
+xfs_bremapi_from_cowfork(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*icow)
+{
+	int			error;
+	xfs_filblks_t		rlen;
+
+	if (xfs_bmap_is_update_needed(icow)) {
+		xfs_fileoff_t		start, end, max_len;
+		struct xfs_bmbt_irec	got;
+		struct xfs_iext_cursor	icur;
+		struct xfs_btree_cur	*cur = NULL;
+		struct xfs_ifork	*ifp = XFS_IFORK_PTR(ip, XFS_DATA_FORK);
+		int			logflags = 0;
+
+		error = xfs_iread_extents(tp, ip, XFS_DATA_FORK);
+		if (error)
+			return error;
+
+		max_len = xfs_refcount_max_unmap(tp->t_log_res);
+		if (max_len < icow->br_blockcount) {
+			icow->br_startoff += icow->br_blockcount - max_len;
+			icow->br_startblock += icow->br_blockcount - max_len;
+			icow->br_blockcount = max_len;
+		}
+
+		end = icow->br_startoff + icow->br_blockcount;
+		if (!xfs_iext_count(ifp) || !xfs_iext_lookup_extent_before(ip,
+				ifp, &end, &icur, &got) ||
+		    isnullstartblock(got.br_startblock) ||
+		    icow->br_startoff + icow->br_blockcount > got.br_startoff +
+				got.br_blockcount) {
+			error = -EAGAIN;
+		} else {
+			end = icow->br_startoff + icow->br_blockcount;
+			start = XFS_FILEOFF_MAX(icow->br_startoff,
+						got.br_startoff);
+			ASSERT(start < end);
+
+			/* Trim the extent to what we need */
+			xfs_trim_extent(icow, start, end - start);
+			xfs_trim_extent(&got, start, end - start);
+
+			if (ifp->if_format == XFS_DINODE_FMT_BTREE) {
+				cur = xfs_bmbt_init_cursor(tp->t_mountp, tp, ip,
+							   XFS_DATA_FORK);
+				cur->bc_ino.flags = 0;
+			}
+
+			/*
+			 * Free the CoW orphan record (it should be done here
+			 * before updating extent due to rmapbt update)
+			 */
+			xfs_refcount_free_cow_extent(tp, icow->br_startblock,
+						     icow->br_blockcount);
+
+			xfs_bmap_update_extent_real(tp, ip, XFS_DATA_FORK,
+					&icur, &cur, icow, &logflags, false);
+
+			/* Free previous referenced space */
+			xfs_refcount_decrease_extent(tp, &got);
+
+			trace_xfs_reflink_cow_remap(ip, icow);
+			error = 0;
+		}
+		if (cur)
+			xfs_btree_del_cursor(cur, 0);
+		if (logflags)
+			xfs_trans_log_inode(tp, ip, logflags);
+		if (!error)
+			return 0;
+	}
+
+	rlen = icow->br_blockcount;
+	error = __xfs_bunmapi(tp, ip, icow->br_startoff, &rlen, 0, 1);
+	if (error)
+		return error;
+
+	/* Trim the extent to whatever got unmapped. */
+	xfs_trim_extent(icow, icow->br_startoff + rlen,
+			icow->br_blockcount - rlen);
+	/* Free the CoW orphan record. */
+	xfs_refcount_free_cow_extent(tp, icow->br_startblock,
+				     icow->br_blockcount);
+
+	/* Map the new blocks into the data fork. */
+	xfs_bmap_map_extent(tp, ip, icow);
+
+	/* Charge this new data fork mapping to the on-disk quota. */
+	xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_DELBCOUNT,
+			(long)icow->br_blockcount);
+	trace_xfs_reflink_cow_remap(ip, icow);
+	return 0;
+}
+
 /* Make sure we won't be right-shifting an extent past the maximum bound. */
 int
 xfs_bmap_can_insert_extents(
@@ -6123,15 +6230,6 @@ xfs_bmap_split_extent(
 	return error;
 }
 
-/* Deferred mapping is only for real extents in the data fork. */
-static bool
-xfs_bmap_is_update_needed(
-	struct xfs_bmbt_irec	*bmap)
-{
-	return  bmap->br_startblock != HOLESTARTBLOCK &&
-		bmap->br_startblock != DELAYSTARTBLOCK;
-}
-
 /* Record a bmap intent. */
 static int
 __xfs_bmap_add(
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index c52ff94786e2..9da1cff41c1c 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -220,6 +220,9 @@ int	xfs_bmap_update_extent_real(struct xfs_trans *tp,
 		struct xfs_inode *ip, int whichfork,
 		struct xfs_iext_cursor *icur, struct xfs_btree_cur **curp,
 		struct xfs_bmbt_irec *new, int *logflagsp, bool convert);
+int
+xfs_bremapi_from_cowfork(struct xfs_trans *tp, struct xfs_inode *ip,
+		struct xfs_bmbt_irec *icow);
 
 enum xfs_bmap_intent_type {
 	XFS_BMAP_MAP = 1,
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 276387a6a85d..75bd2e03cd5b 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -590,7 +590,6 @@ xfs_reflink_end_cow_extent(
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = XFS_IFORK_PTR(ip, XFS_COW_FORK);
-	xfs_filblks_t		rlen;
 	unsigned int		resblks;
 	int			error;
 
@@ -651,26 +650,10 @@ xfs_reflink_end_cow_extent(
 		goto out_cancel;
 	}
 
-	/* Unmap the old blocks in the data fork. */
-	rlen = del.br_blockcount;
-	error = __xfs_bunmapi(tp, ip, del.br_startoff, &rlen, 0, 1);
+	error = xfs_bremapi_from_cowfork(tp, ip, &del);
 	if (error)
 		goto out_cancel;
 
-	/* Trim the extent to whatever got unmapped. */
-	xfs_trim_extent(&del, del.br_startoff + rlen, del.br_blockcount - rlen);
-	trace_xfs_reflink_cow_remap(ip, &del);
-
-	/* Free the CoW orphan record. */
-	xfs_refcount_free_cow_extent(tp, del.br_startblock, del.br_blockcount);
-
-	/* Map the new blocks into the data fork. */
-	xfs_bmap_map_extent(tp, ip, &del);
-
-	/* Charge this new data fork mapping to the on-disk quota. */
-	xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_DELBCOUNT,
-			(long)del.br_blockcount);
-
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-- 
2.24.4

