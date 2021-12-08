Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5830A46DB5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbhLHSob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbhLHSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:44:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83384C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LwFLwha0AUu6FsCUJVd8ShJbPJ4YNDm1Q1jt422PxvU=; b=CprG0VUYKZxrrVfjP9AdwKmNbk
        B64pzD36A+xdXTPZxrqD50Qm0GbZlW2WJWmeoZWF7ACeYIFF07llRjzlhvAXsoOvHpWkldiBnc8Vo
        BcdFNm4S/g4S10HOje4IxvvbuwJrsiuyQsyx8m6+XG0vSK/0lr6DPmozLhdVEzN/VS6HGkHRSHXd+
        T81ztyg/dWv5yPYegwG8bNVxKEIeKGKTd0BMLAy7k/mb1aBEBhfnMkwjxY+ZU/BgHRSBZ/V7sm/1O
        ogvQfSen+fp3UJ2bao7MaPetY4Lz9o1EiPtbc1zBUJHynI8A0zcILfFQ5Qjg+LiO2sC5TxgvB07eM
        ugvKvV1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv1ro-000E8n-VB; Wed, 08 Dec 2021 18:40:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEBD0300237;
        Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A879129B191F3; Wed,  8 Dec 2021 19:40:34 +0100 (CET)
Message-ID: <20211208183906.389506784@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Dec 2021 19:36:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org
Subject: [RFC][PATCH 1/5] atomic: Introduce atomic_{inc,dec,dec_and_test}_ofl()
References: <20211208183655.251963904@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to facilitate architecture support for refcount_t, introduce
a number of new atomic primitives that have a uaccess style exception
for overflow.

Notably:

  atomic_inc_ofl(v, Label) -- increment and goto Label when
			      v is zero or negative.

  atomic_dec_ofl(v, Label) -- decrement and goto Label when
			      the result is zero or negative

  atomic_dec_and_test_ofl(v, Label) -- decrement and return true when
				       the result is zero and goto Label
				       when the result is negative

Since the GCC 'Labels as Values' extention doesn't allow having the
goto in an inline function, these new 'functions' must in fact be
implemented as macro magic.

This meant extending the atomic generation scripts to deal with
wrapping macros instead of inline functions. Since
xchg/cmpxchg/try_cmpxchg were already macro magic, there was existant
code for that. While extending/improving that a few latent
'instrumentation' bugs were uncovered and 'accidentally' fixed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/atomic/atomic-arch-fallback.h |   64 ++++++++++++
 include/linux/atomic/atomic-instrumented.h  |  139 ++++++++++++++++++++--------
 include/linux/atomic/atomic-long.h          |   32 ++++++
 scripts/atomic/atomic-tbl.sh                |    6 +
 scripts/atomic/atomics.tbl                  |    6 +
 scripts/atomic/fallbacks/dec_and_test_ofl   |   12 ++
 scripts/atomic/fallbacks/dec_ofl            |    8 +
 scripts/atomic/fallbacks/inc_ofl            |    8 +
 scripts/atomic/gen-atomic-fallback.sh       |    4 
 scripts/atomic/gen-atomic-instrumented.sh   |  117 +++++++++++++++++++----
 scripts/atomic/gen-atomic-long.sh           |   32 +++++-
 11 files changed, 359 insertions(+), 69 deletions(-)

--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1250,6 +1250,37 @@ arch_atomic_dec_if_positive(atomic_t *v)
 #define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
 #endif
 
