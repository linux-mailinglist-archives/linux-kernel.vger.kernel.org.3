Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676F054B23F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbiFNNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiFNNZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:25:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497973CFC9;
        Tue, 14 Jun 2022 06:25:35 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMpxz59kwzRhxc;
        Tue, 14 Jun 2022 21:22:15 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 21:25:33 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <cgzones@googlemail.com>,
        <austin.kim@lge.com>, <omosnace@redhat.com>,
        <michalorzel.eng@gmail.com>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] selinux: Fix memleak in security_read_policy
Date:   Tue, 14 Jun 2022 21:23:33 +0800
Message-ID: <20220614132333.143042-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

In this function, it directly returns the result of __security_read_policy
without freeing the allocated memory in *data, cause memory leak issue,
so free the memory if __security_read_policy failed.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/ss/services.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 69b2734311a6..78afda6a36b8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -4018,6 +4018,7 @@ static int __security_read_policy(struct selinux_policy *policy,
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len)
 {
+	int err;
 	struct selinux_policy *policy;
 
 	policy = rcu_dereference_protected(
@@ -4030,7 +4031,13 @@ int security_read_policy(struct selinux_state *state,
 	if (!*data)
 		return -ENOMEM;
 
-	return __security_read_policy(policy, *data, len);
+	err = __security_read_policy(policy, *data, len);
+	if (err) {
+		vfree(*data);
+		*data = NULL;
+		*len = 0;
+	}
+	return err;
 }
 
 /**
-- 
2.17.1

