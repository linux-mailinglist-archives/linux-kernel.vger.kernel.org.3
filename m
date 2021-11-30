Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D2C463F90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343926AbhK3VBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbhK3U7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:59:25 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97415C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:04 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b67so28329102qkg.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9+TCZLLMqZE4Cspbo3e1dwusVFmwRs3cKgkqAh7H7o=;
        b=mvGoCUsYUcro7S5D7derj9nuzdLIrLHS0UeOyRfOC8rT8/Lc4Sv5vOArPHZ8omtZak
         S44jTf9V5N9rDov1CWDI5K3H2vwaXnnyOGe5p8tyeWV59/THZCUF/nzAQc1IXqNCjpG4
         l1b9tE/lw4TGsAGhpwJc5OwPm6AXct7x7aOC53LlK8lYuNvxRs6dMANucAzTxirHwnxb
         QTwKKWjffHAL4I1sZMGkwnC47u+qmFmTHj+LACelu6lgyCOdC9b7fljcJMWcVWRjQbRM
         9Mn/aWXHPQhATaCa26dfLUW1TQpaE5YMputUvw3ulKdfAV79x0gmRu3sU/4UVHsGDxEW
         8FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9+TCZLLMqZE4Cspbo3e1dwusVFmwRs3cKgkqAh7H7o=;
        b=uq0mWOzpIG6im5HQcMrjZEs5hMdtcxO4HhG9FkSAmKTIIjM8eoz0vKzGRNIIiEcFKc
         F09DlHC6vhJegwex/rZ7+O/zMtUp0P4jw9RRPz/batV/79fyr6JzWIGR8KMpNnptMIgX
         aBpvJkhpiDQ0QtFltnL3fNFc3zgzUKOAmX7cQ5qDcn/KlITqDCJdwAf38dQHISpIcmkb
         lY72PoGwq09whNd0dVl1PcCEJgKLQ0hDD1I927N2qA8p56GUYkrGFxUiToPrUmsDZXSM
         rUE4AVPYNns84BuVlEFYhgZTNvJA/SD56KJSpsl84zTms0J+zDI2EqFYize8OYzqVPoz
         a+Tw==
X-Gm-Message-State: AOAM530H+RMhbIizgTHebfF78k9+fBP4xg4QCW3IbxTOVw/YH38vKkih
        bKgYXuHfgMtGbvoCqHBIlYW6Qroh9Q==
X-Google-Smtp-Source: ABdhPJziEC0Whwwnh0ZT4xoCeQwm1w/yGOxXC3LLZcLOrkf8H/TA0SqGa36259vbUa95+JLW5HD5sw==
X-Received: by 2002:a05:620a:2682:: with SMTP id c2mr2008075qkp.24.1638305763513;
        Tue, 30 Nov 2021 12:56:03 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id t11sm10549356qkp.56.2021.11.30.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:56:03 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 3/6] x86-64: Use relative per-cpu offsets
Date:   Tue, 30 Nov 2021 15:55:46 -0500
Message-Id: <20211130205549.116673-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130205549.116673-1-brgerst@gmail.com>
References: <20211130205549.116673-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-cpu section is currently linked at virtual address 0, because
older compilers hardcoded the stack protector canary value at a fixed
offset from the start of the GS segment.  Now that the canary is a
normal per-cpu variable, the special handling of the per-cpu section
can be removed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/percpu.h  |  22 ------
 arch/x86/kernel/head_64.S      |   6 +-
 arch/x86/kernel/irq_64.c       |   1 -
 arch/x86/kernel/setup_percpu.c |  12 +--
 arch/x86/kernel/vmlinux.lds.S  |  27 -------
 arch/x86/tools/relocs.c        | 135 +--------------------------------
 init/Kconfig                   |   1 -
 7 files changed, 6 insertions(+), 198 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a3c33b79fb86..5418f0a4d073 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -16,12 +16,6 @@
 #define PER_CPU_VAR(var)	var
 #endif	/* SMP */
 
-#ifdef CONFIG_X86_64_SMP
-#define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
-#else
-#define INIT_PER_CPU_VAR(var)  var
-#endif
-
 #else /* ...!ASSEMBLY */
 
 #include <linux/kernel.h>
@@ -49,22 +43,6 @@
 
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 
-/*
- * Initialized pointers to per-cpu variables needed for the boot
- * processor need to use these macros to get the proper address
- * offset from __per_cpu_load on SMP.
- *
- * There also must be an entry in vmlinux_64.lds.S
- */
-#define DECLARE_INIT_PER_CPU(var) \
-       extern typeof(var) init_per_cpu_var(var)
-
-#ifdef CONFIG_X86_64_SMP
-#define init_per_cpu_var(var)  init_per_cpu__##var
-#else
-#define init_per_cpu_var(var)  var
-#endif
-
 /* For arch-specific code, we can use direct single-insn ops (they
  * don't give an lvalue though). */
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 833f747e74ee..1b8c9919afdb 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -335,11 +335,7 @@ SYM_CODE_END(vc_boot_ghcb)
 	__REFDATA
 	.balign	8
 SYM_DATA(initial_code,	.quad x86_64_start_kernel)
