Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A58474DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbhLNWFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbhLNWEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6078FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:04:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B522CE1AF8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1D9C34608;
        Tue, 14 Dec 2021 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519481;
        bh=rTwBkGOnB/F4TjHE0felVV1ekZn1XbFX+pdtvTmZBV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N82ruOjDR03OiMExnpFMM3DmX2Q6LYAZ1UfXn6vi/YLN3B2AP6BPSgEYSZYEchDDh
         adIxEOJrbbGOrbAcxVcoyvZerDDypsCoQTJLo8Tls2f5QQnMu+yMsMAe4oiUE/WD9f
         LcYJVAdI8jH0Ne2jR6kZWMm1s1tvTyIf4jul+zl4Hxso0jp6P4PAqkj9DruHNvMn8b
         DqgQdu3T8EmHmohITcyEgZKVzu73XzHJNE0HFPE6GaHtsubjCgvolnpYz2J0cJL94X
         /gWmPZbHyiWChwq+yJpw6FDgam/reUDgsbUaN+M/lDQz5W5eiyBoIezPQMz5hCC3hN
         2mWw49jzr/9Tw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 62AB95C0DF2; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 05/29] kcsan: Add core memory barrier instrumentation functions
Date:   Tue, 14 Dec 2021 14:04:15 -0800
Message-Id: <20211214220439.2236564-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Add the core memory barrier instrumentation functions. These invalidate
the current in-flight reordered access based on the rules for the
respective barrier types and in-flight access type.

To obtain barrier instrumentation that can be disabled via __no_kcsan
with appropriate compiler-support (and not just with objtool help),
barrier instrumentation repurposes __atomic_signal_fence(), instead of
inserting explicit calls. Crucially, __atomic_signal_fence() normally
does not map to any real instructions, but is still intercepted by
fsanitize=thread. As a result, like any other instrumentation done by
the compiler, barrier instrumentation can be disabled with __no_kcsan.

Unfortunately Clang and GCC currently differ in their __no_kcsan aka
__no_sanitize_thread behaviour with respect to builtin atomics (and
__tsan_func_{entry,exit}) instrumentation. This is already reflected in
Kconfig.kcsan's dependencies for KCSAN_WEAK_MEMORY. A later change will
introduce support for newer versions of Clang that can implement
__no_kcsan to also remove the additional instrumentation introduced by
KCSAN_WEAK_MEMORY.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h | 71 +++++++++++++++++++++++++++++++++++-
 kernel/kcsan/core.c          | 68 +++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index a1c6a89fde710..9d2c869167f2e 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -36,6 +36,36 @@
  */
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
 
+/*
+ * See definition of __tsan_atomic_signal_fence() in kernel/kcsan/core.c.
+ * Note: The mappings are arbitrary, and do not reflect any real mappings of C11
+ * memory orders to the LKMM memory orders and vice-versa!
+ */
+#define __KCSAN_BARRIER_TO_SIGNAL_FENCE_mb	__ATOMIC_SEQ_CST
+#define __KCSAN_BARRIER_TO_SIGNAL_FENCE_wmb	__ATOMIC_ACQ_REL
+#define __KCSAN_BARRIER_TO_SIGNAL_FENCE_rmb	__ATOMIC_ACQUIRE
+#define __KCSAN_BARRIER_TO_SIGNAL_FENCE_release	__ATOMIC_RELEASE
+
+/**
+ * __kcsan_mb - full memory barrier instrumentation
+ */
+void __kcsan_mb(void);
+
+/**
+ * __kcsan_wmb - write memory barrier instrumentation
+ */
+void __kcsan_wmb(void);
+
+/**
+ * __kcsan_rmb - read memory barrier instrumentation
+ */
+void __kcsan_rmb(void);
+
+/**
+ * __kcsan_release - release barrier instrumentation
+ */
+void __kcsan_release(void);
+
 /**
  * kcsan_disable_current - disable KCSAN for the current context
  *
@@ -159,6 +189,10 @@ void kcsan_end_scoped_access(struct kcsan_scoped_access *sa);
 static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
 					int type) { }
 
+static inline void __kcsan_mb(void)			{ }
+static inline void __kcsan_wmb(void)			{ }
+static inline void __kcsan_rmb(void)			{ }
+static inline void __kcsan_release(void)		{ }
 static inline void kcsan_disable_current(void)		{ }
 static inline void kcsan_enable_current(void)		{ }
 static inline void kcsan_enable_current_nowarn(void)	{ }
@@ -191,12 +225,45 @@ static inline void kcsan_end_scoped_access(struct kcsan_scoped_access *sa) { }
  */
 #define __kcsan_disable_current kcsan_disable_current
 #define __kcsan_enable_current kcsan_enable_current_nowarn
