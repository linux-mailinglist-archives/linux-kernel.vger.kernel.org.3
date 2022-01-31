Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9A4A50A6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351005AbiAaUzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:55:55 -0500
Received: from mail.efficios.com ([167.114.26.124]:38822 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbiAaUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:55:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6797C2DEDA8;
        Mon, 31 Jan 2022 15:55:49 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pNDCIx5d5XQQ; Mon, 31 Jan 2022 15:55:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C80FB2DED24;
        Mon, 31 Jan 2022 15:55:48 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C80FB2DED24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643662548;
        bh=YhQMoo8mAfuaGY6s5bCfF94Up9s2ex9svLUfhGXg2w8=;
        h=From:To:Date:Message-Id;
        b=o+VzJ07rYIoFBshQHyAynB1q8TOsM2oQn99B5oKtzz2lDX1kpilbkHIsDubFJzJhd
         FzZBz7SwYlBnIVUfGvJlk1IOo7saPQk3mkVJ2jY2R8JXrTYJ4ZRTSZSCcHPMzZiNkK
         vN5vTkECSeZhl/7L1w5ASuT36Ppa65Tq/z9HeP3O+4u3URpnuI+LmwD31KrJZZxova
         e8DD5fp40vnnwRjY2WXKn3eLMFfZ1a9D7jwiAa4C01ZYEXaCbNf5xbrmu51VFnfasz
         rzflbwDFLtYlWplWXnJLlXKweOlhBmj9TYgoZa8Mm6N8BIVl68+Ojz/lpZIuQMOehX
         L2C9vpX4LYYCg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id upS1g7lfKRxC; Mon, 31 Jan 2022 15:55:48 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 72B402DED23;
        Mon, 31 Jan 2022 15:55:48 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 2/2] selftests/rseq: Implement rseq numa node id field selftest
Date:   Mon, 31 Jan 2022 15:55:31 -0500
Message-Id: <20220131205531.17873-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131205531.17873-1-mathieu.desnoyers@efficios.com>
References: <20220131205531.17873-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test the NUMA node id extension rseq field. Compare it against the value
returned by the getcpu(2) system call while pinned on a specific core.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/basic_test.c |  6 +++
 tools/testing/selftests/rseq/rseq-abi.h   | 51 +++++++++++++++++++++--
 tools/testing/selftests/rseq/rseq.c       | 37 ++++++++++++++--
 tools/testing/selftests/rseq/rseq.h       | 40 ++++++++++++++++++
 4 files changed, 127 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
index d8efbfb89193..9601db964b72 100644
--- a/tools/testing/selftests/rseq/basic_test.c
+++ b/tools/testing/selftests/rseq/basic_test.c
@@ -22,6 +22,8 @@ void test_cpu_pointer(void)
 	CPU_ZERO(&test_affinity);
 	for (i = 0; i < CPU_SETSIZE; i++) {
 		if (CPU_ISSET(i, &affinity)) {
+			int node;
+
 			CPU_SET(i, &test_affinity);
 			sched_setaffinity(0, sizeof(test_affinity),
 					&test_affinity);
@@ -29,6 +31,10 @@ void test_cpu_pointer(void)
 			assert(rseq_current_cpu() == i);
 			assert(rseq_current_cpu_raw() == i);
 			assert(rseq_cpu_start() == i);
+			node = rseq_fallback_current_node();
+			assert(rseq_current_node() == node);
+			assert(rseq_current_node_raw() == node);
+			assert(rseq_node_start() == node);
 			CPU_CLR(i, &test_affinity);
 		}
 	}
diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index a8c44d9af71f..7aba1cc0990b 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -13,9 +13,9 @@
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
-enum rseq_abi_cpu_id_state {
-	RSEQ_ABI_CPU_ID_UNINITIALIZED			= -1,
-	RSEQ_ABI_CPU_ID_REGISTRATION_FAILED		= -2,
+enum rseq_abi_id_state {
+	RSEQ_ABI_ID_UNINITIALIZED			= -1,
+	RSEQ_ABI_ID_REGISTRATION_FAILED			= -2,
 };
 
 enum rseq_abi_flags {
@@ -146,6 +146,51 @@ struct rseq_abi {
 	 *     this thread.
 	 */
 	__u32 flags;
+	__u32 padding1[3];
+
+	/*
+	 * This is the end of the original rseq ABI.
+	 * This is a valid end of rseq ABI for the purpose of rseq registration
+	 * rseq_len.
+	 * The original rseq ABI use "sizeof(struct rseq)" on registration,
+	 * thus requiring the padding above.
+	 */
+
+	/*
+	 * Restartable sequences node_id_start field. Updated by the
+	 * kernel. Read by user-space with single-copy atomicity
+	 * semantics. This field should only be read by the thread which
+	 * registered this data structure. Aligned on 32-bit. Always
+	 * contains a value in the range of possible NUMA node IDs, although the
+	 * value may not be the actual current NUMA node ID (e.g. if rseq is not
+	 * initialized). This NUMA node ID number value should always be compared
+	 * against the value of the node_id field before performing a rseq
+	 * commit or returning a value read from a data structure indexed using
+	 * the node_id_start value.
+	 */
+	__u32 node_id_start;
+
+	/*
+	 * Restartable sequences node_id field. Updated by the kernel.
+	 * Read by user-space with single-copy atomicity semantics. This
+	 * field should only be read by the thread which registered this
+	 * data structure. Aligned on 32-bit. Values
+	 * RSEQ_ID_UNINITIALIZED and RSEQ_ID_REGISTRATION_FAILED
+	 * have a special semantic: the former means "rseq uninitialized",
+	 * and latter means "rseq initialization failed". This value is
+	 * meant to be read within rseq critical sections and compared
+	 * with the node_id_start value previously read, before performing
+	 * the commit instruction, or read and compared with the
+	 * node_id_start value before returning a value loaded from a data
+	 * structure indexed using the node_id_start value.
+	 */
+	__u32 node_id;
+
+	/*
+	 * This is a valid end of rseq ABI for the purpose of rseq registration
+	 * rseq_len. Use the offset immediately after the node_id field as
+	 * rseq_len.
+	 */
 } __attribute__((aligned(4 * sizeof(__u64))));
 
 #endif /* _RSEQ_ABI_H */
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 07ba0d463a96..99b5c3b71ef0 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -27,10 +27,20 @@
 #include <signal.h>
 #include <limits.h>
 #include <dlfcn.h>
+#include <stddef.h>
 
 #include "../kselftest.h"
 #include "rseq.h"
 
+#ifndef sizeof_field
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#endif
+
+#ifndef offsetofend
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+#endif
+
 static const int *libc_rseq_offset_p;
 static const unsigned int *libc_rseq_size_p;
 static const unsigned int *libc_rseq_flags_p;
@@ -49,7 +59,8 @@ static int rseq_ownership;
 
 static
 __thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"))) = {
-	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
+	.cpu_id = RSEQ_ABI_ID_UNINITIALIZED,
+	.node_id = RSEQ_ABI_ID_UNINITIALIZED,
 };
 
 static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
@@ -58,6 +69,11 @@ static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
 	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
 }
 
