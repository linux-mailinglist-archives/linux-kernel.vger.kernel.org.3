Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F165459A949
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244004AbiHSXPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244132AbiHSXPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:15:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F83D10A773
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E682B82995
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA119C433C1;
        Fri, 19 Aug 2022 23:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660950917;
        bh=xfanyvshwE1RaGKDX1ptGODAoLpIUb8GI1syiWM0c4U=;
        h=From:To:Cc:Subject:Date:From;
        b=aMDxQNH9Y7ngPtlVngBTudaEvxLIRPP+CMTFFzFK+2aY/rDW0sZ2dYigfUU5VxvxN
         CjZD53qHKm/h9bxG3Jg6hF42Ce89hJHDvH2Xhy0fvV6jXzgugc1yCzca8KYFZb0BI7
         hofEvc491FN7lGKD0r/Olrd7kijirMWK1280KF7yP2eNuSBanJ6n9NrE2wtx4uJ7jS
         +yQz2wVKXqULJ0hlo3itVgA77ioJW7r+4RsbjY+n4lbQh9KSYgeB0EnZwlMKLRn1qJ
         2deN+l1IBw8WYvHUcOy0zmjR1eaSr9J64syK4mvO5cUc0urxFTsy8wpRgZ6VKVnXaz
         +CV1xwkugftmQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: flush pending checkpoints when freezing super
Date:   Fri, 19 Aug 2022 16:15:13 -0700
Message-Id: <20220819231514.3609958-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
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

This avoids -EINVAL when trying to freeze f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 27 +++++++++++++++++++++------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/super.c      |  5 ++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8259e0fa97e1..37f7a9ea4746 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1892,15 +1892,30 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi)
 void f2fs_stop_ckpt_thread(struct f2fs_sb_info *sbi)
 {
 	struct ckpt_req_control *cprc = &sbi->cprc_info;
+	struct task_struct *ckpt_task;
 
-	if (cprc->f2fs_issue_ckpt) {
-		struct task_struct *ckpt_task = cprc->f2fs_issue_ckpt;
+	if (!cprc->f2fs_issue_ckpt)
+		return;
 
-		cprc->f2fs_issue_ckpt = NULL;
-		kthread_stop(ckpt_task);
+	ckpt_task = cprc->f2fs_issue_ckpt;
+	cprc->f2fs_issue_ckpt = NULL;
+	kthread_stop(ckpt_task);
 
-		flush_remained_ckpt_reqs(sbi, NULL);
-	}
+	f2fs_flush_ckpt_thread(sbi);
+}
+
+void f2fs_flush_ckpt_thread(struct f2fs_sb_info *sbi)
+{
+	struct ckpt_req_control *cprc = &sbi->cprc_info;
+
+	if (!cprc->f2fs_issue_ckpt)
+		return;
+
+	flush_remained_ckpt_reqs(sbi, NULL);
+
+	/* Let's wait for the previous dispatched checkpoint. */
+	while (atomic_read(&cprc->queued_ckpt))
+		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 }
 
 void f2fs_init_ckpt_req_control(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3c7cdb70fe2e..2a83fc34b372 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3707,6 +3707,7 @@ static inline bool f2fs_need_rand_seg(struct f2fs_sb_info *sbi)
  * checkpoint.c
  */
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
+void f2fs_flush_ckpt_thread(struct f2fs_sb_info *sbi);
 struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *f2fs_get_meta_page_retry(struct f2fs_sb_info *sbi, pgoff_t index);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 212ec2b4926b..48ac3de4a533 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1670,9 +1670,8 @@ static int f2fs_freeze(struct super_block *sb)
 	if (is_sbi_flag_set(F2FS_SB(sb), SBI_IS_DIRTY))
 		return -EINVAL;
 
-	/* ensure no checkpoint required */
-	if (!llist_empty(&F2FS_SB(sb)->cprc_info.issue_list))
-		return -EINVAL;
+	/* Let's flush checkpoints and stop the thread. */
+	f2fs_flush_ckpt_thread(F2FS_SB(sb));
 
 	/* to avoid deadlock on f2fs_evict_inode->SB_FREEZE_FS */
 	set_sbi_flag(F2FS_SB(sb), SBI_IS_FREEZING);
-- 
2.37.1.595.g718a3a8f04-goog

