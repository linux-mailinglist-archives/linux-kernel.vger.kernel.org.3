Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5493B585561
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiG2TED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiG2TDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:03:43 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687788E39;
        Fri, 29 Jul 2022 12:03:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 83B4D318F2B;
        Fri, 29 Jul 2022 15:02:59 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4Cbv7mmQqxI8; Fri, 29 Jul 2022 15:02:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 999C1318B61;
        Fri, 29 Jul 2022 15:02:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 999C1318B61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121371;
        bh=bzVOti+NSNFdOqSVptn18jajeCKw16PqsoJT6G0pVXc=;
        h=From:To:Date:Message-Id;
        b=rsBX12EGz8O9Ovw7TZwV/Q20LQUsyuH6faDIkm22SHo+abDSiTu7nyMI6t5SpkpLZ
         e1Qvx5hVg5U7/l8iqFouw94QYLULLin6RIDTlwnAlZbKafsfB61jkBX29PODdGVYoD
         pI+3Slh3kQjOoFOw/1bAXrU/A+luBNpujy9ALa4iqf4pAPfPh0tCP0+LHg4Pikabdt
         7nJhosjpu/YnKypFfntoM6dK/rz2c5kHogNpzYjuxAAVQYgr73KZO51fDPNG4fP4kM
         rEQ4c8/kVIuukhILZ0cRfcfrsPwMnBjR1idxjkFu+Ci6JRtAVHPSPdx/iXaJyAwPNR
         5UagL52rqNHjA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JrX13Pe2ARu5; Fri, 29 Jul 2022 15:02:51 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id BE442318B55;
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 17/23] selftests/rseq: ppc: Template memory ordering and percpu access mode
Date:   Fri, 29 Jul 2022 15:02:19 -0400
Message-Id: <20220729190225.12726-18-mathieu.desnoyers@efficios.com>
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

Introduce a rseq-ppc-bits.h template header which is internally included
to generate the static inline functions covering:

- relaxed and release memory ordering,
- per-cpu-id and per-vm-vcpu-id per-cpu data access.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rseq/rseq-ppc-bits.h | 454 ++++++++++++++
 tools/testing/selftests/rseq/rseq-ppc.h      | 611 +------------------
 2 files changed, 486 insertions(+), 579 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc-bits.h

diff --git a/tools/testing/selftests/rseq/rseq-ppc-bits.h b/tools/testing/selftests/rseq/rseq-ppc-bits.h
new file mode 100644
index 000000000000..2d33c97c9236
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-ppc-bits.h
@@ -0,0 +1,454 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-ppc-bits.h
+ *
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2016-2018 - Boqun Feng <boqun.feng@gmail.com>
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
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
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
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v not equal to @expectnot */
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v not equal to @expectnot */
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
+#endif
+		/* load the value of @v */
+		RSEQ_ASM_OP_R_LOAD(v)
+		/* store it in @load */
+		RSEQ_ASM_OP_R_STORE(load)
+		/* dereference voffp(v) */
+		RSEQ_ASM_OP_R_LOADX(voffp)
+		/* final store the value at voffp(v) */
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"b" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
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
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		/* load the value of @v */
+		RSEQ_ASM_OP_R_LOAD(v)
+		/* add @count to it */
+		RSEQ_ASM_OP_R_ADD(count)
+		/* final store */
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"r" (count)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
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
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+		/* cmp @v2 equal to @expct2 */
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+		/* cmp @v2 equal to @expct2 */
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
+#endif
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
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
+	rseq_bug("1st expected value comparison failed");
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
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* try store */
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		/* for 'release' */
+		"lwsync\n\t"
+#endif
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
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
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* setup for mempcy */
+		"mr %%r19, %[len]\n\t"
+		"mr %%r20, %[src]\n\t"
+		"mr %%r21, %[dst]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* try memcpy */
+		RSEQ_ASM_OP_R_MEMCPY()
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		/* for 'release' */
+		"lwsync\n\t"
+#endif
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17", "r18", "r19", "r20", "r21"
+		  RSEQ_INJECT_CLOBBER
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
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index f82d95c1bb3f..78015fc52e72 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -2,7 +2,7 @@
 /*
  * rseq-ppc.h
  *
- * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  * (C) Copyright 2016-2018 - Boqun Feng <boqun.feng@gmail.com>
  */
 
