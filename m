Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3CE48E1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 02:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbiANBFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 20:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiANBFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:05:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395EDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 17:05:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u185-20020a2560c2000000b0060fd98540f7so15274403ybb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 17:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=RjuCZT+fganksUH5bZr8Uzcs2rZgf01j4qeqplouvck=;
        b=gplty4vC9Qp82EmqfWUAyNzxihehA43QUhaIY8nNE1aTpoQBlccBDXy+GdrdCm3yHn
         EYWNpdWXvP1LAHuKXlkdU4varqVeYOr3dHgXMjv0J0U+GQTyENOvwBx3zkedL5Im9aQ3
         N4zLrnXZQp8a7QlWbskS+s4bqY9yPBk1T1dAUbqo278Yy0akx/prt0AYuqteCfDMj4fc
         seajGMLzTQ9XPyMCN7ph7s39JfqR50B+BBGwsvyeMM4/pqVhGCkSus/4tcERAh1k+rGJ
         iBNYClp+GEvcegHc2ZoCP464AMnA9my+XZxSgGHNbKNZbpstp8/A1O9bPcUD4zLdANPH
         z8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=RjuCZT+fganksUH5bZr8Uzcs2rZgf01j4qeqplouvck=;
        b=ojXE9faMHuglpWElV/STVHgy1dboqX7Dh4VgTiIVgT90yw7olGEkN+UXEYoHVD9IuK
         yVdQSdBsjMwhj0LlCpLte0aVPW1UUJEzfIOyhrHZIT9CTs8JCmu2ewI7ELu5lNQTexXS
         fLgKr6QbTHdDnFxf2oya00wFa5FBJ5CXv4a1CaXDp7cdLPiXLTw9fXEd4YU040yNvlCQ
         wN1vPscPNnSu2u54exmIUOF7pvJtfqdfKVTGy+Fu30RGahLHTNqRDeMmkMvpRlGODDJD
         JU1Knpqz1r3tW1lz4K/EAqw5JPlYuYwyHJvc5Pa6FST2ydkyeSursHauej23NoWPJnAy
         b0OQ==
X-Gm-Message-State: AOAM532oUsiPcS4FG2wGLLMVJ2Cjn9o9Xdn/FZ2HKLTkdbgKkpOWC509
        GX0ITI8gRpjYL5+a+XltoOaNuzTkwGj5J3zaiWM=
X-Google-Smtp-Source: ABdhPJyZGMiaifrbpM7MJsw+b0l19q3DqEXoclLAvnHFEi7vqUgBAQeUbyNjqXYm+fwMKvr+uc5+6OZ8tFWhEOJmnXg=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:cae2:dbc1:f963:5489])
 (user=ndesaulniers job=sendgmr) by 2002:a25:3b49:: with SMTP id
 i70mr9172098yba.712.1642122340417; Thu, 13 Jan 2022 17:05:40 -0800 (PST)
