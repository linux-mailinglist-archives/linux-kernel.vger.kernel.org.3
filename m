Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E67B463F92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbhK3VDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbhK3U7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:59:23 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB47DC061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:03 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id p3so12068079qvj.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1UTq0XNjoj63bKGJUn764nBUtFsBCgYgAcoKfwHlbw=;
        b=gWTOWBWkcjjHySYevMLCznt45eHqQtdD8J4x/RdcO0aIQS/9QmLVMC8p0L+VyQHL/I
         oNdqX+5cPFZOVOC8XR5nWqIFAM/P49yqcCr/I1oZJOJrE1DtntbCU1Tx1UlBWY/YcJ/i
         SlgrNGnBJ43t8FFmQubVTXZeHA+0O9OHdz2HpO/Q3s1e0MKz5Rrbw81u5js9IlPS4tk3
         OpDu3FBoKYjTEYsXq7gkGQlChD4dQZyDUurIkZNj8Jr5RSWNGcl8GM4T8X8ck6fZT2mF
         m1w0r2yKSq5WGPBOS3ywzQVcPl5STt0eGKIaDr27oPbnV6gv42VV+h+U1T3WYQl6wqIQ
         HCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1UTq0XNjoj63bKGJUn764nBUtFsBCgYgAcoKfwHlbw=;
        b=0khkyMyQuf86kpDmWbKGsFHgptgI+sG19Ncnsykz249Um5WhleCer4iAZbMLGgBExE
         Dp8l6WRJMW56rUP2yeRIqMyb5Bk7QIk8XTbe/vdG20DIUfw7Pa+Jp3zuh4lIrKSnTL6A
         yDZsbMlZ+hX58uuKoGzB1+uixQqqAUzQP1g3YL1ZvezVyRIaZEa/fsIJM8KIGd7tiN4y
         FNwR6hGGdgIPufoLHgo6Zsn2Ak8qDz9KN8/VIH+qfjFSmjwvSgtLCx/sOTKIAAfYaR4d
         2jIRPSe8311KOSe1pQord69ZMNXXI11hCOw7O059DUA7ARidYby56Jktp5JAjFq7kbn2
         ay6g==
X-Gm-Message-State: AOAM531SifxvhzM1KGh0sInk8ubpKflQSymi5i+GVXoNyTOxdQVm7xFx
        WH+4E91zkD3Szb/xJ1PL4Z8Dkb4teg==
X-Google-Smtp-Source: ABdhPJy+02rbr3epQtwmGZI8L7hRy493mSIZLl2dqeNqG7UvuE3Sv03A3VGWKMVKRtnodtaB52LoOg==
X-Received: by 2002:a05:6214:761:: with SMTP id f1mr2206676qvz.90.1638305762663;
        Tue, 30 Nov 2021 12:56:02 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id t11sm10549356qkp.56.2021.11.30.12.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:56:02 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 2/6] x86-64: Convert stack protector to normal percpu variable
Date:   Tue, 30 Nov 2021 15:55:45 -0500
Message-Id: <20211130205549.116673-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130205549.116673-1-brgerst@gmail.com>
References: <20211130205549.116673-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older versions of GCC fixed the location of the stack protector canary
at %gs:40.  This constraint forced the percpu section to be linked at
virtual address 0 so that the canary could be the first data object in
the percpu section.  Supporting the zero-based percpu section requires
additional code to handle relocations for RIP-relative references to
percpu data, extra complexity to kallsyms, and workarounds for linker
bugs due to the use of absolute symbols.

Since version 8.1, GCC has options to configure the location of the
canary value.  This allows the canary to be turned into a normal
percpu variable and removes the constraint that the percpu section
be zero-based.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                      |  2 +-
 arch/x86/Makefile                     | 19 ++++++++------
 arch/x86/entry/entry_64.S             |  2 +-
 arch/x86/include/asm/processor.h      | 25 ++++---------------
 arch/x86/include/asm/stackprotector.h | 36 ++++++---------------------
 arch/x86/kernel/asm-offsets_64.c      |  6 -----
 arch/x86/kernel/cpu/common.c          |  8 ++----
 arch/x86/kernel/head_64.S             | 12 +++++----
 arch/x86/kernel/vmlinux.lds.S         |  6 -----
 arch/x86/tools/relocs.c               |  1 -
 arch/x86/xen/xen-head.S               | 10 +++-----
 11 files changed, 39 insertions(+), 88 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 82ed7fdddc75..a8177ece6a99 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -392,7 +392,7 @@ config PGTABLE_LEVELS
 
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
-	default y if 64BIT
+	default $(cc-option,-mstack-protector-guard-reg=gs -mstack-protector-guard-symbol=__stack_chk_guard) if 64BIT
 	default $(cc-option,-mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard)
 	help
 	   We have to make sure stack protector is unconditionally disabled if
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 42243869216d..f25ba649abf8 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -79,13 +79,7 @@ ifeq ($(CONFIG_X86_32),y)
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
 
