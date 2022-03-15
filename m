Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4E4D9922
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347391AbiCOKpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347229AbiCOKo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:44:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D7A2FFFE;
        Tue, 15 Mar 2022 03:43:46 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hxu6HAo9k3r6P9W+82qGb8nz5Vk89mWlb5WKvszBbSk=;
        b=Ke1S8EuDTveo1AOl5NiFXcHrPBUJqq46dG6xfL/NrszVsDlKiWM4KumWawUdasEBh9r3o9
        k+i+Qwsr7iX16qogvhfcXhcP6KQwvk1VA8fM2WGVRnpL1QDMMMqnKJ9M6tIcD2qJoxpzhB
        jJaHFMr907UzXpEek5bjAbltp6E44MOggdoIk3TwRYXQpkLniy/BdgKCFPy4S6HbJ6VGn/
        Ua0L2e3xqBlclT5jE9pkGujN5MpsRVIur7gXOsPmZSSmR+uP39rQCP4XJOM0RnCwxkzcn6
        R7XEfBe33uy5GQ7855FvMLqO1yfqgb143nY2bG0YCycwSmVg/qAqysF2/I+LQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hxu6HAo9k3r6P9W+82qGb8nz5Vk89mWlb5WKvszBbSk=;
        b=IO83sPTK6ajbp+CNcrLz7LRHwYoaHiPgoJP+0gFX/KZIEtLUFWLDZ6juPUFiP5+NE/nyqh
        UoNYERtQr/KrJMCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86,objtool: Move the ASM_REACHABLE annotation to objtool.h
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Yi9gOW9f1GGwwUD6@hirez.programming.kicks-ass.net>
References: <Yi9gOW9f1GGwwUD6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164734102445.16921.13366804686413251320.tip-bot2@tip-bot2>
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

Commit-ID:     dca5da2abe406168b85f97e22109710ebe0bda08
Gitweb:        https://git.kernel.org/tip/dca5da2abe406168b85f97e22109710ebe0bda08
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Mar 2022 18:05:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:45 +01:00

x86,objtool: Move the ASM_REACHABLE annotation to objtool.h

Because we need a variant for .S files too.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Yi9gOW9f1GGwwUD6@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/bug.h       |  1 +
 arch/x86/include/asm/irq_stack.h |  1 +
 include/linux/compiler.h         |  7 -------
 include/linux/objtool.h          | 16 ++++++++++++++++
 tools/include/linux/objtool.h    | 16 ++++++++++++++++
 5 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index bab883c..4d20a29 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -4,6 +4,7 @@
 
 #include <linux/stringify.h>
 #include <linux/instrumentation.h>
+#include <linux/objtool.h>
 
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 05af249..63f818a 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_IRQ_STACK_H
 
 #include <linux/ptrace.h>
+#include <linux/objtool.h>
 
 #include <asm/processor.h>
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 0f7fd20..219aa5d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -125,18 +125,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 })
 #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
 
-#define ASM_REACHABLE							\
-	"998:\n\t"							\
-	".pushsection .discard.reachable\n\t"				\
-	".long 998b - .\n\t"						\
-	".popsection\n\t"
-
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(".rodata..c_jump_table")
 
 #else
 #define annotate_unreachable()
-# define ASM_REACHABLE
 #define __annotate_jump_table
 #endif
 
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index f797368..586d357 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -83,6 +83,12 @@ struct unwind_hint {
 	_ASM_PTR " 986b\n\t"					\
 	".popsection\n\t"
 
+#define ASM_REACHABLE							\
+	"998:\n\t"							\
+	".pushsection .discard.reachable\n\t"				\
+	".long 998b - .\n\t"						\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -142,6 +148,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro REACHABLE
+.Lhere_\@:
+	.pushsection .discard.reachable
+	.long	.Lhere_\@ - .
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -153,6 +166,7 @@ struct unwind_hint {
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define ANNOTATE_NOENDBR
+#define ASM_REACHABLE
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
@@ -161,6 +175,8 @@ struct unwind_hint {
 .endm
 .macro ANNOTATE_NOENDBR
 .endm
+.macro REACHABLE
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index f797368..586d357 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -83,6 +83,12 @@ struct unwind_hint {
 	_ASM_PTR " 986b\n\t"					\
 	".popsection\n\t"
 
+#define ASM_REACHABLE							\
+	"998:\n\t"							\
+	".pushsection .discard.reachable\n\t"				\
+	".long 998b - .\n\t"						\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -142,6 +148,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro REACHABLE
+.Lhere_\@:
+	.pushsection .discard.reachable
+	.long	.Lhere_\@ - .
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -153,6 +166,7 @@ struct unwind_hint {
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define ANNOTATE_NOENDBR
+#define ASM_REACHABLE
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
@@ -161,6 +175,8 @@ struct unwind_hint {
 .endm
 .macro ANNOTATE_NOENDBR
 .endm
+.macro REACHABLE
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
