Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11B856A552
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiGGO07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiGGO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:26:58 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3254127CEC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:26:57 -0700 (PDT)
Received: from andrey-lpc.intra.ispras.ru (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 8FF2D40D4004;
        Thu,  7 Jul 2022 14:26:53 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrey Strachuk <strochuk@ispras.ru>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] efs: removed useless conditional checks in function
Date:   Thu,  7 Jul 2022 17:26:52 +0300
Message-Id: <20220707142652.14447-1-strochuk@ispras.ru>
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

At lines 300 and 305, variable "bh" is compared with NULL.

-----------------------------------------------------------
293	exts = (efs_extent *) bh->b_data;
294
295	extent_copy(&(exts[ioffset]), &ext);
296
297	if (ext.cooked.ex_magic != 0) {
298		pr_err("extent %d has bad magic number in block %d\n",
299		       cur, iblock);
300		if (bh) brelse(bh);
301		return 0;
302	}
303
304	if ((result = efs_extent_check(&ext, block, sb))) {
305		if (bh) brelse(bh);
306		in->lastextent = cur;
307		return result;
308	}
-----------------------------------------------------------

However, it cannot be NULL because kernel crashes at
line 293 otherwise.
The patch removes useless comparisons.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 fs/efs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 3ba94bb005a6..a88a0600cdfb 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -297,12 +297,12 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 		if (ext.cooked.ex_magic != 0) {
 			pr_err("extent %d has bad magic number in block %d\n",
 			       cur, iblock);
-			if (bh) brelse(bh);
+			brelse(bh);
 			return 0;
 		}
 
 		if ((result = efs_extent_check(&ext, block, sb))) {
-			if (bh) brelse(bh);
+			brelse(bh);
 			in->lastextent = cur;
 			return result;
 		}
-- 
2.25.1

