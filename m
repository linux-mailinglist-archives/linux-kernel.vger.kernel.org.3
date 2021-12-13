Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6223B472C23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhLMMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbhLMMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:15:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854B4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kJtXQtfvYfjtAuOsUxUmIXm6ivARMk0ODegCZPt1LPs=; b=H7bbFZ/quMX3+o3miYBzwg0533
        Qu9mtfezrl2Eb3JCiNkhYV36v41+D4lmA0oyOM6Xmm/sbOPWxA/mIlwRNSF5Pk3vKl7HWdsbbc6x8
        Vhax30mWT9EQw2RmTvjEQNi0fyRV41sYKnyPDWW3UeDTdaHsthBr9iu0jtH9JHGoGm0gEWOC3hn+i
        qlqXE+lvRYKfMVG7zVHBR1/gh7qp/HWyvUWy2uEARKUA3cbp64JsE5YczGjaWtNgtkC9moJmA+b+C
        yGbe+7Xg9btzD3WdunriM/Tt50R0LLdIZBxIDccMY/t67fENDtTMobw4+dT2PlDlKfSNONNhqnZNt
        qEBn9o0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwkEz-00Cm5V-Cc; Mon, 13 Dec 2021 12:15:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2599D30026A;
        Mon, 13 Dec 2021 13:15:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4FBC2D3EC7E9; Mon, 13 Dec 2021 13:15:36 +0100 (CET)
Date:   Mon, 13 Dec 2021 13:15:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        elver@google.com, keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 10/9] atomic: Document the atomic_{}_overflow() functions
Message-ID: <Ybc5aMFodXvDkT4f@hirez.programming.kicks-ass.net>
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210161618.645249719@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


They're damn special, they're very likely to confuse people, write a
few words in a vain attempt to twart some of that confusion.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/atomic_t.txt                     |   36 +++++++++++++++++
 include/linux/atomic/atomic-arch-fallback.h    |   52 ++++++++++++++++++++++++-
 scripts/atomic/fallbacks/dec_and_test_overflow |   10 ++++
 scripts/atomic/fallbacks/dec_overflow          |    9 ++++
 scripts/atomic/fallbacks/inc_overflow          |    9 ++++
 5 files changed, 115 insertions(+), 1 deletion(-)

--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -45,6 +45,14 @@ The 'full' API consists of (atomic64_ an
   atomic_sub_and_test(), atomic_dec_and_test()
 
 
+Reference count with overflow (as used by refcount_t):
+
+  atomic_inc_overflow(), atomic_dec_overflow()
+  atomic_dec_and_test_overflow()
+
+  ATOMIC_OVERFLOW_OFFSET
+
+
 Misc:
 
   atomic_inc_and_test(), atomic_add_negative()
@@ -157,6 +165,34 @@ atomic variable) can be fully ordered an
 visible.
 
 
+Overflow ops:
+
+The atomic_{}_overflow() ops are similar to their !_overflow() bretheren with
+two notable exceptions:
+
+ - they take a label as their final argument to to jump to when the atomic op
+   overflows;
+
+ - the actual value can be offset from 0 in order to allow architectures
+   to play games with condition flags in order to generate better code. This
+   offset is ATOMIC_OVERFLOW_OFFSET.
+
+The canonical overflow conditions are (ATOMIC_OVERFLOW_OFFSET == 0):
+
+  inc: zero or negative on the value pre increment
+  dec: zero or negative on the value post decrement
+  dec_and_test: negative on the value post decrement
+
+This gives an effective range of [0, INT_MIN] for the actual value. When an
+architecture uses ATOMIC_OVERFLOW_OFFSET == 1 (x86), the effective range
+becomes [-1, INT_MIN], or [0, INT_MIN+1] after correction.
+
+These semantics match the reference count use-case (for which they were
+created). Specifically incrementing from zero is a failure because zero means
+the object is freed (IOW use-after-free). Decrementing to zero is a failure
+because it goes undetected (see dec_and_test) and the object would leak.
+
+
 ORDERING  (go read memory-barriers.txt first)
 --------
 
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -1251,6 +1251,14 @@ arch_atomic_dec_if_positive(atomic_t *v)
 #endif
 
 #ifndef arch_atomic_inc_overflow
