Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AEE58555A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiG2TD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbiG2TDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:03:42 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D5F89EBB;
        Fri, 29 Jul 2022 12:02:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B89B5319026;
        Fri, 29 Jul 2022 15:02:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UFC6DVVsY-YH; Fri, 29 Jul 2022 15:02:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6B71D318AF2;
        Fri, 29 Jul 2022 15:02:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6B71D318AF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121371;
        bh=qKFhx3jtmtKp6FvTDDSUrhUVOYJ8FTIi5369bUn879M=;
        h=From:To:Date:Message-Id;
        b=b2y3NKflzcKsvP/CPzwS8q5mf6u+ddXww6g8hPWVZEteLp0P1KMKns4N+6QKL58FP
         HYGgeObxQZljV/p9MAwGB3uOorm2fiyF184A8boqNnFxgVVJJyPFp97/FiSoQqyk1/
         coPvVLZV9Zo7j6uClzaszFeGAcc7gf5W73fGimoF1O/Q5+f2W3qKHOdS3aOTTXqoqh
         JjaO48YWoFmJ2KOE/CUPwxFH7E3K39AujkQLTYmWvTcRrwW6J5VNIpBu2CGeLP2kpa
         CMSJhmqZeSlwHTToaKnA5P8t9eco0B0Wt78oGKGvySYOqs2tITiCsL6+B+4dTK+bQe
         f/VXRxCd15wVA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7raeHdxOdgoZ; Fri, 29 Jul 2022 15:02:51 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 688B5318F14;
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
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v3 16/23] selftests/rseq: mips: Template memory ordering and percpu access mode
Date:   Fri, 29 Jul 2022 15:02:18 -0400
Message-Id: <20220729190225.12726-17-mathieu.desnoyers@efficios.com>
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

Introduce a rseq-mips-bits.h template header which is internally
included to generate the static inline functions covering:

- relaxed and release memory ordering,
- per-cpu-id and per-vm-vcpu-id per-cpu data access.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Paul Burton <paul.burton@mips.com>
---
 tools/testing/selftests/rseq/rseq-mips-bits.h | 462 +++++++++++++
 tools/testing/selftests/rseq/rseq-mips.h      | 640 +-----------------
 2 files changed, 487 insertions(+), 615 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-mips-bits.h

