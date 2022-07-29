Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803DC585566
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiG2TEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238789AbiG2TDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:03:44 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20AE8AB19;
        Fri, 29 Jul 2022 12:03:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D6FB9318EA5;
        Fri, 29 Jul 2022 15:03:00 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aHErRqhBMWOb; Fri, 29 Jul 2022 15:02:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0BFB6319091;
        Fri, 29 Jul 2022 15:02:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0BFB6319091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121372;
        bh=jzkCnmhhc3qVfUYlcY04+wWPx92BK3WW+08Dpv5MDng=;
        h=From:To:Date:Message-Id;
        b=ls3rI8Cu8wUVnWFdDUxerkMsCkQOihvBqOi+pXA39VscQ7ktCrI+VPaSzgvvhZHBc
         mEt1Ncsd7vVNqqsO5eFXmGnndm7/7wJeixr/5LQ+CCfJSWQsMeN3Sgr1JXt5vFkZfX
         kwxnFSCNcftqBWHMqs6j0x33rFDbsl1JrOX4xdu/7yQZ8Jqr8MqxL3hVO4CLrbgdSn
         byDlkbyNmRuItnHwynHi8dBBdsYm39HoW+UXt6lrxkiuM8fuon1g3nJTcnJW1lWsJr
         P72Bm+5SadtU31uvfC75/vL2nzDcUUUBzJyo/d6g0HNB1opBu7LIudBL0DzHQySQpi
         qutycQDf14gSw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id deUGm8uTrW2Z; Fri, 29 Jul 2022 15:02:51 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 7ADB6318B56;
        Fri, 29 Jul 2022 15:02:47 -0400 (EDT)
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
        Vincent Chen <vincent.chen@sifive.com>,
        Eric Lin <eric.lin@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 19/23] selftests/rseq: riscv: Template memory ordering and percpu access mode
Date:   Fri, 29 Jul 2022 15:02:21 -0400
Message-Id: <20220729190225.12726-20-mathieu.desnoyers@efficios.com>
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

Introduce a rseq-riscv-bits.h template header which is internally included
to generate the static inline functions covering:

- relaxed and release memory ordering,
- per-cpu-id and per-vm-vcpu-id per-cpu data access.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Chen <vincent.chen@sifive.com>
Cc: Eric Lin <eric.lin@sifive.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../testing/selftests/rseq/rseq-riscv-bits.h  | 410 ++++++++++++++
 tools/testing/selftests/rseq/rseq-riscv.h     | 527 +-----------------
 2 files changed, 437 insertions(+), 500 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-riscv-bits.h

