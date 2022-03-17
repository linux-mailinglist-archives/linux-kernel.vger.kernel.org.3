Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3683B4DC9EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiCQP0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiCQP0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75FE205BDC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD5B6195A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70653C340F6;
        Thu, 17 Mar 2022 15:25:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUs0A-004ze3-Eg;
        Thu, 17 Mar 2022 11:25:22 -0400
Message-ID: <20220317152522.284233550@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 17 Mar 2022 11:25:01 -0400
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
Subject: [for-next][PATCH 03/13] fprobe: Add ftrace based probe APIs
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

The fprobe is a wrapper API for ftrace function tracer.
Unlike kprobes, this probes only supports the function entry, but this
can probe multiple functions by one fprobe. The usage is similar, user
will set their callback to fprobe::entry_handler and call
register_fprobe*() with probed functions.
There are 3 registration interfaces,

 - register_fprobe() takes filtering patterns of the functin names.
 - register_fprobe_ips() takes an array of ftrace-location addresses.
 - register_fprobe_syms() takes an array of function names.

The registered fprobes can be unregistered with unregister_fprobe().
e.g.

struct fprobe fp = { .entry_handler = user_handler };
const char *targets[] = { "func1", "func2", "func3"};
...

ret = register_fprobe_syms(&fp, targets, ARRAY_SIZE(targets));

...

unregister_fprobe(&fp);

