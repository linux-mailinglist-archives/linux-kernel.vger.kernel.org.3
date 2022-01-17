Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903F949110F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiAQUkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:40:06 -0500
Received: from mail.efficios.com ([167.114.26.124]:46770 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243128AbiAQUjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:39:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 337CB30492F;
        Mon, 17 Jan 2022 15:39:41 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gIffvTfnFFRd; Mon, 17 Jan 2022 15:39:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B26C9304871;
        Mon, 17 Jan 2022 15:39:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B26C9304871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642451979;
        bh=eyFkpEeN+fSVaadwC10SdwC07euc6yJa9T2vRvyrfRA=;
        h=From:To:Date:Message-Id;
        b=eYhvJB5zsmZak05xPyqckEqtBhTVT616IrFnFttmIYWGCXDhEU6Cw1Y83zUPxwKMd
         Yx7WO3dvIFeyKOalegSyW7FaJ4V0UrLbjnDzm0+INOyLc6LPwaZD/AGbcj6b9EwJlZ
         feSGpvZso9qoaA+gW/0YslRRgRK+hyJKc4H2b8mWUArlZd4OWekxoiESDE/E1uqROW
         AXicKZ9kVhWBGS/6J2rTbfrS0YMAN2Hs6X7UTUiZkCbS3O/xUuGAidjw83CHQJLe5Y
         d0FAgSQvxbwBC/FAAF2wrAtsYZOHHi2Tgr6VwQBjAj95ZmjkZ+gb72iYdF/pe0mtRq
         ldxSW7MEU5bLA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AY930U_IG2nt; Mon, 17 Jan 2022 15:39:39 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 643BE30492E;
        Mon, 17 Jan 2022 15:39:39 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 4/5] selftests/rseq: Introduce thread pointer getters
Date:   Mon, 17 Jan 2022 15:39:24 -0500
Message-Id: <20220117203925.12164-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
References: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done in preparation for the selftest uplift to become compatible
with glibc-2.35.

glibc-2.35 exposes the rseq per-thread data in the TCB, accessible
at an offset from the thread pointer.

The toolchains do not implement accessing the thread pointer on all
architectures. Provide thread pointer getters for ppc and x86 which
lack (or lacked until recently) toolchain support.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../rseq/rseq-generic-thread-pointer.h        | 25 ++++++++++++
 .../selftests/rseq/rseq-ppc-thread-pointer.h  | 30 ++++++++++++++
 .../selftests/rseq/rseq-thread-pointer.h      | 19 +++++++++
 .../selftests/rseq/rseq-x86-thread-pointer.h  | 40 +++++++++++++++++++
 4 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/rseq/rseq-generic-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h

diff --git a/tools/testing/selftests/rseq/rseq-generic-thread-pointer.h b/tools/testing/selftests/rseq/rseq-generic-thread-pointer.h
new file mode 100644
index 000000000000..38c584661571
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
index 000000000000..263eee84fb76
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
index 000000000000..977c25d758b2
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
index 000000000000..d3133587d996
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
-- 
2.17.1

