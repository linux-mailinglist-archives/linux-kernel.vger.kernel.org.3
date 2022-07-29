Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D701D585560
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbiG2TEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbiG2TDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:03:42 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA3987363;
        Fri, 29 Jul 2022 12:02:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E16F8319224;
        Fri, 29 Jul 2022 15:02:57 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rCmgRUxmJdiD; Fri, 29 Jul 2022 15:02:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 151F531901E;
        Fri, 29 Jul 2022 15:02:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 151F531901E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121371;
        bh=72wfAitEHiItqXZlrIcuqBtLmisIhXE41Z/bA9PJlsQ=;
        h=From:To:Date:Message-Id;
        b=pW2uzCNCI1hPJ9vXMYNy/sjTvBXgEa0WFeP+2Xhm6c9gYzpMoIgKlIeMOAMBMlJ4j
         FVrc72s8+Vx4MG1ENDJ3WI9KyF/ebviMyq8v+LFFV2dZT5gW+Z1XYGtEfjql8yucw6
         /WHOClSW1bduKgysel0SyU5AGu/VCzCLrpQmSIByuzxyubdjiXNGFedKU+YzxEzGtH
         oqtJ0nbYqO7FpBXTfifK6bkPFpirWP5w+GfGoyIb+TbmqvFM/yGS7cJK4PTVc5NgXS
         YJtzo1U/XImQz6YOCuCTmeWakNa9zFW16ClZ2+eei606c6wKTaslHfiPgAq817uLIw
         R6aiZvu/zxjhA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BODA501znHfj; Fri, 29 Jul 2022 15:02:51 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 35BCC318A76;
        Fri, 29 Jul 2022 15:02:45 -0400 (EDT)
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
Subject: [PATCH v3 13/23] selftests/rseq: x86: Template memory ordering and percpu access mode
Date:   Fri, 29 Jul 2022 15:02:15 -0400
Message-Id: <20220729190225.12726-14-mathieu.desnoyers@efficios.com>
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

Introduce a rseq-x86-bits.h template header which is internally included
to generate the static inline functions covering:

- relaxed and release memory ordering,
- per-cpu-id and per-vm-vcpu-id per-cpu data access.

This introduces changes to the rseq.h selftests API which require to
update the rseq selftest programs. Similar API/templating changes need
to be done for other architectures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/compiler.h       |    6 +
 .../testing/selftests/rseq/rseq-bits-reset.h  |   10 +
 .../selftests/rseq/rseq-bits-template.h       |   39 +
 tools/testing/selftests/rseq/rseq-x86-bits.h  |  993 ++++++++++++++
 tools/testing/selftests/rseq/rseq-x86.h       | 1181 +----------------
 tools/testing/selftests/rseq/rseq.h           |  159 +++
 6 files changed, 1238 insertions(+), 1150 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-bits-reset.h
 create mode 100644 tools/testing/selftests/rseq/rseq-bits-template.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86-bits.h

diff --git a/tools/testing/selftests/rseq/compiler.h b/tools/testing/selftests/rseq/compiler.h
index 876eb6a7f75b..f47092bddeba 100644
--- a/tools/testing/selftests/rseq/compiler.h
+++ b/tools/testing/selftests/rseq/compiler.h
@@ -27,4 +27,10 @@
  */
 #define rseq_after_asm_goto()	asm volatile ("" : : : "memory")
 
+/* Combine two tokens. */
+#define RSEQ__COMBINE_TOKENS(_tokena, _tokenb)	\
+	_tokena##_tokenb
+#define RSEQ_COMBINE_TOKENS(_tokena, _tokenb)	\
+	RSEQ__COMBINE_TOKENS(_tokena, _tokenb)
+
 #endif  /* RSEQ_COMPILER_H_ */
