Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B34DC9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiCQP1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiCQP0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712DD205BEA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 804B161976
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46064C36AEA;
        Thu, 17 Mar 2022 15:25:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUs0C-004zjf-CU;
        Thu, 17 Mar 2022 11:25:24 -0400
Message-ID: <20220317152524.218264673@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 17 Mar 2022 11:25:11 -0400
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
Subject: [for-next][PATCH 13/13] fprobe: Add a selftest for fprobe
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

Add a KUnit based selftest for fprobe interface.

Link: https://lkml.kernel.org/r/164735295554.1084943.18347620679928750960.stgit@devnote2

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
 lib/Kconfig.debug |  12 ++++
 lib/Makefile      |   2 +
 lib/test_fprobe.c | 174 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 lib/test_fprobe.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..7a7af34cbc90 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2100,6 +2100,18 @@ config KPROBES_SANITY_TEST
 
 	  Say N if you are unsure.
 
+config FPROBE_SANITY_TEST
+	bool "Self test for fprobe"
+	depends on DEBUG_KERNEL
+	depends on FPROBE
+	depends on KUNIT=y
+	help
+	  This option will enable testing the fprobe when the system boot.
+	  A series of tests are made to verify that the fprobe is functioning
+	  properly.
+
+	  Say N if you are unsure.
+
 config BACKTRACE_SELF_TEST
 	tristate "Self test for the backtrace code"
 	depends on DEBUG_KERNEL
diff --git a/lib/Makefile b/lib/Makefile
index 300f569c626b..154008764b16 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -103,6 +103,8 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
+CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
+obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
new file mode 100644
index 000000000000..ed70637a2ffa
--- /dev/null
+++ b/lib/test_fprobe.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * test_fprobe.c - simple sanity test for fprobe
+ */
+
+#include <linux/kernel.h>
+#include <linux/fprobe.h>
+#include <linux/random.h>
+#include <kunit/test.h>
+
+#define div_factor 3
+
+static struct kunit *current_test;
+
+static u32 rand1, entry_val, exit_val;
+
+/* Use indirect calls to avoid inlining the target functions */
+static u32 (*target)(u32 value);
+static u32 (*target2)(u32 value);
+static unsigned long target_ip;
+static unsigned long target2_ip;
+
+static noinline u32 fprobe_selftest_target(u32 value)
+{
+	return (value / div_factor);
+}
+
+static noinline u32 fprobe_selftest_target2(u32 value)
+{
+	return (value / div_factor) + 1;
+}
+
+static notrace void fp_entry_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs)
+{
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	/* This can be called on the fprobe_selftest_target and the fprobe_selftest_target2 */
+	if (ip != target_ip)
+		KUNIT_EXPECT_EQ(current_test, ip, target2_ip);
+	entry_val = (rand1 / div_factor);
+}
+
+static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs)
+{
+	unsigned long ret = regs_return_value(regs);
+
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	if (ip != target_ip) {
+		KUNIT_EXPECT_EQ(current_test, ip, target2_ip);
+		KUNIT_EXPECT_EQ(current_test, ret, (rand1 / div_factor) + 1);
+	} else
+		KUNIT_EXPECT_EQ(current_test, ret, (rand1 / div_factor));
+	KUNIT_EXPECT_EQ(current_test, entry_val, (rand1 / div_factor));
+	exit_val = entry_val + div_factor;
+}
+
+/* Test entry only (no rethook) */
+static void test_fprobe_entry(struct kunit *test)
+{
+	struct fprobe fp_entry = {
+		.entry_handler = fp_entry_handler,
+	};
+
+	current_test = test;
+
+	/* Before register, unregister should be failed. */
+	KUNIT_EXPECT_NE(test, 0, unregister_fprobe(&fp_entry));
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp_entry, "fprobe_selftest_target*", NULL));
+
+	entry_val = 0;
+	exit_val = 0;
+	target(rand1);
+	KUNIT_EXPECT_NE(test, 0, entry_val);
+	KUNIT_EXPECT_EQ(test, 0, exit_val);
+
+	entry_val = 0;
+	exit_val = 0;
+	target2(rand1);
+	KUNIT_EXPECT_NE(test, 0, entry_val);
+	KUNIT_EXPECT_EQ(test, 0, exit_val);
+
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp_entry));
+}
+
+static void test_fprobe(struct kunit *test)
+{
+	struct fprobe fp = {
+		.entry_handler = fp_entry_handler,
+		.exit_handler = fp_exit_handler,
+	};
+
+	current_test = test;
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp, "fprobe_selftest_target*", NULL));
+
+	entry_val = 0;
+	exit_val = 0;
+	target(rand1);
+	KUNIT_EXPECT_NE(test, 0, entry_val);
+	KUNIT_EXPECT_EQ(test, entry_val + div_factor, exit_val);
+
+	entry_val = 0;
+	exit_val = 0;
+	target2(rand1);
+	KUNIT_EXPECT_NE(test, 0, entry_val);
+	KUNIT_EXPECT_EQ(test, entry_val + div_factor, exit_val);
+
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
+}
+
+static void test_fprobe_syms(struct kunit *test)
+{
+	static const char *syms[] = {"fprobe_selftest_target", "fprobe_selftest_target2"};
+	struct fprobe fp = {
+		.entry_handler = fp_entry_handler,
+		.exit_handler = fp_exit_handler,
+	};
+
+	current_test = test;
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe_syms(&fp, syms, 2));
+
+	entry_val = 0;
+	exit_val = 0;
+	target(rand1);
+	KUNIT_EXPECT_NE(test, 0, entry_val);
+	KUNIT_EXPECT_EQ(test, entry_val + div_factor, exit_val);
+
+	entry_val = 0;
+	exit_val = 0;
+	target2(rand1);
+	KUNIT_EXPECT_NE(test, 0, entry_val);
+	KUNIT_EXPECT_EQ(test, entry_val + div_factor, exit_val);
+
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
+}
+
+static unsigned long get_ftrace_location(void *func)
+{
+	unsigned long size, addr = (unsigned long)func;
+
+	if (!kallsyms_lookup_size_offset(addr, &size, NULL) || !size)
+		return 0;
+
+	return ftrace_location_range(addr, addr + size - 1);
+}
+
+static int fprobe_test_init(struct kunit *test)
+{
+	do {
+		rand1 = prandom_u32();
+	} while (rand1 <= div_factor);
+
+	target = fprobe_selftest_target;
+	target2 = fprobe_selftest_target2;
+	target_ip = get_ftrace_location(target);
+	target2_ip = get_ftrace_location(target2);
+
+	return 0;
+}
+
+static struct kunit_case fprobe_testcases[] = {
+	KUNIT_CASE(test_fprobe_entry),
+	KUNIT_CASE(test_fprobe),
+	KUNIT_CASE(test_fprobe_syms),
+	{}
+};
+
+static struct kunit_suite fprobe_test_suite = {
+	.name = "fprobe_test",
+	.init = fprobe_test_init,
+	.test_cases = fprobe_testcases,
+};
+
+kunit_test_suites(&fprobe_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.35.1
