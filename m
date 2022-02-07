Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BF74AB8ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbiBGKiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiBGK2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:28:34 -0500
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 02:28:33 PST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86B9BC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:28:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DADF16D;
        Mon,  7 Feb 2022 02:19:55 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89CB43F718;
        Mon,  7 Feb 2022 02:19:54 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, arnd@arndb.de, boqun.feng@gmail.com,
        mark.rutland@arm.com, peterz@infradead.org, will@kernel.org
Subject: [PATCH v3] atomics: fix atomic64_{read_acquire,set_release} fallbacks
Date:   Mon,  7 Feb 2022 10:19:43 +0000
Message-Id: <20220207101943.439825-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd reports that on 32-bit architectures, the fallbacks for
atomic64_read_acquire() and atomic64_set_release() are broken as they
use smp_load_acquire() and smp_store_release() respectively, which do
not work on types larger than the native word size.

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

Since the fallback templates are used to generate the atomic64_*() and
atomic_*() operations, the __native_word() check is added to both. For
the atomic_*() operations, which are always 32-bit, the __native_word()
check is redundant but not harmful, as it is always true.

For the example above this works as expected on 32-bit, e.g. for arm
multi_v7_defconfig:

| <test_atomic64>:
|         push    {r4, r5}
|         dmb     ish
|         pldw    [r0]
|         mov     r2, #5
|         mov     r3, #0
|         ldrexd  r4, [r0]
|         strexd  r4, r2, [r0]
|         teq     r4, #0
|         bne     484 <test_atomic64+0x14>
|         ldrexd  r2, [r0]
|         dmb     ish
|         pop     {r4, r5}
|         bx      lr

... and also on 64-bit, e.g. for arm64 defconfig:

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
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/atomic/atomic-arch-fallback.h | 38 ++++++++++++++++++---
 scripts/atomic/fallbacks/read_acquire       | 11 +++++-
 scripts/atomic/fallbacks/set_release        |  7 +++-
 3 files changed, 49 insertions(+), 7 deletions(-)

Since v1 [1]:
* Fix templates to use arch_${atomic}_{read,write}()
* Update 32-bit sample codegen
* Correct typo in commit message

Since v2 [2]:
* Explain why redundant checks are safe for atomic_t operations
* Add Ard's Reviewed-by tag

[1] https://lore.kernel.org/lkml/20220203143848.3934515-1-mark.rutland@arm.com
[2] https://lore.kernel.org/lkml/20220203161243.3955547-1-mark.rutland@arm.com

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index a3dba31df01e..6db58d180866 100644
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
+		ret = arch_atomic64_read(v);
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
+		arch_atomic64_set(v, i);
+	}
 }
 #define arch_atomic64_set_release arch_atomic64_set_release
 #endif
@@ -2358,4 +2386,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
+// 8e2cc06bc0d2c0967d2f8424762bd48555ee40ae
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
index 803ba7561076..a0ea1d26e6b2 100755
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
+		ret = arch_${atomic}_read(v);
+		__atomic_acquire_fence();
+	}
+
+	return ret;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
index 86ede759f24e..05cdb7f42477 100755
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
+		arch_${atomic}_set(v, i);
+	}
 }
 EOF
-- 
2.30.2

