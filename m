Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61F654B525
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347818AbiFNPzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344168AbiFNPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:55:31 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9261AD81
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:55:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CC4263C7CB1;
        Tue, 14 Jun 2022 11:55:29 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id itYXXXpvbikj; Tue, 14 Jun 2022 11:55:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 723133C7CA9;
        Tue, 14 Jun 2022 11:55:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 723133C7CA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1655222129;
        bh=t5335dZt0Ctnir3GGVeElwVHByKBAKwMNFazlIbWBVk=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=ZZnmYUgrX8qQBwriee8Q3kK0XkccqDUizHR39SZd03oqQ7PZCIx6guG9kBAGQ106o
         LUt32oJkl4gPIjMJslhzbrhP3Xql6pZxIv/2sxd8LB/tObMO/k+z2r6il54XToJw68
         Tt7EwyCMiJGq21OhZ93ZNdAN/yPPhb0U93N2UsPwteOocsvoMJThS+ztWoCpcyw0KZ
         ZAnEk4bl5c2MpBsA/Kj2FkC7iz9tHWPLRpS4kT3bSGCQE5o6OQycMCuri0oaELMRMh
         +9wNieJxzVZC2eU5mW3eKzznT0aJnlK4MRExjBAnx04/B65ZNI0Uf+6xW7IL32aH+J
         xIHp8XZwfTg+Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tSXQ_yREM2T4; Tue, 14 Jun 2022 11:55:29 -0400 (EDT)
Received: from laptop-mjeanson.internal.efficios.com (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 473AF3C7BAF;
        Tue, 14 Jun 2022 11:55:29 -0400 (EDT)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH 1/3] selftests/rseq: riscv: use rseq_get_abi() helper
Date:   Tue, 14 Jun 2022 11:48:28 -0400
Message-Id: <20220614154830.1367382-2-mjeanson@efficios.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220614154830.1367382-1-mjeanson@efficios.com>
References: <20220614154830.1367382-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the RISC-V rseq selftests compatible with glibc-2.35 by using the
rseq_get_abi() helper.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tools/testing/selftests/rseq/rseq-riscv.h | 36 +++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/se=
lftests/rseq/rseq-riscv.h
index b86642f90d7f..6f8a605b75c0 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -194,8 +194,8 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, =
intptr_t newv, int cpu)
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
@@ -251,8 +251,8 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t =
expectnot,
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
@@ -352,8 +352,8 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_=
t expect,
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
@@ -411,8 +411,8 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v,=
 intptr_t expect,
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
@@ -472,8 +472,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t e=
xpect,
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
@@ -532,8 +532,8 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_=
t expect,
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
@@ -593,8 +593,8 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v,=
 intptr_t expect,
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
@@ -651,8 +651,8 @@ int rseq_offset_deref_addv(intptr_t *ptr, off_t off, =
intptr_t inc, int cpu)
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
--=20
2.34.1