+#ifndef arch_atomic_inc_ofl
+#define arch_atomic_inc_ofl(_v, _label)				\
+do {									\
+	int __old = arch_atomic_fetch_inc(_v);			\
+	if (unlikely(__old <= 0))					\
+		goto _label;						\
+} while (0)
+#endif
+
+#ifndef arch_atomic_dec_ofl
+#define arch_atomic_dec_ofl(_v, _label)				\
+do {									\
+	int __new = arch_atomic_dec_return(_v);			\
+	if (unlikely(__new <= 0))					\
+		goto _label;						\
+} while (0)
+#endif
+
+#ifndef arch_atomic_dec_and_test_ofl
+#define arch_atomic_dec_and_test_ofl(_v, _label)			\
+({									\
+	bool __ret = false;						\
+	int __new = arch_atomic_dec_return(_v);			\
+	if (unlikely(__new < 0))					\
+		goto _label;						\
+	if (unlikely(__new == 0))					\
+		__ret = true;						\
+	__ret;								\
+})
+#endif
+
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
@@ -2357,5 +2388,36 @@ arch_atomic64_dec_if_positive(atomic64_t
 #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 #endif
 
+#ifndef arch_atomic64_inc_ofl
+#define arch_atomic64_inc_ofl(_v, _label)				\
+do {									\
+	s64 __old = arch_atomic64_fetch_inc(_v);			\
+	if (unlikely(__old <= 0))					\
+		goto _label;						\
+} while (0)
+#endif
+
+#ifndef arch_atomic64_dec_ofl
+#define arch_atomic64_dec_ofl(_v, _label)				\
+do {									\
+	s64 __new = arch_atomic64_dec_return(_v);			\
+	if (unlikely(__new <= 0))					\
+		goto _label;						\
+} while (0)
+#endif
+
+#ifndef arch_atomic64_dec_and_test_ofl
+#define arch_atomic64_dec_and_test_ofl(_v, _label)			\
+({									\
+	bool __ret = false;						\
+	s64 __new = arch_atomic64_dec_return(_v);			\
+	if (unlikely(__new < 0))					\
+		goto _label;						\
+	if (unlikely(__new == 0))					\
+		__ret = true;						\
+	__ret;								\
+})
+#endif
+
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
+// a59904b14db62a38bbab8699edc4a785a97871fb
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -501,7 +501,7 @@ static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg(v, old, new);
 }
 
@@ -509,7 +509,7 @@ static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -517,7 +517,7 @@ static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_release(v, old, new);
 }
 
@@ -525,7 +525,7 @@ static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -599,6 +599,27 @@ atomic_dec_if_positive(atomic_t *v)
 	return arch_atomic_dec_if_positive(v);
 }
 
+#define atomic_inc_ofl(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_inc_ofl(__ai_v, L); \
+})
+
+#define atomic_dec_ofl(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_dec_ofl(__ai_v, L); \
+})
+
+#define atomic_dec_and_test_ofl(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_dec_and_test_ofl(__ai_v, L); \
+})
+
 static __always_inline s64
 atomic64_read(const atomic64_t *v)
 {
@@ -1079,7 +1100,7 @@ static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg(v, old, new);
 }
 
@@ -1087,7 +1108,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -1095,7 +1116,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_release(v, old, new);
 }
 
@@ -1103,7 +1124,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -1177,6 +1198,27 @@ atomic64_dec_if_positive(atomic64_t *v)
 	return arch_atomic64_dec_if_positive(v);
 }
 
+#define atomic64_inc_ofl(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic64_inc_ofl(__ai_v, L); \
+})
+
+#define atomic64_dec_ofl(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic64_dec_ofl(__ai_v, L); \
+})
+
+#define atomic64_dec_and_test_ofl(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic64_dec_and_test_ofl(__ai_v, L); \
+})
+
 static __always_inline long
 atomic_long_read(const atomic_long_t *v)
 {
@@ -1657,7 +1699,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_long_try_cmpxchg(v, old, new);
 }
 
@@ -1665,7 +1707,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_long_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -1673,7 +1715,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_long_try_cmpxchg_release(v, old, new);
 }
 
@@ -1681,7 +1723,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_long_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -1755,87 +1797,108 @@ atomic_long_dec_if_positive(atomic_long_
 	return arch_atomic_long_dec_if_positive(v);
 }
 
