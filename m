Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9D4A79D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiBBU4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbiBBU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:56:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC64C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 12:56:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b2-20020a252e42000000b00619593ff8ddso1672231ybn.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 12:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cx1XGJFOM9vV+ujVLRyBYr3s7YbuCuxv2q/Mj2t/VXY=;
        b=Miom91qjEDgMZF68by2WdOphaXYlYcjxGQCKPhn3uKhvERmOjZvoPwNxb0+h2fk/pR
         /5JTthMz96Wx5EzgrHxTPnfeAYcp3ZCDmX/P7/7TKMVjy7x09fASzF9wsB3LeYkmF4FA
         aVbBg0/LEZC14qFUQReiphE+Wdiw7ZeareTm3wneA5hgdJeyyV6m7bZ/0LwWn/5aVhoJ
         sscipcIXxHyQD3lnMykkRBE9k836RawsQ7ulT2UXzIRRdovonwz8e1HSAeUSTHPn8xMq
         rvgx/jmtNUguHlpJqgQGCdWvqg2Jc6BgNOiiltVBeRi9HZ3ztGPPsL8g4gSqZcee9cY2
         0r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cx1XGJFOM9vV+ujVLRyBYr3s7YbuCuxv2q/Mj2t/VXY=;
        b=VnaCdCNYgoBR4PnIVRq1445jj/sp/vO6znkxa/aS/VJz/MXgasmjhAmjOL+/MC2w/R
         5kpqKf4gOVbLIaHr1y0iiKgUkd2xy2nhjo90UYmxSGXDepHbnitfsG47s56JNykInyUe
         Mq0XrKx1Atn2Wa3IzLmbMk4MXc/6aZnhoZBgZjkJEnOw46Hj55RIv3SQDShW27LyZ88k
         A+9nvpZURt02oc681NFOCgXjJDZP1ZKaqS8eJ2AAJ9MSuCLCkT2I8WluDcRzQzsCFZdm
         D4EPjQCbhLYGo9MKJGGb1WZb67pbF1051XmKSzq+589Q/wYqxlXOta6GquaitvFi8/tl
         E6sA==
X-Gm-Message-State: AOAM531VFt4XY2u2O8yLYJklRFISehbL3mqwGs+vf3VjGnngZ3ltPKDD
        tzql8XEQjSD1HX9+CPfGeQmS0/WKPMM9bdD/yeM=
X-Google-Smtp-Source: ABdhPJzjOIdXwdMxzPKt+BAnyHps+zRIsPRjzOHXQtDzfFRtgjc/T/6/kRcAWunw6snKE7Ar13SGEnGpgafrtTQ7whk=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:90a:a2a6:ce25:fda2])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:1028:: with SMTP id
 x8mr41613379ybt.583.1643835366769; Wed, 02 Feb 2022 12:56:06 -0800 (PST)
Date:   Wed,  2 Feb 2022 12:55:53 -0800
Message-Id: <20220202205557.2260694-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1643835353; l=6651;
 s=20211004; h=from:subject; bh=XnpkEF4H4ongVqCF0+NLNSyetMQoOyby61mBk4p47DY=;
 b=SdUMlOeS7d9udoAwDdc3bdAJFGNhDRUrkTCaq1swi9UcYcxwZq13ZSbgwzWQokVLje1gGGZrmlzJ
 bOKCNeh/CJBE7uIqSjfgY0FkI5mTRG2wL/5cT7zW53BvZK4dB9qC
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] x86: bug.h: merge annotate_reachable into _BUG_FLAGS for __WARN_FLAGS
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __WARN_FLAGS, we had two asm statements (abbreviated):
asm volatile("ud2");
asm volatile(".pushsection .discard.reachable");

These pair of statements are used to trigger an exception, but then help
objtool understand that for warnings, control flow will be restored
immediately afterwards.

The problem is that volatile is not a compiler barrier. GCC explicitly
documents this.

> Note that the compiler can move even volatile asm instructions
> relative to other code, including across jump instructions.

Also, no clobbers are specified to prevent instructions from subsequent
statements from being scheduled by compiler before the second asm
statement. This can lead to instructions from subsequent statements
being emitted by the compiler before the second asm statement.

Providing a scheduling model such as via -march= options enables the
compiler to better schedule instructions with known latencies to hide
latencies from data hazards compared to inline asm statements in which
latencies are not estimated.

If an instruction gets scheduled by the compiler between the two asm
statements, then objtool will think that it is not reachable, producing
a warning.

