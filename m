Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F829495210
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376911AbiATQJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376873AbiATQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:09:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CDAC061746;
        Thu, 20 Jan 2022 08:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=O4yxE5iBljUnz9jsYfJACEXe1y1JTPG27a4exjE3DTU=; b=N1I9L8vqLIoEjF6t+ZNSkBly0b
        sqgDFRzLWknIOXl6tCRnqlMxOkJ/xXXo53bEjoDT5ovaZrlI+PdcAdAcl+olnMfIc3AlP74Sm61zg
        04j9SRoF5wGwCOUgF/VTuIXqL18OZ/fqq9ZDzKpoRgZqEHEi0gkRLa2DV20ZayIEI+Z42mPV4ytfY
        6WnjWTTQ259UHUGnLykfNUS0KQl1hh9aPB/YrVlnALNschhfq1zdk3snBH+VtqtRYzHfV209c4M0w
        Vy3p04hlypEiQRgqnrnHJ3hdXXS2575F5iRfflIG0unT1/68dQwDJ9yDTnnXS6VtSFTuuZuGG4Qj2
        aW9583Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAZza-00EQ4G-4H; Thu, 20 Jan 2022 16:08:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFE5830077D;
        Thu, 20 Jan 2022 17:08:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A0A6A20279CE0; Thu, 20 Jan 2022 17:08:51 +0100 (CET)
Message-ID: <20220120160822.852009966@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Jan 2022 16:55:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io, Sean Christopherson <seanjc@google.com>
Subject: [RFC][PATCH v2 4/5] x86/uaccess: Implement unsafe_try_cmpxchg_user()
References: <20220120155517.066795336@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do try_cmpxchg() loops on userspace addresses.

Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/uaccess.h |   67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -342,6 +342,24 @@ do {									\
 		     : [umem] "m" (__m(addr))				\
 		     : : label)
 
+#define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm_volatile_goto("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
+		     _ASM_EXTABLE_UA(1b, %l[label])			\
+		     : CC_OUT(z) (success),				\
+		       [ptr] "+m" (*_ptr),				\
+		       [old] "+a" (__old)				\
+		     : [new] ltype (__new)				\
+		     : "memory", "cc"					\
+		     : label);						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 #ifdef CONFIG_X86_32
@@ -407,6 +425,30 @@ do {									\
 		     : [umem] "m" (__m(addr)),				\
 		       "0" (err))
 
+#define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
+	int __err = 0;							\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
+		     CC_SET(z)						\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : CC_OUT(z) (success),				\
+		       [errout] "+r" (__err),				\
+		       [ptr] "+m" (*_ptr),				\
+		       [old] "+a" (__old)				\
+		     : [new] ltype (__new)				\
+		     : "memory", "cc");					\
+	if (unlikely(__err))						\
+		goto label;						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 /* FIXME: this hack is definitely wrong -AK */
@@ -501,6 +543,31 @@ do {										\
 } while (0)
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
+extern void __try_cmpxchg_user_wrong_size(void);
+
+#define unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({		\
+	__typeof__(*(_ptr)) __ret;					\
+	switch (sizeof(__ret)) {					\
+	case 1:	__ret = __try_cmpxchg_user_asm("b", "q",		\
+					       (_ptr), (_oldp),		\
+					       (_nval), _label);	\
+		break;							\
+	case 2:	__ret = __try_cmpxchg_user_asm("w", "r",		\
+					       (_ptr), (_oldp),		\
+					       (_nval), _label);	\
+		break;							\
+	case 4:	__ret = __try_cmpxchg_user_asm("l", "r",		\
+					       (_ptr), (_oldp),		\
+					       (_nval), _label);	\
+		break;							\
+	case 8:	__ret = __try_cmpxchg_user_asm("q", "r",		\
+					       (_ptr), (_oldp),		\
+					       (_nval), _label);	\
+		break;							\
+	default: __try_cmpxchg_user_wrong_size();			\
+	}								\
+	__ret;						})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.


