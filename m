Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771CC4C6CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbiB1MmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiB1MmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:42:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BA6517CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sO2im4q5HIxQ/9U7/PnqC7nl9Uj+KF5Fp6rQ0FndRNE=; b=BivsgwChJw97A0S/uSpa52r0My
        qVGNhxb5MX50TYGOfNOirKymaMrAKXYyjuDLMIndNKkXI4O8YGNg3mDwPPiU8cmBECswKZtt0gdEX
        b26QYXNKP1GOPOhGt/UbPiWYTjgXQ6bQzkRgkrXdLJaELSdGK0/yl26l1kXK7MkwwX+baoQ5kG1Rm
        ap+36rhuuQqJXNe54vPbsa3fNTGr5Q9wg385nn5U7zCwpO7n1VXX+7nI1cjwGDbvZ2vdTEXhm6Hep
        TVfTRbIMFweU1LDWgxLSTy+bKKwSBH6Aq363FxxVzfdaHxHb+MEaAgJLUb+afUx0aYZSE5UoBfnaM
        kcZWDBLA==;
Received: from [2.53.163.181] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOfLG-00CHdk-Ex; Mon, 28 Feb 2022 12:41:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] f2fs: don't pass a bio to f2fs_target_device
Date:   Mon, 28 Feb 2022 14:41:22 +0200
Message-Id: <20220228124123.856027-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228124123.856027-1-hch@lst.de>
References: <20220228124123.856027-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the bdev at bio allocation time by changing the f2fs_target_device
calling conventions, so that no bio needs to be passed in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/data.c | 25 +++++++++++++------------
 fs/f2fs/f2fs.h |  2 +-
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e71dde8de0db0..59dd0347c4bc8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -354,7 +354,7 @@ static void f2fs_write_end_io(struct bio *bio)
 }
 
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
-				block_t blk_addr, struct bio *bio)
+		block_t blk_addr, sector_t *sector)
 {
 	struct block_device *bdev = sbi->sb->s_bdev;
 	int i;
@@ -369,10 +369,9 @@ struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 			}
 		}
 	}
-	if (bio) {
-		bio_set_dev(bio, bdev);
-		bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(blk_addr);
-	}
+
+	if (sector)
+		*sector = SECTOR_FROM_BLOCK(blk_addr);
 	return bdev;
 }
 
@@ -392,11 +391,13 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
 static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
+	struct block_device *bdev;
+	sector_t sector;
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(NULL, npages, 0, GFP_NOIO, &f2fs_bioset);
-
-	f2fs_target_device(sbi, fio->new_blkaddr, bio);
+	bdev = f2fs_target_device(sbi, fio->new_blkaddr, &sector);
+	bio = bio_alloc_bioset(bdev, npages, 0, GFP_NOIO, &f2fs_bioset);
+	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
 		bio->bi_private = NULL;
@@ -984,15 +985,15 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	struct bio *bio;
 	struct bio_post_read_ctx *ctx = NULL;
 	unsigned int post_read_steps = 0;
+	sector_t sector;
+	struct block_device *bdev = f2fs_target_device(sbi, blkaddr, &sector);
 
-	bio = bio_alloc_bioset(NULL, bio_max_segs(nr_pages), REQ_OP_READ,
+	bio = bio_alloc_bioset(bdev, bio_max_segs(nr_pages), REQ_OP_READ,
 			       for_write ? GFP_NOIO : GFP_KERNEL, &f2fs_bioset);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-
+	bio->bi_iter.bi_sector = sector;
 	f2fs_set_bio_crypt_ctx(bio, inode, first_idx, NULL, GFP_NOFS);
-
-	f2fs_target_device(sbi, blkaddr, bio);
 	bio->bi_end_io = f2fs_read_end_io;
 
 	if (fscrypt_inode_uses_fs_layer_crypto(inode))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eb22fa91c2b26..37faae388fe01 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3631,7 +3631,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio);
 int f2fs_merge_page_bio(struct f2fs_io_info *fio);
 void f2fs_submit_page_write(struct f2fs_io_info *fio);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
-			block_t blk_addr, struct bio *bio);
+		block_t blk_addr, sector_t *sector);
 int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr);
 void f2fs_set_data_blkaddr(struct dnode_of_data *dn);
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
-- 
2.30.2

