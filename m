Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9267359114C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbiHLNXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLNX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:23:29 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0165390C68
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:23:26 -0700 (PDT)
Received: from localhost.localdomain ([222.20.126.44])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 27CDLQdu023627-27CDLQdx023627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 12 Aug 2022 21:21:32 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
Date:   Fri, 12 Aug 2022 21:21:24 +0800
Message-Id: <20220812132124.2053673-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

In binderfs_fill_super, if s_root is not successfully initialized by
d_make_root, the previous allocated s_sb_info will not be freed since
generic_shutdown_super first checks if sb->s_root and then does
put_super operation. The put_super operation calls binderfs_put_super
to deallocate s_sb_info and put ipc_ns. This will lead to memory leak
in binderfs_fill_super.

Fix this by invoking binderfs_put_super at error sites before s_root
is successfully initialized.

Fixes: 095cf502b31e ("binderfs: port to new mount api")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/android/binderfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 588d753a7a19..20f5bc77495f 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -710,8 +710,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	info->mount_opts.stats_mode = ctx->stats_mode;
 
 	inode = new_inode(sb);
-	if (!inode)
+	if (!inode) {
+		binderfs_put_super(sb);
 		return -ENOMEM;
+	}
 
 	inode->i_ino = FIRST_INODE;
 	inode->i_fop = &simple_dir_operations;
@@ -721,8 +723,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	set_nlink(inode, 2);
 
 	sb->s_root = d_make_root(inode);
-	if (!sb->s_root)
+	if (!sb->s_root) {
+		binderfs_put_super(sb);
 		return -ENOMEM;
+	}
 
 	ret = binderfs_binder_ctl_create(sb);
 	if (ret)
-- 
2.25.1