To prevent instructions from being scheduled in between the two asm
statements, merge them.

This change also removes an unnecessary unreachable() asm annotation
from BUG() in favor of __builtin_unreachable(). objtool is able to track
that the ud2 from BUG() terminates control flow within the function.

Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
Link: https://github.com/ClangBuiltLinux/linux/issues/1483
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Note to reviewers:
This patch is related but somewhat orthogonal to
https://lore.kernel.org/llvm/20220114010526.1776605-1-ndesaulniers@google.com/.
We're still discussing in
https://lore.kernel.org/llvm/20220131225250.409564-1-ndesaulniers@google.com/
whether such a barrier exists to salvage instrumentation_{begin|end}. I
may have follow up patches based on the result of that discussion.
Regardless of the outcome, I think this patch stands on its own merit,
and any changes to instrumentation_{begin|end} would not undo the
merging of asm statements done in this patch. Finally, I tried adding a
diagnostic to clang to warn when volatile is being used in a way that's
suspicious (https://goto.google.com/llvm-cr/D118297), but I don't think
that will land. Thanks to Nathan for the relevant citiation of the GCC
docs.

 arch/x86/include/asm/bug.h | 20 +++++++++++---------
 include/linux/compiler.h   | 21 +++++----------------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 84b87538a15d..f98db09bffd4 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -22,7 +22,7 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#define _BUG_FLAGS(ins, flags)						\
+#define _BUG_FLAGS(ins, flags, extra)					\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
@@ -31,7 +31,8 @@ do {									\
 		     "\t.word %c1"        "\t# bug_entry::line\n"	\
 		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
 		     "\t.org 2b+%c3\n"					\
-		     ".popsection"					\
+		     ".popsection\n"					\
+		     extra \
 		     : : "i" (__FILE__), "i" (__LINE__),		\
 			 "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
@@ -39,14 +40,15 @@ do {									\
 
 #else /* !CONFIG_DEBUG_BUGVERBOSE */
 
-#define _BUG_FLAGS(ins, flags)						\
+#define _BUG_FLAGS(ins, flags, extra)					\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
 		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
 		     "\t.org 2b+%c1\n"					\
-		     ".popsection"					\
+		     ".popsection\n"					\
+		     extra \
 		     : : "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
@@ -55,7 +57,7 @@ do {									\
 
 #else
 
-#define _BUG_FLAGS(ins, flags)  asm volatile(ins)
+#define _BUG_FLAGS(ins, flags, extra)  asm volatile(ins)
 
 #endif /* CONFIG_GENERIC_BUG */
 
@@ -63,8 +65,8 @@ do {									\
 #define BUG()							\
 do {								\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, 0);					\
-	unreachable();						\
+	_BUG_FLAGS(ASM_UD2, 0, "");				\
+	__builtin_unreachable();				\
 } while (0)
 
 /*
@@ -75,9 +77,9 @@ do {								\
  */
 #define __WARN_FLAGS(flags)					\
 do {								\
+	__auto_type f = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));		\
-	annotate_reachable();					\
+	_BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);			\
 	instrumentation_end();					\
 } while (0)
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 429dcebe2b99..0f7fd205ab7e 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -117,14 +117,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  */
 #define __stringify_label(n) #n
 
-#define __annotate_reachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
-		     ".pushsection .discard.reachable\n\t"		\
-		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
-})
-#define annotate_reachable() __annotate_reachable(__COUNTER__)
-
 #define __annotate_unreachable(c) ({					\
 	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.unreachable\n\t"		\
@@ -133,24 +125,21 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 })
 #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
 
-#define ASM_UNREACHABLE							\
-	"999:\n\t"							\
-	".pushsection .discard.unreachable\n\t"				\
-	".long 999b - .\n\t"						\
+#define ASM_REACHABLE							\
+	"998:\n\t"							\
+	".pushsection .discard.reachable\n\t"				\
+	".long 998b - .\n\t"						\
 	".popsection\n\t"
 
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(".rodata..c_jump_table")
 
 #else
-#define annotate_reachable()
 #define annotate_unreachable()
+# define ASM_REACHABLE
 #define __annotate_jump_table
 #endif
 
-#ifndef ASM_UNREACHABLE
-# define ASM_UNREACHABLE
-#endif
 #ifndef unreachable
 # define unreachable() do {		\
 	annotate_unreachable();		\

base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.35.0.rc2.247.g8bbb082509-goog

