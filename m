Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3374D1C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348178AbiCHP4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348030AbiCHP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EDC4F9C3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AXxkY3fJyaBpuEKZHXTB+//NaiEPMsud285kPOUeKnY=; b=UdQd+oIZ8UYCHYIFoR/CIU+iPA
        rsarLMvwo/SPMsRzyQiH7WehPMwPxXUZnRzd7CRCj9N73dGFxELbpBDtGReV4Mb+eAbrn3HAr1gHr
        j++I8I8OvI+qKBiNi+CCCdRgAcoCwMAyH/8QitC0deK6VBo3HqsBlxwyRvOcOobN2OtgGsdhV1WLy
        7+kmLewqyf/3yhNvbz7+u1+zRpEG69F/m7kq40W02XDYXCWNHXvE2kwsMPFLpjsK6XeUu4ws5zX0u
        npM1gph+tn1l6jckipNjDpbnd5sgZOWK4DKG2dQGxuKac9Rg+b96VjCTV2vQvovDvxjLywq+dzHjG
        EzaUqXMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GIux-0y; Tue, 08 Mar 2022 15:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 206D0300C67;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CC1FD2B561901; Tue,  8 Mar 2022 16:54:38 +0100 (CET)
Message-ID: <20220308154317.519875203@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 06/45] x86/ibt: Base IBT bits
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig, Makefile and basic instruction support for x86 IBT.

(Ab)use __DISABLE_EXPORTS to disable IBT since it's already employed
to mark compressed and purgatory. Additionally mark realmode with it
as well to avoid inserting ENDBR instructions there. While ENDBR is
technically a NOP, inserting them was causing some grief due to code
growth. There's also a problem with using __noendbr in code compiled
without -fcf-protection=branch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig           |   20 ++++++++++
 arch/x86/Makefile          |   16 +++++++-
 arch/x86/include/asm/ibt.h |   87 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 2 deletions(-)

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
+		  (CC_IS_CLANG && $(cc-option, -fcf-protection=branch -mfentry))) && \
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


