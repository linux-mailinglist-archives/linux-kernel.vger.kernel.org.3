Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660D847059E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbhLJQbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhLJQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:30:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D81C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4vrzBsTcMVV4CfSv9J/g6k56Zqn95We7lNeoUHfJ884=; b=mSZuvbot2ghTvynRVx+JE2X5NH
        pO5zqNYSnRiWlxZXGKYfqHUcTpUglrNcYA6pEac0ZrZkDwr/Z/LXGKvSpaxjFwI0CcdjmFzW0RKVT
        Nfr/UW3YzM5S9FUra1SZ3f01kBj2K6u9fwGrDEkAdXRFZmZxGd+2zGqhK4eM2f9T6rt+qRpHs9ljW
        CGMYba4ERgsp2VWFonbK+Tl+GyLZ6TvT60iEXMn8UGUBPg+eptNJxPxgOsGUIWk+NNxOQW6hVFsYF
        IqknTxIL32uVDm5GpT9Ksfuqjj/m3oVwjJlCivl17ks5vvQ+yc/jWsLUHdVRciuE2jHPI8hmz2QNL
        ncs7Wsbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvijl-00ATwp-92; Fri, 10 Dec 2021 16:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 881803005B2;
        Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 648202B3C36C6; Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Message-ID: <20211210162313.464256797@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Dec 2021 17:16:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 3/9] atomic: Introduce atomic_{inc,dec,dec_and_test}_overflow()
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to facilitate architecture support for refcount_t, introduce
a number of new atomic primitives that have a uaccess style exception
for overflow.

Notably:

  atomic_inc_overflow(v, Label):

	increment and goto Label when the old value of v is zero or
	negative.

  atomic_dec_overflow(v, Label):

	decrement and goto Label when the new value of v is zero or
	negative

  atomic_dec_and_test_overflow(v, Label):

	decrement and return true when the result is zero and goto
	Label when the new value of v is negative

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/atomic/atomic-arch-fallback.h    |   64 ++++++++++++++++++++++++
 include/linux/atomic/atomic-instrumented.h     |   65 ++++++++++++++++++++++++-
 include/linux/atomic/atomic-long.h             |   32 +++++++++++-
 scripts/atomic/atomics.tbl                     |    3 +
 scripts/atomic/fallbacks/dec_and_test_overflow |   12 ++++
 scripts/atomic/fallbacks/dec_overflow          |    8 +++
 scripts/atomic/fallbacks/inc_overflow          |    8 +++
 7 files changed, 189 insertions(+), 3 deletions(-)

--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1250,6 +1250,37 @@ arch_atomic_dec_if_positive(atomic_t *v)
 #define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
 #endif
 
+#ifndef arch_atomic_inc_overflow
+#define arch_atomic_inc_overflow(_v, _label)				\
+do {									\
+	int __old = arch_atomic_fetch_inc(_v);			\
+	if (unlikely(__old <= 0))					\
+		goto _label;						\
+} while (0)
+#endif
+
+#ifndef arch_atomic_dec_overflow
+#define arch_atomic_dec_overflow(_v, _label)				\
+do {									\
+	int __new = arch_atomic_dec_return(_v);			\
+	if (unlikely(__new <= 0))					\
+		goto _label;						\
+} while (0)
+#endif
+
+#ifndef arch_atomic_dec_and_test_overflow
+#define arch_atomic_dec_and_test_overflow(_v, _label)		\
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
 
+#ifndef arch_atomic64_inc_overflow
+#define arch_atomic64_inc_overflow(_v, _label)				\
+do {									\
+	s64 __old = arch_atomic64_fetch_inc(_v);			\
+	if (unlikely(__old <= 0))					\
+		goto _label;						\
+} while (0)
+#endif
+
+#ifndef arch_atomic64_dec_overflow
+#define arch_atomic64_dec_overflow(_v, _label)				\
+do {									\
+	s64 __new = arch_atomic64_dec_return(_v);			\
+	if (unlikely(__new <= 0))					\
+		goto _label;						\
+} while (0)
+#endif
+
+#ifndef arch_atomic64_dec_and_test_overflow
+#define arch_atomic64_dec_and_test_overflow(_v, _label)		\
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
+// e4c677b23b3fd5e8dc4bce9d6c055103666cfc4a
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -599,6 +599,27 @@ atomic_dec_if_positive(atomic_t *v)
 	return arch_atomic_dec_if_positive(v);
 }
 
