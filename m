Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA75505CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346670AbiDRQzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346574AbiDRQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE45E338B9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VyhT3BT6VMq8FLjVnc4agqzIjqfTJuNBZf7A2XDS6Y8=;
        b=Q8RA3B4T/yKRL08/kN/te9OrI4+Zp1KxHDarOccvdH3SQ330m/gi1yidHxEbft2HHqRzdR
        hPzb5fjwkleu6iHOi9WvwcXMNqzTs/6vZ3WUuGO+Qu4O3oYRMXFwMCXuoqHse7iDjnEKGQ
        RZCOHk8qL7dqcOXGJi5uMrf5kqevueU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-2aczuG5XNIWsQcUDegrQGw-1; Mon, 18 Apr 2022 12:51:19 -0400
X-MC-Unique: 2aczuG5XNIWsQcUDegrQGw-1
Received: by mail-qt1-f199.google.com with SMTP id o2-20020ac86982000000b002f1d71c97b8so7377104qtq.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyhT3BT6VMq8FLjVnc4agqzIjqfTJuNBZf7A2XDS6Y8=;
        b=wht+WyTzLzVAE9mvhmb55tFpTwRW8qC9UvYPy8hIjBeobuLnOr0Tbn0v3MGc11tzTp
         HW3v24nqYcFnye4t/VCFO1XLWk5WyPJi0toBXgD/3pQ6yg28ZNPjrRK3Qly0DEH+PYWy
         5zaAnsHR3REE6WXAk5oKzJKrT5ufRq99FOHLQJqLRuiTds3zm1AB6VpV7yGChMs3ZtUM
         j5I+Pm1H9sMWJPdb1dnRGfIUXJnoITyudpAa4XywpY2z7e0QLFOaAJrJZgxfh7rX7ZDX
         8/8e297FPbYV0Ts+vc2Auxx+cfOlPtpKw1GNU8wqxyW5LL9b/q1IzPNk4GbTY6y4JUW+
         jV2A==
X-Gm-Message-State: AOAM530rbSNNhqm3BAJ6OvMjKFgKWmit/RSuVLkFRB0g+o/bRGsTdeZm
        LPNDCSo59C+8lwqrW6tm5aQjMcl4YfiHUnrHrRpoVU2tcRg7F8T1aiq6jZfOYk1dPQwV6EqydnN
        0T4SWTgts4XN/dGHvynrDqCVj
X-Received: by 2002:a05:620a:198f:b0:69e:953c:1843 with SMTP id bm15-20020a05620a198f00b0069e953c1843mr3914683qkb.209.1650300678692;
        Mon, 18 Apr 2022 09:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiJCmYzapTJreYBz8xSSddqTH05EYtPfLspu0GRfzhkt2ljHtsHkfebiN8H5PJJNe9rNcDqg==
X-Received: by 2002:a05:620a:198f:b0:69e:953c:1843 with SMTP id bm15-20020a05620a198f00b0069e953c1843mr3914667qkb.209.1650300678333;
        Mon, 18 Apr 2022 09:51:18 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:17 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 17/25] objtool: Add CONFIG_OBJTOOL
Date:   Mon, 18 Apr 2022 09:50:36 -0700
Message-Id: <939bf3d85604b2a126412bf11af6e3bd3b872bcb.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that stack validation is an optional feature of objtool, add
CONFIG_OBJTOOL and replace most usages of CONFIG_STACK_VALIDATION with
it.

CONFIG_STACK_VALIDATION can now be considered to be frame-pointer
specific.  CONFIG_UNWINDER_ORC is already inherently valid for live
patching, so no need to "validate" it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
 kernel/trace/Kconfig              |  1 +
 lib/Kconfig.debug                 | 20 ++++++++++---------
 lib/Kconfig.kcsan                 |  3 ++-
 lib/Kconfig.ubsan                 |  2 +-
 scripts/Makefile.build            |  4 ++--
 scripts/link-vmlinux.sh           | 32 +++++++++++++++++--------------
 scripts/package/builddeb          |  2 +-
 tools/include/linux/objtool.h     |  6 +++---
 17 files changed, 73 insertions(+), 57 deletions(-)

diff --git a/Makefile b/Makefile
index 29e273d3f8cc..707dfbf643a2 100644
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
index 29b0167c088b..04cdef16db24 100644
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
index b0142e01002e..bce0c23f3550 100644
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
index d3a6f74a94bd..d872a7522e55 100644
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
index 0449b125d27f..3ce0e67c579c 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,7 +20,7 @@
 	_ASM_PTR "%c0 + %c1 - .\n\t"			\
 	".popsection \n\t"
 
-#ifdef CONFIG_STACK_VALIDATION
+#ifdef CONFIG_OBJTOOL
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
@@ -34,7 +34,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	return true;
 }
 
-#else
+#else /* !CONFIG_OBJTOOL */
 
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
@@ -48,7 +48,7 @@ static __always_inline bool arch_static_branch(struct static_key * const key, co
 	return true;
 }
 
-#endif /* STACK_VALIDATION */
+#endif /* CONFIG_OBJTOOL */
 
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d374cb3cf024..3c66073e7645 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -338,7 +338,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
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
index 219aa5ddbc73..01ce94b58b42 100644
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
index 24359b4a9605..9111a3704072 100644
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
index 586d35720f13..977d90ba642d 100644
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
index 2c43e327a619..2956bc277150 100644
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
index 075cd25363ac..c0e4e47f3ce3 100644
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
index de022445fbba..901c3b509aca 100644
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
index f3c57ed51838..c4fe15d38b60 100644
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
index d5e15ae29156..0f73e02b7cf1 100644
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
index 0140bfa32c0c..5101a7fbfaaf 100755
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
index 91a502bb97e8..67cd420dcf89 100755
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
index 586d35720f13..977d90ba642d 100644
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
-- 
2.34.1

