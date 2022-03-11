Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FCB4D662A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350367AbiCKQ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350343AbiCKQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:26:36 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388FD1B7637;
        Fri, 11 Mar 2022 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647015900;
  x=1678551900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8onS2RC9Wtu51RueANf2GNphm06S3PZ9X5o0fB0h0Y4=;
  b=CzCtNMFZOStZGgISMxzXYEAsvGyIWb0TSd9EoMkoNck6JG6ueT9jHHCv
   rCGSa3uz4bg36ZBEFQS8c8rsMg7AGleQgbTZsFB9NsLk8RR7QRGyzMXoP
   FzsxQuBw0XVnAz4yq3BfxvkYXcVC9iTt95D/sah1YL66GqGFTHoElXQ9Z
   PoOnwRskCuajdX4Op9B69ff5SbCUdz7wT/Zn9KmH8QwlNonDkN1BqpW+s
   S/q8HwrOEjh4DCuRGMf45utPMAo5fN4h0Ql+cHrlUig0cgMUzM0usjmY3
   v0zdP0KN8FiNI/5UoauhAz2K6i01Qf5n1KRW9vEwN2rYh3l5AskKaZ8ZT
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <devicetree@vger.kernel.org>, <linux-um@lists.infradead.org>,
        <shuah@kernel.org>, <brendanhiggins@google.com>,
        <linux-kselftest@vger.kernel.org>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <linux-rtc@vger.kernel.org>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [RFC v1 01/10] roadtest: import libvhost-user from QEMU
Date:   Fri, 11 Mar 2022 17:24:36 +0100
Message-ID: <20220311162445.346685-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311162445.346685-1-vincent.whitchurch@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Import the libvhost-user from QEMU for use in the implementation of the
virtio devices in the roadtest backend.

The files are from the following paths in v6.2.0 of QEMU:

 include/qemu/atomic.h
 subprojects/libvhost-user/libvhost-user.c
 subprojects/libvhost-user/libvhost-user.h

In order to keep further imports strightforward, the files have been
copied as-is with only the following essential modifications:

 - Addition of SPDX lines (GPL-2.0-or-later, in conformance with the
   existing copyright messages in the files)

 - Change of "standard-headers/linux/virtio_ring.h" to
   <linux/virtio_ring.h> in libvhost-user.h.  It will be built with the
   headers from the current kernel.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../src/libvhost-user/include/atomic.h        |  310 ++
 .../src/libvhost-user/libvhost-user.c         | 2885 +++++++++++++++++
 .../src/libvhost-user/libvhost-user.h         |  691 ++++
 3 files changed, 3886 insertions(+)
 create mode 100644 tools/testing/roadtest/src/libvhost-user/include/atomic.h
 create mode 100644 tools/testing/roadtest/src/libvhost-user/libvhost-user.c
 create mode 100644 tools/testing/roadtest/src/libvhost-user/libvhost-user.h

