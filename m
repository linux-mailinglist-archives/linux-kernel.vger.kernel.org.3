Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C354D9960
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiCOKrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbiCOKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279051330;
        Tue, 15 Mar 2022 03:44:15 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+2Pljqb1A90qyzgo7De+ro0rM0b1dzG9jiLHXA2mpU=;
        b=WEOvdk8MkfsB1a4KQ6dxsLL7kVfp2wo+2GJk/vlpr1eyqPmls8uLqej+ss4NkRIiBdhGoA
        66BO69dXhG35rwkgxu4v3+MajXm3AWq7bmqEVbnSklmwLSHU8uFm7N4mAYRNDb6EA1ehno
        KYPaYlHJBv8kvjdzGyUWX/PieLQGpr6vB7716KDufC/FNWI9ftXz8FEQArAXdxx7zDMXwV
        8W+E/UsukkKdkqqr5mpP0AoM61BQ/bUp2ZAmE5vGL0a21wPgY13jxFzAhXOrw3CbwKCb8G
        1aQCC1ggpEL/GxcTVckjNrkTgs9kW0Hjr2ixMrGuFWwIKOpoav8tMwh93bs5ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+2Pljqb1A90qyzgo7De+ro0rM0b1dzG9jiLHXA2mpU=;
        b=zDerp/V4HSxTF1lotBM9A2VMnVzFLb7pu+Wf8YJKbvwjVAXqDVra49XB2wChmqwWMZh5dI
        jHMBgYQ/xazouwCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Base IBT bits
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.519875203@infradead.org>
References: <20220308154317.519875203@infradead.org>
MIME-Version: 1.0
Message-ID: <164734105314.16921.357071508436313451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     156ff4a544ae13c5fd6759a09ecb069f7059c1a1
Gitweb:        https://git.kernel.org/tip/156ff4a544ae13c5fd6759a09ecb069f7059c1a1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:33 +01:00

x86/ibt: Base IBT bits

Add Kconfig, Makefile and basic instruction support for x86 IBT.

(Ab)use __DISABLE_EXPORTS to disable IBT since it's already employed
to mark compressed and purgatory. Additionally mark realmode with it
as well to avoid inserting ENDBR instructions there. While ENDBR is
technically a NOP, inserting them was causing some grief due to code
growth. There's also a problem with using __noendbr in code compiled
without -fcf-protection=branch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.519875203@infradead.org
---
 arch/x86/Kconfig           | 20 +++++++++-
 arch/x86/Makefile          | 16 ++++++-
 arch/x86/include/asm/ibt.h | 87 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/ibt.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41..19d16c0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1861,6 +1861,26 @@ config X86_UMIP
 	  specific cases in protected and virtual-8086 modes. Emulated
 	  results are dummy.
 
+config CC_HAS_IBT
+	# GCC >= 9 and binutils >= 2.29
+	# Retpoline check to work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93654
+	# Clang/LLVM >= 14
+	# fentry check to work around https://reviews.llvm.org/D111108
+	def_bool ((CC_IS_GCC && $(cc-option, -fcf-protection=branch -mindirect-branch-register)) || \
+		  (CC_IS_CLANG && $(success,echo "void a(void) {}" | $(CC) -Werror $(CLANG_FLAGS) -fcf-protection=branch -mfentry -pg -x c - -c -o /dev/null))) && \
+		  $(as-instr,endbr64)
+
+config X86_KERNEL_IBT
+	prompt "Indirect Branch Tracking"
+	bool
+	depends on X86_64 && CC_HAS_IBT
+	help
+	  Build the kernel with support for Indirect Branch Tracking, a
+	  hardware support course-grain forward-edge Control Flow Integrity
+	  protection. It enforces that all indirect calls must land on
+	  an ENDBR instruction, as such, the compiler will instrument the
+	  code with them to make this happen.
+
 config X86_INTEL_MEMORY_PROTECTION_KEYS
 	prompt "Memory Protection Keys"
 	def_bool y
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index e84cdd4..f29c2c9 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -36,7 +36,7 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
+REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
@@ -62,8 +62,20 @@ export BITS
 #
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 
-# Intel CET isn't enabled in the kernel
+ifeq ($(CONFIG_X86_KERNEL_IBT),y)
+#
+# Kernel IBT has S_CET.NOTRACK_EN=0, as such the compilers must not generate
+# NOTRACK prefixes. Current generation compilers unconditionally employ NOTRACK
+# for jump-tables, as such, disable jump-tables for now.
+#
+# (jump-tables are implicitly disabled by RETPOLINE)
+#
+#   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104816
+#
+KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch -fno-jump-tables)
+else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
+endif
 
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
new file mode 100644
index 0000000..fcaf6a4
--- /dev/null
+++ b/arch/x86/include/asm/ibt.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IBT_H
+#define _ASM_X86_IBT_H
+
+#include <linux/types.h>
+
+/*
+ * The rules for enabling IBT are:
+ *
+ *  - CC_HAS_IBT:         the toolchain supports it
+ *  - X86_KERNEL_IBT:     it is selected in Kconfig
+ *  - !__DISABLE_EXPORTS: this is regular kernel code
+ *
+ * Esp. that latter one is a bit non-obvious, but some code like compressed,
+ * purgatory, realmode etc.. is built with custom CFLAGS that do not include
+ * -fcf-protection=branch and things will go *bang*.
+ *
+ * When all the above are satisfied, HAS_KERNEL_IBT will be 1, otherwise 0.
+ */
+#if defined(CONFIG_X86_KERNEL_IBT) && !defined(__DISABLE_EXPORTS)
+
+#define HAS_KERNEL_IBT	1
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_X86_64
+#define ASM_ENDBR	"endbr64\n\t"
+#else
+#define ASM_ENDBR	"endbr32\n\t"
+#endif
+
+#define __noendbr	__attribute__((nocf_check))
+
+static inline __attribute_const__ u32 gen_endbr(void)
+{
+	u32 endbr;
+
+	/*
+	 * Generate ENDBR64 in a way that is sure to not result in
+	 * an ENDBR64 instruction as immediate.
+	 */
+	asm ( "mov $~0xfa1e0ff3, %[endbr]\n\t"
+	      "not %[endbr]\n\t"
+	       : [endbr] "=&r" (endbr) );
+
+	return endbr;
+}
+
+static inline bool is_endbr(u32 val)
+{
+	val &= ~0x01000000U; /* ENDBR32 -> ENDBR64 */
+	return val == gen_endbr();
+}
+
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_X86_64
+#define ENDBR	endbr64
+#else
+#define ENDBR	endbr32
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#else /* !IBT */
+
+#define HAS_KERNEL_IBT	0
+
+#ifndef __ASSEMBLY__
+
+#define ASM_ENDBR
+
+#define __noendbr
+
+static inline bool is_endbr(u32 val) { return false; }
+
+#else /* __ASSEMBLY__ */
+
+#define ENDBR
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_X86_KERNEL_IBT */
+
+#define ENDBR_INSN_SIZE		(4*HAS_KERNEL_IBT)
+
+#endif /* _ASM_X86_IBT_H */
