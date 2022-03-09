Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B654D3C58
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiCIVtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiCIVti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:49:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E862650042
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:48:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A60E0B82165
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48706C340EE;
        Wed,  9 Mar 2022 21:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646862516;
        bh=JG1VmYVLKB8YkFi9TpzVjvEM9eVANxrBU35l07oWWWU=;
        h=From:To:Cc:Subject:Date:From;
        b=mSGMX9y9zsbr0yFRYmEmhJRRyeKQU3BlErfS7erzYwLvQ2G99Zs9pjyskin8Bhkza
         aPjWW6DuU3toquxj6Nj+HPtmhyHB+U5zzOMxHYgBrfPjsgQjqQDxyO6KuIwqdkTj+l
         vz7JQpa/ohSmRdHDD5Fl7ODE4suA+pDYOstMOeGHCScrYslY2LxsOgbIq5qvzQc07n
         gWaEITB/vJnQ0TFnGm2Ojbzx/C+68eDgW9XubpW27AF4K38cwDIqazjF6Kc9bD4NKw
         lSGzgr0OqqGDmS5fVJ9jtZZLGMkMgM3FchHZR9URFqRwiZ9IbmsSgoW99eTpCC6oYa
         DOEyvkFZe7Exw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: evict inode cache for frozen fs
Date:   Wed,  9 Mar 2022 13:48:33 -0800
Message-Id: <20220309214834.3408741-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
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

Let's purge inode cache in order to avoid the below deadlock.

[freeze test]                         shrinkder
freeze_super
 - pwercpu_down_write(SB_FREEZE_FS)
                                       - super_cache_scan
                                         - down_read(&sb->s_umount)
                                           - prune_icache_sb
                                            - dispose_list
                                             - evict
                                              - f2fs_evict_inode
thaw_super
 - down_write(&sb->s_umount);
                                              - __percpu_down_read(SB_FREEZE_FS)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 1 +
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/inode.c | 6 ++++--
 fs/f2fs/super.c | 4 ++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 9a13902c7702..cba5eab24595 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -338,6 +338,7 @@ static char *s_flag[] = {
 	[SBI_QUOTA_SKIP_FLUSH]	= " quota_skip_flush",
 	[SBI_QUOTA_NEED_REPAIR]	= " quota_need_repair",
 	[SBI_IS_RESIZEFS]	= " resizefs",
+	[SBI_IS_FREEZING]	= " freezefs",
 };
 
 static int stat_show(struct seq_file *s, void *v)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 68d791ec8b27..da729f53daa8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1293,6 +1293,7 @@ enum {
 	SBI_QUOTA_SKIP_FLUSH,			/* skip flushing quota in current CP */
 	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
 	SBI_IS_RESIZEFS,			/* resizefs is in process */
+	SBI_IS_FREEZING,			/* freezefs is in process */
 };
 
 enum {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ab8e0c06c78c..71f232dcf3c2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -778,7 +778,8 @@ void f2fs_evict_inode(struct inode *inode)
 	f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 	f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
 
-	sb_start_intwrite(inode->i_sb);
+	if (!is_sbi_flag_set(sbi, SBI_IS_FREEZING))
+		sb_start_intwrite(inode->i_sb);
 	set_inode_flag(inode, FI_NO_ALLOC);
 	i_size_write(inode, 0);
 retry:
@@ -809,7 +810,8 @@ void f2fs_evict_inode(struct inode *inode)
 		if (dquot_initialize_needed(inode))
 			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
 	}
-	sb_end_intwrite(inode->i_sb);
+	if (!is_sbi_flag_set(sbi, SBI_IS_FREEZING))
+		sb_end_intwrite(inode->i_sb);
 no_delete:
 	dquot_drop(inode);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8e3840973077..4b570b5c2674 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1663,11 +1663,15 @@ static int f2fs_freeze(struct super_block *sb)
 	/* ensure no checkpoint required */
 	if (!llist_empty(&F2FS_SB(sb)->cprc_info.issue_list))
 		return -EINVAL;
+
+	/* to avoid deadlock on f2fs_evict_inode->SB_FREEZE_FS */
+	set_sbi_flag(F2FS_SB(sb), SBI_IS_FREEZING);
 	return 0;
 }
 
 static int f2fs_unfreeze(struct super_block *sb)
 {
+	clear_sbi_flag(F2FS_SB(sb), SBI_IS_FREEZING);
 	return 0;
 }
 
-- 
2.35.1.616.g0bdcbb4464-goog

