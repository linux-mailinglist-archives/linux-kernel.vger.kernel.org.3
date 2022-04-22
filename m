Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3212E50B556
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446682AbiDVKjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446698AbiDVKh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:37:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02894558A;
        Fri, 22 Apr 2022 03:35:05 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623703;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSCbQHI4p++BXesREPtCgOxebj2qsfCgaqA0lyXGXlg=;
        b=mJ3t5lny6HK2tBcSaMZTPQsmVbIyAl3//J/cFFn5X87iEkqAiLNFWUFtqHVyJQDgjEUMRE
        f070K0KtL0bDQuX8tHLGsVYQC4XpUX8wXOER1FbLnd2eg/VMnS1O+hXXsYrgVT1S2+otn/
        eCP/qAa8hszXigDnlAIGntvSvsKmKVHMSnVqFgxpqzx0uuZLIJSGFhZ6T0DgcgQTGcO2i0
        tFJ4zO/wmK5fSlrwd6lvtyZqWKuSHs6YUDgsuYsPLJ8DAXZyyCbsJKXO9BjwKPgHJiPT4m
        hJuxbHfcSelk0EnFwzDd65BuODxhgJKCtAf75TmFp99kAOxZzC1X6XNNrMuSDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623703;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSCbQHI4p++BXesREPtCgOxebj2qsfCgaqA0lyXGXlg=;
        b=MFymbaTN6JRovtkhxM/Gsm6BP9oOTjvXYabs/OdYIddfsrbGQdUqxYZEpsCNhvJjASfxt6
        KiRbmySkIy+9FKDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add CONFIG_OBJTOOL
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <939bf3d85604b2a126412bf11af6e3bd3b872bcb.1650300597.git.jpoimboe@redhat.com>
References: <939bf3d85604b2a126412bf11af6e3bd3b872bcb.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370255.4207.3093917269150811172.tip-bot2@tip-bot2>
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

Commit-ID:     03f16cd020eb8bb2eb837e2090086f296a9fa91d
Gitweb:        https://git.kernel.org/tip/03f16cd020eb8bb2eb837e2090086f296a9fa91d
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:03 +02:00

objtool: Add CONFIG_OBJTOOL

Now that stack validation is an optional feature of objtool, add
CONFIG_OBJTOOL and replace most usages of CONFIG_STACK_VALIDATION with
it.

CONFIG_STACK_VALIDATION can now be considered to be frame-pointer
specific.  CONFIG_UNWINDER_ORC is already inherently valid for live
patching, so no need to "validate" it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/939bf3d85604b2a126412bf11af6e3bd3b872bcb.1650300597.git.jpoimboe@redhat.com
---
 Makefile                          |  2 +-
 arch/Kconfig                      |  8 ++++++--
 arch/x86/Kconfig                  | 18 ++++++++++-------
 arch/x86/Kconfig.debug            |  2 +-
 arch/x86/include/asm/jump_label.h |  6 +++---
 arch/x86/kernel/alternative.c     |  6 +++---
 include/linux/compiler.h          |  6 +++---
 include/linux/instrumentation.h   |  6 +++---
 include/linux/objtool.h           |  6 +++---
 kernel/trace/Kconfig              |  1 +-
 lib/Kconfig.debug                 | 20 ++++++++++---------
 lib/Kconfig.kcsan                 |  3 ++-
 lib/Kconfig.ubsan                 |  2 +-
 scripts/Makefile.build            |  4 ++--
 scripts/link-vmlinux.sh           | 32 ++++++++++++++++--------------
 scripts/package/builddeb          |  2 +-
 tools/include/linux/objtool.h     |  6 +++---
 17 files changed, 73 insertions(+), 57 deletions(-)

diff --git a/Makefile b/Makefile
index fa5112a..2507076 100644
--- a/Makefile
+++ b/Makefile
@@ -1302,7 +1302,7 @@ install: sub_make_done :=
 # ---------------------------------------------------------------------------
 # Tools
 
-ifdef CONFIG_STACK_VALIDATION
+ifdef CONFIG_OBJTOOL
 prepare: tools/objtool
 endif
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 29b0167..04cdef1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1028,11 +1028,14 @@ config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	depends on MMU
 	select ARCH_HAS_ELF_RANDOMIZE
 
+config HAVE_OBJTOOL
+	bool
+
 config HAVE_STACK_VALIDATION
 	bool
 	help
-	  Architecture supports the 'objtool check' host tool command, which
-	  performs compile-time stack metadata validation.
+	  Architecture supports objtool compile-time frame pointer rule
+	  validation.
 
 config HAVE_RELIABLE_STACKTRACE
 	bool
@@ -1302,6 +1305,7 @@ config HAVE_STATIC_CALL
 config HAVE_STATIC_CALL_INLINE
 	bool
 	depends on HAVE_STATIC_CALL
