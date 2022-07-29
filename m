Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18595585554
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiG2TDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiG2TDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:03:16 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E8289EA1;
        Fri, 29 Jul 2022 12:02:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 07232318FBF;
        Fri, 29 Jul 2022 15:02:57 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HbokleqE1hXu; Fri, 29 Jul 2022 15:02:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 40C9B318DE7;
        Fri, 29 Jul 2022 15:02:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 40C9B318DE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121371;
        bh=Ie7S3dyrcvpMRfxEN29qgmzq/a8aBl/lNzNhmgzwua0=;
        h=From:To:Date:Message-Id;
        b=RHGWAW+iE/7KPkx2QzLrJrDHcXAOPJkYOUwfwsXfI7eb4UvLbAu6dv5yMDbQk55he
         TK+X10jo+s26HrE6l4GCJfBfxwvwDHL6CMQSqYK2bKQ/uwIHGl825LcZrlZZ+yengB
         xv8v2XBACLHOZ71JqZzuJKA8mC+WxVBm5LAo7owleCU8NIc/I/AuKwznHjZRhjZab9
         C9yCqlD4cfbA3HoSsh31EvaU0R5gcGn/qKJjPGYYnGFADNBZguSYTIMPwO+zzAPDnz
         AMC5Z8t1JMicOhVC4kxV64W9WLC1ZDS21zEqZN3W1DU58B5iEqryZJ/4md8mp3AuNu
         PZ0YzGW2Hy1xg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8LyJ5UvddZkm; Fri, 29 Jul 2022 15:02:51 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 051C4318E9A;
        Fri, 29 Jul 2022 15:02:46 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 15/23] selftests/rseq: arm64: Template memory ordering and percpu access mode
Date:   Fri, 29 Jul 2022 15:02:17 -0400
Message-Id: <20220729190225.12726-16-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a rseq-arm64-bits.h template header which is internally
included to generate the static inline functions covering:

- relaxed and release memory ordering,
- per-cpu-id and per-vm-vcpu-id per-cpu data access.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 .../testing/selftests/rseq/rseq-arm64-bits.h  | 392 +++++++++++++
 tools/testing/selftests/rseq/rseq-arm64.h     | 516 +-----------------
 2 files changed, 422 insertions(+), 486 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-arm64-bits.h

diff --git a/tools/testing/selftests/rseq/rseq-arm64-bits.h b/tools/testing/selftests/rseq/rseq-arm64-bits.h
new file mode 100644
index 000000000000..a45a827fde44
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-arm64-bits.h
@@ -0,0 +1,392 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-arm64-bits.h
+ *
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2018 - Will Deacon <will.deacon@arm.com>
+ */
+
+#include "rseq-bits-template.h"
+
+#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpnev_storeoffp_load)(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
+#endif
+		RSEQ_ASM_OP_R_LOAD(v)
+		RSEQ_ASM_OP_R_STORE(load)
+		RSEQ_ASM_OP_R_LOAD_OFF(voffp)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [load]		"Qo" (*load),
+		  [voffp]		"r" (voffp)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_addv)(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		RSEQ_ASM_OP_R_LOAD(v)
+		RSEQ_ASM_OP_R_ADD(count)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [count]		"r" (count)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error3])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
+#endif
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"Qo" (*v),
+		  [expect]		"r" (expect),
+		  [v2]			"Qo" (*v2),
+		  [expect2]		"r" (expect2),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+error3:
+	rseq_after_asm_goto();
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+#endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID)) */
+
+#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+#else
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+#endif
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [expect]		"r" (expect),
+		  [v]			"Qo" (*v),
+		  [newv]		"r" (newv),
+		  [v2]			"Qo" (*v2),
+		  [newv2]		"r" (newv2)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
+		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+#else
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+#endif
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [expect]		"r" (expect),
+		  [v]			"Qo" (*v),
+		  [newv]		"r" (newv),
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", RSEQ_ASM_TMP_REG, RSEQ_ASM_TMP_REG_2
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID)) */
+
+#include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 49c387fcd868..7aba23cc486c 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -2,7 +2,7 @@
 /*
  * rseq-arm64.h
  *
- * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  * (C) Copyright 2018 - Will Deacon <will.deacon@arm.com>
  */
 
@@ -200,490 +200,34 @@ do {										\
 	"	cbnz	" RSEQ_ASM_TMP_REG_2 ", 222b\n"				\
 	"333:\n"
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"Qo" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       long voffp, intptr_t *load, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
-#endif
-		RSEQ_ASM_OP_R_LOAD(v)
-		RSEQ_ASM_OP_R_STORE(load)
-		RSEQ_ASM_OP_R_LOAD_OFF(voffp)
-		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"Qo" (*v),
-		  [expectnot]		"r" (expectnot),
-		  [load]		"Qo" (*load),
-		  [voffp]		"r" (voffp)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
+/* Per-cpu-id indexing. */
 
-static inline __attribute__((always_inline))
-int rseq_addv(intptr_t *v, intptr_t count, int cpu)
-{
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-#endif
-		RSEQ_ASM_OP_R_LOAD(v)
-		RSEQ_ASM_OP_R_ADD(count)
-		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"Qo" (*v),
-		  [count]		"r" (count)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
-				 intptr_t *v2, intptr_t newv2,
-				 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		RSEQ_ASM_OP_STORE(newv2, v2)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [expect]		"r" (expect),
-		  [v]			"Qo" (*v),
-		  [newv]		"r" (newv),
-		  [v2]			"Qo" (*v2),
-		  [newv2]		"r" (newv2)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		RSEQ_ASM_OP_STORE(newv2, v2)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [expect]		"r" (expect),
-		  [v]			"Qo" (*v),
-		  [newv]		"r" (newv),
-		  [v2]			"Qo" (*v2),
-		  [newv2]		"r" (newv2)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
-			      intptr_t *v2, intptr_t expect2,
-			      intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error3])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
-		RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
-#endif
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"Qo" (*v),
-		  [expect]		"r" (expect),
-		  [v2]			"Qo" (*v2),
-		  [expect2]		"r" (expect2),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2, error3
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-error3:
-	rseq_after_asm_goto();
-	rseq_bug("2nd expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
-				 void *dst, void *src, size_t len,
-				 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [expect]		"r" (expect),
-		  [v]			"Qo" (*v),
-		  [newv]		"r" (newv),
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG, RSEQ_ASM_TMP_REG_2
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
-#endif
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [expect]		"r" (expect),
-		  [v]			"Qo" (*v),
-		  [newv]		"r" (newv),
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len)
-		  RSEQ_INJECT_INPUT
-		: "memory", RSEQ_ASM_TMP_REG, RSEQ_ASM_TMP_REG_2
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
+
+/* Per-vm-vcpu-id indexing. */
+
+#define RSEQ_TEMPLATE_VM_VCPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_VM_VCPU_ID
+
+/* APIs which are not based on cpu ids. */
+
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
-- 
2.17.1

