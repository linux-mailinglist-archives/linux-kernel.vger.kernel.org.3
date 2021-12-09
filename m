Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6946EB50
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbhLIPgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbhLIPgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:36:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49461C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:32:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1457CB82489
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6342C341D1;
        Thu,  9 Dec 2021 15:32:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mvLPE-000SyG-0H;
        Thu, 09 Dec 2021 10:32:24 -0500
Message-ID: <20211209153223.843082247@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 09 Dec 2021 10:29:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-linus][PATCH 5/5] ftrace/samples: Add module to test multi direct modify interface
References: <20211209152908.459494269@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Adding ftrace-direct-multi-modify.ko kernel module that uses
modify_ftrace_direct_multi API. The core functionality is taken
from ftrace-direct-modify.ko kernel module and changed to fit
multi direct interface.

The init function creates kthread that periodically calls
modify_ftrace_direct_multi to change the trampoline address
for the direct ftrace_ops. The ftrace trace_pipe then shows
trace from both trampolines.

Link: https://lkml.kernel.org/r/20211206182032.87248-4-jolsa@kernel.org

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/ftrace/Makefile                     |   1 +
 samples/ftrace/ftrace-direct-multi-modify.c | 152 ++++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 samples/ftrace/ftrace-direct-multi-modify.c

diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index b9198e2eef28..faf8cdb79c5f 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace-direct-multi.o
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace-direct-multi-modify.o
 
 CFLAGS_sample-trace-array.o := -I$(src)
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
new file mode 100644
index 000000000000..91bc42a7adb9
--- /dev/null
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/ftrace.h>
+#include <asm/asm-offsets.h>
+
+void my_direct_func1(unsigned long ip)
+{
+	trace_printk("my direct func1 ip %lx\n", ip);
+}
+
+void my_direct_func2(unsigned long ip)
+{
+	trace_printk("my direct func2 ip %lx\n", ip);
+}
+
+extern void my_tramp1(void *);
+extern void my_tramp2(void *);
+
+#ifdef CONFIG_X86_64
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	pushq %rdi\n"
+"	movq 8(%rbp), %rdi\n"
+"	call my_direct_func1\n"
+"	popq %rdi\n"
+"	leave\n"
+"	ret\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+"	.type		my_tramp2, @function\n"
+"\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	pushq %rdi\n"
+"	movq 8(%rbp), %rdi\n"
+"	call my_direct_func2\n"
+"	popq %rdi\n"
+"	leave\n"
+"	ret\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_X86_64 */
+
+#ifdef CONFIG_S390
+
+asm (
+"       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp1, @function\n"
+"       .globl          my_tramp1\n"
+"   my_tramp1:"
+"       lgr             %r1,%r15\n"
+"       stmg            %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       stg             %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       aghi            %r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"       stg             %r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"       lgr             %r2,%r0\n"
+"       brasl           %r14,my_direct_func1\n"
+"       aghi            %r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"       lmg             %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       lg              %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       lgr             %r1,%r0\n"
+"       br              %r1\n"
+"       .size           my_tramp1, .-my_tramp1\n"
+"\n"
+"       .type           my_tramp2, @function\n"
+"       .globl          my_tramp2\n"
+"   my_tramp2:"
+"       lgr             %r1,%r15\n"
+"       stmg            %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       stg             %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       aghi            %r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"       stg             %r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"       lgr             %r2,%r0\n"
+"       brasl           %r14,my_direct_func2\n"
+"       aghi            %r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"       lmg             %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       lg              %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       lgr             %r1,%r0\n"
+"       br              %r1\n"
+"       .size           my_tramp2, .-my_tramp2\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_S390 */
+
+static unsigned long my_tramp = (unsigned long)my_tramp1;
+static unsigned long tramps[2] = {
+	(unsigned long)my_tramp1,
+	(unsigned long)my_tramp2,
+};
+
+static struct ftrace_ops direct;
+
+static int simple_thread(void *arg)
+{
+	static int t;
+	int ret = 0;
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(2 * HZ);
+
+		if (ret)
+			continue;
+		t ^= 1;
+		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
+		if (!ret)
+			my_tramp = tramps[t];
+		WARN_ON_ONCE(ret);
+	}
+
+	return 0;
+}
+
+static struct task_struct *simple_tsk;
+
+static int __init ftrace_direct_multi_init(void)
+{
+	int ret;
+
+	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
+	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
+
+	ret = register_ftrace_direct_multi(&direct, my_tramp);
+
+	if (!ret)
+		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
+	return ret;
+}
+
+static void __exit ftrace_direct_multi_exit(void)
+{
+	kthread_stop(simple_tsk);
+	unregister_ftrace_direct_multi(&direct, my_tramp);
+}
+
+module_init(ftrace_direct_multi_init);
+module_exit(ftrace_direct_multi_exit);
+
+MODULE_AUTHOR("Jiri Olsa");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
+MODULE_LICENSE("GPL");
-- 
2.33.0
