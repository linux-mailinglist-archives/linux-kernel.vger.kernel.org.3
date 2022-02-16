Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9FF4B7E30
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbiBPDJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:09:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344069AbiBPDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:09:20 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6839A9A7;
        Tue, 15 Feb 2022 19:09:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4b8YJR_1644980945;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V4b8YJR_1644980945)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 11:09:06 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     xfs <linux-xfs@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/3] xfs: introduce xfs_bmap_update_extent_real()
Date:   Wed, 16 Feb 2022 11:08:53 +0800
Message-Id: <20220216030854.30180-3-hsiangkao@linux.alibaba.com>
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

Previously, xfs_bmap_add_extent_unwritten_real() was just used for
unwritten conversion. However, the code could be sightly modified
to update a real allocated extent. It can be then used to avoid
unnecessary bmbt unmap due to end COW.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 65 ++++++++++++++++++++++++++--------------
 fs/xfs/libxfs/xfs_bmap.h |  4 +--
 fs/xfs/xfs_reflink.c     |  5 ++--
 3 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 14d1a806ba15..8eb1d1ed7b75 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -1930,22 +1930,26 @@ xfs_bmap_add_extent_delay_real(
 }
 
 /*
- * Convert an unwritten allocation to a real allocation or vice versa.
+ * Update a real allocated extent (including converting an unwritten
+ * allocation to a real allocation or vice versa.)
  */
 int					/* error */
