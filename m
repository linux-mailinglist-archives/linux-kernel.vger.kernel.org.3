Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C034526B26
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384204AbiEMUW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384169AbiEMUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECA91611DF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f4e17a5809so81516207b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=pCLU/hXWpDFHII+5GFPvqWhTC0IvLx0cTjkTj7lZmbc=;
        b=Mjo3Zg4GXcSEYygFB3gUeYErey3L9NNmSyjOIi18QzNpHfJy9bulp3ty3kddEgJ9J4
         OPopww/RNZMAY9EqNOt8UF/ur5jA4xe6Vl4e4J9AaOMr5Cvr53O0MDj9V6zOuahgukPh
         whNbmEtNYcTwmi5ExvRm3P7wuEcc3XI3iMrUTv/+vhWbGaJN7D8iBsSS8Yiv4aD4qdX2
         RR4Phvjc5oomZsk9nHp90Pe1Hzk3aTdyy6u1oGKYCyAyoFiiPohavnqrLuMge9o3occh
         IY17V2npSM/kSAcnAxOw8PLdxW+pSd5E2wi75qbJAw0bn5FUPhJZUWJItdmmZ+cDRi4X
         jEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=pCLU/hXWpDFHII+5GFPvqWhTC0IvLx0cTjkTj7lZmbc=;
        b=Yfv9Muc3PnR0dMdeNmVZ6nf+74Nz9CWVhD+YJc7pOtoQqON0a3t+ns+j3NNfgqXmwl
         +lm35/LTKW3XY1932Z7RPWpHJOzacK93+hw3Q47Iw+USIoLNhHwgy9d25yxmD305aAtJ
         l/P3ERfM9ExxhMWErkSlC+6JmaKjqlQOYkaBQPdgTYSEZLs/m0VUuAEDbjzd0u8yx5Iw
         UUlAgIMZ44ElvXdAMjd5bH+w3OSkvE/aWKL7sD0lp2awFmmQ6F0GVd2UAnWMq2r1pFgH
         6HwoetqpH6484CYpvqxAZJa2bN80/Z1ZefiwA+DEGL/u05D7u999cZNaGz1rjBzLSo4K
         BQdQ==
X-Gm-Message-State: AOAM531R0CgXc5NGk0F3CZCpFAWq9A9r2gd3W1rTa1lT39amC78ROwTE
        JkFVoiHkOFyJ/ywvyp7L1Tl0uHFMgA/H/0Y85XGHglhegxKAoMRs5KY+Xd4PfNiw52R1gtRQNCd
        vS97tMc5MTcKVx9HLFrf1jONTk9+Z9nbpf58z+69y0OIHQBIsWssXPC/iHc0deGDHdrSmK0ap+a
        ANzbSinRrOeg==
X-Google-Smtp-Source: ABdhPJy565vLDtoozxUDDhWLLpuoP38XA6FVRX2KCRBMjTPvFI8LzIegV3p504NDk/E/gB0tUPauPneqNQ2rk7e5uq8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a0d:d0c1:0:b0:2dc:5950:c72f with SMTP
 id s184-20020a0dd0c1000000b002dc5950c72fmr7381095ywd.185.1652473335511; Fri,
 13 May 2022 13:22:15 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:44 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=15262; h=from:subject;
 bh=o6CdCuNcxPwKwpmkpv7p1X90CAdPdvaaWPEtZqzJ3XE=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3j6rhd7VRsqD7zucXreXJ7ZaNf6DPaYMcLutG9
 7vnfmlOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn694wAKCRBMtfaEi7xW7r0QC/
 97uOH7x5RKTU/aAHQLlxOmNegxtd2PtEXwOXGVEKW203D4f6n5MqdBdM2Jj6NLSMS2zVXhO1Ix6JpJ
 wTeaiv5+oMu5GTzWiYkYpDvT7RugGEiOdwW3lWmrX+/8B0G1XbIZyDkLykymeurzjZcG9L5tDgR8M/
 jVIirG2M0l5jtzmMmkfqjH/KYcOHCxTwRs2HE0wpmb0SX2Ctpdymw8SuT+vzzGM2KsqQHYJK7Hzob7
 bA+KuvgvhQgsgA3pvWOEa/nIQ1wAQTaRTsjs8UeV/Uokf6fNitmtiHztvm3oFpMvySBJQLK6fMjD6j
 aB+WZH+h5FgVTvUVQNkQHy+SZvgJZ1Wn5DgpfZ8Q0GpJbVLszH9dC2dp8j+GR7td5Z61OEJOxELkJl
 4R1qr8PF8PdrxXEvDYZkcQig4q/1lsv834hPEbiZMk0Su5+XsWidHS8xX8cCa52ewu1zuR82hnQK2F
 us/l/jDOQgh5ZvSyIcOZ6nuHO4c6PRKyUK8gB/+FtSfgA=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 06/21] cfi: Switch to -fsanitize=kcfi
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from Clang's original forward-edge control-flow integrity
implementation to -fsanitize=3Dkcfi, which is better suited for the
kernel, as it doesn't require LTO, doesn't use a jump table that
requires altering function references, and won't break cross-module
function address equality.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile                          |  13 +--
 arch/Kconfig                      |  11 ++-
 include/asm-generic/vmlinux.lds.h |  37 ++++-----
 include/linux/cfi.h               |  35 +++++++--
 include/linux/compiler-clang.h    |   6 +-
 include/linux/module.h            |   6 +-
 kernel/cfi.c                      | 126 ++++++++++++++----------------
 kernel/module.c                   |  34 +-------
 scripts/module.lds.S              |  23 +-----
 9 files changed, 128 insertions(+), 163 deletions(-)

