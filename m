Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306144F6736
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbiDFR1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbiDFR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30AE485E6C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF4EF61C4E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4E2C385A1;
        Wed,  6 Apr 2022 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649258825;
        bh=/gaoq7dw7G28yfHBdA+sdXDjrczgCIBTg9c3xRMRcmo=;
        h=From:To:Cc:Subject:Date:From;
        b=l/uDH/QwVcUjH2qm5pxMjoZnWRQnCFvUxn7G6JXDTbiKGubXHaE1MXl0qnob7lNYm
         SCCFjU2lBAfJOYCULz3BTWyMywoNGjmbe9QmDKvxcvRHoO38MeHIG3xY47XMxt85wh
         pTK6k6fWqCFfqjgbgb4pDkCRmwDJFw7c9rP8rt+dgCb6G3GdTaSOzde84c3J1kv9y5
         zBdDMRQwLtRCCkDC5uZjI/5YgU0/basz69o0NB4KLAMeVUGmr5x7ZaXTPoYxIhQGYx
         rBKCXhkqNULGr2Q5OuaThA97jp8LCICGvKW3q/jT5tIaljdcnMPytupyJCr1e8KoMc
         6kWPqoJZsJRHg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH v3] f2fs: give priority to select unpinned section for foreground GC
Date:   Wed,  6 Apr 2022 23:26:51 +0800
Message-Id: <20220406152651.5142-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
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

Previously, during foreground GC, if victims contain data of pinned file,
it will fail migration of the data, and meanwhile i_gc_failures of that
pinned file may increase, and when it exceeds threshold, GC will unpin
the file, result in breaking pinfile's semantics.

In order to mitigate such condition, let's record and skip section which
has pinned file's data and give priority to select unpinned one.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
v3:
- check pin status before pinning section in pin_section().
 fs/f2fs/gc.c      | 56 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/f2fs/segment.c |  7 ++++++
 fs/f2fs/segment.h |  2 ++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6a7e4148ff9d..df23824ae3c2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -646,6 +646,37 @@ static void release_victim_entry(struct f2fs_sb_info *sbi)
 	f2fs_bug_on(sbi, !list_empty(&am->victim_list));
 }
 
+static void pin_section(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+
+	if (test_bit(secno, dirty_i->pinned_secmap))
+		return;
+	set_bit(secno, dirty_i->pinned_secmap);
+	dirty_i->pinned_secmap_cnt++;
+}
+
+static bool pinned_section_exists(struct dirty_seglist_info *dirty_i)
+{
+	return dirty_i->pinned_secmap_cnt;
+}
+
+static bool section_is_pinned(struct dirty_seglist_info *dirty_i,
+						unsigned int secno)
+{
+	return pinned_section_exists(dirty_i) &&
+			test_bit(secno, dirty_i->pinned_secmap);
+}
+
+static void unpin_all_sections(struct f2fs_sb_info *sbi)
+{
+	unsigned int bitmap_size = f2fs_bitmap_size(MAIN_SECS(sbi));
+
+	memset(DIRTY_I(sbi)->pinned_secmap, 0, bitmap_size);
+	DIRTY_I(sbi)->pinned_secmap_cnt = 0;
+}
+
 /*
  * This function is called from two paths.
  * One is garbage collection and the other is SSR segment selection.
@@ -787,6 +818,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
 			goto next;
 
+		if (gc_type == FG_GC && section_is_pinned(dirty_i, secno))
+			goto next;
+
 		if (is_atgc) {
 			add_victim_entry(sbi, &p, segno);
 			goto next;
@@ -1202,8 +1236,10 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	}
 
 	if (f2fs_is_pinned_file(inode)) {
-		if (gc_type == FG_GC)
+		if (gc_type == FG_GC) {
 			f2fs_pin_file_control(inode, true);
+			pin_section(F2FS_I_SB(inode), segno);
+		}
 		err = -EAGAIN;
 		goto out;
 	}
@@ -1352,8 +1388,10 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		goto out;
 	}
 	if (f2fs_is_pinned_file(inode)) {
-		if (gc_type == FG_GC)
+		if (gc_type == FG_GC) {
 			f2fs_pin_file_control(inode, true);
+			pin_section(F2FS_I_SB(inode), segno);
+		}
 		err = -EAGAIN;
 		goto out;
 	}
@@ -1485,6 +1523,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 							gc_type == FG_GC) {
 				f2fs_pin_file_control(inode, true);
 				iput(inode);
+				pin_section(sbi, segno);
 				return submitted;
 			}
 
@@ -1766,9 +1805,17 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		ret = -EINVAL;
 		goto stop;
 	}
+retry:
 	ret = __get_victim(sbi, &segno, gc_type);
-	if (ret)
+	if (ret) {
+		/* allow to search victim from sections has pinned data */
+		if (ret == -ENODATA && gc_type == FG_GC &&
+				pinned_section_exists(DIRTY_I(sbi))) {
+			unpin_all_sections(sbi);
+			goto retry;
+		}
 		goto stop;
+	}
 
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type, force);
 	if (gc_type == FG_GC &&
@@ -1811,6 +1858,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
 	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = init_segno;
 
+	if (gc_type == FG_GC && pinned_section_exists(DIRTY_I(sbi)))
+		unpin_all_sections(sbi);
+
 	trace_f2fs_gc_end(sbi->sb, ret, total_freed, sec_freed,
 				get_pages(sbi, F2FS_DIRTY_NODES),
 				get_pages(sbi, F2FS_DIRTY_DENTS),
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 012524db7437..1c20d7c9eca3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4736,6 +4736,12 @@ static int init_victim_secmap(struct f2fs_sb_info *sbi)
 	dirty_i->victim_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
 	if (!dirty_i->victim_secmap)
 		return -ENOMEM;
+
+	dirty_i->pinned_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
+	if (!dirty_i->pinned_secmap)
+		return -ENOMEM;
+
+	dirty_i->pinned_secmap_cnt = 0;
 	return 0;
 }
 
@@ -5324,6 +5330,7 @@ static void destroy_victim_secmap(struct f2fs_sb_info *sbi)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 
+	kvfree(dirty_i->pinned_secmap);
 	kvfree(dirty_i->victim_secmap);
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5c94caf0c0a1..fd6f246e649c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -294,6 +294,8 @@ struct dirty_seglist_info {
 	struct mutex seglist_lock;		/* lock for segment bitmaps */
 	int nr_dirty[NR_DIRTY_TYPE];		/* # of dirty segments */
 	unsigned long *victim_secmap;		/* background GC victims */
+	unsigned long *pinned_secmap;		/* pinned victims from foreground GC */
+	unsigned int pinned_secmap_cnt;		/* count of victims which has pinned data */
 };
 
 /* victim selection function for cleaning and SSR */
-- 
2.32.0

