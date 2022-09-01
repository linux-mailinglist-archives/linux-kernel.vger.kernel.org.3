Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964C85A950A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiIAKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIAKtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:49:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4432311EB77
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:49:11 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJHkc5llwzkWnM;
        Thu,  1 Sep 2022 18:45:28 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 18:49:09 +0800
Received: from huawei.com (10.67.175.41) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 18:49:09 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <liaochang1@huawei.com>, <chris.zjh@huawei.com>,
        <zouyipeng@huawei.com>
Subject: [PATCH 1/2] tracing: hold caller_addr to hardirq_{enable,disable}_ip
Date:   Thu, 1 Sep 2022 18:45:14 +0800
Message-ID: <20220901104515.135162-2-zouyipeng@huawei.com>
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

Currently, The arguments passing to lockdep_hardirqs_{on,off} was fixed
in CALLER_ADDR0.
The function trace_hardirqs_on_caller should have been intended to use
caller_addr to represent the address that caller wants to be traced.

For example, lockdep log in riscv showing the last {enabled,disabled} at
__trace_hardirqs_{on,off} all the time(if called by):
[   57.853175] hardirqs last  enabled at (2519): __trace_hardirqs_on+0xc/0x14
[   57.853848] hardirqs last disabled at (2520): __trace_hardirqs_off+0xc/0x14

After use trace_hardirqs_xx_caller, we can get more effective information:
[   53.781428] hardirqs last  enabled at (2595): restore_all+0xe/0x66
[   53.782185] hardirqs last disabled at (2596): ret_from_exception+0xa/0x10

Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 kernel/trace/trace_preemptirq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 95b58bd757ce..1e130da1b742 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -95,14 +95,14 @@ __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 	}
 
 	lockdep_hardirqs_on_prepare();
-	lockdep_hardirqs_on(CALLER_ADDR0);
+	lockdep_hardirqs_on(caller_addr);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
 NOKPROBE_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
-	lockdep_hardirqs_off(CALLER_ADDR0);
+	lockdep_hardirqs_off(caller_addr);
 
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
-- 
2.17.1