diff --git a/tools/testing/selftests/rseq/rseq-mips-bits.h b/tools/testing/selftests/rseq/rseq-mips-bits.h
new file mode 100644
index 000000000000..890e9123403f
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-mips-bits.h
@@ -0,0 +1,462 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Author: Paul Burton <paul.burton@mips.com>
+ * (C) Copyright 2018 MIPS Tech LLC
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
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
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"beq $4, %[expectnot], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"beq $4, %[expectnot], %l[error2]\n\t"
+#endif
+		LONG_S " $4, %[load]\n\t"
+		LONG_ADDI " $4, %[voffp]\n\t"
+		LONG_L " $4, 0($4)\n\t"
+		/* final store */
+		LONG_S " $4, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"Ir" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
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
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		LONG_L " $4, %[v]\n\t"
+		LONG_ADDI " $4, %[count]\n\t"
+		/* final store */
+		LONG_S " $4, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [count]		"Ir" (count)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
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
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		LONG_L " $4, %[v2]\n\t"
+		"bne $4, %[expect2], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+		LONG_L " $4, %[v2]\n\t"
+		"bne $4, %[expect2], %l[error3]\n\t"
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
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
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("1st expected value comparison failed");
+error3:
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
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+#endif
+		/* try store */
+		LONG_S " %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		"sync\n\t"	/* full sync provides store-release */
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
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
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uintptr_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		LONG_S " %[src], %[rseq_scratch0]\n\t"
+		LONG_S "  %[dst], %[rseq_scratch1]\n\t"
+		LONG_S " %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], 7f\n\t"
+#endif
+		/* try memcpy */
+		"beqz %[len], 333f\n\t" \
+		"222:\n\t" \
+		"lb   $4, 0(%[src])\n\t" \
+		"sb   $4, 0(%[dst])\n\t" \
+		LONG_ADDI " %[src], 1\n\t" \
+		LONG_ADDI " %[dst], 1\n\t" \
+		LONG_ADDI " %[len], -1\n\t" \
+		"bnez %[len], 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		"sync\n\t"	/* full sync provides store-release */
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		LONG_L " %[len], %[rseq_scratch2]\n\t"
+		LONG_L " %[dst], %[rseq_scratch1]\n\t"
+		LONG_L " %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      LONG_L " %[len], %[rseq_scratch2]\n\t"
+				      LONG_L " %[dst], %[rseq_scratch1]\n\t"
+				      LONG_L " %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
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
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID)) */
+
+#include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index dd199952d649..0ca65cc088df 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -2,9 +2,7 @@
 /*
  * Author: Paul Burton <paul.burton@mips.com>
  * (C) Copyright 2018 MIPS Tech LLC
- *
- * Based on rseq-arm.h:
- * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
 /*
@@ -150,622 +148,34 @@ do {									\
 		teardown \
 		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
+/* Per-cpu-id indexing. */
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], %l[error2]\n\t"
-#endif
-		/* final store */
-		LONG_S " %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "$4", "memory"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-mips-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-static inline __attribute__((always_inline))
-int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       long voffp, intptr_t *load, int cpu)
-{
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-mips-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		LONG_L " $4, %[v]\n\t"
-		"beq $4, %[expectnot], %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		LONG_L " $4, %[v]\n\t"
-		"beq $4, %[expectnot], %l[error2]\n\t"
-#endif
-		LONG_S " $4, %[load]\n\t"
-		LONG_ADDI " $4, %[voffp]\n\t"
-		LONG_L " $4, 0($4)\n\t"
-		/* final store */
-		LONG_S " $4, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expectnot]		"r" (expectnot),
-		  [voffp]		"Ir" (voffp),
-		  [load]		"m" (*load)
-		  RSEQ_INJECT_INPUT
-		: "$4", "memory"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
+/* Per-vm-vcpu-id indexing. */
 
-static inline __attribute__((always_inline))
-int rseq_addv(intptr_t *v, intptr_t count, int cpu)
-{
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_VM_VCPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-mips-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-#endif
-		LONG_L " $4, %[v]\n\t"
-		LONG_ADDI " $4, %[count]\n\t"
-		/* final store */
-		LONG_S " $4, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(4)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"m" (*v),
-		  [count]		"Ir" (count)
-		  RSEQ_INJECT_INPUT
-		: "$4", "memory"
-		  RSEQ_INJECT_CLOBBER
-		: abort
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
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
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-mips-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_VM_VCPU_ID
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], %l[error2]\n\t"
-#endif
-		/* try store */
-		LONG_S " %[newv2], %[v2]\n\t"
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		LONG_S " %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
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
-		: "$4", "memory"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
+/* APIs which are not based on cpu ids. */
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], %l[error2]\n\t"
-#endif
-		/* try store */
-		LONG_S " %[newv2], %[v2]\n\t"
-		RSEQ_INJECT_ASM(5)
-		"sync\n\t"	/* full sync provides store-release */
-		/* final store */
-		LONG_S " %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
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
-		: "$4", "memory"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
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
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-		LONG_L " $4, %[v2]\n\t"
-		"bne $4, %[expect2], %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], %l[error2]\n\t"
-		LONG_L " $4, %[v2]\n\t"
-		"bne $4, %[expect2], %l[error3]\n\t"
-#endif
-		/* final store */
-		LONG_S " %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
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
-		: "$4", "memory"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2, error3
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("1st expected value comparison failed");
-error3:
-	rseq_bug("2nd expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
-				 void *dst, void *src, size_t len,
-				 intptr_t newv, int cpu)
-{
-	uintptr_t rseq_scratch[3];
-
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		LONG_S " %[src], %[rseq_scratch0]\n\t"
-		LONG_S "  %[dst], %[rseq_scratch1]\n\t"
-		LONG_S " %[len], %[rseq_scratch2]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], 5f\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], 7f\n\t"
-#endif
-		/* try memcpy */
-		"beqz %[len], 333f\n\t" \
-		"222:\n\t" \
-		"lb   $4, 0(%[src])\n\t" \
-		"sb   $4, 0(%[dst])\n\t" \
-		LONG_ADDI " %[src], 1\n\t" \
-		LONG_ADDI " %[dst], 1\n\t" \
-		LONG_ADDI " %[len], -1\n\t" \
-		"bnez %[len], 222b\n\t" \
-		"333:\n\t" \
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		LONG_S " %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		LONG_L " %[len], %[rseq_scratch2]\n\t"
-		LONG_L " %[dst], %[rseq_scratch1]\n\t"
-		LONG_L " %[src], %[rseq_scratch0]\n\t"
-		"b 8f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4,
-				      /* teardown */
-				      LONG_L " %[len], %[rseq_scratch2]\n\t"
-				      LONG_L " %[dst], %[rseq_scratch1]\n\t"
-				      LONG_L " %[src], %[rseq_scratch0]\n\t",
-				      abort, 1b, 2b, 4f)
-		RSEQ_ASM_DEFINE_CMPFAIL(5,
-					/* teardown */
-					LONG_L " %[len], %[rseq_scratch2]\n\t"
-					LONG_L " %[dst], %[rseq_scratch1]\n\t"
-					LONG_L " %[src], %[rseq_scratch0]\n\t",
-					cmpfail)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_CMPFAIL(6,
-					/* teardown */
-					LONG_L " %[len], %[rseq_scratch2]\n\t"
-					LONG_L " %[dst], %[rseq_scratch1]\n\t"
-					LONG_L " %[src], %[rseq_scratch0]\n\t",
-					error1)
-		RSEQ_ASM_DEFINE_CMPFAIL(7,
-					/* teardown */
-					LONG_L " %[len], %[rseq_scratch2]\n\t"
-					LONG_L " %[dst], %[rseq_scratch1]\n\t"
-					LONG_L " %[src], %[rseq_scratch0]\n\t",
-					error2)
-#endif
-		"8:\n\t"
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
-		  [len]			"r" (len),
-		  [rseq_scratch0]	"m" (rseq_scratch[0]),
-		  [rseq_scratch1]	"m" (rseq_scratch[1]),
-		  [rseq_scratch2]	"m" (rseq_scratch[2])
-		  RSEQ_INJECT_INPUT
-		: "$4", "memory"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	uintptr_t rseq_scratch[3];
-
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		LONG_S " %[src], %[rseq_scratch0]\n\t"
-		LONG_S " %[dst], %[rseq_scratch1]\n\t"
-		LONG_S " %[len], %[rseq_scratch2]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], 5f\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
-		LONG_L " $4, %[v]\n\t"
-		"bne $4, %[expect], 7f\n\t"
-#endif
-		/* try memcpy */
-		"beqz %[len], 333f\n\t" \
-		"222:\n\t" \
-		"lb   $4, 0(%[src])\n\t" \
-		"sb   $4, 0(%[dst])\n\t" \
-		LONG_ADDI " %[src], 1\n\t" \
-		LONG_ADDI " %[dst], 1\n\t" \
-		LONG_ADDI " %[len], -1\n\t" \
-		"bnez %[len], 222b\n\t" \
-		"333:\n\t" \
-		RSEQ_INJECT_ASM(5)
-		"sync\n\t"	/* full sync provides store-release */
-		/* final store */
-		LONG_S " %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		LONG_L " %[len], %[rseq_scratch2]\n\t"
-		LONG_L " %[dst], %[rseq_scratch1]\n\t"
-		LONG_L " %[src], %[rseq_scratch0]\n\t"
-		"b 8f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4,
-				      /* teardown */
-				      LONG_L " %[len], %[rseq_scratch2]\n\t"
-				      LONG_L " %[dst], %[rseq_scratch1]\n\t"
-				      LONG_L " %[src], %[rseq_scratch0]\n\t",
-				      abort, 1b, 2b, 4f)
-		RSEQ_ASM_DEFINE_CMPFAIL(5,
-					/* teardown */
-					LONG_L " %[len], %[rseq_scratch2]\n\t"
-					LONG_L " %[dst], %[rseq_scratch1]\n\t"
-					LONG_L " %[src], %[rseq_scratch0]\n\t",
-					cmpfail)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_CMPFAIL(6,
-					/* teardown */
-					LONG_L " %[len], %[rseq_scratch2]\n\t"
-					LONG_L " %[dst], %[rseq_scratch1]\n\t"
-					LONG_L " %[src], %[rseq_scratch0]\n\t",
-					error1)
-		RSEQ_ASM_DEFINE_CMPFAIL(7,
-					/* teardown */
-					LONG_L " %[len], %[rseq_scratch2]\n\t"
-					LONG_L " %[dst], %[rseq_scratch1]\n\t"
-					LONG_L " %[src], %[rseq_scratch0]\n\t",
-					error2)
-#endif
-		"8:\n\t"
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
-		  [len]			"r" (len),
-		  [rseq_scratch0]	"m" (rseq_scratch[0]),
-		  [rseq_scratch1]	"m" (rseq_scratch[1]),
-		  [rseq_scratch2]	"m" (rseq_scratch[2])
-		  RSEQ_INJECT_INPUT
-		: "$4", "memory"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-mips-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
-- 
2.17.1

