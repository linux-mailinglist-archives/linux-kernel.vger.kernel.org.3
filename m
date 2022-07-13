Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DDC57403F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiGMX4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGMX4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:56:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD614D4D5;
        Wed, 13 Jul 2022 16:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3FFBB81677;
        Wed, 13 Jul 2022 23:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E910CC341C0;
        Wed, 13 Jul 2022 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657756558;
        bh=+6HhQ9RDk7g5/LEg8+4SSvQOgQUFr5F3NkFiGu+O4bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqEytcF9NbARek+sqNtax/6TCHEd2RVGVvSqL2E0cY4u1H9ikgEc+W3ut05ddhtrp
         gb/Kpf9DazuLJZTR5DMcvZiEVTTSGztwyFdPwG4x8tVFsLv/LtljJgWWlktzMR8hxH
         fct70kiyDv/8GPuVWWspvHcuVdHVLgy6mXyUW3h9DrMYLkLFQO/t4dsIGPSsypgv24
         oLT7VnbOLhUsIn7gGSTB+zTSGDB9IytfCqH5yHaFmZYcbjtv81+DcJshWM01jF33H0
         /7Qib9gI8m7VGFDMyM+7k1zMNaJW8LCcqZMdOSY9ChcJmzCW/W+X8GcfYdlnwiiR3J
         XzLirP8rX65rw==
Date:   Wed, 13 Jul 2022 16:55:56 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <oliver.sang@intel.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86: Allow for exclusions in checking RETHUNK
Message-ID: <20220713235556.umnau6nd7u6bz72m@treble>
References: <20220713213133.455599-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220713213133.455599-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:31:33PM -0700, Kees Cook wrote:
> +++ b/drivers/misc/lkdtm/rodata.c
> @@ -4,8 +4,12 @@
>   * (via objcopy tricks), to validate the non-executability of .rodata.
>   */
>  #include "lkdtm.h"
> +#include <linux/objtool.h>
>  
>  void noinstr lkdtm_rodata_do_nothing(void)
>  {
>  	/* Does nothing. We just want an architecture agnostic "return". */
>  }

Since the function only consists of a single RET instruction, could we
just do an asm(ANNOTATE_UNSAFE_RET) here?  i.e. see patch below.

> +/* This is a lie, but given the objcopy, we need objtool to ignore it. */
> +STACK_FRAME_NON_STANDARD(lkdtm_rodata_do_nothing);
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index b341f8a8c7c5..c1b58a682ace 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -902,6 +902,8 @@ static void add_ignores(struct objtool_file *file)
>  	struct reloc *reloc;
>  
>  	sec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
> +	if (!sec)
> +		sec = find_section_by_name(file->elf, ".discard.func_stack_frame_non_standard");
>  	if (!sec)
>  		return;

Why was there no .rela section?

Anyway I don't see how this can work, since the code below it traverses
sec->reloc_list, which only exists for rela sections.

Here's the ANNOTATE_UNSAFE_RET idea.  Most of the diff is moving the
annotation macros to objtool.h (where they belong anyway).

If there are no objections I can split this up into proper patches
tomorrow.

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index bb05ed4f46bd..9b7cfc68767b 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -63,35 +63,6 @@
 
 #ifdef __ASSEMBLY__
 
-/*
- * This should be used immediately before an indirect jump/call. It tells
- * objtool the subsequent indirect jump/call is vouched safe for retpoline
- * builds.
- */
-.macro ANNOTATE_RETPOLINE_SAFE
-	.Lannotate_\@:
-	.pushsection .discard.retpoline_safe
-	_ASM_PTR .Lannotate_\@
-	.popsection
-.endm
-
-/*
- * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
- * vs RETBleed validation.
- */
-#define ANNOTATE_UNRET_SAFE ANNOTATE_RETPOLINE_SAFE
-
-/*
- * Abuse ANNOTATE_RETPOLINE_SAFE on a NOP to indicate UNRET_END, should
- * eventually turn into it's own annotation.
- */
-.macro ANNOTATE_UNRET_END
-#ifdef CONFIG_DEBUG_ENTRY
-	ANNOTATE_RETPOLINE_SAFE
-	nop
-#endif
-.endm
-
 /*
  * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
  * indirect jmp/call which may be susceptible to the Spectre variant 2
@@ -155,12 +126,6 @@
 
 #else /* __ASSEMBLY__ */
 
-#define ANNOTATE_RETPOLINE_SAFE					\
-	"999:\n\t"						\
-	".pushsection .discard.retpoline_safe\n\t"		\
-	_ASM_PTR " 999b\n\t"					\
-	".popsection\n\t"
-
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
 
