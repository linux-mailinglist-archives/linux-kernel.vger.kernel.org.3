Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DDC596F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiHQND3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbiHQNDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:03:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CE662D7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:03:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3958A61226
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712DBC433D6;
        Wed, 17 Aug 2022 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660741402;
        bh=hlVKZun9cQgqvk+9guDZaGwV1q58FIbRR4S1l1VS52s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyKihM4zLu/rghvBYhUFYWY9+ktGi3BmlWRBy/ioXsn4bDtFZhGfyDkoHtXCxVrmS
         YVMkFNRUAz97/TFFdCTpP4te37FWkcIQLK85ic4aeLhal/oMpV1CHlhxUkaALUX5C5
         Ezwaebr19WeaCStw8ZAXTDNz3QCG/x26PpmDhM2JojwiZpmeY6oSpBLKMybBgXtYs9
         dKrNm3OdSHmvt9szCPC+iqjmCWb4CRDDB/6QB3bvJE3nNkDJ1CTnwCyb4QmSSViZcj
         a3J7LOn+PyKJ/4ILT9URzPmtT3Fa7kqPa9K15Q4DsM5CGM+cDlClZcRHa3a2Is8zEV
         KFO3PssOalYYQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] binderfs: rework superblock destruction
Date:   Wed, 17 Aug 2022 15:03:06 +0200
Message-Id: <20220817130306.96978-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YvzUS/7bd1mm6c/V@kroah.com>
References: 
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

From: Al Viro <viro@zeniv.linux.org.uk>

So far we relied on
.put_super = binderfs_put_super()
to destroy info we stashed in sb->s_fs_info. But the current implementation of
binderfs_fill_super() leads to a memory leak in the rare circumstance that
d_make_root() fails because ->put_super() is only called when sb->s_root is
initialized. Fix this by removing ->put_super() and simply do all that work in
binderfs_kill_super().

Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
I should note that I didn't have time to test this.
---
 drivers/android/binderfs.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 588d753a7a19..6d896f75aab6 100644
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
@@ -785,11 +773,22 @@ static int binderfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void binderfs_kill_super(struct super_block *sb)
+{
+	struct binderfs_info *info = sb->s_fs_info;
+
+	if (info && info->ipc_ns)
+		put_ipc_ns(info->ipc_ns);
+
+	kfree(info);
+	kill_litter_super(sb);
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
 
-- 
2.34.1