diff --git a/Makefile b/Makefile
index 2284d1ca2503..8439551954f1 100644
--- a/Makefile
+++ b/Makefile
@@ -915,18 +915,7 @@ export CC_FLAGS_LTO
 endif
=20
 ifdef CONFIG_CFI_CLANG
-CC_FLAGS_CFI	:=3D -fsanitize=3Dcfi \
-		   -fsanitize-cfi-cross-dso \
-		   -fno-sanitize-cfi-canonical-jump-tables \
-		   -fno-sanitize-trap=3Dcfi \
-		   -fno-sanitize-blacklist
-
-ifdef CONFIG_CFI_PERMISSIVE
-CC_FLAGS_CFI	+=3D -fsanitize-recover=3Dcfi
-endif
-
-# If LTO flags are filtered out, we must also filter out CFI.
-CC_FLAGS_LTO	+=3D $(CC_FLAGS_CFI)
+CC_FLAGS_CFI	:=3D -fsanitize=3Dkcfi
 KBUILD_CFLAGS	+=3D $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index 625db6376726..f179170cb422 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -720,14 +720,13 @@ config ARCH_SUPPORTS_CFI_CLANG
 	  An architecture should select this option if it can support Clang's
 	  Control-Flow Integrity (CFI) checking.
=20
+config ARCH_USES_CFI_TRAPS
+	bool
+
 config CFI_CLANG
 	bool "Use Clang's Control Flow Integrity (CFI)"
-	depends on LTO_CLANG && ARCH_SUPPORTS_CFI_CLANG
-	# Clang >=3D 12:
-	# - https://bugs.llvm.org/show_bug.cgi?id=3D46258
-	# - https://bugs.llvm.org/show_bug.cgi?id=3D47479
-	depends on CLANG_VERSION >=3D 120000
-	select KALLSYMS
+	depends on ARCH_SUPPORTS_CFI_CLANG
+	depends on $(cc-option,-fsanitize=3Dkcfi)
 	help
 	  This option enables Clang=E2=80=99s forward-edge Control Flow Integrity
 	  (CFI) checking, where the compiler injects a runtime check to each
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index 69138e9db787..fcb3c7146a43 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -421,6 +421,22 @@
 	__end_ro_after_init =3D .;
 #endif
=20
+/*
+ * .kcfi_traps contains a list KCFI trap locations.
+ */
+#ifndef KCFI_TRAPS
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+#define KCFI_TRAPS							\
+	__kcfi_traps : AT(ADDR(__kcfi_traps) - LOAD_OFFSET) {		\
+		__start___kcfi_traps =3D .;				\
+		KEEP(*(.kcfi_traps))					\
+		__stop___kcfi_traps =3D .;				\
+	}
+#else
+#define KCFI_TRAPS
+#endif
+#endif
+
 /*
  * Read only Data
  */
@@ -529,6 +545,8 @@
 		__stop___modver =3D .;					\
 	}								\
 									\
+	KCFI_TRAPS							\
+									\
 	RO_EXCEPTION_TABLE						\
 	NOTES								\
 	BTF								\
@@ -537,21 +555,6 @@
 	__end_rodata =3D .;