-#ifdef CONFIG_SMP
-SYM_DATA(initial_gs,	.quad __per_cpu_load)
-#else
 SYM_DATA(initial_gs,	.quad 0)
-#endif
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
@@ -572,7 +568,7 @@ SYM_DATA_END(level1_fixmap_pgt)
 	.align 16
 
 SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
-SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
+SYM_DATA_LOCAL(early_gdt_descr_base,	.quad gdt_page)
 
 	.align 16
 /* This must match the first entry in level2_kernel_pgt */
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 1c0fb96b9e39..df537518983e 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,7 +26,6 @@
 #include <asm/apic.h>
 
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
-DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_VMAP_STACK
 /*
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 7b65275544b2..a2489b31564e 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -26,18 +26,10 @@
 DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
-#ifdef CONFIG_X86_64
-#define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
-#else
-#define BOOT_PERCPU_OFFSET 0
-#endif
-
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off) = BOOT_PERCPU_OFFSET;
+DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
-unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init = {
-	[0 ... NR_CPUS-1] = BOOT_PERCPU_OFFSET,
-};
+unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;
 EXPORT_SYMBOL(__per_cpu_offset);
 
 /*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 18a01ece43ee..a72288fa4691 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -103,9 +103,6 @@ PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_SMP
-	percpu PT_LOAD FLAGS(6);        /* RW_ */
-#endif
 	init PT_LOAD FLAGS(7);          /* RWE */
 #endif
 	note PT_NOTE FLAGS(0);          /* ___ */
@@ -215,17 +212,6 @@ SECTIONS
 		__init_begin = .; /* paired with __init_end */
 	}
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
-	/*
-	 * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes the
-	 * output PHDR, so the next output section - .init.text - should
-	 * start another segment - init.
-	 */
-	PERCPU_VADDR(INTERNODE_CACHE_BYTES, 0, :percpu)
-	ASSERT(SIZEOF(.data..percpu) < CONFIG_PHYSICAL_START,
-	       "per-CPU data too large - increase CONFIG_PHYSICAL_START")
-#endif
-
 	INIT_TEXT_SECTION(PAGE_SIZE)
 #ifdef CONFIG_X86_64
 	:init
@@ -339,9 +325,7 @@ SECTIONS
 		EXIT_DATA
 	}
 
-#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
-#endif
 
 	. = ALIGN(PAGE_SIZE);
 
@@ -474,17 +458,6 @@ SECTIONS
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
-#ifdef CONFIG_X86_64
-/*
- * Per-cpu symbols which need to be offset from __per_cpu_load
- * for the boot processor.
- */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
-INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(irq_stack_backing_store);
-
-#endif /* CONFIG_X86_64 */
-
 #ifdef CONFIG_KEXEC_CORE
 #include <asm/kexec.h>
 
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 9b3d51cb2cd1..b27980291ff8 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -83,8 +83,6 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"__initramfs_start|"
 	"(jiffies|jiffies_64)|"
 #if ELF_BITS == 64
-	"__per_cpu_load|"
-	"init_per_cpu__.*|"
 	"__end_rodata_hpage_align|"
 #endif
 	"__vvar_page|"
@@ -280,33 +278,6 @@ static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
 	return name;
 }
 
-static Elf_Sym *sym_lookup(const char *symname)
-{
-	int i;
-	for (i = 0; i < shnum; i++) {
-		struct section *sec = &secs[i];
-		long nsyms;
-		char *strtab;
-		Elf_Sym *symtab;
-		Elf_Sym *sym;
-
-		if (sec->shdr.sh_type != SHT_SYMTAB)
-			continue;
-
-		nsyms = sec->shdr.sh_size/sizeof(Elf_Sym);
-		symtab = sec->symtab;
-		strtab = sec->link->strtab;
-
-		for (sym = symtab; --nsyms >= 0; sym++) {
-			if (!sym->st_name)
-				continue;
-			if (strcmp(symname, strtab + sym->st_name) == 0)
-				return sym;
-		}
-	}
-	return 0;
-}
-
 #if BYTE_ORDER == LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
 #define le32_to_cpu(val) (val)
@@ -749,80 +720,8 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 	}
 }
 
