Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC6D571F15
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiGLP05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiGLP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:26:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336F8CE3F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3592B819CD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5C8C3411C;
        Tue, 12 Jul 2022 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657639611;
        bh=47AE1yhhBTrAxEd2qCdPE3/6spXztbOG8ZtTMXmH9FY=;
        h=From:To:Cc:Subject:Date:From;
        b=dOjZ3+ralCttvgDSBN9svWCIhPUiwYEf92ook7K+/VCDdDqVlccOuxGrNBLK4wbWY
         E36W10FplCKhJX33rn0Pd1RGoa1Hyup6UpXZOyI6C3BNz42go+ypcUt+wnskBIsKcX
         NPR7duHOvitSk4Fqbigkfshf0wa0V3hsr9alMGvSTXWhBVEptqddkNK3bXI2z1MXHd
         lEig/gTbjXIcjzMv17tsQtkbaMZWRaRh7IyB+bWJ5xy/x+/oFM4ytiPc6Ikefs3Jql
         0H/11ar8R2MILvTUVvzVkJZEfoVH2LVcTHPSSQn9mr3HtHnT/7zLK/VQmou+Wxsy2z
         37TW1KvkVOi4A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: invalidate meta pages only for post_read required inode
Date:   Tue, 12 Jul 2022 23:26:43 +0800
Message-Id: <20220712152643.4018-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit e3b49ea36802 ("f2fs: invalidate META_MAPPING before
IPU/DIO write"), invalidate_mapping_pages() will be called to
avoid race condition in between IPU/DIO and readahead for GC.

However, readahead flow is only used for post_read required inode,
so this patch adds check condition to avoids unnecessary page cache
invalidating for non-post_read inode.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/data.c    | 8 ++------
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/segment.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2d027505d5f6..a54b91b3a8d4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1479,12 +1479,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			*map->m_next_extent = pgofs + map->m_len;
 
 		/* for hardware encryption, but to avoid potential issue in future */
-		if (flag == F2FS_GET_BLOCK_DIO) {
+		if (flag == F2FS_GET_BLOCK_DIO)
 			f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
-			invalidate_mapping_pages(META_MAPPING(sbi),
-				map->m_pblk, map->m_pblk + map->m_len - 1);
-		}
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
@@ -1700,8 +1697,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		 */
 		f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
-		invalidate_mapping_pages(META_MAPPING(sbi),
-				map->m_pblk, map->m_pblk + map->m_len - 1);
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
@@ -2749,6 +2744,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.submitted = false,
 		.compr_blocks = compr_blocks,
 		.need_lock = LOCK_RETRY,
+		.post_read = f2fs_post_read_required(inode),
 		.io_type = io_type,
 		.io_wbc = wbc,
 		.bio = bio,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1d97d06e0d87..87e96f612582 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1199,6 +1199,7 @@ struct f2fs_io_info {
 	bool retry;		/* need to reallocate block address */
 	int compr_blocks;	/* # of compressed block addresses */
 	bool encrypted;		/* indicate file is encrypted */
+	bool post_read;		/* require post read */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
 	struct bio **bio;		/* bio for ipu */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ce571c0d7126..12b0edc48f7b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3433,7 +3433,8 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
-	invalidate_mapping_pages(META_MAPPING(sbi),
+	if (fio->post_read)
+		invalidate_mapping_pages(META_MAPPING(sbi),
 				fio->new_blkaddr, fio->new_blkaddr);
 
 	stat_inc_inplace_blocks(fio->sbi);
@@ -3616,10 +3617,16 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	block_t i;
 
+	if (!f2fs_post_read_required(inode))
+		return;
+
 	for (i = 0; i < len; i++)
 		f2fs_wait_on_block_writeback(inode, blkaddr + i);
+
+	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr + len - 1);
 }
 
 static int read_compacted_summaries(struct f2fs_sb_info *sbi)
-- 
2.36.1

