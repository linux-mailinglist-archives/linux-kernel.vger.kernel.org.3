Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65C0507D00
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347270AbiDSXDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240456AbiDSXDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:03:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D3A24F38
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B7DA60765
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C93EC385A5;
        Tue, 19 Apr 2022 23:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650409236;
        bh=UHi+8r+t89WZXLmgz78ORNj82wrsPhquz2dEIzRPnzA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=JrIN3+m2tNxPlc+STKEHUt7Nyv8SxDe0TRGmujJ+RmhRuiYJBM4d3mcvfn8AeIMlq
         zxHlA0bZMgxkraen73a+n0g9nd2l1uSLaf1bBkglc/teZzexM/mtyMu9nXb7JA4wMR
         kFT/m+3PlsepHslcvYJHX4br3c2yWK5BrceRxH7d/BEydx/psrLw1AFTNj0bOCYzfK
         Ufha0/61ixu3KioN5+mOYi11khHqv3yqMreRXN3rGr49EkT+l3/rOl9VHCD0eM7ksZ
         cN37TDsxbUtztNk2+q/7+Oyefj/J+vISfkBN86e+SxsrJ8yuQ/z3M3GVdNWrZD5u/P
         hpLNjUfwEVQOA==
Date:   Tue, 19 Apr 2022 16:00:34 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2 v3] f2fs: avoid infinite loop to flush
 node pages
Message-ID: <Yl8/EumA9Hm0yF3r@google.com>
References: <20220411212141.1775589-1-jaegeuk@kernel.org>
 <20220411212141.1775589-2-jaegeuk@kernel.org>
 <Ylif523qTzL9eq1C@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylif523qTzL9eq1C@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 Change log from v2:
  - minor code refactoring

 fs/f2fs/checkpoint.c |  8 +-------
 fs/f2fs/f2fs.h       | 23 +++++++++++++++++++----
 fs/f2fs/node.c       | 23 ++++++++++++-----------
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 71b1e93cbe0c..beceac9885c3 100644
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
index 8c570de21ed5..f3eda4f13646 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -578,8 +578,8 @@ enum {
 /* maximum retry quota flush count */
 #define DEFAULT_RETRY_QUOTA_FLUSH_COUNT		8
 
-/* maximum retry of EIO'ed meta page */
-#define MAX_RETRY_META_PAGE_EIO			100
+/* maximum retry of EIO'ed page */
+#define MAX_RETRY_PAGE_EIO			100
 
 #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
 
@@ -1614,8 +1614,8 @@ struct f2fs_sb_info {
 	/* keep migration IO order for LFS mode */
 	struct f2fs_rwsem io_order_lock;
 	mempool_t *write_io_dummy;		/* Dummy pages */
-	pgoff_t metapage_eio_ofs;		/* EIO page offset */
-	int metapage_eio_cnt;			/* EIO count */
+	pgoff_t page_eio_ofs[NR_PAGE_TYPE];	/* EIO page offset */
+	int page_eio_cnt[NR_PAGE_TYPE];		/* EIO count */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
@@ -4534,6 +4534,21 @@ static inline void f2fs_io_schedule_timeout(long timeout)
 	io_schedule_timeout(timeout);
 }
 
+static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
+					enum page_type type)
+{
+	if (unlikely(f2fs_cp_error(sbi)))
+		return;
+
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
index 144f9f966690..51230cba841b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1416,8 +1416,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 
 	err = read_node_page(page, 0);
 	if (err < 0) {
-		f2fs_put_page(page, 1);
-		return ERR_PTR(err);
+		goto out_put_err;
 	} else if (err == LOCKED_PAGE) {
 		err = 0;
 		goto page_hit;
@@ -1443,19 +1442,21 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 		goto out_err;
 	}
 page_hit:
-	if (unlikely(nid != nid_of_node(page))) {
-		f2fs_warn(sbi, "inconsistent node block, nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
+	if (likely(nid == nid_of_node(page)))
+		return page;
+
+	f2fs_warn(sbi, "inconsistent node block, nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
 			  nid, nid_of_node(page), ino_of_node(page),
 			  ofs_of_node(page), cpver_of_node(page),
 			  next_blkaddr_of_node(page));
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		err = -EINVAL;
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	err = -EINVAL;
 out_err:
-		ClearPageUptodate(page);
-		f2fs_put_page(page, 1);
-		return ERR_PTR(err);
-	}
-	return page;
+	ClearPageUptodate(page);
+out_put_err:
+	f2fs_handle_page_eio(sbi, page->index, NODE);
+	f2fs_put_page(page, 1);
+	return ERR_PTR(err);
 }
 
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
-- 
2.36.0.rc0.470.gd361397f0d-goog