-	ifeq ($(CONFIG_STACKPROTECTOR),y)
-		ifeq ($(CONFIG_SMP),y)
-			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
-		else
-			KBUILD_CFLAGS += -mstack-protector-guard=global
-		endif
-	endif
+	percpu_seg := fs
 else
         BITS := 64
         UTS_MACHINE := x86_64
@@ -126,6 +120,17 @@ else
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
+
+	percpu_seg := gs
+endif
+
+ifeq ($(CONFIG_STACKPROTECTOR),y)
+	ifeq ($(CONFIG_SMP),y)
+		KBUILD_CFLAGS += -mstack-protector-guard-reg=$(percpu_seg) \
+				 -mstack-protector-guard-symbol=__stack_chk_guard
+	else
+		KBUILD_CFLAGS += -mstack-protector-guard=global
+	endif
 endif
 
 ifdef CONFIG_X86_X32
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf795d9..7bfa3b99b5d9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -240,7 +240,7 @@ SYM_FUNC_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(fixed_percpu_data) + stack_canary_offset
+	movq	%rbx, PER_CPU_VAR(__stack_chk_guard)
 #endif
 
 #ifdef CONFIG_RETPOLINE
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2c5f12ae7d04..a63cb7680bcb 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -427,25 +427,13 @@ struct irq_stack {
 DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
 
 #ifdef CONFIG_X86_64
-struct fixed_percpu_data {
-	/*
-	 * GCC hardcodes the stack canary as %gs:40.  Since the
-	 * irq_stack is the object at %gs:0, we reserve the bottom
-	 * 48 bytes of the irq stack for the canary.
-	 *
-	 * Once we are willing to require -mstack-protector-guard-symbol=
-	 * support for x86_64 stackprotector, we can get rid of this.
-	 */
-	char		gs_base[40];
-	unsigned long	stack_canary;
-};
-
-DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
-DECLARE_INIT_PER_CPU(fixed_percpu_data);
-
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
-	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
+#ifdef CONFIG_SMP
+	return per_cpu_offset(cpu);
+#else
+	return 0;
+#endif
 }
 
 DECLARE_PER_CPU(void *, hardirq_stack_ptr);
@@ -455,9 +443,6 @@ extern asmlinkage void ignore_sysret(void);
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
 #else	/* X86_64 */
-#ifdef CONFIG_STACKPROTECTOR
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
-#endif
 DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* !X86_64 */
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 24a8d6c4fb18..6a755a5c4fec 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -2,26 +2,13 @@
 /*
  * GCC stack protector support.
  *
- * Stack protector works by putting predefined pattern at the start of
+ * Stack protector works by putting a predefined pattern at the start of
  * the stack frame and verifying that it hasn't been overwritten when
- * returning from the function.  The pattern is called stack canary
- * and unfortunately gcc historically required it to be at a fixed offset
- * from the percpu segment base.  On x86_64, the offset is 40 bytes.
+ * returning from the function.  The pattern is called the stack canary
+ * and is a unique value for each task.
  *
- * The same segment is shared by percpu area and stack canary.  On
- * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
- * base of percpu area.  The first occupant of the percpu area is always
- * fixed_percpu_data which contains stack_canary at the appropriate
- * offset.  On x86_32, the stack canary is just a regular percpu
- * variable.
- *
- * Putting percpu data in %fs on 32-bit is a minor optimization compared to
- * using %gs.  Since 32-bit userspace normally has %fs == 0, we are likely
- * to load 0 into %fs on exit to usermode, whereas with percpu data in
- * %gs, we are likely to load a non-null %gs on return to user mode.
- *
- * Once we are willing to require GCC 8.1 or better for 64-bit stackprotector
- * support, we can remove some of this complexity.
+ * GCC is configured to read the stack canary value from the __stack_chk_guard
+ * per-cpu variable, which is changed on task switch.
  */
 
 #ifndef _ASM_STACKPROTECTOR_H
