Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40044705A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbhLJQbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbhLJQa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:30:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AB0C061A72
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=WGzBlx+8ml9YOtGyHtZqoSpamvxos3Ivvay4Kqjh8ok=; b=nymwX3ewP47k0yccAWU4qIAuNS
        ZXAR48ZPLXd1IC9rL/8GybDbBecTlbXy5/Io0EcNjlxzNqaQt9+4FUzz54Aky4o0BfECNDq2mTsq3
        5SQjhWQmuMqKb8sbXzm9/WI8vFmultuEzVh7YQS9b6qBqd+AR4UHaWym7Tv5DSoz5P20P7yykhFIa
        tBRcmUQfmTVLcqJotx2vucwcRJ8Wm9NlgvBcjeqtGOaJDJLhSNQmW66RhtFTrs17/AQ/KkG6Qz/L3
        x5RhB4WFUfOX2xNN53E0djiA3JW25WP0jVCLhW4Tp7gsFBD6tRhBtGwmeIgSWme0fXBxfZ6njUeN2
        gIWy0BPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvijm-000aWY-Gn; Fri, 10 Dec 2021 16:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A635B3006BA;
        Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 799D82BC73552; Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Message-ID: <20211210162313.857673010@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Dec 2021 17:16:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 8/9] atomic,x86: Alternative atomic_*_overflow() scheme
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shift the overflow range from [0,INT_MIN] to [-1,INT_MIN], this allows
optimizing atomic_inc_overflow() to use "jle" to detect increment
from free-or-negative (with -1 being the new free and it's increment
being 0 which sets ZF).

This then obviously changes atomic_dec*_overflow() since it must now
detect the 0->-1 transition rather than the 1->0. Luckily this is
reflected in the carry flag (since we need to borrow to decrement 0).
However this means decrement must now use the SUB instruction with a
literal, since DEC doesn't set CF.

This then gives the following primitives:

[-1, INT_MIN]					[0, INT_MIN]

inc()						inc()
	lock inc %[var]					mov       $-1, %[reg]
	jle	error-free-or-negative			lock xadd %[reg], %[var]
							test      %[reg], %[reg]
							jle	  error-zero-or-negative

dec()                                           dec()
	lock sub $1, %[var]				lock dec %[var]
	jc	error-to-free				jle	error-zero-or-negative
	jl	error-from-negative

dec_and_test()                                  dec_and_test()
	lock sub $1, %[var]				lock dec %[var]
	jc	do-free					jl	error-from-negative
	jl	error-from-negative			je	do-free

Make sure to set ATOMIC_OVERFLOW_OFFSET to 1 such that other code
interacting with these primitives can re-center 0.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -263,21 +263,31 @@ static __always_inline int arch_atomic_f
 }
 #define arch_atomic_fetch_xor arch_atomic_fetch_xor
 
-#define arch_atomic_dec_overflow(_v, _label)				\
-	asm_volatile_goto(LOCK_PREFIX "decl %[var]\n\t"			\
+#define ATOMIC_OVERFLOW_OFFSET	1
+
+#define arch_atomic_inc_overflow(_v, _label)				\
+	asm_volatile_goto(LOCK_PREFIX "incl %[var]\n\r"			\
 			  "jle %l1"					\
 			  : : [var] "m" ((_v)->counter)			\
 			  : "memory"					\
 			  : _label)
 
+#define arch_atomic_dec_overflow(_v, _label)				\
+	asm_volatile_goto(LOCK_PREFIX "subl $1, %[var]\n\t"		\
+			  "jc %l1\n\t"					\
+			  "jl %l1"					\
+			  : : [var] "m" ((_v)->counter)			\
+			  : "memory"					\
+			  : _label)
+
 #define arch_atomic_dec_and_test_overflow(_v, _label)			\
 ({									\
 	__label__ __zero;						\
 	__label__ __out;						\
 	bool __ret = false;						\
-	asm_volatile_goto(LOCK_PREFIX "decl %[var]\n\t"			\
-			  "jl %l2\n\t"					\
-			  "je %l[__zero]"				\
+	asm_volatile_goto(LOCK_PREFIX "subl $1, %[var]\n\t"		\
+			  "jc %l[__zero]\n\t"				\
+			  "jl %l2"					\
 			  : : [var] "m" ((_v)->counter)			\
 			  : "memory"					\
 			  : __zero, _label);				\


