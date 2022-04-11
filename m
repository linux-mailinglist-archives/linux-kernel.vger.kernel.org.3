Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC45F4FC6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350168AbiDKVYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350077AbiDKVYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:24:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C732FE5C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0F78B818C6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAFFC385A4;
        Mon, 11 Apr 2022 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649712107;
        bh=gsIunwV9OVTYQPC6kZzO8ZN067jWFIRPVXs3S7CsLN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYsCjOwC9Ty5ywC0RvLiOo8jCZgnvAbk5XWFxmcVFMM0glXuVxRgz0y2AOwbmIIjl
         Y6ID/1SX0Aj5JETA+peHl0N+f2DDMOnREDYlD94f8lhXXbyWJ+5L4Web/wN3ZBPfcf
         rC7AY9CUfK+YC2hpYBAk8SRWA6lNEwuHEaTleHtr6aF0Wplcn1nlAKsHcV1M4wW33h
         01j02wsy4JIzHRKpKncZCJN8gozh5tI+o+NdfYWpiqTLRK18ej6c4KoQCOpoLAedSw
         FR9DtFFkHlXysCBZueHEjjpMimONIiv9uy36JRqGRRsQVSfT6baSmOKb2e0Q/wTNxZ
         bYCup5/ItUPLw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid infinite loop to flush node pages
Date:   Mon, 11 Apr 2022 14:21:41 -0700
Message-Id: <20220411212141.1775589-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
In-Reply-To: <20220411212141.1775589-1-jaegeuk@kernel.org>
References: <20220411212141.1775589-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfstests/generic/475 can give EIO all the time which give an infinite loop
to flush node page like below. Let's avoid it.

[16418.518551] Call Trace:
[16418.518553]  ? dm_submit_bio+0x48/0x400
[16418.518574]  ? submit_bio_checks+0x1ac/0x5a0
[16418.525207]  __submit_bio+0x1a9/0x230
[16418.525210]  ? kmem_cache_alloc+0x29e/0x3c0
[16418.525223]  submit_bio_noacct+0xa8/0x2b0
[16418.525226]  submit_bio+0x4d/0x130
[16418.525238]  __submit_bio+0x49/0x310 [f2fs]
[16418.525339]  ? bio_add_page+0x6a/0x90
[16418.525344]  f2fs_submit_page_bio+0x134/0x1f0 [f2fs]
[16418.525365]  read_node_page+0x125/0x1b0 [f2fs]
[16418.525388]  __get_node_page.part.0+0x58/0x3f0 [f2fs]
[16418.525409]  __get_node_page+0x2f/0x60 [f2fs]
[16418.525431]  f2fs_get_dnode_of_data+0x423/0x860 [f2fs]
[16418.525452]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[16418.525458]  ? __mod_memcg_state.part.0+0x2a/0x30
[16418.525465]  ? __mod_memcg_lruvec_state+0x27/0x40
[16418.525467]  ? __xa_set_mark+0x57/0x70
[16418.525472]  f2fs_do_write_data_page+0x10e/0x7b0 [f2fs]
[16418.525493]  f2fs_write_single_data_page+0x555/0x830 [f2fs]
[16418.525514]  ? sysvec_apic_timer_interrupt+0x4e/0x90
[16418.525518]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[16418.525523]  f2fs_write_cache_pages+0x303/0x880 [f2fs]
[16418.525545]  ? blk_flush_plug_list+0x47/0x100
[16418.525548]  f2fs_write_data_pages+0xfd/0x320 [f2fs]
[16418.525569]  do_writepages+0xd5/0x210
[16418.525648]  filemap_fdatawrite_wbc+0x7d/0xc0
[16418.525655]  filemap_fdatawrite+0x50/0x70
[16418.525658]  f2fs_sync_dirty_inodes+0xa4/0x230 [f2fs]
[16418.525679]  f2fs_write_checkpoint+0x16d/0x1720 [f2fs]
[16418.525699]  ? ttwu_do_wakeup+0x1c/0x160
[16418.525709]  ? ttwu_do_activate+0x6d/0xd0
[16418.525711]  ? __wait_for_common+0x11d/0x150
[16418.525715]  kill_f2fs_super+0xca/0x100 [f2fs]
[16418.525733]  deactivate_locked_super+0x3b/0xb0
[16418.525739]  deactivate_super+0x40/0x50
[16418.525741]  cleanup_mnt+0x139/0x190
[16418.525747]  __cleanup_mnt+0x12/0x20
[16418.525749]  task_work_run+0x6d/0xa0
[16418.525765]  exit_to_user_mode_prepare+0x1ad/0x1b0
[16418.525771]  syscall_exit_to_user_mode+0x27/0x50
[16418.525774]  do_syscall_64+0x48/0xc0
[16418.525776]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  8 +-------
 fs/f2fs/f2fs.h       | 20 ++++++++++++++++----
 fs/f2fs/node.c       |  1 +
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ed61ac99a3cf..a1aa6b8f2ed2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -98,13 +98,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 	}
 
 	if (unlikely(!PageUptodate(page))) {
-		if (page->index == sbi->metapage_eio_ofs) {
-			if (sbi->metapage_eio_cnt++ == MAX_RETRY_META_PAGE_EIO)
-				set_ckpt_flags(sbi, CP_ERROR_FLAG);
-		} else {
-			sbi->metapage_eio_ofs = page->index;
-			sbi->metapage_eio_cnt = 0;
-		}
+		f2fs_handle_page_eio(sbi, page->index, META);
 		f2fs_put_page(page, 1);
 		return ERR_PTR(-EIO);
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9c72a91912ae..2d10f1c8ed12 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -579,8 +579,8 @@ enum {
 /* maximum retry quota flush count */
 #define DEFAULT_RETRY_QUOTA_FLUSH_COUNT		8
 
-/* maximum retry of EIO'ed meta page */
-#define MAX_RETRY_META_PAGE_EIO			100
+/* maximum retry of EIO'ed page */
+#define MAX_RETRY_PAGE_EIO			100
 
 #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
 
@@ -1621,8 +1621,8 @@ struct f2fs_sb_info {
 	/* keep migration IO order for LFS mode */
 	struct f2fs_rwsem io_order_lock;
 	mempool_t *write_io_dummy;		/* Dummy pages */
-	pgoff_t metapage_eio_ofs;		/* EIO page offset */
-	int metapage_eio_cnt;			/* EIO count */
+	pgoff_t page_eio_ofs[NR_PAGE_TYPE];	/* EIO page offset */
+	int page_eio_cnt[NR_PAGE_TYPE];		/* EIO count */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
@@ -4538,6 +4538,18 @@ static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
 }
 
+static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
+					enum page_type type)
+{
+	if (ofs == sbi->page_eio_ofs[type]) {
+		if (sbi->page_eio_cnt[type]++ == MAX_RETRY_PAGE_EIO)
+			set_ckpt_flags(sbi, CP_ERROR_FLAG);
+	} else {
+		sbi->page_eio_ofs[type] = ofs;
+		sbi->page_eio_cnt[type] = 0;
+	}
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fe8c38c9ac77..87f1a8364f21 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1416,6 +1416,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 
 	err = read_node_page(page, 0);
 	if (err < 0) {
+		f2fs_handle_page_eio(sbi, page->index, NODE);
 		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
 	} else if (err == LOCKED_PAGE) {
-- 
2.35.1.1178.g4f1659d476-goog

