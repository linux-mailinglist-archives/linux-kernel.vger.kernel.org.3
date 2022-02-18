Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3934BC1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiBRVQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:16:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbiBRVQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:16:12 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BDC28BF43;
        Fri, 18 Feb 2022 13:15:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BD7C33BAC85;
        Fri, 18 Feb 2022 16:06:49 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rsW_KsIUnzex; Fri, 18 Feb 2022 16:06:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C56A53BAC06;
        Fri, 18 Feb 2022 16:06:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C56A53BAC06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645218403;
        bh=fWg+52u1rxXnBxOGY+84ZiMv6iY1DuUNHrDg8mMnLCk=;
        h=From:To:Date:Message-Id;
        b=AOiIxCOk5/up1YA/uuOCETuTL8NQcMyqhxNwzF98b7JhF3W8hhJn9uH6PdGpBJboM
         ZckZF5xqTdVurLv4lpM//b85OiIrhWVF1DtFXDD3VdrMaWBt/Dh+Ua/HZJBjktK/1M
         NHK0tGyYFTHKmpOTXZT9O4QahEE47Uv08ouivd6+L7EFYF/qXtldLCeXKKZEN/4MdO
         GpQZyuh0NGCsf1Svvym9C3HWbopmgMUimfkMLoFTXPKVBpmQ3invaqnKEFU/BRXXOe
         TLPyjcjphXjegB6logH8UAUQf4Kbl226Xr0IgmQmasMgfXcOt/xnv23DCiMTL6Oi0j
         noQJtSyKhTc4A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MXcb7A5S4Uze; Fri, 18 Feb 2022 16:06:43 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 77C893BAB13;
        Fri, 18 Feb 2022 16:06:43 -0500 (EST)
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
Subject: [RFC PATCH v2 05/11] selftests/rseq: Implement rseq numa node id field selftest
Date:   Fri, 18 Feb 2022 16:06:27 -0500
Message-Id: <20220218210633.23345-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test the NUMA node id extension rseq field. Compare it against the value
returned by the getcpu(2) system call while pinned on a specific core.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/basic_test.c |  5 ++++
 tools/testing/selftests/rseq/rseq-abi.h   |  8 ++++++
 tools/testing/selftests/rseq/rseq.c       | 18 +++++++++++++
 tools/testing/selftests/rseq/rseq.h       | 31 +++++++++++++++++++++++
 4 files changed, 62 insertions(+)

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
index 00ac846d85b0..a1faa9162d52 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -147,6 +147,14 @@ struct rseq_abi {
 	 */
 	__u32 flags;
 
+	/*
+	 * Restartable sequences node_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current NUMA node ID.
+	 */
+	__u32 node_id;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 506f2b17aea6..470fc0f73e22 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -79,6 +79,11 @@ static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
 	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
 }
 
+static int sys_getcpu(unsigned int *cpu, unsigned int *node)
+{
+	return syscall(__NR_getcpu, cpu, node, NULL);
+}
+
 int rseq_available(void)
 {
 	int rc;
@@ -199,3 +204,16 @@ int32_t rseq_fallback_current_cpu(void)
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
index e73db2e82a11..4f1954cd12ff 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -20,6 +20,15 @@
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
@@ -123,6 +132,11 @@ int rseq_unregister_current_thread(void);
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
@@ -132,6 +146,15 @@ static inline int32_t rseq_current_cpu_raw(void)
 	return RSEQ_ACCESS_ONCE(rseq_get_abi()->cpu_id);
 }
 
+/*
+ * Current NUMA node number.
+ */
+static inline uint32_t rseq_current_node_raw(void)
+{
+	assert((int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, node_id));
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->node_id);
+}
+
 /*
  * Returns a possible CPU number, which is typically the current CPU.
  * The returned CPU number can be used to prepare for an rseq critical
@@ -158,6 +181,14 @@ static inline uint32_t rseq_current_cpu(void)
 	return cpu;
 }
 
+static inline uint32_t rseq_current_node(void)
+{
+	if (rseq_likely((int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, node_id)))
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

