Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F243D4FF09E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiDMHhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiDMHhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:37:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910E14CD6B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:34:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B8DFB8213D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40746C385A4;
        Wed, 13 Apr 2022 07:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649835284;
        bh=JfKQqUtSRO+n6Mg/TdQQXoXDb3x9otKPEADPuS48Q9E=;
        h=From:To:Cc:Subject:Date:From;
        b=WxIUJY1IyYpjBmBGKI4lf3FFiHg36Hua/HbjwvJIIJIICkCg7/CdRudCJEcz+QR64
         x97ixjiiMOhKy6cjtTnAxyEPTgE4ONIEZzl7/Z5Qua+VzJHHqSijn/tazbVtHhvkeQ
         f/Y7xOvYe0V8ZXU/GtLkQob3cGhtCnJ1GJVpHNSW7UHUB1v76O4Apy2QBkVSu8wb1f
         zFvr1wuagVY4qQTEEaJXSzjGJ63iP2s/hXo4K+Kikxp0c3B2DmzwEWUWaZ1jX4VMR9
         ipJa7x0zwe+XB3ouL8AqpWmvZHjSBEco5PvtwgBTH9YOQ4sQva+OAEG2Y3jp/VDLMH
         352k61dPl1Caw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH v5] f2fs: give priority to select unpinned section for foreground GC
Date:   Wed, 13 Apr 2022 15:34:38 +0800
Message-Id: <20220413073438.18874-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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
v5:
- clean up codes
 fs/f2fs/gc.c      | 83 +++++++++++++++++++++++++++++++++++++++--------
 fs/f2fs/segment.c |  8 +++++
 fs/f2fs/segment.h |  3 ++
 3 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6a7e4148ff9d..0b3325fe4ffd 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -646,6 +646,51 @@ static void release_victim_entry(struct f2fs_sb_info *sbi)
 	f2fs_bug_on(sbi, !list_empty(&am->victim_list));
 }
 
+static bool f2fs_pin_section(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+
+	if (!dirty_i->enable_pin_section)
+		return false;
+	if (!test_and_set_bit(secno, dirty_i->pinned_secmap))
+		dirty_i->pinned_secmap_cnt++;
+	return true;
+}
+
+static bool f2fs_pinned_section_exists(struct dirty_seglist_info *dirty_i)
+{
+	return dirty_i->enable_pin_section && dirty_i->pinned_secmap_cnt;
+}
+
+static bool f2fs_section_is_pinned(struct dirty_seglist_info *dirty_i,
+						unsigned int secno)
+{
+	return f2fs_pinned_section_exists(dirty_i) &&
+			test_bit(secno, dirty_i->pinned_secmap);
+}
+
+static void f2fs_unpin_all_sections(struct f2fs_sb_info *sbi, bool enable)
+{
+	unsigned int bitmap_size = f2fs_bitmap_size(MAIN_SECS(sbi));
+
+	memset(DIRTY_I(sbi)->pinned_secmap, 0, bitmap_size);
+	DIRTY_I(sbi)->pinned_secmap_cnt = 0;
+	DIRTY_I(sbi)->enable_pin_section = enable;
+}
+
+static bool f2fs_gc_pinned_control(struct inode *inode, int gc_type,
+							unsigned int segno)
+{
+	if (!f2fs_is_pinned_file(inode))
+		return 0;
+	if (gc_type != FG_GC)
+		return -EBUSY;
+	if (!f2fs_pin_section(F2FS_I_SB(inode), segno))
+		f2fs_pin_file_control(inode, true);
+	return -EAGAIN;
+}
+
 /*
  * This function is called from two paths.
  * One is garbage collection and the other is SSR segment selection.
@@ -787,6 +832,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
 			goto next;
 
+		if (gc_type == FG_GC && f2fs_section_is_pinned(dirty_i, secno))
+			goto next;
+
 		if (is_atgc) {
 			add_victim_entry(sbi, &p, segno);
 			goto next;
@@ -1201,12 +1249,9 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		goto out;
 	}
 
-	if (f2fs_is_pinned_file(inode)) {
-		if (gc_type == FG_GC)
-			f2fs_pin_file_control(inode, true);
-		err = -EAGAIN;
+	err = f2fs_gc_pinned_control(inode, gc_type, segno);
+	if (err)
 		goto out;
-	}
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = f2fs_get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
@@ -1351,12 +1396,10 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		err = -EAGAIN;
 		goto out;
 	}
-	if (f2fs_is_pinned_file(inode)) {
-		if (gc_type == FG_GC)
-			f2fs_pin_file_control(inode, true);
-		err = -EAGAIN;
+
+	err = f2fs_gc_pinned_control(inode, gc_type, segno);
+	if (err)
 		goto out;
-	}
 
 	if (gc_type == BG_GC) {
 		if (PageWriteback(page)) {
@@ -1476,14 +1519,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		ofs_in_node = le16_to_cpu(entry->ofs_in_node);
 
 		if (phase == 3) {
+			int err;
+
 			inode = f2fs_iget(sb, dni.ino);
 			if (IS_ERR(inode) || is_bad_inode(inode) ||
 					special_file(inode->i_mode))
 				continue;
 
-			if (is_inode_flag_set(inode, FI_PIN_FILE) &&
-							gc_type == FG_GC) {
-				f2fs_pin_file_control(inode, true);
+			err = f2fs_gc_pinned_control(inode, gc_type, segno);
+			if (err == -EAGAIN) {
 				iput(inode);
 				return submitted;
 			}
@@ -1766,9 +1810,17 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		ret = -EINVAL;
 		goto stop;
 	}
+retry:
 	ret = __get_victim(sbi, &segno, gc_type);
-	if (ret)
+	if (ret) {
+		/* allow to search victim from sections has pinned data */
+		if (ret == -ENODATA && gc_type == FG_GC &&
+				f2fs_pinned_section_exists(DIRTY_I(sbi))) {
+			f2fs_unpin_all_sections(sbi, false);
+			goto retry;
+		}
 		goto stop;
