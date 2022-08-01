Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F375D586738
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiHAKHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiHAKH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:07:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4DB17E3A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:07:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LxDHY2QJWz1M8Nm;
        Mon,  1 Aug 2022 18:04:25 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 1 Aug
 2022 18:07:23 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <pmladek@suse.com>, <akpm@linux-foundation.org>,
        <gpiccoli@igalia.com>, <elver@google.com>, <mcgrof@kernel.org>,
        <tangmeng@uniontech.com>, <yangtiezhu@loongson.cn>,
        <john.ogness@linutronix.de>, <bigeasy@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [PATCH -next] panic: Add register_panic_notifier and unregister_panic_notifier
Date:   Mon, 1 Aug 2022 10:05:09 +0000
Message-ID: <20220801100509.62282-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two methods to manipulate panic_notifier_list and export them.
Subsequently, panic_notifier_list is changed to static variable.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 include/linux/panic_notifier.h |  3 +++
 kernel/panic.c                 | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index 41e32483d7a7..9543d498b90b 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -5,6 +5,9 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
 
+int register_panic_notifier(struct notifier_block *nb);
+int unregister_panic_notifier(struct notifier_block *nb);
+
 extern struct atomic_notifier_head panic_notifier_list;
 
 extern bool crash_kexec_post_notifiers;
diff --git a/kernel/panic.c b/kernel/panic.c
index c6eb8f8db0c0..b848ec4ca6e2 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -199,6 +199,18 @@ static void panic_print_sys_info(bool console_flush)
 		ftrace_dump(DUMP_ALL);
 }
 
+int register_panic_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&panic_notifier_list, nb);
+}
+EXPORT_SYMBOL(register_panic_notifier);
+
+int unregister_panic_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&panic_notifier_list, nb);
+}
+EXPORT_SYMBOL(unregister_panic_notifier);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
-- 
2.17.1