diff --git a/tools/testing/selftests/rseq/rseq-bits-reset.h b/tools/testing/selftests/rseq/rseq-bits-reset.h
new file mode 100644
index 000000000000..3016070212f3
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-bits-reset.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-bits-reset.h
+ *
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#undef RSEQ_TEMPLATE_IDENTIFIER
+#undef RSEQ_TEMPLATE_CPU_ID_OFFSET
+#undef RSEQ_TEMPLATE_SUFFIX
diff --git a/tools/testing/selftests/rseq/rseq-bits-template.h b/tools/testing/selftests/rseq/rseq-bits-template.h
new file mode 100644
index 000000000000..ea0fe06ef314
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-bits-template.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-bits-template.h
+ *
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifdef RSEQ_TEMPLATE_CPU_ID
+# define RSEQ_TEMPLATE_CPU_ID_OFFSET	RSEQ_CPU_ID_OFFSET
+# ifdef RSEQ_TEMPLATE_MO_RELEASE
+#  define RSEQ_TEMPLATE_SUFFIX		_release_cpu_id
+# elif defined (RSEQ_TEMPLATE_MO_RELAXED)
+#  define RSEQ_TEMPLATE_SUFFIX		_relaxed_cpu_id
+# else
+#  error "Never use <rseq-bits-template.h> directly; include <rseq.h> instead."
+# endif
+#elif defined(RSEQ_TEMPLATE_VM_VCPU_ID)
+# define RSEQ_TEMPLATE_CPU_ID_OFFSET	RSEQ_VM_VCPU_ID_OFFSET
+# ifdef RSEQ_TEMPLATE_MO_RELEASE
+#  define RSEQ_TEMPLATE_SUFFIX		_release_vm_vcpu_id
+# elif defined (RSEQ_TEMPLATE_MO_RELAXED)
+#  define RSEQ_TEMPLATE_SUFFIX		_relaxed_vm_vcpu_id
+# else
+#  error "Never use <rseq-bits-template.h> directly; include <rseq.h> instead."
+# endif
+#elif defined (RSEQ_TEMPLATE_CPU_ID_NONE)
+# ifdef RSEQ_TEMPLATE_MO_RELEASE
+#  define RSEQ_TEMPLATE_SUFFIX		_release
+# elif defined (RSEQ_TEMPLATE_MO_RELAXED)
+#  define RSEQ_TEMPLATE_SUFFIX		_relaxed
+# else
+#  error "Never use <rseq-bits-template.h> directly; include <rseq.h> instead."
+# endif
+#else
+# error "Never use <rseq-bits-template.h> directly; include <rseq.h> instead."
+#endif
+
+#define RSEQ_TEMPLATE_IDENTIFIER(x)	RSEQ_COMBINE_TOKENS(x, RSEQ_TEMPLATE_SUFFIX)
+
diff --git a/tools/testing/selftests/rseq/rseq-x86-bits.h b/tools/testing/selftests/rseq/rseq-x86-bits.h
new file mode 100644
index 000000000000..28ca77cc876c
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-x86-bits.h
@@ -0,0 +1,993 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-x86-bits.h
+ *
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include "rseq-bits-template.h"
+
+#ifdef __x86_64__
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
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
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
+/*
+ * Compare @v against @expectnot. When it does _not_ match, load @v
+ * into @load, and store the content of *@v + voffp into @v.
+ */
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
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movq %[v], %%rbx\n\t"
+		"cmpq %%rbx, %[expectnot]\n\t"
+		"je %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"movq %[v], %%rbx\n\t"
+		"cmpq %%rbx, %[expectnot]\n\t"
+		"je %l[error2]\n\t"
+#endif
+		"movq %%rbx, %[load]\n\t"
+		"addq %[voffp], %%rbx\n\t"
+		"movq (%%rbx), %%rbx\n\t"
+		/* final store */
+		"movq %%rbx, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"er" (voffp),
+		  [load]		"m" (*load)
+		: "memory", "cc", "rax", "rbx"
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
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+#endif
+		/* final store */
+		"addq %[count], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"er" (count)
+		: "memory", "cc", "rax"
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
+#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, long off, intptr_t inc, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+#endif
+		/* get p+v */
+		"movq %[ptr], %%rbx\n\t"
+		"addq %[off], %%rbx\n\t"
+		/* get pv */
+		"movq (%%rbx), %%rcx\n\t"
+		/* *pv += inc */
+		"addq %[inc], (%%rcx)\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [ptr]			"m" (*ptr),
+		  [off]			"er" (off),
+		  [inc]			"er" (inc)
+		: "memory", "cc", "rax", "rbx", "rcx"
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
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"cmpq %[v2], %[expect2]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+		"cmpq %[v2], %[expect2]\n\t"
+		"jnz %l[error3]\n\t"
+#endif
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
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
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		"movq %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
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
+	uint64_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		"movq %[src], %[rseq_scratch0]\n\t"
+		"movq %[dst], %[rseq_scratch1]\n\t"
+		"movq %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 6f)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		"test %[len], %[len]\n\t" \
+		"jz 333f\n\t" \
+		"222:\n\t" \
+		"movb (%[src]), %%al\n\t" \
+		"movb %%al, (%[dst])\n\t" \
+		"inc %[src]\n\t" \
+		"inc %[dst]\n\t" \
+		"dec %[len]\n\t" \
+		"jnz 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"movq %[rseq_scratch2], %[len]\n\t"
+		"movq %[rseq_scratch1], %[dst]\n\t"
+		"movq %[rseq_scratch0], %[src]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
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
+		: "memory", "cc", "rax"
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
+#elif defined(__i386__)
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
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* final store */
+		"movl %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "eax"
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
+/*
+ * Compare @v against @expectnot. When it does _not_ match, load @v
+ * into @load, and store the content of *@v + voffp into @v.
+ */
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
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[v], %%ebx\n\t"
+		"cmpl %%ebx, %[expectnot]\n\t"
+		"je %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"movl %[v], %%ebx\n\t"
+		"cmpl %%ebx, %[expectnot]\n\t"
+		"je %l[error2]\n\t"
+#endif
+		"movl %%ebx, %[load]\n\t"
+		"addl %[voffp], %%ebx\n\t"
+		"movl (%%ebx), %%ebx\n\t"
+		/* final store */
+		"movl %%ebx, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"ir" (voffp),
+		  [load]		"m" (*load)
+		: "memory", "cc", "eax", "ebx"
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
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+#endif
+		/* final store */
+		"addl %[count], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"ir" (count)
+		: "memory", "cc", "eax"
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
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"cmpl %[expect2], %[v2]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+		"cmpl %[expect2], %[v2]\n\t"
+		"jnz %l[error3]\n\t"
+#endif
+		"movl %[newv], %%eax\n\t"
+		/* final store */
+		"movl %%eax, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"m" (newv)
+		: "memory", "cc", "eax"
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
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
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
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %[v], %%eax\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"movl %[expect], %%eax\n\t"
+		"cmpl %[v], %%eax\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		"movl %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		"lock; addl $0,-128(%%esp)\n\t"
+#endif
+		/* final store */
+		"movl %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"m" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "eax"
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
+
+}
+
+/* TODO: implement a faster memcpy. */
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		"movl %[src], %[rseq_scratch0]\n\t"
+		"movl %[dst], %[rseq_scratch1]\n\t"
+		"movl %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 6f)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		"test %[len], %[len]\n\t" \
+		"jz 333f\n\t" \
+		"222:\n\t" \
+		"movb (%[src]), %%al\n\t" \
+		"movb %%al, (%[dst])\n\t" \
+		"inc %[src]\n\t" \
+		"inc %[dst]\n\t" \
+		"dec %[len]\n\t" \
+		"jnz 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		"lock; addl $0,-128(%%esp)\n\t"
+#endif
+		"movl %[newv], %%eax\n\t"
+		/* final store */
+		"movl %%eax, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"movl %[rseq_scratch2], %[len]\n\t"
+		"movl %[rseq_scratch1], %[dst]\n\t"
+		"movl %[rseq_scratch0], %[src]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"m" (expect),
+		  [newv]		"m" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		: "memory", "cc", "eax"
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
+#endif
+
+#include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index e148dfb2f68a..a526a6ad3a81 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -2,9 +2,13 @@
 /*
  * rseq-x86.h
  *
- * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
+#ifndef RSEQ_H
+#error "Never use <rseq-x86.h> directly; include <rseq.h> instead."
+#endif
+
 #include <stdint.h>
 
 /*
@@ -22,9 +26,10 @@
  * address through a "r" input operand.
  */
 