diff --git a/tools/testing/selftests/rseq/rseq-riscv-bits.h b/tools/testing/selftests/rseq/rseq-riscv-bits.h
new file mode 100644
index 000000000000..e42211afdef0
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-riscv-bits.h
@@ -0,0 +1,410 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+
+#include "rseq-bits-template.h"
+
+#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID))
+
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [v]			"m" (*v),
+				    [expect]		"r" (expect),
+				    [newv]		"r" (newv)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
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
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpnev_storeoffp_load)(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_R_LOAD(v)
+				  RSEQ_ASM_OP_R_STORE(load)
+				  RSEQ_ASM_OP_R_LOAD_OFF(voffp)
+				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [v]			"m" (*v),
+				    [expectnot]		"r" (expectnot),
+				    [load]		"m" (*load),
+				    [voffp]		"r" (voffp)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
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
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_addv)(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+#endif
+				  RSEQ_ASM_OP_R_LOAD(v)
+				  RSEQ_ASM_OP_R_ADD(count)
+				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [v]			"m" (*v),
+				    [count]		"r" (count)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1
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
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error3]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[error3]")
+#endif
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [v]			"m" (*v),
+				    [expect]		"r" (expect),
+				    [v2]			"m" (*v2),
+				    [expect2]		"r" (expect2),
+				    [newv]		"r" (newv)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2, error3
+#endif
+	);
+
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
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+#endif
+				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, 3)
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]      "m" (__rseq_abi.cpu_id),
+				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [ptr]			"r" (ptr),
+				    [off]			"er" (off),
+				    [inc]			"er" (inc)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1
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
+#endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID)) */
+
+#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID))
+
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_STORE(newv2, v2)
+				  RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+#else
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+#endif
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [expect]		"r" (expect),
+				    [v]			"m" (*v),
+				    [newv]		"r" (newv),
+				    [v2]			"m" (*v2),
+				    [newv2]		"r" (newv2)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
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
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+				  RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+#else
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+#endif
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [expect]		"r" (expect),
+				    [v]			"m" (*v),
+				    [newv]		"r" (newv),
+				    [dst]			"r" (dst),
+				    [src]			"r" (src),
+				    [len]			"r" (len)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
+				    RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
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
diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index 3394b8f7f322..57eaa491b260 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -165,507 +165,34 @@ do {									\
 	RSEQ_ASM_OP_R_ADD(inc)						\
 	__rseq_str(post_commit_label) ":\n"
 
-static inline __always_inline
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
-				    [v]			"m" (*v),
-				    [expect]		"r" (expect),
-				    [newv]		"r" (newv)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-
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
-static inline __always_inline
-int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_R_LOAD(v)
-				  RSEQ_ASM_OP_R_STORE(load)
-				  RSEQ_ASM_OP_R_LOAD_OFF(voffp)
-				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
-				    [v]			"m" (*v),
-				    [expectnot]		"r" (expectnot),
-				    [load]		"m" (*load),
-				    [voffp]		"r" (voffp)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
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
+/* Per-cpu-id indexing. */
 
-static inline __always_inline
-int rseq_addv(intptr_t *v, intptr_t count, int cpu)
-{
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-#endif
-				  RSEQ_ASM_OP_R_LOAD(v)
-				  RSEQ_ASM_OP_R_ADD(count)
-				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
-				  RSEQ_INJECT_ASM(4)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
-				    [v]			"m" (*v),
-				    [count]		"r" (count)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1
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
-static inline __always_inline
-int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
-				 intptr_t *v2, intptr_t newv2,
-				 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_STORE(newv2, v2)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-				  RSEQ_INJECT_ASM(6)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
-				    [expect]		"r" (expect),
-				    [v]			"m" (*v),
-				    [newv]		"r" (newv),
-				    [v2]			"m" (*v2),
-				    [newv2]		"r" (newv2)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-
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
-static inline __always_inline
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_STORE(newv2, v2)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
-				  RSEQ_INJECT_ASM(6)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
-				    [expect]		"r" (expect),
-				    [v]			"m" (*v),
-				    [newv]		"r" (newv),
-				    [v2]			"m" (*v2),
-				    [newv2]		"r" (newv2)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-
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
-static inline __always_inline
-int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
-			      intptr_t *v2, intptr_t expect2,
-			      intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error3]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[error3]")
-#endif
-				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-				  RSEQ_INJECT_ASM(6)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
-				    [v]			"m" (*v),
-				    [expect]		"r" (expect),
-				    [v2]			"m" (*v2),
-				    [expect2]		"r" (expect2),
-				    [newv]		"r" (newv)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2, error3
-#endif
-	);
-
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
-error3:
-	rseq_bug("2nd expected value comparison failed");
-#endif
-}
-
-static inline __always_inline
-int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
-				 void *dst, void *src, size_t len,
-				 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-				  RSEQ_INJECT_ASM(6)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
-				    [expect]		"r" (expect),
-				    [v]			"m" (*v),
-				    [newv]		"r" (newv),
-				    [dst]			"r" (dst),
-				    [src]			"r" (src),
-				    [len]			"r" (len)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
-				    RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-
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
-static inline __always_inline
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
-				  RSEQ_INJECT_ASM(6)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
-				    [expect]		"r" (expect),
-				    [v]			"m" (*v),
-				    [newv]		"r" (newv),
-				    [dst]			"r" (dst),
-				    [src]			"r" (src),
-				    [len]			"r" (len)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
-				    RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-
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
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
 
-#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+/* Per-vm-vcpu-id indexing. */
 
-/*
- *   pval = *(ptr+off)
- *  *pval += inc;
- */
-static inline __always_inline
-int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-#endif
-				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, 3)
-				  RSEQ_INJECT_ASM(4)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]      "m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
-				    [ptr]			"r" (ptr),
-				    [off]			"er" (off),
-				    [inc]			"er" (inc)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1
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
+#define RSEQ_TEMPLATE_VM_VCPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_VM_VCPU_ID
+
+/* APIs which are not based on cpu ids. */
+
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
-- 
2.17.1

