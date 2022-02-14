Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8279D4B4D80
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349990AbiBNLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:02:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349905AbiBNLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:02:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5A16A397;
        Mon, 14 Feb 2022 02:30:23 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:30:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644834622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WcHz/38kpUTRfTb1MH9FbvylA0vbgrpBypC2JHmxk+4=;
        b=bftFilmpNl6keLxM+weEEVyQvj3JD1venPWBn1XTHa8e5ol5kiOUx+yFkk/mfIpd4nCnjE
        8hR+VbwMP6DLF+T5/s8V2f8+XSPXMJrFlPVvP7xDoHgAmRcKpPnxP8cle91qVpqYg4SkQy
        hX7FDdSUT93LdIP/oHYzwjt4kbY26YkYJRdzHZXO2clV3HLpBticP7L3J+t2PiKyOPJBs9
        1uRghgkcTqs1D4iqp8e500LxPoeJZqOWc2xuc4N75eg6sUt8CtlVP6vC0rdzPC3vc7VATi
        jQ92VSMcCvQXDA1i4ToHtZchoQ5DtQCjINwaYBnTQ6pJM17goEm6FkvSdGZrgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644834622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WcHz/38kpUTRfTb1MH9FbvylA0vbgrpBypC2JHmxk+4=;
        b=YG71odPBwRLX3jIV8YDYUz306gqbiojJHSlj4PJcjAoMD13LAeuNTC3P5xBd7zwQI4M0WP
        goI2HaSSZZECciDA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Change type of rseq_offset to ptrdiff_t
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164483462094.16921.3179511861185610192.tip-bot2@tip-bot2>
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

Commit-ID:     889c5d60fbcf332c8b6ab7054d45f2768914a375
Gitweb:        https://git.kernel.org/tip/889c5d60fbcf332c8b6ab7054d45f2768914a375
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Thu, 03 Feb 2022 10:05:32 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Feb 2022 23:30:08 +01:00

selftests/rseq: Change type of rseq_offset to ptrdiff_t

Just before the 2.35 release of glibc, the __rseq_offset userspace ABI
was changed from int to ptrdiff_t.

Adapt to this change in the kernel selftests.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://sourceware.org/pipermail/libc-alpha/2022-February/136024.html
---
 tools/testing/selftests/rseq/rseq-x86.h | 14 +++++++-------
 tools/testing/selftests/rseq/rseq.c     |  5 +++--
 tools/testing/selftests/rseq/rseq.h     |  3 ++-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index f704d36..bd01dc4 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -143,7 +143,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" ((long)rseq_offset),
+		  [rseq_offset]		"r" (rseq_offset),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -214,7 +214,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" ((long)rseq_offset),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -270,7 +270,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" ((long)rseq_offset),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"er" (count)
@@ -329,7 +329,7 @@ int rseq_offset_deref_addv(intptr_t *ptr, long off, intptr_t inc, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" ((long)rseq_offset),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* final store input */
 		  [ptr]			"m" (*ptr),
 		  [off]			"er" (off),
@@ -387,7 +387,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" ((long)rseq_offset),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -469,7 +469,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" ((long)rseq_offset),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -581,7 +581,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" ((long)rseq_offset),
+		  [rseq_offset]		"r" (rseq_offset),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 07ba0d4..986b945 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -27,16 +27,17 @@
 #include <signal.h>
 #include <limits.h>
 #include <dlfcn.h>
+#include <stddef.h>
 
 #include "../kselftest.h"
 #include "rseq.h"
 
-static const int *libc_rseq_offset_p;
+static const ptrdiff_t *libc_rseq_offset_p;
 static const unsigned int *libc_rseq_size_p;
 static const unsigned int *libc_rseq_flags_p;
 
 /* Offset from the thread pointer to the rseq area.  */
-int rseq_offset;
+ptrdiff_t rseq_offset;
 
 /* Size of the registered rseq area.  0 if the registration was
    unsuccessful.  */
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 6bd0ac4..9d850b2 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -16,6 +16,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include "rseq-abi.h"
 #include "compiler.h"
 
@@ -47,7 +48,7 @@
 #include "rseq-thread-pointer.h"
 
 /* Offset from the thread pointer to the rseq area.  */
-extern int rseq_offset;
+extern ptrdiff_t rseq_offset;
 /* Size of the registered rseq area.  0 if the registration was
    unsuccessful.  */
 extern unsigned int rseq_size;
