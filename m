Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8654A869C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351690AbiBCOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:35:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53598 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351330AbiBCOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:43 -0500
Date:   Thu, 03 Feb 2022 14:33:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898822;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oEhdm6SxHY62zgnNJynGHEYOtP+5xY68TFi8zATwSN4=;
        b=zF1UPWtF8LAKxfHR9d2hafZoQuehsa2pT339HTjIsR62lIBrmxoq1PLV9eTV1IqFj9TC56
        mkGho9Yxis/3Ntka8yIym/NSUpbKjY9rO01uS48LCIiq6diholS7AzIyIds2IjoP1+eodC
        otaYW+GdhzAd3x7KSbxNIQpmT+9eNByeLtL+OsYzdlCIBQbUaBUvl6i8RwQ3g6t/T1Ft3I
        xcTPIbuQVekKn/iiJRryz1issHjViVi1Z6VFx1sLSWQAIoCKWfxFDg2mazsMvIDvkBvL9o
        zj6uEbIwxg62bK6mHVFfTdwHI0cWOUxfZdP0IG9w5s0iWtghFWwk9Hmij4RSog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898822;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oEhdm6SxHY62zgnNJynGHEYOtP+5xY68TFi8zATwSN4=;
        b=qK/JJei6up6f/VKsNApqSm0vf4bMUYTb0HCeJM/C8PuaOTRITbsMs/yxf4SnvSfd2INvPl
        LiM3XizkpQJsE9AA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: x86-32: use %gs segment selector
 for accessing rseq thread area
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-16-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-16-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389882171.16921.9829327395460133558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     127b6429d235ab7c358223bbfd8a8b8d8cc799b6
Gitweb:        https://git.kernel.org/tip/127b6429d235ab7c358223bbfd8a8b8d8cc799b6
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:53 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:37 +01:00

selftests/rseq: x86-32: use %gs segment selector for accessing rseq thread area

Rather than use rseq_get_abi() and pass its result through a register to
the inline assembler, directly access the per-thread rseq area through a
memory reference combining the %gs segment selector, the constant offset
of the field in struct rseq, and the rseq_offset value (in a register).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-16-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/rseq-x86.h | 66 ++++++++++++------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index 2976966..f704d36 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -633,6 +633,8 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 #elif defined(__i386__)
 
+#define RSEQ_ASM_TP_SEGMENT	%%gs
+
 #define rseq_smp_mb()	\
 	__asm__ __volatile__ ("lock; addl $0,-128(%%esp)" ::: "memory", "cc")
 #define rseq_smp_rmb()	\
@@ -732,14 +734,14 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 #endif
@@ -750,7 +752,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (rseq_get_abi()),
+		  [rseq_offset]		"r" (rseq_offset),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -798,15 +800,15 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[v], %%ebx\n\t"
 		"cmpl %%ebx, %[expectnot]\n\t"
 		"je %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
 		"movl %[v], %%ebx\n\t"
 		"cmpl %%ebx, %[expectnot]\n\t"
 		"je %l[error2]\n\t"
@@ -821,7 +823,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (rseq_get_abi()),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -864,11 +866,11 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
 		RSEQ_INJECT_ASM(3)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
 #endif
 		/* final store */
 		"addl %[count], %[v]\n\t"
@@ -877,7 +879,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (rseq_get_abi()),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"ir" (count)
@@ -916,14 +918,14 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 #endif
@@ -938,7 +940,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (rseq_get_abi()),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"m" (newv2),
@@ -987,15 +989,15 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %[v], %%eax\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
 		"movl %[expect], %%eax\n\t"
 		"cmpl %[v], %%eax\n\t"
 		"jnz %l[error2]\n\t"
@@ -1011,7 +1013,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (rseq_get_abi()),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -1062,8 +1064,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
@@ -1072,7 +1074,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(5)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 		"cmpl %[expect2], %[v2]\n\t"
@@ -1086,7 +1088,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (rseq_get_abi()),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -1144,15 +1146,15 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		"movl %[dst], %[rseq_scratch1]\n\t"
 		"movl %[len], %[rseq_scratch2]\n\t"
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 5f\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 6f)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 7f\n\t"
@@ -1202,7 +1204,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (rseq_get_abi()),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"m" (expect),
@@ -1261,15 +1263,15 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		"movl %[dst], %[rseq_scratch1]\n\t"
 		"movl %[len], %[rseq_scratch2]\n\t"
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 5f\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 6f)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 7f\n\t"
@@ -1320,7 +1322,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (rseq_get_abi()),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"m" (expect),
