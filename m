Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00D146FF5E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbhLJLI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:08:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45730 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbhLJLIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:08:53 -0500
Date:   Fri, 10 Dec 2021 11:05:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639134316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIwooMHTF0um6QjPP60x9YQnXO5OasQWxO2wWpIr2UQ=;
        b=ESXi4VsUDbGVsrXKor20DRo/MqHnwOHvu6fQbS9eMlKlWVDabrgO5xc0uzrL0/dh3/QNi6
        bbKLnJZhjgg9FLZj+JMKUe+4txXQuaEEyVuFEGQ1m5dLdHpHqegcIjbBrtjtMNrIHiAagU
        GF3WyAjA4hPgVTe2lkpt55vgEClpPzY9TIBvXMGPL+Jkx62D9TVOqHdLypxAVK/equFYHz
        5+YqRKjxSYUZUchnlTjzER2tY/Yo7yqHL21+j8DYvigbMo62IMcGyk5Tl69I4toF+vbOI5
        qoYRrhl9jRfFzc+bZpahk0GiVQ+3HuEQq8sS69hx9KkryQb2cD53F1Qnjsu+4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639134316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIwooMHTF0um6QjPP60x9YQnXO5OasQWxO2wWpIr2UQ=;
        b=npNdI8Rfsm8G7dnozmH3+FYH1Yy0wO/czLxf8/RljJhVOnRrVT5NbFZ2DDqcKCX8oXqI35
        pJxJTBx3fxPEHDCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Add straight-line-speculation mitigation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211204134908.140103474@infradead.org>
References: <20211204134908.140103474@infradead.org>
MIME-Version: 1.0
Message-ID: <163913431447.23020.17885281470969105956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
Gitweb:        https://git.kernel.org/tip/e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 04 Dec 2021 14:43:44 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 09 Dec 2021 13:32:25 +01:00

x86: Add straight-line-speculation mitigation

Make use of an upcoming GCC feature to mitigate
straight-line-speculation for x86:

  https://gcc.gnu.org/g:53a643f8568067d7700a9f2facc8ba39974973d3
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
  https://bugs.llvm.org/show_bug.cgi?id=52323

It's built tested on x86_64-allyesconfig using GCC-12 and GCC-11.

Maintenance overhead of this should be fairly low due to objtool
validation.

Size overhead of all these additional int3 instructions comes to:

     text	   data	    bss	    dec	    hex	filename
  22267751	6933356	2011368	31212475	1dc43bb	defconfig-build/vmlinux
  22804126	6933356	1470696	31208178	1dc32f2	defconfig-build/vmlinux.sls

Or roughly 2.4% additional text.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211204134908.140103474@infradead.org
---
 arch/x86/Kconfig                   | 12 ++++++++++++
 arch/x86/Makefile                  |  4 ++++
 arch/x86/include/asm/linkage.h     | 10 ++++++++++
 arch/x86/include/asm/static_call.h |  2 +-
 arch/x86/kernel/ftrace.c           |  2 +-
 arch/x86/kernel/static_call.c      |  5 +++--
 arch/x86/lib/memmove_64.S          |  2 +-
 arch/x86/lib/retpoline.S           |  2 +-
 scripts/Makefile.build             |  3 ++-
 scripts/link-vmlinux.sh            |  3 +++
 10 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7399327..dd13ba8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -472,6 +472,18 @@ config RETPOLINE
 	  branches. Requires a compiler with -mindirect-branch=thunk-extern
 	  support for full protection. The kernel may run slower.
 
+config CC_HAS_SLS
+	def_bool $(cc-option,-mharden-sls=all)
+
+config SLS
+	bool "Mitigate Straight-Line-Speculation"
+	depends on CC_HAS_SLS && X86_64
+	default n
+	help
+	  Compile the kernel with straight-line-speculation options to guard
+	  against straight line speculation. The kernel image might be slightly
+	  larger.
+
 config X86_CPU_RESCTRL
 	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index c38b657..e84cdd4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -191,6 +191,10 @@ ifdef CONFIG_RETPOLINE
   endif
 endif
 
+ifdef CONFIG_SLS
+  KBUILD_CFLAGS += -mharden-sls=all
+endif
+
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
 
 ifdef CONFIG_LTO_CLANG
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index ebddec2..0309079 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -18,9 +18,19 @@
 #define __ALIGN_STR	__stringify(__ALIGN)
 #endif
 
+#ifdef CONFIG_SLS
+#define RET	ret; int3
+#else
+#define RET	ret
+#endif
+
 #else /* __ASSEMBLY__ */
 
+#ifdef CONFIG_SLS
+#define ASM_RET	"ret; int3\n\t"
+#else
 #define ASM_RET	"ret\n\t"
+#endif
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 39ebe05..ed4f8bb 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -36,7 +36,7 @@
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, ".byte 0xe9; .long " #func " - (. + 4)")
 
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
-	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; nop; nop; nop; nop")
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; int3; nop; nop; nop")
 
 
 #define ARCH_ADD_TRAMP_KEY(name)					\
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index c39f906..7cc540e 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -303,7 +303,7 @@ union ftrace_op_code_union {
 	} __attribute__((packed));
 };
 
-#define RET_SIZE		1
+#define RET_SIZE		1 + IS_ENABLED(CONFIG_SLS)
 
 static unsigned long
 create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 9c407a3..531fb4c 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -17,6 +17,8 @@ enum insn_type {
  */
 static const u8 xor5rax[] = { 0x66, 0x66, 0x48, 0x31, 0xc0 };
 
+static const u8 retinsn[] = { RET_INSN_OPCODE, 0xcc, 0xcc, 0xcc, 0xcc };
+
 static void __ref __static_call_transform(void *insn, enum insn_type type, void *func)
 {
 	const void *emulate = NULL;
@@ -42,8 +44,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void 
 		break;
 
 	case RET:
-		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
-		size = RET_INSN_SIZE;
+		code = &retinsn;
 		break;
 	}
 
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index e84d649..50ea390 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -40,7 +40,7 @@ SYM_FUNC_START(__memmove)
 	/* FSRM implies ERMS => no length checks, do the copy directly */
 .Lmemmove_begin_forward:
 	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
-	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; RET", X86_FEATURE_ERMS
+	ALTERNATIVE "", __stringify(movq %rdx, %rcx; rep movsb; RET), X86_FEATURE_ERMS
 
 	/*
 	 * movsq instruction have many startup latency
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index a842866..89b3fb2 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -34,7 +34,7 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
+		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg; int3), X86_FEATURE_RETPOLINE_AMD
 
 .endm
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 78656b5..a4b89b7 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -234,7 +234,8 @@ objtool_args =								\
 	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
-	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)
+	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
+	$(if $(CONFIG_SLS), --sls)
 
 cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
 cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 5cdd9bc..9716f28 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -139,6 +139,9 @@ objtool_link()
 		if [ -n "${CONFIG_X86_SMAP}" ]; then
 			objtoolopt="${objtoolopt} --uaccess"
 		fi
+		if [ -n "${CONFIG_SLS}" ]; then
+			objtoolopt="${objtoolopt} --sls"
+		fi
 		info OBJTOOL ${1}
 		tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
 	fi
