Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9A54B524
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350859AbiFNPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347101AbiFNPzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:55:36 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3E71AF0D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:55:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EF5283C7953;
        Tue, 14 Jun 2022 11:55:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fkm3KVBSAbbc; Tue, 14 Jun 2022 11:55:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AB8603C7951;
        Tue, 14 Jun 2022 11:55:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AB8603C7951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1655222130;
        bh=BI6uR+MrhnoRZ8ZYS3QE+wHIMBYha/H2WzTYFRyoAU8=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=EwUPPfYX/MXDdf9Gg5H6PFjc4JG4cTv42LqVXL/P5MB1ySIgwWbqn2J2KncBGEdGw
         vm0VQF0gSnGor1V6OC7xmFmPtFiN2nDk04fII00aCdvlizumFHEQAtJbEOiMfp7y7E
         FZCUWPCgG4oVgcGQU38paRH7bDO1LHIyS68AVfNtmfnfwdvuLor0RE1LjA2swxEHBn
         old4/hJsZs30/1K522XGABJZ7bM0t4JGwfS6ncaVwAim4M18U93ramWMaKsjQZHp1a
         rtai5O4aOiyJO3L+kt8ELJhnQZ3pvALFHsR6Wm6W4ACGpEoMXb3KL3x7AK3ZzhCKTo
         YAULGNxAbDBeg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B_Y5V8vMHad0; Tue, 14 Jun 2022 11:55:30 -0400 (EDT)
Received: from laptop-mjeanson.internal.efficios.com (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 6DE463C7AB8;
        Tue, 14 Jun 2022 11:55:30 -0400 (EDT)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH 2/3] selftests/rseq: riscv: fix 'literal-suffix' warning
Date:   Tue, 14 Jun 2022 11:48:29 -0400
Message-Id: <20220614154830.1367382-3-mjeanson@efficios.com>
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

This header is also used in librseq where it can be included in C++
code, add a space between literals and string macros.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tools/testing/selftests/rseq/rseq-riscv.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/se=
lftests/rseq/rseq-riscv.h
index 6f8a605b75c0..3a391c9bf468 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -86,7 +86,7 @@ do {									\
=20
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
 	RSEQ_INJECT_ASM(1)						\
-	"la	"RSEQ_ASM_TMP_REG_1 ", " __rseq_str(cs_label) "\n"	\
+	"la	" RSEQ_ASM_TMP_REG_1 ", " __rseq_str(cs_label) "\n"	\
 	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(rseq_cs) "]\n"	\
 	__rseq_str(label) ":\n"
=20
@@ -103,17 +103,17 @@ do {									\
=20
 #define RSEQ_ASM_OP_CMPEQ(var, expect, label)				\
 	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
-	"bne	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+	"bne	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
 		  __rseq_str(label) "\n"
=20
 #define RSEQ_ASM_OP_CMPEQ32(var, expect, label)				\
-	"lw	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
-	"bne	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+	"lw	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
+	"bne	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
 		  __rseq_str(label) "\n"
=20
 #define RSEQ_ASM_OP_CMPNE(var, expect, label)				\
 	REG_L	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"		\
-	"beq	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
+	"beq	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "] ,"	\
 		  __rseq_str(label) "\n"
=20
 #define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
@@ -127,12 +127,12 @@ do {									\
 	REG_S	RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"
=20
 #define RSEQ_ASM_OP_R_LOAD_OFF(offset)					\
-	"add	"RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(offset) "], "	\
+	"add	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(offset) "], "	\
 		 RSEQ_ASM_TMP_REG_1 "\n"				\
 	REG_L	RSEQ_ASM_TMP_REG_1 ", (" RSEQ_ASM_TMP_REG_1 ")\n"
=20
 #define RSEQ_ASM_OP_R_ADD(count)					\
-	"add	"RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
+	"add	" RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
 		", %[" __rseq_str(count) "]\n"
=20
 #define RSEQ_ASM_OP_FINAL_STORE(value, var, post_commit_label)		\
--=20
2.34.1

