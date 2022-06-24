Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A67559B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiFXORq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiFXORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:17:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D9F53A55
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:17:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B72A121AF8;
        Fri, 24 Jun 2022 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656080260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03tWAhpXCmNzUiHfSiKw+1BZE8rrRfRXxeC/0KmMbDU=;
        b=MwamV0L8hiRk24i7XhyFceAhMrXrf446PrE8/rC0zFDFk4NvhmyoHNpfNNWXtGttuW4mYm
        HOpcs0xAXqybGrKHnNUY7zDJXvGQsQGg3GrO1GJfPp5J98pGO+p3zDfpCEVgQoxtg/DmXL
        yWhKqDWfIpuFMvppypjs6Ti4uNhibuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656080260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03tWAhpXCmNzUiHfSiKw+1BZE8rrRfRXxeC/0KmMbDU=;
        b=tdXxB4KOOuwPS5BAXwyix1T1swKE8fPh7X2EjqfrZNp2unEj9Biq5+3IuibvjMuzUDyBXI
        MaQE/LhOgbti9eCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A17D313B4B;
        Fri, 24 Jun 2022 14:17:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uEEHJ4THtWKoHQAAMHmgww
        (envelope-from <iivanov@suse.de>); Fri, 24 Jun 2022 14:17:40 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH 1/1] arm64: Add initial set of stack unwinder self tests
Date:   Fri, 24 Jun 2022 17:10:00 +0300
Message-Id: <20220624141000.88120-2-iivanov@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220624141000.88120-1-iivanov@suse.de>
References: <20220624141000.88120-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kunit tests for obvious cases where stack unwind could be needed.
Like these:

 * Unwind a separate task
 * Unwind starting from caller
 * Unwind from irq context
 * Unwind from kprobe handler called via ftrace
 * Unwind from ftrace handler
 * Unwind through kretprobed function
 * Unwind from kretprobe handler

Tests are completely based on code used in s390 unwinder tests.
Cases which where not relevant to aarch64 where removed and
some places where adjusted to address aarch64 specifics.

Cc: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 arch/arm64/Kconfig.debug        |  12 +
 arch/arm64/kernel/Makefile      |   1 +
 arch/arm64/kernel/stacktrace.c  |  23 ++
 arch/arm64/kernel/test_unwind.c | 518 ++++++++++++++++++++++++++++++++
 include/linux/stacktrace.h      |   1 +
 5 files changed, 555 insertions(+)
 create mode 100644 arch/arm64/kernel/test_unwind.c

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 265c4461031f..a48ab884754e 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -20,4 +20,16 @@ config ARM64_RELOC_TEST
 	depends on m
 	tristate "Relocation testing module"
 
+config ARM64_UNWIND_SELFTEST
+	def_tristate n
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	prompt "Test unwind functions"
+	help
+	  This option enables aarch64 specific stack unwinder testing kernel
+	  module. This option is not useful for distributions or general
+	  kernels, but only for kernel developers working on architecture code.
+
+	  Say N if you are unsure.
+
 source "drivers/hwtracing/coresight/Kconfig"
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index fa7981d0d917..014da14dd25c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
 obj-y					+= vdso-wrap.o
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
+obj-$(CONFIG_ARM64_UNWIND_SELFTEST)	+= test_unwind.o
 
 # Force dependency (vdso*-wrap.S includes vdso.so through incbin)
 $(obj)/vdso-wrap.o: $(obj)/vdso/vdso.so
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 8016ba0e2c96..6dc39b356cc2 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -406,3 +406,26 @@ noinline int notrace arch_stack_walk_reliable(
 	reliable = unwind(&state, consume_entry, cookie);
 	return reliable ? 0 : -EINVAL;
 }