-/* Offset of cpu_id and rseq_cs fields in struct rseq. */
+/* Offset of cpu_id, rseq_cs, and vm_vcpu_id fields in struct rseq. */
 #define RSEQ_CPU_ID_OFFSET	4
 #define RSEQ_CS_OFFSET		8
+#define RSEQ_VM_VCPU_ID_OFFSET	24
 
 #ifdef __x86_64__
 
@@ -108,523 +113,6 @@ do {									\
 		"jmp %l[" __rseq_str(cmpfail_label) "]\n\t"		\
 		".popsection\n\t"
 
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
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-#endif
-		/* final store */
-		"movq %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "rax"
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
-/*
- * Compare @v against @expectnot. When it does _not_ match, load @v
- * into @load, and store the content of *@v + voffp into @v.
- */
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
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"movq %[v], %%rbx\n\t"
-		"cmpq %%rbx, %[expectnot]\n\t"
-		"je %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"movq %[v], %%rbx\n\t"
-		"cmpq %%rbx, %[expectnot]\n\t"
-		"je %l[error2]\n\t"
-#endif
-		"movq %%rbx, %[load]\n\t"
-		"addq %[voffp], %%rbx\n\t"
-		"movq (%%rbx), %%rbx\n\t"
-		/* final store */
-		"movq %%rbx, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expectnot]		"r" (expectnot),
-		  [voffp]		"er" (voffp),
-		  [load]		"m" (*load)
-		: "memory", "cc", "rax", "rbx"
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
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-#endif
-		/* final store */
-		"addq %[count], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [count]		"er" (count)
-		: "memory", "cc", "rax"
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
-#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
-
-/*
- *   pval = *(ptr+off)
- *  *pval += inc;
- */
-static inline __attribute__((always_inline))
-int rseq_offset_deref_addv(intptr_t *ptr, long off, intptr_t inc, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-#endif
-		/* get p+v */
-		"movq %[ptr], %%rbx\n\t"
-		"addq %[off], %%rbx\n\t"
-		/* get pv */
-		"movq (%%rbx), %%rcx\n\t"
-		/* *pv += inc */
-		"addq %[inc], (%%rcx)\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [ptr]			"m" (*ptr),
-		  [off]			"er" (off),
-		  [inc]			"er" (inc)
-		: "memory", "cc", "rax", "rbx", "rcx"
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
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-#endif
-		/* try store */
-		"movq %[newv2], %[v2]\n\t"
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		"movq %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* try store input */
-		  [v2]			"m" (*v2),
-		  [newv2]		"r" (newv2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "rax"
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
-/* x86-64 is TSO. */
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	return rseq_cmpeqv_trystorev_storev(v, expect, v2, newv2, newv, cpu);
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
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-		"cmpq %[v2], %[expect2]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-		"cmpq %[v2], %[expect2]\n\t"
-		"jnz %l[error3]\n\t"
-#endif
-		/* final store */
-		"movq %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* cmp2 input */
-		  [v2]			"m" (*v2),
-		  [expect2]		"r" (expect2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "rax"
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
-	uint64_t rseq_scratch[3];
-
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		"movq %[src], %[rseq_scratch0]\n\t"
-		"movq %[dst], %[rseq_scratch1]\n\t"
-		"movq %[len], %[rseq_scratch2]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpq %[v], %[expect]\n\t"
-		"jnz 5f\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
-		"cmpq %[v], %[expect]\n\t"
-		"jnz 7f\n\t"
-#endif
-		/* try memcpy */
-		"test %[len], %[len]\n\t" \
-		"jz 333f\n\t" \
-		"222:\n\t" \
-		"movb (%[src]), %%al\n\t" \
-		"movb %%al, (%[dst])\n\t" \
-		"inc %[src]\n\t" \
-		"inc %[dst]\n\t" \
-		"dec %[len]\n\t" \
-		"jnz 222b\n\t" \
-		"333:\n\t" \
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		"movq %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		"movq %[rseq_scratch2], %[len]\n\t"
-		"movq %[rseq_scratch1], %[dst]\n\t"
-		"movq %[rseq_scratch0], %[src]\n\t"
-		RSEQ_ASM_DEFINE_ABORT(4,
-			"movq %[rseq_scratch2], %[len]\n\t"
-			"movq %[rseq_scratch1], %[dst]\n\t"
-			"movq %[rseq_scratch0], %[src]\n\t",
-			abort)
-		RSEQ_ASM_DEFINE_CMPFAIL(5,
-			"movq %[rseq_scratch2], %[len]\n\t"
-			"movq %[rseq_scratch1], %[dst]\n\t"
-			"movq %[rseq_scratch0], %[src]\n\t",
-			cmpfail)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_CMPFAIL(6,
-			"movq %[rseq_scratch2], %[len]\n\t"
-			"movq %[rseq_scratch1], %[dst]\n\t"
-			"movq %[rseq_scratch0], %[src]\n\t",
-			error1)
-		RSEQ_ASM_DEFINE_CMPFAIL(7,
-			"movq %[rseq_scratch2], %[len]\n\t"
-			"movq %[rseq_scratch1], %[dst]\n\t"
-			"movq %[rseq_scratch0], %[src]\n\t",
-			error2)
-#endif
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
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
-		: "memory", "cc", "rax"
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
-/* x86-64 is TSO. */
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	return rseq_cmpeqv_trymemcpy_storev(v, expect, dst, src, len,
-					    newv, cpu);
-}
-
 #elif defined(__i386__)
 
 #define RSEQ_ASM_TP_SEGMENT	%%gs
@@ -711,643 +199,36 @@ do {									\
 		"jmp %l[" __rseq_str(cmpfail_label) "]\n\t"		\
 		".popsection\n\t"
 
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
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-#endif
-		/* final store */
-		"movl %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "eax"
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
-/*
- * Compare @v against @expectnot. When it does _not_ match, load @v
- * into @load, and store the content of *@v + voffp into @v.
- */
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
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"movl %[v], %%ebx\n\t"
-		"cmpl %%ebx, %[expectnot]\n\t"
-		"je %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"movl %[v], %%ebx\n\t"
-		"cmpl %%ebx, %[expectnot]\n\t"
-		"je %l[error2]\n\t"
-#endif
-		"movl %%ebx, %[load]\n\t"
-		"addl %[voffp], %%ebx\n\t"
-		"movl (%%ebx), %%ebx\n\t"
-		/* final store */
-		"movl %%ebx, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expectnot]		"r" (expectnot),
-		  [voffp]		"ir" (voffp),
-		  [load]		"m" (*load)
-		: "memory", "cc", "eax", "ebx"
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
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-#endif
-		/* final store */
-		"addl %[count], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [count]		"ir" (count)
-		: "memory", "cc", "eax"
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
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-#endif
-		/* try store */
-		"movl %[newv2], %%eax\n\t"
-		"movl %%eax, %[v2]\n\t"
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		"movl %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* try store input */
-		  [v2]			"m" (*v2),
-		  [newv2]		"m" (newv2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "eax"
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
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"movl %[expect], %%eax\n\t"
-		"cmpl %[v], %%eax\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"movl %[expect], %%eax\n\t"
-		"cmpl %[v], %%eax\n\t"
-		"jnz %l[error2]\n\t"
-#endif
-		/* try store */
-		"movl %[newv2], %[v2]\n\t"
-		RSEQ_INJECT_ASM(5)
-		"lock; addl $0,-128(%%esp)\n\t"
-		/* final store */
-		"movl %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* try store input */
-		  [v2]			"m" (*v2),
-		  [newv2]		"r" (newv2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"m" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "eax"
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
 #endif
 
-}
+/* Per-cpu-id indexing. */
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
-			      intptr_t *v2, intptr_t expect2,
-			      intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-		"cmpl %[expect2], %[v2]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-		"cmpl %[expect2], %[v2]\n\t"
-		"jnz %l[error3]\n\t"
-#endif
-		"movl %[newv], %%eax\n\t"
-		/* final store */
-		"movl %%eax, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* cmp2 input */
-		  [v2]			"m" (*v2),
-		  [expect2]		"r" (expect2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"m" (newv)
-		: "memory", "cc", "eax"
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
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
 
-/* TODO: implement a faster memcpy. */
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
-				 void *dst, void *src, size_t len,
-				 intptr_t newv, int cpu)
-{
-	uint32_t rseq_scratch[3];
+/* Per-vm-vcpu-id indexing. */
 
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_VM_VCPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		"movl %[src], %[rseq_scratch0]\n\t"
-		"movl %[dst], %[rseq_scratch1]\n\t"
-		"movl %[len], %[rseq_scratch2]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"movl %[expect], %%eax\n\t"
-		"cmpl %%eax, %[v]\n\t"
-		"jnz 5f\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
-		"movl %[expect], %%eax\n\t"
-		"cmpl %%eax, %[v]\n\t"
-		"jnz 7f\n\t"
-#endif
-		/* try memcpy */
-		"test %[len], %[len]\n\t" \
-		"jz 333f\n\t" \
-		"222:\n\t" \
-		"movb (%[src]), %%al\n\t" \
-		"movb %%al, (%[dst])\n\t" \
-		"inc %[src]\n\t" \
-		"inc %[dst]\n\t" \
-		"dec %[len]\n\t" \
-		"jnz 222b\n\t" \
-		"333:\n\t" \
-		RSEQ_INJECT_ASM(5)
-		"movl %[newv], %%eax\n\t"
-		/* final store */
-		"movl %%eax, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		"movl %[rseq_scratch2], %[len]\n\t"
-		"movl %[rseq_scratch1], %[dst]\n\t"
-		"movl %[rseq_scratch0], %[src]\n\t"
-		RSEQ_ASM_DEFINE_ABORT(4,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			abort)
-		RSEQ_ASM_DEFINE_CMPFAIL(5,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			cmpfail)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_CMPFAIL(6,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			error1)
-		RSEQ_ASM_DEFINE_CMPFAIL(7,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			error2)
-#endif
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"m" (expect),
-		  [newv]		"m" (newv),
-		  /* try memcpy input */
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len),
-		  [rseq_scratch0]	"m" (rseq_scratch[0]),
-		  [rseq_scratch1]	"m" (rseq_scratch[1]),
-		  [rseq_scratch2]	"m" (rseq_scratch[2])
-		: "memory", "cc", "eax"
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
-/* TODO: implement a faster memcpy. */
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	uint32_t rseq_scratch[3];
-
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_VM_VCPU_ID
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		"movl %[src], %[rseq_scratch0]\n\t"
-		"movl %[dst], %[rseq_scratch1]\n\t"
-		"movl %[len], %[rseq_scratch2]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"movl %[expect], %%eax\n\t"
-		"cmpl %%eax, %[v]\n\t"
-		"jnz 5f\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
-		"movl %[expect], %%eax\n\t"
-		"cmpl %%eax, %[v]\n\t"
-		"jnz 7f\n\t"
-#endif
-		/* try memcpy */
-		"test %[len], %[len]\n\t" \
-		"jz 333f\n\t" \
-		"222:\n\t" \
-		"movb (%[src]), %%al\n\t" \
-		"movb %%al, (%[dst])\n\t" \
-		"inc %[src]\n\t" \
-		"inc %[dst]\n\t" \
-		"dec %[len]\n\t" \
-		"jnz 222b\n\t" \
-		"333:\n\t" \
-		RSEQ_INJECT_ASM(5)
-		"lock; addl $0,-128(%%esp)\n\t"
-		"movl %[newv], %%eax\n\t"
-		/* final store */
-		"movl %%eax, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		"movl %[rseq_scratch2], %[len]\n\t"
-		"movl %[rseq_scratch1], %[dst]\n\t"
-		"movl %[rseq_scratch0], %[src]\n\t"
-		RSEQ_ASM_DEFINE_ABORT(4,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			abort)
-		RSEQ_ASM_DEFINE_CMPFAIL(5,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			cmpfail)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_CMPFAIL(6,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			error1)
-		RSEQ_ASM_DEFINE_CMPFAIL(7,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			error2)
-#endif
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"m" (expect),
-		  [newv]		"m" (newv),
-		  /* try memcpy input */
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len),
-		  [rseq_scratch0]	"m" (rseq_scratch[0]),
-		  [rseq_scratch1]	"m" (rseq_scratch[1]),
-		  [rseq_scratch2]	"m" (rseq_scratch[2])
-		: "memory", "cc", "eax"
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
+/* APIs which are not based on cpu ids. */
 
-#endif
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 003e0e3750ce..95a76a1c3b27 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -74,6 +74,20 @@ extern unsigned int rseq_flags;
  */
 extern unsigned int rseq_feature_size;
 
+enum rseq_mo {
+	RSEQ_MO_RELAXED = 0,
+	RSEQ_MO_CONSUME = 1,	/* Unused */
+	RSEQ_MO_ACQUIRE = 2,	/* Unused */
+	RSEQ_MO_RELEASE = 3,
+	RSEQ_MO_ACQ_REL = 4,	/* Unused */
+	RSEQ_MO_SEQ_CST = 5,	/* Unused */
+};
+
+enum rseq_percpu_mode {
+	RSEQ_PERCPU_CPU_ID = 0,
+	RSEQ_PERCPU_VM_VCPU_ID = 1,
+};
+
 static inline struct rseq_abi *rseq_get_abi(void)
 {
 	return (struct rseq_abi *) ((uintptr_t) rseq_thread_pointer() + rseq_offset);
@@ -222,4 +236,149 @@ static inline void rseq_prepare_unload(void)
 	rseq_clear_rseq_cs();
 }
 
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+		       intptr_t *v, intptr_t expect,
+		       intptr_t newv, int cpu)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	switch (percpu_mode) {
+	case RSEQ_PERCPU_CPU_ID:
+		return rseq_cmpeqv_storev_relaxed_cpu_id(v, expect, newv, cpu);
+	case RSEQ_PERCPU_VM_VCPU_ID:
+		return rseq_cmpeqv_storev_relaxed_vm_vcpu_id(v, expect, newv, cpu);
+	}
+	return -1;
+}
+
+/*
+ * Compare @v against @expectnot. When it does _not_ match, load @v
+ * into @load, and store the content of *@v + voffp into @v.
+ */
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+			       intptr_t *v, intptr_t expectnot, long voffp, intptr_t *load,
+			       int cpu)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	switch (percpu_mode) {
+	case RSEQ_PERCPU_CPU_ID:
+		return rseq_cmpnev_storeoffp_load_relaxed_cpu_id(v, expectnot, voffp, load, cpu);
+	case RSEQ_PERCPU_VM_VCPU_ID:
+		return rseq_cmpnev_storeoffp_load_relaxed_vm_vcpu_id(v, expectnot, voffp, load, cpu);
+	}
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+	      intptr_t *v, intptr_t count, int cpu)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	switch (percpu_mode) {
+	case RSEQ_PERCPU_CPU_ID:
+		return rseq_addv_relaxed_cpu_id(v, count, cpu);
+	case RSEQ_PERCPU_VM_VCPU_ID:
+		return rseq_addv_relaxed_vm_vcpu_id(v, count, cpu);
+	}
+	return -1;
+}
+
+#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __attribute__((always_inline))
+int rseq_offset_deref_addv(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+			   intptr_t *ptr, long off, intptr_t inc, int cpu)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	switch (percpu_mode) {
+	case RSEQ_PERCPU_CPU_ID:
+		return rseq_offset_deref_addv_relaxed_cpu_id(ptr, off, inc, cpu);
+	case RSEQ_PERCPU_VM_VCPU_ID:
+		return rseq_offset_deref_addv_relaxed_vm_vcpu_id(ptr, off, inc, cpu);
+	}
+	return -1;
+}
+#endif
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+				 intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	switch (rseq_mo) {
+	case RSEQ_MO_RELAXED:
+		switch (percpu_mode) {
+		case RSEQ_PERCPU_CPU_ID:
+			return rseq_cmpeqv_trystorev_storev_relaxed_cpu_id(v, expect, v2, newv2, newv, cpu);
+		case RSEQ_PERCPU_VM_VCPU_ID:
+			return rseq_cmpeqv_trystorev_storev_relaxed_vm_vcpu_id(v, expect, v2, newv2, newv, cpu);
+		}
+		return -1;
+	case RSEQ_MO_RELEASE:
+		switch (percpu_mode) {
+		case RSEQ_PERCPU_CPU_ID:
+			return rseq_cmpeqv_trystorev_storev_release_cpu_id(v, expect, v2, newv2, newv, cpu);
+		case RSEQ_PERCPU_VM_VCPU_ID:
+			return rseq_cmpeqv_trystorev_storev_release_vm_vcpu_id(v, expect, v2, newv2, newv, cpu);
+		}
+		return -1;
+	default:
+		return -1;
+	}
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+			      intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	switch (percpu_mode) {
+	case RSEQ_PERCPU_CPU_ID:
+		return rseq_cmpeqv_cmpeqv_storev_relaxed_cpu_id(v, expect, v2, expect2, newv, cpu);
+	case RSEQ_PERCPU_VM_VCPU_ID:
+		return rseq_cmpeqv_cmpeqv_storev_relaxed_vm_vcpu_id(v, expect, v2, expect2, newv, cpu);
+	}
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+				 intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	switch (rseq_mo) {
+	case RSEQ_MO_RELAXED:
+		switch (percpu_mode) {
+		case RSEQ_PERCPU_CPU_ID:
+			return rseq_cmpeqv_trymemcpy_storev_relaxed_cpu_id(v, expect, dst, src, len, newv, cpu);
+		case RSEQ_PERCPU_VM_VCPU_ID:
+			return rseq_cmpeqv_trymemcpy_storev_relaxed_vm_vcpu_id(v, expect, dst, src, len, newv, cpu);
+		}
+		return -1;
+	case RSEQ_MO_RELEASE:
+		switch (percpu_mode) {
+		case RSEQ_PERCPU_CPU_ID:
+			return rseq_cmpeqv_trymemcpy_storev_release_cpu_id(v, expect, dst, src, len, newv, cpu);
+		case RSEQ_PERCPU_VM_VCPU_ID:
+			return rseq_cmpeqv_trymemcpy_storev_release_vm_vcpu_id(v, expect, dst, src, len, newv, cpu);
+		}
+		return -1;
+	default:
+		return -1;
+	}
+}
+
 #endif  /* RSEQ_H_ */
-- 
2.17.1

