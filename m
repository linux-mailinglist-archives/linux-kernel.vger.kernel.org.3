Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352E957F508
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiGXM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiGXM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CCB21A2;
        Sun, 24 Jul 2022 05:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AA5F61045;
        Sun, 24 Jul 2022 12:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32B4C341C0;
        Sun, 24 Jul 2022 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658665566;
        bh=ui9v7vSQ2hZ9Vz4T0T/cwSBKPyXOYiw7vf10Zir0n/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8tM3zQA2WovR9pT9WzJIjE98QNUnL4S8sdgOcnO2R/y5boR36AkueAY4wiA22wJb
         mC5v+aqu6nLFl0jo8qFZ7ZX/3zTAzQumB3Km6mtWd6/hn309e14rjRJYqandv8gHAT
         Oq9CS7IyVWM/Gcw9YRFLiw74pQeK9El8Y7TZpwWi7iU3ScSBFsgvhQ6t1RR/FLqmOX
         vbGI1NoY0xUjqX0kFG1YP32lyWN0ddJwrG6cmjCsLHhK2xZGNZPjlIetlVtU1FDmcJ
         Nl4fm4T142c6xW+vI1PuL3B4z05GBt0f7ojjkzYJHnTdI8JuZVWYW30KmWeUW5q+lB
         aCyDG6Oek9H6w==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, mingo@redhat.com,
        philipp.tomsich@vrull.eu, cmuellner@linux.com,
        linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM
Cc:     linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V8 06/10] riscv: atomic: Clean up unnecessary acquire and release definitions
Date:   Sun, 24 Jul 2022 08:25:13 -0400
Message-Id: <20220724122517.1019187-7-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220724122517.1019187-1-guoren@kernel.org>
References: <20220724122517.1019187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Clean up unnecessary xchg_acquire, xchg_release, and cmpxchg_release
custom definitions, because the generic implementation is the same as
the riscv custom implementation.

Before the patch:
000000000000024e <.LBB238>:
                ops = xchg_acquire(pending_ipis, 0);
 24e:   089937af                amoswap.d       a5,s1,(s2)
 252:   0230000f                fence   r,rw

0000000000000256 <.LBB243>:
                ops = xchg_release(pending_ipis, 0);
 256:   0310000f                fence   rw,w
 25a:   089934af                amoswap.d       s1,s1,(s2)

After the patch:
000000000000026e <.LBB245>:
                ops = xchg_acquire(pending_ipis, 0);
 26e:   089937af                amoswap.d       a5,s1,(s2)

0000000000000272 <.LBE247>:
 272:   0230000f                fence   r,rw

0000000000000276 <.LBB249>:
                ops = xchg_release(pending_ipis, 0);
 276:   0310000f                fence   rw,w

000000000000027a <.LBB251>:
 27a:   089934af                amoswap.d       s1,s1,(s2)

Only cmpxchg_acquire is necessary (It prevents unnecessary acquire
ordering when the value from lr is different from old).

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/atomic.h  |  19 -----
 arch/riscv/include/asm/cmpxchg.h | 116 -------------------------------
 2 files changed, 135 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 0dfe9d857a76..83636320ba95 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -249,16 +249,6 @@ c_t arch_atomic##prefix##_xchg_relaxed(atomic##prefix##_t *v, c_t n)	\
 	return __xchg_relaxed(&(v->counter), n, size);			\
 }									\
 static __always_inline							\
-c_t arch_atomic##prefix##_xchg_acquire(atomic##prefix##_t *v, c_t n)	\
-{									\
-	return __xchg_acquire(&(v->counter), n, size);			\
-}									\
-static __always_inline							\
-c_t arch_atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)	\
-{									\
-	return __xchg_release(&(v->counter), n, size);			\
-}									\
-static __always_inline							\
 c_t arch_atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)		\
 {									\
 	return __xchg(&(v->counter), n, size);				\
@@ -276,12 +266,6 @@ c_t arch_atomic##prefix##_cmpxchg_acquire(atomic##prefix##_t *v,	\
 	return __cmpxchg_acquire(&(v->counter), o, n, size);		\
 }									\
 static __always_inline							\
-c_t arch_atomic##prefix##_cmpxchg_release(atomic##prefix##_t *v,	\
-				     c_t o, c_t n)			\
-{									\
-	return __cmpxchg_release(&(v->counter), o, n, size);		\
-}									\
-static __always_inline							\
 c_t arch_atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
 {									\
 	return __cmpxchg(&(v->counter), o, n, size);			\
@@ -299,12 +283,9 @@ c_t arch_atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
 ATOMIC_OPS()
 
 #define arch_atomic_xchg_relaxed	arch_atomic_xchg_relaxed
-#define arch_atomic_xchg_acquire	arch_atomic_xchg_acquire
-#define arch_atomic_xchg_release	arch_atomic_xchg_release
 #define arch_atomic_xchg		arch_atomic_xchg
 #define arch_atomic_cmpxchg_relaxed	arch_atomic_cmpxchg_relaxed
 #define arch_atomic_cmpxchg_acquire	arch_atomic_cmpxchg_acquire
-#define arch_atomic_cmpxchg_release	arch_atomic_cmpxchg_release
 #define arch_atomic_cmpxchg		arch_atomic_cmpxchg
 
 #undef ATOMIC_OPS
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 12debce235e5..67ab6375b650 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -44,76 +44,6 @@
 					    _x_, sizeof(*(ptr)));	\
 })
 
-#define __xchg_acquire(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
-
-#define arch_xchg_acquire(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
-
-#define __xchg_release(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
-
-#define arch_xchg_release(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_release((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
-
 #define __xchg(ptr, new, size)						\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
@@ -253,52 +183,6 @@
 					_o_, _n_, sizeof(*(ptr)));	\
 })
 
-#define __cmpxchg_release(ptr, old, new, size)				\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__typeof__(*(ptr)) __ret;					\
-	register unsigned int __rc;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"0:	lr.w %0, %2\n"				\
-			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" ((long)__old), "rJ" (__new)		\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"0:	lr.d %0, %2\n"				\
-			"	bne %0, %z3, 1f\n"			\
-			"	sc.d %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
-
-#define arch_cmpxchg_release(ptr, o, n)					\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_release((ptr),			\
-					_o_, _n_, sizeof(*(ptr)));	\
-})
-
 #define __cmpxchg(ptr, old, new, size)					\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
-- 
2.36.1