-#else
+#else /* __SANITIZE_THREAD__ */
 static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 				      int type) { }
 static inline void __kcsan_enable_current(void)  { }
 static inline void __kcsan_disable_current(void) { }
-#endif
+#endif /* __SANITIZE_THREAD__ */
+
+#if defined(CONFIG_KCSAN_WEAK_MEMORY) && defined(__SANITIZE_THREAD__)
+/*
+ * Normal barrier instrumentation is not done via explicit calls, but by mapping
+ * to a repurposed __atomic_signal_fence(), which normally does not generate any
+ * real instructions, but is still intercepted by fsanitize=thread. This means,
+ * like any other compile-time instrumentation, barrier instrumentation can be
+ * disabled with the __no_kcsan function attribute.
+ *
+ * Also see definition of __tsan_atomic_signal_fence() in kernel/kcsan/core.c.
+ */
+#define __KCSAN_BARRIER_TO_SIGNAL_FENCE(name)					\
+	static __always_inline void kcsan_##name(void)				\
+	{									\
+		barrier();							\
+		__atomic_signal_fence(__KCSAN_BARRIER_TO_SIGNAL_FENCE_##name);	\
+		barrier();							\
+	}
+__KCSAN_BARRIER_TO_SIGNAL_FENCE(mb)
+__KCSAN_BARRIER_TO_SIGNAL_FENCE(wmb)
+__KCSAN_BARRIER_TO_SIGNAL_FENCE(rmb)
+__KCSAN_BARRIER_TO_SIGNAL_FENCE(release)
+#elif defined(CONFIG_KCSAN_WEAK_MEMORY) && defined(__KCSAN_INSTRUMENT_BARRIERS__)
+#define kcsan_mb	__kcsan_mb
+#define kcsan_wmb	__kcsan_wmb
+#define kcsan_rmb	__kcsan_rmb
+#define kcsan_release	__kcsan_release
+#else /* CONFIG_KCSAN_WEAK_MEMORY && ... */
+static inline void kcsan_mb(void)		{ }
+static inline void kcsan_wmb(void)		{ }
+static inline void kcsan_rmb(void)		{ }
+static inline void kcsan_release(void)		{ }
+#endif /* CONFIG_KCSAN_WEAK_MEMORY && ... */
 
 /**
  * __kcsan_check_read - check regular read access for races
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 481f8a5240898..9160609139666 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -939,6 +939,22 @@ void __kcsan_check_access(const volatile void *ptr, size_t size, int type)
 }
 EXPORT_SYMBOL(__kcsan_check_access);
 
+#define DEFINE_MEMORY_BARRIER(name, order_before_cond)				\
+	void __kcsan_##name(void)						\
+	{									\
+		struct kcsan_scoped_access *sa = get_reorder_access(get_ctx());	\
+		if (!sa)							\
+			return;							\
+		if (order_before_cond)						\
+			sa->size = 0;						\
+	}									\
+	EXPORT_SYMBOL(__kcsan_##name)
+
+DEFINE_MEMORY_BARRIER(mb, true);
+DEFINE_MEMORY_BARRIER(wmb, sa->type & (KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND));
+DEFINE_MEMORY_BARRIER(rmb, !(sa->type & KCSAN_ACCESS_WRITE) || (sa->type & KCSAN_ACCESS_COMPOUND));
+DEFINE_MEMORY_BARRIER(release, true);
+
 /*
  * KCSAN uses the same instrumentation that is emitted by supported compilers
  * for ThreadSanitizer (TSAN).
@@ -1123,10 +1139,19 @@ EXPORT_SYMBOL(__tsan_init);
  * functions, whose job is to also execute the operation itself.
  */
 
+static __always_inline void kcsan_atomic_builtin_memorder(int memorder)
+{
+	if (memorder == __ATOMIC_RELEASE ||
+	    memorder == __ATOMIC_SEQ_CST ||
+	    memorder == __ATOMIC_ACQ_REL)
+		__kcsan_release();
+}
+
 #define DEFINE_TSAN_ATOMIC_LOAD_STORE(bits)                                                        \
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
 	{                                                                                          \
+		kcsan_atomic_builtin_memorder(memorder);                                           \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC, _RET_IP_);    \
 		}                                                                                  \