Date:   Thu, 13 Jan 2022 17:05:26 -0800
Message-Id: <20220114010526.1776605-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1642122325; l=6868;
 s=20211004; h=from:subject; bh=JVcfRmXkwlckyWvO0KJ0DMWB85z7efazeg6STr6lLYU=;
 b=Szmw4L8Ugr0cfksSUemebgNv/yVMV+yPIO7/p5Rlj2o0kl5blBBzDi+89M6aQ00/WGR2baRiADP/
 xhThZ13aDiPW1K8XAbd0IVzKjVprCpl5FQ0SIuNrsZA2Sv1s5En/
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] objtool: prefer memory clobber & %= to volatile & __COUNTER__
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit dcce50e6cc4d ("compiler.h: Fix annotation macro misplacement with Cl=
ang")
mentions:

> 'volatile' is ignored for some reason and Clang feels free to move the
> reachable() annotation away from its intended location.

Indeed, volatile is not a compiler barrier. Particularly once `-march=3D`
flags are used under certain configs, LLVM's machine-scheduler can be
observed moving instructions across the asm statement meant to point to
known reachable or unreachable code, as reported by 0day bot.

Prefer a memory clobber which is a compiler barrier that prevents these
re-orderings and remove the volatile qualifier.

Looking closer, the use of __COUNTER__ seems to have been used to
prevent de-duplication of these asm statements. The GCC manual mentions:

> Under certain circumstances, GCC may duplicate (or remove duplicates
> of) your assembly code when optimizing. This can lead to unexpected
> duplicate symbol errors during compilation if your asm code defines
> symbols or labels. Using =E2=80=98%=3D=E2=80=99 (see AssemblerTemplate) m=
ay help resolve
> this problem.
>
> =E2=80=98%=3D=E2=80=99 Outputs a number that is unique to each instance o=
f the asm
> statement in the entire compilation. This option is useful when
> creating local labels and referring to them multiple times in a single
> template that generates multiple assembler instructions.

commit 3d1e236022cc ("objtool: Prevent GCC from merging annotate_unreachabl=
e()")

Mentions that

> The inline asm =E2=80=98%=3D=E2=80=99 token could be used for that, but u=
nfortunately
> older versions of GCC don't support it.

From testing all versions of GCC available on godbolt.org, GCC 4.1+
seems to support 4.1. Since the minimum supported version of GCC at the
moment is GCC 5.1, it sounds like this is no longer a concern.

Prefer the %=3D assembler template to having to stringify __COUNTER__.

This commit is effectively a revert of the following commits:
commit dcce50e6cc4d ("compiler.h: Fix annotation macro misplacement with Cl=
ang")
commit f1069a8756b9 ("compiler.h: Avoid using inline asm operand modifiers"=
)
commit c199f64ff93c ("instrumentation.h: Avoid using inline asm operand mod=
ifiers")
commit d0c2e691d1cb ("objtool: Add a comment for the unreachable annotation=
 macros")
commit ec1e1b610917 ("objtool: Prevent GCC from merging annotate_unreachabl=
e(), take 2")
commit 3d1e236022cc ("objtool: Prevent GCC from merging annotate_unreachabl=
e()")

Link: https://github.com/ClangBuiltLinux/linux/issues/1566
Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#AssemblerTemplat=
e
Link: https://lore.kernel.org/llvm/202112080834.XFYU8b5Q-lkp@intel.com/
Link: https://lore.kernel.org/llvm/202111300857.IyINAyJk-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler.h        | 31 +++++++++++--------------------
 include/linux/instrumentation.h | 24 ++++++++++--------------
 2 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 429dcebe2b99..3ac21b888d20 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -108,30 +108,21 @@ void ftrace_likely_update(struct ftrace_likely_data *=
f, int val,
 # define barrier_before_unreachable() do { } while (0)
 #endif
=20
-/* Unreachable code */
+/* These macros help objtool understand GCC code flow for unreachable code=
. */
 #ifdef CONFIG_STACK_VALIDATION
-/*
- * These macros help objtool understand GCC code flow for unreachable code=
.
- * The __COUNTER__ based labels are a hack to make each instance of the ma=
cros
- * unique, to convince GCC not to merge duplicate inline asm statements.
- */
-#define __stringify_label(n) #n
-
-#define __annotate_reachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
-		     ".pushsection .discard.reachable\n\t"		\
-		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
+#define annotate_reachable() ({			\
+	asm (".Lreachable%=3D:\n\t"			\
+	     ".pushsection .discard.reachable\n\t"	\
+	     ".long .Lreachable%=3D - .\n\t"		\
+	     ".popsection\n\t" ::: "memory");		\
 })
-#define annotate_reachable() __annotate_reachable(__COUNTER__)
=20
-#define __annotate_unreachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
-		     ".pushsection .discard.unreachable\n\t"		\
-		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
+#define annotate_unreachable() ({			\
+	asm (".Lunreachable%=3D:\n\t"			\
+	     ".pushsection .discard.unreachable\n\t"	\
+	     ".long .Lunreachable%=3D - .\n\t"		\
+	     ".popsection\n\t" ::: "memory");		\
 })
-#define annotate_unreachable() __annotate_unreachable(__COUNTER__)
=20
 #define ASM_UNREACHABLE							\
 	"999:\n\t"							\
diff --git a/include/linux/instrumentation.h b/include/linux/instrumentatio=
n.h
index 24359b4a9605..0dae9c08764f 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -4,16 +4,13 @@
=20
 #if defined(CONFIG_DEBUG_ENTRY) && defined(CONFIG_STACK_VALIDATION)
=20
-#include <linux/stringify.h>
-
 /* Begin/end of an instrumentation safe region */
-#define __instrumentation_begin(c) ({					\
-	asm volatile(__stringify(c) ": nop\n\t"				\
-		     ".pushsection .discard.instr_begin\n\t"		\
-		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
+#define instrumentation_begin() ({			\
+	asm (".Linstbegin%=3D: nop\n\t"			\
+	     ".pushsection .discard.instr_begin\n\t"	\
+	     ".long .Linstbegin%=3D - .\n\t"		\
+	     ".popsection\n\t" ::: "memory");		\
 })
-#define instrumentation_begin() __instrumentation_begin(__COUNTER__)
=20
 /*
  * Because instrumentation_{begin,end}() can nest, objtool validation cons=
iders
@@ -46,13 +43,12 @@
  * To avoid this, have _end() be a NOP instruction, this ensures it will b=
e
  * part of the condition block and does not escape.
  */
-#define __instrumentation_end(c) ({					\
-	asm volatile(__stringify(c) ": nop\n\t"				\
-		     ".pushsection .discard.instr_end\n\t"		\
-		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
+#define instrumentation_end() ({			\
+	asm (".Linstend%=3D: nop\n\t"			\
+	     ".pushsection .discard.instr_end\n\t"	\
+	     ".long .Linstend%=3D - .\n\t"		\
+	     ".popsection\n\t" ::: "memory");		\
 })
-#define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else
 # define instrumentation_begin()	do { } while(0)
 # define instrumentation_end()		do { } while(0)

base-commit: dcce50e6cc4d86a63dc0a9a6ee7d4f948ccd53a1
--=20
2.34.1.703.g22d0c6ccf7-goog