-xfs_bmap_add_extent_unwritten_real(
+xfs_bmap_update_extent_real(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,	/* incore inode pointer */
 	int			whichfork,
 	struct xfs_iext_cursor	*icur,
 	struct xfs_btree_cur	**curp,	/* if *curp is null, not a btree */
 	struct xfs_bmbt_irec	*new,	/* new data to add to file extents */
-	int			*logflagsp) /* inode logging flags */
+	int			*logflagsp, /* inode logging flags */
+	bool			convert)
 {
 	struct xfs_btree_cur	*cur;	/* btree cursor */
 	int			error;	/* error return value */
 	int			i;	/* temp state */
 	struct xfs_ifork	*ifp;	/* inode fork pointer */
+	xfs_fileoff_t		del_startoff;	/* start offset of del entry */
+	xfs_exntst_t		del_state;
 	xfs_fileoff_t		new_endoff;	/* end offset of new entry */
 	struct xfs_bmbt_irec	left, right;	/* neighbor extent entries */
 	struct xfs_bmbt_irec	prev;		/* previous old extent */
@@ -1953,6 +1957,7 @@ xfs_bmap_add_extent_unwritten_real(
 	int			state = xfs_bmap_fork_to_state(whichfork);
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_bmbt_irec	old;
+	int			tmp_logflags = 0;
 
 	*logflagsp = 0;
 
@@ -1968,8 +1973,11 @@ xfs_bmap_add_extent_unwritten_real(
 	 */
 	error = 0;
 	xfs_iext_get_extent(ifp, icur, &prev);
-	ASSERT(new->br_state != prev.br_state);
+	ASSERT(!convert || new->br_state != prev.br_state);
 	new_endoff = new->br_startoff + new->br_blockcount;
+	del_startoff = prev.br_startblock +
+		new->br_startoff - prev.br_startoff;
+	del_state = prev.br_state;
 	ASSERT(prev.br_startoff <= new->br_startoff);
 	ASSERT(prev.br_startoff + prev.br_blockcount >= new_endoff);
 
@@ -2129,6 +2137,7 @@ xfs_bmap_add_extent_unwritten_real(
 		 */
 		prev.br_blockcount += right.br_blockcount;
 		prev.br_state = new->br_state;
+		prev.br_startblock = new->br_startblock;
 
 		xfs_iext_next(ifp, icur);
 		xfs_iext_remove(ip, icur, state);
@@ -2171,6 +2180,7 @@ xfs_bmap_add_extent_unwritten_real(
 		 * Neither the left nor right neighbors are contiguous with
 		 * the new one.
 		 */
+		prev.br_startblock = new->br_startblock;
 		prev.br_state = new->br_state;
 		xfs_iext_update_extent(ip, state, icur, &prev);
 
@@ -2362,7 +2372,8 @@ xfs_bmap_add_extent_unwritten_real(
 		right.br_startoff = new_endoff;
 		right.br_blockcount =
 			old.br_startoff + old.br_blockcount - new_endoff;
-		right.br_startblock = new->br_startblock + new->br_blockcount;
+		right.br_startblock = old.br_startblock + prev.br_blockcount +
+			new->br_blockcount;
 		right.br_state = prev.br_state;
 
 		xfs_iext_update_extent(ip, state, icur, &prev);
@@ -2430,20 +2441,30 @@ xfs_bmap_add_extent_unwritten_real(
 	}
 
 	/* update reverse mappings */
-	xfs_rmap_convert_extent(mp, tp, ip, whichfork, new);
+	if (!convert) {
+		old = *new;
+		old.br_startblock = del_startoff;
+		old.br_state = del_state;
+		xfs_rmap_unmap_extent(tp, ip, whichfork, &old);
+		xfs_rmap_map_extent(tp, ip, whichfork, new);
+	} else {
+		xfs_rmap_convert_extent(mp, tp, ip, whichfork, new);
+	}
 
-	/* convert to a btree if necessary */
+	/* convert to a btree or extents if necessary */
 	if (xfs_bmap_needs_btree(ip, whichfork)) {
-		int	tmp_logflags;	/* partial log flag return val */
-
 		ASSERT(cur == NULL);
 		error = xfs_bmap_extents_to_btree(tp, ip, &cur, 0,
 				&tmp_logflags, whichfork);
-		*logflagsp |= tmp_logflags;
-		if (error)
-			goto done;
+	} else if (!convert) {
+		error = xfs_bmap_btree_to_extents(tp, ip, cur,
+				&tmp_logflags, whichfork);
 	}
 
+	*logflagsp |= tmp_logflags;
+	if (error)
+		goto done;
+
 	/* clear out the allocated field, done with it now in any case. */
 	if (cur) {
 		cur->bc_ino.allocated = 0;
@@ -4216,8 +4237,8 @@ xfs_bmapi_convert_unwritten(
 			return error;
 	}
 
-	error = xfs_bmap_add_extent_unwritten_real(bma->tp, bma->ip, whichfork,
-			&bma->icur, &bma->cur, mval, &tmp_logflags);
+	error = xfs_bmap_update_extent_real(bma->tp, bma->ip, whichfork,
+			&bma->icur, &bma->cur, mval, &tmp_logflags, true);
 	/*
 	 * Log the inode core unconditionally in the unwritten extent conversion
 	 * path because the conversion might not have done so (e.g., if the
@@ -5444,9 +5465,9 @@ __xfs_bunmapi(
 				del.br_blockcount = mod;
 			}
 			del.br_state = XFS_EXT_UNWRITTEN;
-			error = xfs_bmap_add_extent_unwritten_real(tp, ip,
+			error = xfs_bmap_update_extent_real(tp, ip,
 					whichfork, &icur, &cur, &del,
-					&logflags);
+					&logflags, true);
 			if (error)
 				goto error0;
 			goto nodelete;
@@ -5503,18 +5524,18 @@ __xfs_bunmapi(
 				prev.br_startblock += mod;
 				prev.br_blockcount -= mod;
 				prev.br_state = XFS_EXT_UNWRITTEN;
-				error = xfs_bmap_add_extent_unwritten_real(tp,
-						ip, whichfork, &icur, &cur,
-						&prev, &logflags);
+				error = xfs_bmap_update_extent_real(tp, ip,
+						whichfork, &icur, &cur, &prev,
+						&logflags, true);
 				if (error)
 					goto error0;
 				goto nodelete;
 			} else {
 				ASSERT(del.br_state == XFS_EXT_NORM);
 				del.br_state = XFS_EXT_UNWRITTEN;
-				error = xfs_bmap_add_extent_unwritten_real(tp,
-						ip, whichfork, &icur, &cur,
-						&del, &logflags);
+				error = xfs_bmap_update_extent_real(tp, ip,
+						whichfork, &icur, &cur, &del,
+						&logflags, true);
 				if (error)
 					goto error0;
 				goto nodelete;
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 03d9aaf87413..c52ff94786e2 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -216,10 +216,10 @@ int	xfs_bmapi_reserve_delalloc(struct xfs_inode *ip, int whichfork,
 		int eof);
 int	xfs_bmapi_convert_delalloc(struct xfs_inode *ip, int whichfork,
 		xfs_off_t offset, struct iomap *iomap, unsigned int *seq);
-int	xfs_bmap_add_extent_unwritten_real(struct xfs_trans *tp,
+int	xfs_bmap_update_extent_real(struct xfs_trans *tp,
 		struct xfs_inode *ip, int whichfork,
 		struct xfs_iext_cursor *icur, struct xfs_btree_cur **curp,
-		struct xfs_bmbt_irec *new, int *logflagsp);
+		struct xfs_bmbt_irec *new, int *logflagsp, bool convert);
 
 enum xfs_bmap_intent_type {
 	XFS_BMAP_MAP = 1,
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index db70060e7bf6..276387a6a85d 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -266,9 +266,8 @@ xfs_reflink_convert_cow_locked(
 			continue;
 
 		got.br_state = XFS_EXT_NORM;
-		error = xfs_bmap_add_extent_unwritten_real(NULL, ip,
-				XFS_COW_FORK, &icur, &dummy_cur, &got,
-				&dummy_logflags);
+		error = xfs_bmap_update_extent_real(NULL, ip, XFS_COW_FORK,
+				&icur, &dummy_cur, &got, &dummy_logflags, true);
 		if (error)
 			return error;
 	} while (xfs_iext_next_extent(ip->i_cowfp, &icur, &got));
-- 
2.24.4