diff --git a/tools/testing/roadtest/src/libvhost-user/include/atomic.h b/tools/testing/roadtest/src/libvhost-user/include/atomic.h
new file mode 100644
index 000000000000..65026bf54406
--- /dev/null
+++ b/tools/testing/roadtest/src/libvhost-user/include/atomic.h
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Simple interface for atomic operations.
+ *
+ * Copyright (C) 2013 Red Hat, Inc.
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * See docs/devel/atomics.rst for discussion about the guarantees each
+ * atomic primitive is meant to provide.
+ */
+
+#ifndef QEMU_ATOMIC_H
+#define QEMU_ATOMIC_H
+
+/* Compiler barrier */
+#define barrier()   ({ asm volatile("" ::: "memory"); (void)0; })
+
+/* The variable that receives the old value of an atomically-accessed
+ * variable must be non-qualified, because atomic builtins return values
+ * through a pointer-type argument as in __atomic_load(&var, &old, MODEL).
+ *
+ * This macro has to handle types smaller than int manually, because of
+ * implicit promotion.  int and larger types, as well as pointers, can be
+ * converted to a non-qualified type just by applying a binary operator.
+ */
+#define typeof_strip_qual(expr)                                                    \
+  typeof(                                                                          \
+    __builtin_choose_expr(                                                         \
+      __builtin_types_compatible_p(typeof(expr), bool) ||                          \
+        __builtin_types_compatible_p(typeof(expr), const bool) ||                  \
+        __builtin_types_compatible_p(typeof(expr), volatile bool) ||               \
+        __builtin_types_compatible_p(typeof(expr), const volatile bool),           \
+        (bool)1,                                                                   \
+    __builtin_choose_expr(                                                         \
+      __builtin_types_compatible_p(typeof(expr), signed char) ||                   \
+        __builtin_types_compatible_p(typeof(expr), const signed char) ||           \
+        __builtin_types_compatible_p(typeof(expr), volatile signed char) ||        \
+        __builtin_types_compatible_p(typeof(expr), const volatile signed char),    \
+        (signed char)1,                                                            \
+    __builtin_choose_expr(                                                         \
+      __builtin_types_compatible_p(typeof(expr), unsigned char) ||                 \
+        __builtin_types_compatible_p(typeof(expr), const unsigned char) ||         \
+        __builtin_types_compatible_p(typeof(expr), volatile unsigned char) ||      \
+        __builtin_types_compatible_p(typeof(expr), const volatile unsigned char),  \
+        (unsigned char)1,                                                          \
+    __builtin_choose_expr(                                                         \
+      __builtin_types_compatible_p(typeof(expr), signed short) ||                  \
+        __builtin_types_compatible_p(typeof(expr), const signed short) ||          \
+        __builtin_types_compatible_p(typeof(expr), volatile signed short) ||       \
+        __builtin_types_compatible_p(typeof(expr), const volatile signed short),   \
+        (signed short)1,                                                           \
+    __builtin_choose_expr(                                                         \
+      __builtin_types_compatible_p(typeof(expr), unsigned short) ||                \
+        __builtin_types_compatible_p(typeof(expr), const unsigned short) ||        \
+        __builtin_types_compatible_p(typeof(expr), volatile unsigned short) ||     \
+        __builtin_types_compatible_p(typeof(expr), const volatile unsigned short), \
+        (unsigned short)1,                                                         \
+      (expr)+0))))))
+
+#ifndef __ATOMIC_RELAXED
+#error "Expecting C11 atomic ops"
+#endif
+
+/* Manual memory barriers
+ *
+ *__atomic_thread_fence does not include a compiler barrier; instead,
+ * the barrier is part of __atomic_load/__atomic_store's "volatile-like"
+ * semantics. If smp_wmb() is a no-op, absence of the barrier means that
+ * the compiler is free to reorder stores on each side of the barrier.
+ * Add one here, and similarly in smp_rmb() and smp_read_barrier_depends().
+ */
+
+#define smp_mb()                     ({ barrier(); __atomic_thread_fence(__ATOMIC_SEQ_CST); })
+#define smp_mb_release()             ({ barrier(); __atomic_thread_fence(__ATOMIC_RELEASE); })
+#define smp_mb_acquire()             ({ barrier(); __atomic_thread_fence(__ATOMIC_ACQUIRE); })
+
+/* Most compilers currently treat consume and acquire the same, but really
+ * no processors except Alpha need a barrier here.  Leave it in if
+ * using Thread Sanitizer to avoid warnings, otherwise optimize it away.
+ */
+#if defined(__SANITIZE_THREAD__)
+#define smp_read_barrier_depends()   ({ barrier(); __atomic_thread_fence(__ATOMIC_CONSUME); })
+#elif defined(__alpha__)
+#define smp_read_barrier_depends()   asm volatile("mb":::"memory")
+#else
+#define smp_read_barrier_depends()   barrier()
+#endif
+
+/*
+ * A signal barrier forces all pending local memory ops to be observed before
+ * a SIGSEGV is delivered to the *same* thread.  In practice this is exactly
+ * the same as barrier(), but since we have the correct builtin, use it.
+ */
+#define signal_barrier()    __atomic_signal_fence(__ATOMIC_SEQ_CST)
+
+/* Sanity check that the size of an atomic operation isn't "overly large".
+ * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
+ * want to use them because we ought not need them, and this lets us do a
+ * bit of sanity checking that other 32-bit hosts might build.
+ *
+ * That said, we have a problem on 64-bit ILP32 hosts in that in order to
+ * sync with TCG_OVERSIZED_GUEST, this must match TCG_TARGET_REG_BITS.
+ * We'd prefer not want to pull in everything else TCG related, so handle
+ * those few cases by hand.
+ *
+ * Note that x32 is fully detected with __x86_64__ + _ILP32, and that for
+ * Sparc we always force the use of sparcv9 in configure. MIPS n32 (ILP32) &
+ * n64 (LP64) ABIs are both detected using __mips64.
+ */
+#if defined(__x86_64__) || defined(__sparc__) || defined(__mips64)
+# define ATOMIC_REG_SIZE  8
+#else
+# define ATOMIC_REG_SIZE  sizeof(void *)
+#endif
+
+/* Weak atomic operations prevent the compiler moving other
+ * loads/stores past the atomic operation load/store. However there is
+ * no explicit memory barrier for the processor.
+ *
+ * The C11 memory model says that variables that are accessed from
+ * different threads should at least be done with __ATOMIC_RELAXED
+ * primitives or the result is undefined. Generally this has little to
+ * no effect on the generated code but not using the atomic primitives
+ * will get flagged by sanitizers as a violation.
+ */
+#define qatomic_read__nocheck(ptr) \
+    __atomic_load_n(ptr, __ATOMIC_RELAXED)
+
+#define qatomic_read(ptr)                              \
+    ({                                                 \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
+    qatomic_read__nocheck(ptr);                        \
+    })
+
+#define qatomic_set__nocheck(ptr, i) \
+    __atomic_store_n(ptr, i, __ATOMIC_RELAXED)
+
+#define qatomic_set(ptr, i)  do {                      \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
+    qatomic_set__nocheck(ptr, i);                      \
+} while(0)
+
+/* See above: most compilers currently treat consume and acquire the
+ * same, but this slows down qatomic_rcu_read unnecessarily.
+ */
+#ifdef __SANITIZE_THREAD__
+#define qatomic_rcu_read__nocheck(ptr, valptr)           \
+    __atomic_load(ptr, valptr, __ATOMIC_CONSUME);
+#else
+#define qatomic_rcu_read__nocheck(ptr, valptr)           \
+    __atomic_load(ptr, valptr, __ATOMIC_RELAXED);        \
+    smp_read_barrier_depends();
+#endif
+
+#define qatomic_rcu_read(ptr)                          \
+    ({                                                 \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
+    typeof_strip_qual(*ptr) _val;                      \
+    qatomic_rcu_read__nocheck(ptr, &_val);             \
+    _val;                                              \
+    })
+
+#define qatomic_rcu_set(ptr, i) do {                   \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
+    __atomic_store_n(ptr, i, __ATOMIC_RELEASE);        \
+} while(0)
+
+#define qatomic_load_acquire(ptr)                       \
+    ({                                                  \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);  \
+    typeof_strip_qual(*ptr) _val;                       \
+    __atomic_load(ptr, &_val, __ATOMIC_ACQUIRE);        \
+    _val;                                               \
+    })
+
+#define qatomic_store_release(ptr, i)  do {             \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);  \
+    __atomic_store_n(ptr, i, __ATOMIC_RELEASE);         \
+} while(0)
+
+
+/* All the remaining operations are fully sequentially consistent */
+
+#define qatomic_xchg__nocheck(ptr, i)    ({                 \
+    __atomic_exchange_n(ptr, (i), __ATOMIC_SEQ_CST);        \
+})
+
+#define qatomic_xchg(ptr, i)    ({                          \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);      \
+    qatomic_xchg__nocheck(ptr, i);                          \
+})
+
+/* Returns the eventual value, failed or not */
+#define qatomic_cmpxchg__nocheck(ptr, old, new)    ({                   \
+    typeof_strip_qual(*ptr) _old = (old);                               \
+    (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \
+                              __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);      \
+    _old;                                                               \
+})
+
+#define qatomic_cmpxchg(ptr, old, new)    ({                            \
+    QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);                  \
+    qatomic_cmpxchg__nocheck(ptr, old, new);                            \
+})
+
+/* Provide shorter names for GCC atomic builtins, return old value */
+#define qatomic_fetch_inc(ptr)  __atomic_fetch_add(ptr, 1, __ATOMIC_SEQ_CST)
+#define qatomic_fetch_dec(ptr)  __atomic_fetch_sub(ptr, 1, __ATOMIC_SEQ_CST)
+
+#define qatomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST)
+#define qatomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST)
+#define qatomic_fetch_and(ptr, n) __atomic_fetch_and(ptr, n, __ATOMIC_SEQ_CST)
+#define qatomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST)
+#define qatomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ_CST)
+
+#define qatomic_inc_fetch(ptr)    __atomic_add_fetch(ptr, 1, __ATOMIC_SEQ_CST)
+#define qatomic_dec_fetch(ptr)    __atomic_sub_fetch(ptr, 1, __ATOMIC_SEQ_CST)
+#define qatomic_add_fetch(ptr, n) __atomic_add_fetch(ptr, n, __ATOMIC_SEQ_CST)
+#define qatomic_sub_fetch(ptr, n) __atomic_sub_fetch(ptr, n, __ATOMIC_SEQ_CST)
+#define qatomic_and_fetch(ptr, n) __atomic_and_fetch(ptr, n, __ATOMIC_SEQ_CST)
+#define qatomic_or_fetch(ptr, n)  __atomic_or_fetch(ptr, n, __ATOMIC_SEQ_CST)
+#define qatomic_xor_fetch(ptr, n) __atomic_xor_fetch(ptr, n, __ATOMIC_SEQ_CST)
+
+/* And even shorter names that return void.  */
+#define qatomic_inc(ptr) \
+    ((void) __atomic_fetch_add(ptr, 1, __ATOMIC_SEQ_CST))
+#define qatomic_dec(ptr) \
+    ((void) __atomic_fetch_sub(ptr, 1, __ATOMIC_SEQ_CST))
+#define qatomic_add(ptr, n) \
+    ((void) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST))
+#define qatomic_sub(ptr, n) \
+    ((void) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST))
+#define qatomic_and(ptr, n) \
+    ((void) __atomic_fetch_and(ptr, n, __ATOMIC_SEQ_CST))
+#define qatomic_or(ptr, n) \
+    ((void) __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST))
+#define qatomic_xor(ptr, n) \
+    ((void) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ_CST))
+
+#define smp_wmb()   smp_mb_release()
+#define smp_rmb()   smp_mb_acquire()
+
+/* qatomic_mb_read/set semantics map Java volatile variables. They are
+ * less expensive on some platforms (notably POWER) than fully
+ * sequentially consistent operations.
+ *
+ * As long as they are used as paired operations they are safe to
+ * use. See docs/devel/atomics.rst for more discussion.
+ */
+
+#define qatomic_mb_read(ptr)                             \
+    qatomic_load_acquire(ptr)
+
+#if !defined(__SANITIZE_THREAD__) && \
+    (defined(__i386__) || defined(__x86_64__) || defined(__s390x__))
+/* This is more efficient than a store plus a fence.  */
+# define qatomic_mb_set(ptr, i)  ((void)qatomic_xchg(ptr, i))
+#else
+# define qatomic_mb_set(ptr, i) \
+   ({ qatomic_store_release(ptr, i); smp_mb(); })
+#endif
+
+#define qatomic_fetch_inc_nonzero(ptr) ({                               \
+    typeof_strip_qual(*ptr) _oldn = qatomic_read(ptr);                  \
+    while (_oldn && qatomic_cmpxchg(ptr, _oldn, _oldn + 1) != _oldn) {  \
+        _oldn = qatomic_read(ptr);                                      \
+    }                                                                   \
+    _oldn;                                                              \
+})
+
+/*
+ * Abstractions to access atomically (i.e. "once") i64/u64 variables.
+ *
+ * The i386 abi is odd in that by default members are only aligned to
+ * 4 bytes, which means that 8-byte types can wind up mis-aligned.
+ * Clang will then warn about this, and emit a call into libatomic.
+ *
+ * Use of these types in structures when they will be used with atomic
+ * operations can avoid this.
+ */
+typedef int64_t aligned_int64_t __attribute__((aligned(8)));
+typedef uint64_t aligned_uint64_t __attribute__((aligned(8)));
+
+#ifdef CONFIG_ATOMIC64
+/* Use __nocheck because sizeof(void *) might be < sizeof(u64) */
+#define qatomic_read_i64(P) \
+    _Generic(*(P), int64_t: qatomic_read__nocheck(P))
+#define qatomic_read_u64(P) \
+    _Generic(*(P), uint64_t: qatomic_read__nocheck(P))
+#define qatomic_set_i64(P, V) \
+    _Generic(*(P), int64_t: qatomic_set__nocheck(P, V))
+#define qatomic_set_u64(P, V) \
+    _Generic(*(P), uint64_t: qatomic_set__nocheck(P, V))
+
+static inline void qatomic64_init(void)
+{
+}
+#else /* !CONFIG_ATOMIC64 */
+int64_t  qatomic_read_i64(const int64_t *ptr);
+uint64_t qatomic_read_u64(const uint64_t *ptr);
+void qatomic_set_i64(int64_t *ptr, int64_t val);
+void qatomic_set_u64(uint64_t *ptr, uint64_t val);
+void qatomic64_init(void);
+#endif /* !CONFIG_ATOMIC64 */
+
+#endif /* QEMU_ATOMIC_H */
diff --git a/tools/testing/roadtest/src/libvhost-user/libvhost-user.c b/tools/testing/roadtest/src/libvhost-user/libvhost-user.c
new file mode 100644
index 000000000000..1e6dddfb10df
--- /dev/null
+++ b/tools/testing/roadtest/src/libvhost-user/libvhost-user.c
@@ -0,0 +1,2885 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Vhost User library
+ *
+ * Copyright IBM, Corp. 2007
+ * Copyright (c) 2016 Red Hat, Inc.
+ *
+ * Authors:
+ *  Anthony Liguori <aliguori@us.ibm.com>
+ *  Marc-André Lureau <mlureau@redhat.com>
+ *  Victor Kaplansky <victork@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+/* this code avoids GLib dependency */
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include <errno.h>
+#include <string.h>
+#include <assert.h>
+#include <inttypes.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/eventfd.h>
+#include <sys/mman.h>
+#include <endian.h>
+
+#if defined(__linux__)
+#include <sys/syscall.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/vhost.h>
+
+#ifdef __NR_userfaultfd
+#include <linux/userfaultfd.h>
+#endif
+
+#endif
+
+#include "include/atomic.h"
+
+#include "libvhost-user.h"
+
+/* usually provided by GLib */
+#ifndef MIN
+#define MIN(x, y) ({                            \
+            typeof(x) _min1 = (x);              \
+            typeof(y) _min2 = (y);              \
+            (void) (&_min1 == &_min2);          \
+            _min1 < _min2 ? _min1 : _min2; })
+#endif
+
+/* Round number down to multiple */
+#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
+
+/* Round number up to multiple */
+#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
+
+#ifndef unlikely
+#define unlikely(x)   __builtin_expect(!!(x), 0)
+#endif
+
+/* Align each region to cache line size in inflight buffer */
+#define INFLIGHT_ALIGNMENT 64
+
+/* The version of inflight buffer */
+#define INFLIGHT_VERSION 1
+
+/* The version of the protocol we support */
+#define VHOST_USER_VERSION 1
+#define LIBVHOST_USER_DEBUG 0
+
+#define DPRINT(...)                             \
+    do {                                        \
+        if (LIBVHOST_USER_DEBUG) {              \
+            fprintf(stderr, __VA_ARGS__);        \
+        }                                       \
+    } while (0)
+
+static inline
+bool has_feature(uint64_t features, unsigned int fbit)
+{
+    assert(fbit < 64);
+    return !!(features & (1ULL << fbit));
+}
+
+static inline
+bool vu_has_feature(VuDev *dev,
+                    unsigned int fbit)
+{
+    return has_feature(dev->features, fbit);
+}
+
+static inline bool vu_has_protocol_feature(VuDev *dev, unsigned int fbit)
+{
+    return has_feature(dev->protocol_features, fbit);
+}
+
+static const char *
+vu_request_to_string(unsigned int req)
+{
+#define REQ(req) [req] = #req
+    static const char *vu_request_str[] = {
+        REQ(VHOST_USER_NONE),
+        REQ(VHOST_USER_GET_FEATURES),
+        REQ(VHOST_USER_SET_FEATURES),
+        REQ(VHOST_USER_SET_OWNER),
+        REQ(VHOST_USER_RESET_OWNER),
+        REQ(VHOST_USER_SET_MEM_TABLE),
+        REQ(VHOST_USER_SET_LOG_BASE),
+        REQ(VHOST_USER_SET_LOG_FD),
+        REQ(VHOST_USER_SET_VRING_NUM),
+        REQ(VHOST_USER_SET_VRING_ADDR),
+        REQ(VHOST_USER_SET_VRING_BASE),
+        REQ(VHOST_USER_GET_VRING_BASE),
+        REQ(VHOST_USER_SET_VRING_KICK),
+        REQ(VHOST_USER_SET_VRING_CALL),
+        REQ(VHOST_USER_SET_VRING_ERR),
+        REQ(VHOST_USER_GET_PROTOCOL_FEATURES),
+        REQ(VHOST_USER_SET_PROTOCOL_FEATURES),
+        REQ(VHOST_USER_GET_QUEUE_NUM),
+        REQ(VHOST_USER_SET_VRING_ENABLE),
+        REQ(VHOST_USER_SEND_RARP),
+        REQ(VHOST_USER_NET_SET_MTU),
+        REQ(VHOST_USER_SET_SLAVE_REQ_FD),
+        REQ(VHOST_USER_IOTLB_MSG),
+        REQ(VHOST_USER_SET_VRING_ENDIAN),
+        REQ(VHOST_USER_GET_CONFIG),
+        REQ(VHOST_USER_SET_CONFIG),
+        REQ(VHOST_USER_POSTCOPY_ADVISE),
+        REQ(VHOST_USER_POSTCOPY_LISTEN),
+        REQ(VHOST_USER_POSTCOPY_END),
+        REQ(VHOST_USER_GET_INFLIGHT_FD),
+        REQ(VHOST_USER_SET_INFLIGHT_FD),
+        REQ(VHOST_USER_GPU_SET_SOCKET),
+        REQ(VHOST_USER_VRING_KICK),
+        REQ(VHOST_USER_GET_MAX_MEM_SLOTS),
+        REQ(VHOST_USER_ADD_MEM_REG),
+        REQ(VHOST_USER_REM_MEM_REG),
+        REQ(VHOST_USER_MAX),
+    };
+#undef REQ
+
+    if (req < VHOST_USER_MAX) {
+        return vu_request_str[req];
+    } else {
+        return "unknown";
+    }
+}
+
+static void
+vu_panic(VuDev *dev, const char *msg, ...)
+{
+    char *buf = NULL;
+    va_list ap;
+
+    va_start(ap, msg);
+    if (vasprintf(&buf, msg, ap) < 0) {
+        buf = NULL;
+    }
+    va_end(ap);
+
+    dev->broken = true;
+    dev->panic(dev, buf);
+    free(buf);
+
+    /*
+     * FIXME:
+     * find a way to call virtio_error, or perhaps close the connection?
+     */
+}
+
+/* Translate guest physical address to our virtual address.  */
+void *
+vu_gpa_to_va(VuDev *dev, uint64_t *plen, uint64_t guest_addr)
+{
+    int i;
+
+    if (*plen == 0) {
+        return NULL;
+    }
+
+    /* Find matching memory region.  */
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *r = &dev->regions[i];
+
+        if ((guest_addr >= r->gpa) && (guest_addr < (r->gpa + r->size))) {
+            if ((guest_addr + *plen) > (r->gpa + r->size)) {
+                *plen = r->gpa + r->size - guest_addr;
+            }
+            return (void *)(uintptr_t)
+                guest_addr - r->gpa + r->mmap_addr + r->mmap_offset;
+        }
+    }
+
+    return NULL;
+}
+
+/* Translate qemu virtual address to our virtual address.  */
+static void *
+qva_to_va(VuDev *dev, uint64_t qemu_addr)
+{
+    int i;
+
+    /* Find matching memory region.  */
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *r = &dev->regions[i];
+
+        if ((qemu_addr >= r->qva) && (qemu_addr < (r->qva + r->size))) {
+            return (void *)(uintptr_t)
+                qemu_addr - r->qva + r->mmap_addr + r->mmap_offset;
+        }
+    }
+
+    return NULL;
+}
+
+static void
+vmsg_close_fds(VhostUserMsg *vmsg)
+{
+    int i;
+
+    for (i = 0; i < vmsg->fd_num; i++) {
+        close(vmsg->fds[i]);
+    }
+}
+
+/* Set reply payload.u64 and clear request flags and fd_num */
+static void vmsg_set_reply_u64(VhostUserMsg *vmsg, uint64_t val)
+{
+    vmsg->flags = 0; /* defaults will be set by vu_send_reply() */
+    vmsg->size = sizeof(vmsg->payload.u64);
+    vmsg->payload.u64 = val;
+    vmsg->fd_num = 0;
+}
+
+/* A test to see if we have userfault available */
+static bool
+have_userfault(void)
+{
+#if defined(__linux__) && defined(__NR_userfaultfd) &&\
+        defined(UFFD_FEATURE_MISSING_SHMEM) &&\
+        defined(UFFD_FEATURE_MISSING_HUGETLBFS)
+    /* Now test the kernel we're running on really has the features */
+    int ufd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+    struct uffdio_api api_struct;
+    if (ufd < 0) {
+        return false;
+    }
+
+    api_struct.api = UFFD_API;
+    api_struct.features = UFFD_FEATURE_MISSING_SHMEM |
+                          UFFD_FEATURE_MISSING_HUGETLBFS;
+    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
+        close(ufd);
+        return false;
+    }
+    close(ufd);
+    return true;
+
+#else
+    return false;
+#endif
+}
+
+static bool
+vu_message_read_default(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    char control[CMSG_SPACE(VHOST_MEMORY_BASELINE_NREGIONS * sizeof(int))] = {};
+    struct iovec iov = {
+        .iov_base = (char *)vmsg,
+        .iov_len = VHOST_USER_HDR_SIZE,
+    };
+    struct msghdr msg = {
+        .msg_iov = &iov,
+        .msg_iovlen = 1,
+        .msg_control = control,
+        .msg_controllen = sizeof(control),
+    };
+    size_t fd_size;
+    struct cmsghdr *cmsg;
+    int rc;
+
+    do {
+        rc = recvmsg(conn_fd, &msg, 0);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    if (rc < 0) {
+        vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
+        return false;
+    }
+
+    vmsg->fd_num = 0;
+    for (cmsg = CMSG_FIRSTHDR(&msg);
+         cmsg != NULL;
+         cmsg = CMSG_NXTHDR(&msg, cmsg))
+    {
+        if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_RIGHTS) {
+            fd_size = cmsg->cmsg_len - CMSG_LEN(0);
+            vmsg->fd_num = fd_size / sizeof(int);
+            memcpy(vmsg->fds, CMSG_DATA(cmsg), fd_size);
+            break;
+        }
+    }
+
+    if (vmsg->size > sizeof(vmsg->payload)) {
+        vu_panic(dev,
+                 "Error: too big message request: %d, size: vmsg->size: %u, "
+                 "while sizeof(vmsg->payload) = %zu\n",
+                 vmsg->request, vmsg->size, sizeof(vmsg->payload));
+        goto fail;
+    }
+
+    if (vmsg->size) {
+        do {
+            rc = read(conn_fd, &vmsg->payload, vmsg->size);
+        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+        if (rc <= 0) {
+            vu_panic(dev, "Error while reading: %s", strerror(errno));
+            goto fail;
+        }
+
+        assert(rc == vmsg->size);
+    }
+
+    return true;
+
+fail:
+    vmsg_close_fds(vmsg);
+
+    return false;
+}
+
+static bool
+vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    int rc;
+    uint8_t *p = (uint8_t *)vmsg;
+    char control[CMSG_SPACE(VHOST_MEMORY_BASELINE_NREGIONS * sizeof(int))] = {};
+    struct iovec iov = {
+        .iov_base = (char *)vmsg,
+        .iov_len = VHOST_USER_HDR_SIZE,
+    };
+    struct msghdr msg = {
+        .msg_iov = &iov,
+        .msg_iovlen = 1,
+        .msg_control = control,
+    };
+    struct cmsghdr *cmsg;
+
+    memset(control, 0, sizeof(control));
+    assert(vmsg->fd_num <= VHOST_MEMORY_BASELINE_NREGIONS);
+    if (vmsg->fd_num > 0) {
+        size_t fdsize = vmsg->fd_num * sizeof(int);
+        msg.msg_controllen = CMSG_SPACE(fdsize);
+        cmsg = CMSG_FIRSTHDR(&msg);
+        cmsg->cmsg_len = CMSG_LEN(fdsize);
+        cmsg->cmsg_level = SOL_SOCKET;
+        cmsg->cmsg_type = SCM_RIGHTS;
+        memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
+    } else {
+        msg.msg_controllen = 0;
+    }
+
+    do {
+        rc = sendmsg(conn_fd, &msg, 0);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+
+    if (vmsg->size) {
+        do {
+            if (vmsg->data) {
+                rc = write(conn_fd, vmsg->data, vmsg->size);
+            } else {
+                rc = write(conn_fd, p + VHOST_USER_HDR_SIZE, vmsg->size);
+            }
+        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+    }
+
+    if (rc <= 0) {
+        vu_panic(dev, "Error while writing: %s", strerror(errno));
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    /* Set the version in the flags when sending the reply */
+    vmsg->flags &= ~VHOST_USER_VERSION_MASK;
+    vmsg->flags |= VHOST_USER_VERSION;
+    vmsg->flags |= VHOST_USER_REPLY_MASK;
+
+    return vu_message_write(dev, conn_fd, vmsg);
+}
+
+/*
+ * Processes a reply on the slave channel.
+ * Entered with slave_mutex held and releases it before exit.
+ * Returns true on success.
+ */
+static bool
+vu_process_message_reply(VuDev *dev, const VhostUserMsg *vmsg)
+{
+    VhostUserMsg msg_reply;
+    bool result = false;
+
+    if ((vmsg->flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
+        result = true;
+        goto out;
+    }
+
+    if (!vu_message_read_default(dev, dev->slave_fd, &msg_reply)) {
+        goto out;
+    }
+
+    if (msg_reply.request != vmsg->request) {
+        DPRINT("Received unexpected msg type. Expected %d received %d",
+               vmsg->request, msg_reply.request);
+        goto out;
+    }
+
+    result = msg_reply.payload.u64 == 0;
+
+out:
+    pthread_mutex_unlock(&dev->slave_mutex);
+    return result;
+}
+
+/* Kick the log_call_fd if required. */
+static void
+vu_log_kick(VuDev *dev)
+{
+    if (dev->log_call_fd != -1) {
+        DPRINT("Kicking the QEMU's log...\n");
+        if (eventfd_write(dev->log_call_fd, 1) < 0) {
+            vu_panic(dev, "Error writing eventfd: %s", strerror(errno));
+        }
+    }
+}
+
+static void
+vu_log_page(uint8_t *log_table, uint64_t page)
+{
+    DPRINT("Logged dirty guest page: %"PRId64"\n", page);
+    qatomic_or(&log_table[page / 8], 1 << (page % 8));
+}
+
+static void
+vu_log_write(VuDev *dev, uint64_t address, uint64_t length)
+{
+    uint64_t page;
+
+    if (!(dev->features & (1ULL << VHOST_F_LOG_ALL)) ||
+        !dev->log_table || !length) {
+        return;
+    }
+
+    assert(dev->log_size > ((address + length - 1) / VHOST_LOG_PAGE / 8));
+
+    page = address / VHOST_LOG_PAGE;
+    while (page * VHOST_LOG_PAGE < address + length) {
+        vu_log_page(dev->log_table, page);
+        page += 1;
+    }
+
+    vu_log_kick(dev);
+}
+
+static void
+vu_kick_cb(VuDev *dev, int condition, void *data)
+{
+    int index = (intptr_t)data;
+    VuVirtq *vq = &dev->vq[index];
+    int sock = vq->kick_fd;
+    eventfd_t kick_data;
+    ssize_t rc;
+
+    rc = eventfd_read(sock, &kick_data);
+    if (rc == -1) {
+        vu_panic(dev, "kick eventfd_read(): %s", strerror(errno));
+        dev->remove_watch(dev, dev->vq[index].kick_fd);
+    } else {
+        DPRINT("Got kick_data: %016"PRIx64" handler:%p idx:%d\n",
+               kick_data, vq->handler, index);
+        if (vq->handler) {
+            vq->handler(dev, index);
+        }
+    }
+}
+
+static bool
+vu_get_features_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    vmsg->payload.u64 =
+        /*
+         * The following VIRTIO feature bits are supported by our virtqueue
+         * implementation:
+         */
+        1ULL << VIRTIO_F_NOTIFY_ON_EMPTY |
+        1ULL << VIRTIO_RING_F_INDIRECT_DESC |
+        1ULL << VIRTIO_RING_F_EVENT_IDX |
+        1ULL << VIRTIO_F_VERSION_1 |
+
+        /* vhost-user feature bits */
+        1ULL << VHOST_F_LOG_ALL |
+        1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
+
+    if (dev->iface->get_features) {
+        vmsg->payload.u64 |= dev->iface->get_features(dev);
+    }
+
+    vmsg->size = sizeof(vmsg->payload.u64);
+    vmsg->fd_num = 0;
+
+    DPRINT("Sending back to guest u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
+
+    return true;
+}
+
+static void
+vu_set_enable_all_rings(VuDev *dev, bool enabled)
+{
+    uint16_t i;
+
+    for (i = 0; i < dev->max_queues; i++) {
+        dev->vq[i].enable = enabled;
+    }
+}
+
+static bool
+vu_set_features_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
+
+    dev->features = vmsg->payload.u64;
+    if (!vu_has_feature(dev, VIRTIO_F_VERSION_1)) {
+        /*
+         * We only support devices conforming to VIRTIO 1.0 or
+         * later
+         */
+        vu_panic(dev, "virtio legacy devices aren't supported by libvhost-user");
+        return false;
+    }
+
+    if (!(dev->features & VHOST_USER_F_PROTOCOL_FEATURES)) {
+        vu_set_enable_all_rings(dev, true);
+    }
+
+    if (dev->iface->set_features) {
+        dev->iface->set_features(dev, dev->features);
+    }
+
+    return false;
+}
+
+static bool
+vu_set_owner_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    return false;
+}
+
+static void
+vu_close_log(VuDev *dev)
+{
+    if (dev->log_table) {
+        if (munmap(dev->log_table, dev->log_size) != 0) {
+            perror("close log munmap() error");
+        }
+
+        dev->log_table = NULL;
+    }
+    if (dev->log_call_fd != -1) {
+        close(dev->log_call_fd);
+        dev->log_call_fd = -1;
+    }
+}
+
+static bool
+vu_reset_device_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    vu_set_enable_all_rings(dev, false);
+
+    return false;
+}
+
+static bool
+map_ring(VuDev *dev, VuVirtq *vq)
+{
+    vq->vring.desc = qva_to_va(dev, vq->vra.desc_user_addr);
+    vq->vring.used = qva_to_va(dev, vq->vra.used_user_addr);
+    vq->vring.avail = qva_to_va(dev, vq->vra.avail_user_addr);
+
+    DPRINT("Setting virtq addresses:\n");
+    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
+    DPRINT("    vring_used  at %p\n", vq->vring.used);
+    DPRINT("    vring_avail at %p\n", vq->vring.avail);
+
+    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
+}
+
+static bool
+generate_faults(VuDev *dev) {
+    int i;
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *dev_region = &dev->regions[i];
+        int ret;
+#ifdef UFFDIO_REGISTER
+        /*
+         * We should already have an open ufd. Mark each memory
+         * range as ufd.
+         * Discard any mapping we have here; note I can't use MADV_REMOVE
+         * or fallocate to make the hole since I don't want to lose
+         * data that's already arrived in the shared process.
+         * TODO: How to do hugepage
+         */
+        ret = madvise((void *)(uintptr_t)dev_region->mmap_addr,
+                      dev_region->size + dev_region->mmap_offset,
+                      MADV_DONTNEED);
+        if (ret) {
+            fprintf(stderr,
+                    "%s: Failed to madvise(DONTNEED) region %d: %s\n",
+                    __func__, i, strerror(errno));
+        }
+        /*
+         * Turn off transparent hugepages so we dont get lose wakeups
+         * in neighbouring pages.
+         * TODO: Turn this backon later.
+         */
+        ret = madvise((void *)(uintptr_t)dev_region->mmap_addr,
+                      dev_region->size + dev_region->mmap_offset,
+                      MADV_NOHUGEPAGE);
+        if (ret) {
+            /*
+             * Note: This can happen legally on kernels that are configured
+             * without madvise'able hugepages
+             */
+            fprintf(stderr,
+                    "%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n",
+                    __func__, i, strerror(errno));
+        }
+        struct uffdio_register reg_struct;
+        reg_struct.range.start = (uintptr_t)dev_region->mmap_addr;
+        reg_struct.range.len = dev_region->size + dev_region->mmap_offset;
+        reg_struct.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+        if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
+            vu_panic(dev, "%s: Failed to userfault region %d "
+                          "@%p + size:%zx offset: %zx: (ufd=%d)%s\n",
+                     __func__, i,
+                     dev_region->mmap_addr,
+                     dev_region->size, dev_region->mmap_offset,
+                     dev->postcopy_ufd, strerror(errno));
+            return false;
+        }
+        if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
+            vu_panic(dev, "%s Region (%d) doesn't support COPY",
+                     __func__, i);
+            return false;
+        }
+        DPRINT("%s: region %d: Registered userfault for %"
+               PRIx64 " + %" PRIx64 "\n", __func__, i,
+               (uint64_t)reg_struct.range.start,
+               (uint64_t)reg_struct.range.len);
+        /* Now it's registered we can let the client at it */
+        if (mprotect((void *)(uintptr_t)dev_region->mmap_addr,
+                     dev_region->size + dev_region->mmap_offset,
+                     PROT_READ | PROT_WRITE)) {
+            vu_panic(dev, "failed to mprotect region %d for postcopy (%s)",
+                     i, strerror(errno));
+            return false;
+        }
+        /* TODO: Stash 'zero' support flags somewhere */
+#endif
+    }
+
+    return true;
+}
+
+static bool
+vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
+    int i;
+    bool track_ramblocks = dev->postcopy_listening;
+    VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
+    VuDevRegion *dev_region = &dev->regions[dev->nregions];
+    void *mmap_addr;
+
+    /*
+     * If we are in postcopy mode and we receive a u64 payload with a 0 value
+     * we know all the postcopy client bases have been received, and we
+     * should start generating faults.
+     */
+    if (track_ramblocks &&
+        vmsg->size == sizeof(vmsg->payload.u64) &&
+        vmsg->payload.u64 == 0) {
+        (void)generate_faults(dev);
+        return false;
+    }
+
+    DPRINT("Adding region: %u\n", dev->nregions);
+    DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
+           msg_region->guest_phys_addr);
+    DPRINT("    memory_size:     0x%016"PRIx64"\n",
+           msg_region->memory_size);
+    DPRINT("    userspace_addr   0x%016"PRIx64"\n",
+           msg_region->userspace_addr);
+    DPRINT("    mmap_offset      0x%016"PRIx64"\n",
+           msg_region->mmap_offset);
+
+    dev_region->gpa = msg_region->guest_phys_addr;
+    dev_region->size = msg_region->memory_size;
+    dev_region->qva = msg_region->userspace_addr;
+    dev_region->mmap_offset = msg_region->mmap_offset;
+
+    /*
+     * We don't use offset argument of mmap() since the
+     * mapped address has to be page aligned, and we use huge
+     * pages.
+     */
+    if (track_ramblocks) {
+        /*
+         * In postcopy we're using PROT_NONE here to catch anyone
+         * accessing it before we userfault.
+         */
+        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
+                         PROT_NONE, MAP_SHARED,
+                         vmsg->fds[0], 0);
+    } else {
+        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
+                         PROT_READ | PROT_WRITE, MAP_SHARED, vmsg->fds[0],
+                         0);
+    }
+
+    if (mmap_addr == MAP_FAILED) {
+        vu_panic(dev, "region mmap error: %s", strerror(errno));
+    } else {
+        dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
+        DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
+               dev_region->mmap_addr);
+    }
+
+    close(vmsg->fds[0]);
+
+    if (track_ramblocks) {
+        /*
+         * Return the address to QEMU so that it can translate the ufd
+         * fault addresses back.
+         */
+        msg_region->userspace_addr = (uintptr_t)(mmap_addr +
+                                                 dev_region->mmap_offset);
+
+        /* Send the message back to qemu with the addresses filled in. */
+        vmsg->fd_num = 0;
+        if (!vu_send_reply(dev, dev->sock, vmsg)) {
+            vu_panic(dev, "failed to respond to add-mem-region for postcopy");
+            return false;
+        }
+
+        DPRINT("Successfully added new region in postcopy\n");
+        dev->nregions++;
+        return false;
+
+    } else {
+        for (i = 0; i < dev->max_queues; i++) {
+            if (dev->vq[i].vring.desc) {
+                if (map_ring(dev, &dev->vq[i])) {
+                    vu_panic(dev, "remapping queue %d for new memory region",
+                             i);
+                }
+            }
+        }
+
+        DPRINT("Successfully added new region\n");
+        dev->nregions++;
+        vmsg_set_reply_u64(vmsg, 0);
+        return true;
+    }
+}
+
+static inline bool reg_equal(VuDevRegion *vudev_reg,
+                             VhostUserMemoryRegion *msg_reg)
+{
+    if (vudev_reg->gpa == msg_reg->guest_phys_addr &&
+        vudev_reg->qva == msg_reg->userspace_addr &&
+        vudev_reg->size == msg_reg->memory_size) {
+        return true;
+    }
+
+    return false;
+}
+
+static bool
+vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
+    int i, j;
+    bool found = false;
+    VuDevRegion shadow_regions[VHOST_USER_MAX_RAM_SLOTS] = {};
+    VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
+
+    DPRINT("Removing region:\n");
+    DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
+           msg_region->guest_phys_addr);
+    DPRINT("    memory_size:     0x%016"PRIx64"\n",
+           msg_region->memory_size);
+    DPRINT("    userspace_addr   0x%016"PRIx64"\n",
+           msg_region->userspace_addr);
+    DPRINT("    mmap_offset      0x%016"PRIx64"\n",
+           msg_region->mmap_offset);
+
+    for (i = 0, j = 0; i < dev->nregions; i++) {
+        if (!reg_equal(&dev->regions[i], msg_region)) {
+            shadow_regions[j].gpa = dev->regions[i].gpa;
+            shadow_regions[j].size = dev->regions[i].size;
+            shadow_regions[j].qva = dev->regions[i].qva;
+            shadow_regions[j].mmap_addr = dev->regions[i].mmap_addr;
+            shadow_regions[j].mmap_offset = dev->regions[i].mmap_offset;
+            j++;
+        } else {
+            found = true;
+            VuDevRegion *r = &dev->regions[i];
+            void *m = (void *) (uintptr_t) r->mmap_addr;
+
+            if (m) {
+                munmap(m, r->size + r->mmap_offset);
+            }
+        }
+    }
+
+    if (found) {
+        memcpy(dev->regions, shadow_regions,
+               sizeof(VuDevRegion) * VHOST_USER_MAX_RAM_SLOTS);
+        DPRINT("Successfully removed a region\n");
+        dev->nregions--;
+        vmsg_set_reply_u64(vmsg, 0);
+    } else {
+        vu_panic(dev, "Specified region not found\n");
+    }
+
+    return true;
+}
+
+static bool
+vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int i;
+    VhostUserMemory m = vmsg->payload.memory, *memory = &m;
+    dev->nregions = memory->nregions;
+
+    DPRINT("Nregions: %u\n", memory->nregions);
+    for (i = 0; i < dev->nregions; i++) {
+        void *mmap_addr;
+        VhostUserMemoryRegion *msg_region = &memory->regions[i];
+        VuDevRegion *dev_region = &dev->regions[i];
+
+        DPRINT("Region %d\n", i);
+        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
+               msg_region->guest_phys_addr);
+        DPRINT("    memory_size:     0x%016"PRIx64"\n",
+               msg_region->memory_size);
+        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
+               msg_region->userspace_addr);
+        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
+               msg_region->mmap_offset);
+
+        dev_region->gpa = msg_region->guest_phys_addr;
+        dev_region->size = msg_region->memory_size;
+        dev_region->qva = msg_region->userspace_addr;
+        dev_region->mmap_offset = msg_region->mmap_offset;
+
+        /* We don't use offset argument of mmap() since the
+         * mapped address has to be page aligned, and we use huge
+         * pages.
+         * In postcopy we're using PROT_NONE here to catch anyone
+         * accessing it before we userfault
+         */
+        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
+                         PROT_NONE, MAP_SHARED,
+                         vmsg->fds[i], 0);
+
+        if (mmap_addr == MAP_FAILED) {
+            vu_panic(dev, "region mmap error: %s", strerror(errno));
+        } else {
+            dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
+            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
+                   dev_region->mmap_addr);
+        }
+
+        /* Return the address to QEMU so that it can translate the ufd
+         * fault addresses back.
+         */
+        msg_region->userspace_addr = (uintptr_t)(mmap_addr +
+                                                 dev_region->mmap_offset);
+        close(vmsg->fds[i]);
+    }
+
+    /* Send the message back to qemu with the addresses filled in */
+    vmsg->fd_num = 0;
+    if (!vu_send_reply(dev, dev->sock, vmsg)) {
+        vu_panic(dev, "failed to respond to set-mem-table for postcopy");
+        return false;
+    }
+
+    /* Wait for QEMU to confirm that it's registered the handler for the
+     * faults.
+     */
+    if (!dev->read_msg(dev, dev->sock, vmsg) ||
+        vmsg->size != sizeof(vmsg->payload.u64) ||
+        vmsg->payload.u64 != 0) {
+        vu_panic(dev, "failed to receive valid ack for postcopy set-mem-table");
+        return false;
+    }
+
+    /* OK, now we can go and register the memory and generate faults */
+    (void)generate_faults(dev);
+
+    return false;
+}
+
+static bool
+vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int i;
+    VhostUserMemory m = vmsg->payload.memory, *memory = &m;
+
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *r = &dev->regions[i];
+        void *m = (void *) (uintptr_t) r->mmap_addr;
+
+        if (m) {
+            munmap(m, r->size + r->mmap_offset);
+        }
+    }
+    dev->nregions = memory->nregions;
+
+    if (dev->postcopy_listening) {
+        return vu_set_mem_table_exec_postcopy(dev, vmsg);
+    }
+
+    DPRINT("Nregions: %u\n", memory->nregions);
+    for (i = 0; i < dev->nregions; i++) {
+        void *mmap_addr;
+        VhostUserMemoryRegion *msg_region = &memory->regions[i];
+        VuDevRegion *dev_region = &dev->regions[i];
+
+        DPRINT("Region %d\n", i);
+        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
+               msg_region->guest_phys_addr);
+        DPRINT("    memory_size:     0x%016"PRIx64"\n",
+               msg_region->memory_size);
+        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
+               msg_region->userspace_addr);
+        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
+               msg_region->mmap_offset);
+
+        dev_region->gpa = msg_region->guest_phys_addr;
+        dev_region->size = msg_region->memory_size;
+        dev_region->qva = msg_region->userspace_addr;
+        dev_region->mmap_offset = msg_region->mmap_offset;
+
+        /* We don't use offset argument of mmap() since the
+         * mapped address has to be page aligned, and we use huge
+         * pages.  */
+        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
+                         PROT_READ | PROT_WRITE, MAP_SHARED,
+                         vmsg->fds[i], 0);
+
+        if (mmap_addr == MAP_FAILED) {
+            vu_panic(dev, "region mmap error: %s", strerror(errno));
+        } else {
+            dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
+            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
+                   dev_region->mmap_addr);
+        }
+
+        close(vmsg->fds[i]);
+    }
+
+    for (i = 0; i < dev->max_queues; i++) {
+        if (dev->vq[i].vring.desc) {
+            if (map_ring(dev, &dev->vq[i])) {
+                vu_panic(dev, "remapping queue %d during setmemtable", i);
+            }
+        }
+    }
+
+    return false;
+}
+
+static bool
+vu_set_log_base_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int fd;
+    uint64_t log_mmap_size, log_mmap_offset;
+    void *rc;
+
+    if (vmsg->fd_num != 1 ||
+        vmsg->size != sizeof(vmsg->payload.log)) {
+        vu_panic(dev, "Invalid log_base message");
+        return true;
+    }
+
+    fd = vmsg->fds[0];
+    log_mmap_offset = vmsg->payload.log.mmap_offset;
+    log_mmap_size = vmsg->payload.log.mmap_size;
+    DPRINT("Log mmap_offset: %"PRId64"\n", log_mmap_offset);
+    DPRINT("Log mmap_size:   %"PRId64"\n", log_mmap_size);
+
+    rc = mmap(0, log_mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+              log_mmap_offset);
+    close(fd);
+    if (rc == MAP_FAILED) {
+        perror("log mmap error");
+    }
+
+    if (dev->log_table) {
+        munmap(dev->log_table, dev->log_size);
+    }
+    dev->log_table = rc;
+    dev->log_size = log_mmap_size;
+
+    vmsg->size = sizeof(vmsg->payload.u64);
+    vmsg->fd_num = 0;
+
+    return true;
+}
+
+static bool
+vu_set_log_fd_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    if (vmsg->fd_num != 1) {
+        vu_panic(dev, "Invalid log_fd message");
+        return false;
+    }
+
+    if (dev->log_call_fd != -1) {
+        close(dev->log_call_fd);
+    }
+    dev->log_call_fd = vmsg->fds[0];
+    DPRINT("Got log_call_fd: %d\n", vmsg->fds[0]);
+
+    return false;
+}
+
+static bool
+vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index = vmsg->payload.state.index;
+    unsigned int num = vmsg->payload.state.num;
+
+    DPRINT("State.index: %u\n", index);
+    DPRINT("State.num:   %u\n", num);
+    dev->vq[index].vring.num = num;
+
+    return false;
+}
+
+static bool
+vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    struct vhost_vring_addr addr = vmsg->payload.addr, *vra = &addr;
+    unsigned int index = vra->index;
+    VuVirtq *vq = &dev->vq[index];
+
+    DPRINT("vhost_vring_addr:\n");
+    DPRINT("    index:  %d\n", vra->index);
+    DPRINT("    flags:  %d\n", vra->flags);
+    DPRINT("    desc_user_addr:   0x%016" PRIx64 "\n", (uint64_t)vra->desc_user_addr);
+    DPRINT("    used_user_addr:   0x%016" PRIx64 "\n", (uint64_t)vra->used_user_addr);
+    DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", (uint64_t)vra->avail_user_addr);
+    DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", (uint64_t)vra->log_guest_addr);
+
+    vq->vra = *vra;
+    vq->vring.flags = vra->flags;
+    vq->vring.log_guest_addr = vra->log_guest_addr;
+
+
+    if (map_ring(dev, vq)) {
+        vu_panic(dev, "Invalid vring_addr message");
+        return false;
+    }
+
+    vq->used_idx = le16toh(vq->vring.used->idx);
+
+    if (vq->last_avail_idx != vq->used_idx) {
+        bool resume = dev->iface->queue_is_processed_in_order &&
+            dev->iface->queue_is_processed_in_order(dev, index);
+
+        DPRINT("Last avail index != used index: %u != %u%s\n",
+               vq->last_avail_idx, vq->used_idx,
+               resume ? ", resuming" : "");
+
+        if (resume) {
+            vq->shadow_avail_idx = vq->last_avail_idx = vq->used_idx;
+        }
+    }
+
+    return false;
+}
+
+static bool
+vu_set_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index = vmsg->payload.state.index;
+    unsigned int num = vmsg->payload.state.num;
+
+    DPRINT("State.index: %u\n", index);
+    DPRINT("State.num:   %u\n", num);
+    dev->vq[index].shadow_avail_idx = dev->vq[index].last_avail_idx = num;
+
+    return false;
+}
+
+static bool
+vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index = vmsg->payload.state.index;
+
+    DPRINT("State.index: %u\n", index);
+    vmsg->payload.state.num = dev->vq[index].last_avail_idx;
+    vmsg->size = sizeof(vmsg->payload.state);
+
+    dev->vq[index].started = false;
+    if (dev->iface->queue_set_started) {
+        dev->iface->queue_set_started(dev, index, false);
+    }
+
+    if (dev->vq[index].call_fd != -1) {
+        close(dev->vq[index].call_fd);
+        dev->vq[index].call_fd = -1;
+    }
+    if (dev->vq[index].kick_fd != -1) {
+        dev->remove_watch(dev, dev->vq[index].kick_fd);
+        close(dev->vq[index].kick_fd);
+        dev->vq[index].kick_fd = -1;
+    }
+
+    return true;
+}
+
+static bool
+vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
+
+    if (index >= dev->max_queues) {
+        vmsg_close_fds(vmsg);
+        vu_panic(dev, "Invalid queue index: %u", index);
+        return false;
+    }
+
+    if (nofd) {
+        vmsg_close_fds(vmsg);
+        return true;
+    }
+
+    if (vmsg->fd_num != 1) {
+        vmsg_close_fds(vmsg);
+        vu_panic(dev, "Invalid fds in request: %d", vmsg->request);
+        return false;
+    }
+
+    return true;
+}
+
+static int
+inflight_desc_compare(const void *a, const void *b)
+{
+    VuVirtqInflightDesc *desc0 = (VuVirtqInflightDesc *)a,
+                        *desc1 = (VuVirtqInflightDesc *)b;
+
+    if (desc1->counter > desc0->counter &&
+        (desc1->counter - desc0->counter) < VIRTQUEUE_MAX_SIZE * 2) {
+        return 1;
+    }
+
+    return -1;
+}
+
+static int
+vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
+{
+    int i = 0;
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight)) {
+        return -1;
+    }
+
+    if (unlikely(!vq->inflight->version)) {
+        /* initialize the buffer */
+        vq->inflight->version = INFLIGHT_VERSION;
+        return 0;
+    }
+
+    vq->used_idx = le16toh(vq->vring.used->idx);
+    vq->resubmit_num = 0;
+    vq->resubmit_list = NULL;
+    vq->counter = 0;
+
+    if (unlikely(vq->inflight->used_idx != vq->used_idx)) {
+        vq->inflight->desc[vq->inflight->last_batch_head].inflight = 0;
+
+        barrier();
+
+        vq->inflight->used_idx = vq->used_idx;
+    }
+
+    for (i = 0; i < vq->inflight->desc_num; i++) {
+        if (vq->inflight->desc[i].inflight == 1) {
+            vq->inuse++;
+        }
+    }
+
+    vq->shadow_avail_idx = vq->last_avail_idx = vq->inuse + vq->used_idx;
+
+    if (vq->inuse) {
+        vq->resubmit_list = calloc(vq->inuse, sizeof(VuVirtqInflightDesc));
+        if (!vq->resubmit_list) {
+            return -1;
+        }
+
+        for (i = 0; i < vq->inflight->desc_num; i++) {
+            if (vq->inflight->desc[i].inflight) {
+                vq->resubmit_list[vq->resubmit_num].index = i;
+                vq->resubmit_list[vq->resubmit_num].counter =
+                                        vq->inflight->desc[i].counter;
+                vq->resubmit_num++;
+            }
+        }
+
+        if (vq->resubmit_num > 1) {
+            qsort(vq->resubmit_list, vq->resubmit_num,
+                  sizeof(VuVirtqInflightDesc), inflight_desc_compare);
+        }
+        vq->counter = vq->resubmit_list[0].counter + 1;
+    }
+
+    /* in case of I/O hang after reconnecting */
+    if (eventfd_write(vq->kick_fd, 1)) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static bool
+vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
+
+    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
+
+    if (!vu_check_queue_msg_file(dev, vmsg)) {
+        return false;
+    }
+
+    if (dev->vq[index].kick_fd != -1) {
+        dev->remove_watch(dev, dev->vq[index].kick_fd);
+        close(dev->vq[index].kick_fd);
+        dev->vq[index].kick_fd = -1;
+    }
+
+    dev->vq[index].kick_fd = nofd ? -1 : vmsg->fds[0];
+    DPRINT("Got kick_fd: %d for vq: %d\n", dev->vq[index].kick_fd, index);
+
+    dev->vq[index].started = true;
+    if (dev->iface->queue_set_started) {
+        dev->iface->queue_set_started(dev, index, true);
+    }
+
+    if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
+        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
+                       vu_kick_cb, (void *)(long)index);
+
+        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
+               dev->vq[index].kick_fd, index);
+    }
+
+    if (vu_check_queue_inflights(dev, &dev->vq[index])) {
+        vu_panic(dev, "Failed to check inflights for vq: %d\n", index);
+    }
+
+    return false;
+}
+
+void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
+                          vu_queue_handler_cb handler)
+{
+    int qidx = vq - dev->vq;
+
+    vq->handler = handler;
+    if (vq->kick_fd >= 0) {
+        if (handler) {
+            dev->set_watch(dev, vq->kick_fd, VU_WATCH_IN,
+                           vu_kick_cb, (void *)(long)qidx);
+        } else {
+            dev->remove_watch(dev, vq->kick_fd);
+        }
+    }
+}
+
+bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
+                                int size, int offset)
+{
+    int qidx = vq - dev->vq;
+    int fd_num = 0;
+    VhostUserMsg vmsg = {
+        .request = VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG,
+        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+        .size = sizeof(vmsg.payload.area),
+        .payload.area = {
+            .u64 = qidx & VHOST_USER_VRING_IDX_MASK,
+            .size = size,
+            .offset = offset,
+        },
+    };
+
+    if (fd == -1) {
+        vmsg.payload.area.u64 |= VHOST_USER_VRING_NOFD_MASK;
+    } else {
+        vmsg.fds[fd_num++] = fd;
+    }
+
+    vmsg.fd_num = fd_num;
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) {
+        return false;
+    }
+
+    pthread_mutex_lock(&dev->slave_mutex);
+    if (!vu_message_write(dev, dev->slave_fd, &vmsg)) {
+        pthread_mutex_unlock(&dev->slave_mutex);
+        return false;
+    }
+
+    /* Also unlocks the slave_mutex */
+    return vu_process_message_reply(dev, &vmsg);
+}
+
+static bool
+vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
+
+    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
+
+    if (!vu_check_queue_msg_file(dev, vmsg)) {
+        return false;
+    }
+
+    if (dev->vq[index].call_fd != -1) {
+        close(dev->vq[index].call_fd);
+        dev->vq[index].call_fd = -1;
+    }
+
+    dev->vq[index].call_fd = nofd ? -1 : vmsg->fds[0];
+
+    /* in case of I/O hang after reconnecting */
+    if (dev->vq[index].call_fd != -1 && eventfd_write(vmsg->fds[0], 1)) {
+        return -1;
+    }
+
+    DPRINT("Got call_fd: %d for vq: %d\n", dev->vq[index].call_fd, index);
+
+    return false;
+}
+
+static bool
+vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
+
+    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
+
+    if (!vu_check_queue_msg_file(dev, vmsg)) {
+        return false;
+    }
+
+    if (dev->vq[index].err_fd != -1) {
+        close(dev->vq[index].err_fd);
+        dev->vq[index].err_fd = -1;
+    }
+
+    dev->vq[index].err_fd = nofd ? -1 : vmsg->fds[0];
+
+    return false;
+}
+
+static bool
+vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    /*
+     * Note that we support, but intentionally do not set,
+     * VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. This means that
+     * a device implementation can return it in its callback
+     * (get_protocol_features) if it wants to use this for
+     * simulation, but it is otherwise not desirable (if even
+     * implemented by the master.)
+     */
+    uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_MQ |
+                        1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
+                        1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ |
+                        1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER |
+                        1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD |
+                        1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK |
+                        1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS;
+
+    if (have_userfault()) {
+        features |= 1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT;
+    }
+
+    if (dev->iface->get_config && dev->iface->set_config) {
+        features |= 1ULL << VHOST_USER_PROTOCOL_F_CONFIG;
+    }
+
+    if (dev->iface->get_protocol_features) {
+        features |= dev->iface->get_protocol_features(dev);
+    }
+
+    vmsg_set_reply_u64(vmsg, features);
+    return true;
+}
+
+static bool
+vu_set_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    uint64_t features = vmsg->payload.u64;
+
+    DPRINT("u64: 0x%016"PRIx64"\n", features);
+
+    dev->protocol_features = vmsg->payload.u64;
+
+    if (vu_has_protocol_feature(dev,
+                                VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS) &&
+        (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SLAVE_REQ) ||
+         !vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
+        /*
+         * The use case for using messages for kick/call is simulation, to make
+         * the kick and call synchronous. To actually get that behaviour, both
+         * of the other features are required.
+         * Theoretically, one could use only kick messages, or do them without
+         * having F_REPLY_ACK, but too many (possibly pending) messages on the
+         * socket will eventually cause the master to hang, to avoid this in
+         * scenarios where not desired enforce that the settings are in a way
+         * that actually enables the simulation case.
+         */
+        vu_panic(dev,
+                 "F_IN_BAND_NOTIFICATIONS requires F_SLAVE_REQ && F_REPLY_ACK");
+        return false;
+    }
+
+    if (dev->iface->set_protocol_features) {
+        dev->iface->set_protocol_features(dev, features);
+    }
+
+    return false;
+}
+
+static bool
+vu_get_queue_num_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    vmsg_set_reply_u64(vmsg, dev->max_queues);
+    return true;
+}
+
+static bool
+vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index = vmsg->payload.state.index;
+    unsigned int enable = vmsg->payload.state.num;
+
+    DPRINT("State.index: %u\n", index);
+    DPRINT("State.enable:   %u\n", enable);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_enable index: %u", index);
+        return false;
+    }
+
+    dev->vq[index].enable = enable;
+    return false;
+}
+
+static bool
+vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)
+{
+    if (vmsg->fd_num != 1) {
+        vu_panic(dev, "Invalid slave_req_fd message (%d fd's)", vmsg->fd_num);
+        return false;
+    }
+
+    if (dev->slave_fd != -1) {
+        close(dev->slave_fd);
+    }
+    dev->slave_fd = vmsg->fds[0];
+    DPRINT("Got slave_fd: %d\n", vmsg->fds[0]);
+
+    return false;
+}
+
+static bool
+vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int ret = -1;
+
+    if (dev->iface->get_config) {
+        ret = dev->iface->get_config(dev, vmsg->payload.config.region,
+                                     vmsg->payload.config.size);
+    }
+
+    if (ret) {
+        /* resize to zero to indicate an error to master */
+        vmsg->size = 0;
+    }
+
+    return true;
+}
+
+static bool
+vu_set_config(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int ret = -1;
+
+    if (dev->iface->set_config) {
+        ret = dev->iface->set_config(dev, vmsg->payload.config.region,
+                                     vmsg->payload.config.offset,
+                                     vmsg->payload.config.size,
+                                     vmsg->payload.config.flags);
+        if (ret) {
+            vu_panic(dev, "Set virtio configuration space failed");
+        }
+    }
+
+    return false;
+}
+
+static bool
+vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
+{
+    dev->postcopy_ufd = -1;
+#ifdef UFFDIO_API
+    struct uffdio_api api_struct;
+
+    dev->postcopy_ufd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+    vmsg->size = 0;
+#endif
+
+    if (dev->postcopy_ufd == -1) {
+        vu_panic(dev, "Userfaultfd not available: %s", strerror(errno));
+        goto out;
+    }
+
+#ifdef UFFDIO_API
+    api_struct.api = UFFD_API;
+    api_struct.features = 0;
+    if (ioctl(dev->postcopy_ufd, UFFDIO_API, &api_struct)) {
+        vu_panic(dev, "Failed UFFDIO_API: %s", strerror(errno));
+        close(dev->postcopy_ufd);
+        dev->postcopy_ufd = -1;
+        goto out;
+    }
+    /* TODO: Stash feature flags somewhere */
+#endif
+
+out:
+    /* Return a ufd to the QEMU */
+    vmsg->fd_num = 1;
+    vmsg->fds[0] = dev->postcopy_ufd;
+    return true; /* = send a reply */
+}
+
+static bool
+vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
+{
+    if (dev->nregions) {
+        vu_panic(dev, "Regions already registered at postcopy-listen");
+        vmsg_set_reply_u64(vmsg, -1);
+        return true;
+    }
+    dev->postcopy_listening = true;
+
+    vmsg_set_reply_u64(vmsg, 0);
+    return true;
+}
+
+static bool
+vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg)
+{
+    DPRINT("%s: Entry\n", __func__);
+    dev->postcopy_listening = false;
+    if (dev->postcopy_ufd > 0) {
+        close(dev->postcopy_ufd);
+        dev->postcopy_ufd = -1;
+        DPRINT("%s: Done close\n", __func__);
+    }
+
+    vmsg_set_reply_u64(vmsg, 0);
+    DPRINT("%s: exit\n", __func__);
+    return true;
+}
+
+static inline uint64_t
+vu_inflight_queue_size(uint16_t queue_size)
+{
+    return ALIGN_UP(sizeof(VuDescStateSplit) * queue_size +
+           sizeof(uint16_t), INFLIGHT_ALIGNMENT);
+}
+
+#ifdef MFD_ALLOW_SEALING
+static void *
+memfd_alloc(const char *name, size_t size, unsigned int flags, int *fd)
+{
+    void *ptr;
+    int ret;
+
+    *fd = memfd_create(name, MFD_ALLOW_SEALING);
+    if (*fd < 0) {
+        return NULL;
+    }
+
+    ret = ftruncate(*fd, size);
+    if (ret < 0) {
+        close(*fd);
+        return NULL;
+    }
+
+    ret = fcntl(*fd, F_ADD_SEALS, flags);
+    if (ret < 0) {
+        close(*fd);
+        return NULL;
+    }
+
+    ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, *fd, 0);
+    if (ptr == MAP_FAILED) {
+        close(*fd);
+        return NULL;
+    }
+
+    return ptr;
+}
+#endif
+
+static bool
+vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int fd = -1;
+    void *addr = NULL;
+    uint64_t mmap_size;
+    uint16_t num_queues, queue_size;
+
+    if (vmsg->size != sizeof(vmsg->payload.inflight)) {
+        vu_panic(dev, "Invalid get_inflight_fd message:%d", vmsg->size);
+        vmsg->payload.inflight.mmap_size = 0;
+        return true;
+    }
+
+    num_queues = vmsg->payload.inflight.num_queues;
+    queue_size = vmsg->payload.inflight.queue_size;
+
+    DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
+    DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
+
+    mmap_size = vu_inflight_queue_size(queue_size) * num_queues;
+
+#ifdef MFD_ALLOW_SEALING
+    addr = memfd_alloc("vhost-inflight", mmap_size,
+                       F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                       &fd);
+#else
+    vu_panic(dev, "Not implemented: memfd support is missing");
+#endif
+
+    if (!addr) {
+        vu_panic(dev, "Failed to alloc vhost inflight area");
+        vmsg->payload.inflight.mmap_size = 0;
+        return true;
+    }
+
+    memset(addr, 0, mmap_size);
+
+    dev->inflight_info.addr = addr;
+    dev->inflight_info.size = vmsg->payload.inflight.mmap_size = mmap_size;
+    dev->inflight_info.fd = vmsg->fds[0] = fd;
+    vmsg->fd_num = 1;
+    vmsg->payload.inflight.mmap_offset = 0;
+
+    DPRINT("send inflight mmap_size: %"PRId64"\n",
+           vmsg->payload.inflight.mmap_size);
+    DPRINT("send inflight mmap offset: %"PRId64"\n",
+           vmsg->payload.inflight.mmap_offset);
+
+    return true;
+}
+
+static bool
+vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int fd, i;
+    uint64_t mmap_size, mmap_offset;
+    uint16_t num_queues, queue_size;
+    void *rc;
+
+    if (vmsg->fd_num != 1 ||
+        vmsg->size != sizeof(vmsg->payload.inflight)) {
+        vu_panic(dev, "Invalid set_inflight_fd message size:%d fds:%d",
+                 vmsg->size, vmsg->fd_num);
+        return false;
+    }
+
+    fd = vmsg->fds[0];
+    mmap_size = vmsg->payload.inflight.mmap_size;
+    mmap_offset = vmsg->payload.inflight.mmap_offset;
+    num_queues = vmsg->payload.inflight.num_queues;
+    queue_size = vmsg->payload.inflight.queue_size;
+
+    DPRINT("set_inflight_fd mmap_size: %"PRId64"\n", mmap_size);
+    DPRINT("set_inflight_fd mmap_offset: %"PRId64"\n", mmap_offset);
+    DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
+    DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
+
+    rc = mmap(0, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+              fd, mmap_offset);
+
+    if (rc == MAP_FAILED) {
+        vu_panic(dev, "set_inflight_fd mmap error: %s", strerror(errno));
+        return false;
+    }
+
+    if (dev->inflight_info.fd) {
+        close(dev->inflight_info.fd);
+    }
+
+    if (dev->inflight_info.addr) {
+        munmap(dev->inflight_info.addr, dev->inflight_info.size);
+    }
+
+    dev->inflight_info.fd = fd;
+    dev->inflight_info.addr = rc;
+    dev->inflight_info.size = mmap_size;
+
+    for (i = 0; i < num_queues; i++) {
+        dev->vq[i].inflight = (VuVirtqInflight *)rc;
+        dev->vq[i].inflight->desc_num = queue_size;
+        rc = (void *)((char *)rc + vu_inflight_queue_size(queue_size));
+    }
+
+    return false;
+}
+
+static bool
+vu_handle_vring_kick(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index = vmsg->payload.state.index;
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid queue index: %u", index);
+        return false;
+    }
+
+    DPRINT("Got kick message: handler:%p idx:%u\n",
+           dev->vq[index].handler, index);
+
+    if (!dev->vq[index].started) {
+        dev->vq[index].started = true;
+
+        if (dev->iface->queue_set_started) {
+            dev->iface->queue_set_started(dev, index, true);
+        }
+    }
+
+    if (dev->vq[index].handler) {
+        dev->vq[index].handler(dev, index);
+    }
+
+    return false;
+}
+
+static bool vu_handle_get_max_memslots(VuDev *dev, VhostUserMsg *vmsg)
+{
+    vmsg->flags = VHOST_USER_REPLY_MASK | VHOST_USER_VERSION;
+    vmsg->size  = sizeof(vmsg->payload.u64);
+    vmsg->payload.u64 = VHOST_USER_MAX_RAM_SLOTS;
+    vmsg->fd_num = 0;
+
+    if (!vu_message_write(dev, dev->sock, vmsg)) {
+        vu_panic(dev, "Failed to send max ram slots: %s\n", strerror(errno));
+    }
+
+    DPRINT("u64: 0x%016"PRIx64"\n", (uint64_t) VHOST_USER_MAX_RAM_SLOTS);
+
+    return false;
+}
+
+static bool
+vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int do_reply = 0;
+
+    /* Print out generic part of the request. */
+    DPRINT("================ Vhost user message ================\n");
+    DPRINT("Request: %s (%d)\n", vu_request_to_string(vmsg->request),
+           vmsg->request);
+    DPRINT("Flags:   0x%x\n", vmsg->flags);
+    DPRINT("Size:    %u\n", vmsg->size);
+
+    if (vmsg->fd_num) {
+        int i;
+        DPRINT("Fds:");
+        for (i = 0; i < vmsg->fd_num; i++) {
+            DPRINT(" %d", vmsg->fds[i]);
+        }
+        DPRINT("\n");
+    }
+
+    if (dev->iface->process_msg &&
+        dev->iface->process_msg(dev, vmsg, &do_reply)) {
+        return do_reply;
+    }
+
+    switch (vmsg->request) {
+    case VHOST_USER_GET_FEATURES:
+        return vu_get_features_exec(dev, vmsg);
+    case VHOST_USER_SET_FEATURES:
+        return vu_set_features_exec(dev, vmsg);
+    case VHOST_USER_GET_PROTOCOL_FEATURES:
+        return vu_get_protocol_features_exec(dev, vmsg);
+    case VHOST_USER_SET_PROTOCOL_FEATURES:
+        return vu_set_protocol_features_exec(dev, vmsg);
+    case VHOST_USER_SET_OWNER:
+        return vu_set_owner_exec(dev, vmsg);
+    case VHOST_USER_RESET_OWNER:
+        return vu_reset_device_exec(dev, vmsg);
+    case VHOST_USER_SET_MEM_TABLE:
+        return vu_set_mem_table_exec(dev, vmsg);
+    case VHOST_USER_SET_LOG_BASE:
+        return vu_set_log_base_exec(dev, vmsg);
+    case VHOST_USER_SET_LOG_FD:
+        return vu_set_log_fd_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_NUM:
+        return vu_set_vring_num_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_ADDR:
+        return vu_set_vring_addr_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_BASE:
+        return vu_set_vring_base_exec(dev, vmsg);
+    case VHOST_USER_GET_VRING_BASE:
+        return vu_get_vring_base_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_KICK:
+        return vu_set_vring_kick_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_CALL:
+        return vu_set_vring_call_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_ERR:
+        return vu_set_vring_err_exec(dev, vmsg);
+    case VHOST_USER_GET_QUEUE_NUM:
+        return vu_get_queue_num_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_ENABLE:
+        return vu_set_vring_enable_exec(dev, vmsg);
+    case VHOST_USER_SET_SLAVE_REQ_FD:
+        return vu_set_slave_req_fd(dev, vmsg);
+    case VHOST_USER_GET_CONFIG:
+        return vu_get_config(dev, vmsg);
+    case VHOST_USER_SET_CONFIG:
+        return vu_set_config(dev, vmsg);
+    case VHOST_USER_NONE:
+        /* if you need processing before exit, override iface->process_msg */
+        exit(0);
+    case VHOST_USER_POSTCOPY_ADVISE:
+        return vu_set_postcopy_advise(dev, vmsg);
+    case VHOST_USER_POSTCOPY_LISTEN:
+        return vu_set_postcopy_listen(dev, vmsg);
+    case VHOST_USER_POSTCOPY_END:
+        return vu_set_postcopy_end(dev, vmsg);
+    case VHOST_USER_GET_INFLIGHT_FD:
+        return vu_get_inflight_fd(dev, vmsg);
+    case VHOST_USER_SET_INFLIGHT_FD:
+        return vu_set_inflight_fd(dev, vmsg);
+    case VHOST_USER_VRING_KICK:
+        return vu_handle_vring_kick(dev, vmsg);
+    case VHOST_USER_GET_MAX_MEM_SLOTS:
+        return vu_handle_get_max_memslots(dev, vmsg);
+    case VHOST_USER_ADD_MEM_REG:
+        return vu_add_mem_reg(dev, vmsg);
+    case VHOST_USER_REM_MEM_REG:
+        return vu_rem_mem_reg(dev, vmsg);
+    default:
+        vmsg_close_fds(vmsg);
+        vu_panic(dev, "Unhandled request: %d", vmsg->request);
+    }
+
+    return false;
+}
+
+bool
+vu_dispatch(VuDev *dev)
+{
+    VhostUserMsg vmsg = { 0, };
+    int reply_requested;
+    bool need_reply, success = false;
+
+    if (!dev->read_msg(dev, dev->sock, &vmsg)) {
+        goto end;
+    }
+
+    need_reply = vmsg.flags & VHOST_USER_NEED_REPLY_MASK;
+
+    reply_requested = vu_process_message(dev, &vmsg);
+    if (!reply_requested && need_reply) {
+        vmsg_set_reply_u64(&vmsg, 0);
+        reply_requested = 1;
+    }
+
+    if (!reply_requested) {
+        success = true;
+        goto end;
+    }
+
+    if (!vu_send_reply(dev, dev->sock, &vmsg)) {
+        goto end;
+    }
+
+    success = true;
+
+end:
+    free(vmsg.data);
+    return success;
+}
+
+void
+vu_deinit(VuDev *dev)
+{
+    int i;
+
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *r = &dev->regions[i];
+        void *m = (void *) (uintptr_t) r->mmap_addr;
+        if (m != MAP_FAILED) {
+            munmap(m, r->size + r->mmap_offset);
+        }
+    }
+    dev->nregions = 0;
+
+    for (i = 0; i < dev->max_queues; i++) {
+        VuVirtq *vq = &dev->vq[i];
+
+        if (vq->call_fd != -1) {
+            close(vq->call_fd);
+            vq->call_fd = -1;
+        }
+
+        if (vq->kick_fd != -1) {
+            dev->remove_watch(dev, vq->kick_fd);
+            close(vq->kick_fd);
+            vq->kick_fd = -1;
+        }
+
+        if (vq->err_fd != -1) {
+            close(vq->err_fd);
+            vq->err_fd = -1;
+        }
+
+        if (vq->resubmit_list) {
+            free(vq->resubmit_list);
+            vq->resubmit_list = NULL;
+        }
+
+        vq->inflight = NULL;
+    }
+
+    if (dev->inflight_info.addr) {
+        munmap(dev->inflight_info.addr, dev->inflight_info.size);
+        dev->inflight_info.addr = NULL;
+    }
+
+    if (dev->inflight_info.fd > 0) {
+        close(dev->inflight_info.fd);
+        dev->inflight_info.fd = -1;
+    }
+
+    vu_close_log(dev);
+    if (dev->slave_fd != -1) {
+        close(dev->slave_fd);
+        dev->slave_fd = -1;
+    }
+    pthread_mutex_destroy(&dev->slave_mutex);
+
+    if (dev->sock != -1) {
+        close(dev->sock);
+    }
+
+    free(dev->vq);
+    dev->vq = NULL;
+}
+
+bool
+vu_init(VuDev *dev,
+        uint16_t max_queues,
+        int socket,
+        vu_panic_cb panic,
+        vu_read_msg_cb read_msg,
+        vu_set_watch_cb set_watch,
+        vu_remove_watch_cb remove_watch,
+        const VuDevIface *iface)
+{
+    uint16_t i;
+
+    assert(max_queues > 0);
+    assert(socket >= 0);
+    assert(set_watch);
+    assert(remove_watch);
+    assert(iface);
+    assert(panic);
+
+    memset(dev, 0, sizeof(*dev));
+
+    dev->sock = socket;
+    dev->panic = panic;
+    dev->read_msg = read_msg ? read_msg : vu_message_read_default;
+    dev->set_watch = set_watch;
+    dev->remove_watch = remove_watch;
+    dev->iface = iface;
+    dev->log_call_fd = -1;
+    pthread_mutex_init(&dev->slave_mutex, NULL);
+    dev->slave_fd = -1;
+    dev->max_queues = max_queues;
+
+    dev->vq = malloc(max_queues * sizeof(dev->vq[0]));
+    if (!dev->vq) {
+        DPRINT("%s: failed to malloc virtqueues\n", __func__);
+        return false;
+    }
+
+    for (i = 0; i < max_queues; i++) {
+        dev->vq[i] = (VuVirtq) {
+            .call_fd = -1, .kick_fd = -1, .err_fd = -1,
+            .notification = true,
+        };
+    }
+
+    return true;
+}
+
+VuVirtq *
+vu_get_queue(VuDev *dev, int qidx)
+{
+    assert(qidx < dev->max_queues);
+    return &dev->vq[qidx];
+}
+
+bool
+vu_queue_enabled(VuDev *dev, VuVirtq *vq)
+{
+    return vq->enable;
+}
+
+bool
+vu_queue_started(const VuDev *dev, const VuVirtq *vq)
+{
+    return vq->started;
+}
+
+static inline uint16_t
+vring_avail_flags(VuVirtq *vq)
+{
+    return le16toh(vq->vring.avail->flags);
+}
+
+static inline uint16_t
+vring_avail_idx(VuVirtq *vq)
+{
+    vq->shadow_avail_idx = le16toh(vq->vring.avail->idx);
+
+    return vq->shadow_avail_idx;
+}
+
+static inline uint16_t
+vring_avail_ring(VuVirtq *vq, int i)
+{
+    return le16toh(vq->vring.avail->ring[i]);
+}
+
+static inline uint16_t
+vring_get_used_event(VuVirtq *vq)
+{
+    return vring_avail_ring(vq, vq->vring.num);
+}
+
+static int
+virtqueue_num_heads(VuDev *dev, VuVirtq *vq, unsigned int idx)
+{
+    uint16_t num_heads = vring_avail_idx(vq) - idx;
+
+    /* Check it isn't doing very strange things with descriptor numbers. */
+    if (num_heads > vq->vring.num) {
+        vu_panic(dev, "Guest moved used index from %u to %u",
+                 idx, vq->shadow_avail_idx);
+        return -1;
+    }
+    if (num_heads) {
+        /* On success, callers read a descriptor at vq->last_avail_idx.
+         * Make sure descriptor read does not bypass avail index read. */
+        smp_rmb();
+    }
+
+    return num_heads;
+}
+
+static bool
+virtqueue_get_head(VuDev *dev, VuVirtq *vq,
+                   unsigned int idx, unsigned int *head)
+{
+    /* Grab the next descriptor number they're advertising, and increment
+     * the index we've seen. */
+    *head = vring_avail_ring(vq, idx % vq->vring.num);
+
+    /* If their number is silly, that's a fatal mistake. */
+    if (*head >= vq->vring.num) {
+        vu_panic(dev, "Guest says index %u is available", *head);
+        return false;
+    }
+
+    return true;
+}
+
+static int
+virtqueue_read_indirect_desc(VuDev *dev, struct vring_desc *desc,
+                             uint64_t addr, size_t len)
+{
+    struct vring_desc *ori_desc;
+    uint64_t read_len;
+
+    if (len > (VIRTQUEUE_MAX_SIZE * sizeof(struct vring_desc))) {
+        return -1;
+    }
+
+    if (len == 0) {
+        return -1;
+    }
+
+    while (len) {
+        read_len = len;
+        ori_desc = vu_gpa_to_va(dev, &read_len, addr);
+        if (!ori_desc) {
+            return -1;
+        }
+
+        memcpy(desc, ori_desc, read_len);
+        len -= read_len;
+        addr += read_len;
+        desc += read_len;
+    }
+
+    return 0;
+}
+
+enum {
+    VIRTQUEUE_READ_DESC_ERROR = -1,
+    VIRTQUEUE_READ_DESC_DONE = 0,   /* end of chain */
+    VIRTQUEUE_READ_DESC_MORE = 1,   /* more buffers in chain */
+};
+
+static int
+virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
+                         int i, unsigned int max, unsigned int *next)
+{
+    /* If this descriptor says it doesn't chain, we're done. */
+    if (!(le16toh(desc[i].flags) & VRING_DESC_F_NEXT)) {
+        return VIRTQUEUE_READ_DESC_DONE;
+    }
+
+    /* Check they're not leading us off end of descriptors. */
+    *next = le16toh(desc[i].next);
+    /* Make sure compiler knows to grab that: we don't want it changing! */
+    smp_wmb();
+
+    if (*next >= max) {
+        vu_panic(dev, "Desc next is %u", *next);
+        return VIRTQUEUE_READ_DESC_ERROR;
+    }
+
+    return VIRTQUEUE_READ_DESC_MORE;
+}
+
+void
+vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
+                         unsigned int *out_bytes,
+                         unsigned max_in_bytes, unsigned max_out_bytes)
+{
+    unsigned int idx;
+    unsigned int total_bufs, in_total, out_total;
+    int rc;
+
+    idx = vq->last_avail_idx;
+
+    total_bufs = in_total = out_total = 0;
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
+        goto done;
+    }
+
+    while ((rc = virtqueue_num_heads(dev, vq, idx)) > 0) {
+        unsigned int max, desc_len, num_bufs, indirect = 0;
+        uint64_t desc_addr, read_len;
+        struct vring_desc *desc;
+        struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
+        unsigned int i;
+
+        max = vq->vring.num;
+        num_bufs = total_bufs;
+        if (!virtqueue_get_head(dev, vq, idx++, &i)) {
+            goto err;
+        }
+        desc = vq->vring.desc;
+
+        if (le16toh(desc[i].flags) & VRING_DESC_F_INDIRECT) {
+            if (le32toh(desc[i].len) % sizeof(struct vring_desc)) {
+                vu_panic(dev, "Invalid size for indirect buffer table");
+                goto err;
+            }
+
+            /* If we've got too many, that implies a descriptor loop. */
+            if (num_bufs >= max) {
+                vu_panic(dev, "Looped descriptor");
+                goto err;
+            }
+
+            /* loop over the indirect descriptor table */
+            indirect = 1;
+            desc_addr = le64toh(desc[i].addr);
+            desc_len = le32toh(desc[i].len);
+            max = desc_len / sizeof(struct vring_desc);
+            read_len = desc_len;
+            desc = vu_gpa_to_va(dev, &read_len, desc_addr);
+            if (unlikely(desc && read_len != desc_len)) {
+                /* Failed to use zero copy */
+                desc = NULL;
+                if (!virtqueue_read_indirect_desc(dev, desc_buf,
+                                                  desc_addr,
+                                                  desc_len)) {
+                    desc = desc_buf;
+                }
+            }
+            if (!desc) {
+                vu_panic(dev, "Invalid indirect buffer table");
+                goto err;
+            }
+            num_bufs = i = 0;
+        }
+
+        do {
+            /* If we've got too many, that implies a descriptor loop. */
+            if (++num_bufs > max) {
+                vu_panic(dev, "Looped descriptor");
+                goto err;
+            }
+
+            if (le16toh(desc[i].flags) & VRING_DESC_F_WRITE) {
+                in_total += le32toh(desc[i].len);
+            } else {
+                out_total += le32toh(desc[i].len);
+            }
+            if (in_total >= max_in_bytes && out_total >= max_out_bytes) {
+                goto done;
+            }
+            rc = virtqueue_read_next_desc(dev, desc, i, max, &i);
+        } while (rc == VIRTQUEUE_READ_DESC_MORE);
+
+        if (rc == VIRTQUEUE_READ_DESC_ERROR) {
+            goto err;
+        }
+
+        if (!indirect) {
+            total_bufs = num_bufs;
+        } else {
+            total_bufs++;
+        }
+    }
+    if (rc < 0) {
+        goto err;
+    }
+done:
+    if (in_bytes) {
+        *in_bytes = in_total;
+    }
+    if (out_bytes) {
+        *out_bytes = out_total;
+    }
+    return;
+
+err:
+    in_total = out_total = 0;
+    goto done;
+}
+
+bool
+vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int in_bytes,
+                     unsigned int out_bytes)
+{
+    unsigned int in_total, out_total;
+
+    vu_queue_get_avail_bytes(dev, vq, &in_total, &out_total,
+                             in_bytes, out_bytes);
+
+    return in_bytes <= in_total && out_bytes <= out_total;
+}
+
+/* Fetch avail_idx from VQ memory only when we really need to know if
+ * guest has added some buffers. */
+bool
+vu_queue_empty(VuDev *dev, VuVirtq *vq)
+{
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
+        return true;
+    }
+
+    if (vq->shadow_avail_idx != vq->last_avail_idx) {
+        return false;
+    }
+
+    return vring_avail_idx(vq) == vq->last_avail_idx;
+}
+
+static bool
+vring_notify(VuDev *dev, VuVirtq *vq)
+{
+    uint16_t old, new;
+    bool v;
+
+    /* We need to expose used array entries before checking used event. */
+    smp_mb();
+
+    /* Always notify when queue is empty (when feature acknowledge) */
+    if (vu_has_feature(dev, VIRTIO_F_NOTIFY_ON_EMPTY) &&
+        !vq->inuse && vu_queue_empty(dev, vq)) {
+        return true;
+    }
+
+    if (!vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
+        return !(vring_avail_flags(vq) & VRING_AVAIL_F_NO_INTERRUPT);
+    }
+
+    v = vq->signalled_used_valid;
+    vq->signalled_used_valid = true;
+    old = vq->signalled_used;
+    new = vq->signalled_used = vq->used_idx;
+    return !v || vring_need_event(vring_get_used_event(vq), new, old);
+}
+
+static void _vu_queue_notify(VuDev *dev, VuVirtq *vq, bool sync)
+{
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
+        return;
+    }
+
+    if (!vring_notify(dev, vq)) {
+        DPRINT("skipped notify...\n");
+        return;
+    }
+
+    if (vq->call_fd < 0 &&
+        vu_has_protocol_feature(dev,
+                                VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS) &&
+        vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SLAVE_REQ)) {
+        VhostUserMsg vmsg = {
+            .request = VHOST_USER_SLAVE_VRING_CALL,
+            .flags = VHOST_USER_VERSION,
+            .size = sizeof(vmsg.payload.state),
+            .payload.state = {
+                .index = vq - dev->vq,
+            },
+        };
+        bool ack = sync &&
+                   vu_has_protocol_feature(dev,
+                                           VHOST_USER_PROTOCOL_F_REPLY_ACK);
+
+        if (ack) {
+            vmsg.flags |= VHOST_USER_NEED_REPLY_MASK;
+        }
+
+        vu_message_write(dev, dev->slave_fd, &vmsg);
+        if (ack) {
+            vu_message_read_default(dev, dev->slave_fd, &vmsg);
+        }
+        return;
+    }
+
+    if (eventfd_write(vq->call_fd, 1) < 0) {
+        vu_panic(dev, "Error writing eventfd: %s", strerror(errno));
+    }
+}
+
+void vu_queue_notify(VuDev *dev, VuVirtq *vq)
+{
+    _vu_queue_notify(dev, vq, false);
+}
+
+void vu_queue_notify_sync(VuDev *dev, VuVirtq *vq)
+{
+    _vu_queue_notify(dev, vq, true);
+}
+
+static inline void
+vring_used_flags_set_bit(VuVirtq *vq, int mask)
+{
+    uint16_t *flags;
+
+    flags = (uint16_t *)((char*)vq->vring.used +
+                         offsetof(struct vring_used, flags));
+    *flags = htole16(le16toh(*flags) | mask);
+}
+
+static inline void
+vring_used_flags_unset_bit(VuVirtq *vq, int mask)
+{
+    uint16_t *flags;
+
+    flags = (uint16_t *)((char*)vq->vring.used +
+                         offsetof(struct vring_used, flags));
+    *flags = htole16(le16toh(*flags) & ~mask);
+}
+
+static inline void
+vring_set_avail_event(VuVirtq *vq, uint16_t val)
+{
+    uint16_t *avail;
+
+    if (!vq->notification) {
+        return;
+    }
+
+    avail = (uint16_t *)&vq->vring.used->ring[vq->vring.num];
+    *avail = htole16(val);
+}
+
+void
+vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable)
+{
+    vq->notification = enable;
+    if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
+        vring_set_avail_event(vq, vring_avail_idx(vq));
+    } else if (enable) {
+        vring_used_flags_unset_bit(vq, VRING_USED_F_NO_NOTIFY);
+    } else {
+        vring_used_flags_set_bit(vq, VRING_USED_F_NO_NOTIFY);
+    }
+    if (enable) {
+        /* Expose avail event/used flags before caller checks the avail idx. */
+        smp_mb();
+    }
+}
+
+static bool
+virtqueue_map_desc(VuDev *dev,
+                   unsigned int *p_num_sg, struct iovec *iov,
+                   unsigned int max_num_sg, bool is_write,
+                   uint64_t pa, size_t sz)
+{
+    unsigned num_sg = *p_num_sg;
+
+    assert(num_sg <= max_num_sg);
+
+    if (!sz) {
+        vu_panic(dev, "virtio: zero sized buffers are not allowed");
+        return false;
+    }
+
+    while (sz) {
+        uint64_t len = sz;
+
+        if (num_sg == max_num_sg) {
+            vu_panic(dev, "virtio: too many descriptors in indirect table");
+            return false;
+        }
+
+        iov[num_sg].iov_base = vu_gpa_to_va(dev, &len, pa);
+        if (iov[num_sg].iov_base == NULL) {
+            vu_panic(dev, "virtio: invalid address for buffers");
+            return false;
+        }
+        iov[num_sg].iov_len = len;
+        num_sg++;
+        sz -= len;
+        pa += len;
+    }
+
+    *p_num_sg = num_sg;
+    return true;
+}
+
+static void *
+virtqueue_alloc_element(size_t sz,
+                                     unsigned out_num, unsigned in_num)
+{
+    VuVirtqElement *elem;
+    size_t in_sg_ofs = ALIGN_UP(sz, __alignof__(elem->in_sg[0]));
+    size_t out_sg_ofs = in_sg_ofs + in_num * sizeof(elem->in_sg[0]);
+    size_t out_sg_end = out_sg_ofs + out_num * sizeof(elem->out_sg[0]);
+
+    assert(sz >= sizeof(VuVirtqElement));
+    elem = malloc(out_sg_end);
+    elem->out_num = out_num;
+    elem->in_num = in_num;
+    elem->in_sg = (void *)elem + in_sg_ofs;
+    elem->out_sg = (void *)elem + out_sg_ofs;
+    return elem;
+}
+
+static void *
+vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
+{
+    struct vring_desc *desc = vq->vring.desc;
+    uint64_t desc_addr, read_len;
+    unsigned int desc_len;
+    unsigned int max = vq->vring.num;
+    unsigned int i = idx;
+    VuVirtqElement *elem;
+    unsigned int out_num = 0, in_num = 0;
+    struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
+    int rc;
+
+    if (le16toh(desc[i].flags) & VRING_DESC_F_INDIRECT) {
+        if (le32toh(desc[i].len) % sizeof(struct vring_desc)) {
+            vu_panic(dev, "Invalid size for indirect buffer table");
+            return NULL;
+        }
+
+        /* loop over the indirect descriptor table */
+        desc_addr = le64toh(desc[i].addr);
+        desc_len = le32toh(desc[i].len);
+        max = desc_len / sizeof(struct vring_desc);
+        read_len = desc_len;
+        desc = vu_gpa_to_va(dev, &read_len, desc_addr);
+        if (unlikely(desc && read_len != desc_len)) {
+            /* Failed to use zero copy */
+            desc = NULL;
+            if (!virtqueue_read_indirect_desc(dev, desc_buf,
+                                              desc_addr,
+                                              desc_len)) {
+                desc = desc_buf;
+            }
+        }
+        if (!desc) {
+            vu_panic(dev, "Invalid indirect buffer table");
+            return NULL;
+        }
+        i = 0;
+    }
+
+    /* Collect all the descriptors */
+    do {
+        if (le16toh(desc[i].flags) & VRING_DESC_F_WRITE) {
+            if (!virtqueue_map_desc(dev, &in_num, iov + out_num,
+                               VIRTQUEUE_MAX_SIZE - out_num, true,
+                               le64toh(desc[i].addr),
+                               le32toh(desc[i].len))) {
+                return NULL;
+            }
+        } else {
+            if (in_num) {
+                vu_panic(dev, "Incorrect order for descriptors");
+                return NULL;
+            }
+            if (!virtqueue_map_desc(dev, &out_num, iov,
+                               VIRTQUEUE_MAX_SIZE, false,
+                               le64toh(desc[i].addr),
+                               le32toh(desc[i].len))) {
+                return NULL;
+            }
+        }
+
+        /* If we've got too many, that implies a descriptor loop. */
+        if ((in_num + out_num) > max) {
+            vu_panic(dev, "Looped descriptor");
+            return NULL;
+        }
+        rc = virtqueue_read_next_desc(dev, desc, i, max, &i);
+    } while (rc == VIRTQUEUE_READ_DESC_MORE);
+
+    if (rc == VIRTQUEUE_READ_DESC_ERROR) {
+        vu_panic(dev, "read descriptor error");
+        return NULL;
+    }
+
+    /* Now copy what we have collected and mapped */
+    elem = virtqueue_alloc_element(sz, out_num, in_num);
+    elem->index = idx;
+    for (i = 0; i < out_num; i++) {
+        elem->out_sg[i] = iov[i];
+    }
+    for (i = 0; i < in_num; i++) {
+        elem->in_sg[i] = iov[out_num + i];
+    }
+
+    return elem;
+}
+
+static int
+vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
+{
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight)) {
+        return -1;
+    }
+
+    vq->inflight->desc[desc_idx].counter = vq->counter++;
+    vq->inflight->desc[desc_idx].inflight = 1;
+
+    return 0;
+}
+
+static int
+vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
+{
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight)) {
+        return -1;
+    }
+
+    vq->inflight->last_batch_head = desc_idx;
+
+    return 0;
+}
+
+static int
+vu_queue_inflight_post_put(VuDev *dev, VuVirtq *vq, int desc_idx)
+{
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+        return 0;
+    }
+
+    if (unlikely(!vq->inflight)) {
+        return -1;
+    }
+
+    barrier();
+
+    vq->inflight->desc[desc_idx].inflight = 0;
+
+    barrier();
+
+    vq->inflight->used_idx = vq->used_idx;
+
+    return 0;
+}
+
+void *
+vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
+{
+    int i;
+    unsigned int head;
+    VuVirtqElement *elem;
+
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
+        return NULL;
+    }
+
+    if (unlikely(vq->resubmit_list && vq->resubmit_num > 0)) {
+        i = (--vq->resubmit_num);
+        elem = vu_queue_map_desc(dev, vq, vq->resubmit_list[i].index, sz);
+
+        if (!vq->resubmit_num) {
+            free(vq->resubmit_list);
+            vq->resubmit_list = NULL;
+        }
+
+        return elem;
+    }
+
+    if (vu_queue_empty(dev, vq)) {
+        return NULL;
+    }
+    /*
+     * Needed after virtio_queue_empty(), see comment in
+     * virtqueue_num_heads().
+     */
+    smp_rmb();
+
+    if (vq->inuse >= vq->vring.num) {
+        vu_panic(dev, "Virtqueue size exceeded");
+        return NULL;
+    }
+
+    if (!virtqueue_get_head(dev, vq, vq->last_avail_idx++, &head)) {
+        return NULL;
+    }
+
+    if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
+        vring_set_avail_event(vq, vq->last_avail_idx);
+    }
+
+    elem = vu_queue_map_desc(dev, vq, head, sz);
+
+    if (!elem) {
+        return NULL;
+    }
+
+    vq->inuse++;
+
+    vu_queue_inflight_get(dev, vq, head);
+
+    return elem;
+}
+
+static void
+vu_queue_detach_element(VuDev *dev, VuVirtq *vq, VuVirtqElement *elem,
+                        size_t len)
+{
+    vq->inuse--;
+    /* unmap, when DMA support is added */
+}
+
+void
+vu_queue_unpop(VuDev *dev, VuVirtq *vq, VuVirtqElement *elem,
+               size_t len)
+{
+    vq->last_avail_idx--;
+    vu_queue_detach_element(dev, vq, elem, len);
+}
+
+bool
+vu_queue_rewind(VuDev *dev, VuVirtq *vq, unsigned int num)
+{
+    if (num > vq->inuse) {
+        return false;
+    }
+    vq->last_avail_idx -= num;
+    vq->inuse -= num;
+    return true;
+}
+
+static inline
+void vring_used_write(VuDev *dev, VuVirtq *vq,
+                      struct vring_used_elem *uelem, int i)
+{
+    struct vring_used *used = vq->vring.used;
+
+    used->ring[i] = *uelem;
+    vu_log_write(dev, vq->vring.log_guest_addr +
+                 offsetof(struct vring_used, ring[i]),
+                 sizeof(used->ring[i]));
+}
+
+
+static void
+vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
+                  const VuVirtqElement *elem,
+                  unsigned int len)
+{
+    struct vring_desc *desc = vq->vring.desc;
+    unsigned int i, max, min, desc_len;
+    uint64_t desc_addr, read_len;
+    struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
+    unsigned num_bufs = 0;
+
+    max = vq->vring.num;
+    i = elem->index;
+
+    if (le16toh(desc[i].flags) & VRING_DESC_F_INDIRECT) {
+        if (le32toh(desc[i].len) % sizeof(struct vring_desc)) {
+            vu_panic(dev, "Invalid size for indirect buffer table");
+            return;
+        }
+
+        /* loop over the indirect descriptor table */
+        desc_addr = le64toh(desc[i].addr);
+        desc_len = le32toh(desc[i].len);
+        max = desc_len / sizeof(struct vring_desc);
+        read_len = desc_len;
+        desc = vu_gpa_to_va(dev, &read_len, desc_addr);
+        if (unlikely(desc && read_len != desc_len)) {
+            /* Failed to use zero copy */
+            desc = NULL;
+            if (!virtqueue_read_indirect_desc(dev, desc_buf,
+                                              desc_addr,
+                                              desc_len)) {
+                desc = desc_buf;
+            }
+        }
+        if (!desc) {
+            vu_panic(dev, "Invalid indirect buffer table");
+            return;
+        }
+        i = 0;
+    }
+
+    do {
+        if (++num_bufs > max) {
+            vu_panic(dev, "Looped descriptor");
+            return;
+        }
+
+        if (le16toh(desc[i].flags) & VRING_DESC_F_WRITE) {
+            min = MIN(le32toh(desc[i].len), len);
+            vu_log_write(dev, le64toh(desc[i].addr), min);
+            len -= min;
+        }
+
+    } while (len > 0 &&
+             (virtqueue_read_next_desc(dev, desc, i, max, &i)
+              == VIRTQUEUE_READ_DESC_MORE));
+}
+
+void
+vu_queue_fill(VuDev *dev, VuVirtq *vq,
+              const VuVirtqElement *elem,
+              unsigned int len, unsigned int idx)
+{
+    struct vring_used_elem uelem;
+
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
+        return;
+    }
+
+    vu_log_queue_fill(dev, vq, elem, len);
+
+    idx = (idx + vq->used_idx) % vq->vring.num;
+
+    uelem.id = htole32(elem->index);
+    uelem.len = htole32(len);
+    vring_used_write(dev, vq, &uelem, idx);
+}
+
+static inline
+void vring_used_idx_set(VuDev *dev, VuVirtq *vq, uint16_t val)
+{
+    vq->vring.used->idx = htole16(val);
+    vu_log_write(dev,
+                 vq->vring.log_guest_addr + offsetof(struct vring_used, idx),
+                 sizeof(vq->vring.used->idx));
+
+    vq->used_idx = val;
+}
+
+void
+vu_queue_flush(VuDev *dev, VuVirtq *vq, unsigned int count)
+{
+    uint16_t old, new;
+
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
+        return;
+    }
+
+    /* Make sure buffer is written before we update index. */
+    smp_wmb();
+
+    old = vq->used_idx;
+    new = old + count;
+    vring_used_idx_set(dev, vq, new);
+    vq->inuse -= count;
+    if (unlikely((int16_t)(new - vq->signalled_used) < (uint16_t)(new - old))) {
+        vq->signalled_used_valid = false;
+    }
+}
+
+void
+vu_queue_push(VuDev *dev, VuVirtq *vq,
+              const VuVirtqElement *elem, unsigned int len)
+{
+    vu_queue_fill(dev, vq, elem, len, 0);
+    vu_queue_inflight_pre_put(dev, vq, elem->index);
+    vu_queue_flush(dev, vq, 1);
+    vu_queue_inflight_post_put(dev, vq, elem->index);
+}
diff --git a/tools/testing/roadtest/src/libvhost-user/libvhost-user.h b/tools/testing/roadtest/src/libvhost-user/libvhost-user.h
new file mode 100644
index 000000000000..691e0bc051c1
--- /dev/null
+++ b/tools/testing/roadtest/src/libvhost-user/libvhost-user.h
@@ -0,0 +1,691 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Vhost User library
+ *
+ * Copyright (c) 2016 Red Hat, Inc.
+ *
+ * Authors:
+ *  Victor Kaplansky <victork@redhat.com>
+ *  Marc-André Lureau <mlureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef LIBVHOST_USER_H
+#define LIBVHOST_USER_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <poll.h>
+#include <linux/vhost.h>
+#include <pthread.h>
+#include <linux/virtio_ring.h>
+
+/* Based on qemu/hw/virtio/vhost-user.c */
+#define VHOST_USER_F_PROTOCOL_FEATURES 30
+#define VHOST_LOG_PAGE 4096
+
+#define VIRTQUEUE_MAX_SIZE 1024
+
+#define VHOST_MEMORY_BASELINE_NREGIONS 8
+
+/*
+ * Set a reasonable maximum number of ram slots, which will be supported by
+ * any architecture.
+ */
+#define VHOST_USER_MAX_RAM_SLOTS 32
+
+#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
+
+typedef enum VhostSetConfigType {
+    VHOST_SET_CONFIG_TYPE_MASTER = 0,
+    VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
+} VhostSetConfigType;
+
+/*
+ * Maximum size of virtio device config space
+ */
+#define VHOST_USER_MAX_CONFIG_SIZE 256
+
+enum VhostUserProtocolFeature {
+    VHOST_USER_PROTOCOL_F_MQ = 0,
+    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
+    VHOST_USER_PROTOCOL_F_RARP = 2,
+    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
+    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
+    VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
+    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
+    VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
+    VHOST_USER_PROTOCOL_F_CONFIG = 9,
+    VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
+    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
+    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
+    VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
+    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
+
+    VHOST_USER_PROTOCOL_F_MAX
+};
+
+#define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MAX) - 1)
+
+typedef enum VhostUserRequest {
+    VHOST_USER_NONE = 0,
+    VHOST_USER_GET_FEATURES = 1,
+    VHOST_USER_SET_FEATURES = 2,
+    VHOST_USER_SET_OWNER = 3,
+    VHOST_USER_RESET_OWNER = 4,
+    VHOST_USER_SET_MEM_TABLE = 5,
+    VHOST_USER_SET_LOG_BASE = 6,
+    VHOST_USER_SET_LOG_FD = 7,
+    VHOST_USER_SET_VRING_NUM = 8,
+    VHOST_USER_SET_VRING_ADDR = 9,
+    VHOST_USER_SET_VRING_BASE = 10,
+    VHOST_USER_GET_VRING_BASE = 11,
+    VHOST_USER_SET_VRING_KICK = 12,
+    VHOST_USER_SET_VRING_CALL = 13,
+    VHOST_USER_SET_VRING_ERR = 14,
+    VHOST_USER_GET_PROTOCOL_FEATURES = 15,
+    VHOST_USER_SET_PROTOCOL_FEATURES = 16,
+    VHOST_USER_GET_QUEUE_NUM = 17,
+    VHOST_USER_SET_VRING_ENABLE = 18,
+    VHOST_USER_SEND_RARP = 19,
+    VHOST_USER_NET_SET_MTU = 20,
+    VHOST_USER_SET_SLAVE_REQ_FD = 21,
+    VHOST_USER_IOTLB_MSG = 22,
+    VHOST_USER_SET_VRING_ENDIAN = 23,
+    VHOST_USER_GET_CONFIG = 24,
+    VHOST_USER_SET_CONFIG = 25,
+    VHOST_USER_CREATE_CRYPTO_SESSION = 26,
+    VHOST_USER_CLOSE_CRYPTO_SESSION = 27,
+    VHOST_USER_POSTCOPY_ADVISE  = 28,
+    VHOST_USER_POSTCOPY_LISTEN  = 29,
+    VHOST_USER_POSTCOPY_END     = 30,
+    VHOST_USER_GET_INFLIGHT_FD = 31,
+    VHOST_USER_SET_INFLIGHT_FD = 32,
+    VHOST_USER_GPU_SET_SOCKET = 33,
+    VHOST_USER_VRING_KICK = 35,
+    VHOST_USER_GET_MAX_MEM_SLOTS = 36,
+    VHOST_USER_ADD_MEM_REG = 37,
+    VHOST_USER_REM_MEM_REG = 38,
+    VHOST_USER_MAX
+} VhostUserRequest;
+
+typedef enum VhostUserSlaveRequest {
+    VHOST_USER_SLAVE_NONE = 0,
+    VHOST_USER_SLAVE_IOTLB_MSG = 1,
+    VHOST_USER_SLAVE_CONFIG_CHANGE_MSG = 2,
+    VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG = 3,
+    VHOST_USER_SLAVE_VRING_CALL = 4,
+    VHOST_USER_SLAVE_VRING_ERR = 5,
+    VHOST_USER_SLAVE_MAX
+}  VhostUserSlaveRequest;
+
+typedef struct VhostUserMemoryRegion {
+    uint64_t guest_phys_addr;
+    uint64_t memory_size;
+    uint64_t userspace_addr;
+    uint64_t mmap_offset;
+} VhostUserMemoryRegion;
+
+typedef struct VhostUserMemory {
+    uint32_t nregions;
+    uint32_t padding;
+    VhostUserMemoryRegion regions[VHOST_MEMORY_BASELINE_NREGIONS];
+} VhostUserMemory;
+
+typedef struct VhostUserMemRegMsg {
+    uint64_t padding;
+    VhostUserMemoryRegion region;
+} VhostUserMemRegMsg;
+
+typedef struct VhostUserLog {
+    uint64_t mmap_size;
+    uint64_t mmap_offset;
+} VhostUserLog;
+
+typedef struct VhostUserConfig {
+    uint32_t offset;
+    uint32_t size;
+    uint32_t flags;
+    uint8_t region[VHOST_USER_MAX_CONFIG_SIZE];
+} VhostUserConfig;
+
+static VhostUserConfig c __attribute__ ((unused));
+#define VHOST_USER_CONFIG_HDR_SIZE (sizeof(c.offset) \
+                                   + sizeof(c.size) \
+                                   + sizeof(c.flags))
+
+typedef struct VhostUserVringArea {
+    uint64_t u64;
+    uint64_t size;
+    uint64_t offset;
+} VhostUserVringArea;
+
+typedef struct VhostUserInflight {
+    uint64_t mmap_size;
+    uint64_t mmap_offset;
+    uint16_t num_queues;
+    uint16_t queue_size;
+} VhostUserInflight;
+
+#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
+# define VU_PACKED __attribute__((gcc_struct, packed))
+#else
+# define VU_PACKED __attribute__((packed))
+#endif
+
+typedef struct VhostUserMsg {
+    int request;
+
+#define VHOST_USER_VERSION_MASK     (0x3)
+#define VHOST_USER_REPLY_MASK       (0x1 << 2)
+#define VHOST_USER_NEED_REPLY_MASK  (0x1 << 3)
+    uint32_t flags;
+    uint32_t size; /* the following payload size */
+
+    union {
+#define VHOST_USER_VRING_IDX_MASK   (0xff)
+#define VHOST_USER_VRING_NOFD_MASK  (0x1 << 8)
+        uint64_t u64;
+        struct vhost_vring_state state;
+        struct vhost_vring_addr addr;
+        VhostUserMemory memory;
+        VhostUserMemRegMsg memreg;
+        VhostUserLog log;
+        VhostUserConfig config;
+        VhostUserVringArea area;
+        VhostUserInflight inflight;
+    } payload;
+
+    int fds[VHOST_MEMORY_BASELINE_NREGIONS];
+    int fd_num;
+    uint8_t *data;
+} VU_PACKED VhostUserMsg;
+
+typedef struct VuDevRegion {
+    /* Guest Physical address. */
+    uint64_t gpa;
+    /* Memory region size. */
+    uint64_t size;
+    /* QEMU virtual address (userspace). */
+    uint64_t qva;
+    /* Starting offset in our mmaped space. */
+    uint64_t mmap_offset;
+    /* Start address of mmaped space. */
+    uint64_t mmap_addr;
+} VuDevRegion;
+
+typedef struct VuDev VuDev;
+
+typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
+typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
+typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
+                                  int *do_reply);
+typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
+typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool started);
+typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx);
+typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t len);
+typedef int (*vu_set_config_cb) (VuDev *dev, const uint8_t *data,
+                                 uint32_t offset, uint32_t size,
+                                 uint32_t flags);
+
+typedef struct VuDevIface {
+    /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
+    vu_get_features_cb get_features;
+    /* enable vhost implementation features */
+    vu_set_features_cb set_features;
+    /* get the protocol feature bitmask from the underlying vhost
+     * implementation */
+    vu_get_features_cb get_protocol_features;
+    /* enable protocol features in the underlying vhost implementation. */
+    vu_set_features_cb set_protocol_features;
+    /* process_msg is called for each vhost-user message received */
+    /* skip libvhost-user processing if return value != 0 */
+    vu_process_msg_cb process_msg;
+    /* tells when queues can be processed */
+    vu_queue_set_started_cb queue_set_started;
+    /*
+     * If the queue is processed in order, in which case it will be
+     * resumed to vring.used->idx. This can help to support resuming
+     * on unmanaged exit/crash.
+     */
+    vu_queue_is_processed_in_order_cb queue_is_processed_in_order;
+    /* get the config space of the device */
+    vu_get_config_cb get_config;
+    /* set the config space of the device */
+    vu_set_config_cb set_config;
+} VuDevIface;
+
+typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
+
+typedef struct VuRing {
+    unsigned int num;
+    struct vring_desc *desc;
+    struct vring_avail *avail;
+    struct vring_used *used;
+    uint64_t log_guest_addr;
+    uint32_t flags;
+} VuRing;
+
+typedef struct VuDescStateSplit {
+    /* Indicate whether this descriptor is inflight or not.
+     * Only available for head-descriptor. */
+    uint8_t inflight;
+
+    /* Padding */
+    uint8_t padding[5];
+
+    /* Maintain a list for the last batch of used descriptors.
+     * Only available when batching is used for submitting */
+    uint16_t next;
+
+    /* Used to preserve the order of fetching available descriptors.
+     * Only available for head-descriptor. */
+    uint64_t counter;
+} VuDescStateSplit;
+
+typedef struct VuVirtqInflight {
+    /* The feature flags of this region. Now it's initialized to 0. */
+    uint64_t features;
+
+    /* The version of this region. It's 1 currently.
+     * Zero value indicates a vm reset happened. */
+    uint16_t version;
+
+    /* The size of VuDescStateSplit array. It's equal to the virtqueue
+     * size. Slave could get it from queue size field of VhostUserInflight. */
+    uint16_t desc_num;
+
+    /* The head of list that track the last batch of used descriptors. */
+    uint16_t last_batch_head;
+
+    /* Storing the idx value of used ring */
+    uint16_t used_idx;
+
+    /* Used to track the state of each descriptor in descriptor table */
+    VuDescStateSplit desc[];
+} VuVirtqInflight;
+
+typedef struct VuVirtqInflightDesc {
+    uint16_t index;
+    uint64_t counter;
+} VuVirtqInflightDesc;
+
+typedef struct VuVirtq {
+    VuRing vring;
+
+    VuVirtqInflight *inflight;
+
+    VuVirtqInflightDesc *resubmit_list;
+
+    uint16_t resubmit_num;
+
+    uint64_t counter;
+
+    /* Next head to pop */
+    uint16_t last_avail_idx;
+
+    /* Last avail_idx read from VQ. */
+    uint16_t shadow_avail_idx;
+
+    uint16_t used_idx;
+
+    /* Last used index value we have signalled on */
+    uint16_t signalled_used;
+
+    /* Last used index value we have signalled on */
+    bool signalled_used_valid;
+
+    /* Notification enabled? */
+    bool notification;
+
+    int inuse;
+
+    vu_queue_handler_cb handler;
+
+    int call_fd;
+    int kick_fd;
+    int err_fd;
+    unsigned int enable;
+    bool started;
+
+    /* Guest addresses of our ring */
+    struct vhost_vring_addr vra;
+} VuVirtq;
+
+enum VuWatchCondtion {
+    VU_WATCH_IN = POLLIN,
+    VU_WATCH_OUT = POLLOUT,
+    VU_WATCH_PRI = POLLPRI,
+    VU_WATCH_ERR = POLLERR,
+    VU_WATCH_HUP = POLLHUP,
+};
+
+typedef void (*vu_panic_cb) (VuDev *dev, const char *err);
+typedef void (*vu_watch_cb) (VuDev *dev, int condition, void *data);
+typedef void (*vu_set_watch_cb) (VuDev *dev, int fd, int condition,
+                                 vu_watch_cb cb, void *data);
+typedef void (*vu_remove_watch_cb) (VuDev *dev, int fd);
+
+typedef struct VuDevInflightInfo {
+    int fd;
+    void *addr;
+    uint64_t size;
+} VuDevInflightInfo;
+
+struct VuDev {
+    int sock;
+    uint32_t nregions;
+    VuDevRegion regions[VHOST_USER_MAX_RAM_SLOTS];
+    VuVirtq *vq;
+    VuDevInflightInfo inflight_info;
+    int log_call_fd;
+    /* Must be held while using slave_fd */
+    pthread_mutex_t slave_mutex;
+    int slave_fd;
+    uint64_t log_size;
+    uint8_t *log_table;
+    uint64_t features;
+    uint64_t protocol_features;
+    bool broken;
+    uint16_t max_queues;
+
+    /*
+     * @read_msg: custom method to read vhost-user message
+     *
+     * Read data from vhost_user socket fd and fill up
+     * the passed VhostUserMsg *vmsg struct.
+     *
+     * If reading fails, it should close the received set of file
+     * descriptors as socket message's auxiliary data.
+     *
+     * For the details, please refer to vu_message_read in libvhost-user.c
+     * which will be used by default if not custom method is provided when
+     * calling vu_init
+     *
+     * Returns: true if vhost-user message successfully received,
+     *          otherwise return false.
+     *
+     */
+    vu_read_msg_cb read_msg;
+
+    /*
+     * @set_watch: add or update the given fd to the watch set,
+     * call cb when condition is met.
+     */
+    vu_set_watch_cb set_watch;
+
+    /* @remove_watch: remove the given fd from the watch set */
+    vu_remove_watch_cb remove_watch;
+
+    /*
+     * @panic: encountered an unrecoverable error, you may try to re-initialize
+     */
+    vu_panic_cb panic;
+    const VuDevIface *iface;
+
+    /* Postcopy data */
+    int postcopy_ufd;
+    bool postcopy_listening;
+};
+
+typedef struct VuVirtqElement {
+    unsigned int index;
+    unsigned int out_num;
+    unsigned int in_num;
+    struct iovec *in_sg;
+    struct iovec *out_sg;
+} VuVirtqElement;
+
+/**
+ * vu_init:
+ * @dev: a VuDev context
+ * @max_queues: maximum number of virtqueues
+ * @socket: the socket connected to vhost-user master
+ * @panic: a panic callback
+ * @set_watch: a set_watch callback
+ * @remove_watch: a remove_watch callback
+ * @iface: a VuDevIface structure with vhost-user device callbacks
+ *
+ * Initializes a VuDev vhost-user context.
+ *
+ * Returns: true on success, false on failure.
+ **/
+bool vu_init(VuDev *dev,
+             uint16_t max_queues,
+             int socket,
+             vu_panic_cb panic,
+             vu_read_msg_cb read_msg,
+             vu_set_watch_cb set_watch,
+             vu_remove_watch_cb remove_watch,
+             const VuDevIface *iface);
+
+
+/**
+ * vu_deinit:
+ * @dev: a VuDev context
+ *
+ * Cleans up the VuDev context
+ */
+void vu_deinit(VuDev *dev);
+
+/**
+ * vu_dispatch:
+ * @dev: a VuDev context
+ *
+ * Process one vhost-user message.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_dispatch(VuDev *dev);
+
+/**
+ * vu_gpa_to_va:
+ * @dev: a VuDev context
+ * @plen: guest memory size
+ * @guest_addr: guest address
+ *
+ * Translate a guest address to a pointer. Returns NULL on failure.
+ */
+void *vu_gpa_to_va(VuDev *dev, uint64_t *plen, uint64_t guest_addr);
+
+/**
+ * vu_get_queue:
+ * @dev: a VuDev context
+ * @qidx: queue index
+ *
+ * Returns the queue number @qidx.
+ */
+VuVirtq *vu_get_queue(VuDev *dev, int qidx);
+
+/**
+ * vu_set_queue_handler:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @handler: the queue handler callback
+ *
+ * Set the queue handler. This function may be called several times
+ * for the same queue. If called with NULL @handler, the handler is
+ * removed.
+ */
+void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
+                          vu_queue_handler_cb handler);
+
+/**
+ * vu_set_queue_host_notifier:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @fd: a file descriptor
+ * @size: host page size
+ * @offset: notifier offset in @fd file
+ *
+ * Set queue's host notifier. This function may be called several
+ * times for the same queue. If called with -1 @fd, the notifier
+ * is removed.
+ */
+bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
+                                int size, int offset);
+
+/**
+ * vu_queue_set_notification:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @enable: state
+ *
+ * Set whether the queue notifies (via event index or interrupt)
+ */
+void vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable);
+
+/**
+ * vu_queue_enabled:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Returns: whether the queue is enabled.
+ */
+bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
+
+/**
+ * vu_queue_started:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Returns: whether the queue is started.
+ */
+bool vu_queue_started(const VuDev *dev, const VuVirtq *vq);
+
+/**
+ * vu_queue_empty:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Returns: true if the queue is empty or not ready.
+ */
+bool vu_queue_empty(VuDev *dev, VuVirtq *vq);
+
+/**
+ * vu_queue_notify:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Request to notify the queue via callfd (skipped if unnecessary)
+ */
+void vu_queue_notify(VuDev *dev, VuVirtq *vq);
+
+/**
+ * vu_queue_notify_sync:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Request to notify the queue via callfd (skipped if unnecessary)
+ * or sync message if possible.
+ */
+void vu_queue_notify_sync(VuDev *dev, VuVirtq *vq);
+
+/**
+ * vu_queue_pop:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @sz: the size of struct to return (must be >= VuVirtqElement)
+ *
+ * Returns: a VuVirtqElement filled from the queue or NULL. The
+ * returned element must be free()-d by the caller.
+ */
+void *vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz);
+
+
+/**
+ * vu_queue_unpop:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @elem: The #VuVirtqElement
+ * @len: number of bytes written
+ *
+ * Pretend the most recent element wasn't popped from the virtqueue.  The next
+ * call to vu_queue_pop() will refetch the element.
+ */
+void vu_queue_unpop(VuDev *dev, VuVirtq *vq, VuVirtqElement *elem,
+                    size_t len);
+
+/**
+ * vu_queue_rewind:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @num: number of elements to push back
+ *
+ * Pretend that elements weren't popped from the virtqueue.  The next
+ * virtqueue_pop() will refetch the oldest element.
+ *
+ * Returns: true on success, false if @num is greater than the number of in use
+ * elements.
+ */
+bool vu_queue_rewind(VuDev *dev, VuVirtq *vq, unsigned int num);
+
+/**
+ * vu_queue_fill:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @elem: a VuVirtqElement
+ * @len: length in bytes to write
+ * @idx: optional offset for the used ring index (0 in general)
+ *
+ * Fill the used ring with @elem element.
+ */
+void vu_queue_fill(VuDev *dev, VuVirtq *vq,
+                   const VuVirtqElement *elem,
+                   unsigned int len, unsigned int idx);
+
+/**
+ * vu_queue_push:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @elem: a VuVirtqElement
+ * @len: length in bytes to write
+ *
+ * Helper that combines vu_queue_fill() with a vu_queue_flush().
+ */
+void vu_queue_push(VuDev *dev, VuVirtq *vq,
+                   const VuVirtqElement *elem, unsigned int len);
+
+/**
+ * vu_queue_flush:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @num: number of elements to flush
+ *
+ * Mark the last number of elements as done (used.idx is updated by
+ * num elements).
+*/
+void vu_queue_flush(VuDev *dev, VuVirtq *vq, unsigned int num);
+
+/**
+ * vu_queue_get_avail_bytes:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @in_bytes: in bytes
+ * @out_bytes: out bytes
+ * @max_in_bytes: stop counting after max_in_bytes
+ * @max_out_bytes: stop counting after max_out_bytes
+ *
+ * Count the number of available bytes, up to max_in_bytes/max_out_bytes.
+ */
+void vu_queue_get_avail_bytes(VuDev *vdev, VuVirtq *vq, unsigned int *in_bytes,
+                              unsigned int *out_bytes,
+                              unsigned max_in_bytes, unsigned max_out_bytes);
+
+/**
+ * vu_queue_avail_bytes:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @in_bytes: expected in bytes
+ * @out_bytes: expected out bytes
+ *
+ * Returns: true if in_bytes <= in_total && out_bytes <= out_total
+ */
+bool vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int in_bytes,
+                          unsigned int out_bytes);
+
+#endif /* LIBVHOST_USER_H */
-- 
2.34.1

