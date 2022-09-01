Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335145A950C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiIAKtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiIAKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:49:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8D11EB7F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:49:12 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJHjn4GCFzYcys;
        Thu,  1 Sep 2022 18:44:45 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 18:49:10 +0800
Received: from huawei.com (10.67.175.41) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 18:49:10 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <liaochang1@huawei.com>, <chris.zjh@huawei.com>,
        <zouyipeng@huawei.com>
Subject: [PATCH 2/2] riscv: tracing: Improve hardirq tracing message
Date:   Thu, 1 Sep 2022 18:45:15 +0800
Message-ID: <20220901104515.135162-3-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901104515.135162-1-zouyipeng@huawei.com>
References: <20220901104515.135162-1-zouyipeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.41]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use trace_hardirqs_on_caller to improve irq_tracing message.

lockdep log in riscv showing the last {enabled,disabled} at
__trace_hardirqs_{on,off} all the time(if called by).
But that's not what we want to see, the caller is what we want.

Before this commit:
[   57.853175] hardirqs last  enabled at (2519): __trace_hardirqs_on+0xc/0x14
[   57.853848] hardirqs last disabled at (2520): __trace_hardirqs_off+0xc/0x14

After this commit
[   53.781428] hardirqs last  enabled at (2595): restore_all+0xe/0x66
[   53.782185] hardirqs last disabled at (2596): ret_from_exception+0xa/0x10

Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 arch/riscv/kernel/trace_irq.c | 4 ++--
 include/linux/irqflags.h      | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/trace_irq.c b/arch/riscv/kernel/trace_irq.c
index 095ac976d7da..7ca24b26e19f 100644
--- a/arch/riscv/kernel/trace_irq.c
+++ b/arch/riscv/kernel/trace_irq.c
@@ -16,12 +16,12 @@
 
 void __trace_hardirqs_on(void)
 {
-	trace_hardirqs_on();
+	trace_hardirqs_on_caller(CALLER_ADDR0);
 }
 NOKPROBE_SYMBOL(__trace_hardirqs_on);
 
 void __trace_hardirqs_off(void)
 {
-	trace_hardirqs_off();
+	trace_hardirqs_off_caller(CALLER_ADDR0);
 }
 NOKPROBE_SYMBOL(__trace_hardirqs_off);
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 5ec0fa71399e..46774fa85cde 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -53,6 +53,8 @@ extern void trace_hardirqs_on_prepare(void);
 extern void trace_hardirqs_off_finish(void);
 extern void trace_hardirqs_on(void);
 extern void trace_hardirqs_off(void);
+extern void trace_hardirqs_on_caller(unsigned long caller_addr);
+extern void trace_hardirqs_off_caller(unsigned long caller_addr);
 
 # define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
-- 
2.17.1

