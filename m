Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB24653AF8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiFAVOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFAVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:14:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E66633B9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:14:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6827EB81C38
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E3DC385B8;
        Wed,  1 Jun 2022 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654118069;
        bh=YS5IOiL9dBi2zEpaewYYTodWjSpqUzZtFaSZlv5Z/II=;
        h=From:To:Cc:Subject:Date:From;
        b=WRNSXd37nZ9tk86Gt+WreCXc4zZmfI3kf/OQ/NYetdgAL8OEIlpvS29IXI0OWjNxl
         rlw8nDuBknvhcmezjQjF64NEMfgY4SAPntcYEvjylKdIe3Sv6ZcgG4ngTQHJmV8bp5
         ECqMhRz10pP7y5ftF2Q5SDqOXzpHZ4zW2K8PrwJxLMRHpxNko24NLkfzRxavRtIhsg
         57Rwfe4uvAzYMubjtb2EFxx+v3jgTnl0KxE2TaZfku5ibxG6Cp0EVygyPFRrRF5Wgz
         pZyfjbFnH+B64Vwdhhf1h72NrhlmxXi+jeHboHrA7SW45H4DynjcAn96gldGFCHL8D
         zIOsixA8i9qpA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: attach inline_data after setting compression
Date:   Wed,  1 Jun 2022 14:14:27 -0700
Message-Id: <20220601211427.2345120-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
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

This fixes the below corruption.

[345393.335389] F2FS-fs (vdb): sanity_check_inode: inode (ino=6d0, mode=33206) should not have inline_data, run fsck to fix

Fixes: 677a82b44ebf ("f2fs: fix to do sanity check for inline inode")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c549acb52ac4..a841abe6a071 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -89,8 +89,6 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 	if (test_opt(sbi, INLINE_XATTR))
 		set_inode_flag(inode, FI_INLINE_XATTR);
 
-	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
-		set_inode_flag(inode, FI_INLINE_DATA);
 	if (f2fs_may_inline_dentry(inode))
 		set_inode_flag(inode, FI_INLINE_DENTRY);
 
@@ -107,10 +105,6 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 
 	f2fs_init_extent_tree(inode, NULL);
 
-	stat_inc_inline_xattr(inode);
-	stat_inc_inline_inode(inode);
-	stat_inc_inline_dir(inode);
-
 	F2FS_I(inode)->i_flags =
 		f2fs_mask_flags(mode, F2FS_I(dir)->i_flags & F2FS_FL_INHERITED);
 
@@ -127,6 +121,14 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 			set_compress_context(inode);
 	}
 
+	/* Should enable inline_data after compression set */
+	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
+		set_inode_flag(inode, FI_INLINE_DATA);
+
+	stat_inc_inline_xattr(inode);
+	stat_inc_inline_inode(inode);
+	stat_inc_inline_dir(inode);
+
 	f2fs_set_inode_flags(inode);
 
 	trace_f2fs_new_inode(inode, 0);
@@ -325,6 +327,8 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (!is_extension_exist(name, ext[i], false))
 			continue;
 
+		/* Do not use inline_data with compression */
+		clear_inode_flag(inode, FI_INLINE_DATA);
 		set_compress_context(inode);
 		return;
 	}
-- 
2.36.1.255.ge46751e96f-goog