@@ -37,6 +24,8 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 
+DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+
 /*
  * Initialize the stackprotector canary value.
  *
@@ -53,9 +42,6 @@ static __always_inline void boot_init_stack_canary(void)
 	u64 canary;
 	u64 tsc;
 
-#ifdef CONFIG_X86_64
-	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
-#endif
 	/*
 	 * We both use the random pool and the current TSC as a source
 	 * of randomness. The TSC only matters for very early init,
@@ -68,20 +54,12 @@ static __always_inline void boot_init_stack_canary(void)
 	canary &= CANARY_MASK;
 
 	current->stack_canary = canary;
-#ifdef CONFIG_X86_64
-	this_cpu_write(fixed_percpu_data.stack_canary, canary);
-#else
 	this_cpu_write(__stack_chk_guard, canary);
-#endif
 }
 
 static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
 {
-#ifdef CONFIG_X86_64
-	per_cpu(fixed_percpu_data.stack_canary, cpu) = idle->stack_canary;
-#else
 	per_cpu(__stack_chk_guard, cpu) = idle->stack_canary;
-#endif
 }
 
 #else	/* STACKPROTECTOR */
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index b14533af7676..985dc3455993 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -54,11 +54,5 @@ int main(void)
 	BLANK();
 #undef ENTRY
 
-	BLANK();
-
-#ifdef CONFIG_STACKPROTECTOR
-	DEFINE(stack_canary_offset, offsetof(struct fixed_percpu_data, stack_canary));
-	BLANK();
-#endif
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0663642d6199..0462de9b9921 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1767,10 +1767,6 @@ static __init int setup_clearcpuid(char *arg)
 __setup("clearcpuid=", setup_clearcpuid);
 
 #ifdef CONFIG_X86_64
-DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
-		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
-EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
-
 /*
  * The following percpu variables are hot.  Align current_task to
  * cacheline size such that they fall in the same cacheline.
@@ -1851,13 +1847,13 @@ DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
 	(unsigned long)&init_thread_union + THREAD_SIZE;
 EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
 
+#endif	/* CONFIG_X86_64 */
+
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
 
-#endif	/* CONFIG_X86_64 */
-
 /*
  * Clear all 6 debug registers:
  */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8b3ebd2bb85..833f747e74ee 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -198,10 +198,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movl %eax,%fs
 	movl %eax,%gs
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data. If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	/*
+	 * Set up GS base.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
@@ -337,7 +335,11 @@ SYM_CODE_END(vc_boot_ghcb)
 	__REFDATA
 	.balign	8
 SYM_DATA(initial_code,	.quad x86_64_start_kernel)
-SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
+#ifdef CONFIG_SMP
+SYM_DATA(initial_gs,	.quad __per_cpu_load)
+#else
+SYM_DATA(initial_gs,	.quad 0)
+#endif
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3d6dc12d198f..18a01ece43ee 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -481,14 +481,8 @@ SECTIONS
  */
 #define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
 INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
-#ifdef CONFIG_SMP
-. = ASSERT((fixed_percpu_data == 0),
-           "fixed_percpu_data is not at start of per-cpu area");
-#endif
-
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_KEXEC_CORE
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index c736cf2ac76b..9b3d51cb2cd1 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -810,7 +810,6 @@ static void percpu_init(void)
  *	__per_cpu_load
  *
  * The "gold" linker incorrectly associates:
- *	init_per_cpu__fixed_percpu_data
  *	init_per_cpu__gdt_page
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 6a64496edefb..ba738835db11 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -54,16 +54,14 @@ SYM_CODE_START(startup_xen)
 	mov %rsi, xen_start_info
 	mov initial_stack(%rip), %rsp
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data.  If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	/*
+	 * Set up GS base.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
-	cdq
+	movl	initial_gs(%rip),%eax
+	movl	initial_gs+4(%rip),%edx
 	wrmsr
 
 	call xen_start_kernel
-- 
2.31.1

