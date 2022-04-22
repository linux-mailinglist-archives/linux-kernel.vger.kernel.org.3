Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998950B557
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446742AbiDVKjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446685AbiDVKhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:37:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7038C10C6;
        Fri, 22 Apr 2022 03:35:01 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:34:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ki5WHEZ13c1++Oy6X8lNBfXAF1P+ZU4XYe3IcWwTUgE=;
        b=rrMtbhczJSHUYxLB6sfX6JRk3ibgo2ih5B8+wuzPG6TVKOAi7vDlBP1zqMuv+yLzFc1/ig
        knGL17lkdjCSJdX6c3g1FjHqIyjDDyUwZhv00bqEtm4uwMe7acIAWLW0J/b3Hz92kRPGCS
        0tdtDkIcwnjETU9CPp51spnTKVzF7Q46exKCFOYofw/Hs3yXjDuXCsnOGANj0veLwbBfXG
        O22P1WqGNU9vSu31kjsREGGD2Q/bskqmBGFgSbSZS2E1nVt/O8MNk8lrZMw0/TwP6S+VmW
        99TMRaJIpTI13kyKXvM4T9bxjv1K6OwLWFRxKWXRazz/0BqC5LwUyJu0Q2phFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ki5WHEZ13c1++Oy6X8lNBfXAF1P+ZU4XYe3IcWwTUgE=;
        b=bv6tMQ58Di3oGzE7m1iwwAvD6Vu8Ilp89MCfg0twhskh8gSd7cVYhMcYtwmIKFStTbKJPo
        B53nvMfZTqkH4QCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make noinstr hacks optional
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b326eeb9c33231b9dfbb925f194ed7ee40edcd7c.1650300597.git.jpoimboe@redhat.com>
References: <b326eeb9c33231b9dfbb925f194ed7ee40edcd7c.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062369895.4207.331120687086403525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     22102f4559beaabcea614b29ee090c6a214f002f
Gitweb:        https://git.kernel.org/tip/22102f4559beaabcea614b29ee090c6a214f002f
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:04 +02:00

objtool: Make noinstr hacks optional

Objtool has some hacks in place to workaround toolchain limitations
which otherwise would break no-instrumentation rules.  Make the hacks
explicit (and optional for other arches) by turning it into a cmdline
option and kernel config option.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/b326eeb9c33231b9dfbb925f194ed7ee40edcd7c.1650300597.git.jpoimboe@redhat.com
---
 arch/Kconfig                            | 3 +++
 arch/x86/Kconfig                        | 1 +
 lib/Kconfig.debug                       | 4 ++--
 lib/Kconfig.kcsan                       | 5 +++--
 scripts/Makefile.build                  | 1 +
 scripts/link-vmlinux.sh                 | 4 ++++
 tools/objtool/builtin-check.c           | 8 +++++++-
 tools/objtool/check.c                   | 2 +-
 tools/objtool/include/objtool/builtin.h | 1 +
 9 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9dce6d6..6ba6e34 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1035,6 +1035,9 @@ config HAVE_OBJTOOL
 config HAVE_JUMP_LABEL_HACK
 	bool
 
+config HAVE_NOINSTR_HACK
+	bool
+
 config HAVE_STACK_VALIDATION
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 26d012f..06e7cdd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -231,6 +231,7 @@ config X86
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
+	select HAVE_NOINSTR_HACK		if HAVE_OBJTOOL
 	select HAVE_NMI
 	select HAVE_OBJTOOL			if X86_64
 	select HAVE_OPTPROBES
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c0e4e47..7d2bbc3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2036,11 +2036,11 @@ config KCOV
 	bool "Code coverage for fuzzing"
 	depends on ARCH_HAS_KCOV
 	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
-	depends on !ARCH_WANTS_NO_INSTR || HAVE_OBJTOOL || \
+	depends on !ARCH_WANTS_NO_INSTR || HAVE_NOINSTR_HACK || \
 		   GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
 	select DEBUG_FS
 	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
-	select OBJTOOL if HAVE_OBJTOOL
+	select OBJTOOL if HAVE_NOINSTR_HACK
 	help
 	  KCOV exposes kernel code coverage information in a form suitable
 	  for coverage-guided fuzzing (randomized testing).
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 901c3b5..47a693c 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -187,8 +187,9 @@ config KCSAN_WEAK_MEMORY
 	# We can either let objtool nop __tsan_func_{entry,exit}() and builtin
 	# atomics instrumentation in .noinstr.text, or use a compiler that can
 	# implement __no_kcsan to really remove all instrumentation.
-	depends on HAVE_OBJTOOL || CC_IS_GCC || CLANG_VERSION >= 140000
-	select OBJTOOL if HAVE_OBJTOOL
+	depends on !ARCH_WANTS_NO_INSTR || HAVE_NOINSTR_HACK || \
+		   CC_IS_GCC || CLANG_VERSION >= 140000
+	select OBJTOOL if HAVE_NOINSTR_HACK
 	help
 	  Enable support for modeling a subset of weak memory, which allows
 	  detecting a subset of data races due to missing memory barriers.
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f1d2c2e..6c206a1 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -228,6 +228,7 @@ objtool := $(objtree)/tools/objtool/objtool
 
 objtool_args =								\
 	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
+	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
 	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index fa1f168..90c9c4c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -121,6 +121,10 @@ objtool_link()
 			objtoolopt="${objtoolopt} --hacks=jump_label"
 		fi
 
+		if is_enabled CONFIG_HAVE_NOINSTR_HACK; then
+			objtoolopt="${objtoolopt} --hacks=noinstr"
+		fi
+
 		if is_enabled CONFIG_X86_KERNEL_IBT; then
 			objtoolopt="${objtoolopt} --ibt"
 		fi
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index b2c626d..1803a63 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -47,12 +47,17 @@ static int parse_hacks(const struct option *opt, const char *str, int unset)
 		found = true;
 	}
 
+	if (!str || strstr(str, "noinstr")) {
+		opts.hack_noinstr = true;
+		found = true;
+	}
+
 	return found ? 0 : -1;
 }
 
 const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
-	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label", "patch toolchain bugs/limitations", parse_hacks),
+	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr", "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
@@ -108,6 +113,7 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 static bool opts_valid(void)
 {
 	if (opts.hack_jump_label	||
+	    opts.hack_noinstr		||
 	    opts.ibt			||
 	    opts.mcount			||
 	    opts.noinstr		||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d157978..30b24dc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1144,7 +1144,7 @@ static void annotate_call_site(struct objtool_file *file,
 	 * attribute so they need a little help, NOP out any such calls from
 	 * noinstr text.
 	 */
-	if (insn->sec->noinstr && sym->profiling_func) {
+	if (opts.hack_noinstr && insn->sec->noinstr && sym->profiling_func) {
 		if (reloc) {
 			reloc->type = R_NONE;
 			elf_write_reloc(file->elf, reloc);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index c6acf05..f3a1a75 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -13,6 +13,7 @@ struct opts {
 	/* actions: */
 	bool dump_orc;
 	bool hack_jump_label;
+	bool hack_noinstr;
 	bool ibt;
 	bool mcount;
 	bool noinstr;
