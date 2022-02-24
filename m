Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259D84C2F63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiBXPTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiBXPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8435144F4A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bva9vPHXQYlcS7hOjih1Py2Kr67jbSPtC0VimiZzpYo=; b=fnpWiWTTG+VNzxDVzv0wlEhQ0N
        Nm7SG63xcJz8PTBYg1tKnn/GkcT8a4/7PhrezkRWcyDsnfq9GAKbfHpb3MoZVBSsn7VD57Sbdsj72
        LnrCzJ4FjKIOCrRn6MOpkKp2rstx3zYdOCl9TFR6qRBMe2GXGdX8A5p5uvI9Ug6nEoF8Qu6J9IOG/
        5k10xOjEcY1wY0vOtzak0+pdhcXlDcT30cJsehYympIb0QuaNIFYvALKnd0mWfAitXA+sQd+g1JBa
        HbOIsCFg/3Gsxx/NK8gc47lZnb8PEzKmKAc775AdafsPYqJEhme4qSzCmlD/Lt1I93PavEyupPVdc
        xc2WeFSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-00CeLa-61; Thu, 24 Feb 2022 15:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2638D30081D;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2F69929E75E51; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151322.307406918@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 05/39] x86: Base IBT bits
References: <20220224145138.952963315@infradead.org>
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

XXX clang is not playing ball, probably lld being 'funny', I'm having
problems with .plt entries appearing all over after linking.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig           |   19 ++++++++++++
 arch/x86/Makefile          |    7 +++-
 arch/x86/include/asm/ibt.h |   71 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 2 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1861,6 +1861,25 @@ config X86_UMIP
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
+	  hardware supported CFI scheme. Any indirect call must land on
+	  an ENDBR instruction, as such, the compiler will litter the
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
@@ -62,8 +62,11 @@ export BITS
 #
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 
-# Intel CET isn't enabled in the kernel
+ifeq ($(CONFIG_X86_KERNEL_IBT),y)
+KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch)
+else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
+endif
 
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
--- /dev/null
+++ b/arch/x86/include/asm/ibt.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IBT_H
+#define _ASM_X86_IBT_H
+
+#include <linux/types.h>
+
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
+static inline __attribute_const__ unsigned int gen_endbr(void)
+{
+	unsigned int endbr;
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
+static inline bool is_endbr(unsigned int val)
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
+static inline bool is_endbr(unsigned int val) { return false; }
+
+#else /* __ASSEMBLY__ */
+
+#define ENDBR
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_X86_KERNEL_IBT */
+#endif /* _ASM_X86_IBT_H */