+#define atomic_long_inc_ofl(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_long_inc_ofl(__ai_v, L); \
+})
+
+#define atomic_long_dec_ofl(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_long_dec_ofl(__ai_v, L); \
+})
+
+#define atomic_long_dec_and_test_ofl(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_long_dec_and_test_ofl(__ai_v, L); \
+})
+
 #define xchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -1843,8 +1906,8 @@ atomic_long_dec_if_positive(atomic_long_
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -1852,8 +1915,8 @@ atomic_long_dec_if_positive(atomic_long_
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -1861,8 +1924,8 @@ atomic_long_dec_if_positive(atomic_long_
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -1870,36 +1933,36 @@ atomic_long_dec_if_positive(atomic_long_
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define cmpxchg_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #define sync_cmpxchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_double(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -1907,9 +1970,9 @@ atomic_long_dec_if_positive(atomic_long_
 #define cmpxchg_double_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 2a9553f0a9d5619f19151092df5cabbbf16ce835
+// 214f9a7e972966a9a8e28e1568665cfb75decf91
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -515,6 +515,21 @@ arch_atomic_long_dec_if_positive(atomic_
 	return arch_atomic64_dec_if_positive(v);
 }
 
+#define arch_atomic_long_inc_ofl(v, L) \
+({ \
+	arch_atomic64_inc_ofl((v), L) \
+})
+
+#define arch_atomic_long_dec_ofl(v, L) \
+({ \
+	arch_atomic64_dec_ofl((v), L) \
+})
+
+#define arch_atomic_long_dec_and_test_ofl(v, L) \
+({ \
+	arch_atomic64_dec_and_test_ofl((v), L) \
+})
+
 #else /* CONFIG_64BIT */
 
 static __always_inline long
@@ -1009,6 +1024,21 @@ arch_atomic_long_dec_if_positive(atomic_
 	return arch_atomic_dec_if_positive(v);
 }
 
+#define arch_atomic_long_inc_ofl(v, L) \
+({ \
+	arch_atomic_inc_ofl((v), L) \
+})
+
+#define arch_atomic_long_dec_ofl(v, L) \
+({ \
+	arch_atomic_dec_ofl((v), L) \
+})
+
+#define arch_atomic_long_dec_and_test_ofl(v, L) \
+({ \
+	arch_atomic_dec_and_test_ofl((v), L) \
+})
+
 #endif /* CONFIG_64BIT */
 #endif /* _LINUX_ATOMIC_LONG_H */
-// e8f0e08ff072b74d180eabe2ad001282b38c2c88
+// 120f718985fa4c8f0e884cc4f23db8aa950255fb
--- a/scripts/atomic/atomic-tbl.sh
+++ b/scripts/atomic/atomic-tbl.sh
@@ -36,6 +36,12 @@ meta_has_relaxed()
 	meta_in "$1" "BFIR"
 }
 
+#meta_has_macro(meta)
+meta_has_macro()
+{
+	meta_in "$1" "m"
+}
+
 #find_fallback_template(pfx, name, sfx, order)
 find_fallback_template()
 {
--- a/scripts/atomic/atomics.tbl
+++ b/scripts/atomic/atomics.tbl
@@ -10,12 +10,15 @@
 # * F/f	- fetch: returns base type (has fetch_ variants)
 # * l	- load: returns base type (has _acquire order variant)
 # * s	- store: returns void (has _release order variant)
+# * m	- macro:
 #
 # Where args contains list of type[:name], where type is:
 # * cv	- const pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
 # * v	- pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
 # * i	- base type (int/s64/long)
 # * p	- pointer to base type (int/s64/long)
+# * L	- label for exception case
+# * V:... - vararg
 #
 read			l	cv
 set			s	v	i
@@ -39,3 +42,6 @@ inc_not_zero		b	v
 inc_unless_negative	b	v
 dec_unless_positive	b	v
 dec_if_positive		i	v
+inc_ofl			m	v	L
+dec_ofl			m	v	L
+dec_and_test_ofl	m	v	L
--- /dev/null
+++ b/scripts/atomic/fallbacks/dec_and_test_ofl
@@ -0,0 +1,12 @@
+cat << EOF
+#define arch_${atomic}_dec_and_test_ofl(_v, _label)			\\
+({									\\
+	bool __ret = false;						\\
+	${int} __new = arch_${atomic}_dec_return(_v);			\\
+	if (unlikely(__new < 0))					\\
+		goto _label;						\\
+	if (unlikely(__new == 0))					\\
+		__ret = true;						\\
+	__ret;								\\
+})
+EOF
--- /dev/null
+++ b/scripts/atomic/fallbacks/dec_ofl
@@ -0,0 +1,8 @@
+cat << EOF
+#define arch_${atomic}_dec_ofl(_v, _label)				\\
+do {									\\
+	${int} __new = arch_${atomic}_dec_return(_v);			\\
+	if (unlikely(__new <= 0))					\\
+		goto _label;						\\
+} while (0)
+EOF
--- /dev/null
+++ b/scripts/atomic/fallbacks/inc_ofl
@@ -0,0 +1,8 @@
+cat << EOF
+#define arch_${atomic}_inc_ofl(_v, _label)				\\
+do {									\\
+	${int} __old = arch_${atomic}_fetch_inc(_v);			\\
+	if (unlikely(__old <= 0))					\\
+		goto _label;						\\
+} while (0)
+EOF
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -27,7 +27,9 @@ gen_template_fallback()
 	if [ ! -z "${template}" ]; then
 		printf "#ifndef ${atomicname}\n"
 		. ${template}
-		printf "#define ${atomicname} ${atomicname}\n"
+		if ! meta_has_macro "${meta}"; then
+			printf "#define ${atomicname} ${atomicname}\n"
+		fi
 		printf "#endif\n\n"
 	fi
 }
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -13,9 +13,13 @@ gen_param_check()
 	local type="${arg%%:*}"
 	local name="$(gen_param_name "${arg}")"
 	local rw="write"
+	local pfx;
 
 	case "${type#c}" in
+	v) pfx="atomic_";;
 	i) return;;
