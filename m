Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060104DADCE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351151AbiCPJxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354994AbiCPJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:53:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC10E606E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:51:56 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KJQW72NTSzfZ2K;
        Wed, 16 Mar 2022 17:50:27 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 17:51:54 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Wed, 16 Mar
 2022 17:51:54 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rostedt@goodmis.org>, <mark.rutland@arm.com>,
        <bobo.shaobowang@huawei.com>, <zengshun.wu@outlook.com>
Subject: [RFC PATCH -next v2 2/4] arm64/ftrace: introduce ftrace dynamic trampoline entrances
Date:   Wed, 16 Mar 2022 18:01:30 +0800
Message-ID: <20220316100132.244849-3-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Jian <cj.chengjian@huawei.com>

We introduce two function entrances ftrace_(regs)_caller_tramp
for dynamic trampoline use, which are put into Read-Only section
and should be entirely copied to the space allocated for trampoline.

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 arch/arm64/kernel/entry-ftrace.S | 80 +++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index e535480a4069..88462d925446 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -76,6 +76,23 @@
 	add	x29, sp, #S_STACKFRAME
 	.endm
 
+	.macro ftrace_regs_restore
+	/* Restore function arguments */
+	ldp	x0, x1, [sp]
+	ldp	x2, x3, [sp, #S_X2]
+	ldp	x4, x5, [sp, #S_X4]
+	ldp	x6, x7, [sp, #S_X6]
+	ldr	x8, [sp, #S_X8]
+
+	/* Restore the callsite's FP, LR, PC */
+	ldr	x29, [sp, #S_FP]
+	ldr	x30, [sp, #S_LR]
+	ldr	x9, [sp, #S_PC]
+
+	/* Restore the callsite's SP */
+	add	sp, sp, #PT_REGS_SIZE + 16
+	.endm
+
 SYM_CODE_START(ftrace_regs_caller)
 	bti	c
 	ftrace_regs_entry	1
@@ -108,22 +125,8 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL) // ftrace_graph_caller();
  * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
  * to restore x0-x8, x29, and x30.
  */
-ftrace_common_return:
-	/* Restore function arguments */
-	ldp	x0, x1, [sp]
-	ldp	x2, x3, [sp, #S_X2]
-	ldp	x4, x5, [sp, #S_X4]
-	ldp	x6, x7, [sp, #S_X6]
-	ldr	x8, [sp, #S_X8]
-
-	/* Restore the callsite's FP, LR, PC */
-	ldr	x29, [sp, #S_FP]
-	ldr	x30, [sp, #S_LR]
-	ldr	x9, [sp, #S_PC]
-
-	/* Restore the callsite's SP */
-	add	sp, sp, #PT_REGS_SIZE + 16
-
+SYM_INNER_LABEL(ftrace_common_return, SYM_L_GLOBAL)
+	ftrace_regs_restore
 	ret	x9
 SYM_CODE_END(ftrace_common)
 
@@ -138,6 +141,51 @@ SYM_CODE_START(ftrace_graph_caller)
 SYM_CODE_END(ftrace_graph_caller)
 #endif
 
+.pushsection ".rodata", "a"
+// ftrace trampoline for ftrace_regs_caller
+SYM_CODE_START(ftrace_regs_caller_tramp)
+	bti	c
+	ftrace_regs_entry	1		// save all regs
+
+	sub	x0, x30, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
+	mov	x1, x9				// parent_ip (callsite's LR)
+SYM_INNER_LABEL(ftrace_regs_caller_tramp_ops, SYM_L_GLOBAL)
+	ldr	x2, 0				// ops
+	mov	x3, sp				// regs
+SYM_INNER_LABEL(ftrace_regs_caller_tramp_call, SYM_L_GLOBAL)
+	nop
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+SYM_INNER_LABEL(ftrace_regs_caller_tramp_graph_call, SYM_L_GLOBAL)
+	nop					// ftrace_graph_caller()
+#endif
+	ftrace_regs_restore
+SYM_INNER_LABEL(ftrace_regs_caller_tramp_end, SYM_L_GLOBAL)
+	ret	x9
+SYM_CODE_END(ftrace_regs_caller_tramp)
+
+// ftrace trampoline for ftrace_caller
+SYM_CODE_START(ftrace_caller_tramp)
+	bti	c
+	ftrace_regs_entry	0		// save all regs
+
+	sub	x0, x30, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
+	mov	x1, x9				// parent_ip (callsite's LR)
+SYM_INNER_LABEL(ftrace_caller_tramp_ops, SYM_L_GLOBAL)
+	ldr	x2, 0				// ops
+	mov	x3, sp				// regs
+SYM_INNER_LABEL(ftrace_caller_tramp_call, SYM_L_GLOBAL)
+	nop
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+SYM_INNER_LABEL(ftrace_caller_tramp_graph_call, SYM_L_GLOBAL)
+	nop					// ftrace_graph_caller()
+#endif
+	ftrace_regs_restore
+SYM_INNER_LABEL(ftrace_caller_tramp_end, SYM_L_GLOBAL)
+	ret	x9
+SYM_CODE_END(ftrace_caller_tramp)
+.popsection		// .rodata
+
+
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 /*
-- 
2.25.1

