Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA424D95A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345683AbiCOHxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbiCOHxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:53:43 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA84BB9A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:52:29 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 22F7pr4U009621-22F7pr4X009621
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 15 Mar 2022 15:51:58 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: erofs: remember if kobject_init_and_add was done
Date:   Tue, 15 Mar 2022 15:51:52 +0800
Message-Id: <20220315075152.63789-1-dzm91@hust.edu.cn>
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

Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
is triggered by injecting fault in kobject_init_and_add of
erofs_unregister_sysfs.

Fix this by remembering if kobject_init_and_add is successful.

Note that I've tested the patch and the crash does not occur any more.

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/erofs/internal.h | 1 +
 fs/erofs/sysfs.c    | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5aa2cf2c2f80..9e20665e3f68 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -144,6 +144,7 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 
 	/* sysfs support */
+	bool s_sysfs_inited;
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
 	struct completion s_kobj_unregister;
 };
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dac252bc9228..2b48a4df19b4 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
 				   "%s", sb->s_id);
 	if (err)
 		goto put_sb_kobj;
+	sbi->s_sysfs_inited = true;
 	return 0;
 
 put_sb_kobj:
@@ -221,9 +222,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
+	if (sbi->s_sysfs_inited) {
+		kobject_del(&sbi->s_kobj);
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
+	}
 }
 
 int __init erofs_init_sysfs(void)
-- 
2.25.1

