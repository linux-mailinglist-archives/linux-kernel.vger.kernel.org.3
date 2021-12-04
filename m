Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB8646852D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385165AbhLDNzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbhLDNzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:55:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1BCC0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JG+nOrxYO6sWxp1PSYVonhH2By05Ih5pIi8iuuznKLU=; b=P+RuraStW5pWCgdVFFI0+mOVQK
        HH2lWikmuwajt6kQbOwPOGHtukgASUa6aCXs/SioH0qm5oOTGFRjbzb8NKPZZ8zhPqApB29049MdL
        EP9aZ9IfBIou5T0NVvnkEMMU7X+gB79IKG8oHOTQzQc9rqi1rwMOOSMXvIiehIMKjrJ+O9Ctxw5ok
        tbTHq5lyeUUdpiFhu9arI+FpJYKA+ewuj8BCnCc50/8NaEtyTuvHnaZ4YhgzyCypsi8EhOF/0v4EE
        OmgyBGqbs+LSRLw9rUG3UKnNWyJrllEEqpHEUm5UiDPw0bCppTx7NSKTbcugufX7jIhS5b4WhUdmR
        tW7O8D6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtVRm-002CkZ-Q4; Sat, 04 Dec 2021 13:51:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2344330073F;
        Sat,  4 Dec 2021 14:51:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8D38A2DD2562E; Sat,  4 Dec 2021 14:51:24 +0100 (CET)
Message-ID: <20211204134908.140103474@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 04 Dec 2021 14:43:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        keescook@chromium.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v2 6/6] x86: Add straight-line-speculation mitigation
References: <20211204134338.760603010@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of an upcomming GCC feature to mitigate
straight-line-speculation for x86:

  https://gcc.gnu.org/g:53a643f8568067d7700a9f2facc8ba39974973d3
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
  https://bugs.llvm.org/show_bug.cgi?id=52323

It's built tested on x86_64-allyesconfig using GCC-12 and GCC-11.

Maintenace overhead of this should be fairly low due to objtool
validation.

Size overhead of all these additional int3 instructions comes to:

   text	   data	    bss	    dec	    hex	filename
22267751	6933356	2011368	31212475	1dc43bb	defconfig-build/vmlinux
22804126	6933356	1470696	31208178	1dc32f2	defconfig-build/vmlinux.sls

Or roughly 2.4% additional text.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                   |   12 ++++++++++++
 arch/x86/Makefile                  |    4 ++++
 arch/x86/include/asm/linkage.h     |   10 ++++++++++
 arch/x86/include/asm/static_call.h |    2 +-
 arch/x86/kernel/ftrace.c           |    2 +-
 arch/x86/kernel/static_call.c      |    5 +++--
 arch/x86/lib/memmove_64.S          |    2 +-
 arch/x86/lib/retpoline.S           |    2 +-
 scripts/Makefile.build             |    3 ++-
 scripts/link-vmlinux.sh            |    3 +++
 10 files changed, 38 insertions(+), 7 deletions(-)

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
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -179,6 +179,10 @@ ifdef CONFIG_RETPOLINE
   endif
 endif
 
+ifdef CONFIG_SLS
+  KBUILD_CFLAGS += -mharden-sls=all
+endif
+
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
 
 ifdef CONFIG_LTO_CLANG
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
 
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -36,7 +36,7 @@
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, ".byte 0xe9; .long " #func " - (. + 4)")
 
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
-	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; nop; nop; nop; nop")
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; int3; nop; nop; nop")
 
 
 #define ARCH_ADD_TRAMP_KEY(name)					\
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -303,7 +303,7 @@ union ftrace_op_code_union {
 	} __attribute__((packed));
 };
 
-#define RET_SIZE		1
+#define RET_SIZE		1 + IS_ENABLED(CONFIG_SLS)
 
 static unsigned long
 create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
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
@@ -42,8 +44,7 @@ static void __ref __static_call_transfor
 		break;
 
 	case RET:
-		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
-		size = RET_INSN_SIZE;
+		code = &retinsn;
 		break;
 	}
 
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
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -34,7 +34,7 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\re
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
+		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg; int3), X86_FEATURE_RETPOLINE_AMD
 
 .endm
 
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