Link: https://lkml.kernel.org/r/164735283857.1084943.1154436951479395551.stgit@devnote2

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
 include/linux/fprobe.h |  87 +++++++++++++++++
 kernel/trace/Kconfig   |  12 +++
 kernel/trace/Makefile  |   1 +
 kernel/trace/fprobe.c  | 211 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 include/linux/fprobe.h
 create mode 100644 kernel/trace/fprobe.c

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
new file mode 100644
index 000000000000..2ba099aff041
--- /dev/null
+++ b/include/linux/fprobe.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Simple ftrace probe wrapper */
+#ifndef _LINUX_FPROBE_H
+#define _LINUX_FPROBE_H
+
+#include <linux/compiler.h>
+#include <linux/ftrace.h>
+
+/**
+ * struct fprobe - ftrace based probe.
+ * @ops: The ftrace_ops.
+ * @nmissed: The counter for missing events.
+ * @flags: The status flag.
+ * @entry_handler: The callback function for function entry.
+ */
+struct fprobe {
+#ifdef CONFIG_FUNCTION_TRACER
+	/*
+	 * If CONFIG_FUNCTION_TRACER is not set, CONFIG_FPROBE is disabled too.
+	 * But user of fprobe may keep embedding the struct fprobe on their own
+	 * code. To avoid build error, this will keep the fprobe data structure
+	 * defined here, but remove ftrace_ops data structure.
+	 */
+	struct ftrace_ops	ops;
+#endif
+	unsigned long		nmissed;
+	unsigned int		flags;
+	void (*entry_handler)(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
+};
+
+#define FPROBE_FL_DISABLED	1
+
+static inline bool fprobe_disabled(struct fprobe *fp)
+{
+	return (fp) ? fp->flags & FPROBE_FL_DISABLED : false;
+}
+
+#ifdef CONFIG_FPROBE
+int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter);
+int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
+int register_fprobe_syms(struct fprobe *fp, const char **syms, int num);
+int unregister_fprobe(struct fprobe *fp);
+#else
+static inline int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
+{
+	return -EOPNOTSUPP;
+}
+static inline int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
+{
+	return -EOPNOTSUPP;
+}
+static inline int register_fprobe_syms(struct fprobe *fp, const char **syms, int num)
+{
+	return -EOPNOTSUPP;
+}
+static inline int unregister_fprobe(struct fprobe *fp)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+/**
+ * disable_fprobe() - Disable fprobe
+ * @fp: The fprobe to be disabled.
+ *
+ * This will soft-disable @fp. Note that this doesn't remove the ftrace
+ * hooks from the function entry.
+ */
+static inline void disable_fprobe(struct fprobe *fp)
+{
+	if (fp)
+		fp->flags |= FPROBE_FL_DISABLED;
+}
+
+/**
+ * enable_fprobe() - Enable fprobe
+ * @fp: The fprobe to be enabled.
+ *
+ * This will soft-enable @fp.
+ */
+static inline void enable_fprobe(struct fprobe *fp)
+{
+	if (fp)
+		fp->flags &= ~FPROBE_FL_DISABLED;
+}
+
+#endif
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 16a52a71732d..79d3e8e5a167 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -236,6 +236,18 @@ config DYNAMIC_FTRACE_WITH_ARGS
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
+config FPROBE
+	bool "Kernel Function Probe (fprobe)"
+	depends on FUNCTION_TRACER
+	depends on DYNAMIC_FTRACE_WITH_REGS
+	default n
+	help
+	  This option enables kernel function probe (fprobe) based on ftrace,
+	  which is similar to kprobes, but probes only for kernel function
+	  entries and it can probe multiple functions by one fprobe.
+
+	  If unsure, say N.
+
 config FUNCTION_PROFILER
 	bool "Kernel function profiler"
 	depends on FUNCTION_TRACER
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 19ef3758da95..cb6245da30bb 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
+obj-$(CONFIG_FPROBE) += fprobe.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
new file mode 100644
index 000000000000..7e8ceee339a0
--- /dev/null
+++ b/kernel/trace/fprobe.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fprobe - Simple ftrace probe wrapper for function entry.
+ */
+#define pr_fmt(fmt) "fprobe: " fmt
+
+#include <linux/err.h>
+#include <linux/fprobe.h>
+#include <linux/kallsyms.h>
+#include <linux/kprobes.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
+
+static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe *fp;
+	int bit;
+
+	fp = container_of(ops, struct fprobe, ops);
+	if (fprobe_disabled(fp))
+		return;
+
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
+
+	if (fp->entry_handler)
+		fp->entry_handler(fp, ip, ftrace_get_regs(fregs));
+
+	ftrace_test_recursion_unlock(bit);
+}
+NOKPROBE_SYMBOL(fprobe_handler);
+
+/* Convert ftrace location address from symbols */
+static unsigned long *get_ftrace_locations(const char **syms, int num)
+{
+	unsigned long addr, size;
+	unsigned long *addrs;
+	int i;
+
+	/* Convert symbols to symbol address */
+	addrs = kcalloc(num, sizeof(*addrs), GFP_KERNEL);
+	if (!addrs)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < num; i++) {
+		addr = kallsyms_lookup_name(syms[i]);
+		if (!addr)	/* Maybe wrong symbol */
+			goto error;
+
+		/* Convert symbol address to ftrace location. */
+		if (!kallsyms_lookup_size_offset(addr, &size, NULL) || !size)
+			goto error;
+
+		addr = ftrace_location_range(addr, addr + size - 1);
+		if (!addr) /* No dynamic ftrace there. */
+			goto error;
+
+		addrs[i] = addr;
+	}
+
+	return addrs;
+
+error:
+	kfree(addrs);
+
+	return ERR_PTR(-ENOENT);
+}
+
+static void fprobe_init(struct fprobe *fp)
+{
+	fp->nmissed = 0;
+	fp->ops.func = fprobe_handler;
+	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
+}
+
+/**
+ * register_fprobe() - Register fprobe to ftrace by pattern.
+ * @fp: A fprobe data structure to be registered.
+ * @filter: A wildcard pattern of probed symbols.
+ * @notfilter: A wildcard pattern of NOT probed symbols.
+ *
+ * Register @fp to ftrace for enabling the probe on the symbols matched to @filter.
+ * If @notfilter is not NULL, the symbols matched the @notfilter are not probed.
+ *
+ * Return 0 if @fp is registered successfully, -errno if not.
+ */
+int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
+{
+	unsigned char *str;
+	int ret, len;
+
+	if (!fp || !filter)
+		return -EINVAL;
+
+	fprobe_init(fp);
+
+	len = strlen(filter);
+	str = kstrdup(filter, GFP_KERNEL);
+	ret = ftrace_set_filter(&fp->ops, str, len, 0);
+	kfree(str);
+	if (ret)
+		return ret;
+
+	if (notfilter) {
+		len = strlen(notfilter);
+		str = kstrdup(notfilter, GFP_KERNEL);
+		ret = ftrace_set_notrace(&fp->ops, str, len, 0);
+		kfree(str);
+		if (ret)
+			goto out;
+	}
+
+	ret = register_ftrace_function(&fp->ops);
+out:
+	if (ret)
+		ftrace_free_filter(&fp->ops);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_fprobe);
+
+/**
+ * register_fprobe_ips() - Register fprobe to ftrace by address.
+ * @fp: A fprobe data structure to be registered.
+ * @addrs: An array of target ftrace location addresses.
+ * @num: The number of entries of @addrs.
+ *
+ * Register @fp to ftrace for enabling the probe on the address given by @addrs.
+ * The @addrs must be the addresses of ftrace location address, which may be
+ * the symbol address + arch-dependent offset.
+ * If you unsure what this mean, please use other registration functions.
+ *
+ * Return 0 if @fp is registered successfully, -errno if not.
+ */
+int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
+{
+	int ret;
+
+	if (!fp || !addrs || num <= 0)
+		return -EINVAL;
+
+	fprobe_init(fp);
+
+	ret = ftrace_set_filter_ips(&fp->ops, addrs, num, 0, 0);
+	if (!ret)
+		ret = register_ftrace_function(&fp->ops);
+
+	if (ret)
+		ftrace_free_filter(&fp->ops);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_fprobe_ips);
+
+/**
+ * register_fprobe_syms() - Register fprobe to ftrace by symbols.
+ * @fp: A fprobe data structure to be registered.
+ * @syms: An array of target symbols.
+ * @num: The number of entries of @syms.
+ *
+ * Register @fp to the symbols given by @syms array. This will be useful if
+ * you are sure the symbols exist in the kernel.
+ *
+ * Return 0 if @fp is registered successfully, -errno if not.
+ */
+int register_fprobe_syms(struct fprobe *fp, const char **syms, int num)
+{
+	unsigned long *addrs;
+	int ret;
+
+	if (!fp || !syms || num <= 0)
+		return -EINVAL;
+
+	addrs = get_ftrace_locations(syms, num);
+	if (IS_ERR(addrs))
+		return PTR_ERR(addrs);
+
+	ret = register_fprobe_ips(fp, addrs, num);
+
+	kfree(addrs);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_fprobe_syms);
+
+/**
+ * unregister_fprobe() - Unregister fprobe from ftrace
+ * @fp: A fprobe data structure to be unregistered.
+ *
+ * Unregister fprobe (and remove ftrace hooks from the function entries).
+ *
+ * Return 0 if @fp is unregistered successfully, -errno if not.
+ */
+int unregister_fprobe(struct fprobe *fp)
+{
+	int ret;
+
+	if (!fp || fp->ops.func != fprobe_handler)
+		return -EINVAL;
+
+	ret = unregister_ftrace_function(&fp->ops);
+
+	if (!ret)
+		ftrace_free_filter(&fp->ops);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(unregister_fprobe);
-- 
2.35.1