=20
=20
-/*
- * .text..L.cfi.jumptable.* contain Control-Flow Integrity (CFI)
- * jump table entries.
- */
-#ifdef CONFIG_CFI_CLANG
-#define TEXT_CFI_JT							\
-		. =3D ALIGN(PMD_SIZE);					\
-		__cfi_jt_start =3D .;					\
-		*(.text..L.cfi.jumptable .text..L.cfi.jumptable.*)	\
-		. =3D ALIGN(PMD_SIZE);					\
-		__cfi_jt_end =3D .;
-#else
-#define TEXT_CFI_JT
-#endif
-
 /*
  * Non-instrumentable text section
  */
@@ -579,7 +582,6 @@
 		*(.text..refcount)					\
 		*(.ref.text)						\
 		*(.text.asan.* .text.tsan.*)				\
-		TEXT_CFI_JT						\
 	MEM_KEEP(init.text*)						\
 	MEM_KEEP(exit.text*)						\
=20
@@ -1008,8 +1010,7 @@
  * keep any .init_array.* sections.
  * https://bugs.llvm.org/show_bug.cgi?id=3D46478
  */
-#if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || define=
d(CONFIG_KCSAN) || \
-	defined(CONFIG_CFI_CLANG)
+#if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || define=
d(CONFIG_KCSAN)
 # ifdef CONFIG_CONSTRUCTORS
 #  define SANITIZER_DISCARDS						\
 	*(.eh_frame)
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 2cdbc0fbd0ab..655b8b10ac3d 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -2,17 +2,42 @@
 /*
  * Clang Control Flow Integrity (CFI) support.
  *
- * Copyright (C) 2021 Google LLC
+ * Copyright (C) 2022 Google LLC
  */
 #ifndef _LINUX_CFI_H
 #define _LINUX_CFI_H
=20
+#include <linux/bug.h>
+#include <linux/module.h>
+
 #ifdef CONFIG_CFI_CLANG
-typedef void (*cfi_check_fn)(uint64_t id, void *ptr, void *diag);
+enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long =
addr,
+				      unsigned long target, unsigned long type);
+#else
+static inline enum bug_trap_type report_cfi_failure(struct pt_regs *regs,
+						    unsigned long addr,
+						    unsigned long target,
+						    unsigned long type)
+{
+	return BUG_TRAP_TYPE_NONE;
+}
+#endif /* CONFIG_CFI_CLANG */
=20
-/* Compiler-generated function in each module, and the kernel */
-extern void __cfi_check(uint64_t id, void *ptr, void *diag);
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+bool is_cfi_trap(unsigned long addr);
+#else
+static inline bool is_cfi_trap(unsigned long addr) { return false; }
+#endif /* CONFIG_ARCH_USES_CFI_TRAPS */
=20
-#endif /* CONFIG_CFI_CLANG */
+#ifdef CONFIG_MODULES
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+void module_cfi_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+			 struct module *mod);
+#else
+static inline void module_cfi_finalize(const Elf_Ehdr *hdr,
+				       const Elf_Shdr *sechdrs,
+				       struct module *mod) {}
+#endif /* CONFIG_ARCH_USES_CFI_TRAPS */
+#endif /* CONFIG_MODULES */
=20
 #endif /* _LINUX_CFI_H */
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.=
h
index babb1347148c..42e55579d649 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -66,8 +66,10 @@
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
=20
-#define __nocfi		__attribute__((__no_sanitize__("cfi")))
-#define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
+#if __has_feature(kcfi)
+/* Disable CFI checking inside a function. */
+#define __nocfi		__attribute__((__no_sanitize__("kcfi")))
+#endif
=20
 /*
  * Turn individual warnings and errors on and off locally, depending
diff --git a/include/linux/module.h b/include/linux/module.h
index 87857275c047..3b485834be74 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -27,7 +27,6 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
-#include <linux/cfi.h>
=20
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -388,8 +387,9 @@ struct module {
 	const s32 *crcs;
 	unsigned int num_syms;
=20
-#ifdef CONFIG_CFI_CLANG
-	cfi_check_fn cfi_check;
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+	unsigned long *kcfi_traps;
+	unsigned long *kcfi_traps_end;
 #endif
=20
 	/* Kernel parameters. */
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 2cc0d01ea980..456d5eac082a 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -1,94 +1,86 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Clang Control Flow Integrity (CFI) error and slowpath handling.
+ * Clang Control Flow Integrity (CFI) error handling.
  *
