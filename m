Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3724A86B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiBCOi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:38:58 -0500
Received: from foss.arm.com ([217.140.110.172]:50262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234953AbiBCOi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:38:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D41D31063;
        Thu,  3 Feb 2022 06:38:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EDA273F774;
        Thu,  3 Feb 2022 06:38:55 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, boqun.feng@gmail.com, mark.rutland@arm.com,
        peterz@infradead.org, will@kernel.org
Subject: [PATCH] atomics: fix atomic64_{read_acquire,set_release} fallbacks
Date:   Thu,  3 Feb 2022 14:38:48 +0000
Message-Id: <20220203143848.3934515-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd reports that on 32-bit architectures, the fallbacks for
atomic64_read_acquire and atomic64_set_release() are broken as they use
smp_load_acquire() and smp_store_release() respectively, which do not
work on types larger than the native word size.

Since those contain compiletime_assert_atomic_type(), any attempt to use
those fallbacks will result in a build-time error. e.g. with the
following added to arch/arm/kernel/setup.c:

| void test_atomic64(atomic64_t *v)
| {
|        atomic64_set_release(v, 5);
|        atomic64_read_acquire(v);
| }

The compiler will complain as follows:

| In file included from <command-line>:
| In function 'arch_atomic64_set_release',
|     inlined from 'test_atomic64' at ./include/linux/atomic/atomic-instrumented.h:669:2:
| ././include/linux/compiler_types.h:346:38: error: call to '__compiletime_assert_9' declared with attribute error: Need native word sized stores/loads for atomicity.
|   346 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
|       |                                      ^
| ././include/linux/compiler_types.h:327:4: note: in definition of macro '__compiletime_assert'
|   327 |    prefix ## suffix();    \
|       |    ^~~~~~
| ././include/linux/compiler_types.h:346:2: note: in expansion of macro '_compiletime_assert'
|   346 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
|       |  ^~~~~~~~~~~~~~~~~~~
| ././include/linux/compiler_types.h:349:2: note: in expansion of macro 'compiletime_assert'
|   349 |  compiletime_assert(__native_word(t),    \
|       |  ^~~~~~~~~~~~~~~~~~
| ./include/asm-generic/barrier.h:133:2: note: in expansion of macro 'compiletime_assert_atomic_type'
|   133 |  compiletime_assert_atomic_type(*p);    \
|       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| ./include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
|   164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
|       |                                                       ^~~~~~~~~~~~~~~~~~~
| ./include/linux/atomic/atomic-arch-fallback.h:1270:2: note: in expansion of macro 'smp_store_release'
|  1270 |  smp_store_release(&(v)->counter, i);
|       |  ^~~~~~~~~~~~~~~~~
| make[2]: *** [scripts/Makefile.build:288: arch/arm/kernel/setup.o] Error 1
| make[1]: *** [scripts/Makefile.build:550: arch/arm/kernel] Error 2
| make: *** [Makefile:1831: arch/arm] Error 2

Fix this by only using smp_load_acquire() and smp_store_release() for
native atomic types, and otherwise falling back to the regular barriers
necessary for acquire/release semantics, as we do in the more generic
acquire and release fallbacks.

For the example above this works as expected on 32-bit, e.g.

| <test_atomic64>:
|         dmb     ish
|         mov     r2, #5
|         mov     r3, #0
|         strd    r2, [r0]
|         ldrd    r2, [r0]
|         dmb     ish
|         bx      lr

... and also on 64-bit, e.g.

| <test_atomic64>:
|         bti     c
|         paciasp
|         mov     x1, #0x5
|         stlr    x1, [x0]
|         ldar    x0, [x0]
|         autiasp
|         ret

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/atomic/atomic-arch-fallback.h | 38 ++++++++++++++++++---
 scripts/atomic/fallbacks/read_acquire       | 11 +++++-
 scripts/atomic/fallbacks/set_release        |  7 +++-
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index a3dba31df01e..8dfb03317f2a 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -151,7 +151,16 @@
 static __always_inline int
 arch_atomic_read_acquire(const atomic_t *v)
 {
-	return smp_load_acquire(&(v)->counter);
+	int ret;
+
+	if (__native_word(atomic_t)) {
+		ret = smp_load_acquire(&(v)->counter);
+	} else {
+		ret = arch_atomic_read(v);
+		__atomic_acquire_fence();
+	}
+
+	return ret;
 }
 #define arch_atomic_read_acquire arch_atomic_read_acquire
 #endif
@@ -160,7 +169,12 @@ arch_atomic_read_acquire(const atomic_t *v)
 static __always_inline void
 arch_atomic_set_release(atomic_t *v, int i)
 {
-	smp_store_release(&(v)->counter, i);
+	if (__native_word(atomic_t)) {
+		smp_store_release(&(v)->counter, i);
+	} else {
+		__atomic_release_fence();
+		arch_atomic_set(v, i);
+	}
 }
 #define arch_atomic_set_release arch_atomic_set_release
 #endif
@@ -1258,7 +1272,16 @@ arch_atomic_dec_if_positive(atomic_t *v)
 static __always_inline s64
 arch_atomic64_read_acquire(const atomic64_t *v)
 {
-	return smp_load_acquire(&(v)->counter);
+	s64 ret;
+
+	if (__native_word(atomic64_t)) {
+		ret = smp_load_acquire(&(v)->counter);
+	} else {
+		ret = arch_atomic_read(v);
+		__atomic_acquire_fence();
+	}
+
+	return ret;
 }
 #define arch_atomic64_read_acquire arch_atomic64_read_acquire
 #endif
@@ -1267,7 +1290,12 @@ arch_atomic64_read_acquire(const atomic64_t *v)
 static __always_inline void
 arch_atomic64_set_release(atomic64_t *v, s64 i)
 {
-	smp_store_release(&(v)->counter, i);
+	if (__native_word(atomic64_t)) {
+		smp_store_release(&(v)->counter, i);
+	} else {
+		__atomic_release_fence();
+		arch_atomic_set(v, i);
+	}
 }
 #define arch_atomic64_set_release arch_atomic64_set_release
 #endif
@@ -2358,4 +2386,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
+// ba488b6398359cb776d457971f30cef78d0d36dc
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
index 803ba7561076..7b8b87143c0c 100755
--- a/scripts/atomic/fallbacks/read_acquire
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -2,6 +2,15 @@ cat <<EOF
 static __always_inline ${ret}
 arch_${atomic}_read_acquire(const ${atomic}_t *v)
 {
-	return smp_load_acquire(&(v)->counter);
+	${int} ret;
+
+	if (__native_word(${atomic}_t)) {
+		ret = smp_load_acquire(&(v)->counter);
+	} else {
+		ret = arch_atomic_read(v);
+		__atomic_acquire_fence();
+	}
+
+	return ret;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
index 86ede759f24e..5f692db3ce29 100755
--- a/scripts/atomic/fallbacks/set_release
+++ b/scripts/atomic/fallbacks/set_release
@@ -2,6 +2,11 @@ cat <<EOF
 static __always_inline void
 arch_${atomic}_set_release(${atomic}_t *v, ${int} i)
 {
-	smp_store_release(&(v)->counter, i);
+	if (__native_word(${atomic}_t)) {
+		smp_store_release(&(v)->counter, i);
+	} else {
+		__atomic_release_fence();
+		arch_atomic_set(v, i);
+	}
 }
 EOF
-- 
2.30.2

