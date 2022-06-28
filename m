Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B9455D917
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbiF1HRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbiF1HQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:16:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA572C677;
        Tue, 28 Jun 2022 00:16:49 -0700 (PDT)
Date:   Tue, 28 Jun 2022 07:16:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656400608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7X5Kec0L7pw8Q4seMcLd4oIQMAdicOFNGv0zfK6xBxE=;
        b=4A5YDh62RdZD92JrcUQWiVNDKGvSkD8byYWnxHE1BFdXNd5R1brxEts/3KklONpCQm/8dC
        q6263uhvJPopwmJYwUUyGEilMX55iqjyINF0An+EkuvuLtwuBeX/EJNdtLQowTZC5Jr1MH
        epjSQ7I1VrsrBt/5/UkDE2C5xJBGT8nxL2TglgX+ZrrTrjPCv4cC/9XCq9kT8Wj0X3yQbp
        lo9eyzy5EPCg9S1++aY6WQovivi223DoIa4zrsqaylwVYVG355TcvBEThZ7f3PJMFdH91+
        MKd6IIwnhmXs44F4Nde3lqD3q4dHyXYEBdNVNInjmlRR6B0od9mrgV6Br2/Vmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656400608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7X5Kec0L7pw8Q4seMcLd4oIQMAdicOFNGv0zfK6xBxE=;
        b=g6MRNazjY361KnyJC1Mhmdt0eEpFe0l53yOtLIx8avY/fOXAYhJFixtVASKy7MT3TTE+L4
        KME9yYbCqd3JcQBw==
From:   "tip-bot2 for Michael Jeanson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: riscv: use rseq_get_abi() helper
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220614154830.1367382-2-mjeanson@efficios.com>
References: <20220614154830.1367382-2-mjeanson@efficios.com>
MIME-Version: 1.0
Message-ID: <165640060703.4207.13582940534637128711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4f3394924358fe04ced0411c72fc7eeb0d3be652
Gitweb:        https://git.kernel.org/tip/4f3394924358fe04ced0411c72fc7eeb0d3be652
Author:        Michael Jeanson <mjeanson@efficios.com>
AuthorDate:    Tue, 14 Jun 2022 11:48:28 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:08:28 +02:00

selftests/rseq: riscv: use rseq_get_abi() helper

Make the RISC-V rseq selftests compatible with glibc-2.35 by using the
rseq_get_abi() helper.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/r/20220614154830.1367382-2-mjeanson@efficios.com
---
 tools/testing/selftests/rseq/rseq-riscv.h | 36 +++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index b86642f..6f8a605 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -194,8 +194,8 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
 				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [v]			"m" (*v),
 				    [expect]		"r" (expect),
 				    [newv]		"r" (newv)
@@ -251,8 +251,8 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
 				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [v]			"m" (*v),
 				    [expectnot]		"r" (expectnot),
 				    [load]		"m" (*load),
@@ -301,8 +301,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
 				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [v]			"m" (*v),
 				    [count]		"r" (count)
 				    RSEQ_INJECT_INPUT
@@ -352,8 +352,8 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
 				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [expect]		"r" (expect),
 				    [v]			"m" (*v),
 				    [newv]		"r" (newv),
@@ -411,8 +411,8 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
 				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [expect]		"r" (expect),
 				    [v]			"m" (*v),
 				    [newv]		"r" (newv),
@@ -472,8 +472,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
 				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [v]			"m" (*v),
 				    [expect]		"r" (expect),
 				    [v2]			"m" (*v2),
@@ -532,8 +532,8 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
 				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [expect]		"r" (expect),
 				    [v]			"m" (*v),
 				    [newv]		"r" (newv),
@@ -593,8 +593,8 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
 				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [expect]		"r" (expect),
 				    [v]			"m" (*v),
 				    [newv]		"r" (newv),
@@ -651,8 +651,8 @@ int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
 				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]      "m" (__rseq_abi.cpu_id),
-				    [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+				    [current_cpu_id]      "m" (rseq_get_abi()->cpu_id),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [ptr]			"r" (ptr),
 				    [off]			"er" (off),
 				    [inc]			"er" (inc)
