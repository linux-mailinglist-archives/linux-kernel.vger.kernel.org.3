Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA06C4B7E27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiBPDJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:09:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344068AbiBPDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:09:20 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A08E9A997;
        Tue, 15 Feb 2022 19:09:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4b8YIz_1644980943;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V4b8YIz_1644980943)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 11:09:04 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     xfs <linux-xfs@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 1/3] xfs: get rid of LEFT, RIGHT, PREV in xfs_bmap_add_extent_unwritten_real()
Date:   Wed, 16 Feb 2022 11:08:52 +0800
Message-Id: <20220216030854.30180-2-hsiangkao@linux.alibaba.com>
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

It doesn't seems that such macros are easier to read. Also, they
could polluate the identifier namespace.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 200 +++++++++++++++++++--------------------
 1 file changed, 96 insertions(+), 104 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 74198dd82b03..14d1a806ba15 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -1935,11 +1935,11 @@ xfs_bmap_add_extent_delay_real(
 int					/* error */
 xfs_bmap_add_extent_unwritten_real(
 	struct xfs_trans	*tp,
-	xfs_inode_t		*ip,	/* incore inode pointer */
+	struct xfs_inode	*ip,	/* incore inode pointer */
 	int			whichfork,
 	struct xfs_iext_cursor	*icur,
 	struct xfs_btree_cur	**curp,	/* if *curp is null, not a btree */
-	xfs_bmbt_irec_t		*new,	/* new data to add to file extents */
+	struct xfs_bmbt_irec	*new,	/* new data to add to file extents */
 	int			*logflagsp) /* inode logging flags */
 {
 	struct xfs_btree_cur	*cur;	/* btree cursor */
@@ -1947,8 +1947,8 @@ xfs_bmap_add_extent_unwritten_real(
 	int			i;	/* temp state */
 	struct xfs_ifork	*ifp;	/* inode fork pointer */
 	xfs_fileoff_t		new_endoff;	/* end offset of new entry */
-	xfs_bmbt_irec_t		r[3];	/* neighbor extent entries */
-					/* left is 0, right is 1, prev is 2 */
+	struct xfs_bmbt_irec	left, right;	/* neighbor extent entries */
+	struct xfs_bmbt_irec	prev;		/* previous old extent */
 	int			rval=0;	/* return value (logging flags) */
 	int			state = xfs_bmap_fork_to_state(whichfork);
 	struct xfs_mount	*mp = ip->i_mount;
@@ -1963,44 +1963,40 @@ xfs_bmap_add_extent_unwritten_real(
 
 	XFS_STATS_INC(mp, xs_add_exlist);
 
-#define	LEFT		r[0]
-#define	RIGHT		r[1]
-#define	PREV		r[2]
-
 	/*
 	 * Set up a bunch of variables to make the tests simpler.
 	 */
 	error = 0;
-	xfs_iext_get_extent(ifp, icur, &PREV);
-	ASSERT(new->br_state != PREV.br_state);
+	xfs_iext_get_extent(ifp, icur, &prev);
+	ASSERT(new->br_state != prev.br_state);
 	new_endoff = new->br_startoff + new->br_blockcount;
-	ASSERT(PREV.br_startoff <= new->br_startoff);
-	ASSERT(PREV.br_startoff + PREV.br_blockcount >= new_endoff);
+	ASSERT(prev.br_startoff <= new->br_startoff);
+	ASSERT(prev.br_startoff + prev.br_blockcount >= new_endoff);
 
 	/*
 	 * Set flags determining what part of the previous oldext allocation
 	 * extent is being replaced by a newext allocation.
 	 */
-	if (PREV.br_startoff == new->br_startoff)
+	if (prev.br_startoff == new->br_startoff)
 		state |= BMAP_LEFT_FILLING;
-	if (PREV.br_startoff + PREV.br_blockcount == new_endoff)
+	if (prev.br_startoff + prev.br_blockcount == new_endoff)
 		state |= BMAP_RIGHT_FILLING;
 
 	/*
 	 * Check and set flags if this segment has a left neighbor.
 	 * Don't set contiguous if the combined extent would be too large.
 	 */
-	if (xfs_iext_peek_prev_extent(ifp, icur, &LEFT)) {
+	if (xfs_iext_peek_prev_extent(ifp, icur, &left)) {
 		state |= BMAP_LEFT_VALID;
-		if (isnullstartblock(LEFT.br_startblock))
+		if (isnullstartblock(left.br_startblock))
 			state |= BMAP_LEFT_DELAY;
 	}
 
 	if ((state & BMAP_LEFT_VALID) && !(state & BMAP_LEFT_DELAY) &&
-	    LEFT.br_startoff + LEFT.br_blockcount == new->br_startoff &&
-	    LEFT.br_startblock + LEFT.br_blockcount == new->br_startblock &&
-	    LEFT.br_state == new->br_state &&
-	    LEFT.br_blockcount + new->br_blockcount <= MAXEXTLEN)
+	    left.br_startoff + left.br_blockcount == new->br_startoff &&
+	    left.br_startblock + left.br_blockcount == new->br_startblock &&
+	    left.br_state == new->br_state &&
+	    left.br_blockcount + new->br_blockcount <= MAXEXTLEN)
 		state |= BMAP_LEFT_CONTIG;
 
 	/*
@@ -2008,22 +2004,22 @@ xfs_bmap_add_extent_unwritten_real(
 	 * Don't set contiguous if the combined extent would be too large.
 	 * Also check for all-three-contiguous being too large.
 	 */
-	if (xfs_iext_peek_next_extent(ifp, icur, &RIGHT)) {
+	if (xfs_iext_peek_next_extent(ifp, icur, &right)) {
 		state |= BMAP_RIGHT_VALID;
-		if (isnullstartblock(RIGHT.br_startblock))
+		if (isnullstartblock(right.br_startblock))
 			state |= BMAP_RIGHT_DELAY;
 	}
 
 	if ((state & BMAP_RIGHT_VALID) && !(state & BMAP_RIGHT_DELAY) &&
-	    new_endoff == RIGHT.br_startoff &&
-	    new->br_startblock + new->br_blockcount == RIGHT.br_startblock &&
-	    new->br_state == RIGHT.br_state &&
-	    new->br_blockcount + RIGHT.br_blockcount <= MAXEXTLEN &&
+	    new_endoff == right.br_startoff &&
+	    new->br_startblock + new->br_blockcount == right.br_startblock &&
+	    new->br_state == right.br_state &&
+	    new->br_blockcount + right.br_blockcount <= MAXEXTLEN &&
 	    ((state & (BMAP_LEFT_CONTIG | BMAP_LEFT_FILLING |
 		       BMAP_RIGHT_FILLING)) !=
 		      (BMAP_LEFT_CONTIG | BMAP_LEFT_FILLING |
 		       BMAP_RIGHT_FILLING) ||
-	     LEFT.br_blockcount + new->br_blockcount + RIGHT.br_blockcount
+	     left.br_blockcount + new->br_blockcount + right.br_blockcount
 			<= MAXEXTLEN))
 		state |= BMAP_RIGHT_CONTIG;
 
@@ -2038,18 +2034,18 @@ xfs_bmap_add_extent_unwritten_real(
 		 * Setting all of a previous oldext extent to newext.
 		 * The left and right neighbors are both contiguous with new.
 		 */
-		LEFT.br_blockcount += PREV.br_blockcount + RIGHT.br_blockcount;
+		left.br_blockcount += prev.br_blockcount + right.br_blockcount;
 
 		xfs_iext_remove(ip, icur, state);
 		xfs_iext_remove(ip, icur, state);
 		xfs_iext_prev(ifp, icur);
-		xfs_iext_update_extent(ip, state, icur, &LEFT);
+		xfs_iext_update_extent(ip, state, icur, &left);
 		ifp->if_nextents -= 2;
-		if (cur == NULL)
+		if (cur == NULL) {
 			rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
-		else {
+		} else {
 			rval = XFS_ILOG_CORE;
-			error = xfs_bmbt_lookup_eq(cur, &RIGHT, &i);
+			error = xfs_bmbt_lookup_eq(cur, &right, &i);
 			if (error)
 				goto done;
 			if (XFS_IS_CORRUPT(mp, i != 1)) {
@@ -2080,7 +2076,7 @@ xfs_bmap_add_extent_unwritten_real(
 				error = -EFSCORRUPTED;
 				goto done;
 			}
-			error = xfs_bmbt_update(cur, &LEFT);
+			error = xfs_bmbt_update(cur, &left);
 			if (error)
 				goto done;
 		}
@@ -2091,17 +2087,17 @@ xfs_bmap_add_extent_unwritten_real(
 		 * Setting all of a previous oldext extent to newext.
 		 * The left neighbor is contiguous, the right is not.
 		 */
-		LEFT.br_blockcount += PREV.br_blockcount;
+		left.br_blockcount += prev.br_blockcount;
 
 		xfs_iext_remove(ip, icur, state);
 		xfs_iext_prev(ifp, icur);
-		xfs_iext_update_extent(ip, state, icur, &LEFT);
+		xfs_iext_update_extent(ip, state, icur, &left);
 		ifp->if_nextents--;
-		if (cur == NULL)
+		if (cur == NULL) {
 			rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
-		else {
+		} else {
 			rval = XFS_ILOG_CORE;
-			error = xfs_bmbt_lookup_eq(cur, &PREV, &i);
+			error = xfs_bmbt_lookup_eq(cur, &prev, &i);
 			if (error)
 				goto done;
 			if (XFS_IS_CORRUPT(mp, i != 1)) {
@@ -2120,7 +2116,7 @@ xfs_bmap_add_extent_unwritten_real(
 				error = -EFSCORRUPTED;
 				goto done;
 			}
-			error = xfs_bmbt_update(cur, &LEFT);
+			error = xfs_bmbt_update(cur, &left);
 			if (error)
 				goto done;
 		}
@@ -2131,20 +2127,20 @@ xfs_bmap_add_extent_unwritten_real(
 		 * Setting all of a previous oldext extent to newext.
 		 * The right neighbor is contiguous, the left is not.
 		 */
-		PREV.br_blockcount += RIGHT.br_blockcount;
-		PREV.br_state = new->br_state;
+		prev.br_blockcount += right.br_blockcount;
+		prev.br_state = new->br_state;
 
 		xfs_iext_next(ifp, icur);
 		xfs_iext_remove(ip, icur, state);
 		xfs_iext_prev(ifp, icur);
-		xfs_iext_update_extent(ip, state, icur, &PREV);
+		xfs_iext_update_extent(ip, state, icur, &prev);
 		ifp->if_nextents--;
 
-		if (cur == NULL)
+		if (cur == NULL) {
 			rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
-		else {
+		} else {
 			rval = XFS_ILOG_CORE;
-			error = xfs_bmbt_lookup_eq(cur, &RIGHT, &i);
+			error = xfs_bmbt_lookup_eq(cur, &right, &i);
 			if (error)
 				goto done;
 			if (XFS_IS_CORRUPT(mp, i != 1)) {
@@ -2163,7 +2159,7 @@ xfs_bmap_add_extent_unwritten_real(
 				error = -EFSCORRUPTED;
 				goto done;
 			}
-			error = xfs_bmbt_update(cur, &PREV);
+			error = xfs_bmbt_update(cur, &prev);
 			if (error)
 				goto done;
 		}
@@ -2175,12 +2171,12 @@ xfs_bmap_add_extent_unwritten_real(
 		 * Neither the left nor right neighbors are contiguous with
 		 * the new one.
 		 */
-		PREV.br_state = new->br_state;
-		xfs_iext_update_extent(ip, state, icur, &PREV);
+		prev.br_state = new->br_state;
+		xfs_iext_update_extent(ip, state, icur, &prev);
 
-		if (cur == NULL)
+		if (cur == NULL) {
 			rval = XFS_ILOG_DEXT;
-		else {
+		} else {
 			rval = 0;
 			error = xfs_bmbt_lookup_eq(cur, new, &i);
 			if (error)
@@ -2189,7 +2185,7 @@ xfs_bmap_add_extent_unwritten_real(
 				error = -EFSCORRUPTED;
 				goto done;
 			}
-			error = xfs_bmbt_update(cur, &PREV);
+			error = xfs_bmbt_update(cur, &prev);
 			if (error)
 				goto done;
 		}
@@ -2200,20 +2196,20 @@ xfs_bmap_add_extent_unwritten_real(
 		 * Setting the first part of a previous oldext extent to newext.
 		 * The left neighbor is contiguous.
 		 */
-		LEFT.br_blockcount += new->br_blockcount;
+		left.br_blockcount += new->br_blockcount;
 
-		old = PREV;
-		PREV.br_startoff += new->br_blockcount;
-		PREV.br_startblock += new->br_blockcount;
-		PREV.br_blockcount -= new->br_blockcount;
+		old = prev;
+		prev.br_startoff += new->br_blockcount;
+		prev.br_startblock += new->br_blockcount;
+		prev.br_blockcount -= new->br_blockcount;
 
-		xfs_iext_update_extent(ip, state, icur, &PREV);
+		xfs_iext_update_extent(ip, state, icur, &prev);
 		xfs_iext_prev(ifp, icur);
-		xfs_iext_update_extent(ip, state, icur, &LEFT);
+		xfs_iext_update_extent(ip, state, icur, &left);
 
-		if (cur == NULL)
+		if (cur == NULL) {
 			rval = XFS_ILOG_DEXT;
-		else {
+		} else {
 			rval = 0;
 			error = xfs_bmbt_lookup_eq(cur, &old, &i);
 			if (error)
@@ -2222,13 +2218,13 @@ xfs_bmap_add_extent_unwritten_real(
 				error = -EFSCORRUPTED;
 				goto done;
 			}
-			error = xfs_bmbt_update(cur, &PREV);
+			error = xfs_bmbt_update(cur, &prev);
 			if (error)
 				goto done;
 			error = xfs_btree_decrement(cur, 0, &i);
 			if (error)
 				goto done;
-			error = xfs_bmbt_update(cur, &LEFT);
+			error = xfs_bmbt_update(cur, &left);
 			if (error)
 				goto done;
 		}
@@ -2239,18 +2235,18 @@ xfs_bmap_add_extent_unwritten_real(
 		 * Setting the first part of a previous oldext extent to newext.
 		 * The left neighbor is not contiguous.
 		 */
-		old = PREV;
-		PREV.br_startoff += new->br_blockcount;
-		PREV.br_startblock += new->br_blockcount;
-		PREV.br_blockcount -= new->br_blockcount;
+		old = prev;
+		prev.br_startoff += new->br_blockcount;
+		prev.br_startblock += new->br_blockcount;
+		prev.br_blockcount -= new->br_blockcount;
 
-		xfs_iext_update_extent(ip, state, icur, &PREV);
+		xfs_iext_update_extent(ip, state, icur, &prev);
 		xfs_iext_insert(ip, icur, new, state);
 		ifp->if_nextents++;
 
-		if (cur == NULL)
+		if (cur == NULL) {
 			rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
-		else {
+		} else {
 			rval = XFS_ILOG_CORE;
 			error = xfs_bmbt_lookup_eq(cur, &old, &i);
 			if (error)
@@ -2259,7 +2255,7 @@ xfs_bmap_add_extent_unwritten_real(
 				error = -EFSCORRUPTED;
 				goto done;
 			}
-			error = xfs_bmbt_update(cur, &PREV);
+			error = xfs_bmbt_update(cur, &prev);
 			if (error)
 				goto done;
 			cur->bc_rec.b = *new;
@@ -2277,20 +2273,20 @@ xfs_bmap_add_extent_unwritten_real(
 		 * Setting the last part of a previous oldext extent to newext.
 		 * The right neighbor is contiguous with the new allocation.
 		 */
-		old = PREV;
-		PREV.br_blockcount -= new->br_blockcount;
+		old = prev;
+		prev.br_blockcount -= new->br_blockcount;
 
-		RIGHT.br_startoff = new->br_startoff;
-		RIGHT.br_startblock = new->br_startblock;
-		RIGHT.br_blockcount += new->br_blockcount;
+		right.br_startoff = new->br_startoff;
+		right.br_startblock = new->br_startblock;
+		right.br_blockcount += new->br_blockcount;
 
-		xfs_iext_update_extent(ip, state, icur, &PREV);
+		xfs_iext_update_extent(ip, state, icur, &prev);
 		xfs_iext_next(ifp, icur);
-		xfs_iext_update_extent(ip, state, icur, &RIGHT);
+		xfs_iext_update_extent(ip, state, icur, &right);
 
-		if (cur == NULL)
+		if (cur == NULL) {
 			rval = XFS_ILOG_DEXT;
-		else {
+		} else {
 			rval = 0;
 			error = xfs_bmbt_lookup_eq(cur, &old, &i);
 			if (error)
@@ -2299,13 +2295,13 @@ xfs_bmap_add_extent_unwritten_real(
 				error = -EFSCORRUPTED;
 				goto done;
 			}
-			error = xfs_bmbt_update(cur, &PREV);
+			error = xfs_bmbt_update(cur, &prev);
 			if (error)
 				goto done;
 			error = xfs_btree_increment(cur, 0, &i);
 			if (error)
 				goto done;
-			error = xfs_bmbt_update(cur, &RIGHT);
+			error = xfs_bmbt_update(cur, &right);
 			if (error)
 				goto done;
 		}
@@ -2316,17 +2312,17 @@ xfs_bmap_add_extent_unwritten_real(
 		 * Setting the last part of a previous oldext extent to newext.
 		 * The right neighbor is not contiguous.
 		 */
-		old = PREV;
-		PREV.br_blockcount -= new->br_blockcount;
+		old = prev;
+		prev.br_blockcount -= new->br_blockcount;
 
-		xfs_iext_update_extent(ip, state, icur, &PREV);
+		xfs_iext_update_extent(ip, state, icur, &prev);
 		xfs_iext_next(ifp, icur);
 		xfs_iext_insert(ip, icur, new, state);
 		ifp->if_nextents++;
 
-		if (cur == NULL)
+		if (cur == NULL) {
 			rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
-		else {
+		} else {
 			rval = XFS_ILOG_CORE;
 			error = xfs_bmbt_lookup_eq(cur, &old, &i);
 			if (error)
@@ -2335,7 +2331,7 @@ xfs_bmap_add_extent_unwritten_real(
 				error = -EFSCORRUPTED;
 				goto done;
 			}
-			error = xfs_bmbt_update(cur, &PREV);
+			error = xfs_bmbt_update(cur, &prev);
 			if (error)
 				goto done;
 			error = xfs_bmbt_lookup_eq(cur, new, &i);
@@ -2360,25 +2356,24 @@ xfs_bmap_add_extent_unwritten_real(
 		 * newext.  Contiguity is impossible here.
 		 * One extent becomes three extents.
 		 */
-		old = PREV;
-		PREV.br_blockcount = new->br_startoff - PREV.br_startoff;
+		old = prev;
+		prev.br_blockcount = new->br_startoff - prev.br_startoff;
 
-		r[0] = *new;
-		r[1].br_startoff = new_endoff;
-		r[1].br_blockcount =
+		right.br_startoff = new_endoff;
+		right.br_blockcount =
 			old.br_startoff + old.br_blockcount - new_endoff;
-		r[1].br_startblock = new->br_startblock + new->br_blockcount;
-		r[1].br_state = PREV.br_state;
+		right.br_startblock = new->br_startblock + new->br_blockcount;
+		right.br_state = prev.br_state;
 
-		xfs_iext_update_extent(ip, state, icur, &PREV);
+		xfs_iext_update_extent(ip, state, icur, &prev);
 		xfs_iext_next(ifp, icur);
-		xfs_iext_insert(ip, icur, &r[1], state);
-		xfs_iext_insert(ip, icur, &r[0], state);
+		xfs_iext_insert(ip, icur, &right, state);
+		xfs_iext_insert(ip, icur, new, state);
 		ifp->if_nextents += 2;
 
-		if (cur == NULL)
+		if (cur == NULL) {
 			rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
-		else {
+		} else {
 			rval = XFS_ILOG_CORE;
 			error = xfs_bmbt_lookup_eq(cur, &old, &i);
 			if (error)
@@ -2388,11 +2383,11 @@ xfs_bmap_add_extent_unwritten_real(
 				goto done;
 			}
 			/* new right extent - oldext */
-			error = xfs_bmbt_update(cur, &r[1]);
+			error = xfs_bmbt_update(cur, &right);
 			if (error)
 				goto done;
 			/* new left extent - oldext */
-			cur->bc_rec.b = PREV;
+			cur->bc_rec.b = prev;
 			if ((error = xfs_btree_insert(cur, &i)))
 				goto done;
 			if (XFS_IS_CORRUPT(mp, i != 1)) {
@@ -2459,9 +2454,6 @@ xfs_bmap_add_extent_unwritten_real(
 done:
 	*logflagsp |= rval;
 	return error;
-#undef	LEFT
-#undef	RIGHT
-#undef	PREV
 }
 
 /*
-- 
2.24.4