-/*
- * The .data..percpu section is a special case for x86_64 SMP kernels.
- * It is used to initialize the actual per_cpu areas and to provide
- * definitions for the per_cpu variables that correspond to their offsets
- * within the percpu area. Since the values of all of the symbols need
- * to be offsets from the start of the per_cpu area the virtual address
- * (sh_addr) of .data..percpu is 0 in SMP kernels.
- *
- * This means that:
- *
- *	Relocations that reference symbols in the per_cpu area do not
- *	need further relocation (since the value is an offset relative
- *	to the start of the per_cpu area that does not change).
- *
- *	Relocations that apply to the per_cpu area need to have their
- *	offset adjusted by by the value of __per_cpu_load to make them
- *	point to the correct place in the loaded image (because the
- *	virtual address of .data..percpu is 0).
- *
- * For non SMP kernels .data..percpu is linked as part of the normal
- * kernel data and does not require special treatment.
- *
- */
-static int per_cpu_shndx	= -1;
-static Elf_Addr per_cpu_load_addr;
-
-static void percpu_init(void)
-{
-	int i;
-	for (i = 0; i < shnum; i++) {
-		ElfW(Sym) *sym;
-		if (strcmp(sec_name(i), ".data..percpu"))
-			continue;
-
-		if (secs[i].shdr.sh_addr != 0)	/* non SMP kernel */
-			return;
-
-		sym = sym_lookup("__per_cpu_load");
-		if (!sym)
-			die("can't find __per_cpu_load\n");
-
-		per_cpu_shndx = i;
-		per_cpu_load_addr = sym->st_value;
-		return;
-	}
-}
-
 #if ELF_BITS == 64
 
-/*
- * Check to see if a symbol lies in the .data..percpu section.
- *
- * The linker incorrectly associates some symbols with the
- * .data..percpu section so we also need to check the symbol
- * name to make sure that we classify the symbol correctly.
- *
- * The GNU linker incorrectly associates:
- *	__init_begin
- *	__per_cpu_load
- *
- * The "gold" linker incorrectly associates:
- *	init_per_cpu__gdt_page
- */
-static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
-{
-	int shndx = sym_index(sym);
-
-	return (shndx == per_cpu_shndx) &&
-		strcmp(symname, "__init_begin") &&
-		strcmp(symname, "__per_cpu_load") &&
-		strncmp(symname, "init_per_cpu_", 13);
-}
-
-
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
@@ -833,47 +732,21 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	if (sym->st_shndx == SHN_UNDEF)
 		return 0;
 
-	/*
-	 * Adjust the offset if this reloc applies to the percpu section.
-	 */
-	if (sec->shdr.sh_info == per_cpu_shndx)
-		offset += per_cpu_load_addr;
-
 	switch (r_type) {
 	case R_X86_64_NONE:
-		/* NONE can be ignored. */
-		break;
-
 	case R_X86_64_PC32:
 	case R_X86_64_PLT32:
-		/*
-		 * PC relative relocations don't need to be adjusted unless
-		 * referencing a percpu symbol.
-		 *
-		 * NB: R_X86_64_PLT32 can be treated as R_X86_64_PC32.
-		 */
-		if (is_percpu_sym(sym, symname))
-			add_reloc(&relocs32neg, offset);
-		break;
-
 	case R_X86_64_PC64:
 		/*
-		 * Only used by jump labels
+		 * NONE can be ignored and PC relative relocations don't need
+		 * to be adjusted. Because sym must be defined, R_X86_64_PLT32 can
+		 * be treated the same way as R_X86_64_PC32.
 		 */
-		if (is_percpu_sym(sym, symname))
-			die("Invalid R_X86_64_PC64 relocation against per-CPU symbol %s\n",
-			    symname);
 		break;
 
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
-		/*
-		 * References to the percpu area don't need to be adjusted.
-		 */
-		if (is_percpu_sym(sym, symname))
-			break;
-
 		if (shn_abs) {
 			/*
 			 * Whitelisted absolute symbols do not require
@@ -1175,8 +1048,6 @@ void process(FILE *fp, int use_real_mode, int as_text,
 	read_strtabs(fp);
 	read_symtabs(fp);
 	read_relocs(fp);
-	if (ELF_BITS == 64)
-		percpu_init();
 	if (show_absolute_syms) {
 		print_absolute_symbols();
 		return;
diff --git a/init/Kconfig b/init/Kconfig
index 41a728debdbd..943552dc9c19 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1714,7 +1714,6 @@ config KALLSYMS_ALL
 config KALLSYMS_ABSOLUTE_PERCPU
 	bool
 	depends on KALLSYMS
-	default X86_64 && SMP
 
 config KALLSYMS_BASE_RELATIVE
 	bool
-- 
2.31.1

