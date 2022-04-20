Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11340507EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358871AbiDTCNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358829AbiDTCNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:13:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11683286F8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:10:47 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KjkYR5cnHzCrYg;
        Wed, 20 Apr 2022 10:06:19 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:10:44 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:10:44 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <broonie@kernel.org>,
        <mark.rutland@arm.com>, <ardb@kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH -next] arm64: ftrace: Add DYNAMIC_FTRACE_WITH_ARGS support
Date:   Wed, 20 Apr 2022 10:09:42 +0800
Message-ID: <20220420020942.204224-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DYNAMIC_FTRACE_WITH_ARGS allows ftrace_ops without the FL_SAVE_REGS flag
set (via the "ftrace_caller" trampoline) to fetch all parameters and
stack pointer. On arm64, under the DYNAMIC_FTRACE_WITH_REGS
implementation, ftrace_caller() already supports filling the above
registers into pt_regs, all that remains to be done is to ensure that
arch_ftrace_get_regs() returns NULL when FL_SAVE_REGS is not set. We use
pt_regs::regs[10] to identify whether the FL_SAVE_REGS flag is set.

The mcount-based implementation supports DYNAMIC_FTRACE_WITH_ARGS with
some difficulty, as some registers (e.g. X0) are already clobbered
before entering the trampoline. We need to rely on gcc's
"-fpatchable-function-entry" feature, so here we have
DYNAMIC_FTRACE_WITH_ARGS depending on DYNAMIC_FTRACE_WITH_REGS, and the
mcount-based implementation is unaffected.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/arm64/Kconfig               |  2 ++
 arch/arm64/include/asm/ftrace.h  | 17 +++++++++++++++++
 arch/arm64/kernel/entry-ftrace.S |  5 +++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 18a18a0e855d..a1b4c5800b38 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -177,6 +177,8 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
+		if HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1494cfa8639b..2b4cd442c843 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -78,6 +78,23 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+struct ftrace_regs {
+	struct pt_regs		regs;
+};
+
+static __always_inline struct pt_regs *
+arch_ftrace_get_regs(struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs = &fregs->regs;
+
+	/* When FL_SAVE_REGS is not set, X10 is set to zero */
+	if (!pt_regs_read_reg(regs, 10))
+		return NULL;
+	return regs;
+}
+#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 struct dyn_ftrace;
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index e535480a4069..805287fedb01 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -46,6 +46,8 @@
 
 	/* Optionally save the callee-saved registers, always save the FP */
 	.if \allregs == 1
+	/* Set X10 to 1 (just non-zero) for ops with FL_SAVE_REGS flag set */
+	mov	x10, #1
 	stp	x10, x11, [sp, #S_X10]
 	stp	x12, x13, [sp, #S_X12]
 	stp	x14, x15, [sp, #S_X14]
@@ -57,6 +59,9 @@
 	stp	x26, x27, [sp, #S_X26]
 	stp	x28, x29, [sp, #S_X28]
 	.else
+	/* Set X10 to 0 for ops without FL_SAVE_REGS flag */
+	mov	x10, #0
+	str	x10, [sp, #S_X10]
 	str	x29, [sp, #S_FP]
 	.endif
 
-- 
2.17.1