+	L) return;;
+	V) return;;
 	esac
 
 	if [ ${type#c} != ${type} ]; then
@@ -27,7 +31,16 @@ gen_param_check()
 		rw="read_write"
 	fi
 
-	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
+	if meta_has_macro "${meta}"; then
+		name="__ai_${name}"
+	fi
+
+	printf "\tinstrument_${pfx}${rw}(${name}, sizeof(*${name}));"
+	if meta_has_macro "${meta}"; then
+		printf " \\"
+	fi
+	printf "\n"
+
 }
 
 #gen_params_checks(meta, arg...)
@@ -41,6 +54,52 @@ gen_params_checks()
 	done
 }
 
+#gen_var(arg)
+gen_var()
+{
+	local type="${1%%:*}"
+	local name="$(gen_param_name "$1")"
+
+	case "${type#c}" in
+	L) return;;
+	V) return;;
+	esac
+
+	printf "\ttypeof(${name}) __ai_${name} = (${name}); \\\\\n";
+}
+
+#gen_vars(arg...)
+gen_vars()
+{
+	while [ "$#" -gt 0 ]; do
+		gen_var "$1"
+		shift
+	done
+}
+
+#gen_varg(arg)
+gen_varg()
+{
+	local type="${1%%:*}"
+	local name="$(gen_param_name "$1")"
+
+	case "${type#c}" in
+	L)	printf "${name}";;
+	V)	printf "__VA_ARGS__";;
+	*)	printf "__ai_${name}";;
+	esac
+}
+
+#gen_vargs(arg...)
+gen_vargs()
+{
+	while [ "$#" -gt 0 ]; do
+		printf "$(gen_varg "$1")"
+		[ "$#" -gt 1 ] && printf ", "
+		shift
+	done
+}
+
 #gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
 gen_proto_order_variant()
 {
@@ -54,11 +113,28 @@ gen_proto_order_variant()
 
 	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
 
-	local ret="$(gen_ret_type "${meta}" "${int}")"
-	local params="$(gen_params "${int}" "${atomic}" "$@")"
 	local checks="$(gen_params_checks "${meta}" "$@")"
 	local args="$(gen_args "$@")"
-	local retstmt="$(gen_ret_stmt "${meta}")"
+
+	if meta_has_macro "${meta}"; then
+
+		local vars="$(gen_vars "$@")"
+		local vargs="$(gen_vargs "$@")"
+
+cat <<EOF
+#define ${atomicname}(${args}) \\
+({ \\
+${vars}
+${checks}
+	arch_${atomicname}(${vargs}); \\
+})
+EOF
+
+	else
+
+		local ret="$(gen_ret_type "${meta}" "${int}")"
+		local params="$(gen_params "${int}" "${atomic}" "$@")"
+		local retstmt="$(gen_ret_stmt "${meta}")"
 
 cat <<EOF
 static __always_inline ${ret}
@@ -69,6 +145,8 @@ ${checks}
 }
 EOF
 