+static int sys_getcpu(unsigned *cpu, unsigned *node)
+{
+	return syscall(__NR_getcpu, cpu, node, NULL);
+}
+
 int rseq_available(void)
 {
 	int rc;
@@ -83,7 +99,7 @@ int rseq_register_current_thread(void)
 		/* Treat libc's ownership as a successful registration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, offsetofend(struct rseq_abi, node_id), 0, RSEQ_SIG);
 	if (rc)
 		return -1;
 	assert(rseq_current_cpu_raw() >= 0);
@@ -98,7 +114,7 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, offsetofend(struct rseq_abi, node_id), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (rc)
 		return -1;
 	return 0;
@@ -121,7 +137,7 @@ void rseq_init(void)
 		return;
 	rseq_ownership = 1;
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
-	rseq_size = sizeof(struct rseq_abi);
+	rseq_size = offsetofend(struct rseq_abi, node_id);
 	rseq_flags = 0;
 }
 
@@ -146,3 +162,16 @@ int32_t rseq_fallback_current_cpu(void)
 	}
 	return cpu;
 }
+
+int32_t rseq_fallback_current_node(void)
+{
+	uint32_t cpu_id, node_id;
+	int ret;
+
+	ret = sys_getcpu(&cpu_id, &node_id);
+	if (ret) {
+		perror("sys_getcpu()");
+		return ret;
+	}
+	return (int32_t) node_id;
+}
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 6bd0ac466b4a..6fccc87f9025 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -115,6 +115,11 @@ int rseq_unregister_current_thread(void);
  */
 int32_t rseq_fallback_current_cpu(void);
 
+/*
+ * Restartable sequence fallback for reading the current node number.
+ */
+int32_t rseq_fallback_current_node(void);
+
 /*
  * Values returned can be either the current CPU number, -1 (rseq is
  * uninitialized), or -2 (rseq initialization has failed).
@@ -124,6 +129,15 @@ static inline int32_t rseq_current_cpu_raw(void)
 	return RSEQ_ACCESS_ONCE(rseq_get_abi()->cpu_id);
 }
 
+/*
+ * Values returned can be either the current NUMA node number, -1 (rseq is
+ * uninitialized), or -2 (rseq initialization has failed).
+ */
+static inline int32_t rseq_current_node_raw(void)
+{
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->node_id);
+}
+
 /*
  * Returns a possible CPU number, which is typically the current CPU.
  * The returned CPU number can be used to prepare for an rseq critical
@@ -140,6 +154,22 @@ static inline uint32_t rseq_cpu_start(void)
 	return RSEQ_ACCESS_ONCE(rseq_get_abi()->cpu_id_start);
 }
 
+/*
+ * Returns a possible NUMA node number, which is typically the current NUMA
+ * node.  The returned NUMA node number can be used to prepare for an rseq
+ * critical section, which will confirm whether the NUMA node number is indeed
+ * the current one, and whether rseq is initialized.
+ *
+ * The NUMA node number returned by rseq_node_start should always be validated
+ * by passing it to a rseq asm sequence, or by comparing it to the return value
+ * of rseq_current_node_raw() if the rseq asm sequence does not need to be
+ * invoked.
+ */
+static inline uint32_t rseq_node_start(void)
+{
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->node_id_start);
+}
+
 static inline uint32_t rseq_current_cpu(void)
 {
 	int32_t cpu;
@@ -150,6 +180,16 @@ static inline uint32_t rseq_current_cpu(void)
 	return cpu;
 }
 
+static inline uint32_t rseq_current_node(void)
+{
+	int32_t node;
+
+	node = rseq_current_node_raw();
+	if (rseq_unlikely(node < 0))
+		node = rseq_fallback_current_node();
+	return node;
+}
+
 static inline void rseq_clear_rseq_cs(void)
 {
 	RSEQ_WRITE_ONCE(rseq_get_abi()->rseq_cs.arch.ptr, 0);
-- 
2.17.1

