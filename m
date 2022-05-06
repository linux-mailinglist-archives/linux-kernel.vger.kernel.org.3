Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB251DFC9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391710AbiEFTuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391394AbiEFTuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:50:19 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A584F458
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:46:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VCTGriZ_1651866373;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VCTGriZ_1651866373)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 May 2022 03:46:31 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs: get rid of erofs_prepare_dio() helper
Date:   Sat,  7 May 2022 03:46:10 +0800
Message-Id: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Fold in erofs_prepare_dio() and it seems much clearer.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index bb9c1fd48c19..fa9fdc6a5966 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -366,42 +366,32 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 	return iomap_bmap(mapping, block, &erofs_iomap_ops);
 }
 
-static int erofs_prepare_dio(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	loff_t align = iocb->ki_pos | iov_iter_count(to) |
-		iov_iter_alignment(to);
-	struct block_device *bdev = inode->i_sb->s_bdev;
-	unsigned int blksize_mask;
-
-	if (bdev)
-		blksize_mask = (1 << ilog2(bdev_logical_block_size(bdev))) - 1;
-	else
-		blksize_mask = (1 << inode->i_blkbits) - 1;
-
-	if (align & blksize_mask)
-		return -EINVAL;
-	return 0;
-}
 
-static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
-{
 	/* no need taking (shared) inode lock since it's a ro filesystem */
 	if (!iov_iter_count(to))
 		return 0;
 
 #ifdef CONFIG_FS_DAX
-	if (IS_DAX(iocb->ki_filp->f_mapping->host))
+	if (IS_DAX(inode))
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
 #endif
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		int err = erofs_prepare_dio(iocb, to);
-
-		if (!err)
-			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
-					    NULL, 0, 0);
-		if (err < 0)
-			return err;
+		loff_t align = iocb->ki_pos | iov_iter_count(to) |
+			iov_iter_alignment(to);
+		struct block_device *bdev = inode->i_sb->s_bdev;
+		unsigned int blksize_mask;
+
+		if (bdev)
+			blksize_mask = bdev_logical_block_size(bdev) - 1;
+		else
+			blksize_mask = (1 << inode->i_blkbits) - 1;
+
+		if (align & blksize_mask)
+			return -EINVAL;
+		return iomap_dio_rw(iocb, to, &erofs_iomap_ops, NULL, 0, 0);
 	}
 	return filemap_read(iocb, to, 0);
 }
-- 
2.24.4

