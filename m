Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026FA5A2225
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245470AbiHZHoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245445AbiHZHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:44:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342FC0B70;
        Fri, 26 Aug 2022 00:44:03 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDWvw6NWxz19V00;
        Fri, 26 Aug 2022 15:40:28 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:44:01 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:44:00 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>,
        <ardb@kernel.org>, <will@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>
CC:     <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <nick.hawkins@hpe.com>, <john@phrozen.org>,
        <mhiramat@kernel.org>, <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <lihuafei1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH RESEND v3 1/4] ARM: stacktrace: Skip frame pointer boundary check for call_with_stack()
Date:   Fri, 26 Aug 2022 15:40:44 +0800
Message-ID: <20220826074047.107357-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220826074047.107357-1-lihuafei1@huawei.com>
References: <20220826074047.107357-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the frame pointer unwinder, it was found that the stack trace
output of stack_trace_save() is incomplete if the stack contains
call_with_stack():

 [0x7f00002c] dump_stack_task+0x2c/0x90 [hrtimer]
 [0x7f0000a0] hrtimer_hander+0x10/0x18 [hrtimer]
 [0x801a67f0] __hrtimer_run_queues+0x1b0/0x3b4
 [0x801a7350] hrtimer_run_queues+0xc4/0xd8
 [0x801a597c] update_process_times+0x3c/0x88
 [0x801b5a98] tick_periodic+0x50/0xd8
 [0x801b5bf4] tick_handle_periodic+0x24/0x84
 [0x8010ffc4] twd_handler+0x38/0x48
 [0x8017d220] handle_percpu_devid_irq+0xa8/0x244
 [0x80176e9c] generic_handle_domain_irq+0x2c/0x3c
 [0x8052e3a8] gic_handle_irq+0x7c/0x90
 [0x808ab15c] generic_handle_arch_irq+0x60/0x80
 [0x8051191c] call_with_stack+0x1c/0x20

For the frame pointer unwinder, unwind_frame() checks stackframe::fp by
stackframe::sp. Since call_with_stack() switches the SP from one stack
to another, stackframe::fp and stackframe: :sp will point to different
stacks, so we can no longer check stackframe::fp by stackframe::sp. Skip
checking stackframe::fp at this point to avoid this problem.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Reviewed-by: Linus Waleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/stacktrace.c   | 40 ++++++++++++++++++++++++++++------
 arch/arm/lib/call_with_stack.S |  2 ++
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index d0fa2037460a..af87040b0353 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -9,6 +9,8 @@
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
 
+#include "reboot.h"
+
 #if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
 /*
  * Unwind the current stack frame and store the new register values in the
@@ -39,29 +41,53 @@
  * Note that with framepointer enabled, even the leaf functions have the same
  * prologue and epilogue, therefore we can ignore the LR value in this case.
  */
-int notrace unwind_frame(struct stackframe *frame)
+
+extern unsigned long call_with_stack_end;
+
+static int frame_pointer_check(struct stackframe *frame)
 {
 	unsigned long high, low;
 	unsigned long fp = frame->fp;
+	unsigned long pc = frame->pc;
+
+	/*
+	 * call_with_stack() is the only place we allow SP to jump from one
+	 * stack to another, with FP and SP pointing to different stacks,
+	 * skipping the FP boundary check at this point.
+	 */
+	if (pc >= (unsigned long)&call_with_stack &&
+			pc < (unsigned long)&call_with_stack_end)
+		return 0;
 
 	/* only go to a higher address on the stack */
 	low = frame->sp;
 	high = ALIGN(low, THREAD_SIZE);
 
-#ifdef CONFIG_CC_IS_CLANG
 	/* check current frame pointer is within bounds */
+#ifdef CONFIG_CC_IS_CLANG
 	if (fp < low + 4 || fp > high - 4)
 		return -EINVAL;
-
-	frame->sp = frame->fp;
-	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
-	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 4));
 #else
-	/* check current frame pointer is within bounds */
 	if (fp < low + 12 || fp > high - 4)
 		return -EINVAL;
+#endif
+
+	return 0;
+}
+
+int notrace unwind_frame(struct stackframe *frame)
+{
+	unsigned long fp = frame->fp;
+
+	if (frame_pointer_check(frame))
+		return -EINVAL;
 
 	/* restore the registers from the stack frame */
+#ifdef CONFIG_CC_IS_CLANG
+	frame->sp = frame->fp;
+	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
+	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 4));
+#else
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp - 12));
 	frame->sp = READ_ONCE_NOCHECK(*(unsigned long *)(fp - 8));
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp - 4));
diff --git a/arch/arm/lib/call_with_stack.S b/arch/arm/lib/call_with_stack.S
index 0a268a6c513c..5030d4e8d126 100644
--- a/arch/arm/lib/call_with_stack.S
+++ b/arch/arm/lib/call_with_stack.S
@@ -46,4 +46,6 @@ UNWIND( .setfp	fpreg, sp	)
 	pop	{fpreg, pc}
 UNWIND( .fnend			)
 #endif
+	.globl call_with_stack_end
+call_with_stack_end:
 ENDPROC(call_with_stack)
-- 
2.17.1

