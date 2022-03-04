Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB65F4CCBA7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiCDCUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiCDCUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:20:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2621167F9F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:19:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44F6D61785
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954FBC340E9;
        Fri,  4 Mar 2022 02:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646360398;
        bh=+K4HyZ3cdG7e3Iua5G4TDQLJZxt25ZPQtp0tzpcxw34=;
        h=From:To:Cc:Subject:Date:From;
        b=ANsvXB3CPCBPSnzh6ym2HggLY5upXtRglk60r5GM1bhdL2nTcLmRmAODUJ+jrk8cx
         OQlOjLkJX8mXnq00jMEu4cYAD6jN2dU/Co9mxtNNeZaIo3sd1IwkWueVSWDrJ63Enk
         BHzleBp/r9jXjytCmmYQqcmSZskPHjpsocuXLivOeQiiyelG4mNzdVpMtFU/tsME0W
         7anik83iIst2Js32KYa9ma4xD6qvWwSP9fVf/I+fGEBYTbqilp8OeeJOhzHTqufQtD
         wItuukn3M25ZpO2H49KyaI0zvAhf5Q2Yt0WQsw/zeDrSugXhRXWXIVqxFJmuWHnDs3
         4DQnb/+KXa8Iw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: avoid an infinite loop in f2fs_sync_dirty_inodes
Date:   Thu,  3 Mar 2022 18:19:54 -0800
Message-Id: <20220304021955.2524246-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one read IO is always failing, we can fall into an infinite loop in
f2fs_sync_dirty_inodes. This happens during xfstests/generic/475.

[  142.803335] Buffer I/O error on dev dm-1, logical block 8388592, async page read
...
[  382.887210]  submit_bio_noacct+0xdd/0x2a0
[  382.887213]  submit_bio+0x80/0x110
[  382.887223]  __submit_bio+0x4d/0x300 [f2fs]
[  382.887282]  f2fs_submit_page_bio+0x125/0x200 [f2fs]
[  382.887299]  __get_meta_page+0xc9/0x280 [f2fs]
[  382.887315]  f2fs_get_meta_page+0x13/0x20 [f2fs]
[  382.887331]  f2fs_get_node_info+0x317/0x3c0 [f2fs]
[  382.887350]  f2fs_do_write_data_page+0x327/0x6f0 [f2fs]
[  382.887367]  f2fs_write_single_data_page+0x5b7/0x960 [f2fs]
[  382.887386]  f2fs_write_cache_pages+0x302/0x890 [f2fs]
[  382.887405]  ? preempt_count_add+0x7a/0xc0
[  382.887408]  f2fs_write_data_pages+0xfd/0x320 [f2fs]
[  382.887425]  ? _raw_spin_unlock+0x1a/0x30
[  382.887428]  do_writepages+0xd3/0x1d0
[  382.887432]  filemap_fdatawrite_wbc+0x69/0x90
[  382.887434]  filemap_fdatawrite+0x50/0x70
[  382.887437]  f2fs_sync_dirty_inodes+0xa4/0x270 [f2fs]
[  382.887453]  f2fs_write_checkpoint+0x189/0x1640 [f2fs]
[  382.887469]  ? schedule_timeout+0x114/0x150
[  382.887471]  ? ttwu_do_activate+0x6d/0xb0
[  382.887473]  ? preempt_count_add+0x7a/0xc0
[  382.887476]  kill_f2fs_super+0xca/0x100 [f2fs]
[  382.887491]  deactivate_locked_super+0x35/0xa0
[  382.887494]  deactivate_super+0x40/0x50
[  382.887497]  cleanup_mnt+0x139/0x190
[  382.887499]  __cleanup_mnt+0x12/0x20
[  382.887501]  task_work_run+0x64/0xa0
[  382.887505]  exit_to_user_mode_prepare+0x1b7/0x1c0
[  382.887508]  syscall_exit_to_user_mode+0x27/0x50
[  382.887510]  do_syscall_64+0x48/0xc0
[  382.887513]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 7 +++++++
 fs/f2fs/f2fs.h       | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 203a1577942d..871eee35a32f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -98,6 +98,13 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 	}
 
 	if (unlikely(!PageUptodate(page))) {
+		if (page->index == sbi->metapage_eio_ofs &&
+			sbi->metapage_eio_cnt++ == MAX_RETRY_META_PAGE_EIO) {
+			set_ckpt_flags(sbi, CP_ERROR_FLAG);
+		} else {
+			sbi->metapage_eio_ofs = page->index;
+			sbi->metapage_eio_cnt = 0;
+		}
 		f2fs_put_page(page, 1);
 		return ERR_PTR(-EIO);
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 47bf9e30913f..efc4f1fe2ffd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -577,6 +577,9 @@ enum {
 /* maximum retry quota flush count */
 #define DEFAULT_RETRY_QUOTA_FLUSH_COUNT		8
 
+/* maximum retry of EIO'ed meta page */
+#define MAX_RETRY_META_PAGE_EIO			100
+
 #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
 
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
@@ -1614,6 +1617,8 @@ struct f2fs_sb_info {
 	/* keep migration IO order for LFS mode */
 	struct f2fs_rwsem io_order_lock;
 	mempool_t *write_io_dummy;		/* Dummy pages */
+	pgoff_t metapage_eio_ofs;		/* EIO page offset */
+	int metapage_eio_cnt;			/* EIO count */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
-- 
2.35.1.616.g0bdcbb4464-goog