- * Copyright (C) 2021 Google LLC
+ * Copyright (C) 2022 Google LLC
  */
=20
-#include <linux/hardirq.h>
-#include <linux/kallsyms.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/printk.h>
-#include <linux/ratelimit.h>
-#include <linux/rcupdate.h>
-#include <linux/vmalloc.h>
-#include <asm/cacheflush.h>
-#include <asm/set_memory.h>
-
-/* Compiler-defined handler names */
-#ifdef CONFIG_CFI_PERMISSIVE
-#define cfi_failure_handler	__ubsan_handle_cfi_check_fail
-#else
-#define cfi_failure_handler	__ubsan_handle_cfi_check_fail_abort
-#endif
-
-static inline void handle_cfi_failure(void *ptr)
-{
-	if (IS_ENABLED(CONFIG_CFI_PERMISSIVE))
-		WARN_RATELIMIT(1, "CFI failure (target: %pS):\n", ptr);
-	else
-		panic("CFI failure (target: %pS)\n", ptr);
-}
-
-#ifdef CONFIG_MODULES
+#include <linux/cfi.h>
=20
-static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
+enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long =
addr,
+				      unsigned long target, unsigned long type)
 {
-	cfi_check_fn fn =3D NULL;
-	struct module *mod;
+	pr_err("CFI failure at %pS (target: %pS; expected type: 0x%08x)\n",
+	       (void *)addr, (void *)target, (u32)type);
=20
-	rcu_read_lock_sched_notrace();
-	mod =3D __module_address(ptr);
-	if (mod)
-		fn =3D mod->cfi_check;
-	rcu_read_unlock_sched_notrace();
+	if (IS_ENABLED(CONFIG_CFI_PERMISSIVE)) {
+		__warn(NULL, 0, (void *)addr, 0, regs, NULL);
+		return BUG_TRAP_TYPE_WARN;
+	}
=20
-	return fn;
+	return BUG_TRAP_TYPE_BUG;
 }
=20
-static inline cfi_check_fn find_check_fn(unsigned long ptr)
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+#ifdef CONFIG_MODULES
+/* Populates `kcfi_trap(_end)?` fields in `struct module`. */
+void module_cfi_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+			 struct module *mod)
 {
-	cfi_check_fn fn =3D NULL;
+	char *secstrings;
+	unsigned int i;
=20
-	if (is_kernel_text(ptr))
-		return __cfi_check;
+	mod->kcfi_traps =3D NULL;
+	mod->kcfi_traps_end =3D NULL;
=20
-	/*
-	 * Indirect call checks can happen when RCU is not watching. Both
-	 * the shadow and __module_address use RCU, so we need to wake it
-	 * up if necessary.
-	 */
-	RCU_NONIDLE({
-		fn =3D find_module_check_fn(ptr);
-	});
+	secstrings =3D (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
=20
-	return fn;
+	for (i =3D 1; i < hdr->e_shnum; i++) {
+		if (strcmp(secstrings + sechdrs[i].sh_name, "__kcfi_traps"))
+			continue;
+
+		mod->kcfi_traps =3D (unsigned long *)sechdrs[i].sh_addr;
+		mod->kcfi_traps_end =3D (unsigned long *)(sechdrs[i].sh_addr +
+							sechdrs[i].sh_size);
+		break;
+	}
 }
=20
-void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
+static bool is_module_cfi_trap(unsigned long addr)
 {
-	cfi_check_fn fn =3D find_check_fn((unsigned long)ptr);
+	bool found =3D false;
+	struct module *mod;
+	unsigned long *p;
=20
-	if (likely(fn))
-		fn(id, ptr, diag);
-	else /* Don't allow unchecked modules */
-		handle_cfi_failure(ptr);
-}
-EXPORT_SYMBOL(__cfi_slowpath_diag);
+	rcu_read_lock_sched_notrace();
=20
-#else /* !CONFIG_MODULES */
+	mod =3D __module_address(addr);
+	if (mod)
+		for (p =3D mod->kcfi_traps; !found && p < mod->kcfi_traps_end; ++p)
+			found =3D (*p =3D=3D addr);
+
+	rcu_read_unlock_sched_notrace();
=20
-void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
+	return found;
+}
+#else /* CONFIG_MODULES */
+static inline bool is_module_cfi_trap(unsigned long addr)
 {
-	handle_cfi_failure(ptr); /* No modules */
+	return false;
 }
-EXPORT_SYMBOL(__cfi_slowpath_diag);
-
 #endif /* CONFIG_MODULES */
