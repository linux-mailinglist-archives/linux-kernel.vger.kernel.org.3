Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895D246FF61
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhLJLJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:09:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbhLJLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:08:56 -0500
Date:   Fri, 10 Dec 2021 11:05:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639134320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwnLeJfHwdJRNHEYeNbBsJuiLSU6PlZ5Q7YUKK4wPJ4=;
        b=qhWokm3qNsP9Q+Mejr2uUD7XqpB4jJ4I7+MCTmfwUL9lj6lApcYhdK+OkqUNNE7iBKWICO
        QZUmTTevpykntyjCGCAlSy+DANl/MZ434OUtEjZzGu9Gx7iA+b+GQ9yYVgLFJn8gLlWSDM
        XaCPhD/Sji+plWygINK3RRLOCD9at/Yfc/eQJr7vu7Q7M+b/8YLvKiaggBqCkiGej8u9I7
        +O6ox/u0q7OML0o4D+TfOtJk1ySwnLKWSYn75NYQFnVUH0k5F2Ai4655jRL0S9qyZFBepa
        yehMsieOd4p5O23mVTQIxkdEPSFSvCcN4R2BIWddTJYTBAlwFhtZyD2TxjAdWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639134320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwnLeJfHwdJRNHEYeNbBsJuiLSU6PlZ5Q7YUKK4wPJ4=;
        b=alfs/8Ez9QiVuXPZrpsVhD5bpDbnbzv4VvB3Uz/8/CUOPXp7TzgWZUyinxiwtLa9+wlFre
        5WOIpvgJSVNCIADg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/lib/atomic64_386_32: Rename things
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211204134907.841623970@infradead.org>
References: <20211204134907.841623970@infradead.org>
MIME-Version: 1.0
Message-ID: <163913431912.23020.252828531596067663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     22da5a07c75e1104caf6a42f189c97b83d070073
Gitweb:        https://git.kernel.org/tip/22da5a07c75e1104caf6a42f189c97b83d070073
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 04 Dec 2021 14:43:39 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 11:57:08 +01:00

x86/lib/atomic64_386_32: Rename things

Principally, in order to get rid of #define RET in this code to make
place for a new RET, but also to clarify the code, rename a bunch of
things:

  s/UNLOCK/IRQ_RESTORE/
  s/LOCK/IRQ_SAVE/
  s/BEGIN/BEGIN_IRQ_SAVE/
  s/\<RET\>/RET_IRQ_RESTORE/
  s/RET_ENDP/\tRET_IRQ_RESTORE\rENDP/

which then leaves RET unused so it can be removed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211204134907.841623970@infradead.org
---
 arch/x86/lib/atomic64_386_32.S | 84 ++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/arch/x86/lib/atomic64_386_32.S b/arch/x86/lib/atomic64_386_32.S
index 16bc913..4ad6b97 100644
--- a/arch/x86/lib/atomic64_386_32.S
+++ b/arch/x86/lib/atomic64_386_32.S
@@ -9,81 +9,83 @@
 #include <asm/alternative.h>
 
 /* if you want SMP support, implement these with real spinlocks */
-.macro LOCK reg
+.macro IRQ_SAVE reg
 	pushfl
 	cli
 .endm
 
-.macro UNLOCK reg
+.macro IRQ_RESTORE reg
 	popfl
 .endm
 
