Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4571F4A869B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351533AbiBCOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:35:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351232AbiBCOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:51 -0500
Date:   Thu, 03 Feb 2022 14:33:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898829;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoObQMbqV/g6JnRfMZcgNXX4ApSictsIREj9Ja84ShQ=;
        b=yVvwaxUvoNNVtZhBzTNnDVfU3rY5nssRK+6o4fh8Ai1QtHFh6Qj/xIDnWNEW/Naj7Ent+d
        xBy6/xyu0x7NdANLCO+3Y2Cr5nzX+wK6S3/EAoL4H3j5UhraEyPJdTDL53xfFJ2AgdUsyG
        VSSbLB60ANW6sJhKGNWvCUnrgKQli60P1RyGBAqN0jAVrALj3K38zFYnFeKfey1jzXxbsU
        pPruHNnlFfrmvX2ffUq5AB7nMp/bclaqloxY5kXV08vWeXx6kz6jIzBpqRUH7vp5GYnsNy
        L9xCcr8RXTJ46le2HwT/k3QmzCOxDNTg6Rjkjj7L926rt0jV/M3al1J/+N2Qdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898829;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoObQMbqV/g6JnRfMZcgNXX4ApSictsIREj9Ja84ShQ=;
        b=ODoRz4IUHtzesC4Qms2qTPTav+5kLw2/9WrnOQQzR+3dLgoYlEpxXDadNifIURrwPdTpzO
        28gKRAUMerin2kDQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Introduce thread pointer getters
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-7-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-7-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389882867.16921.9809151390457421813.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     886ddfba933f5ce9d76c278165d834d114ba4ffc
Gitweb:        https://git.kernel.org/tip/886ddfba933f5ce9d76c278165d834d114ba4ffc
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:44 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:35 +01:00

selftests/rseq: Introduce thread pointer getters

This is done in preparation for the selftest uplift to become compatible
with glibc-2.35.

glibc-2.35 exposes the rseq per-thread data in the TCB, accessible
at an offset from the thread pointer.

The toolchains do not implement accessing the thread pointer on all
architectures. Provide thread pointer getters for ppc and x86 which
lack (or lacked until recently) toolchain support.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-7-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/rseq-generic-thread-pointer.h | 25 ++++-
 tools/testing/selftests/rseq/rseq-ppc-thread-pointer.h     | 30 +++++-
 tools/testing/selftests/rseq/rseq-thread-pointer.h         | 19 +++-
 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h     | 40 +++++++-
 4 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/rseq/rseq-generic-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h

diff --git a/tools/testing/selftests/rseq/rseq-generic-thread-pointer.h b/tools/testing/selftests/rseq/rseq-generic-thread-pointer.h
new file mode 100644
index 0000000..38c5846
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-generic-thread-pointer.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq-generic-thread-pointer.h
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef _RSEQ_GENERIC_THREAD_POINTER
+#define _RSEQ_GENERIC_THREAD_POINTER
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* Use gcc builtin thread pointer. */
+static inline void *rseq_thread_pointer(void)
+{
+	return __builtin_thread_pointer();
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/tools/testing/selftests/rseq/rseq-ppc-thread-pointer.h b/tools/testing/selftests/rseq/rseq-ppc-thread-pointer.h
new file mode 100644
index 0000000..263eee8
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-ppc-thread-pointer.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq-ppc-thread-pointer.h
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef _RSEQ_PPC_THREAD_POINTER
+#define _RSEQ_PPC_THREAD_POINTER
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+static inline void *rseq_thread_pointer(void)
+{
+#ifdef __powerpc64__
+	register void *__result asm ("r13");
+#else
+	register void *__result asm ("r2");
+#endif
+	asm ("" : "=r" (__result));
+	return __result;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/tools/testing/selftests/rseq/rseq-thread-pointer.h b/tools/testing/selftests/rseq/rseq-thread-pointer.h
new file mode 100644
index 0000000..977c25d
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-thread-pointer.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq-thread-pointer.h
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef _RSEQ_THREAD_POINTER
+#define _RSEQ_THREAD_POINTER
+
+#if defined(__x86_64__) || defined(__i386__)
+#include "rseq-x86-thread-pointer.h"
+#elif defined(__PPC__)
+#include "rseq-ppc-thread-pointer.h"
+#else
+#include "rseq-generic-thread-pointer.h"
+#endif
+
+#endif
diff --git a/tools/testing/selftests/rseq/rseq-x86-thread-pointer.h b/tools/testing/selftests/rseq/rseq-x86-thread-pointer.h
new file mode 100644
index 0000000..d313358
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-x86-thread-pointer.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq-x86-thread-pointer.h
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef _RSEQ_X86_THREAD_POINTER
+#define _RSEQ_X86_THREAD_POINTER
+
+#include <features.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#if __GNUC_PREREQ (11, 1)
+static inline void *rseq_thread_pointer(void)
+{
+	return __builtin_thread_pointer();
+}
+#else
+static inline void *rseq_thread_pointer(void)
+{
+	void *__result;
+
+# ifdef __x86_64__
+	__asm__ ("mov %%fs:0, %0" : "=r" (__result));
+# else
+	__asm__ ("mov %%gs:0, %0" : "=r" (__result));
+# endif
+	return __result;
+}
+#endif /* !GCC 11 */
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
