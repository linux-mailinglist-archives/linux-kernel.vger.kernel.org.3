Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB047059D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbhLJQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhLJQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:30:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA06AC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9r4ir9X+LihKrT7hY/BtEz6BMhD5gRGP9c6+8I59KNI=; b=hFzZnnzW+ChEBSXylpyfMWPzWU
        jyKSX3tjiT1BZbtGvRx6LC0EuA87mEKFIdLfqyypX98/wLC9QDbOv+Z7fi6aOnxtkGeIrnszcROcN
        QB5CVad/SDuxHn43pfZ/rguN8E3pY7zvpvB/ZsQAt82L5pK8YG5wEBWDcxAzv1dY3HEd0KRIpocxY
        1vkgagsJGzVAKg+FEe5E4haeOyuVzVrNWEWEXMRw3OEkwtS5UKkpmK1jZ4/LCbsKt/Vrlz9925LoH
        ck5O+G+T6qt8Q4vP+ZW0ZZYdcL2h5colc4r7IQoTSEHxh+T+iFOg2KnxO3qbkopGh3QkkY0nETZ7v
        suwmvM9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvijl-00ATwv-S5; Fri, 10 Dec 2021 16:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6397300750;
        Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7458D2B3CD730; Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Message-ID: <20211210162313.774144401@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Dec 2021 17:16:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 7/9] refcount: Prepare for atomic_*_overflow() offsets
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for atomic_*_overflow() not strictly being in the
[0,INT_MAX] range, add ATOMIC_OVERFLOW_OFFSET to correct for the 0
point.

This makes the uncommon refcount ops a little awkward, but allows for
faster common ops.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/atomic.h   |   16 ++++++++++++++++
 include/linux/refcount.h |   16 ++++++++++++----
 lib/refcount.c           |   10 +++++-----
 3 files changed, 33 insertions(+), 9 deletions(-)

--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -7,6 +7,14 @@
 #include <asm/atomic.h>
 #include <asm/barrier.h>
 
+#ifndef ATOMIC_OVERFLOW_OFFSET
+#define ATOMIC_OVERFLOW_OFFSET 0
+#endif
+
+#ifndef ATOMIC64_OVERFLOW_OFFSET
+#define ATOMIC64_OVERFLOW_OFFSET 0
+#endif
+
 /*
  * Relaxed variants of xchg, cmpxchg and some atomic operations.
  *
@@ -81,4 +89,12 @@
 #include <linux/atomic/atomic-long.h>
 #include <linux/atomic/atomic-instrumented.h>
 
+#ifndef ATOMIC_LONG_OVERFLOW_OFFSET
+#ifdef CONFIG_64BIT
+#define ATOMIC_LONG_OVERFLOW_OFFSET	ATOMIC64_OVERFLOW_OFFSET
+#else
+#define ATOMIC_LONG_OVERFLOW_OFFSET	ATOMIC_OVERFLOW_OFFSET
+#endif
+#endif
+
 #endif /* _LINUX_ATOMIC_H */
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -133,7 +133,7 @@ void refcount_warn_saturate(refcount_t *
  */
 static inline void refcount_set(refcount_t *r, int n)
 {
-	atomic_set(&r->refs, n);
+	atomic_set(&r->refs, n - ATOMIC_OVERFLOW_OFFSET);
 }
 
 /**
@@ -144,18 +144,20 @@ static inline void refcount_set(refcount
  */
 static inline unsigned int refcount_read(const refcount_t *r)
 {
-	return atomic_read(&r->refs);
+	return atomic_read(&r->refs) + ATOMIC_OVERFLOW_OFFSET;
 }
 
 static inline __must_check bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
 {
-	int old = refcount_read(r);
+	int old = atomic_read(&r->refs);
 
 	do {
-		if (!old)
+		if (old == -ATOMIC_OVERFLOW_OFFSET)
 			break;
 	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
 
+	old += ATOMIC_OVERFLOW_OFFSET;
+
 	if (oldp)
 		*oldp = old;
 
@@ -192,6 +194,8 @@ static inline void __refcount_add(int i,
 {
 	int old = atomic_fetch_add_relaxed(i, &r->refs);
 
+	old += ATOMIC_OVERFLOW_OFFSET;
+
 	if (oldp)
 		*oldp = old;
 
@@ -274,6 +278,8 @@ static inline __must_check bool __refcou
 {
 	int old = atomic_fetch_sub_release(i, &r->refs);
 
+	old += ATOMIC_OVERFLOW_OFFSET;
+
 	if (oldp)
 		*oldp = old;
 
@@ -343,6 +349,8 @@ static inline void __refcount_dec(refcou
 {
 	int old = atomic_fetch_sub_release(1, &r->refs);
 
+	old += ATOMIC_OVERFLOW_OFFSET;
+
 	if (oldp)
 		*oldp = old;
 
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -13,7 +13,7 @@
 void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
 {
 	int old = refcount_read(r);
-	refcount_set(r, REFCOUNT_SATURATED);
+	atomic_set(&r->refs, REFCOUNT_SATURATED);
 
 	/* racy; who cares */
 	if (old == 1 && t == REFCOUNT_ADD_OVF)
@@ -59,9 +59,9 @@ EXPORT_SYMBOL(refcount_warn_saturate);
  */
 bool refcount_dec_if_one(refcount_t *r)
 {
-	int val = 1;
+	int val = 1 - ATOMIC_OVERFLOW_OFFSET;
 
-	return atomic_try_cmpxchg_release(&r->refs, &val, 0);
+	return atomic_try_cmpxchg_release(&r->refs, &val, 0 - ATOMIC_OVERFLOW_OFFSET);
 }
 EXPORT_SYMBOL(refcount_dec_if_one);
 
@@ -85,11 +85,11 @@ bool refcount_dec_not_one(refcount_t *r)
 		if (unlikely(val - (REFCOUNT_SATURATED + REFCOUNT_SATURATED/2) < -REFCOUNT_SATURATED))
 			return true;
 
-		if (val == 1)
+		if (val == 1 - ATOMIC_OVERFLOW_OFFSET)
 			return false;
 
 		new = val - 1;
-		if (new > val) {
+		if (new + ATOMIC_OVERFLOW_OFFSET > val + ATOMIC_OVERFLOW_OFFSET) {
 			refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
 			return true;
 		}


