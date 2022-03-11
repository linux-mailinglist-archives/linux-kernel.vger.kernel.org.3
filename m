Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C244D5842
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345695AbiCKCn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiCKCny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:43:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B003F3584A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:42:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48ADF60B22
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1692C340E8;
        Fri, 11 Mar 2022 02:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646966571;
        bh=jMF+7A91O+CmShR7jtuBs7wudx+hHvkwGcYaTfViQeg=;
        h=From:To:Cc:Subject:Date:From;
        b=BgA8wgE2jmR6CmyR9PfBrZu+Y/t8HwTk2AZDQZm/cKKaTHSDmBlMJ62flLj0xhey+
         1n24qoD4fYv+II0qVmEuV6bQRI0PxgK4AAYM8+54BpQ9voQ6oOImfbFguS0jicREdD
         nDpGa1DQqEB4R6kmgG5BW2tsXlpf8EVjd8K0teyQzQsgpkVKFpznwHrGgAVK+XOqP8
         ZmPz+V85hjEJlHWRjigIZHbbQdOGg7BahewIj2aIhZF8LRIDPPmRWRq6r9yxsJnk1Q
         zZcXWubdBnSaVupyHvrLwOWE6qMO3jZNsfFMggIx9GKBSgGVJwi2RzyIFFe1Flqj2x
         N0OJ1u8dtgNXQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Hyunchul Lee <cheol.lee@lge.com>, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: fix to override bi_write_hint in fs-based whint_mode
Date:   Fri, 11 Mar 2022 10:42:40 +0800
Message-Id: <20220311024240.3700299-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If whint_mode=fs-based, for direct write IO, it needs to override
bio.bi_write_hint with the hint provided by filesystem.

Fixes: 0cdd31953967 ("f2fs: support passing down write hints given by users to block layer")
Cc: Hyunchul Lee <cheol.lee@lge.com>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/file.c    | 21 +++++++++++++++++++++
 fs/f2fs/segment.c | 17 +++++++++++------
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 68d791ec8b27..01d1393b8f83 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3629,6 +3629,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 			block_t old_addr, block_t new_addr,
 			unsigned char version, bool recover_curseg,
 			bool recover_newaddr);
+int f2fs_get_segment_temp(int seg_type);
 void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			block_t old_blkaddr, block_t *new_blkaddr,
 			struct f2fs_summary *sum, int type,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d5c3273c6efe..9a1c4f69a39a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4458,6 +4458,26 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
 	return ret;
 }
 
+
+static void f2fs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
+							  loff_t file_offset)
+{
+	struct inode *inode = iter->inode;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_FS) {
+		int seg_type = f2fs_rw_hint_to_seg_type(bio->bi_write_hint);
+		enum temp_type temp = f2fs_get_segment_temp(seg_type);
+
+		/*
+		 * in fs-based whint_mode, override bi_write_hint w/
+		 * the hint provided by filesystem.
+		 */
+		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
+	}
+	submit_bio(bio);
+}
+
 static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
 				 unsigned int flags)
 {
@@ -4472,6 +4492,7 @@ static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
 
 static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
 	.end_io = f2fs_dio_write_end_io,
+	.submit_io = f2fs_dio_submit_io,
 };
 
 static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 012524db7437..20aa9f11de5e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3397,6 +3397,15 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 	}
 }
 
+int f2fs_get_segment_temp(int seg_type)
+{
+	if (IS_HOT(seg_type))
+		return HOT;
+	else if (IS_WARM(seg_type))
+		return WARM;
+	return COLD;
+}
+
 static int __get_segment_type(struct f2fs_io_info *fio)
 {
 	int type = 0;
@@ -3415,12 +3424,8 @@ static int __get_segment_type(struct f2fs_io_info *fio)
 		f2fs_bug_on(fio->sbi, true);
 	}
 
-	if (IS_HOT(type))
-		fio->temp = HOT;
-	else if (IS_WARM(type))
-		fio->temp = WARM;
-	else
-		fio->temp = COLD;
+	fio->temp = f2fs_get_segment_temp(type);
+
 	return type;
 }
 
-- 
2.25.1