+	fi
+
 	printf "\n"
 }
 
@@ -76,32 +154,27 @@ gen_xchg()
 {
 	local xchg="$1"; shift
 	local mult="$1"; shift
+	local ARGS;
 
 	if [ "${xchg%${xchg#try_cmpxchg}}" = "try_cmpxchg" ] ; then
-
-cat <<EOF
-#define ${xchg}(ptr, oldp, ...) \\
-({ \\
-	typeof(ptr) __ai_ptr = (ptr); \\
-	typeof(oldp) __ai_oldp = (oldp); \\
-	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
-	instrument_atomic_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
-	arch_${xchg}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
-})
-EOF
-
+		ARGS="v:ptr p:oldp V:..."
 	else
+		ARGS="v:ptr V:..."
+	fi
+
+	local args="$(gen_args ${ARGS})"
+	local vars="$(gen_vars ${ARGS})"
+	local checks="$(gen_params_checks "m" ${ARGS})"
+	local vargs="$(gen_vargs ${ARGS})"
 
 cat <<EOF
-#define ${xchg}(ptr, ...) \\
+#define ${xchg}(${args}) \\
 ({ \\
-	typeof(ptr) __ai_ptr = (ptr); \\
-	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
-	arch_${xchg}(__ai_ptr, __VA_ARGS__); \\
+${vars}
+${checks}
+	arch_${xchg}(${vargs}); \\
 })
 EOF
-
-	fi
 }
 
 cat << EOF
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -17,16 +17,21 @@ gen_cast()
 	printf "($(gen_param_type "${arg}" "${int}" "${atomic}"))"
 }
 
-#gen_args_cast(int, atomic, arg...)
+#gen_args_cast(meta, int, atomic, arg...)
 gen_args_cast()
 {
+	local meta=$1; shift
 	local int="$1"; shift
 	local atomic="$1"; shift
 
 	while [ "$#" -gt 0 ]; do
 		local cast="$(gen_cast "$1" "${int}" "${atomic}")"
 		local arg="$(gen_param_name "$1")"
-		printf "${cast}${arg}"
+		if meta_has_macro "${meta}" && [ "${1%%:*}" != "L" ]; then
+			printf "${cast}(${arg})"
+		else
+			printf "${cast}${arg}"
+		fi
 		[ "$#" -gt 1 ] && printf ", "
 		shift;
 	done
@@ -40,10 +45,24 @@ gen_proto_order_variant()
 	local atomic="$1"; shift
 	local int="$1"; shift
 
-	local ret="$(gen_ret_type "${meta}" "long")"
-	local params="$(gen_params "long" "atomic_long" "$@")"
-	local argscast="$(gen_args_cast "${int}" "${atomic}" "$@")"
-	local retstmt="$(gen_ret_stmt "${meta}")"
+	local argscast="$(gen_args_cast "${meta}" "${int}" "${atomic}" "$@")"
+
+	if meta_has_macro "${meta}"; then
+
+		local args="$(gen_args "$@")"
+
+cat <<EOF
+#define arch_atomic_long_${name}(${args}) \\
+({ \\
+	arch_${atomic}_${name}(${argscast}) \\
+})
+
+EOF
+	else
+
+		local ret="$(gen_ret_type "${meta}" "long")"
+		local params="$(gen_params "long" "atomic_long" "$@")"
+		local retstmt="$(gen_ret_stmt "${meta}")"
 
 cat <<EOF
 static __always_inline ${ret}
@@ -53,6 +72,7 @@ arch_atomic_long_${name}(${params})
 }
 
 EOF
+	fi
 }
 
 cat << EOF


