Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB94DBC98
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358305AbiCQBrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiCQBrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:47:15 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE78DEF9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:46:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V7PI3vS_1647481551;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V7PI3vS_1647481551)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 09:45:58 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ufs: clean up some inconsistent indenting
Date:   Thu, 17 Mar 2022 09:45:50 +0800
Message-Id: <20220317014550.1018-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

fs/ufs/inode.c:1071 ufs_alloc_lastblock() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/ufs/inode.c | 72 +++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index d0dda01620f0..508eeefdfa0d 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1068,52 +1068,52 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 
 	lastpage = ufs_get_locked_page(mapping, lastfrag >>
 				       (PAGE_SHIFT - inode->i_blkbits));
-       if (IS_ERR(lastpage)) {
-               err = -EIO;
-               goto out;
-       }
+	if (IS_ERR(lastpage)) {
+		err = -EIO;
+		goto out;
+	}
 
-       end = lastfrag & ((1 << (PAGE_SHIFT - inode->i_blkbits)) - 1);
-       bh = page_buffers(lastpage);
-       for (i = 0; i < end; ++i)
-               bh = bh->b_this_page;
+	end = lastfrag & ((1 << (PAGE_SHIFT - inode->i_blkbits)) - 1);
+	bh = page_buffers(lastpage);
+	for (i = 0; i < end; ++i)
+		bh = bh->b_this_page;
 
 
-       err = ufs_getfrag_block(inode, lastfrag, bh, 1);
+	err = ufs_getfrag_block(inode, lastfrag, bh, 1);
 
-       if (unlikely(err))
-	       goto out_unlock;
+	if (unlikely(err))
+		goto out_unlock;
 
-       if (buffer_new(bh)) {
-	       clear_buffer_new(bh);
-	       clean_bdev_bh_alias(bh);
-	       /*
+	if (buffer_new(bh)) {
+		clear_buffer_new(bh);
+		clean_bdev_bh_alias(bh);
+		/*
 		* we do not zeroize fragment, because of
 		* if it maped to hole, it already contains zeroes
 		*/
-	       set_buffer_uptodate(bh);
-	       mark_buffer_dirty(bh);
-	       set_page_dirty(lastpage);
-       }
-
-       if (lastfrag >= UFS_IND_FRAGMENT) {
-	       end = uspi->s_fpb - ufs_fragnum(lastfrag) - 1;
-	       phys64 = bh->b_blocknr + 1;
-	       for (i = 0; i < end; ++i) {
-		       bh = sb_getblk(sb, i + phys64);
-		       lock_buffer(bh);
-		       memset(bh->b_data, 0, sb->s_blocksize);
-		       set_buffer_uptodate(bh);
-		       mark_buffer_dirty(bh);
-		       unlock_buffer(bh);
-		       sync_dirty_buffer(bh);
-		       brelse(bh);
-	       }
-       }
+		set_buffer_uptodate(bh);
+		mark_buffer_dirty(bh);
+		set_page_dirty(lastpage);
+	}
+
+	if (lastfrag >= UFS_IND_FRAGMENT) {
+		end = uspi->s_fpb - ufs_fragnum(lastfrag) - 1;
+		phys64 = bh->b_blocknr + 1;
+		for (i = 0; i < end; ++i) {
+			bh = sb_getblk(sb, i + phys64);
+			lock_buffer(bh);
+			memset(bh->b_data, 0, sb->s_blocksize);
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+			unlock_buffer(bh);
+			sync_dirty_buffer(bh);
+			brelse(bh);
+		}
+	}
 out_unlock:
-       ufs_put_locked_page(lastpage);
+	ufs_put_locked_page(lastpage);
 out:
-       return err;
+	return err;
 }
 
 static void ufs_truncate_blocks(struct inode *inode)
-- 
2.20.1.7.g153144c

