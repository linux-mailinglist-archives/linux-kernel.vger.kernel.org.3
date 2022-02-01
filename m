Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FFF4A5E60
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiBAOec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:34:32 -0500
Received: from mail.efficios.com ([167.114.26.124]:42230 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbiBAOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:34:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6573A33D77F;
        Tue,  1 Feb 2022 09:34:29 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uxRmZ0LHyCFp; Tue,  1 Feb 2022 09:34:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B205D33D97A;
        Tue,  1 Feb 2022 09:34:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B205D33D97A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643726068;
        bh=u3tKAzzm5VKsz6x7OcMtZfI6oRYCneaiXPYEvO7Wx9k=;
        h=From:To:Date:Message-Id;
        b=KrOxRdIKORSEkIFiS8IkAViTv+Mh+TDllfunTzfiw9UNSnTtdFU7cvQzWnJrbIGQv
         ZlPZq160x/O5GA6tqn1FquX1p/oR2pexakiCO9pMRXa39Ll/aME6v77oN7pKM5wKDf
         zxgJeDrT4CZjfwdqo+6G4feOmfx0nq9uGkYOSTXh0woJlG+Cnv+PIw4F0RB8MEoPyw
         wmElK68Bb1CgWGlSpnb7QrWdsuQXMpc5+IlzyQYQYhm3T+svSUVRyi18cRMl5nOmRL
         WQQkP9jVuzQVeHnqMBcwLv4LmV4yZrYEdUM/pgeHesmj6AG1xW43o/JmUCfgcXJicH
         QC9uLj/FnE9Wg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zjufrg6Yr9g9; Tue,  1 Feb 2022 09:34:28 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 6CC8733DE01;
        Tue,  1 Feb 2022 09:34:28 -0500 (EST)
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
Subject: [RFC PATCH v2 2/2] selftests/rseq: Implement rseq numa node id field selftest
Date:   Tue,  1 Feb 2022 09:34:25 -0500
Message-Id: <20220201143425.19907-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201143425.19907-1-mathieu.desnoyers@efficios.com>
References: <20220201143425.19907-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test the NUMA node id extension rseq field. Compare it against the value
returned by the getcpu(2) system call while pinned on a specific core.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/basic_test.c |  5 ++++
 tools/testing/selftests/rseq/rseq-abi.h   | 23 ++++++++++++++++
 tools/testing/selftests/rseq/rseq.c       | 24 ++++++++++++++---
 tools/testing/selftests/rseq/rseq.h       | 32 +++++++++++++++++++++++
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
index d8efbfb89193..a49b88cb20a3 100644
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
@@ -29,6 +31,9 @@ void test_cpu_pointer(void)
 			assert(rseq_current_cpu() == i);
 			assert(rseq_current_cpu_raw() == i);
 			assert(rseq_cpu_start() == i);
+			node = rseq_fallback_current_node();
+			assert(rseq_current_node() == node);
+			assert(rseq_current_node_raw() == node);
 			CPU_CLR(i, &test_affinity);
 		}
 	}
diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index a8c44d9af71f..850827e8d089 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -146,6 +146,29 @@ struct rseq_abi {
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
+	 * Restartable sequences node_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current NUMA node ID.
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
index 07ba0d463a96..4b0e68051db8 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -58,6 +58,11 @@ static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
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
@@ -83,7 +88,7 @@ int rseq_register_current_thread(void)
 		/* Treat libc's ownership as a successful registration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, rseq_offsetofend(struct rseq_abi, node_id), 0, RSEQ_SIG);
 	if (rc)
 		return -1;
 	assert(rseq_current_cpu_raw() >= 0);
@@ -98,7 +103,7 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, rseq_offsetofend(struct rseq_abi, node_id), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (rc)
 		return -1;
 	return 0;
@@ -121,7 +126,7 @@ void rseq_init(void)
 		return;
 	rseq_ownership = 1;
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
-	rseq_size = sizeof(struct rseq_abi);
+	rseq_size = rseq_offsetofend(struct rseq_abi, node_id);
 	rseq_flags = 0;
 }
 
@@ -146,3 +151,16 @@ int32_t rseq_fallback_current_cpu(void)
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
index 6bd0ac466b4a..9d5ec4d66d98 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -16,9 +16,19 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include "rseq-abi.h"
 #include "compiler.h"
 
+#ifndef rseq_sizeof_field
+#define rseq_sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#endif
+
+#ifndef rseq_offsetofend
+#define rseq_offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ rseq_sizeof_field(TYPE, MEMBER))
+#endif
+
 /*
  * Empty code injection macros, override when testing.
  * It is important to consider that the ASM injection macros need to be
@@ -115,6 +125,11 @@ int rseq_unregister_current_thread(void);
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
@@ -124,6 +139,15 @@ static inline int32_t rseq_current_cpu_raw(void)
 	return RSEQ_ACCESS_ONCE(rseq_get_abi()->cpu_id);
 }
 
+/*
+ * Current NUMA node number.
+ */
+static inline uint32_t rseq_current_node_raw(void)
+{
+	assert((int) rseq_size >= rseq_offsetofend(struct rseq_abi, node_id));
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->node_id);
+}
+
 /*
  * Returns a possible CPU number, which is typically the current CPU.
  * The returned CPU number can be used to prepare for an rseq critical
@@ -150,6 +174,14 @@ static inline uint32_t rseq_current_cpu(void)
 	return cpu;
 }
 
+static inline uint32_t rseq_current_node(void)
+{
+	if (rseq_likely((int) rseq_size >= rseq_offsetofend(struct rseq_abi, node_id)))
+		return rseq_current_node_raw();
+	else
+		return rseq_fallback_current_node();
+}
+
 static inline void rseq_clear_rseq_cs(void)
 {
 	RSEQ_WRITE_ONCE(rseq_get_abi()->rseq_cs.arch.ptr, 0);
-- 
2.17.1

