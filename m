Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0861E49110D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243208AbiAQUj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:39:57 -0500
Received: from mail.efficios.com ([167.114.26.124]:46734 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243053AbiAQUjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:39:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CF4FA304A37;
        Mon, 17 Jan 2022 15:39:40 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qzsmsax8qnEp; Mon, 17 Jan 2022 15:39:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 73655304AB7;
        Mon, 17 Jan 2022 15:39:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 73655304AB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642451979;
        bh=AVGrasYVbMMc1WklGkEfHByfaj1LaGuZM0/f6Gc/8jo=;
        h=From:To:Date:Message-Id;
        b=e3V5GtwJgL9KBIPb8d4i51jdwQiKpnYtTO3vXh3OC2rmweR0FY3BbMKxTuxYi6swZ
         iBic1v1dbIDPZEjHMRP+Ut+PaT4zcCRcpzRJQGHMoXgiEQJK3Dk45l9QwE0s8zfTgJ
         ZDqu5G92DFzByOSnwX+9YTJ4mRNtG3eFfIX+cx0FJ3BPFB0zloMLuYVFbXzVqfIWka
         o+CQcBu1nKUCZolPEi3CUMQ9XB+YI7F+BRtw9InAydhi7UOM0UXgwUd6zQ/D0Dc+4i
         bs9IcseM+8T7END8D68ym8Li+y52Om90OCc3jt+vMWgH5rJ4Upx08+/e4MMC/BPQru
         AVNyatQN0teVQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eJIpdy8VN7zj; Mon, 17 Jan 2022 15:39:39 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 211E430476E;
        Mon, 17 Jan 2022 15:39:39 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 3/5] selftests/rseq: Introduce rseq_get_abi() helper
Date:   Mon, 17 Jan 2022 15:39:23 -0500
Message-Id: <20220117203925.12164-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
References: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done in preparation for the selftest uplift to become compatible
with glibc-2.35.

glibc-2.35 exposes the rseq per-thread data in the TCB, accessible
at an offset from the thread pointer, rather than through an actual
Thread-Local Storage (TLS) variable, as the kernel selftests initially
expected.

Introduce a rseq_get_abi() helper, initially using the __rseq_abi
TLS variable, in preparation for changing this userspace ABI for one
which is compatible with glibc-2.35.

Note that the __rseq_abi TLS and glibc-2.35's ABI for per-thread data
cannot actively coexist in a process, because the kernel supports only
a single rseq registration per thread.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-arm.h   | 32 +++++++++++------------
 tools/testing/selftests/rseq/rseq-arm64.h | 32 +++++++++++------------
 tools/testing/selftests/rseq/rseq-mips.h  | 32 +++++++++++------------
 tools/testing/selftests/rseq/rseq-ppc.h   | 32 +++++++++++------------
 tools/testing/selftests/rseq/rseq-s390.h  | 24 ++++++++---------
 tools/testing/selftests/rseq/rseq-x86.h   | 30 ++++++++++-----------
 tools/testing/selftests/rseq/rseq.h       | 13 ++++++---
 7 files changed, 100 insertions(+), 95 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 5943c816c07c..6716540e17c6 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -185,8 +185,8 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -255,8 +255,8 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -316,8 +316,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [v]			"m" (*v),
 		  [count]		"Ir" (count)
 		  RSEQ_INJECT_INPUT
@@ -381,8 +381,8 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -457,8 +457,8 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -537,8 +537,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -657,8 +657,8 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		"8:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -782,8 +782,8 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		"8:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 200dae9e4208..b9d9b3aa6e9b 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -230,8 +230,8 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [v]			"Qo" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -287,8 +287,8 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [v]			"Qo" (*v),
 		  [expectnot]		"r" (expectnot),
 		  [load]		"Qo" (*load),
@@ -337,8 +337,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [v]			"Qo" (*v),
 		  [count]		"r" (count)
 		  RSEQ_INJECT_INPUT
