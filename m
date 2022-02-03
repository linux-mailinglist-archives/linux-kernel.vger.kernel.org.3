Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D24A8692
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351359AbiBCOew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:34:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351242AbiBCOdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:47 -0500
Date:   Thu, 03 Feb 2022 14:33:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898826;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hsAogLYT/KWinGplMf4pimQaZWNeQd/iHgKX3h6tuc=;
        b=V4O2ZIKvYbROpgCn8n5ryeXysm34btIDvd5bjl23sG2e8m4+CGiGxm3myu3bQTgwcRhrUX
        hLaexfAsHnPe+nARgmoBaMXN7dNylzjX6Nqj4Ui657xNrk9SF70F3Kyl6k6tJ9MfczbAP1
        SpMTZnc6UIeM0X183KkZO6PfIa2YzDA6TVAJ5ENYACFgPSYSmimSyf8X9A+yEWSWi2v+HL
        3n7tG9i224JZOjdNHhAVINWH6Ro5vNR/Bzd4yIp7ZZxe9MbO2RPlo2tIsnMZvYTMNBgpI8
        yUqO/Y7w711EiQ/Pk0AawXu/y9XpRMTP4zn++EcPWuyFDrywyo26JW+63gKY5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898826;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hsAogLYT/KWinGplMf4pimQaZWNeQd/iHgKX3h6tuc=;
        b=KHTc5aWsJalmEtcgKNZV3OmO8beVxaDqrVix25+dQUbGkBuQg6gU3Q1hXp4OkmkrRacLmi
        /AkD4RvsXHb4uEAA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Fix ppc32 offsets by using long
 rather than off_t
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-11-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-11-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389882555.16921.12530085917050460497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     26dc8a6d8e11552f3b797b5aafe01071ca32d692
Gitweb:        https://git.kernel.org/tip/26dc8a6d8e11552f3b797b5aafe01071ca32d692
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:48 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:36 +01:00

selftests/rseq: Fix ppc32 offsets by using long rather than off_t

The semantic of off_t is for file offsets. We mean to use it as an
offset from a pointer. We really expect it to fit in a single register,
and not use a 64-bit type on 32-bit architectures.

Fix runtime issues on ppc32 where the offset is always 0 due to
inconsistency between the argument type (off_t -> 64-bit) and type
expected by the inline assembler (32-bit).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-11-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/basic_percpu_ops_test.c | 2 +-
 tools/testing/selftests/rseq/param_test.c            | 2 +-
 tools/testing/selftests/rseq/rseq-arm.h              | 2 +-
 tools/testing/selftests/rseq/rseq-arm64.h            | 2 +-
 tools/testing/selftests/rseq/rseq-mips.h             | 2 +-
 tools/testing/selftests/rseq/rseq-ppc.h              | 2 +-
 tools/testing/selftests/rseq/rseq-s390.h             | 2 +-
 tools/testing/selftests/rseq/rseq-skip.h             | 2 +-
 tools/testing/selftests/rseq/rseq-x86.h              | 6 +++---
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index b953a52..517756a 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -167,7 +167,7 @@ struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
 	for (;;) {
 		struct percpu_list_node *head;
 		intptr_t *targetptr, expectnot, *load;
-		off_t offset;
+		long offset;
 		int ret, cpu;
 
 		cpu = rseq_cpu_start();
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index cc2cfc1..335c290 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -549,7 +549,7 @@ struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
 	for (;;) {
 		struct percpu_list_node *head;
 		intptr_t *targetptr, expectnot, *load;
-		off_t offset;
+		long offset;
 		int ret;
 
 		cpu = rseq_cpu_start();
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 5f567b3..ae476af 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -217,7 +217,7 @@ error2:
 
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index d0f2b7f..7806817 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -259,7 +259,7 @@ error2:
 
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 6df5427..0d1d925 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -222,7 +222,7 @@ error2:
 
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index 87befda..aa18c0e 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -270,7 +270,7 @@ error2:
 
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 9927021..0f523b3 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -198,7 +198,7 @@ error2:
  */
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
diff --git a/tools/testing/selftests/rseq/rseq-skip.h b/tools/testing/selftests/rseq/rseq-skip.h
index 72750b5..7b53dac 100644
--- a/tools/testing/selftests/rseq/rseq-skip.h
+++ b/tools/testing/selftests/rseq/rseq-skip.h
@@ -13,7 +13,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	return -1;
 }
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index 1d9fa05..0ee6c04 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -172,7 +172,7 @@ error2:
  */
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
@@ -286,7 +286,7 @@ error1:
  *  *pval += inc;
  */
 static inline __attribute__((always_inline))
-int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
+int rseq_offset_deref_addv(intptr_t *ptr, long off, intptr_t inc, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
@@ -750,7 +750,7 @@ error2:
  */
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