diff --git a/drivers/misc/lkdtm/rodata.c b/drivers/misc/lkdtm/rodata.c
index 708a2558a7ac..b4aeb50c4a96 100644
--- a/drivers/misc/lkdtm/rodata.c
+++ b/drivers/misc/lkdtm/rodata.c
@@ -8,6 +8,7 @@
 
 void noinstr lkdtm_rodata_do_nothing(void)
 {
+	asm(ANNOTATE_RETPOLINE_SAFE);
 	/* Does nothing. We just want an architecture agnostic "return". */
 }
 
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 10bc88cc3bf6..0bd80ba8e6b2 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -43,6 +43,12 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_SAVE		5
 #define UNWIND_HINT_TYPE_RESTORE	6
 
+/*
+ * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
+ * vs RETBleed validation.
+ */
+#define ANNOTATE_UNRET_SAFE ANNOTATE_RETPOLINE_SAFE
+
 #ifdef CONFIG_OBJTOOL
 
 #include <asm/asm.h>
@@ -84,6 +90,12 @@ struct unwind_hint {
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
+#define ANNOTATE_RETPOLINE_SAFE					\
+	"999:\n\t"						\
+	".pushsection .discard.retpoline_safe\n\t"		\
+	_ASM_PTR " 999b\n\t"					\
+	".popsection\n\t"
+
 #define ANNOTATE_NOENDBR					\
 	"986: \n\t"						\
 	".pushsection .discard.noendbr\n\t"			\
@@ -98,6 +110,29 @@ struct unwind_hint {
 
 #else /* __ASSEMBLY__ */
 
+/*
+ * This should be used immediately before an indirect jump/call. It tells
+ * objtool the subsequent indirect jump/call is vouched safe for retpoline
+ * builds.
+ */
+.macro ANNOTATE_RETPOLINE_SAFE
+	.Lannotate_\@:
+	.pushsection .discard.retpoline_safe
+	_ASM_PTR .Lannotate_\@
+	.popsection
+.endm
+
+/*
+ * Abuse ANNOTATE_RETPOLINE_SAFE on a NOP to indicate UNRET_END, should
+ * eventually turn into it's own annotation.
+ */
+.macro ANNOTATE_UNRET_END
+#ifdef CONFIG_DEBUG_ENTRY
+	ANNOTATE_RETPOLINE_SAFE
+	nop
+#endif
+.endm
+
 /*
  * This macro indicates that the following intra-function call is valid.
  * Any non-annotated intra-function call will cause objtool to issue a warning.
@@ -172,6 +207,8 @@ struct unwind_hint {
 
 #else /* !CONFIG_OBJTOOL */
 
+#define ANNOTATE_RETPOLINE_SAFE
+
 #ifndef __ASSEMBLY__
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 10bc88cc3bf6..0bd80ba8e6b2 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -43,6 +43,12 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_SAVE		5
 #define UNWIND_HINT_TYPE_RESTORE	6
 
+/*
+ * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
+ * vs RETBleed validation.
+ */
+#define ANNOTATE_UNRET_SAFE ANNOTATE_RETPOLINE_SAFE
+
 #ifdef CONFIG_OBJTOOL
 
 #include <asm/asm.h>
@@ -84,6 +90,12 @@ struct unwind_hint {
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
+#define ANNOTATE_RETPOLINE_SAFE					\
+	"999:\n\t"						\
+	".pushsection .discard.retpoline_safe\n\t"		\
+	_ASM_PTR " 999b\n\t"					\
+	".popsection\n\t"
+
 #define ANNOTATE_NOENDBR					\
 	"986: \n\t"						\
 	".pushsection .discard.noendbr\n\t"			\
@@ -98,6 +110,29 @@ struct unwind_hint {
 
 #else /* __ASSEMBLY__ */
 
+/*
+ * This should be used immediately before an indirect jump/call. It tells
+ * objtool the subsequent indirect jump/call is vouched safe for retpoline
+ * builds.
+ */
+.macro ANNOTATE_RETPOLINE_SAFE
+	.Lannotate_\@:
+	.pushsection .discard.retpoline_safe
+	_ASM_PTR .Lannotate_\@
+	.popsection
+.endm
+
+/*
+ * Abuse ANNOTATE_RETPOLINE_SAFE on a NOP to indicate UNRET_END, should
+ * eventually turn into it's own annotation.
+ */
+.macro ANNOTATE_UNRET_END
+#ifdef CONFIG_DEBUG_ENTRY
+	ANNOTATE_RETPOLINE_SAFE
+	nop
+#endif
+.endm
+
 /*
  * This macro indicates that the following intra-function call is valid.
  * Any non-annotated intra-function call will cause objtool to issue a warning.
@@ -172,6 +207,8 @@ struct unwind_hint {
 
 #else /* !CONFIG_OBJTOOL */
 
+#define ANNOTATE_RETPOLINE_SAFE
+
 #ifndef __ASSEMBLY__
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
