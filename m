Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22014B241C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349388AbiBKLRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:17:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349352AbiBKLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:17:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B763DE6D;
        Fri, 11 Feb 2022 03:17:02 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:17:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644578221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tz07RCJ9WMDmnOw/LDfyMmPrhf8T/yIsOMvfNM3aBo=;
        b=PqWrQOSwIXpvSgvAKCRr/Ka8H9Yp9PM5QATdn2vtAIY5j/tO9gM6/hkyXQ7A4dco+da9iq
        jjA3ruivjWjeWVZI9ThTQnsORFR+WJSYx4KQ+YfVXIXaSZhjUK2Eep2kcQpXjpNxfPZsT0
        aTbJtEH1JvLIE1r+isLpmO7pvWw7gECKCq7EqCrS8ZaCbbLLkJ0+ajVFFHOtxjuFvnueEy
        Wa3VFoJT4tbL1/TF/L1WkpgnGGhmcwTHYkwzTlrsZWO8dPSuYA6ostZfx7OllZMTmjpCpR
        ZDgudZcUnOm5XJUOMOYzFTE1g49n7ljDB3YMzR10Z53bM3IzeBBixUVEDWSeDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644578221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tz07RCJ9WMDmnOw/LDfyMmPrhf8T/yIsOMvfNM3aBo=;
        b=Q2Zi75U/1OQK+YPIlvHpxrg+XEthF7tiC7pr9iwNkiKU6nsyRn7fPboGCwbB+4vquBAN7D
        EDO4Kxn9WcZbT4Dg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] atomics: Fix atomic64_{read_acquire,set_release}
 fallbacks
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207101943.439825-1-mark.rutland@arm.com>
References: <20220207101943.439825-1-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164457822029.16921.17234654225123637373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     dc1b4df09acdca7a89806b28f235cd6d8dcd3d24
Gitweb:        https://git.kernel.org/tip/dc1b4df09acdca7a89806b28f235cd6d8dcd3d24
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 07 Feb 2022 10:19:43 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Feb 2022 12:13:56 +01:00

atomics: Fix atomic64_{read_acquire,set_release} fallbacks

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20220207101943.439825-1-mark.rutland@arm.com
---
 include/linux/atomic/atomic-arch-fallback.h | 38 +++++++++++++++++---
 scripts/atomic/fallbacks/read_acquire       | 11 +++++-
 scripts/atomic/fallbacks/set_release        |  7 +++-
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index a3dba31..6db58d1 100644
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
index 803ba75..a0ea1d2 100755
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
index 86ede75..05cdb7f 100755
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
