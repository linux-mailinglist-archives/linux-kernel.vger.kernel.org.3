Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2CC4D2A24
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiCIH6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiCIH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537261662FA;
        Tue,  8 Mar 2022 23:55:14 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812512;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67vwANpJTkFM+VKLfcSYbwEQmBFZeQvy69Ixfm0A92U=;
        b=h2u+zWXHw3LBNesOmzb4awSqp1HUNyP7MQFidaRMraC1cO2sBbPbeEh4ll+0OgqM3rzO0U
        j8BE/mZjPhSDgqxv+laGURAb8i8HKzfVPtvpFZHFTeW0wUn7G3Iw+tuMfNYhAnXVvBVvCj
        R9Jakn2x6ICufTL1XtT3Te6SM+3VtvukIPk/PicIwxqVIsA/R/XL4cjm1UKTFg+98Fh0Vx
        kxZ1y6Z7LS4fMD+uBEuh9bNt1wS3p3ZsIYAK25HMQYaELWGqkYlQlD4/kf9/Dgj0l0epkj
        balQJ1yOm6Zwknw0b3gF8jE2aUh6rcVymm7Yp3iBdRJFVOHxJ5BalzSS+tiGFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812512;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67vwANpJTkFM+VKLfcSYbwEQmBFZeQvy69Ixfm0A92U=;
        b=Yfl/4WunnGbkmnTr+NYwOs+CcFFaFk/1u9PmD1gg6H7395WqXOLJz3FJfVb3hI0+662cW1
        yVCmkSs9RuOhTWBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Add ANNOTATE_NOENDBR
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.578968224@infradead.org>
References: <20220308154317.578968224@infradead.org>
MIME-Version: 1.0
Message-ID: <164681251179.16921.1282256563704890213.tip-bot2@tip-bot2>
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

Commit-ID:     34963d5e9be5911d93d4a543aa1d07e719599371
Gitweb:        https://git.kernel.org/tip/34963d5e9be5911d93d4a543aa1d07e719599371
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:28 +01:00

x86/ibt: Add ANNOTATE_NOENDBR

In order to have objtool warn about code references to !ENDBR
instruction, we need an annotation to allow this for non-control-flow
instances -- consider text range checks, text patching, or return
trampolines etc.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.578968224@infradead.org
---
 include/linux/objtool.h       | 16 ++++++++++++++++
 tools/include/linux/objtool.h | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index aca52db..f797368 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -77,6 +77,12 @@ struct unwind_hint {
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
+#define ANNOTATE_NOENDBR					\
+	"986: \n\t"						\
+	".pushsection .discard.noendbr\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -129,6 +135,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro ANNOTATE_NOENDBR
+.Lhere_\@:
+	.pushsection .discard.noendbr
+	.quad	.Lhere_\@
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -139,12 +152,15 @@ struct unwind_hint {
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
+#define ANNOTATE_NOENDBR
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
+.macro ANNOTATE_NOENDBR
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index aca52db..f797368 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -77,6 +77,12 @@ struct unwind_hint {
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
+#define ANNOTATE_NOENDBR					\
+	"986: \n\t"						\
+	".pushsection .discard.noendbr\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -129,6 +135,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro ANNOTATE_NOENDBR
+.Lhere_\@:
+	.pushsection .discard.noendbr
+	.quad	.Lhere_\@
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -139,12 +152,15 @@ struct unwind_hint {
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
+#define ANNOTATE_NOENDBR
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
+.macro ANNOTATE_NOENDBR
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