@@ -388,8 +388,8 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
@@ -447,8 +447,8 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
@@ -508,8 +508,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [v]			"Qo" (*v),
 		  [expect]		"r" (expect),
 		  [v2]			"Qo" (*v2),
@@ -569,8 +569,8 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
@@ -629,8 +629,8 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index e989e7c14b09..2b1f5bd95268 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -190,8 +190,8 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -258,8 +258,8 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -319,8 +319,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [v]			"m" (*v),
 		  [count]		"Ir" (count)
 		  RSEQ_INJECT_INPUT
@@ -382,8 +382,8 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -456,8 +456,8 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -532,8 +532,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		"5:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -649,8 +649,8 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		"8:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -771,8 +771,8 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		"8:\n\t"
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index 76be90196fe4..2e6b7572ba08 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -235,8 +235,8 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -301,8 +301,8 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -359,8 +359,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"r" (count)
@@ -419,8 +419,8 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -489,8 +489,8 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -560,8 +560,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -635,8 +635,8 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -711,8 +711,8 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 8ef94ad1cbb4..b906e044d2a3 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -165,8 +165,8 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -233,8 +233,8 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -288,8 +288,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"r" (count)
@@ -347,8 +347,8 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -426,8 +426,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -534,8 +534,8 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index 640411518e46..1d9fa0516e53 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -141,7 +141,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -207,7 +207,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -258,7 +258,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"er" (count)
@@ -314,7 +314,7 @@ int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* final store input */
 		  [ptr]			"m" (*ptr),
 		  [off]			"er" (off),
@@ -372,7 +372,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -449,7 +449,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -555,7 +555,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -719,7 +719,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -785,7 +785,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -836,7 +836,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"ir" (count)
@@ -894,7 +894,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"m" (newv2),
@@ -962,7 +962,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -1032,7 +1032,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -1142,7 +1142,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"m" (expect),
@@ -1255,7 +1255,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_abi]		"r" (&__rseq_abi),
+		  [rseq_abi]		"r" (rseq_get_abi()),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"m" (expect),
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index f971a9217145..3e7b5c54ab3d 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -46,6 +46,11 @@
 extern __thread struct rseq __rseq_abi;
 extern int __rseq_handled;
 
+static inline struct rseq *rseq_get_abi(void)
+{
+	return &__rseq_abi;
+}
+
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
 #define rseq_unlikely(x)	__builtin_expect(!!(x), 0)
 #define rseq_barrier()		__asm__ __volatile__("" : : : "memory")
@@ -108,7 +113,7 @@ int32_t rseq_fallback_current_cpu(void);
  */
 static inline int32_t rseq_current_cpu_raw(void)
 {
-	return RSEQ_ACCESS_ONCE(__rseq_abi.cpu_id);
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->cpu_id);
 }
 
 /*
@@ -124,7 +129,7 @@ static inline int32_t rseq_current_cpu_raw(void)
  */
 static inline uint32_t rseq_cpu_start(void)
 {
-	return RSEQ_ACCESS_ONCE(__rseq_abi.cpu_id_start);
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->cpu_id_start);
 }
 
 static inline uint32_t rseq_current_cpu(void)
@@ -140,9 +145,9 @@ static inline uint32_t rseq_current_cpu(void)
 static inline void rseq_clear_rseq_cs(void)
 {
 #ifdef __LP64__
-	RSEQ_WRITE_ONCE(__rseq_abi.rseq_cs.ptr, 0);
+	RSEQ_WRITE_ONCE(rseq_get_abi()->rseq_cs.ptr, 0);
 #else
-	RSEQ_WRITE_ONCE(__rseq_abi.rseq_cs.ptr.ptr32, 0);
+	RSEQ_WRITE_ONCE(rseq_get_abi()->rseq_cs.ptr.ptr32, 0);
 #endif
 }
 
-- 
2.17.1

