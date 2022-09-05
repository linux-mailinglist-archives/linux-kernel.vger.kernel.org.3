Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE95ACF7B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiIEKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiIEKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:07:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C45923158
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MJ/bcZF83PsSn8wSXx0c2hSrEl0FZ79NDKbNQutwdMM=; b=VZ3OwtcH2VT3NDF0vQ/mBOx3Nt
        CCVM8DfIRlX4sDUZSBckT6O+talkCmbMvv+35YuBEBz08HjIIjCaNvj4LIeCSJwhLCL5bNnXZ8wNX
        EFhBD/EcjCH0IUHiVv+r4PtAZ4+Jb5BPcfqupOuGPgpm1jEq6kxfLly4kE455/4ftLDDzdZUtuHQC
        LwZGRRZHp64GDHA49W45znBMy7nymoe5uyc8UE5jwtULuiXotKFU9pt12FdYObGnJlfN28/3zoPW+
        T6b5oJUSsMzuJVwivLTonS1eBza0YJjJggX8qPL1/x91XiYlFxUO4cglRiVLwF8oR/f/wx+LdNkDv
        nZsvJr9A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oV8y7-009Uyy-2O; Mon, 05 Sep 2022 10:06:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFEA33001FD;
        Mon,  5 Sep 2022 12:04:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B74452B63DD72; Mon,  5 Sep 2022 12:04:35 +0200 (CEST)
Date:   Mon, 5 Sep 2022 12:04:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 08/59] x86/build: Ensure proper function alignment
Message-ID: <YxXJswK9QjhCGmPN@hirez.programming.kicks-ass.net>
References: <20220902130625.217071627@infradead.org>
 <20220902130947.190618587@infradead.org>
 <CAHk-=whdvPcHmH5eG+FUrbQw1e-05n__EWobMqbxcCTP7dtZAg@mail.gmail.com>
 <YxI+K8Y+f/FHSQCU@hirez.programming.kicks-ass.net>
 <CAHk-=wjRLehUO=u8HDJGRFv+wz7hakSc=z6eTg547pAmb0UKHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRLehUO=u8HDJGRFv+wz7hakSc=z6eTg547pAmb0UKHg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:08:54AM -0700, Linus Torvalds wrote:

> Let's just do this right.

Something like so then?

---
--- a/Makefile
+++ b/Makefile
@@ -940,8 +940,8 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
 
-ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B
-KBUILD_CFLAGS += -falign-functions=64
+ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
+KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1419,4 +1419,24 @@ source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
 
+config FUNCTION_ALIGNMENT_8B
+	bool
+
+config FUNCTION_ALIGNMENT_16B
+	bool
+
+config FUNCTION_ALIGNMENT_32B
+	bool
+
+config FUNCTION_ALIGNMENT_64B
+	bool
+
+config FUNCTION_ALIGNMENT
+	int
+	default 64 if FUNCTION_ALIGNMENT_64B
+	default 32 if FUNCTION_ALIGNMENT_32B
+	default 16 if FUNCTION_ALIGNMENT_16B
+	default 8 if FUNCTION_ALIGNMENT_8B
+	default 0
+
 endmenu
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -63,6 +63,7 @@ config IA64
 	select NUMA if !FLATMEM
 	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
 	select ZONE_DMA32
+	select FUNCTION_ALIGNMENT_32B
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -23,7 +23,7 @@ KBUILD_AFLAGS_KERNEL := -mconstant-gp
 EXTRA		:=
 
 cflags-y	:= -pipe $(EXTRA) -ffixed-r13 -mfixed-range=f12-f15,f32-f127 \
-		   -falign-functions=32 -frename-registers -fno-optimize-sibling-calls
+		   -frename-registers -fno-optimize-sibling-calls
 KBUILD_CFLAGS_KERNEL := -mconstant-gp
 
 GAS_STATUS	= $(shell $(srctree)/arch/ia64/scripts/check-gas "$(CC)" "$(OBJDUMP)")
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -283,6 +283,8 @@ config X86
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
 	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
+	select FUNCTION_ALIGNMENT_16B		if X86_64 || X86_ALIGNMENT_16
+	select FUNCTION_ALIGNMENT_8B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 
 config INSTRUCTION_DECODER
@@ -2442,6 +2444,7 @@ config HAVE_CALL_THUNKS
 	depends on CC_HAS_ENTRY_PADDING && RETHUNK && OBJTOOL
 
 config CALL_THUNKS
+	select FUNCTION_ALIGNMENT_16B
 	def_bool n
 
 menuconfig SPECULATION_MITIGATIONS
@@ -2515,6 +2518,7 @@ config CALL_DEPTH_TRACKING
 
 config CALL_THUNKS_DEBUG
 	bool "Enable call thunks and call depth tracking debugging"
+	select FUNCTION_ALIGNMENT_32B
 	depends on CALL_DEPTH_TRACKING
 	default n
 	help
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -517,9 +517,3 @@ config CPU_SUP_VORTEX_32
 	  makes the kernel a tiny bit smaller.
 
 	  If unsure, say N.
-
-# Defined here so it is defined for UM too
-config FUNCTION_ALIGNMENT
-	int
-	default 16 if X86_64 || X86_ALIGNMENT_16
-	default 8
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -84,10 +84,6 @@ else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
 
-ifneq ($(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B),y)
-KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
-endif
-
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
         UTS_MACHINE := i386
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -12,16 +12,7 @@
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #endif /* CONFIG_X86_32 */
 
-#if CONFIG_FUNCTION_ALIGNMENT == 8
-# define __ALIGN		.p2align 3, 0x90;
-#elif CONFIG_FUNCTION_ALIGNMENT == 16
-# define __ALIGN		.p2align 4, 0x90;
-#elif CONFIG_FUNCTION_ALIGNMENT == 32
-# define __ALIGN		.p2align 5, 0x90
-#else
-# error Unsupported function alignment
-#endif
-
+#define __ALIGN			.balign CONFIG_FUNCTION_ALIGNMENT, 0x90
 #define __ALIGN_STR		__stringify(__ALIGN)
 
 #ifdef CONFIG_CFI_CLANG
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -69,8 +69,8 @@
 #endif
 
 #ifndef __ALIGN
-#define __ALIGN		.align 4,0x90
-#define __ALIGN_STR	".align 4,0x90"
+#define __ALIGN			.balign CONFIG_FUNCTION_ALIGNMENT
+#define __ALIGN_STR		__stringify(__ALIGN)
 #endif
 
 #ifdef __ASSEMBLY__
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -459,6 +459,7 @@ config SECTION_MISMATCH_WARN_ONLY
 config DEBUG_FORCE_FUNCTION_ALIGN_64B
 	bool "Force all function address 64B aligned"
 	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC)
+	select FUNCTION_ALIGNMENT_64B
 	help
 	  There are cases that a commit from one domain changes the function
 	  address alignment of other domains, and cause magic performance
