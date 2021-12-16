Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5330A4767B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhLPCHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:07:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15744 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbhLPCHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:07:36 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JDwR56wz7zZdWC;
        Thu, 16 Dec 2021 10:04:33 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:07:34 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>,
        <keescook@chromium.org>, <gustavoars@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH -next, v3 1/2] audit: use struct_size() helper in audit_[send|make]_reply()
Date:   Thu, 16 Dec 2021 10:08:30 +0800
Message-ID: <20211216020831.93674-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of struct_size() helper instead of an open-coded calculation.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/audit.c       | 2 +-
 kernel/auditfilter.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index f33028578c60..7778eca34837 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1459,7 +1459,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 			security_release_secctx(ctx, len);
 		}
 		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
-				 sig_data, sizeof(*sig_data) + len);
+				 sig_data, struct_size(sig_data, ctx, len));
 		kfree(sig_data);
 		break;
 	case AUDIT_TTY_GET: {
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 19352820b274..42d99896e7a6 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
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

