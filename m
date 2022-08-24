Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936455A026B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbiHXUDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiHXUC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBA07C1F9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:02:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49E56617E0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 20:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92128C433C1;
        Wed, 24 Aug 2022 20:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661371376;
        bh=unxW9Qi6JH0z2onbNULdSwd+TxNQ1BVAlQ1Duh4IOWs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=HgiJBW6GKNHD5d08CRjJ349ggpAY8WPUFTeIXQ6qNaH1Gr3Agc+CVX/L9AXWiwtF2
         OPjevjrvmjoDpYyhmyqZAAPKj6q/Sl553GUHwsfR5CfYDnD1f1T78cIBs7I62UPE8v
         CRvWqKnojLzIZy9PT+89ErltIvfwmZAnabF/zHg8DgfjBlx6g9ZaLWsKRaysDrzBjG
         HK3ZWhE/LkNfdCa+vrTsu3VXoF7t72RC2AYzlshvs5aUHdXn4z+hYG8aamI/w65cFf
         CoCbm4wCr8xsN8dwjlmWk3EdgDnvGS/BvEo/rd1SHCJaXfz/zPxOHFsDF2xav0vTMj
         1lokFcnkEp90w==
Date:   Wed, 24 Aug 2022 13:02:54 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] f2fs: flush pending checkpoints when freezing super
Message-ID: <YwaD7mJpMLhEm5wd@google.com>
References: <20220819231514.3609958-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819231514.3609958-1-jaegeuk@kernel.org>
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

 Change log from v1:
  - do not check cprc->f2fs_issue_ckpt in f2fs_flush_ckpt_thread

 fs/f2fs/checkpoint.c | 24 ++++++++++++++++++------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/super.c      |  5 ++---
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7de48e791920..7bf1feb5ac78 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1893,15 +1893,27 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi)
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
+	flush_remained_ckpt_reqs(sbi, NULL);
+
+	/* Let's wait for the previous dispatched checkpoint. */
+	while (atomic_read(&cprc->queued_ckpt))
+		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 }
 
 void f2fs_init_ckpt_req_control(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6770210aae70..088c3d1574b8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3711,6 +3711,7 @@ static inline bool f2fs_need_rand_seg(struct f2fs_sb_info *sbi)
  * checkpoint.c
  */
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
+void f2fs_flush_ckpt_thread(struct f2fs_sb_info *sbi);
 struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *f2fs_get_meta_page_retry(struct f2fs_sb_info *sbi, pgoff_t index);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e910f0e39d76..4f2ff50b247c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1671,9 +1671,8 @@ static int f2fs_freeze(struct super_block *sb)
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

