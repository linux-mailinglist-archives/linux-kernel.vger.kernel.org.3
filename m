Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ACF547328
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiFKJZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiFKJZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:25:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEFF57B29
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 02:25:01 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LKsnR44D4z1K9Lx;
        Sat, 11 Jun 2022 17:23:07 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 17:25:00 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] audit: make is_audit_feature_set() static
Date:   Sat, 11 Jun 2022 17:23:04 +0800
Message-ID: <20220611092304.152469-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Currently nobody use is_audit_feature_set() outside this file, so make
it static.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/linux/audit.h | 2 --
 kernel/audit.c        | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index cece70231138..00f7a80f1a3e 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -119,8 +119,6 @@ enum audit_nfcfgop {
 	AUDIT_NFT_OP_INVALID,
 };
 
-extern int is_audit_feature_set(int which);
-
 extern int __init audit_register_class(int class, unsigned *list);
 extern int audit_classify_syscall(int abi, unsigned syscall);
 extern int audit_classify_arch(int arch);
diff --git a/kernel/audit.c b/kernel/audit.c
index 0749211d5552..a75978ae38ad 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1100,7 +1100,7 @@ static inline void audit_log_user_recv_msg(struct audit_buffer **ab,
 	audit_log_common_recv_msg(NULL, ab, msg_type);
 }
 
-int is_audit_feature_set(int i)
+static int is_audit_feature_set(int i)
 {
 	return af.features & AUDIT_FEATURE_TO_MASK(i);
 }
-- 
2.17.1

