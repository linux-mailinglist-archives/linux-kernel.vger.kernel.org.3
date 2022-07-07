Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D775056A55E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiGGO1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiGGO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:27:48 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA1A2B256;
        Thu,  7 Jul 2022 07:27:47 -0700 (PDT)
Received: from andrey-lpc.intra.ispras.ru (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 68A9940D4004;
        Thu,  7 Jul 2022 14:27:46 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Jeff Mahoney <jeffm@suse.com>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] reiserfs: removed useless condition from if
Date:   Thu,  7 Jul 2022 17:27:45 +0300
Message-Id: <20220707142745.14572-1-strochuk@ispras.ru>
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

At line 1001, bi is compared with NULL.

982	struct buffer_head *bh = bi->bi_bh;
983	int nr, free_space;
984	struct block_head *blkh;
985	struct item_head *ih;
986	int i;
987	int last_loc, unmoved_loc;
988
989	blkh = B_BLK_HEAD(bh);
990	nr = blkh_nr_item(blkh);
991	free_space = blkh_free_space(blkh);
992
993	/* check free space */
994	RFALSE(free_space < paste_size,
995	       "vs-10175: not enough free space: needed %d, available %d",
996	       paste_size, free_space);
997
998	#ifdef CONFIG_REISERFS_CHECK
999		if (zeros_number > paste_size) {
1000			struct super_block *sb = NULL;
1001			if (bi && bi->tb)
1002				sb = bi->tb->tb_sb;
1003			print_cur_tb("10177");
1004			reiserfs_panic(sb, "vs-10177",
1005				       "zeros_number == %d, paste_size == %d",
1006				       zeros_number, paste_size);
1007		}
1008	#endif				/* CONFIG_REISERFS_CHECK */

However, it cannot be NULL because kernel crashes
at line 982 otherwise.
The patch removes useless comparison.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: c3a9c2109f84 ("reiserfs: rework reiserfs_panic")
---
 fs/reiserfs/lbalance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/lbalance.c b/fs/reiserfs/lbalance.c
index 7f868569d4d0..0a530ea06d4e 100644
--- a/fs/reiserfs/lbalance.c
+++ b/fs/reiserfs/lbalance.c
@@ -998,7 +998,7 @@ void leaf_paste_in_buffer(struct buffer_info *bi, int affected_item_num,
 #ifdef CONFIG_REISERFS_CHECK
 	if (zeros_number > paste_size) {
 		struct super_block *sb = NULL;
-		if (bi && bi->tb)
+		if (bi->tb)
 			sb = bi->tb->tb_sb;
 		print_cur_tb("10177");
 		reiserfs_panic(sb, "vs-10177",
-- 
2.25.1

