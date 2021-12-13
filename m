Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08AF472875
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhLMKNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbhLMKEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147D9C01CB3C;
        Mon, 13 Dec 2021 01:50:27 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nG9adFk8yvm9GidNOqVsupXz8HnXf1Ut5MUPEXZCEwY=;
        b=teTjhcfjxiRDle3HbkHxGP0T1csxYKxmHrOlbLpj+csOylJZk9i9VzbD0KfphXbJWCBgaU
        gPgh+TTRcAJZXlLr3WjV639lVc2BkcuWEShmYXrLlQ0+g/Gb804UTSV21ljsM4uD0DiBhA
        Jvv627nwgcQIIz1kDUdc6xM5DNnbMReshh9Zc4A7qUi/NcI8ukk9YzsPjDbF8XysgETAN+
        aV2uNljRLNEGOsopKnsrC0g5ohwTNSDZj5Bb0BwpMVfv9gqslvEjdoi0CMiVaPb/PZSsDs
        uNx4OdxkTQi1fHKw1n7iE5G5TX2uevS+cFeGLFeOk3DIaYweYqKx5qVUmHmLZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nG9adFk8yvm9GidNOqVsupXz8HnXf1Ut5MUPEXZCEwY=;
        b=pcFXtAm44BJyiKsK5bexFOEYAm6FbD/bGvtspQiCXWz0Dh3SeHCyYC60F/epD5tedGHa4D
        pjEYg8AX07AL5ZCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mmx_32: Remove X86_USE_3DNOW
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YZKQzUmeNuwyvZpk@hirez.programming.kicks-ass.net>
References: <YZKQzUmeNuwyvZpk@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163938902439.23020.355741123201987633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c6dbd3e5e69cf3ca47a3864115d4cbdd44619243
Gitweb:        https://git.kernel.org/tip/c6dbd3e5e69cf3ca47a3864115d4cbdd44619243
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 Nov 2021 17:46:39 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:45 +01:00

x86/mmx_32: Remove X86_USE_3DNOW

This code puts an exception table entry on the PREFETCH instruction to
overwrite it with a JMP.d8 when it triggers an exception. Except of
course, our code is no longer writable, also SMP.

Instead of fixing this broken mess, simply take it out.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/YZKQzUmeNuwyvZpk@hirez.programming.kicks-ass.net
---
 arch/x86/Kconfig                               |   2 +-
 arch/x86/Kconfig.cpu                           |   4 +-
 arch/x86/include/asm/mmx.h                     |  15 +-
 arch/x86/include/asm/page_32.h                 |  14 +-
 arch/x86/include/asm/required-features.h       |   4 +-
 arch/x86/include/asm/string_32.h               |  33 +-
 arch/x86/lib/Makefile                          |   1 +-
 arch/x86/lib/memcpy_32.c                       |   4 +-
 arch/x86/lib/mmx_32.c                          | 388 +----------------
 arch/x86/lib/usercopy_32.c                     |   1 +-
 tools/arch/x86/include/asm/required-features.h |   4 +-
 11 files changed, 1 insertion(+), 469 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index dd13ba8..0c9c680 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1957,7 +1957,7 @@ config EFI
 
 config EFI_STUB
 	bool "EFI stub support"
-	depends on EFI && !X86_USE_3DNOW
+	depends on EFI
 	depends on $(cc-option,-mabi=ms) || X86_32
 	select RELOCATABLE
 	help
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index eefc434..542377c 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -342,10 +342,6 @@ config X86_USE_PPRO_CHECKSUM
 	def_bool y
 	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM
 
-config X86_USE_3DNOW
-	def_bool y
-	depends on (MCYRIXIII || MK7 || MGEODE_LX) && !UML
-
 #
 # P6_NOPs are a relatively minor optimization that require a family >=
 # 6 processor, except that it is broken on certain VIA chips.
diff --git a/arch/x86/include/asm/mmx.h b/arch/x86/include/asm/mmx.h
index f572d0f..e69de29 100644
--- a/arch/x86/include/asm/mmx.h
+++ b/arch/x86/include/asm/mmx.h
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_MMX_H
-#define _ASM_X86_MMX_H
-
-/*
- *	MMX 3Dnow! helper operations
- */
-
-#include <linux/types.h>
-
-extern void *_mmx_memcpy(void *to, const void *from, size_t size);
-extern void mmx_clear_page(void *page);
-extern void mmx_copy_page(void *to, void *from);
-
-#endif /* _ASM_X86_MMX_H */
diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index b13f848..df42f8a 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -19,19 +19,6 @@ extern unsigned long __phys_addr(unsigned long);
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #endif /* CONFIG_FLATMEM */
 
