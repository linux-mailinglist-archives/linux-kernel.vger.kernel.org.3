Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1574D56331B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiGAMGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiGAMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:05:58 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A48239A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:05:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VI2LV6l_1656677153;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VI2LV6l_1656677153)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 20:05:53 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     palmer@dabbelt.com
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 3/3] riscv: atomic: Clean up unnecessary acquire and release definitions
Date:   Fri,  1 Jul 2022 20:05:48 +0800
Message-Id: <20220701120548.228261-4-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220701120548.228261-1-xianting.tian@linux.alibaba.com>
References: <20220701120548.228261-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
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
2.17.1

