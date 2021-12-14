Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BAF4741C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhLNLsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:48:04 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28315 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhLNLsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:01 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JCxSt3tTGzbjRL;
        Tue, 14 Dec 2021 19:47:42 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 19:47:59 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>, <keescook@chromium.org>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>, <linux-hardening@vger.kernel.org>
Subject: [PATCH -next] audit: use struct_size() helper in kmalloc()
Date:   Tue, 14 Dec 2021 19:48:54 +0800
Message-ID: <20211214114854.133328-1-xiujianfeng@huawei.com>
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

Make use of struct_size() helper instead of an open-coded calucation.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/audit.c       | 2 +-
 kernel/audit_tree.c  | 2 +-
 kernel/auditfilter.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index d4084751cfe6..f33028578c60 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1446,7 +1446,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 			if (err)
 				return err;
 		}
-		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
+		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
 		if (!sig_data) {
 			if (audit_sig_sid)
 				security_release_secctx(ctx, len);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 72324afcffef..e7315d487163 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -94,7 +94,7 @@ static struct audit_tree *alloc_tree(const char *s)
 {
 	struct audit_tree *tree;
 
-	tree = kmalloc(sizeof(struct audit_tree) + strlen(s) + 1, GFP_KERNEL);
+	tree = kmalloc(struct_size(tree, pathname, strlen(s) + 1), GFP_KERNEL);
 	if (tree) {
 		refcount_set(&tree->count, 1);
 		tree->goner = 0;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 4173e771650c..19352820b274 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -637,7 +637,7 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
 	void *bufp;
 	int i;
 
-	data = kmalloc(sizeof(*data) + krule->buflen, GFP_KERNEL);
+	data = kmalloc(struct_size(data, buf, krule->buflen), GFP_KERNEL);
 	if (unlikely(!data))
 		return NULL;
 	memset(data, 0, sizeof(*data));
-- 
2.17.1