+	select OBJTOOL
 
 config HAVE_PREEMPT_DYNAMIC
 	bool
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4bed3ab..43e26ee 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -188,7 +188,7 @@ config X86
 	select HAVE_CONTEXT_TRACKING		if X86_64
 	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
-	select HAVE_OBJTOOL_MCOUNT		if STACK_VALIDATION
+	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
 	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
@@ -231,6 +231,7 @@ config X86
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_NMI
+	select HAVE_OBJTOOL			if X86_64
 	select HAVE_OPTPROBES
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
@@ -239,17 +240,17 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select MMU_GATHER_RCU_TABLE_FREE		if PARAVIRT
+	select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
+	select HAVE_RELIABLE_STACKTRACE		if UNWINDER_ORC || STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
-	select HAVE_STACK_VALIDATION		if X86_64
+	select HAVE_STACK_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_STATIC_CALL
-	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
+	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
 	select HAVE_PREEMPT_DYNAMIC_CALL
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
@@ -268,7 +269,6 @@ config X86
 	select RTC_MC146818_LIB
 	select SPARSE_IRQ
 	select SRCU
-	select STACK_VALIDATION			if HAVE_STACK_VALIDATION && (HAVE_STATIC_CALL_INLINE || RETPOLINE)
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
@@ -459,6 +459,7 @@ config GOLDFISH
 
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
+	select OBJTOOL if HAVE_OBJTOOL
 	default y
 	help
 	  Compile kernel with the retpoline compiler options to guard against
@@ -472,6 +473,7 @@ config CC_HAS_SLS
 config SLS
 	bool "Mitigate Straight-Line-Speculation"
 	depends on CC_HAS_SLS && X86_64
+	select OBJTOOL if HAVE_OBJTOOL
 	default n
 	help
 	  Compile the kernel with straight-line-speculation options to guard
@@ -1819,6 +1821,7 @@ config ARCH_RANDOM
 config X86_SMAP
 	def_bool y
 	prompt "Supervisor Mode Access Prevention" if EXPERT
+	select OBJTOOL if HAVE_OBJTOOL
 	help
 	  Supervisor Mode Access Prevention (SMAP) is a security
 	  feature in newer Intel processors.  There is a small
@@ -1855,9 +1858,10 @@ config CC_HAS_IBT
 config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
 	bool
-	depends on X86_64 && CC_HAS_IBT && STACK_VALIDATION
+	depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL
 	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
 	depends on !LD_IS_LLD || LLD_VERSION >= 140000
+	select OBJTOOL
 	help
 	  Build the kernel with support for Indirect Branch Tracking, a
 	  hardware support course-grain forward-edge Control Flow Integrity
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d3a6f74..d872a75 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -237,7 +237,7 @@ choice
 config UNWINDER_ORC
 	bool "ORC unwinder"
 	depends on X86_64
-	select STACK_VALIDATION
+	select OBJTOOL
 	help
 	  This option enables the ORC (Oops Rewind Capability) unwinder for
 	  unwinding kernel stack traces.  It uses a custom data format which is
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 0449b12..3ce0e67 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,7 +20,7 @@
 	_ASM_PTR "%c0 + %c1 - .\n\t"			\
 	".popsection \n\t"
 
-#ifdef CONFIG_STACK_VALIDATION
+#ifdef CONFIG_OBJTOOL
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
@@ -34,7 +34,7 @@ l_yes:
 	return true;
 }
 
-#else
+#else /* !CONFIG_OBJTOOL */
 
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
@@ -48,7 +48,7 @@ l_yes:
 	return true;
 }
 
-#endif /* STACK_VALIDATION */
+#endif /* CONFIG_OBJTOOL */
 
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d374cb3..3c66073 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -338,7 +338,7 @@ next:
 	}
 }
 
-#if defined(CONFIG_RETPOLINE) && defined(CONFIG_STACK_VALIDATION)
+#if defined(CONFIG_RETPOLINE) && defined(CONFIG_OBJTOOL)
 
 /*
  * CALL/JMP *%\reg
@@ -507,11 +507,11 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 	}
 }
 
-#else /* !RETPOLINES || !CONFIG_STACK_VALIDATION */
+#else /* !CONFIG_RETPOLINE || !CONFIG_OBJTOOL */
 
 void __init_or_module noinline apply_retpolines(s32 *start, s32 *end) { }
 
-#endif /* CONFIG_RETPOLINE && CONFIG_STACK_VALIDATION */
+#endif /* CONFIG_RETPOLINE && CONFIG_OBJTOOL */
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 219aa5d..01ce94b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -109,7 +109,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #endif
 
 /* Unreachable code */
