Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F824A86A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351672AbiBCOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351387AbiBCOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E7AC06173E;
        Thu,  3 Feb 2022 06:33:50 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898828;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LbmmkDtP8bns/di2T8gcpVYUig1vNfi1S0k7xZiMLo=;
        b=iUFWu8o/XUCal5wcub9pvPBFvouH7U2I9dV0w0TBSkBk4R01/EY1vUyIZchn7zZjHiankB
        vQvznStSmtX9QYjgbfIBwvjl5Z0wjiJt2LvIrM28/BqiNGAHanamjqYe855705oI23s0Gq
        fjbiJSgBC5DcOinUsQ0COVA3eb2P+OPzE/pevqq+2ACdnj4pS8KEqBdbunPOrrtR2zV4Es
        +sbMiBjkc1FYXaOJEbSP7KF4WDkZWmJirTrh2qCgWTqdh83m5cqYH+GnWX6u14L97lj9iU
        NjSq3l/8XjuVqxNESslMbyhU64uQW7lD/tBfoSgYZDMb7A0fC96RQ0t1o4SKJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898828;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LbmmkDtP8bns/di2T8gcpVYUig1vNfi1S0k7xZiMLo=;
        b=WUOxyskKF7SaFZCqEJGEH7FT60JhEhtFnOnsdvtcjSfRx+wrDW0ewBumFqloePOTU5FiCL
        HHfl/6V/cjuE8SCA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Uplift rseq selftests for
 compatibility with glibc-2.35
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-8-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-8-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389882788.16921.1787223779254646136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     233e667e1ae3e348686bd9dd0172e62a09d852e1
Gitweb:        https://git.kernel.org/tip/233e667e1ae3e348686bd9dd0172e62a09d852e1
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:45 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:35 +01:00

selftests/rseq: Uplift rseq selftests for compatibility with glibc-2.35

glibc-2.35 (upcoming release date 2022-02-01) exposes the rseq per-thread
data in the TCB, accessible at an offset from the thread pointer, rather
than through an actual Thread-Local Storage (TLS) variable, as the
Linux kernel selftests initially expected.

The __rseq_abi TLS and glibc-2.35's ABI for per-thread data cannot
actively coexist in a process, because the kernel supports only a single
rseq registration per thread.

Here is the scheme introduced to ensure selftests can work both with an
older glibc and with glibc-2.35+:

- librseq exposes its own "rseq_offset, rseq_size, rseq_flags" ABI.

- librseq queries for glibc rseq ABI (__rseq_offset, __rseq_size,
  __rseq_flags) using dlsym() in a librseq library constructor. If those
  are found, copy their values into rseq_offset, rseq_size, and
  rseq_flags.

- Else, if those glibc symbols are not found, handle rseq registration
  from librseq and use its own IE-model TLS to implement the rseq ABI
  per-thread storage.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-8-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/Makefile |   2 +-
 tools/testing/selftests/rseq/rseq.c   | 161 +++++++++++--------------
 tools/testing/selftests/rseq/rseq.h   |  13 +-
 3 files changed, 88 insertions(+), 88 deletions(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 2af9d39..215e106 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -6,7 +6,7 @@ endif
 
 CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L$(OUTPUT) -Wl,-rpath=./ \
 	  $(CLANG_FLAGS)
-LDLIBS += -lpthread
+LDLIBS += -lpthread -ldl
 
 # Own dependencies because we only want to build against 1st prerequisite, but
 # still track changes to header files and depend on shared object.
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 1f905b6..07ba0d4 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -26,130 +26,123 @@
 #include <assert.h>
 #include <signal.h>
 #include <limits.h>
+#include <dlfcn.h>
 
 #include "../kselftest.h"
 #include "rseq.h"
 
-__thread struct rseq_abi __rseq_abi = {
-	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
-};
+static const int *libc_rseq_offset_p;
+static const unsigned int *libc_rseq_size_p;
+static const unsigned int *libc_rseq_flags_p;
 
-/*
- * Shared with other libraries. This library may take rseq ownership if it is
- * still 0 when executing the library constructor. Set to 1 by library
- * constructor when handling rseq. Set to 0 in destructor if handling rseq.
- */
-int __rseq_handled;
+/* Offset from the thread pointer to the rseq area.  */
+int rseq_offset;
+
+/* Size of the registered rseq area.  0 if the registration was
+   unsuccessful.  */
+unsigned int rseq_size = -1U;
+
+/* Flags used during rseq registration.  */
+unsigned int rseq_flags;
 
-/* Whether this library have ownership of rseq registration. */
 static int rseq_ownership;
 
-static __thread volatile uint32_t __rseq_refcount;
+static
+__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"))) = {
+	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
+};
 
-static void signal_off_save(sigset_t *oldset)
+static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
+		    int flags, uint32_t sig)
 {
-	sigset_t set;
-	int ret;
-
-	sigfillset(&set);
-	ret = pthread_sigmask(SIG_BLOCK, &set, oldset);
-	if (ret)
-		abort();
+	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
 }
 
