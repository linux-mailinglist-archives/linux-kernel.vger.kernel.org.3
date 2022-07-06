Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F4B567E94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiGFGbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiGFGam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:30:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB41A3BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84FC0B81AEC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4DAC3411C;
        Wed,  6 Jul 2022 06:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657089025;
        bh=PTwnVLqCKTknxTFPAXpZG38/BbOEsnQ5HZjLPj6vgEs=;
        h=From:To:Cc:Subject:Date:From;
        b=gstNkweOe/7+xVYqNE9xStimSVujj9AmDdhf5JgNcY5MCoHU+lKImBc2a262m+QrI
         hEDZUnc4ayavXp2ngUY6KKKAdX7DnEROSBPN1e1YXy8dTLwJioeHX0uMQkHwodNRQV
         YEOXPjgIX1wBqEMsWUicf9kFm7esDf1ZlvdlvLYxVqyRP2HjUtEx8dPt0hNTnBtoHJ
         vZh3YWduf+didN2wppVq7rBH7GzYrJicp5xkUYbYoFdHw29KLPDmBSbJ/c/PdQh2WE
         xn/seLHvCSW3ZkCSAc4UtyWZVhjHRE8FleBkC+u6N6aTVGSVUpyBrmOxHV8+Sd66kc
         buJSafA3cxPIQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: fix to invalidate META_MAPPING before DIO write
Date:   Wed,  6 Jul 2022 14:30:15 +0800
Message-Id: <20220706063015.29727-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoted from commit e3b49ea36802 ("f2fs: invalidate META_MAPPING before
IPU/DIO write")

"
Encrypted pages during GC are read and cached in META_MAPPING.
However, due to cached pages in META_MAPPING, there is an issue where
newly written pages are lost by IPU or DIO writes.

Thread A - f2fs_gc()            Thread B
/* phase 3 */
down_write(i_gc_rwsem)
ra_data_block()       ---- (a)
up_write(i_gc_rwsem)
                                f2fs_direct_IO() :
                                 - down_read(i_gc_rwsem)
                                 - __blockdev_direct_io()
                                 - get_data_block_dio_write()
                                 - f2fs_dio_submit_bio()  ---- (b)
                                 - up_read(i_gc_rwsem)
/* phase 4 */
down_write(i_gc_rwsem)
move_data_block()     ---- (c)
up_write(i_gc_rwsem)

(a) In phase 3 of f2fs_gc(), up-to-date page is read from storage and
    cached in META_MAPPING.
(b) In thread B, writing new data by IPU or DIO write on same blkaddr as
    read in (a). cached page in META_MAPPING become out-dated.
(c) In phase 4 of f2fs_gc(), out-dated page in META_MAPPING is copied to
    new blkaddr. In conclusion, the newly written data in (b) is lost.

To address this issue, invalidating pages in META_MAPPING before IPU or
DIO write.
"

In previous commit, we missed to cover extent cache hit case, and passed
wrong value for parameter @end of invalidate_mapping_pages(), fix both
issues.

Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
Fixes: e3b49ea36802 ("f2fs: invalidate META_MAPPING before IPU/DIO write")
Cc: Hyeong-Jun Kim <hj514.kim@samsung.com>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/data.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c448c3ee7ac3..2d027505d5f6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1479,9 +1479,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			*map->m_next_extent = pgofs + map->m_len;
 
 		/* for hardware encryption, but to avoid potential issue in future */
-		if (flag == F2FS_GET_BLOCK_DIO)
+		if (flag == F2FS_GET_BLOCK_DIO) {
 			f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
+			invalidate_mapping_pages(META_MAPPING(sbi),
+				map->m_pblk, map->m_pblk + map->m_len - 1);
+		}
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
@@ -1698,7 +1701,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
 		invalidate_mapping_pages(META_MAPPING(sbi),
-						map->m_pblk, map->m_pblk);
+				map->m_pblk, map->m_pblk + map->m_len - 1);
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
-- 
2.25.1