-#ifdef CONFIG_STACK_VALIDATION
+#ifdef CONFIG_OBJTOOL
 /*
  * These macros help objtool understand GCC code flow for unreachable code.
  * The __COUNTER__ based labels are a hack to make each instance of the macros
@@ -128,10 +128,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(".rodata..c_jump_table")
 
-#else
+#else /* !CONFIG_OBJTOOL */
 #define annotate_unreachable()
 #define __annotate_jump_table
-#endif
+#endif /* CONFIG_OBJTOOL */
 
 #ifndef unreachable
 # define unreachable() do {		\
diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index 24359b4..9111a37 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_INSTRUMENTATION_H
 #define __LINUX_INSTRUMENTATION_H
 
-#if defined(CONFIG_DEBUG_ENTRY) && defined(CONFIG_STACK_VALIDATION)
+#ifdef CONFIG_VMLINUX_VALIDATION
 
 #include <linux/stringify.h>
 
@@ -53,9 +53,9 @@
 		     ".popsection\n\t" : : "i" (c));			\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
-#else
+#else /* !CONFIG_VMLINUX_VALIDATION */
 # define instrumentation_begin()	do { } while(0)
 # define instrumentation_end()		do { } while(0)
-#endif
+#endif /* CONFIG_VMLINUX_VALIDATION */
 
 #endif /* __LINUX_INSTRUMENTATION_H */
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 586d357..977d90b 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -38,7 +38,7 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_REGS_PARTIAL	2
 #define UNWIND_HINT_TYPE_FUNC		3
 
-#ifdef CONFIG_STACK_VALIDATION
+#ifdef CONFIG_OBJTOOL
 
 #ifndef __ASSEMBLY__
 
