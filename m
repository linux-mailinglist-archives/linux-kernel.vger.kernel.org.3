Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9CE571016
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiGLCTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGLCS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:18:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9C4A5;
        Mon, 11 Jul 2022 19:18:57 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LhkqR10WyzVffN;
        Tue, 12 Jul 2022 10:15:15 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 10:17:58 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 10:17:57 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>,
        <ardb@kernel.org>, <will@kernel.org>
CC:     <mark.rutland@arm.com>, <broonie@kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <arnd@arndb.de>, <linus.walleij@linaro.org>,
        <rostedt@goodmis.org>, <nick.hawkins@hpe.com>, <john@phrozen.org>,
        <mhiramat@kernel.org>, <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <lihuafei1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH 5/5] ARM: stacktrace: Convert stacktrace to generic ARCH_STACKWALK
Date:   Tue, 12 Jul 2022 10:15:27 +0800
Message-ID: <20220712021527.109921-6-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220712021527.109921-1-lihuafei1@huawei.com>
References: <20220712021527.109921-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

This patch converts ARM stacktrace to the generic ARCH_STACKWALK
implemented by commit 214d8ca6ee85 ("stacktrace: Provide common
infrastructure").

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/arm/Kconfig             |   1 +
 arch/arm/kernel/stacktrace.c | 114 ++++++++++-------------------------
 2 files changed, 33 insertions(+), 82 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7630ba9cb6cc..8da192853562 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,6 +18,7 @@ config ARM
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_STACKWALK
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if SWIOTLB || !MMU
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index ec0ca3192775..1b9c91e14d2e 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -136,98 +136,48 @@ void notrace walk_stackframe(struct stackframe *frame,
 EXPORT_SYMBOL(walk_stackframe);
 
 #ifdef CONFIG_STACKTRACE
-struct stack_trace_data {
-	struct stack_trace *trace;
-	unsigned int no_sched_functions;
-	unsigned int skip;
-};
-
-static bool save_trace(void *d, unsigned long addr)
-{
-	struct stack_trace_data *data = d;
-	struct stack_trace *trace = data->trace;
-
-	if (data->no_sched_functions && in_sched_functions(addr))
-		return true;
-	if (data->skip) {
-		data->skip--;
-		return true;
-	}
-
-	trace->entries[trace->nr_entries++] = addr;
-	return trace->nr_entries < trace->max_entries;
-}
-
-/* This must be noinline to so that our skip calculation works correctly */
-static noinline void __save_stack_trace(struct task_struct *tsk,
-	struct stack_trace *trace, unsigned int nosched)
+static void start_stack_trace(struct stackframe *frame, struct task_struct *task,
+			      unsigned long fp, unsigned long sp,
+			      unsigned long lr, unsigned long pc)
 {
-	struct stack_trace_data data;
-	struct stackframe frame;
-
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = nosched;
-
-	if (tsk != current) {
-		/* task blocked in __switch_to */
-		frame.fp = thread_saved_fp(tsk);
-		frame.sp = thread_saved_sp(tsk);
-		frame.lr = 0;		/* recovered from the stack */
-		frame.pc = thread_saved_pc(tsk);
-	} else {
-		/* We don't want this function nor the caller */
-		data.skip += 2;
-		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.sp = current_stack_pointer;
-		frame.lr = (unsigned long)__builtin_return_address(0);
-here:
-		frame.pc = (unsigned long)&&here;
-	}
+	frame->fp = fp;
+	frame->sp = sp;
+	frame->lr = lr;
+	frame->pc = pc;
 #ifdef CONFIG_KRETPROBES
-	frame.kr_cur = NULL;
-	frame.tsk = tsk;
+	frame->kr_cur = NULL;
+	frame->tsk = task;
 #endif
 #ifdef CONFIG_UNWINDER_FRAME_POINTER
-	frame.ex_frame = false;
+	frame->ex_frame = in_entry_text(frame->pc) ? true : false;
 #endif
-
-	walk_stackframe(&frame, save_trace, &data);
 }
 
-void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
+void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+		     struct task_struct *task, struct pt_regs *regs)
 {
-	struct stack_trace_data data;
 	struct stackframe frame;
 
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = 0;
-
-	frame.fp = regs->ARM_fp;
-	frame.sp = regs->ARM_sp;
-	frame.lr = regs->ARM_lr;
-	frame.pc = regs->ARM_pc;
-#ifdef CONFIG_KRETPROBES
-	frame.kr_cur = NULL;
-	frame.tsk = current;
-#endif
-#ifdef CONFIG_UNWINDER_FRAME_POINTER
-	frame.ex_frame = in_entry_text(frame.pc) ? true : false;
-#endif
-
-	walk_stackframe(&frame, save_trace, &data);
-}
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
-{
-	__save_stack_trace(tsk, trace, 1);
-}
-EXPORT_SYMBOL(save_stack_trace_tsk);
+	if (regs) {
+		start_stack_trace(&frame, NULL, regs->ARM_fp, regs->ARM_sp,
+				  regs->ARM_lr, regs->ARM_pc);
+	} else if (task != current) {
+		/* task blocked in __switch_to */
+		start_stack_trace(&frame, task, thread_saved_fp(task),
+				  thread_saved_sp(task), 0,
+				  thread_saved_pc(task));
+	} else {
+here:
+		start_stack_trace(&frame, task,
+				  (unsigned long)__builtin_frame_address(0),
+				  current_stack_pointer,
+				  (unsigned long)__builtin_return_address(0),
+				  (unsigned long)&&here);
+		/* skip this function */
+		if (unwind_frame(&frame))
+			return;
+	}
 
-void save_stack_trace(struct stack_trace *trace)
-{
-	__save_stack_trace(current, trace, 0);
+	walk_stackframe(&frame, consume_entry, cookie);
 }
-EXPORT_SYMBOL_GPL(save_stack_trace);
 #endif
-- 
2.17.1