@@ -1136,6 +1161,7 @@ EXPORT_SYMBOL(__tsan_init);
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
 	{                                                                                          \
+		kcsan_atomic_builtin_memorder(memorder);                                           \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC, _RET_IP_);          \
@@ -1148,6 +1174,7 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
 	{                                                                                          \
+		kcsan_atomic_builtin_memorder(memorder);                                           \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
@@ -1180,6 +1207,7 @@ EXPORT_SYMBOL(__tsan_init);
 	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
 							      u##bits val, int mo, int fail_mo)    \
 	{                                                                                          \
+		kcsan_atomic_builtin_memorder(mo);                                                 \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
@@ -1195,6 +1223,7 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
 							   int mo, int fail_mo)                    \
 	{                                                                                          \
+		kcsan_atomic_builtin_memorder(mo);                                                 \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
@@ -1226,10 +1255,47 @@ DEFINE_TSAN_ATOMIC_OPS(64);
 void __tsan_atomic_thread_fence(int memorder);
 void __tsan_atomic_thread_fence(int memorder)
 {
+	kcsan_atomic_builtin_memorder(memorder);
 	__atomic_thread_fence(memorder);
 }
 EXPORT_SYMBOL(__tsan_atomic_thread_fence);
 
+/*
+ * In instrumented files, we emit instrumentation for barriers by mapping the
+ * kernel barriers to an __atomic_signal_fence(), which is interpreted specially
+ * and otherwise has no relation to a real __atomic_signal_fence(). No known
+ * kernel code uses __atomic_signal_fence().
+ *
+ * Since fsanitize=thread instrumentation handles __atomic_signal_fence(), which
+ * are turned into calls to __tsan_atomic_signal_fence(), such instrumentation
+ * can be disabled via the __no_kcsan function attribute (vs. an explicit call
+ * which could not). When __no_kcsan is requested, __atomic_signal_fence()
+ * generates no code.
+ *
+ * Note: The result of using __atomic_signal_fence() with KCSAN enabled is
+ * potentially limiting the compiler's ability to reorder operations; however,
+ * if barriers were instrumented with explicit calls (without LTO), the compiler
+ * couldn't optimize much anyway. The result of a hypothetical architecture
+ * using __atomic_signal_fence() in normal code would be KCSAN false negatives.
+ */
 void __tsan_atomic_signal_fence(int memorder);
-void __tsan_atomic_signal_fence(int memorder) { }
+noinline void __tsan_atomic_signal_fence(int memorder)
+{
+	switch (memorder) {
+	case __KCSAN_BARRIER_TO_SIGNAL_FENCE_mb:
+		__kcsan_mb();
+		break;
+	case __KCSAN_BARRIER_TO_SIGNAL_FENCE_wmb:
+		__kcsan_wmb();
+		break;
+	case __KCSAN_BARRIER_TO_SIGNAL_FENCE_rmb:
+		__kcsan_rmb();
+		break;
+	case __KCSAN_BARRIER_TO_SIGNAL_FENCE_release:
+		__kcsan_release();
+		break;
+	default:
+		break;
+	}
+}
 EXPORT_SYMBOL(__tsan_atomic_signal_fence);
-- 
2.31.1.189.g2e36527f23

