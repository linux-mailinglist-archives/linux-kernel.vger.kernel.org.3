Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D80B5AB3A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiIBOcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiIBO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:28:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326DC140CE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yAGW7R8vTxeOqWUEPXbZtse6DzAQxppiABwB+quxCsY=; b=iTzoVo4CmQFy1IW4MYB9A0TLxW
        JbgR2Ls5vDF6W2uy1JxTWkUH5JH1HIUt03/RvuCwL+pJicEv1Y9a2bufrnA4CQ0eYxtbLOQj49oeQ
        IDxmnBVLqVS97joi41/KPfHRJxRUMdi3dS8zAdv302eB3SF7zIhUhWph2HcBEtvy7XSirX1r+kT/r
        sugQn6Bw4J+oGLgDJqvvy7juSCNLrqbqsU4TNTcH7r85gtLx4SF7vLxIQm0qjpNrusYBd00WUUq2V
        sRrG1OtXSDQSyhHt24Mb16s8i9e4WOctsW4fsUx0rK6kvyLMhX7hunc55dHfMU6QoFYKMuGaQT3Wz
        M36ooAFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-008g8K-TR; Fri, 02 Sep 2022 13:54:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 346E330276B;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2F9872B8EF7FD; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130950.408585331@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
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
Subject: [PATCH v2 39/59] x86/Kconfig: Introduce function padding
References: <20220902130625.217071627@infradead.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

Now that all functions are 16 byte aligned, add 16 bytes of NOP
padding in front of each function. This prepares things for software
call stack tracking and kCFI/FineIBT.

This significantly increases kernel .text size, around 5.1% on a
x86_64-defconfig-ish build.

However, per the random access argument used for alignment, these 16
extra bytes are code that wouldn't be used. Performance measurements
back this up by showing no significant performance regressions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Makefile                       |    3 +++
 arch/x86/Kconfig               |   12 +++++++++++-
 arch/x86/Makefile              |    5 +++++
 arch/x86/entry/vdso/Makefile   |    3 ++-
 arch/x86/include/asm/linkage.h |   28 ++++++++++++++++++++++++----
 5 files changed, 45 insertions(+), 6 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -920,6 +920,9 @@ KBUILD_AFLAGS	+= -fno-lto
 export CC_FLAGS_LTO
 endif
 
+PADDING_CFLAGS := -fpatchable-function-entry=$(CONFIG_FUNCTION_PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
+export PADDING_CFLAGS
+
 ifdef CONFIG_CFI_CLANG
 CC_FLAGS_CFI	:= -fsanitize=cfi \
 		   -fsanitize-cfi-cross-dso \
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2427,9 +2427,19 @@ config CC_HAS_SLS
 config CC_HAS_RETURN_THUNK
 	def_bool $(cc-option,-mfunction-return=thunk-extern)
 
+config CC_HAS_ENTRY_PADDING
+	def_bool $(cc-option,-fpatchable-function-entry=16,16)
+
+config FUNCTION_PADDING_BYTES
+	int
+	default 32 if CALL_THUNKS_DEBUG && !CFI_CLANG
+	default 27 if CALL_THUNKS_DEBUG && CFI_CLANG
+	default 16 if !CFI_CLANG
+	default 11
+
 config HAVE_CALL_THUNKS
 	def_bool y
-	depends on RETHUNK && OBJTOOL
+	depends on CC_HAS_ENTRY_PADDING && RETHUNK && OBJTOOL
 
 config CALL_THUNKS
 	def_bool n
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -202,6 +202,11 @@ ifdef CONFIG_SLS
   KBUILD_CFLAGS += -mharden-sls=all
 endif
 
+PADDING_CFLAGS := -fpatchable-function-entry=$(CONFIG_FUNCTION_PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
+ifdef CONFIG_CALL_THUNKS
+  KBUILD_CFLAGS += $(PADDING_CFLAGS)
+endif
+
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
 
 ifdef CONFIG_LTO_CLANG
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -92,7 +92,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 $(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
 
 #
@@ -154,6 +154,7 @@ KBUILD_CFLAGS_32 := $(filter-out $(RANDS
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(PADDING_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -13,17 +13,37 @@
 #endif /* CONFIG_X86_32 */
 
 #if CONFIG_FUNCTION_ALIGNMENT == 8
-#define __ALIGN			.p2align 3, 0x90;
+# define __ALIGN		.p2align 3, 0x90;
 #elif CONFIG_FUNCTION_ALIGNMENT == 16
-#define __ALIGN			.p2align 4, 0x90;
+# define __ALIGN		.p2align 4, 0x90;
+#elif CONFIG_FUNCTION_ALIGNMENT == 32
+# define __ALIGN		.p2align 5, 0x90
 #else
 # error Unsupported function alignment
 #endif
 
 #define __ALIGN_STR		__stringify(__ALIGN)
-#define ASM_FUNC_ALIGN		__ALIGN_STR
-#define __FUNC_ALIGN		__ALIGN
+
+#ifdef CONFIG_CFI_CLANG
+#define __FUNCTION_PADDING	(CONFIG_FUNCTION_ALIGNMENT - 5)
+#else
+#define __FUNCTION_PADDING	CONFIG_FUNCTION_ALIGNMENT
+#endif
+
+#if defined(CONFIG_CALL_THUNKS) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
+#define FUNCTION_PADDING	.skip __FUNCTION_PADDING, 0x90;
+#else
+#define FUNCTION_PADDING
+#endif
+
+#if (CONFIG_FUNCTION_ALIGNMENT > 8) && !defined(__DISABLE_EXPORTS) && !defined(BULID_VDSO)
+# define __FUNC_ALIGN		__ALIGN; FUNCTION_PADDING
+#else
+# define __FUNC_ALIGN		__ALIGN
+#endif
+
 #define SYM_F_ALIGN		__FUNC_ALIGN
+#define ASM_FUNC_ALIGN		__stringify(__FUNC_ALIGN)
 
 #ifdef __ASSEMBLY__
 