+/**
+ * arch_atomic_inc_overflow - increment with overflow exception
+ * @_v: pointer of type atomic_t
+ * @_label: label to goto on overflow
+ *
+ * Atomically increments @_v and goto @_label when the old
+ * value (+ATOMIC_OVERFLOW_OFFSET) is negative.
+ */
 #define arch_atomic_inc_overflow(_v, _label)				\
 do {									\
 	int __old = arch_atomic_fetch_inc(_v);			\
@@ -1260,6 +1268,14 @@ do {									\
 #endif
 
 #ifndef arch_atomic_dec_overflow
+/**
+ * arch_atomic_dec_overflow - decrement with overflow exception
+ * @_v: pointer of type atomic_t
+ * @_label: label to goto on overflow
+ *
+ * Atomically decrements @_v and goto @_label when the
+ * result (+ATOMIC_OVERFLOW_OFFSET) is negative.
+ */
 #define arch_atomic_dec_overflow(_v, _label)				\
 do {									\
 	int __new = arch_atomic_dec_return(_v);			\
@@ -1269,6 +1285,15 @@ do {									\
 #endif
 
 #ifndef arch_atomic_dec_and_test_overflow
+/**
+ * arch_atomic_dec_and_test_overflow - decrement and test if zero with overflow exception
+ * @_v: pointer of type atomic_t
+ * @_label: label to goto on overflow
+ *
+ * Atomically decrements @_v and returns true if the result
+ * (+ATOMIC_OVERFLOW_OFFSET) is zero or goto @_label when the
+ * result (+ATOMIC_OVERFLOW_OFFSET) is negative.
+ */
 #define arch_atomic_dec_and_test_overflow(_v, _label)		\
 ({									\
 	bool __ret = false;						\
@@ -2389,6 +2414,14 @@ arch_atomic64_dec_if_positive(atomic64_t
 #endif
 
 #ifndef arch_atomic64_inc_overflow
+/**
+ * arch_atomic64_inc_overflow - increment with overflow exception
+ * @_v: pointer of type atomic64_t
+ * @_label: label to goto on overflow
+ *
+ * Atomically increments @_v and goto @_label when the old
+ * value (+ATOMIC64_OVERFLOW_OFFSET) is negative.
+ */
 #define arch_atomic64_inc_overflow(_v, _label)				\
 do {									\
 	s64 __old = arch_atomic64_fetch_inc(_v);			\
@@ -2398,6 +2431,14 @@ do {									\
 #endif
 
 #ifndef arch_atomic64_dec_overflow
+/**
+ * arch_atomic64_dec_overflow - decrement with overflow exception
+ * @_v: pointer of type atomic64_t
+ * @_label: label to goto on overflow
+ *
+ * Atomically decrements @_v and goto @_label when the
+ * result (+ATOMIC64_OVERFLOW_OFFSET) is negative.
+ */
 #define arch_atomic64_dec_overflow(_v, _label)				\
 do {									\
 	s64 __new = arch_atomic64_dec_return(_v);			\
@@ -2407,6 +2448,15 @@ do {									\
 #endif
 
 #ifndef arch_atomic64_dec_and_test_overflow
+/**
+ * arch_atomic64_dec_and_test_overflow - decrement and test if zero with overflow exception
+ * @_v: pointer of type atomic64_t
+ * @_label: label to goto on overflow
+ *
+ * Atomically decrements @_v and returns true if the result
+ * (+ATOMIC64_OVERFLOW_OFFSET) is zero or goto @_label when the
+ * result (+ATOMIC64_OVERFLOW_OFFSET) is negative.
+ */
 #define arch_atomic64_dec_and_test_overflow(_v, _label)		\
 ({									\
 	bool __ret = false;						\
@@ -2420,4 +2470,4 @@ do {									\
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// e4c677b23b3fd5e8dc4bce9d6c055103666cfc4a
+// ccccab23ad71e0523949b969f68b40fe6812fc15
--- a/scripts/atomic/fallbacks/dec_and_test_overflow
+++ b/scripts/atomic/fallbacks/dec_and_test_overflow
@@ -1,4 +1,14 @@
+ATOMIC=`echo ${atomic} | tr '[:lower:]' '[:upper:]'`
 cat << EOF
+/**
+ * arch_${atomic}_dec_and_test_overflow - decrement and test if zero with overflow exception
+ * @_v: pointer of type ${atomic}_t
+ * @_label: label to goto on overflow
+ *
+ * Atomically decrements @_v and returns true if the result
+ * (+${ATOMIC}_OVERFLOW_OFFSET) is zero or goto @_label when the
+ * result (+${ATOMIC}_OVERFLOW_OFFSET) is negative.
+ */
 #define arch_${atomic}_dec_and_test_overflow(_v, _label)		\\
 ({									\\
 	bool __ret = false;						\\
--- a/scripts/atomic/fallbacks/dec_overflow
+++ b/scripts/atomic/fallbacks/dec_overflow
@@ -1,4 +1,13 @@
+ATOMIC=`echo ${atomic} | tr '[:lower:]' '[:upper:]'`
 cat << EOF
+/**
+ * arch_${atomic}_dec_overflow - decrement with overflow exception
+ * @_v: pointer of type ${atomic}_t
+ * @_label: label to goto on overflow
+ *
+ * Atomically decrements @_v and goto @_label when the
+ * result (+${ATOMIC}_OVERFLOW_OFFSET) is negative.
+ */
 #define arch_${atomic}_dec_overflow(_v, _label)				\\
 do {									\\
 	${int} __new = arch_${atomic}_dec_return(_v);			\\
--- a/scripts/atomic/fallbacks/inc_overflow
+++ b/scripts/atomic/fallbacks/inc_overflow
@@ -1,4 +1,13 @@
+ATOMIC=`echo ${atomic} | tr '[:lower:]' '[:upper:]'`
 cat << EOF
+/**
+ * arch_${atomic}_inc_overflow - increment with overflow exception
+ * @_v: pointer of type ${atomic}_t
+ * @_label: label to goto on overflow
+ *
+ * Atomically increments @_v and goto @_label when the old
+ * value (+${ATOMIC}_OVERFLOW_OFFSET) is negative.
+ */
 #define arch_${atomic}_inc_overflow(_v, _label)				\\
 do {									\\
 	${int} __old = arch_${atomic}_fetch_inc(_v);			\\
