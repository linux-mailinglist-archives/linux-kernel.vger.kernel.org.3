Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF25AEEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiIFPYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239439AbiIFPXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:23:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A32AA376
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:35:09 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMS4M0CykzkWyg;
        Tue,  6 Sep 2022 22:11:47 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 22:15:34 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <bristot@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] rv/reactor: add __init/__exit annotations to module init/exit funcs
Date:   Tue, 6 Sep 2022 22:12:10 +0800
Message-ID: <20220906141210.132607-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Add missing __init/__exit annotations to module init/exit funcs.

Fixes: 135b881ea885 ("rv/reactor: Add the printk reactor")
Fixes: e88043c0ac16 ("rv/reactor: Add the panic reactor")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/trace/rv/reactor_panic.c  | 4 ++--
 kernel/trace/rv/reactor_printk.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
index b698d05dd069..d65f6c25a87c 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -24,13 +24,13 @@ static struct rv_reactor rv_panic = {
 	.react = rv_panic_reaction
 };
 
-static int register_react_panic(void)
+static int __init register_react_panic(void)
 {
 	rv_register_reactor(&rv_panic);
 	return 0;
 }
 
-static void unregister_react_panic(void)
+static void __exit unregister_react_panic(void)
 {
 	rv_unregister_reactor(&rv_panic);
 }
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
index 31899f953af4..4b6b7106a477 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -23,13 +23,13 @@ static struct rv_reactor rv_printk = {
 	.react = rv_printk_reaction
 };
 
-static int register_react_printk(void)
+static int __init register_react_printk(void)
 {
 	rv_register_reactor(&rv_printk);
 	return 0;
 }
 
-static void unregister_react_printk(void)
+static void __exit unregister_react_printk(void)
 {
 	rv_unregister_reactor(&rv_printk);
 }
-- 
2.17.1

