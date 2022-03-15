Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AD04D9C38
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348661AbiCON37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348657AbiCON3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:29:55 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4071C46B22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:28:40 -0700 (PDT)
Received: from localhost.localdomain ([10.11.68.233])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 22FDSG1u003439-22FDSG1x003439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 15 Mar 2022 21:28:20 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: erofs: add sanity check for kobject in erofs_unregister_sysfs
Date:   Tue, 15 Mar 2022 21:28:14 +0800
Message-Id: <20220315132814.12332-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
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

Fix this by adding sanity check for kobject in erofs_unregister_sysfs

Note that I've tested the patch and the crash does not occur any more.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/erofs/sysfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dac252bc9228..f3babf1e6608 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -221,9 +221,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
+	if (sbi->s_kobj.state_in_sysfs) {
+		kobject_del(&sbi->s_kobj);
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
+	}
 }
 
 int __init erofs_init_sysfs(void)
-- 
2.25.1

