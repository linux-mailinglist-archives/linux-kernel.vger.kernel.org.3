Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1C507AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357190AbiDSULb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356848AbiDSULU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B7A38798;
        Tue, 19 Apr 2022 13:08:35 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5TQ7e+ydmfc3X+WM3b1du6w735B/gYPHMRRjpCFhjs=;
        b=sKMY8L5iQzjDYBEKLYnoFu3lYBRN3Wk27NgatD4tOZMhLyofV1b6A/32xnBHV83BhHcAmv
        CKzw1xjaFNwMYS7eS57AhxNaqZ5laKa5f2oVeulxBSawPB3hkDwQqRakqczeQwLguuGe0W
        POQvgf/N3p5pAM8qSv7wDjTJzOx2pBAOCIslL6KoYBz+NjdiIpj+cMwMnF/FEEDsddnFpp
        VatpnqLoGH2Yj9j6uK+ObA38nKXweEysdZ+aCFsoE5ZUv2cTMssH1aDFB17qgt9CgpJjE+
        yv02TgH1F0vcPRcWtjavoBZ3bndPfxmxuh9OvPnZLpUGkpwJhibv1rxFr4FCNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5TQ7e+ydmfc3X+WM3b1du6w735B/gYPHMRRjpCFhjs=;
        b=+ylT+DP/+KFGSnQbpmGFlnCGYT5et+976ALnstd9UFfEzJMln3wue1mU0UmbGhW+UpeI/s
        /fsfwmWmwqC+w9Cg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/uaccess: Don't jump between functions
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <9519e4853148b765e047967708f2b61e56c93186.1649718562.git.jpoimboe@redhat.com>
References: <9519e4853148b765e047967708f2b61e56c93186.1649718562.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039891328.4207.11005941518753288516.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     02041b32256628aef0d18ec15d3658fe41bc1afe
Gitweb:        https://git.kernel.org/tip/02041b32256628aef0d18ec15d3658fe41bc1afe
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 11 Apr 2022 16:10:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:53 +02:00

x86/uaccess: Don't jump between functions

For unwinding sanity, a function shouldn't jump to the middle of another
function.  Move the short string user copy code out to a separate
non-function code snippet.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/9519e4853148b765e047967708f2b61e56c93186.1649718562.git.jpoimboe@redhat.com
---
 arch/x86/lib/copy_user_64.S | 87 +++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 8ca5ecf..9dec1b3 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -53,12 +53,12 @@
 SYM_FUNC_START(copy_user_generic_unrolled)
 	ASM_STAC
 	cmpl $8,%edx
-	jb 20f		/* less then 8 bytes, go to byte copy loop */
+	jb .Lcopy_user_short_string_bytes
 	ALIGN_DESTINATION
 	movl %edx,%ecx
 	andl $63,%edx
 	shrl $6,%ecx
-	jz .L_copy_short_string
+	jz copy_user_short_string
 1:	movq (%rsi),%r8
 2:	movq 1*8(%rsi),%r9
 3:	movq 2*8(%rsi),%r10
@@ -79,37 +79,11 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 	leaq 64(%rdi),%rdi
 	decl %ecx
 	jnz 1b
-.L_copy_short_string:
-	movl %edx,%ecx
-	andl $7,%edx
-	shrl $3,%ecx
-	jz 20f
-18:	movq (%rsi),%r8
-19:	movq %r8,(%rdi)
-	leaq 8(%rsi),%rsi
-	leaq 8(%rdi),%rdi
-	decl %ecx
-	jnz 18b
-20:	andl %edx,%edx
-	jz 23f
-	movl %edx,%ecx
-21:	movb (%rsi),%al
-22:	movb %al,(%rdi)
-	incq %rsi
-	incq %rdi
-	decl %ecx
-	jnz 21b
-23:	xor %eax,%eax
-	ASM_CLAC
-	RET
+	jmp copy_user_short_string
 
 30:	shll $6,%ecx
 	addl %ecx,%edx
-	jmp 60f
-40:	leal (%rdx,%rcx,8),%edx
-	jmp 60f
-50:	movl %ecx,%edx
-60:	jmp .Lcopy_user_handle_tail /* ecx is zerorest also */
+	jmp .Lcopy_user_handle_tail
 
 	_ASM_EXTABLE_CPY(1b, 30b)
 	_ASM_EXTABLE_CPY(2b, 30b)
@@ -127,10 +101,6 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 	_ASM_EXTABLE_CPY(14b, 30b)
 	_ASM_EXTABLE_CPY(15b, 30b)
 	_ASM_EXTABLE_CPY(16b, 30b)
-	_ASM_EXTABLE_CPY(18b, 40b)
-	_ASM_EXTABLE_CPY(19b, 40b)
-	_ASM_EXTABLE_CPY(21b, 50b)
-	_ASM_EXTABLE_CPY(22b, 50b)
 SYM_FUNC_END(copy_user_generic_unrolled)
 EXPORT_SYMBOL(copy_user_generic_unrolled)
 
@@ -191,7 +161,7 @@ EXPORT_SYMBOL(copy_user_generic_string)
 SYM_FUNC_START(copy_user_enhanced_fast_string)
 	ASM_STAC
 	/* CPUs without FSRM should avoid rep movsb for short copies */
-	ALTERNATIVE "cmpl $64, %edx; jb .L_copy_short_string", "", X86_FEATURE_FSRM
+	ALTERNATIVE "cmpl $64, %edx; jb copy_user_short_string", "", X86_FEATURE_FSRM
 	movl %edx,%ecx
 1:	rep movsb
 	xorl %eax,%eax
@@ -244,6 +214,53 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
 /*
+ * Finish memcpy of less than 64 bytes.  #AC should already be set.
+ *
+ * Input:
+ * rdi destination
+ * rsi source
+ * rdx count (< 64)
+ *
+ * Output:
+ * eax uncopied bytes or 0 if successful.
+ */
+SYM_CODE_START_LOCAL(copy_user_short_string)
+	movl %edx,%ecx
+	andl $7,%edx
+	shrl $3,%ecx
+	jz .Lcopy_user_short_string_bytes
+18:	movq (%rsi),%r8
+19:	movq %r8,(%rdi)
+	leaq 8(%rsi),%rsi
+	leaq 8(%rdi),%rdi
+	decl %ecx
+	jnz 18b
+.Lcopy_user_short_string_bytes:
+	andl %edx,%edx
+	jz 23f
+	movl %edx,%ecx
+21:	movb (%rsi),%al
+22:	movb %al,(%rdi)
+	incq %rsi
+	incq %rdi
+	decl %ecx
+	jnz 21b
+23:	xor %eax,%eax
+	ASM_CLAC
+	RET
+
+40:	leal (%rdx,%rcx,8),%edx
+	jmp 60f
+50:	movl %ecx,%edx		/* ecx is zerorest also */
+60:	jmp .Lcopy_user_handle_tail
+
+	_ASM_EXTABLE_CPY(18b, 40b)
+	_ASM_EXTABLE_CPY(19b, 40b)
+	_ASM_EXTABLE_CPY(21b, 50b)
+	_ASM_EXTABLE_CPY(22b, 50b)
+SYM_CODE_END(copy_user_short_string)
+
+/*
  * copy_user_nocache - Uncached memory copy with exception handling
  * This will force destination out of cache for more performance.
  *