-static void signal_restore(sigset_t oldset)
+int rseq_available(void)
 {
-	int ret;
+	int rc;
 
-	ret = pthread_sigmask(SIG_SETMASK, &oldset, NULL);
-	if (ret)
+	rc = sys_rseq(NULL, 0, 0, 0);
+	if (rc != -1)
 		abort();
-}
-
-static int sys_rseq(volatile struct rseq_abi *rseq_abi, uint32_t rseq_len,
-		    int flags, uint32_t sig)
-{
-	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
+	switch (errno) {
+	case ENOSYS:
+		return 0;
+	case EINVAL:
+		return 1;
+	default:
+		abort();
+	}
 }
 
 int rseq_register_current_thread(void)
 {
-	int rc, ret = 0;
-	sigset_t oldset;
+	int rc;
 
-	if (!rseq_ownership)
+	if (!rseq_ownership) {
+		/* Treat libc's ownership as a successful registration. */
 		return 0;
-	signal_off_save(&oldset);
-	if (__rseq_refcount == UINT_MAX) {
-		ret = -1;
-		goto end;
 	}
-	if (__rseq_refcount++)
-		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), 0, RSEQ_SIG);
-	if (!rc) {
-		assert(rseq_current_cpu_raw() >= 0);
-		goto end;
-	}
-	if (errno != EBUSY)
-		RSEQ_WRITE_ONCE(__rseq_abi.cpu_id, RSEQ_ABI_CPU_ID_REGISTRATION_FAILED);
-	ret = -1;
-	__rseq_refcount--;
-end:
-	signal_restore(oldset);
-	return ret;
+	if (rc)
+		return -1;
+	assert(rseq_current_cpu_raw() >= 0);
+	return 0;
 }
 
 int rseq_unregister_current_thread(void)
 {
-	int rc, ret = 0;
-	sigset_t oldset;
+	int rc;
 
-	if (!rseq_ownership)
+	if (!rseq_ownership) {
+		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
-	signal_off_save(&oldset);
-	if (!__rseq_refcount) {
-		ret = -1;
-		goto end;
 	}
-	if (--__rseq_refcount)
-		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi),
-		      RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
-	if (!rc)
-		goto end;
-	__rseq_refcount = 1;
-	ret = -1;
-end:
-	signal_restore(oldset);
-	return ret;
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	if (rc)
+		return -1;
+	return 0;
 }
 
-int32_t rseq_fallback_current_cpu(void)
+static __attribute__((constructor))
+void rseq_init(void)
 {
-	int32_t cpu;
-
-	cpu = sched_getcpu();
-	if (cpu < 0) {
-		perror("sched_getcpu()");
-		abort();
+	libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
+	libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
+	libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
+	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p) {
+		/* rseq registration owned by glibc */
+		rseq_offset = *libc_rseq_offset_p;
+		rseq_size = *libc_rseq_size_p;
+		rseq_flags = *libc_rseq_flags_p;
+		return;
 	}
-	return cpu;
-}
-
-void __attribute__((constructor)) rseq_init(void)
-{
-	/* Check whether rseq is handled by another library. */
-	if (__rseq_handled)
+	if (!rseq_available())
 		return;
-	__rseq_handled = 1;
 	rseq_ownership = 1;
+	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
+	rseq_size = sizeof(struct rseq_abi);
+	rseq_flags = 0;
 }
 
-void __attribute__((destructor)) rseq_fini(void)
+static __attribute__((destructor))
+void rseq_exit(void)
 {
 	if (!rseq_ownership)
 		return;
-	__rseq_handled = 0;
+	rseq_offset = 0;
+	rseq_size = -1U;
 	rseq_ownership = 0;
 }
+
+int32_t rseq_fallback_current_cpu(void)
+{
+	int32_t cpu;
+
+	cpu = sched_getcpu();
+	if (cpu < 0) {
+		perror("sched_getcpu()");
+		abort();
+	}
+	return cpu;
+}
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index ca668a2..17531cc 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -43,12 +43,19 @@
 #define RSEQ_INJECT_FAILED
 #endif
 
-extern __thread struct rseq_abi __rseq_abi;
-extern int __rseq_handled;
+#include "rseq-thread-pointer.h"
+
+/* Offset from the thread pointer to the rseq area.  */
+extern int rseq_offset;
+/* Size of the registered rseq area.  0 if the registration was
+   unsuccessful.  */
+extern unsigned int rseq_size;
+/* Flags used during rseq registration.  */
+extern unsigned int rseq_flags;
 
 static inline struct rseq_abi *rseq_get_abi(void)
 {
-	return &__rseq_abi;
+	return (struct rseq_abi *) ((uintptr_t) rseq_thread_pointer() + rseq_offset);
 }
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
