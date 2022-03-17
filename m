Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AEE4DC9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiCQP1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiCQP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:26:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B02205BDA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E817A6196B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FB9C3410A;
        Thu, 17 Mar 2022 15:25:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUs0B-004zhx-QC;
        Thu, 17 Mar 2022 11:25:23 -0400
Message-ID: <20220317152523.643326783@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 17 Mar 2022 11:25:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 10/13] fprobe: Add sample program for fprobe
References: <20220317152458.213689956@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a sample program for the fprobe. The sample_fprobe puts a fprobe on
kernel_clone() by default. This dump stack and some called address info
at the function entry and exit.

The sample_fprobe.ko gets 2 parameters.
- symbol: you can specify the comma separated symbols or wildcard symbol
  pattern (in this case you can not use comma)
- stackdump: a bool value to enable or disable stack dump in the fprobe
  handler.

Link: https://lkml.kernel.org/r/164735291987.1084943.4449670993752806840.stgit@devnote2

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/Kconfig                 |   7 ++
 samples/Makefile                |   1 +
 samples/fprobe/Makefile         |   3 +
 samples/fprobe/fprobe_example.c | 120 ++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 samples/fprobe/Makefile
 create mode 100644 samples/fprobe/fprobe_example.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 10e021c72282..470ee3baf2e1 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -79,6 +79,13 @@ config SAMPLE_HW_BREAKPOINT
 	help
 	  This builds kernel hardware breakpoint example modules.
 
+config SAMPLE_FPROBE
+	tristate "Build fprobe examples -- loadable modules only"
+	depends on FPROBE && m
+	help
+	  This builds a fprobe example module. This module has an option 'symbol'.
+	  You can specify a probed symbol or symbols separated with ','.
+
 config SAMPLE_KFIFO
 	tristate "Build kfifo examples -- loadable modules only"
 	depends on m
diff --git a/samples/Makefile b/samples/Makefile
index 448343e8faeb..701e912ab5af 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -34,3 +34,4 @@ subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
+obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
diff --git a/samples/fprobe/Makefile b/samples/fprobe/Makefile
new file mode 100644
index 000000000000..ecccbfa6e99b
--- /dev/null
+++ b/samples/fprobe/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SAMPLE_FPROBE) += fprobe_example.o
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
new file mode 100644
index 000000000000..24d3cf109140
--- /dev/null
+++ b/samples/fprobe/fprobe_example.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Here's a sample kernel module showing the use of fprobe to dump a
+ * stack trace and selected registers when kernel_clone() is called.
+ *
+ * For more information on theory of operation of kprobes, see
+ * Documentation/trace/kprobes.rst
+ *
+ * You will see the trace data in /var/log/messages and on the console
+ * whenever kernel_clone() is invoked to create a new process.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fprobe.h>
+#include <linux/sched/debug.h>
+#include <linux/slab.h>
+
+#define BACKTRACE_DEPTH 16
+#define MAX_SYMBOL_LEN 4096
+struct fprobe sample_probe;
+
+static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
+module_param_string(symbol, symbol, sizeof(symbol), 0644);
+static char nosymbol[MAX_SYMBOL_LEN] = "";
+module_param_string(nosymbol, nosymbol, sizeof(nosymbol), 0644);
+static bool stackdump = true;
+module_param(stackdump, bool, 0644);
+
+static void show_backtrace(void)
+{
+	unsigned long stacks[BACKTRACE_DEPTH];
+	unsigned int len;
+
+	len = stack_trace_save(stacks, BACKTRACE_DEPTH, 2);
+	stack_trace_print(stacks, len, 24);
+}
+
+static void sample_entry_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs)
+{
+	pr_info("Enter <%pS> ip = 0x%p\n", (void *)ip, (void *)ip);
+	if (stackdump)
+		show_backtrace();
+}
+
+static void sample_exit_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs)
+{
+	unsigned long rip = instruction_pointer(regs);
+
+	pr_info("Return from <%pS> ip = 0x%p to rip = 0x%p (%pS)\n",
+		(void *)ip, (void *)ip, (void *)rip, (void *)rip);
+	if (stackdump)
+		show_backtrace();
+}
+
+static int __init fprobe_init(void)
+{
+	char *p, *symbuf = NULL;
+	const char **syms;
+	int ret, count, i;
+
+	sample_probe.entry_handler = sample_entry_handler;
+	sample_probe.exit_handler = sample_exit_handler;
+
+	if (strchr(symbol, '*')) {
+		/* filter based fprobe */
+		ret = register_fprobe(&sample_probe, symbol,
+				      nosymbol[0] == '\0' ? NULL : nosymbol);
+		goto out;
+	} else if (!strchr(symbol, ',')) {
+		symbuf = symbol;
+		ret = register_fprobe_syms(&sample_probe, (const char **)&symbuf, 1);
+		goto out;
+	}
+
+	/* Comma separated symbols */
+	symbuf = kstrdup(symbol, GFP_KERNEL);
+	if (!symbuf)
+		return -ENOMEM;
+	p = symbuf;
+	count = 1;
+	while ((p = strchr(++p, ',')) != NULL)
+		count++;
+
+	pr_info("%d symbols found\n", count);
+
+	syms = kcalloc(count, sizeof(char *), GFP_KERNEL);
+	if (!syms) {
+		kfree(symbuf);
+		return -ENOMEM;
+	}
+
+	p = symbuf;
+	for (i = 0; i < count; i++)
+		syms[i] = strsep(&p, ",");
+
+	ret = register_fprobe_syms(&sample_probe, syms, count);
+	kfree(syms);
+	kfree(symbuf);
+out:
+	if (ret < 0)
+		pr_err("register_fprobe failed, returned %d\n", ret);
+	else
+		pr_info("Planted fprobe at %s\n", symbol);
+
+	return ret;
+}
+
+static void __exit fprobe_exit(void)
+{
+	unregister_fprobe(&sample_probe);
+
+	pr_info("fprobe at %s unregistered\n", symbol);
+}
+
+module_init(fprobe_init)
+module_exit(fprobe_exit)
+MODULE_LICENSE("GPL");
-- 
2.35.1
