Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E050A468528
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355134AbhLDNzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhLDNzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:55:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E2AC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 05:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=i4WiHg7iXoxZsnAwf64b18WHcEUSLjSRr2jrakjNorM=; b=rZKwpKu1MEt4x212JUuooDDNg2
        JgGtSvUzlACfMce5lcQfiOmDOe1nqDmboenst94Z5++0/k3rRVtd3cy7x1zLMLivuD0C23CS3poYi
        DrUtbY28UCfeWJ0D9Oq1yJrtSdo2sZ82KiO0D7szxc0SEHA82zfgzOflbNOuO9Pjz3bjg6YV6lFO2
        qZyBLS5Vw1/W1jYOHNlG56h2I8YxU4hnOLrJzfaRIAHvHnEqCtLmKy4CAxWAc5WpJpICWVu0zvD04
        mXNnaX9k1nf8rWRe8lYGvUtjg1yn9/4gBCgSsjEPvYnKD0SF1Gn3RR0+uJgRbXQaPOub1oo0Ptmyh
        7LP2a6yA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtVRl-00DG37-Nm; Sat, 04 Dec 2021 13:51:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFD2E30026A;
        Sat,  4 Dec 2021 14:51:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7A2222DD25624; Sat,  4 Dec 2021 14:51:24 +0100 (CET)
Message-ID: <20211204134907.841623970@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 04 Dec 2021 14:43:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        keescook@chromium.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v2 1/6] x86/atomic64_386_32: Rename things
References: <20211204134338.760603010@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Principally to get rid of #define RET in this code to make place for a
new RET, but also to clarify the code, rename a bunch of things:

  s/UNLOCK/IRQ_RESTORE/
  s/LOCK/IRQ_SAVE/
  s/BEGIN/BEGIN_IRQ_SAVE/
  s/\<RET\>/RET_IRQ_RESTORE/
  s/RET_ENDP/\tRET_IRQ_RESTORE\rENDP/

which then leaves RET unused so it can be removed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/atomic64_386_32.S |   84 ++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

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


