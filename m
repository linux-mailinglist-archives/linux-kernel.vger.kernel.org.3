Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3E751B5A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiEECNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiEECNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:13:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7821E13
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:09:53 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KtxsS2DwRzGpY0;
        Thu,  5 May 2022 10:07:08 +0800 (CST)
Received: from localhost.localdomain (10.157.217.52) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 10:09:51 +0800
From:   taolan <taolan@huawei.com>
To:     <pmladek@suse.com>, <senozhatsky@chromium.org>,
        <rostedt@goodmis.org>, <john.ogness@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] =?UTF-8?q?printk:=20fix=20kernel=20msg=20leakage=20in=20s?= =?UTF-8?q?yslog=5Fprint=5Fall=20function=EF=BC=9B?=
Date:   Thu, 5 May 2022 02:05:41 +0000
Message-ID: <20220505020541.1133-1-taolan@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.157.217.52]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: t00264981 <taolan@huawei.com>

This function applies for memory but does not initialize the memory,and
then invokes copy_to_user to copy the memory to the user space, which
causes kernel information leaks.

[ 148.439660] kernel memory leak value 0xffffff80aed972bc at
0xffffffd37f00a000 to 0x704b883e74

Signed-off-by: t00264981 <taolan@huawei.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index da03c15ecc89..22d7d821909d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1591,7 +1591,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	u64 seq;
 	bool time;
 
-	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
+	text = kzalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
-- 
2.18.0.huawei.25