=20
-void cfi_failure_handler(void *data, void *ptr, void *vtable)
+extern unsigned long __start___kcfi_traps[];
+extern unsigned long __stop___kcfi_traps[];
+
+bool is_cfi_trap(unsigned long addr)
 {
-	handle_cfi_failure(ptr);
+	unsigned long *p;
+
+	for (p =3D __start___kcfi_traps; p < __stop___kcfi_traps; ++p)
+		if (*p =3D=3D addr)
+			return true;
+
+	return is_module_cfi_trap(addr);
 }
-EXPORT_SYMBOL(cfi_failure_handler);
+#endif /* CONFIG_ARCH_USES_CFI_TRAPS */
diff --git a/kernel/module.c b/kernel/module.c
index 296fe02323e9..411ae8c358e6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -57,6 +57,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/cfi.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
=20
@@ -3871,8 +3872,9 @@ static int complete_formation(struct module *mod, str=
uct load_info *info)
 	if (err < 0)
 		goto out;
=20
-	/* This relies on module_mutex for list integrity. */
+	/* These rely on module_mutex for list integrity. */
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
+	module_cfi_finalize(info->hdr, info->sechdrs, mod);
=20
 	module_enable_ro(mod, false);
 	module_enable_nx(mod);
@@ -3928,8 +3930,6 @@ static int unknown_module_param_cb(char *param, char =
*val, const char *modname,
 	return 0;
 }
=20
-static void cfi_init(struct module *mod);
-
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -4059,9 +4059,6 @@ static int load_module(struct load_info *info, const =
char __user *uargs,
=20
 	flush_module_icache(mod);
=20
-	/* Setup CFI for the module. */
-	cfi_init(mod);
-
 	/* Now copy in args */
 	mod->args =3D strndup_user(uargs, ~0UL >> 1);
 	if (IS_ERR(mod->args)) {
@@ -4502,31 +4499,6 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *,=
 const char *,
 #endif /* CONFIG_LIVEPATCH */
 #endif /* CONFIG_KALLSYMS */
=20
-static void cfi_init(struct module *mod)
-{
-#ifdef CONFIG_CFI_CLANG
-	initcall_t *init;
-	exitcall_t *exit;
-
-	rcu_read_lock_sched();
-	mod->cfi_check =3D (cfi_check_fn)
-		find_kallsyms_symbol_value(mod, "__cfi_check");
-	init =3D (initcall_t *)
-		find_kallsyms_symbol_value(mod, "__cfi_jt_init_module");
-	exit =3D (exitcall_t *)
-		find_kallsyms_symbol_value(mod, "__cfi_jt_cleanup_module");
-	rcu_read_unlock_sched();
-
-	/* Fix init/exit functions to point to the CFI jump table */
-	if (init)
-		mod->init =3D *init;
-#ifdef CONFIG_MODULE_UNLOAD
-	if (exit)
-		mod->exit =3D *exit;
-#endif
-#endif
-}
-
 /* Maximum number of characters written by module_flags() */
 #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
=20
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 1d0e1e4dc3d2..0708896139cc 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,20 +3,10 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
-#ifdef CONFIG_CFI_CLANG
-# include <asm/page.h>
-# define ALIGN_CFI 		ALIGN(PAGE_SIZE)
-# define SANITIZER_DISCARDS	*(.eh_frame)
-#else
-# define ALIGN_CFI
-# define SANITIZER_DISCARDS
-#endif
-
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
-		SANITIZER_DISCARDS
 	}
=20
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
@@ -31,6 +21,10 @@ SECTIONS {
=20
 	__patchable_function_entries : { *(__patchable_function_entries) }
=20
+#ifdef CONFIG_ARCH_USES_CFI_TRAPS
+	__kcfi_traps 		: { KEEP(*(.kcfi_traps)) }
+#endif
+
 #ifdef CONFIG_LTO_CLANG
 	/*
 	 * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
@@ -51,15 +45,6 @@ SECTIONS {
 		*(.rodata .rodata.[0-9a-zA-Z_]*)
 		*(.rodata..L*)
 	}
-
-	/*
-	 * With CONFIG_CFI_CLANG, we assume __cfi_check is at the beginning
-	 * of the .text section, and is aligned to PAGE_SIZE.
-	 */
-	.text : ALIGN_CFI {
-		*(.text.__cfi_check)
-		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
-	}
 #endif
 }
=20
--=20
2.36.0.550.gb090851708-goog