-#define BEGIN(op) \
+#define BEGIN_IRQ_SAVE(op) \
 .macro endp; \
 SYM_FUNC_END(atomic64_##op##_386); \
 .purgem endp; \
 .endm; \
 SYM_FUNC_START(atomic64_##op##_386); \
-	LOCK v;
+	IRQ_SAVE v;
 
 #define ENDP endp
 
-#define RET \
-	UNLOCK v; \
+#define RET_IRQ_RESTORE \
+	IRQ_RESTORE v; \
 	ret
 
-#define RET_ENDP \
-	RET; \
-	ENDP
-
 #define v %ecx
-BEGIN(read)
+BEGIN_IRQ_SAVE(read)
 	movl  (v), %eax
 	movl 4(v), %edx
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v %esi
-BEGIN(set)
+BEGIN_IRQ_SAVE(set)
 	movl %ebx,  (v)
 	movl %ecx, 4(v)
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v  %esi
-BEGIN(xchg)
+BEGIN_IRQ_SAVE(xchg)
 	movl  (v), %eax
 	movl 4(v), %edx
 	movl %ebx,  (v)
 	movl %ecx, 4(v)
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v %ecx
-BEGIN(add)
+BEGIN_IRQ_SAVE(add)
 	addl %eax,  (v)
 	adcl %edx, 4(v)
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v %ecx
-BEGIN(add_return)
+BEGIN_IRQ_SAVE(add_return)
 	addl  (v), %eax
 	adcl 4(v), %edx
 	movl %eax,  (v)
 	movl %edx, 4(v)
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v %ecx
-BEGIN(sub)
+BEGIN_IRQ_SAVE(sub)
 	subl %eax,  (v)
 	sbbl %edx, 4(v)
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v %ecx
-BEGIN(sub_return)
+BEGIN_IRQ_SAVE(sub_return)
 	negl %edx
 	negl %eax
 	sbbl $0, %edx
@@ -91,47 +93,52 @@ BEGIN(sub_return)
 	adcl 4(v), %edx
 	movl %eax,  (v)
 	movl %edx, 4(v)
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v %esi
-BEGIN(inc)
+BEGIN_IRQ_SAVE(inc)
 	addl $1,  (v)
 	adcl $0, 4(v)
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v %esi
-BEGIN(inc_return)
+BEGIN_IRQ_SAVE(inc_return)
 	movl  (v), %eax
 	movl 4(v), %edx
 	addl $1, %eax
 	adcl $0, %edx
 	movl %eax,  (v)
 	movl %edx, 4(v)
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v %esi
-BEGIN(dec)
+BEGIN_IRQ_SAVE(dec)
 	subl $1,  (v)
 	sbbl $0, 4(v)
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v %esi
-BEGIN(dec_return)
+BEGIN_IRQ_SAVE(dec_return)
 	movl  (v), %eax
 	movl 4(v), %edx
 	subl $1, %eax
 	sbbl $0, %edx
 	movl %eax,  (v)
 	movl %edx, 4(v)
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
 
 #define v %esi
-BEGIN(add_unless)
+BEGIN_IRQ_SAVE(add_unless)
 	addl %eax, %ecx
 	adcl %edx, %edi
 	addl  (v), %eax
@@ -143,7 +150,7 @@ BEGIN(add_unless)
 	movl %edx, 4(v)
 	movl $1, %eax
 2:
-	RET
+	RET_IRQ_RESTORE
 3:
 	cmpl %edx, %edi
 	jne 1b
@@ -153,7 +160,7 @@ ENDP
 #undef v
 
 #define v %esi
-BEGIN(inc_not_zero)
+BEGIN_IRQ_SAVE(inc_not_zero)
 	movl  (v), %eax
 	movl 4(v), %edx
 	testl %eax, %eax
@@ -165,7 +172,7 @@ BEGIN(inc_not_zero)
 	movl %edx, 4(v)
 	movl $1, %eax
 2:
-	RET
+	RET_IRQ_RESTORE
 3:
 	testl %edx, %edx
 	jne 1b
@@ -174,7 +181,7 @@ ENDP
 #undef v
 
 #define v %esi
-BEGIN(dec_if_positive)
+BEGIN_IRQ_SAVE(dec_if_positive)
 	movl  (v), %eax
 	movl 4(v), %edx
 	subl $1, %eax
@@ -183,5 +190,6 @@ BEGIN(dec_if_positive)
 	movl %eax,  (v)
 	movl %edx, 4(v)
 1:
-RET_ENDP
+	RET_IRQ_RESTORE
+ENDP
 #undef v
