Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E94946DB5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbhLHSo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbhLHSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:44:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A243DC061A72
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5WlgdMMtK59kppfHpuNUf5s3NEGd9KhzGrQnwAexo2M=; b=izSzIQP4dra3R8nZmUMhCLE/vK
        kMSSqeg9aEJgVkn25mWveugMrUBo5deTAi8Zkc7peuvEVbBdk0csV+jlcIPT9z6BQaJrdtA8Jfm8z
        HRDF8/qVBBC9/dIOlXR9iaWUnPiAr2T4wcDB7RuAlVPmwCnHQRI85aHQrQaQ5RpCHXTDi9cGZMwBG
        welcfJGmfkzZnQyd/y3s7uwhwwoYwJMG+mfikeMyUU1fnYnCYDy85tjFCRL077orlAjCOIb8vlN1V
        MAhaYgS0WawScoFMgx/UxW18pv5yAYYMW/tmbssjLC2XzY3lWsS6XghFpIB5VJWDq/yd6r1SwSPj2
        FTklUT9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv1ro-000E8o-Va; Wed, 08 Dec 2021 18:40:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD07E300491;
        Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B103F29B1B7AF; Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Message-ID: <20211208183906.622829307@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Dec 2021 19:36:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org
Subject: [RFC][PATCH 4/5] atomic,x86: Implement atomic_dec_and_test_ofl()
References: <20211208183655.251963904@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a better implementation of atomic_{inc,dec_and_test}_ofl() by
making use of the atomic-op condition codes.

This further improves the fast path code:

    a980:       b8 ff ff ff ff          mov    $0xffffffff,%eax
    a985:       f0 0f c1 07             lock xadd %eax,(%rdi)
    a989:       83 e8 01                sub    $0x1,%eax
    a98c:       78 20                   js     a9ae <ring_buffer_put+0x2e>
    a98e:       74 01                   je     a991 <ring_buffer_put+0x11>
    a990:       c3                      ret

to:

    ab81:       48 89 fb                mov    %rdi,%rbx
    ab84:       f0 ff 0f                lock decl (%rdi)
    ab87:       7c 04                   jl     ab8d <ring_buffer_put+0xd>
    ab89:       74 10                   je     ab9b <ring_buffer_put+0x1b>
    ab8b:       c3                      ret

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -263,6 +263,29 @@ static __always_inline int arch_atomic_f
 }
 #define arch_atomic_fetch_xor arch_atomic_fetch_xor
 
+#define arch_atomic_dec_ofl(_v, _label)					\
+	asm_volatile_goto(LOCK_PREFIX "decl %[var]\n\t"			\
+			  "jle %l1"					\
+			  : : [var] "m" ((_v)->counter)			\
+			  : "memory"					\
+			  : _label)
+
+#define arch_atomic_dec_and_test_ofl(_v, _label)			\
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