-#ifdef CONFIG_X86_USE_3DNOW
-#include <asm/mmx.h>
-
-static inline void clear_page(void *page)
-{
-	mmx_clear_page(page);
-}
-
-static inline void copy_page(void *to, void *from)
-{
-	mmx_copy_page(to, from);
-}
-#else  /* !CONFIG_X86_USE_3DNOW */
 #include <linux/string.h>
 
 static inline void clear_page(void *page)
@@ -43,7 +30,6 @@ static inline void copy_page(void *to, void *from)
 {
 	memcpy(to, from, PAGE_SIZE);
 }
-#endif	/* CONFIG_X86_USE_3DNOW */
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PAGE_32_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index b2d504f..aff7747 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -35,11 +35,7 @@
 # define NEED_CMOV	0
 #endif
 
-#ifdef CONFIG_X86_USE_3DNOW
-# define NEED_3DNOW	(1<<(X86_FEATURE_3DNOW & 31))
-#else
 # define NEED_3DNOW	0
-#endif
 
 #if defined(CONFIG_X86_P6_NOP) || defined(CONFIG_X86_64)
 # define NEED_NOPL	(1<<(X86_FEATURE_NOPL & 31))
diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index f74362b..32c0d98 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -146,42 +146,9 @@ static __always_inline void *__constant_memcpy(void *to, const void *from,
 extern void *memcpy(void *, const void *, size_t);
 
 #ifndef CONFIG_FORTIFY_SOURCE
-#ifdef CONFIG_X86_USE_3DNOW
-
-#include <asm/mmx.h>
-
-/*
- *	This CPU favours 3DNow strongly (eg AMD Athlon)
- */
-
-static inline void *__constant_memcpy3d(void *to, const void *from, size_t len)
-{
-	if (len < 512)
-		return __constant_memcpy(to, from, len);
-	return _mmx_memcpy(to, from, len);
-}
-
-static inline void *__memcpy3d(void *to, const void *from, size_t len)
-{
-	if (len < 512)
-		return __memcpy(to, from, len);
-	return _mmx_memcpy(to, from, len);
-}
-
-#define memcpy(t, f, n)				\
-	(__builtin_constant_p((n))		\
-	 ? __constant_memcpy3d((t), (f), (n))	\
-	 : __memcpy3d((t), (f), (n)))
-
-#else
-
-/*
- *	No 3D Now!
- */
 
 #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
 
-#endif
 #endif /* !CONFIG_FORTIFY_SOURCE */
 
 #define __HAVE_ARCH_MEMMOVE
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index c6506c6..f767478 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -63,7 +63,6 @@ ifeq ($(CONFIG_X86_32),y)
 ifneq ($(CONFIG_X86_CMPXCHG64),y)
         lib-y += cmpxchg8b_emu.o atomic64_386_32.o
 endif
-        lib-$(CONFIG_X86_USE_3DNOW) += mmx_32.o
 else
         obj-y += iomap_copy_64.o
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
diff --git a/arch/x86/lib/memcpy_32.c b/arch/x86/lib/memcpy_32.c
index e565d1c..3a6e6cf 100644
--- a/arch/x86/lib/memcpy_32.c
+++ b/arch/x86/lib/memcpy_32.c
@@ -7,11 +7,7 @@
 
 __visible void *memcpy(void *to, const void *from, size_t n)
 {
-#if defined(CONFIG_X86_USE_3DNOW) && !defined(CONFIG_FORTIFY_SOURCE)
-	return __memcpy3d(to, from, n);
-#else
 	return __memcpy(to, from, n);
-#endif
 }
 EXPORT_SYMBOL(memcpy);
 
diff --git a/arch/x86/lib/mmx_32.c b/arch/x86/lib/mmx_32.c
index cc5f4ea..e69de29 100644
--- a/arch/x86/lib/mmx_32.c
+++ b/arch/x86/lib/mmx_32.c
@@ -1,388 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	MMX 3DNow! library helper functions
- *
- *	To do:
- *	We can use MMX just for prefetch in IRQ's. This may be a win.
- *		(reported so on K6-III)
- *	We should use a better code neutral filler for the short jump
- *		leal ebx. [ebx] is apparently best for K6-2, but Cyrix ??
- *	We also want to clobber the filler register so we don't get any
- *		register forwarding stalls on the filler.
- *
- *	Add *user handling. Checksums are not a win with MMX on any CPU
- *	tested so far for any MMX solution figured.
- *
- *	22/09/2000 - Arjan van de Ven
- *		Improved for non-engineering-sample Athlons
- *
- */
-#include <linux/hardirq.h>
-#include <linux/string.h>
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-
-#include <asm/fpu/api.h>
-#include <asm/asm.h>
-
-/*
- * Use KFPU_387.  MMX instructions are not affected by MXCSR,
- * but both AMD and Intel documentation states that even integer MMX
- * operations will result in #MF if an exception is pending in FCW.
- *
- * EMMS is not needed afterwards because, after calling kernel_fpu_end(),
- * any subsequent user of the 387 stack will reinitialize it using
- * KFPU_387.
- */
-
-void *_mmx_memcpy(void *to, const void *from, size_t len)
-{
-	void *p;
-	int i;
-
-	if (unlikely(in_interrupt()))
-		return __memcpy(to, from, len);
-
-	p = to;
-	i = len >> 6; /* len/64 */
-
-	kernel_fpu_begin_mask(KFPU_387);
-
-	__asm__ __volatile__ (
-		"1: prefetch (%0)\n"		/* This set is 28 bytes */
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b)
-			: : "r" (from));
-
-	for ( ; i > 5; i--) {
-		__asm__ __volatile__ (
-		"1:  prefetch 320(%0)\n"
-		"2:  movq (%0), %%mm0\n"
-		"  movq 8(%0), %%mm1\n"
-		"  movq 16(%0), %%mm2\n"
-		"  movq 24(%0), %%mm3\n"
-		"  movq %%mm0, (%1)\n"
-		"  movq %%mm1, 8(%1)\n"
-		"  movq %%mm2, 16(%1)\n"
-		"  movq %%mm3, 24(%1)\n"
-		"  movq 32(%0), %%mm0\n"
-		"  movq 40(%0), %%mm1\n"
-		"  movq 48(%0), %%mm2\n"
-		"  movq 56(%0), %%mm3\n"
-		"  movq %%mm0, 32(%1)\n"
-		"  movq %%mm1, 40(%1)\n"
-		"  movq %%mm2, 48(%1)\n"
-		"  movq %%mm3, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b)
-			: : "r" (from), "r" (to) : "memory");
-
-		from += 64;
-		to += 64;
-	}
-
-	for ( ; i > 0; i--) {
-		__asm__ __volatile__ (
-		"  movq (%0), %%mm0\n"
-		"  movq 8(%0), %%mm1\n"
-		"  movq 16(%0), %%mm2\n"
-		"  movq 24(%0), %%mm3\n"
-		"  movq %%mm0, (%1)\n"
-		"  movq %%mm1, 8(%1)\n"
-		"  movq %%mm2, 16(%1)\n"
-		"  movq %%mm3, 24(%1)\n"
-		"  movq 32(%0), %%mm0\n"
-		"  movq 40(%0), %%mm1\n"
-		"  movq 48(%0), %%mm2\n"
-		"  movq 56(%0), %%mm3\n"
-		"  movq %%mm0, 32(%1)\n"
-		"  movq %%mm1, 40(%1)\n"
-		"  movq %%mm2, 48(%1)\n"
-		"  movq %%mm3, 56(%1)\n"
-			: : "r" (from), "r" (to) : "memory");
-
-		from += 64;
-		to += 64;
-	}
-	/*
-	 * Now do the tail of the block:
-	 */
-	__memcpy(to, from, len & 63);
-	kernel_fpu_end();
-
-	return p;
-}
-EXPORT_SYMBOL(_mmx_memcpy);
-
-#ifdef CONFIG_MK7
-
-/*
- *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and
- *	other MMX using processors do not.
- */
-
-static void fast_clear_page(void *page)
-{
-	int i;
-
-	kernel_fpu_begin_mask(KFPU_387);
-
-	__asm__ __volatile__ (
-		"  pxor %%mm0, %%mm0\n" : :
-	);
-
-	for (i = 0; i < 4096/64; i++) {
-		__asm__ __volatile__ (
-		"  movntq %%mm0, (%0)\n"
-		"  movntq %%mm0, 8(%0)\n"
-		"  movntq %%mm0, 16(%0)\n"
-		"  movntq %%mm0, 24(%0)\n"
-		"  movntq %%mm0, 32(%0)\n"
-		"  movntq %%mm0, 40(%0)\n"
-		"  movntq %%mm0, 48(%0)\n"
-		"  movntq %%mm0, 56(%0)\n"
-		: : "r" (page) : "memory");
-		page += 64;
-	}
-
-	/*
-	 * Since movntq is weakly-ordered, a "sfence" is needed to become
-	 * ordered again:
-	 */
-	__asm__ __volatile__("sfence\n"::);
-
-	kernel_fpu_end();
-}
-
-static void fast_copy_page(void *to, void *from)
-{
-	int i;
-
-	kernel_fpu_begin_mask(KFPU_387);
-
-	/*
-	 * maybe the prefetch stuff can go before the expensive fnsave...
-	 * but that is for later. -AV
-	 */
-	__asm__ __volatile__(
-		"1: prefetch (%0)\n"
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b) : : "r" (from));
-
-	for (i = 0; i < (4096-320)/64; i++) {
-		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
-		"   movntq %%mm0, (%1)\n"
-		"   movq 8(%0), %%mm1\n"
-		"   movntq %%mm1, 8(%1)\n"
-		"   movq 16(%0), %%mm2\n"
-		"   movntq %%mm2, 16(%1)\n"
-		"   movq 24(%0), %%mm3\n"
-		"   movntq %%mm3, 24(%1)\n"
-		"   movq 32(%0), %%mm4\n"
-		"   movntq %%mm4, 32(%1)\n"
-		"   movq 40(%0), %%mm5\n"
-		"   movntq %%mm5, 40(%1)\n"
-		"   movq 48(%0), %%mm6\n"
-		"   movntq %%mm6, 48(%1)\n"
-		"   movq 56(%0), %%mm7\n"
-		"   movntq %%mm7, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-		_ASM_EXTABLE(1b, 3b) : : "r" (from), "r" (to) : "memory");
-
-		from += 64;
-		to += 64;
-	}
-
-	for (i = (4096-320)/64; i < 4096/64; i++) {
-		__asm__ __volatile__ (
-		"2: movq (%0), %%mm0\n"
-		"   movntq %%mm0, (%1)\n"
-		"   movq 8(%0), %%mm1\n"
-		"   movntq %%mm1, 8(%1)\n"
-		"   movq 16(%0), %%mm2\n"
-		"   movntq %%mm2, 16(%1)\n"
-		"   movq 24(%0), %%mm3\n"
-		"   movntq %%mm3, 24(%1)\n"
-		"   movq 32(%0), %%mm4\n"
-		"   movntq %%mm4, 32(%1)\n"
-		"   movq 40(%0), %%mm5\n"
-		"   movntq %%mm5, 40(%1)\n"
-		"   movq 48(%0), %%mm6\n"
-		"   movntq %%mm6, 48(%1)\n"
-		"   movq 56(%0), %%mm7\n"
-		"   movntq %%mm7, 56(%1)\n"
-			: : "r" (from), "r" (to) : "memory");
-		from += 64;
-		to += 64;
-	}
-	/*
-	 * Since movntq is weakly-ordered, a "sfence" is needed to become
-	 * ordered again:
-	 */
-	__asm__ __volatile__("sfence \n"::);
-	kernel_fpu_end();
-}
-
-#else /* CONFIG_MK7 */
-
-/*
- *	Generic MMX implementation without K7 specific streaming
- */
-static void fast_clear_page(void *page)
-{
-	int i;
-
-	kernel_fpu_begin_mask(KFPU_387);
-
-	__asm__ __volatile__ (
-		"  pxor %%mm0, %%mm0\n" : :
-	);
-
-	for (i = 0; i < 4096/128; i++) {
-		__asm__ __volatile__ (
-		"  movq %%mm0, (%0)\n"
-		"  movq %%mm0, 8(%0)\n"
-		"  movq %%mm0, 16(%0)\n"
-		"  movq %%mm0, 24(%0)\n"
-		"  movq %%mm0, 32(%0)\n"
-		"  movq %%mm0, 40(%0)\n"
-		"  movq %%mm0, 48(%0)\n"
-		"  movq %%mm0, 56(%0)\n"
-		"  movq %%mm0, 64(%0)\n"
-		"  movq %%mm0, 72(%0)\n"
-		"  movq %%mm0, 80(%0)\n"
-		"  movq %%mm0, 88(%0)\n"
-		"  movq %%mm0, 96(%0)\n"
-		"  movq %%mm0, 104(%0)\n"
-		"  movq %%mm0, 112(%0)\n"
-		"  movq %%mm0, 120(%0)\n"
-			: : "r" (page) : "memory");
-		page += 128;
-	}
-
-	kernel_fpu_end();
-}
-
-static void fast_copy_page(void *to, void *from)
-{
-	int i;
-
-	kernel_fpu_begin_mask(KFPU_387);
-
-	__asm__ __volatile__ (
-		"1: prefetch (%0)\n"
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b) : : "r" (from));
-
-	for (i = 0; i < 4096/64; i++) {
-		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
-		"   movq 8(%0), %%mm1\n"
-		"   movq 16(%0), %%mm2\n"
-		"   movq 24(%0), %%mm3\n"
-		"   movq %%mm0, (%1)\n"
-		"   movq %%mm1, 8(%1)\n"
-		"   movq %%mm2, 16(%1)\n"
-		"   movq %%mm3, 24(%1)\n"
-		"   movq 32(%0), %%mm0\n"
-		"   movq 40(%0), %%mm1\n"
-		"   movq 48(%0), %%mm2\n"
-		"   movq 56(%0), %%mm3\n"
-		"   movq %%mm0, 32(%1)\n"
-		"   movq %%mm1, 40(%1)\n"
-		"   movq %%mm2, 48(%1)\n"
-		"   movq %%mm3, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b)
-			: : "r" (from), "r" (to) : "memory");
-
-		from += 64;
-		to += 64;
-	}
-	kernel_fpu_end();
-}
-
-#endif /* !CONFIG_MK7 */
-
-/*
- * Favour MMX for page clear and copy:
- */
-static void slow_zero_page(void *page)
-{
-	int d0, d1;
-
-	__asm__ __volatile__(
-		"cld\n\t"
-		"rep ; stosl"
-
-			: "=&c" (d0), "=&D" (d1)
-			:"a" (0), "1" (page), "0" (1024)
-			:"memory");
-}
-
-void mmx_clear_page(void *page)
-{
-	if (unlikely(in_interrupt()))
-		slow_zero_page(page);
-	else
-		fast_clear_page(page);
-}
-EXPORT_SYMBOL(mmx_clear_page);
-
-static void slow_copy_page(void *to, void *from)
-{
-	int d0, d1, d2;
-
-	__asm__ __volatile__(
-		"cld\n\t"
-		"rep ; movsl"
-		: "=&c" (d0), "=&D" (d1), "=&S" (d2)
-		: "0" (1024), "1" ((long) to), "2" ((long) from)
-		: "memory");
-}
-
-void mmx_copy_page(void *to, void *from)
-{
-	if (unlikely(in_interrupt()))
-		slow_copy_page(to, from);
-	else
-		fast_copy_page(to, from);
-}
-EXPORT_SYMBOL(mmx_copy_page);
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 7d29077..962006b 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -8,7 +8,6 @@
  */
 #include <linux/export.h>
 #include <linux/uaccess.h>
-#include <asm/mmx.h>
 #include <asm/asm.h>
 
 #ifdef CONFIG_X86_INTEL_USERCOPY
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index b2d504f..aff7747 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -35,11 +35,7 @@
 # define NEED_CMOV	0
 #endif
 
-#ifdef CONFIG_X86_USE_3DNOW
-# define NEED_3DNOW	(1<<(X86_FEATURE_3DNOW & 31))
-#else
 # define NEED_3DNOW	0
-#endif
 
 #if defined(CONFIG_X86_P6_NOP) || defined(CONFIG_X86_64)
 # define NEED_NOPL	(1<<(X86_FEATURE_NOPL & 31))
