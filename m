Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614174728D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhLMKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbhLMKEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B8C01CB2B;
        Mon, 13 Dec 2021 01:50:25 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LdSI+3cBNobQzzshOcHkNJSjoVgRYo6p5R4N2AE7q8=;
        b=3cbT6uWik+e6A/d9wpA2NlsiypAg8VkoLY6yQzSL58+95ulHcanPHsyqdCRvr92xHmwhrr
        7xUdY5RdyrPzGnWc+xKM8RZK968R9FEVFRhPcV1FFxTYCivFe3j6RrAWT3o9JvJnbqa92B
        hz47ddpcmY/kNnqC4RBFyAJrXNcnZfISTZoIg6Vbv0K15Rp51l9e2XYH5BBsESKf4PwXM4
        pmrqN9KcR50LArvCmFQWSl0RcU9RfbacnPt+jRRYtWNkRi3FFFeofIvoqDc74s7rm9iyQq
        awyVp43NCSc72TGWaXeVMK6pyUWrcTcB6k0KTD92xEu6kaGmf4svEbBb2cMSxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LdSI+3cBNobQzzshOcHkNJSjoVgRYo6p5R4N2AE7q8=;
        b=IxJTFja0ghklGis+cELpvaHF+/pfnPWdxrjgS5Atspu8Ci4NZ83coiN4L8P+cbKBc5B1p2
        ubpbZIRzdz4RJZAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/copy_user_64: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.068505810@infradead.org>
References: <20211110101325.068505810@infradead.org>
MIME-Version: 1.0
Message-ID: <163938902353.23020.7872915094812841883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     acba44d2436d463f60a54bf934d378dcf384a965
Gitweb:        https://git.kernel.org/tip/acba44d2436d463f60a54bf934d378dcf384a965
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:45 +01:00

x86/copy_user_64: Remove .fixup usage

Place the anonymous .fixup code at the tail of the regular functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211110101325.068505810@infradead.org
---
 arch/x86/lib/copy_user_64.S | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 8fb562f..e6ac385 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -32,14 +32,10 @@
 	decl %ecx
 	jnz 100b
 102:
-	.section .fixup,"ax"
-103:	addl %ecx,%edx			/* ecx is zerorest also */
-	jmp .Lcopy_user_handle_tail
-	.previous
 
-	_ASM_EXTABLE_CPY(100b, 103b)
-	_ASM_EXTABLE_CPY(101b, 103b)
-	.endm
+	_ASM_EXTABLE_CPY(100b, .Lcopy_user_handle_align)
+	_ASM_EXTABLE_CPY(101b, .Lcopy_user_handle_align)
+.endm
 
 /*
  * copy_user_generic_unrolled - memory copy with exception handling.
@@ -107,7 +103,6 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 	ASM_CLAC
 	RET
 
-	.section .fixup,"ax"
 30:	shll $6,%ecx
 	addl %ecx,%edx
 	jmp 60f
@@ -115,7 +110,6 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 	jmp 60f
 50:	movl %ecx,%edx
 60:	jmp .Lcopy_user_handle_tail /* ecx is zerorest also */
-	.previous
 
 	_ASM_EXTABLE_CPY(1b, 30b)
 	_ASM_EXTABLE_CPY(2b, 30b)
@@ -166,20 +160,16 @@ SYM_FUNC_START(copy_user_generic_string)
 	movl %edx,%ecx
 	shrl $3,%ecx
 	andl $7,%edx
-1:	rep
-	movsq
+1:	rep movsq
 2:	movl %edx,%ecx
-3:	rep
-	movsb
+3:	rep movsb
 	xorl %eax,%eax
 	ASM_CLAC
 	RET
 
-	.section .fixup,"ax"
 11:	leal (%rdx,%rcx,8),%ecx
 12:	movl %ecx,%edx		/* ecx is zerorest also */
 	jmp .Lcopy_user_handle_tail
-	.previous
 
 	_ASM_EXTABLE_CPY(1b, 11b)
 	_ASM_EXTABLE_CPY(3b, 12b)
@@ -203,16 +193,13 @@ SYM_FUNC_START(copy_user_enhanced_fast_string)
 	cmpl $64,%edx
 	jb .L_copy_short_string	/* less then 64 bytes, avoid the costly 'rep' */
 	movl %edx,%ecx
-1:	rep
-	movsb
+1:	rep movsb
 	xorl %eax,%eax
 	ASM_CLAC
 	RET
 
-	.section .fixup,"ax"
 12:	movl %ecx,%edx		/* ecx is zerorest also */
 	jmp .Lcopy_user_handle_tail
-	.previous
 
 	_ASM_EXTABLE_CPY(1b, 12b)
 SYM_FUNC_END(copy_user_enhanced_fast_string)
@@ -240,6 +227,11 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	RET
 
 	_ASM_EXTABLE_CPY(1b, 2b)
+
+.Lcopy_user_handle_align:
+	addl %ecx,%edx			/* ecx is zerorest also */
+	jmp .Lcopy_user_handle_tail
+
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
 /*
@@ -350,7 +342,6 @@ SYM_FUNC_START(__copy_user_nocache)
 	sfence
 	RET
 
-	.section .fixup,"ax"
 .L_fixup_4x8b_copy:
 	shll $6,%ecx
 	addl %ecx,%edx
@@ -366,7 +357,6 @@ SYM_FUNC_START(__copy_user_nocache)
 .L_fixup_handle_tail:
 	sfence
 	jmp .Lcopy_user_handle_tail
-	.previous
 
 	_ASM_EXTABLE_CPY(1b, .L_fixup_4x8b_copy)
 	_ASM_EXTABLE_CPY(2b, .L_fixup_4x8b_copy)
