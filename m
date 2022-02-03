Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8403F4A868B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351563AbiBCOem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:34:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351345AbiBCOdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:45 -0500
Date:   Thu, 03 Feb 2022 14:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQyNSA4HHv1lpBd8YFPnd65nQ/pjSAAaDil8pXm08HU=;
        b=uqM4kGw/vCWpNXsNBb3HBxaYaFqGteph1ZZ1Q8IUTNt/CXpsv1+B3qwI+v2l9ilg9ILcWO
        kWhU8KSsDwbwEfZpMwGUSNvD3+pg7Xj6gTrUtR4MfFmjNnyXs0vq0mzJqDARO92BsaKtyc
        jf+xz35H5TRUC5S2Fmx2EHksyWirKEqpnSpjxNFxcAeeZUoVAPLlRKgybG0r06mwjroRy5
        akvyQJPvmcEiFXFe3wkkzOFFqQ8fPlf3mv+3h2C4j6pQ5Bs5tC3TrTvucEu5F27TGPENSK
        npoqh0zzL5wJW9cTtJF48kH8PQUXejwa2iiF/aZTS5ZQx//faXP8D+/5Z7pZDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQyNSA4HHv1lpBd8YFPnd65nQ/pjSAAaDil8pXm08HU=;
        b=UEB7+Yuvhb20I3sNNJrUc1worjCrWMrjU2GcN+aKskHqaXT4C81IPx2x2Oq6fmbm5MWmtJ
        fQl03SxrOmvCS/AQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Fix: work-around asm goto compiler bugs
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-14-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-14-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389882322.16921.10717882010374150835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b53823fb2ef854222853be164f3b1e815f315144
Gitweb:        https://git.kernel.org/tip/b53823fb2ef854222853be164f3b1e815f315144
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:51 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:37 +01:00

selftests/rseq: Fix: work-around asm goto compiler bugs

gcc and clang each have their own compiler bugs with respect to asm
goto. Implement a work-around for compiler versions known to have those
bugs.

gcc prior to 4.8.2 miscompiles asm goto.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670

gcc prior to 8.1.0 miscompiles asm goto at O1.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=103908

clang prior to version 13.0.1 miscompiles asm goto at O2.
https://github.com/llvm/llvm-project/issues/52735

Work around these issues by adding a volatile inline asm with
memory clobber in the fallthrough after the asm goto and at each
label target.  Emit this for all compilers in case other similar
issues are found in the future.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-14-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/compiler.h   | 30 ++++++++++-
 tools/testing/selftests/rseq/rseq-arm.h   | 39 +++++++++++++-
 tools/testing/selftests/rseq/rseq-arm64.h | 45 +++++++++++++--
 tools/testing/selftests/rseq/rseq-ppc.h   | 39 +++++++++++++-
 tools/testing/selftests/rseq/rseq-s390.h  | 29 +++++++++-
 tools/testing/selftests/rseq/rseq-x86.h   | 68 ++++++++++++++++++++++-
 tools/testing/selftests/rseq/rseq.h       |  1 +-
 7 files changed, 245 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/compiler.h

diff --git a/tools/testing/selftests/rseq/compiler.h b/tools/testing/selftests/rseq/compiler.h
new file mode 100644
index 0000000..876eb6a
--- /dev/null
+++ b/tools/testing/selftests/rseq/compiler.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq/compiler.h
+ *
+ * Work-around asm goto compiler bugs.
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef RSEQ_COMPILER_H
+#define RSEQ_COMPILER_H
+
+/*
+ * gcc prior to 4.8.2 miscompiles asm goto.
+ * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
+ *
+ * gcc prior to 8.1.0 miscompiles asm goto at O1.
+ * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=103908
+ *
+ * clang prior to version 13.0.1 miscompiles asm goto at O2.
+ * https://github.com/llvm/llvm-project/issues/52735
+ *
+ * Work around these issues by adding a volatile inline asm with
+ * memory clobber in the fallthrough after the asm goto and at each
+ * label target.  Emit this for all compilers in case other similar
+ * issues are found in the future.
+ */
+#define rseq_after_asm_goto()	asm volatile ("" : : : "memory")
+
+#endif  /* RSEQ_COMPILER_H_ */
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 64c3a62..893a11e 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -195,16 +195,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -263,16 +268,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -317,12 +327,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -384,16 +397,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -456,16 +474,21 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -532,18 +555,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("1st expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -652,16 +681,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -771,16 +805,21 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 7806817..cbe190a 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -242,17 +242,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -300,16 +304,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -348,12 +357,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -402,17 +414,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -461,17 +477,21 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -522,19 +542,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -584,17 +609,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -644,17 +673,21 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index aa18c0e..bab8e0b 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -254,16 +254,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -322,16 +327,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -378,12 +388,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -442,16 +455,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -512,16 +530,21 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -583,18 +606,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("1st expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -659,16 +688,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -735,16 +769,21 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 0f523b3..4e6dc5f 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -178,16 +178,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -248,16 +253,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -301,12 +311,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -364,16 +377,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -443,18 +461,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("1st expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -555,16 +579,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index e444563..4ab2e74 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -152,16 +152,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -220,16 +225,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -269,12 +279,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -387,16 +400,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -464,18 +482,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("1st expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -574,16 +598,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -730,16 +759,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -798,16 +832,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -847,12 +886,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -909,16 +951,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -977,16 +1024,21 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 
@@ -1047,18 +1099,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("1st expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -1161,16 +1219,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -1274,16 +1337,21 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 17531cc..6bd0ac4 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -17,6 +17,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include "rseq-abi.h"
+#include "compiler.h"
 
 /*
  * Empty code injection macros, override when testing.
