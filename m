Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85D5A2226
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245379AbiHZHoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245487AbiHZHoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:44:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7487FC2EBB;
        Fri, 26 Aug 2022 00:44:06 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDWy616HNzGprJ;
        Fri, 26 Aug 2022 15:42:22 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:44:03 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:44:02 +0800
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
Subject: [PATCH RESEND v3 4/4] ARM: stacktrace: Convert stacktrace to generic ARCH_STACKWALK
Date:   Fri, 26 Aug 2022 15:40:47 +0800
Message-ID: <20220826074047.107357-5-lihuafei1@huawei.com>
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

Historically architectures have had duplicated code in their stack trace
implementations for filtering what gets traced. In order to avoid this
duplication some generic code has been provided using a new interface
arch_stack_walk(), enabled by selecting ARCH_STACKWALK in Kconfig, which
factors all this out into the generic stack trace code. Convert ARM to
use this common infrastructure.

When initializing the stack frame of the current task, arm64 uses
__builtin_frame_address(1) to initialize the frame pointer, skipping
arch_stack_walk(), see the commit c607ab4f916d ("arm64: stacktrace:
don't trace arch_ stack_walk()"). Since __builtin_frame_address(1) does
not work on ARM, unwind_frame() is used to unwind the stack one layer
forward before calling walk_stackframe().

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig             |   1 +
 arch/arm/kernel/stacktrace.c | 114 ++++++++++-------------------------
 2 files changed, 33 insertions(+), 82 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..3a8abc84260a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -17,6 +17,7 @@ config ARM
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_STACKWALK
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index d05968bc7812..620aa82e3bdd 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -142,40 +142,32 @@ void notrace walk_stackframe(struct stackframe *frame,
 EXPORT_SYMBOL(walk_stackframe);
 
 #ifdef CONFIG_STACKTRACE
-struct stack_trace_data {
-	struct stack_trace *trace;
-	unsigned int no_sched_functions;
-	unsigned int skip;
-};
-
-static bool save_trace(void *d, unsigned long addr)
+static void start_stack_trace(struct stackframe *frame, struct task_struct *task,
+			      unsigned long fp, unsigned long sp,
+			      unsigned long lr, unsigned long pc)
 {
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
+	frame->fp = fp;
+	frame->sp = sp;
+	frame->lr = lr;
+	frame->pc = pc;
+#ifdef CONFIG_KRETPROBES
+	frame->kr_cur = NULL;
+	frame->tsk = task;
+#endif
+#ifdef CONFIG_UNWINDER_FRAME_POINTER
+	frame->ex_frame = in_entry_text(frame->pc);
+#endif
 }
 
-/* This must be noinline to so that our skip calculation works correctly */
-static noinline void __save_stack_trace(struct task_struct *tsk,
-	struct stack_trace *trace, unsigned int nosched)
+void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+		     struct task_struct *task, struct pt_regs *regs)
 {
-	struct stack_trace_data data;
 	struct stackframe frame;
 
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = nosched;
-
-	if (tsk != current) {
+	if (regs) {
+		start_stack_trace(&frame, NULL, regs->ARM_fp, regs->ARM_sp,
+				  regs->ARM_lr, regs->ARM_pc);
+	} else if (task != current) {
 #ifdef CONFIG_SMP
 		/*
 		 * What guarantees do we have here that 'tsk' is not
@@ -184,64 +176,22 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 		 */
 		return;
 #else
-		frame.fp = thread_saved_fp(tsk);
-		frame.sp = thread_saved_sp(tsk);
-		frame.lr = 0;		/* recovered from the stack */
-		frame.pc = thread_saved_pc(tsk);
+		start_stack_trace(&frame, task, thread_saved_fp(task),
+				  thread_saved_sp(task), 0,
+				  thread_saved_pc(task));
 #endif
 	} else {
-		/* We don't want this function nor the caller */
-		data.skip += 2;
-		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.sp = current_stack_pointer;
-		frame.lr = (unsigned long)__builtin_return_address(0);
 here:
-		frame.pc = (unsigned long)&&here;
+		start_stack_trace(&frame, task,
+				  (unsigned long)__builtin_frame_address(0),
+				  current_stack_pointer,
+				  (unsigned long)__builtin_return_address(0),
+				  (unsigned long)&&here);
+		/* skip this function */
+		if (unwind_frame(&frame))
+			return;
 	}
-#ifdef CONFIG_KRETPROBES
-	frame.kr_cur = NULL;
-	frame.tsk = tsk;
-#endif
-#ifdef CONFIG_UNWINDER_FRAME_POINTER
-	frame.ex_frame = false;
-#endif
 
-	walk_stackframe(&frame, save_trace, &data);
-}
-
-void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
-{
-	struct stack_trace_data data;
-	struct stackframe frame;
-
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
-	frame.ex_frame = in_entry_text(frame.pc);
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
-
-void save_stack_trace(struct stack_trace *trace)
-{
-	__save_stack_trace(current, trace, 0);
+	walk_stackframe(&frame, consume_entry, cookie);
 }
-EXPORT_SYMBOL_GPL(save_stack_trace);
 #endif
-- 
2.17.1