+#define atomic_inc_overflow(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_inc_overflow(__ai_v, L); \
+})
+
+#define atomic_dec_overflow(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_dec_overflow(__ai_v, L); \
+})
+
+#define atomic_dec_and_test_overflow(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_dec_and_test_overflow(__ai_v, L); \
+})
+
 static __always_inline s64
 atomic64_read(const atomic64_t *v)
 {
@@ -1177,6 +1198,27 @@ atomic64_dec_if_positive(atomic64_t *v)
 	return arch_atomic64_dec_if_positive(v);
 }
 
+#define atomic64_inc_overflow(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic64_inc_overflow(__ai_v, L); \
+})
+
+#define atomic64_dec_overflow(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic64_dec_overflow(__ai_v, L); \
+})
+
+#define atomic64_dec_and_test_overflow(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic64_dec_and_test_overflow(__ai_v, L); \
+})
+
 static __always_inline long
 atomic_long_read(const atomic_long_t *v)
 {
@@ -1755,6 +1797,27 @@ atomic_long_dec_if_positive(atomic_long_
 	return arch_atomic_long_dec_if_positive(v);
 }
 
+#define atomic_long_inc_overflow(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_long_inc_overflow(__ai_v, L); \
+})
+
+#define atomic_long_dec_overflow(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_long_dec_overflow(__ai_v, L); \
+})
+
+#define atomic_long_dec_and_test_overflow(v, L) \
+({ \
+	typeof(v) __ai_v = (v); \
+	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
+	arch_atomic_long_dec_and_test_overflow(__ai_v, L); \
+})
+
 #define xchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1912,4 +1975,4 @@ atomic_long_dec_if_positive(atomic_long_
 
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 66cdf9a0e0a995cba29c61baf018f7ef35974ae5
+// 702806891ef1d01d76767c55088264ab6a1ef77d
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -515,6 +515,21 @@ arch_atomic_long_dec_if_positive(atomic_
 	return arch_atomic64_dec_if_positive(v);
 }
 
+#define arch_atomic_long_inc_overflow(v, L) \
+({ \
+	arch_atomic64_inc_overflow((v), L) \
+})
+
+#define arch_atomic_long_dec_overflow(v, L) \
+({ \
+	arch_atomic64_dec_overflow((v), L) \
+})
+
+#define arch_atomic_long_dec_and_test_overflow(v, L) \
+({ \
+	arch_atomic64_dec_and_test_overflow((v), L) \
+})
+
 #else /* CONFIG_64BIT */
 
 static __always_inline long
@@ -1009,6 +1024,21 @@ arch_atomic_long_dec_if_positive(atomic_
 	return arch_atomic_dec_if_positive(v);
 }
 
+#define arch_atomic_long_inc_overflow(v, L) \
+({ \
+	arch_atomic_inc_overflow((v), L) \
+})
+
+#define arch_atomic_long_dec_overflow(v, L) \
+({ \
+	arch_atomic_dec_overflow((v), L) \
+})
+
+#define arch_atomic_long_dec_and_test_overflow(v, L) \
+({ \
+	arch_atomic_dec_and_test_overflow((v), L) \
+})
+
 #endif /* CONFIG_64BIT */
 #endif /* _LINUX_ATOMIC_LONG_H */
-// e8f0e08ff072b74d180eabe2ad001282b38c2c88
+// 487bc4fea91f23f2a4b42af7d5b49ef9172ae792
--- a/scripts/atomic/atomics.tbl
+++ b/scripts/atomic/atomics.tbl
@@ -44,3 +44,6 @@ inc_not_zero		b	v
 inc_unless_negative	b	v
 dec_unless_positive	b	v
 dec_if_positive		i	v
+inc_overflow			n	v	L
+dec_overflow			n	v	L
+dec_and_test_overflow	m	v	L
--- /dev/null
+++ b/scripts/atomic/fallbacks/dec_and_test_overflow
@@ -0,0 +1,12 @@
+cat << EOF
+#define arch_${atomic}_dec_and_test_overflow(_v, _label)		\\
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
+++ b/scripts/atomic/fallbacks/dec_overflow
@@ -0,0 +1,8 @@
+cat << EOF
+#define arch_${atomic}_dec_overflow(_v, _label)				\\
+do {									\\
+	${int} __new = arch_${atomic}_dec_return(_v);			\\
+	if (unlikely(__new <= 0))					\\
+		goto _label;						\\
+} while (0)
+EOF
--- /dev/null
+++ b/scripts/atomic/fallbacks/inc_overflow
@@ -0,0 +1,8 @@
+cat << EOF
+#define arch_${atomic}_inc_overflow(_v, _label)				\\
+do {									\\
+	${int} __old = arch_${atomic}_fetch_inc(_v);			\\
+	if (unlikely(__old <= 0))					\\
+		goto _label;						\\
+} while (0)
+EOF


