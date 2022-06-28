Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83355DF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiF1HRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241050AbiF1HQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:16:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F852C66F;
        Tue, 28 Jun 2022 00:16:48 -0700 (PDT)
Date:   Tue, 28 Jun 2022 07:16:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656400607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsXosqEsWRtYNA85DJ622epYp+sxCEszKTOajyHzupI=;
        b=VPjQEkNxIWobyvYPYht59xYs4pYDfmSgDa3lE3ZBHYNnXC1C+d1wU/45CVuKDpCyIU4TLG
        AJhT/nQHOLIaV39ewiUJZDvTTJUllPXDOmrpYJHzo5pG9XocpZnGCwgRHijCfpFua9mbd5
        mIBMT36jKPqk4c50hJeFNC7LenUmGnusBubXE0S7ciNZGDtmgGxsPi6jVuzWyTNIRwKhQ0
        MVNmtXd+KVRN4VZ6fG9EA1VIZcPbJcGIxzSto5lJcWXbSGRcI0awczkgmP0eKfyMxp7rRe
        84JaGfCNr+MK4+C+/9vv6tP6Cy5mgnLGE4tuNZQUEzbGtSzsa8ToutkyQ/d+tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656400607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsXosqEsWRtYNA85DJ622epYp+sxCEszKTOajyHzupI=;
        b=34LiCadMpeuaZ3rS8x5nvmwkgUCnkkYGwm50i13mttdJRelFZABYqHlhcdsxip5K9B/HZL
        57+2iTBNBrjxo7Cw==
From:   "tip-bot2 for Michael Jeanson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: riscv: fix 'literal-suffix' warning
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220614154830.1367382-3-mjeanson@efficios.com>
References: <20220614154830.1367382-3-mjeanson@efficios.com>
MIME-Version: 1.0
Message-ID: <165640060612.4207.6044570687728760265.tip-bot2@tip-bot2>
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

Commit-ID:     d47c0cc94a86b9098930523a9e68180bef6b26cf
Gitweb:        https://git.kernel.org/tip/d47c0cc94a86b9098930523a9e68180bef6b26cf
Author:        Michael Jeanson <mjeanson@efficios.com>
AuthorDate:    Tue, 14 Jun 2022 11:48:29 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:08:28 +02:00

selftests/rseq: riscv: fix 'literal-suffix' warning

This header is also used in librseq where it can be included in C++
code, add a space between literals and string macros.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/r/20220614154830.1367382-3-mjeanson@efficios.com
---
 tools/testing/selftests/rseq/rseq-riscv.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index 6f8a605..3a391c9 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -86,7 +86,7 @@ do {									\
 
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
 	RSEQ_INJECT_ASM(1)						\
-	"la	"RSEQ_ASM_TMP_REG_1 ", " __rseq_str(cs_label) "\n"	\
+	"la	" RSEQ_ASM_TMP_REG_1 ", " __rseq_str(cs_label) "\n"	\
 	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(rseq_cs) "]\n"	\
 	__rseq_str(label) ":\n"
 
@@ -103,17 +103,17 @@ do {									\
 
 #define RSEQ_ASM_OP_CMPEQ(var, expect, label)				\
 	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
-	"bne	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+	"bne	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
 		  __rseq_str(label) "\n"
 
 #define RSEQ_ASM_OP_CMPEQ32(var, expect, label)				\
-	"lw	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
-	"bne	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+	"lw	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
+	"bne	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
 		  __rseq_str(label) "\n"
 
 #define RSEQ_ASM_OP_CMPNE(var, expect, label)				\
 	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
-	"beq	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+	"beq	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
 		  __rseq_str(label) "\n"
 
 #define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
@@ -127,12 +127,12 @@ do {									\
 	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"
 
 #define RSEQ_ASM_OP_R_LOAD_OFF(offset)					\
-	"add	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(offset) "], "	\
+	"add	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(offset) "], "	\
 		 RSEQ_ASM_TMP_REG_1 "\n"				\
 	REG_L	RSEQ_ASM_TMP_REG_1 ", (" RSEQ_ASM_TMP_REG_1 ")\n"
 
 #define RSEQ_ASM_OP_R_ADD(count)					\
-	"add	"RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
+	"add	" RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
 		", %[" __rseq_str(count) "]\n"
 
 #define RSEQ_ASM_OP_FINAL_STORE(value, var, post_commit_label)		\
