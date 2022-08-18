Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D453A597B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbiHRB6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiHRB6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:58:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157441D01
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:58:34 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M7SgJ1bcPzGpXS;
        Thu, 18 Aug 2022 09:57:00 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 09:58:33 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 09:58:33 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <chenzhongjin@huawei.com>
Subject: [PATCH] x86/unwind/orc: unwind ftrace trampolines with correct orc
Date:   Thu, 18 Aug 2022 09:55:25 +0800
Message-ID: <20220818015525.222053-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When meeting ftrace trampolines in orc unwinding, unwinder uses address
of ftrace_{regs_}call address to find the orc, which gets next frame at
sp+176.

If there is an irq hitting at sub $0xa8,%rsp, the next frame should be
sp+8 instead of 176. It makes unwinder skip correct frame and throw
warnings such as "wrong direction" or "can't access registers", etc,
depending on the content of the wrong frame address.

By adding the base address ftrace_{regs_}caller with the offset
*ip - ops->trampoline*,
we can get the correct address to find orc.

Also change "caller" to "tramp_addr" to make variable name conform to
its content.

Fixes: 6be7fa3c74d1 ("ftrace, orc, x86: Handle ftrace dynamically allocated trampolines")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/x86/kernel/unwind_orc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 38185aedf7d1..a938c5d0ed6f 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -93,22 +93,25 @@ static struct orc_entry *orc_find(unsigned long ip);
 static struct orc_entry *orc_ftrace_find(unsigned long ip)
 {
 	struct ftrace_ops *ops;
-	unsigned long caller;
+	unsigned long tramp_addr, offset;
 
 	ops = ftrace_ops_trampoline(ip);
 	if (!ops)
 		return NULL;
 
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
-		caller = (unsigned long)ftrace_regs_call;
+		tramp_addr = (unsigned long)ftrace_regs_caller;
 	else
-		caller = (unsigned long)ftrace_call;
+		tramp_addr = (unsigned long)ftrace_caller;
+
+	offset = ip - ops->trampoline;
+	tramp_addr += offset;
 
 	/* Prevent unlikely recursion */
-	if (ip == caller)
+	if (ip == tramp_addr)
 		return NULL;
 
-	return orc_find(caller);
+	return orc_find(tramp_addr);
 }
 #else
 static struct orc_entry *orc_ftrace_find(unsigned long ip)
-- 
2.17.1

