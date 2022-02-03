Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F16C4A8694
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348625AbiBCOfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346637AbiBCOdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C14DC061748;
        Thu,  3 Feb 2022 06:33:49 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898828;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=msML4SXy1z4LgxuF7P8h08vbttLe47Mjh7ylXANH8qk=;
        b=CaOYdtC/BfMddESISz+UYBM8zjw/aA5aZqNgbWNe4yVynBcvaz21SJnd6t2NS186nN72kK
        NTAk44rHmlodXid+KMI9ikGT1N9+s1A6f/rioEoZjFbtOi+IGev6MQRHCP9eTgVnPctCvd
        0P1/yBHBSuTvyHhvS03v1pGAj4sIMODxY93JOuKsWn0JrUbjuXqAMni3HUdsBwj28BmIA5
        L58PN1vO5OqTlx+OOoRBeyJ1D84qNFhvdPUQXgkBGdn3HsXlFFBkVwaOi0XdIMPdA1xrNz
        iWC5VRqy+S9Ym+YhKA/bnyIBwopJvz7pynFY5waB21wiEikGMiL8yD/VIJ6OCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898828;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=msML4SXy1z4LgxuF7P8h08vbttLe47Mjh7ylXANH8qk=;
        b=rbEFH7/CrpHqy6vDmzTLItnFHbBWyYBD2yps1Ss7OqTTfpZ80MPNkalyiG3THwcaAkI5v8
        1OJkFDy03bcK8yCA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Fix ppc32: wrong rseq_cs 32-bit
 field pointer on big endian
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-9-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-9-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389882710.16921.16766628373629367760.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     24d1136a29da5953de5c0cbc6c83eb62a1e0bf14
Gitweb:        https://git.kernel.org/tip/24d1136a29da5953de5c0cbc6c83eb62a1e0bf14
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:46 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:35 +01:00

selftests/rseq: Fix ppc32: wrong rseq_cs 32-bit field pointer on big endian

ppc32 incorrectly uses padding as rseq_cs pointer field. Fix this by
using the rseq_cs.arch.ptr field.

Use this field across all architectures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-9-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/rseq-arm.h   | 16 ++++++++--------
 tools/testing/selftests/rseq/rseq-arm64.h | 16 ++++++++--------
 tools/testing/selftests/rseq/rseq-mips.h  | 16 ++++++++--------
 tools/testing/selftests/rseq/rseq-ppc.h   | 16 ++++++++--------
 tools/testing/selftests/rseq/rseq-s390.h  | 12 ++++++------
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 6716540..5f567b3 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -186,7 +186,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -256,7 +256,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -317,7 +317,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [count]		"Ir" (count)
 		  RSEQ_INJECT_INPUT
@@ -382,7 +382,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -458,7 +458,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -538,7 +538,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -658,7 +658,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -783,7 +783,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index b9d9b3a..d0f2b7f 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -231,7 +231,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"Qo" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -288,7 +288,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"Qo" (*v),
 		  [expectnot]		"r" (expectnot),
 		  [load]		"Qo" (*load),
@@ -338,7 +338,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"Qo" (*v),
 		  [count]		"r" (count)
 		  RSEQ_INJECT_INPUT
@@ -389,7 +389,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
@@ -448,7 +448,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
@@ -509,7 +509,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"Qo" (*v),
 		  [expect]		"r" (expect),
 		  [v2]			"Qo" (*v2),
@@ -570,7 +570,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
@@ -630,7 +630,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 2b1f5bd..6df5427 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -191,7 +191,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -259,7 +259,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -320,7 +320,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [count]		"Ir" (count)
 		  RSEQ_INJECT_INPUT
@@ -383,7 +383,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -457,7 +457,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -533,7 +533,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -650,7 +650,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -772,7 +772,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index 2e6b757..c4ba137 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -236,7 +236,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -302,7 +302,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -360,7 +360,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"r" (count)
@@ -420,7 +420,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -490,7 +490,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -561,7 +561,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -636,7 +636,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -712,7 +712,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index b906e04..9927021 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -166,7 +166,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -234,7 +234,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -289,7 +289,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"r" (count)
@@ -348,7 +348,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -427,7 +427,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -535,7 +535,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
