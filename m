Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0807559E435
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbiHWMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241529AbiHWMqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:46:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D929D8CD
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCB89B81C29
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB3CC433C1;
        Tue, 23 Aug 2022 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661248431;
        bh=Q5FEnebqitjiFea4DJafW7oybDFur+9NDnzsl+DMiHk=;
        h=From:To:Cc:Subject:Date:From;
        b=cydQGhX2IUbSZYu1cl7DoVMMqZ1FJcefxzn+x7FoMB12ErNrwU5STC1eR1t0oaFPt
         zLvgDlHO/JCzUwufwHkULnGbWxTxlNy0E2+s/KHzkgPuRCftqXz+M5xYJBr/6M6Mh6
         kQ6HNLH7XfoHB3aPrUfYN0G6pxHB+Hh5KmweXVEo7v0sk05lh+8zIvxsXYtiGwnZzC
         OVlx6KjKpN9yopLER+FhOKnTn9+/4D4ERyXxD8+vIdobobhiNOzazah7gvqwUplwnR
         2WDyFNsEY7W0kM6FsxSV2k7JKxekWgCw3oIPVRlhz9zpze7rJ5qQTObFtr738c/RT6
         yDhTXblnLbRmQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v2] binderfs: rework superblock destruction
Date:   Tue, 23 Aug 2022 11:53:39 +0200
Message-Id: <20220823095339.853371-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=brauner@kernel.org; h=from:subject; bh=2fbddUWii2vIogxqCBndRUeMJ0elbAaMYulczrf2jOY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSzLJ6k+8fEN1FLU2vPlswFL2uEtquq/ra9OeOFGUdA17LP l3pFOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiGcXI0FwQ8DBFXXHBLgXr/FCupv aFnJOLAyN1T8W3Ta7fWHyWkZFhUdyJVxv21QlrdWZu49gS1xj0NOLuuo7rx4TtpOcrChzmBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

From: Al Viro <viro@zeniv.linux.org.uk>

So far we relied on
.put_super = binderfs_put_super()
to destroy info we stashed in sb->s_fs_info. This gave us the required ordering
between ->evict_inode() and sb->s_fs_info destruction.

But the current implementation of binderfs_fill_super() has a memory leak in
the rare circumstance that d_make_root() fails because ->put_super() is only
called when sb->s_root is initialized. Fix this by removing ->put_super() and
simply do all that work in binderfs_kill_super().

Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 drivers/android/binderfs.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 588d753a7a19..927776fdeb1a 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -340,22 +340,10 @@ static int binderfs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static void binderfs_put_super(struct super_block *sb)
-{
-	struct binderfs_info *info = sb->s_fs_info;
-
-	if (info && info->ipc_ns)
-		put_ipc_ns(info->ipc_ns);
-
-	kfree(info);
-	sb->s_fs_info = NULL;
-}
-
 static const struct super_operations binderfs_super_ops = {
 	.evict_inode    = binderfs_evict_inode,
 	.show_options	= binderfs_show_options,
 	.statfs         = simple_statfs,
-	.put_super	= binderfs_put_super,
 };
 
 static inline bool is_binderfs_control_device(const struct dentry *dentry)
@@ -785,11 +773,27 @@ static int binderfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void binderfs_kill_super(struct super_block *sb)
+{
+	struct binderfs_info *info = sb->s_fs_info;
+
+	/*
+	 * During inode eviction struct binderfs_info is needed.
+	 * So first wipe the super_block then free struct binderfs_info.
+	 */
+	kill_litter_super(sb);
+
+	if (info && info->ipc_ns)
+		put_ipc_ns(info->ipc_ns);
+
+	kfree(info);
+}
+
 static struct file_system_type binder_fs_type = {
 	.name			= "binder",
 	.init_fs_context	= binderfs_init_fs_context,
 	.parameters		= binderfs_fs_parameters,
-	.kill_sb		= kill_litter_super,
+	.kill_sb		= binderfs_kill_super,
 	.fs_flags		= FS_USERNS_MOUNT,
 };
 

base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
-- 
2.34.1