@@ -157,7 +157,7 @@ struct unwind_hint {
 
 #endif /* __ASSEMBLY__ */
 
-#else /* !CONFIG_STACK_VALIDATION */
+#else /* !CONFIG_OBJTOOL */
 
 #ifndef __ASSEMBLY__
 
@@ -179,6 +179,6 @@ struct unwind_hint {
 .endm
 #endif
 
-#endif /* CONFIG_STACK_VALIDATION */
+#endif /* CONFIG_OBJTOOL */
 
 #endif /* _LINUX_OBJTOOL_H */
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 2c43e32..2956bc2 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -728,6 +728,7 @@ config FTRACE_MCOUNT_USE_OBJTOOL
 	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 	depends on !FTRACE_MCOUNT_USE_CC
 	depends on FTRACE_MCOUNT_RECORD
+	select OBJTOOL
 
 config FTRACE_MCOUNT_USE_RECORDMCOUNT
 	def_bool y
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 075cd25..c0e4e47 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -485,24 +485,25 @@ config FRAME_POINTER
 	  larger and slower, but it gives very useful debugging information
 	  in case of kernel bugs. (precise oopses/stacktraces/warnings)
 
+config OBJTOOL
+	bool
+
 config STACK_VALIDATION
 	bool "Compile-time stack metadata validation"
-	depends on HAVE_STACK_VALIDATION
+	depends on HAVE_STACK_VALIDATION && UNWINDER_FRAME_POINTER
+	select OBJTOOL
 	default n
 	help
-	  Add compile-time checks to validate stack metadata, including frame
-	  pointers (if CONFIG_FRAME_POINTER is enabled).  This helps ensure
-	  that runtime stack traces are more reliable.
-
-	  This is also a prerequisite for generation of ORC unwind data, which
-	  is needed for CONFIG_UNWINDER_ORC.
+	  Validate frame pointer rules at compile-time.  This helps ensure that
+	  runtime stack traces are more reliable.
 
 	  For more information, see
 	  tools/objtool/Documentation/stack-validation.txt.
 
 config VMLINUX_VALIDATION
 	bool
-	depends on STACK_VALIDATION && DEBUG_ENTRY
+	depends on HAVE_OBJTOOL && DEBUG_ENTRY
+	select OBJTOOL
 	default y
 
 config VMLINUX_MAP
@@ -2035,10 +2036,11 @@ config KCOV
 	bool "Code coverage for fuzzing"
 	depends on ARCH_HAS_KCOV
 	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
-	depends on !ARCH_WANTS_NO_INSTR || STACK_VALIDATION || \
+	depends on !ARCH_WANTS_NO_INSTR || HAVE_OBJTOOL || \
 		   GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
 	select DEBUG_FS
 	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
+	select OBJTOOL if HAVE_OBJTOOL
 	help
 	  KCOV exposes kernel code coverage information in a form suitable
 	  for coverage-guided fuzzing (randomized testing).
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index de02244..901c3b5 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -187,7 +187,8 @@ config KCSAN_WEAK_MEMORY
 	# We can either let objtool nop __tsan_func_{entry,exit}() and builtin
 	# atomics instrumentation in .noinstr.text, or use a compiler that can
 	# implement __no_kcsan to really remove all instrumentation.
-	depends on STACK_VALIDATION || CC_IS_GCC || CLANG_VERSION >= 140000
+	depends on HAVE_OBJTOOL || CC_IS_GCC || CLANG_VERSION >= 140000
+	select OBJTOOL if HAVE_OBJTOOL
 	help
 	  Enable support for modeling a subset of weak memory, which allows
 	  detecting a subset of data races due to missing memory barriers.
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index f3c57ed..c4fe15d 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -94,7 +94,7 @@ config UBSAN_UNREACHABLE
 	bool "Perform checking for unreachable code"
 	# objtool already handles unreachable checking and gets angry about
 	# seeing UBSan instrumentation located in unreachable places.
-	depends on !STACK_VALIDATION
+	depends on !(OBJTOOL && (STACK_VALIDATION || UNWINDER_ORC || X86_SMAP))
 	depends on $(cc-option,-fsanitize=unreachable)
 	help
 	  This option enables -fsanitize=unreachable which checks for control
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index d5e15ae..0f73e02 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -222,7 +222,7 @@ cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	
 	$(sub_cmd_record_mcount))
 endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 
-ifdef CONFIG_STACK_VALIDATION
+ifdef CONFIG_OBJTOOL
 
 objtool := $(objtree)/tools/objtool/objtool
 
@@ -241,7 +241,7 @@ objtool_args =								\
 cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
 cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
 
-endif # CONFIG_STACK_VALIDATION
+endif # CONFIG_OBJTOOL
 
 ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 0140bfa..5101a7f 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -108,8 +108,11 @@ objtool_link()
 	local objtoolcmd;
 	local objtoolopt;
 
-	if is_enabled CONFIG_STACK_VALIDATION && \
-	   ( is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT ); then
+	if ! is_enabled CONFIG_OBJTOOL; then
+		return;
+	fi
+
+	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
 
 		# Don't perform vmlinux validation unless explicitly requested,
 		# but run objtool on vmlinux.o now that we have an object file.
@@ -126,10 +129,23 @@ objtool_link()
 			objtoolopt="${objtoolopt} --orc"
 		fi
 
+		if is_enabled CONFIG_RETPOLINE; then
+			objtoolopt="${objtoolopt} --retpoline"
+		fi
+
+		if is_enabled CONFIG_SLS; then
+			objtoolopt="${objtoolopt} --sls"
+		fi
+
 		if is_enabled CONFIG_STACK_VALIDATION; then
 			objtoolopt="${objtoolopt} --stackval"
 		fi
 
+		if is_enabled CONFIG_X86_SMAP; then
+			objtoolopt="${objtoolopt} --uaccess"
+		fi
+
+
 		objtoolopt="${objtoolopt} --lto"
 	fi
 
@@ -139,18 +155,6 @@ objtool_link()
 
 	if [ -n "${objtoolopt}" ]; then
 
-		if is_enabled CONFIG_RETPOLINE; then
-			objtoolopt="${objtoolopt} --retpoline"
-		fi
-
-		if is_enabled CONFIG_SLS; then
-			objtoolopt="${objtoolopt} --sls"
-		fi
-
-		if is_enabled CONFIG_X86_SMAP; then
-			objtoolopt="${objtoolopt} --uaccess"
-		fi
-
 		if ! is_enabled CONFIG_FRAME_POINTER; then
 			objtoolopt="${objtoolopt} --no-fp"
 		fi
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 91a502b..67cd420 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -67,7 +67,7 @@ deploy_kernel_headers () {
 	) > debian/hdrsrcfiles
 
 	{
-		if is_enabled CONFIG_STACK_VALIDATION; then
+		if is_enabled CONFIG_OBJTOOL; then
 			echo tools/objtool/objtool
 		fi
 
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 586d357..977d90b 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -38,7 +38,7 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_REGS_PARTIAL	2
 #define UNWIND_HINT_TYPE_FUNC		3
 
-#ifdef CONFIG_STACK_VALIDATION
+#ifdef CONFIG_OBJTOOL
 
 #ifndef __ASSEMBLY__
 
@@ -157,7 +157,7 @@ struct unwind_hint {
 
 #endif /* __ASSEMBLY__ */
 
-#else /* !CONFIG_STACK_VALIDATION */
+#else /* !CONFIG_OBJTOOL */
 
 #ifndef __ASSEMBLY__
 
@@ -179,6 +179,6 @@ struct unwind_hint {
 .endm
 #endif
 
-#endif /* CONFIG_STACK_VALIDATION */
+#endif /* CONFIG_OBJTOOL */
 
 #endif /* _LINUX_OBJTOOL_H */
