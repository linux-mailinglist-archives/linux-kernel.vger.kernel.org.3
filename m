Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6186F5A2223
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245491AbiHZHoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245435AbiHZHoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:44:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428BFC2EBB;
        Fri, 26 Aug 2022 00:44:04 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDWwF1V80zlWW5;
        Fri, 26 Aug 2022 15:40:45 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:44:02 +0800
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
Subject: [PATCH RESEND v3 2/4] ARM: stacktrace: Avoid duplicate saving of exception PC value
Date:   Fri, 26 Aug 2022 15:40:45 +0800
Message-ID: <20220826074047.107357-3-lihuafei1@huawei.com>
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

Because an exception stack frame is not created in the exception entry,
save_trace() does special handling for the exception PC, but this is
only needed when CONFIG_FRAME_POINTER_UNWIND=y. When
CONFIG_ARM_UNWIND=y, unwind annotations have been added to the exception
entry and save_trace() will repeatedly save the exception PC:

    [0x7f000090] hrtimer_hander+0x8/0x10 [hrtimer]
    [0x8019ec50] __hrtimer_run_queues+0x18c/0x394
    [0x8019f760] hrtimer_run_queues+0xbc/0xd0
    [0x8019def0] update_process_times+0x34/0x80
    [0x801ad2a4] tick_periodic+0x48/0xd0
    [0x801ad3dc] tick_handle_periodic+0x1c/0x7c
    [0x8010f2e0] twd_handler+0x30/0x40
    [0x80177620] handle_percpu_devid_irq+0xa0/0x23c
    [0x801718d0] generic_handle_domain_irq+0x24/0x34
    [0x80502d28] gic_handle_irq+0x74/0x88
    [0x8085817c] generic_handle_arch_irq+0x58/0x78
    [0x80100ba8] __irq_svc+0x88/0xc8
    [0x80108114] arch_cpu_idle+0x38/0x3c
    [0x80108114] arch_cpu_idle+0x38/0x3c    <==== duplicate saved exception PC
    [0x80861bf8] default_idle_call+0x38/0x130
    [0x8015d5cc] do_idle+0x150/0x214
    [0x8015d978] cpu_startup_entry+0x18/0x1c
    [0x808589c0] rest_init+0xd8/0xdc
    [0x80c00a44] arch_post_acpi_subsys_init+0x0/0x8

We can move the special handling of the exception PC in save_trace() to
the unwind_frame() of the frame pointer unwinder.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Reviewed-by: Linus Waleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/stacktrace.h |  6 +++++
 arch/arm/kernel/return_address.c  |  1 +
 arch/arm/kernel/stacktrace.c      | 44 +++++++++++++++++++++----------
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 3e78f921b8b2..39be2d1aa27b 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -21,6 +21,9 @@ struct stackframe {
 	struct llist_node *kr_cur;
 	struct task_struct *tsk;
 #endif
+#ifdef CONFIG_UNWINDER_FRAME_POINTER
+	bool ex_frame;
+#endif
 };
 
 static __always_inline
@@ -34,6 +37,9 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
 		frame->kr_cur = NULL;
 		frame->tsk = current;
 #endif
+#ifdef CONFIG_UNWINDER_FRAME_POINTER
+		frame->ex_frame = in_entry_text(frame->pc);
+#endif
 }
 
 extern int unwind_frame(struct stackframe *frame);
diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index 8aac1e10b117..38f1ea9c724d 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -47,6 +47,7 @@ void *return_address(unsigned int level)
 	frame.kr_cur = NULL;
 	frame.tsk = current;
 #endif
+	frame.ex_frame = false;
 
 	walk_stackframe(&frame, save_return_addr, &data);
 
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index af87040b0353..85443b5d1922 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -82,6 +82,27 @@ int notrace unwind_frame(struct stackframe *frame)
 	if (frame_pointer_check(frame))
 		return -EINVAL;
 
+	/*
+	 * When we unwind through an exception stack, include the saved PC
+	 * value into the stack trace.
+	 */
+	if (frame->ex_frame) {
+		struct pt_regs *regs = (struct pt_regs *)frame->sp;
+
+		/*
+		 * We check that 'regs + sizeof(struct pt_regs)' (that is,
+		 * &regs[1]) does not exceed the bottom of the stack to avoid
+		 * accessing data outside the task's stack. This may happen
+		 * when frame->ex_frame is a false positive.
+		 */
+		if ((unsigned long)&regs[1] > ALIGN(frame->sp, THREAD_SIZE))
+			return -EINVAL;
+
+		frame->pc = regs->ARM_pc;
+		frame->ex_frame = false;
+		return 0;
+	}
+
 	/* restore the registers from the stack frame */
 #ifdef CONFIG_CC_IS_CLANG
 	frame->sp = frame->fp;
@@ -98,6 +119,9 @@ int notrace unwind_frame(struct stackframe *frame)
 					(void *)frame->fp, &frame->kr_cur);
 #endif
 
+	if (in_entry_text(frame->pc))
+		frame->ex_frame = true;
+
 	return 0;
 }
 #endif
@@ -128,7 +152,6 @@ static int save_trace(struct stackframe *frame, void *d)
 {
 	struct stack_trace_data *data = d;
 	struct stack_trace *trace = data->trace;
-	struct pt_regs *regs;
 	unsigned long addr = frame->pc;
 
 	if (data->no_sched_functions && in_sched_functions(addr))
@@ -139,19 +162,6 @@ static int save_trace(struct stackframe *frame, void *d)
 	}
 
 	trace->entries[trace->nr_entries++] = addr;
-
-	if (trace->nr_entries >= trace->max_entries)
-		return 1;
-
-	if (!in_entry_text(frame->pc))
-		return 0;
-
-	regs = (struct pt_regs *)frame->sp;
-	if ((unsigned long)&regs[1] > ALIGN(frame->sp, THREAD_SIZE))
-		return 0;
-
-	trace->entries[trace->nr_entries++] = regs->ARM_pc;
-
 	return trace->nr_entries >= trace->max_entries;
 }
 
@@ -193,6 +203,9 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 	frame.kr_cur = NULL;
 	frame.tsk = tsk;
 #endif
+#ifdef CONFIG_UNWINDER_FRAME_POINTER
+	frame.ex_frame = false;
+#endif
 
 	walk_stackframe(&frame, save_trace, &data);
 }
@@ -214,6 +227,9 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	frame.kr_cur = NULL;
 	frame.tsk = current;
 #endif
+#ifdef CONFIG_UNWINDER_FRAME_POINTER
+	frame.ex_frame = in_entry_text(frame.pc);
+#endif
 
 	walk_stackframe(&frame, save_trace, &data);
 }
-- 
2.17.1

