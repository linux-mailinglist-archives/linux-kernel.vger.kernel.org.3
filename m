Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632694705A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbhLJQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbhLJQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:30:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E96C061A32
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Qg/RiJ5yqmaRfWocnGQn09ZU5P1p7wY/f+eRvkt1vd0=; b=A5tYy9/5N02DLjMY0lrxUfq6SV
        b8BiV1da305J87HQ3SdyUWuY5q2X3FZyY3wXwcRyuFSYv8+Gw+EcistOK0ZTK9kQd41kjcA+Q47yX
        /+rhYLz5ev2u+T9KIa9FO1MCNy+6gKU3A29YxpPNBstMqtE6P/mLCx2LLwtCwNQY1LIhO517ZwLa+
        0Fd+QSDdlcCkhpnHgqIj8sBCKUIEMWGfEN8Zi1rISywmXlcr0dylod94ECHGKJ9BR077sLXhJEij7
        Jukq1BUgyk2mzTJbpiOxdZf8r778I9LveyHQC4iTzDLQABCiduxd7w98xdjyA+7WDKfi0mgKjaHo2
        4majscDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvijl-00ATww-SD; Fri, 10 Dec 2021 16:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A63DE300792;
        Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6A2632B3CD728; Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Message-ID: <20211210162313.599116743@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Dec 2021 17:16:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 5/9] atomic,x86: Implement atomic_dec_and_test_overflow()
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a better implementation of atomic_{dec,dec_and_test}_overflow() by
making use of the atomic-op condition codes.

This further improves the fast path code:

    a980:       b8 ff ff ff ff          mov    $0xffffffff,%eax
    a985:       f0 0f c1 07             lock xadd %eax,(%rdi)
    a989:       83 e8 01                sub    $0x1,%eax
    a98c:       78 20                   js     a9ae <ring_buffer_put+0x2e>
    a98e:       74 01                   je     a991 <ring_buffer_put+0x11>
    a990:       c3                      ret

to:

    a950:       f0 ff 0f                lock decl (%rdi)
    a953:       7c 20                   jl     a975 <ring_buffer_put+0x25>
    a955:       74 01                   je     a958 <ring_buffer_put+0x8>
    a957:       c3                      ret

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -263,6 +263,29 @@ static __always_inline int arch_atomic_f
 }
 #define arch_atomic_fetch_xor arch_atomic_fetch_xor
 
+#define arch_atomic_dec_overflow(_v, _label)				\
+	asm_volatile_goto(LOCK_PREFIX "decl %[var]\n\t"			\
+			  "jle %l1"					\
+			  : : [var] "m" ((_v)->counter)			\
+			  : "memory"					\
+			  : _label)
+
+#define arch_atomic_dec_and_test_overflow(_v, _label)			\
+({									\
+	__label__ __zero;						\
+	__label__ __out;						\
+	bool __ret = false;						\
+	asm_volatile_goto(LOCK_PREFIX "decl %[var]\n\t"			\
+			  "jl %l2\n\t"					\
+			  "je %l[__zero]"				\
+			  : : [var] "m" ((_v)->counter)			\
+			  : "memory"					\
+			  : __zero, _label);				\
+	goto __out;							\
+__zero:	__ret = true;							\
+__out:	__ret;								\
+})
+
 #ifdef CONFIG_X86_32
 # include <asm/atomic64_32.h>
 #else


