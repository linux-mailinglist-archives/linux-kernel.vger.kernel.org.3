Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7457B2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiGTIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGTIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:22:38 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C123D6BC13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:22:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VJw6BQ8_1658305349;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJw6BQ8_1658305349)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 16:22:34 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs: get rid of erofs_prepare_dio() helper
Date:   Wed, 20 Jul 2022 16:22:29 +0800
Message-Id: <20220720082229.12172-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fold in erofs_prepare_dio() in order to simplify the code.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20220506194612.117120-1-hsiangkao@linux.alibaba.com

 fs/erofs/data.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fbb037ba326e..fe8ac0e163f7 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -366,42 +366,33 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
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
 
-	if (align & blksize_mask)
-		return -EINVAL;
-	return 0;
-}
-
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
+		struct block_device *bdev = inode->i_sb->s_bdev;
+		unsigned int blksize_mask;
+
+		if (bdev)
+			blksize_mask = bdev_logical_block_size(bdev) - 1;
+		else
+			blksize_mask = (1 << inode->i_blkbits) - 1;
+
+		if ((iocb->ki_pos | iov_iter_count(to) |
+		     iov_iter_alignment(to)) & blksize_mask)
+			return -EINVAL;
 
-		if (!err)
-			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
-					    NULL, 0, NULL, 0);
-		if (err < 0)
-			return err;
+		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
+				    NULL, 0, NULL, 0);
 	}
 	return filemap_read(iocb, to, 0);
 }
-- 
2.24.4

