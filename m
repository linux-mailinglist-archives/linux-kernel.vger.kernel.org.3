Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF947512A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbhLODD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:03:26 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29193 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhLODDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:03:24 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JDKkt2r4yz8vth;
        Wed, 15 Dec 2021 11:01:10 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 11:03:23 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>,
        <keescook@chromium.org>, <gustavoars@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH -next, v2] audit: use struct_size() helper in kmalloc()
Date:   Wed, 15 Dec 2021 11:04:20 +0800
Message-ID: <20211215030420.72324-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of struct_size() helper instead of an open-coded calculation.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/uapi/linux/audit.h | 2 +-
 kernel/audit.c             | 4 ++--
 kernel/audit_tree.c        | 2 +-
 kernel/auditfilter.c       | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 9176a095fefc..8eda133ca4c1 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -514,7 +514,7 @@ struct audit_rule_data {
 	__u32		values[AUDIT_MAX_FIELDS];
 	__u32		fieldflags[AUDIT_MAX_FIELDS];
 	__u32		buflen;	/* total length of string fields */
-	char		buf[0];	/* string fields buffer */
+	char		buf[];	/* string fields buffer */
 };
 
 #endif /* _UAPI_LINUX_AUDIT_H_ */
diff --git a/kernel/audit.c b/kernel/audit.c
index d4084751cfe6..7778eca34837 100644
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
@@ -1459,7 +1459,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 			security_release_secctx(ctx, len);
 		}
 		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
-				 sig_data, sizeof(*sig_data) + len);
+				 sig_data, struct_size(sig_data, ctx, len));
 		kfree(sig_data);
 		break;
 	case AUDIT_TTY_GET: {
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
index 4173e771650c..42d99896e7a6 100644
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
@@ -1092,7 +1092,7 @@ static void audit_list_rules(int seq, struct sk_buff_head *q)
 				break;
 			skb = audit_make_reply(seq, AUDIT_LIST_RULES, 0, 1,
 					       data,
-					       sizeof(*data) + data->buflen);
+					       struct_size(data, buf, data->buflen));
 			if (skb)
 				skb_queue_tail(q, skb);
 			kfree(data);
-- 
2.17.1

