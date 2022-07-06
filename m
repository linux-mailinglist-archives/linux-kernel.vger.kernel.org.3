Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B8E5689A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiGFNgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiGFNgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:36:50 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED44B5F66;
        Wed,  6 Jul 2022 06:36:48 -0700 (PDT)
Received: from andrey-lpc.intra.ispras.ru (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id D6A4740737B9;
        Wed,  6 Jul 2022 13:36:44 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] xfs: removed useless condition in function xfs_attr_node_get
Date:   Wed,  6 Jul 2022 16:36:27 +0300
Message-Id: <20220706133627.11198-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At line 1561, variable "state" is being compared
with NULL every loop iteration.

-------------------------------------------------------------------
1561	for (i = 0; state != NULL && i < state->path.active; i++) {
1562		xfs_trans_brelse(args->trans, state->path.blk[i].bp);
1563		state->path.blk[i].bp = NULL;
1564	}
-------------------------------------------------------------------

However, it cannot be NULL.

----------------------------------------
1546	state = xfs_da_state_alloc(args);
----------------------------------------

xfs_da_state_alloc calls kmem_cache_zalloc. kmem_cache_zalloc is
called with __GFP_NOFAIL flag and, therefore, it cannot return NULL.

--------------------------------------------------------------------------
	struct xfs_da_state *
	xfs_da_state_alloc(
	struct xfs_da_args	*args)
	{
		struct xfs_da_state	*state;

		state = kmem_cache_zalloc(xfs_da_state_cache, GFP_NOFS | __GFP_NOFAIL);
		state->args = args;
		state->mp = args->dp->i_mount;
		return state;
	}
--------------------------------------------------------------------------

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>

Fixes: 4d0cdd2bb8f0 ("xfs: clean up xfs_attr_node_hasname")
---
 fs/xfs/libxfs/xfs_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 224649a76cbb..6b8857e53add 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -1558,7 +1558,7 @@ xfs_attr_node_get(
 	 * If not in a transaction, we have to release all the buffers.
 	 */
 out_release:
-	for (i = 0; state != NULL && i < state->path.active; i++) {
+	for (i = 0; i < state->path.active; i++) {
 		xfs_trans_brelse(args->trans, state->path.blk[i].bp);
 		state->path.blk[i].bp = NULL;
 	}
-- 
2.25.1

