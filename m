Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96E54F491
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381402AbiFQJqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiFQJqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:46:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD4B692A1;
        Fri, 17 Jun 2022 02:46:16 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LPYz23g2bz1K9tp;
        Fri, 17 Jun 2022 17:44:14 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 17:46:14 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND -next] selinux: Let the caller free the momory in *mnt_opts on error
Date:   Fri, 17 Jun 2022 17:44:12 +0800
Message-ID: <20220617094412.197479-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may allocate memory for @mnt_opts if NULL in selinux_add_opt(), and
now some error paths goto @err label to free memory while others don't,
as suggested by Paul, don't free memory in case of error and let the
caller to cleanup on error.

And also this patch changes the @s NULL check to return -EINVAL instead.

Link: https://lore.kernel.org/lkml/20220611090550.135674-1-xiujianfeng@huawei.com/T/
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/hooks.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4d20a139a86d..9d08b91e05a2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -944,10 +944,12 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 	return rc;
 }
 
+/*
+ * NOTE: the caller is resposible for freeing the memory even if on error.
+ */
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
 	struct selinux_mnt_opts *opts = *mnt_opts;
-	bool is_alloc_opts = false;
 	u32 *dst_sid;
 	int rc;
 
@@ -955,7 +957,7 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		/* eaten and completely ignored */
 		return 0;
 	if (!s)
-		return -ENOMEM;
+		return -EINVAL;
 
 	if (!selinux_initialized(&selinux_state)) {
 		pr_warn("SELinux: Unable to set superblock options before the security server is initialized\n");
@@ -967,7 +969,6 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		if (!opts)
 			return -ENOMEM;
 		*mnt_opts = opts;
-		is_alloc_opts = true;
 	}
 
 	switch (token) {
@@ -1002,10 +1003,6 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	return rc;
 
 err:
-	if (is_alloc_opts) {
-		kfree(opts);
-		*mnt_opts = NULL;
-	}
 	pr_warn(SEL_MOUNT_FAIL_MSG);
 	return -EINVAL;
 }
-- 
2.17.1

