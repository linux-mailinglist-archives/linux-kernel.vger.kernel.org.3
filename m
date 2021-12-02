Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6DD465EC4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355854AbhLBHiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:38:15 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28144 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbhLBHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:38:10 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J4SMS0cxQz1DJqJ;
        Thu,  2 Dec 2021 15:32:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 15:34:46 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next] selinux: Use struct_size() helper in kmalloc()
Date:   Thu, 2 Dec 2021 15:35:33 +0800
Message-ID: <20211202073533.104072-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of struct_size() helper instead of an open-coded calculation.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/ss/sidtab.c | 2 +-
 security/selinux/xfrm.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 656d50b09f76..293ec048af08 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -570,7 +570,7 @@ void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
 		goto out_unlock;
 	}
 
-	cache = kmalloc(sizeof(struct sidtab_str_cache) + str_len, GFP_ATOMIC);
+	cache = kmalloc(struct_size(cache, str, str_len), GFP_ATOMIC);
 	if (!cache)
 		goto out_unlock;
 
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index be83e5ce4469..90697317895f 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -89,7 +89,7 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 	if (str_len >= PAGE_SIZE)
 		return -ENOMEM;
 
-	ctx = kmalloc(sizeof(*ctx) + str_len + 1, gfp);
+	ctx = kmalloc(struct_size(ctx, ctx_str, str_len + 1), gfp);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -360,7 +360,7 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	if (rc)
 		return rc;
 
-	ctx = kmalloc(sizeof(*ctx) + str_len, GFP_ATOMIC);
+	ctx = kmalloc(struct_size(ctx, ctx_str, str_len), GFP_ATOMIC);
 	if (!ctx) {
 		rc = -ENOMEM;
 		goto out;
-- 
2.17.1

