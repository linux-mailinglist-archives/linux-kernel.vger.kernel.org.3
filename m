Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE874C6CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiB1MmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiB1MmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:42:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4EB74878
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IR4abFvHdW12CaulzRpJ7ldY+fqUsw7Tyy0gpgznxxI=; b=OoW4TgUzT4R+MfenewyNryXeUW
        iUL2PXMIjxTZ5yJDCOM6yL0WBzWRJJ6Y463Kahd9peAFJng7WXdTXf1JgTu2QY7KO3mXw3mumoU/r
        q30VivZukzwo+BIyGQ/rrRKYztZZpf8WPJXi8TtN8ev7iU/01cpfUCDWt8B5lpLP4vIOPNURRit4t
        60hDFVt3uDc/endDjmoChnaQKjPMTe2ec7jFN4xF2oVq6OT+BQnRJmHfF0Lg8jjJjCZpcZQlQrHjJ
        ixUur7ZpsLXDr15j7MCNssueEMdMdmssra5Dod6ibAr+/eYEhicDGIsRbrCoxKfKskpVwe9zdWz3q
        CNts/IFQ==;
Received: from [2.53.163.181] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOfLJ-00CHew-Lq; Mon, 28 Feb 2022 12:41:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] f2fs: pass the bio operation to bio_alloc_bioset
Date:   Mon, 28 Feb 2022 14:41:23 +0200
Message-Id: <20220228124123.856027-3-hch@lst.de>
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

Refactor block I/O code so that the bio operation and known flags are set
at bio allocation time.  Only the later updated flags are updated on the
fly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/data.c | 70 +++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 59dd0347c4bc8..fc077bce679d9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -388,6 +388,24 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
 	return 0;
 }
 
+static void __attach_io_flag(struct f2fs_io_info *fio, unsigned int io_flag)
+{
+	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;
+	unsigned int fua_flag = io_flag & temp_mask;
+	unsigned int meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
+
+	/*
+	 * data/node io flag bits per temp:
+	 *      REQ_META     |      REQ_FUA      |
+	 *    5 |    4 |   3 |    2 |    1 |   0 |
+	 * Cold | Warm | Hot | Cold | Warm | Hot |
+	 */
+	if ((1 << fio->temp) & meta_flag)
+		fio->op_flags |= REQ_META;
+	if ((1 << fio->temp) & fua_flag)
+		fio->op_flags |= REQ_FUA;
+}
+
 static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
@@ -395,8 +413,14 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	sector_t sector;
 	struct bio *bio;
 
+	if (fio->type == DATA)
+		__attach_io_flag(fio, sbi->data_io_flag);
+	else if (fio->type == NODE)
+		__attach_io_flag(fio, sbi->node_io_flag);
+
 	bdev = f2fs_target_device(sbi, fio->new_blkaddr, &sector);
-	bio = bio_alloc_bioset(bdev, npages, 0, GFP_NOIO, &f2fs_bioset);
+	bio = bio_alloc_bioset(bdev, npages, fio->op | fio->op_flags, GFP_NOIO,
+			       &f2fs_bioset);
 	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
@@ -501,34 +525,6 @@ void f2fs_submit_bio(struct f2fs_sb_info *sbi,
 	__submit_bio(sbi, bio, type);
 }
 
-static void __attach_io_flag(struct f2fs_io_info *fio)
-{
-	struct f2fs_sb_info *sbi = fio->sbi;
-	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;
-	unsigned int io_flag, fua_flag, meta_flag;
-
-	if (fio->type == DATA)
-		io_flag = sbi->data_io_flag;
-	else if (fio->type == NODE)
-		io_flag = sbi->node_io_flag;
-	else
-		return;
-
-	fua_flag = io_flag & temp_mask;
-	meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
-
-	/*
-	 * data/node io flag bits per temp:
-	 *      REQ_META     |      REQ_FUA      |
-	 *    5 |    4 |   3 |    2 |    1 |   0 |
-	 * Cold | Warm | Hot | Cold | Warm | Hot |
-	 */
-	if ((1 << fio->temp) & meta_flag)
-		fio->op_flags |= REQ_META;
-	if ((1 << fio->temp) & fua_flag)
-		fio->op_flags |= REQ_FUA;
-}
-
 static void __submit_merged_bio(struct f2fs_bio_info *io)
 {
 	struct f2fs_io_info *fio = &io->fio;
@@ -536,9 +532,6 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	if (!io->bio)
 		return;
 
-	__attach_io_flag(fio);
-	bio_set_op_attrs(io->bio, fio->op, fio->op_flags);
-
 	if (is_read_io(fio->op))
 		trace_f2fs_prepare_read_bio(io->sbi->sb, fio->type, io->bio);
 	else
@@ -596,10 +589,9 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 	/* change META to META_FLUSH in the checkpoint procedure */
 	if (type >= META_FLUSH) {
 		io->fio.type = META_FLUSH;
-		io->fio.op = REQ_OP_WRITE;
-		io->fio.op_flags = REQ_META | REQ_PRIO | REQ_SYNC;
+		io->bio->bi_opf |= REQ_META | REQ_PRIO | REQ_SYNC;
 		if (!test_opt(sbi, NOBARRIER))
-			io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
+			io->bio->bi_opf |= REQ_PREFLUSH | REQ_FUA;
 	}
 	__submit_merged_bio(io);
 	up_write(&io->io_rwsem);
@@ -680,9 +672,6 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc && !is_read_io(fio->op))
 		wbc_account_cgroup_owner(fio->io_wbc, page, PAGE_SIZE);
 
-	__attach_io_flag(fio);
-	bio_set_op_attrs(bio, fio->op, fio->op_flags);
-
 	inc_page_count(fio->sbi, is_read_io(fio->op) ?
 			__read_io_type(page): WB_DATA_TYPE(fio->page));
 
@@ -876,10 +865,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 alloc_new:
 	if (!bio) {
 		bio = __bio_alloc(fio, BIO_MAX_VECS);
-		__attach_io_flag(fio);
 		f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
 				       fio->page->index, fio, GFP_NOIO);
-		bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
 		add_bio_entry(fio->sbi, bio, page, fio->temp);
 	} else {
@@ -988,7 +975,8 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	sector_t sector;
 	struct block_device *bdev = f2fs_target_device(sbi, blkaddr, &sector);
 
-	bio = bio_alloc_bioset(bdev, bio_max_segs(nr_pages), REQ_OP_READ,
+	bio = bio_alloc_bioset(bdev, bio_max_segs(nr_pages),
+			       REQ_OP_READ | op_flag,
 			       for_write ? GFP_NOIO : GFP_KERNEL, &f2fs_bioset);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-- 
2.30.2

