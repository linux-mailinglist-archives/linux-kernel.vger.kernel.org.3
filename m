Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A0A4A8732
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351627AbiBCPFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:05:41 -0500
Received: from mail.efficios.com ([167.114.26.124]:47342 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351632AbiBCPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:05:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ED720390641;
        Thu,  3 Feb 2022 10:05:34 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aiWU0OIApTxa; Thu,  3 Feb 2022 10:05:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 77004390640;
        Thu,  3 Feb 2022 10:05:34 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 77004390640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643900734;
        bh=WyU7uOvxJADaGz3aMWb0JYsLM3wbm8jc3RBF8tl9dlE=;
        h=From:To:Date:Message-Id;
        b=d5KDhyoRCf0WVf+JNqUD7+sNJsWdPO3xfruP9ZbXomt+pTOljgjRpvgTKlTU8yqMI
         yDObmZZN9IIeA6A0mj9FF9E90bc6zrc/v4zBfLyoPb9I6N3ri5XkVY/lD5tpAQI0Ve
         txr86r/goZr/gQmffte0S0Jw6maMov9WSsJT2E5AXxsow+b9MMmEQ/6NJKmBMwGPK9
         7KgJo2NDAEdkgBZYnLA4djWJTpdTZBwzgqnU8uzhVmVtiw9ww6MoFx7UCLOVmdzG4I
         FjdQQt3+sDosJjkX2XRVqrC1f2bFcNCwL8/yGyUtyOFYdwhN9MoGfYRvf11ZtX9J02
         Eg1Iyv4tFlRNw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yjEdcLOaV4XO; Thu,  3 Feb 2022 10:05:34 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 177BF39063D;
        Thu,  3 Feb 2022 10:05:34 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] selftests/rseq: change type of rseq_offset to ptrdiff_t
Date:   Thu,  3 Feb 2022 10:05:32 -0500
Message-Id: <20220203150532.12464-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just before the 2.35 release of glibc, the __rseq_offset userspace ABI
was changed from int to ptrdiff_t.

Adapt to this change in the kernel selftests.

Link: https://sourceware.org/pipermail/libc-alpha/2022-February/136024.html
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-x86.h | 14 +++++++-------
 tools/testing/selftests/rseq/rseq.c     |  5 +++--
 tools/testing/selftests/rseq/rseq.h     |  3 ++-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index f704d3664327..bd01dc41ca13 100644
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
index 07ba0d463a96..986b9458efb2 100644
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
index 6bd0ac466b4a..9d850b290c2e 100644
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
-- 
2.17.1