+
+#if IS_ENABLED(CONFIG_ARM64_UNWIND_SELFTEST)
+noinline notrace int test_arch_stack_walk(stack_trace_consume_fn consume_entry,
+					  void *cookie,
+					  struct task_struct *task,
+					  struct pt_regs *regs)
+{
+	struct unwind_state state;
+
+	if (regs) {
+		if (task != current)
+			return -EINVAL;
+		unwind_init_from_regs(&state, regs);
+	} else if (task == current) {
+		unwind_init_from_caller(&state);
+	} else {
+		unwind_init_from_task(&state, task);
+	}
+
+	return unwind(&state, consume_entry, cookie) ? 0 : -EINVAL;
+}
+EXPORT_SYMBOL_GPL(test_arch_stack_walk);
+#endif
diff --git a/arch/arm64/kernel/test_unwind.c b/arch/arm64/kernel/test_unwind.c
new file mode 100644
index 000000000000..fc09400f3d12
--- /dev/null
+++ b/arch/arm64/kernel/test_unwind.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test module for aarch64 stack unwinder functionality.
+ * Based on s390 unwinder tests.
+ */
+
+#include <kunit/test.h>
+#include <linux/completion.h>
+#include <linux/kallsyms.h>
+#include <linux/kthread.h>
+#include <linux/ftrace.h>
+#include <linux/module.h>
+#include <linux/timer.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/kprobes.h>
+#include <linux/wait.h>
+#include <asm/irq.h>
+#include <asm/stacktrace.h>
+
+static struct kunit *current_test;
+
+#define BT_BUF_SIZE (PAGE_SIZE * 4)
+
+static bool force_bt;
+module_param_named(backtrace, force_bt, bool, 0444);
+MODULE_PARM_DESC(backtrace, "print backtraces for all tests");
+
+struct unwind_tracker {
+	int frame_count;
+	int prev_is_func2;
+	int seen_func2_func1;
+	int seen_kretprobe_trampoline;
+	char *bt_buff;
+	size_t bt_pos;
+};
+
+/*
+ * To avoid printk line limit split backtrace by lines
+ */
+static void print_backtrace(char *bt)
+{
+	char *p;
+
+	while (true) {
+		p = strsep(&bt, "\n");
+		if (!p)
+			break;
+		kunit_err(current_test, "%s\n", p);
+	}
+}
+
+static bool check_backtrace_entry(void *arg, unsigned long addr)
+{
+	struct unwind_tracker *tracker = arg;
+	const int max_frames = 128;
+	char sym[KSYM_SYMBOL_LEN];
+
+	if (tracker->frame_count++ == max_frames) {
+		kunit_err(current_test, "stack too deep\n");
+		return false;
+	}
+
+	if (!addr) {
+		kunit_err(current_test, "addr is 0\n");
+		return false;
+	}
+
+	sprint_symbol(sym, addr);
+	if (tracker->prev_is_func2 && str_has_prefix(sym, "unwindme_func1"))
+		tracker->seen_func2_func1 = 1;
+
+	tracker->prev_is_func2 = str_has_prefix(sym, "unwindme_func2");
+
+	if (str_has_prefix(sym, "__kretprobe_trampoline+0x0/"))
+		tracker->seen_kretprobe_trampoline = 1;
+
+	if (tracker->bt_pos >= BT_BUF_SIZE) {
+		kunit_err(current_test, "backtrace buffer is too small\n");
+		return true;
+	}
+
+	tracker->bt_pos += snprintf(tracker->bt_buff + tracker->bt_pos,
+				    BT_BUF_SIZE - tracker->bt_pos, " %pSR\n",
+				    (void *)addr);
+	return true;
+}
+
+int test_arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+			 struct task_struct *task, struct pt_regs *regs);
+
+/*
+ * Calls test_arch_stack_walk() which is handy wrapper of aarch64 unwind
+ * functionality, and verifies that the result contains unwindme_func2
+ *followed by unwindme_func1.
+ */
+static noinline int test_unwind(struct task_struct *task, struct pt_regs *regs)
+{
+	struct unwind_tracker tracker;
+	int ret = 0;
+
+	/* Unwind. */
+	tracker.frame_count = 0;
+	tracker.prev_is_func2 = 0;
+	tracker.seen_func2_func1 = 0;
+	tracker.seen_kretprobe_trampoline = 0;
+
+	tracker.bt_pos = 0;
+	tracker.bt_buff = kmalloc(BT_BUF_SIZE, GFP_ATOMIC);
+	if (!tracker.bt_buff) {
+		kunit_err(current_test,
+			  "failed to allocate backtrace buffer\n");
+		return -ENOMEM;
+	}
+
+	ret = test_arch_stack_walk(check_backtrace_entry, &tracker, task, regs);
+
+	if (!tracker.seen_func2_func1) {
+		kunit_err(current_test,
+			  "unwindme_func2 and unwindme_func1 not found\n");
+		ret = -EINVAL;
+	}
+	if (tracker.frame_count == 128) {
+		kunit_err(current_test, "Maximum number of frames exceeded\n");
+		ret = -EINVAL;
+	}
+	if (tracker.seen_kretprobe_trampoline) {
+		kunit_err(current_test,
+			  "__kretprobe_trampoline+0x0 in unwinding results\n");
+		ret = -EINVAL;
+	}
+
+	if (ret || force_bt)
+		print_backtrace(tracker.bt_buff);
+
+	kfree(tracker.bt_buff);
+	return ret;
+}
+
+/* State of the task being unwound. */
+struct unwindme {
+	int flags;
+	int ret;
+	struct task_struct *task;
+	struct completion task_ready;
+	wait_queue_head_t task_wq;
+};
+
+static struct unwindme *unwindme;
+
+/* Values of unwindme.flags. */
+#define UWM_DEFAULT		0x0
+#define UWM_THREAD		0x1	/* Unwind a separate task. */
+#define UWM_REGS		0x2	/* Pass regs to test_unwind(). */
+#define UWM_CALLER		0x8	/* Unwind starting from caller. */
+#define UWM_IRQ			0x20	/* Unwind from irq context. */
+#define UWM_KPROBE_ON_FTRACE	0x80	/* Unwind from kprobe handler called via ftrace. */
+#define UWM_FTRACE		0x100	/* Unwind from ftrace handler. */
+#define UWM_KRETPROBE		0x200	/* Unwind through kretprobed function. */
+#define UWM_KRETPROBE_HANDLER	0x400	/* Unwind from kretprobe handler. */
+
+static notrace noinline struct pt_regs fake_pt_regs(void)
+{
+	struct pt_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+
+	regs.regs[29] = (unsigned long)__builtin_frame_address(1);
+	regs.pc = (unsigned long)__builtin_return_address(0);
+
+	return regs;
+}
+
+static int kretprobe_ret_handler(struct kretprobe_instance *ri,
+				 struct pt_regs *regs)
+{
+	struct unwindme *u = unwindme;
+
+	if (!(u->flags & UWM_KRETPROBE_HANDLER))
+		return 0;
+
+	u->ret = test_unwind(current, (u->flags & UWM_REGS) ? regs : NULL);
+
+	return 0;
+}
+
+static noinline notrace int test_unwind_kretprobed_func(struct unwindme *u)
+{
+	struct pt_regs regs;
+
+	if (!(u->flags & UWM_KRETPROBE))
+		return 0;
+
+	regs = fake_pt_regs();
+	return test_unwind(current, (u->flags & UWM_REGS) ? &regs : NULL);
+}
+
+static noinline int test_unwind_kretprobed_func_caller(struct unwindme *u)
+{
+	return test_unwind_kretprobed_func(u);
+}
+
+static int test_unwind_kretprobe(struct unwindme *u)
+{
+	int ret;
+	struct kretprobe my_kretprobe;
+
+	if (!IS_ENABLED(CONFIG_KPROBES))
+		kunit_skip(current_test, "requires CONFIG_KPROBES");
+
+	u->ret = -1; /* make sure kprobe is called */
+	unwindme = u;
+
+	memset(&my_kretprobe, 0, sizeof(my_kretprobe));
+	my_kretprobe.handler = kretprobe_ret_handler;
+	my_kretprobe.maxactive = 1;
+	my_kretprobe.kp.addr = (kprobe_opcode_t *)test_unwind_kretprobed_func;
+
+	ret = register_kretprobe(&my_kretprobe);
+
+	if (ret < 0) {
+		kunit_err(current_test, "register_kretprobe failed %d\n", ret);
+		return -EINVAL;
+	}
+
+	ret = test_unwind_kretprobed_func_caller(u);
+	unregister_kretprobe(&my_kretprobe);
+	unwindme = NULL;
+	if (u->flags & UWM_KRETPROBE_HANDLER)
+		ret = u->ret;
+	return ret;
+}
+
+static int kprobe_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct unwindme *u = unwindme;
+
+	u->ret = test_unwind(current, (u->flags & UWM_REGS) ? regs : NULL);
+	return 0;
+}
+
+extern const char test_unwind_kprobed_insn[];
+
+static noinline void test_unwind_kprobed_func(void)
+{
+	asm volatile("	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "test_unwind_kprobed_insn:\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     "	nop\n"
+		     :);
+}
+
+static int test_unwind_kprobe(struct unwindme *u)
+{
+	struct kprobe kp;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_KPROBES))
+		kunit_skip(current_test, "requires CONFIG_KPROBES");
+	if (!IS_ENABLED(CONFIG_KPROBES_ON_FTRACE) &&
+	    u->flags & UWM_KPROBE_ON_FTRACE)
+		kunit_skip(current_test, "requires CONFIG_KPROBES_ON_FTRACE");
+
+	u->ret = -1; /* make sure kprobe is called */
+	unwindme = u;
+	memset(&kp, 0, sizeof(kp));
+	kp.pre_handler = kprobe_pre_handler;
+	kp.addr = u->flags & UWM_KPROBE_ON_FTRACE ?
+			  (kprobe_opcode_t *)test_unwind_kprobed_func :
+			  (kprobe_opcode_t *)test_unwind_kprobed_insn;
+	ret = register_kprobe(&kp);
+	if (ret < 0) {
+		kunit_err(current_test, "register_kprobe failed %d\n", ret);
+		return -EINVAL;
+	}
+
+	test_unwind_kprobed_func();
+	unregister_kprobe(&kp);
+	unwindme = NULL;
+	return u->ret;
+}
+
+static void notrace __used test_unwind_ftrace_handler(unsigned long ip,
+						      unsigned long parent_ip,
+						      struct ftrace_ops *fops,
+						      struct ftrace_regs *fregs)
+{
+	struct unwindme *u = (struct unwindme *)fregs->regs.regs[0];
+
+	u->ret = test_unwind(current,
+			     (u->flags & UWM_REGS) ? &fregs->regs : NULL);
+}
+
+static noinline int test_unwind_ftraced_func(struct unwindme *u)
+{
+	return READ_ONCE(u)->ret;
+}
+
+static int test_unwind_ftrace(struct unwindme *u)
+{
+	int ret;
+#ifdef CONFIG_DYNAMIC_FTRACE
+	struct ftrace_ops *fops;
+
+	fops = kunit_kzalloc(current_test, sizeof(*fops), GFP_KERNEL);
+	fops->func = test_unwind_ftrace_handler;
+	fops->flags = FTRACE_OPS_FL_DYNAMIC | FTRACE_OPS_FL_RECURSION |
+		      FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_PERMANENT;
+#else
+	kunit_skip(current_test, "requires CONFIG_DYNAMIC_FTRACE");
+#endif
+
+	ret = ftrace_set_filter_ip(
+		fops, (unsigned long)test_unwind_ftraced_func, 0, 0);
+	if (ret) {
+		kunit_err(current_test, "failed to set ftrace filter (%d)\n",
+			  ret);
+		return -1;
+	}
+
+	ret = register_ftrace_function(fops);
+	if (!ret) {
+		ret = test_unwind_ftraced_func(u);
+		unregister_ftrace_function(fops);
+	} else {
+		kunit_err(current_test,
+			  "failed to register ftrace handler (%d)\n", ret);
+	}
+
+	ftrace_set_filter_ip(fops, (unsigned long)test_unwind_ftraced_func, 1,
+			     0);
+	return ret;
+}
+
+/* This function may or may not appear in the backtrace. */
+static noinline int unwindme_func4(struct unwindme *u, struct pt_regs *regs)
+{
+	if (!(u->flags & UWM_CALLER))
+		*regs = fake_pt_regs();
+	if (u->flags & UWM_THREAD) {
+		complete(&u->task_ready);
+		wait_event(u->task_wq, kthread_should_park());
+		kthread_parkme();
+		return 0;
+	} else if (u->flags & (UWM_KPROBE_ON_FTRACE)) {
+		return test_unwind_kprobe(u);
+	} else if (u->flags & (UWM_KRETPROBE | UWM_KRETPROBE_HANDLER)) {
+		return test_unwind_kretprobe(u);
+	} else if (u->flags & UWM_FTRACE) {
+		return test_unwind_ftrace(u);
+	} else {
+		return test_unwind(current, (u->flags & UWM_REGS) ? regs : NULL);
+	}
+}
+
+/* This function may or may not appear in the backtrace. */
+static noinline int unwindme_func3(struct unwindme *u)
+{
+	struct pt_regs regs;
+
+	regs = fake_pt_regs();
+	return unwindme_func4(u, &regs);
+}
+
+/* This function must appear in the backtrace. */
+static noinline int unwindme_func2(struct unwindme *u)
+{
+	return unwindme_func3(u);
+}
+
+/* This function must follow unwindme_func2 in the backtrace. */
+static noinline int unwindme_func1(void *u)
+{
+	return unwindme_func2((struct unwindme *)u);
+}
+
+static void unwindme_timer_fn(struct timer_list *unused)
+{
+	struct unwindme *u = READ_ONCE(unwindme);
+
+	if (u) {
+		unwindme = NULL;
+		u->task = NULL;
+		u->ret = unwindme_func1(u);
+		complete(&u->task_ready);
+	}
+}
+
+static struct timer_list unwind_timer;
+
+static int test_unwind_irq(struct unwindme *u)
+{
+	unwindme = u;
+	init_completion(&u->task_ready);
+	timer_setup(&unwind_timer, unwindme_timer_fn, 0);
+	mod_timer(&unwind_timer, jiffies + 1);
+	wait_for_completion(&u->task_ready);
+	return u->ret;
+}
+
+/* Spawns a task and passes it to test_unwind(). */
+static int test_unwind_task(struct unwindme *u)
+{
+	struct task_struct *task;
+	int ret;
+
+	/* Initialize thread-related fields. */
+	init_completion(&u->task_ready);
+	init_waitqueue_head(&u->task_wq);
+
+	/*
+	 * Start the task and wait until it reaches unwindme_func4() and sleeps
+	 * in (task_ready, unwind_done] range.
+	 */
+	task = kthread_run(unwindme_func1, u, "test_unwind_task");
+	if (IS_ERR(task)) {
+		kunit_err(current_test, "kthread_run() failed\n");
+		return PTR_ERR(task);
+	}
+
+	/*
+	 * Make sure task reaches unwindme_func4 before parking it,
+	 * we might park it before kthread function has been executed otherwise
+	 */
+	wait_for_completion(&u->task_ready);
+	kthread_park(task);
+	/* Unwind. */
+	ret = test_unwind(task, NULL);
+	kthread_stop(task);
+	return ret;
+}
+
+struct test_params {
+	int flags;
+	char *name;
+};
+
+/*
+ * Create required parameter list for tests
+ */
+#define TEST_WITH_FLAGS(f)	{ .flags = f, .name = #f }
+static const struct test_params param_list[] = {
+	TEST_WITH_FLAGS(UWM_DEFAULT),
+	TEST_WITH_FLAGS(UWM_REGS),
+	TEST_WITH_FLAGS(UWM_CALLER),
+	TEST_WITH_FLAGS(UWM_CALLER | UWM_REGS),
+	TEST_WITH_FLAGS(UWM_THREAD),
+	TEST_WITH_FLAGS(UWM_THREAD | UWM_CALLER),
+	TEST_WITH_FLAGS(UWM_IRQ),
+	TEST_WITH_FLAGS(UWM_IRQ | UWM_REGS),
+	TEST_WITH_FLAGS(UWM_IRQ | UWM_CALLER),
+	TEST_WITH_FLAGS(UWM_IRQ | UWM_CALLER | UWM_REGS),
+	TEST_WITH_FLAGS(UWM_REGS),
+	TEST_WITH_FLAGS(UWM_KPROBE_ON_FTRACE),
+	TEST_WITH_FLAGS(UWM_KPROBE_ON_FTRACE | UWM_REGS),
+	TEST_WITH_FLAGS(UWM_FTRACE),
+	TEST_WITH_FLAGS(UWM_FTRACE | UWM_REGS),
+	TEST_WITH_FLAGS(UWM_KRETPROBE),
+	TEST_WITH_FLAGS(UWM_KRETPROBE | UWM_REGS),
+	TEST_WITH_FLAGS(UWM_KRETPROBE_HANDLER),
+	TEST_WITH_FLAGS(UWM_KRETPROBE_HANDLER | UWM_REGS),
+};
+
+/*
+ * Parameter description generator: required for KUNIT_ARRAY_PARAM()
+ */
+static void get_desc(const struct test_params *params, char *desc)
+{
+	strscpy(desc, params->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+/*
+ * Create test_unwind_gen_params
+ */
+KUNIT_ARRAY_PARAM(test_unwind, param_list, get_desc);
+
+static void test_unwind_flags(struct kunit *test)
+{
+	struct unwindme u;
+	const struct test_params *params;
+
+	current_test = test;
+	params = (const struct test_params *)test->param_value;
+	u.flags = params->flags;
+	if (u.flags & UWM_THREAD)
+		KUNIT_EXPECT_EQ(test, 0, test_unwind_task(&u));
+	else if (u.flags & UWM_IRQ)
+		KUNIT_EXPECT_EQ(test, 0, test_unwind_irq(&u));
+	else
+		KUNIT_EXPECT_EQ(test, 0, unwindme_func1(&u));
+}
+
+static struct kunit_case unwind_test_cases[] = {
+	KUNIT_CASE_PARAM(test_unwind_flags, test_unwind_gen_params),
+	{}
+};
+
+static struct kunit_suite test_unwind_suite = {
+	.name = "test_unwind",
+	.test_cases = unwind_test_cases,
+};
+
+kunit_test_suites(&test_unwind_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 97455880ac41..3262c6875176 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -60,6 +60,7 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
 
 void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			  const struct pt_regs *regs);
+
 #endif /* CONFIG_ARCH_STACKWALK */
 
 #ifdef CONFIG_STACKTRACE
-- 
2.35.3

