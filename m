Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C229051E115
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444470AbiEFVdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343890AbiEFVdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:33:13 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 538436F48A;
        Fri,  6 May 2022 14:29:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 68B6C5345CA;
        Sat,  7 May 2022 07:29:25 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nn5Vs-008rXR-Qn; Sat, 07 May 2022 07:29:24 +1000
Date:   Sat, 7 May 2022 07:29:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        linux-xfs@vger.kernel.org
Subject: Re: [xfs]  32678f1513:  aim7.jobs-per-min -5.6% regression
Message-ID: <20220506212924.GJ1098723@dread.disaster.area>
References: <20220502082018.1076561-2-david@fromorbit.com>
 <20220506092250.GI23061@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506092250.GI23061@xsang-OptiPlex-9020>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62759337
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=8nJEP1OIZ-IA:10 a=oZkIemNP1mAA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=xEvadSHMmT4qNSc8GvgA:9
        a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 05:22:50PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -5.6% regression of aim7.jobs-per-min due to commit:
> 
> 
> commit: 32678f151338b9a321e9e27139a63c81f353acb7 ("[PATCH 1/4] xfs: detect self referencing btree sibling pointers")
> url: https://github.com/intel-lab-lkp/linux/commits/Dave-Chinner/xfs-fix-random-format-verification-issues/20220502-162206
> base: https://git.kernel.org/cgit/fs/xfs/xfs-linux.git for-next
> patch link: https://lore.kernel.org/linux-xfs/20220502082018.1076561-2-david@fromorbit.com

Well, that answers the concern I had about the impact of 
changing the way endian conversions were done in that patch.

> a44a027a8b2a20fe 32678f151338b9a321e9e27139a 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     464232            -5.6%     438315        aim7.jobs-per-min
....
>       0.13 ±  5%      +0.2        0.33 ±  6%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
....
>       0.11 ±  4%      +0.2        0.30 ±  5%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock

Because there is it, right at the bottom of the profile.

Can you try the patch below and see if that fixes the issue?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


xfs: avoid unnecessary runtime sibling pointer endian conversions

From: Dave Chinner <dchinner@redhat.com>

Commit dc04db2aa7c9 has caused a small aim7 regression, showing a
small increase in CPU usage in __xfs_btree_check_sblock() as a
result of the extra checking.

This is likely due to the endian conversion of the sibling poitners
being unconditional instead of relying on the compiler to endian
convert the NULL pointer at compile time and avoiding the runtime
conversion for this common case.

Rework the checks so that endian conversion of the sibling pointers
is only done if they are not null as the original code did.

Fixes: dc04db2aa7c9 ("xfs: detect self referencing btree sibling pointers")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/libxfs/xfs_btree.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 2aa300f7461f..4d673e943317 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -51,16 +51,25 @@ xfs_btree_magic(
 	return magic;
 }
 
+/*
+ * These sibling pointer checks are optimised for null sibling pointers. This
+ * happens a lot, and we don't need to byte swap at runtime if the sibling
+ * pointer is NULL.
+ */
 static xfs_failaddr_t
 xfs_btree_check_lblock_siblings(
 	struct xfs_mount	*mp,
 	struct xfs_btree_cur	*cur,
 	int			level,
 	xfs_fsblock_t		fsb,
-	xfs_fsblock_t		sibling)
+	__be64			dsibling)
 {
-	if (sibling == NULLFSBLOCK)
+	xfs_fsblock_t		sibling;
+
+	if (dsibling == cpu_to_be64(NULLFSBLOCK))
 		return NULL;
+
+	sibling = be64_to_cpu(dsibling);
 	if (sibling == fsb)
 		return __this_address;
 	if (level >= 0) {
@@ -81,10 +90,14 @@ xfs_btree_check_sblock_siblings(
 	int			level,
 	xfs_agnumber_t		agno,
 	xfs_agblock_t		agbno,
-	xfs_agblock_t		sibling)
+	__be32			dsibling)
 {
-	if (sibling == NULLAGBLOCK)
+	xfs_agblock_t		sibling;
+
+	if (dsibling == cpu_to_be32(NULLAGBLOCK))
 		return NULL;
+
+	sibling = be32_to_cpu(dsibling);
 	if (sibling == agbno)
 		return __this_address;
 	if (level >= 0) {
@@ -136,10 +149,10 @@ __xfs_btree_check_lblock(
 		fsb = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
 
 	fa = xfs_btree_check_lblock_siblings(mp, cur, level, fsb,
-			be64_to_cpu(block->bb_u.l.bb_leftsib));
+			block->bb_u.l.bb_leftsib);
 	if (!fa)
 		fa = xfs_btree_check_lblock_siblings(mp, cur, level, fsb,
-				be64_to_cpu(block->bb_u.l.bb_rightsib));
+				block->bb_u.l.bb_rightsib);
 	return fa;
 }
 
@@ -204,10 +217,10 @@ __xfs_btree_check_sblock(
 	}
 
 	fa = xfs_btree_check_sblock_siblings(mp, cur, level, agno, agbno,
-			be32_to_cpu(block->bb_u.s.bb_leftsib));
+			block->bb_u.s.bb_leftsib);
 	if (!fa)
 		fa = xfs_btree_check_sblock_siblings(mp, cur, level, agno,
-				 agbno, be32_to_cpu(block->bb_u.s.bb_rightsib));
+				 agbno, block->bb_u.s.bb_rightsib);
 	return fa;
 }
 
@@ -4523,10 +4536,10 @@ xfs_btree_lblock_verify(
 	/* sibling pointer verification */
 	fsb = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
 	fa = xfs_btree_check_lblock_siblings(mp, NULL, -1, fsb,
-			be64_to_cpu(block->bb_u.l.bb_leftsib));
+			block->bb_u.l.bb_leftsib);
 	if (!fa)
 		fa = xfs_btree_check_lblock_siblings(mp, NULL, -1, fsb,
-				be64_to_cpu(block->bb_u.l.bb_rightsib));
+				block->bb_u.l.bb_rightsib);
 	return fa;
 }
 
@@ -4580,10 +4593,10 @@ xfs_btree_sblock_verify(
 	agno = xfs_daddr_to_agno(mp, xfs_buf_daddr(bp));
 	agbno = xfs_daddr_to_agbno(mp, xfs_buf_daddr(bp));
 	fa = xfs_btree_check_sblock_siblings(mp, NULL, -1, agno, agbno,
-			be32_to_cpu(block->bb_u.s.bb_leftsib));
+			block->bb_u.s.bb_leftsib);
 	if (!fa)
 		fa = xfs_btree_check_sblock_siblings(mp, NULL, -1, agno, agbno,
-				be32_to_cpu(block->bb_u.s.bb_rightsib));
+				block->bb_u.s.bb_rightsib);
 	return fa;
 }
 