+	}
 
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type, force);
 	if (gc_type == FG_GC &&
@@ -1811,6 +1863,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
 	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = init_segno;
 
+	if (gc_type == FG_GC && f2fs_pinned_section_exists(DIRTY_I(sbi)))
+		f2fs_unpin_all_sections(sbi, true);
+
 	trace_f2fs_gc_end(sbi->sb, ret, total_freed, sec_freed,
 				get_pages(sbi, F2FS_DIRTY_NODES),
 				get_pages(sbi, F2FS_DIRTY_DENTS),
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 22dfeb991529..93c7bae57a25 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4734,6 +4734,13 @@ static int init_victim_secmap(struct f2fs_sb_info *sbi)
 	dirty_i->victim_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
 	if (!dirty_i->victim_secmap)
 		return -ENOMEM;
+
+	dirty_i->pinned_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
+	if (!dirty_i->pinned_secmap)
+		return -ENOMEM;
+
+	dirty_i->pinned_secmap_cnt = 0;
+	dirty_i->enable_pin_section = true;
 	return 0;
 }
 
@@ -5322,6 +5329,7 @@ static void destroy_victim_secmap(struct f2fs_sb_info *sbi)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 
+	kvfree(dirty_i->pinned_secmap);
 	kvfree(dirty_i->victim_secmap);
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5c94caf0c0a1..8a591455d796 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -294,6 +294,9 @@ struct dirty_seglist_info {
 	struct mutex seglist_lock;		/* lock for segment bitmaps */
 	int nr_dirty[NR_DIRTY_TYPE];		/* # of dirty segments */
 	unsigned long *victim_secmap;		/* background GC victims */
+	unsigned long *pinned_secmap;		/* pinned victims from foreground GC */
+	unsigned int pinned_secmap_cnt;		/* count of victims which has pinned data */
+	bool enable_pin_section;		/* enable pinning section */
 };
 
 /* victim selection function for cleaning and SSR */
-- 
2.25.1