@@ -205,581 +205,34 @@ do {									\
 		RSEQ_STORE_LONG(var) "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t" \
 		__rseq_str(post_commit_label) ":\n\t"
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		/* final store */
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "memory", "cc", "r17"
-		  RSEQ_INJECT_CLOBBER
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
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		/* cmp @v not equal to @expectnot */
-		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		/* cmp @v not equal to @expectnot */
-		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
-#endif
-		/* load the value of @v */
-		RSEQ_ASM_OP_R_LOAD(v)
-		/* store it in @load */
-		RSEQ_ASM_OP_R_STORE(load)
-		/* dereference voffp(v) */
-		RSEQ_ASM_OP_R_LOADX(voffp)
-		/* final store the value at voffp(v) */
-		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expectnot]		"r" (expectnot),
-		  [voffp]		"b" (voffp),
-		  [load]		"m" (*load)
-		  RSEQ_INJECT_INPUT
-		: "memory", "cc", "r17"
-		  RSEQ_INJECT_CLOBBER
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
-int rseq_addv(intptr_t *v, intptr_t count, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-#endif
-		/* load the value of @v */
-		RSEQ_ASM_OP_R_LOAD(v)
-		/* add @count to it */
-		RSEQ_ASM_OP_R_ADD(count)
-		/* final store */
-		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [count]		"r" (count)
-		  RSEQ_INJECT_INPUT
-		: "memory", "cc", "r17"
-		  RSEQ_INJECT_CLOBBER
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
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		/* try store */
-		RSEQ_ASM_OP_STORE(newv2, v2)
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* try store input */
-		  [v2]			"m" (*v2),
-		  [newv2]		"r" (newv2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "memory", "cc", "r17"
-		  RSEQ_INJECT_CLOBBER
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
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		/* try store */
-		RSEQ_ASM_OP_STORE(newv2, v2)
-		RSEQ_INJECT_ASM(5)
-		/* for 'release' */
-		"lwsync\n\t"
-		/* final store */
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* try store input */
-		  [v2]			"m" (*v2),
-		  [newv2]		"r" (newv2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "memory", "cc", "r17"
-		  RSEQ_INJECT_CLOBBER
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
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-		/* cmp @v2 equal to @expct2 */
-		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
-		RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-		/* cmp @v2 equal to @expct2 */
-		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
-#endif
-		/* final store */
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* cmp2 input */
-		  [v2]			"m" (*v2),
-		  [expect2]		"r" (expect2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "memory", "cc", "r17"
-		  RSEQ_INJECT_CLOBBER
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
-	rseq_bug("1st expected value comparison failed");
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
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* setup for mempcy */
-		"mr %%r19, %[len]\n\t"
-		"mr %%r20, %[src]\n\t"
-		"mr %%r21, %[dst]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		/* try memcpy */
-		RSEQ_ASM_OP_R_MEMCPY()
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv),
-		  /* try memcpy input */
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len)
-		  RSEQ_INJECT_INPUT
-		: "memory", "cc", "r17", "r18", "r19", "r20", "r21"
-		  RSEQ_INJECT_CLOBBER
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
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* setup for mempcy */
-		"mr %%r19, %[len]\n\t"
-		"mr %%r20, %[src]\n\t"
-		"mr %%r21, %[dst]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		/* cmp cpuid */
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		/* cmp @v equal to @expect */
-		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
-#endif
-		/* try memcpy */
-		RSEQ_ASM_OP_R_MEMCPY()
-		RSEQ_INJECT_ASM(5)
-		/* for 'release' */
-		"lwsync\n\t"
-		/* final store */
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv),
-		  /* try memcpy input */
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len)
-		  RSEQ_INJECT_INPUT
-		: "memory", "cc", "r17", "r18", "r19", "r20", "r21"
-		  RSEQ_INJECT_CLOBBER
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
+
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-ppc-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-ppc-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
+
+/* Per-vm-vcpu-id indexing. */
+
+#define RSEQ_TEMPLATE_VM_VCPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-ppc-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-ppc-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_VM_VCPU_ID
+
+/* APIs which are not based on cpu ids. */
+
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-ppc-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
-- 
2.17.1

