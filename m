Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9949110C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbiAQUjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:39:54 -0500
Received: from mail.efficios.com ([167.114.26.124]:46684 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiAQUjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:39:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A5D87304772;
        Mon, 17 Jan 2022 15:39:39 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2dg4Wx3vCP-J; Mon, 17 Jan 2022 15:39:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 68B4530476F;
        Mon, 17 Jan 2022 15:39:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 68B4530476F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642451979;
        bh=y9jIj5bHLEFbZfb67tCrLOyYFHIc/2fDV45Kvh7BPGg=;
        h=From:To:Date:Message-Id;
        b=KCDzE5daSRXVTLiEvtRP2dsAplatsIJyBmVO9bW3tUPI54i3/+kjHP38pkyg1EeVX
         STaPz5oysJX23CvPzYAQmXC4ZLq04yUds+WC9/4idF03bPgme5IFMoJLVmbrPWNxO1
         ovhwxASdyHTVg/Tvhqi6WFua0ZBZNj+hVt4tq87AB4K+hspK9iiVX93CwRIzdw/zDZ
         vwGT2UaOyG1ZzQes0dfX8XuZbYVWMokEDWdUyKyRPJEg0g4/LXyYHwAiJsRcxELm09
         rmpi+ko10FwBnLlNP5b/A9xflZxTNQ8q5BAx3YPqvQzn1H8CDjeqQKFYW8k7Us721g
         aq2tOFCoGBxcg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mD-MY-TQO7AS; Mon, 17 Jan 2022 15:39:39 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id DBD503049C4;
        Mon, 17 Jan 2022 15:39:38 -0500 (EST)
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
Subject: [RFC PATCH 2/5] selftests/rseq: Remove volatile from __rseq_abi
Date:   Mon, 17 Jan 2022 15:39:22 -0500
Message-Id: <20220117203925.12164-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
References: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done in preparation for the selftest uplift to become compatible
with glibc-2.35.

All accesses to the __rseq_abi fields are volatile, but remove the
volatile from the TLS variable declaration, otherwise we are stuck with
volatile for the upcoming rseq_get_abi() helper.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq.c | 4 ++--
 tools/testing/selftests/rseq/rseq.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 7159eb777fd3..a0d8eed24035 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -31,7 +31,7 @@
 
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
-__thread volatile struct rseq __rseq_abi = {
+__thread struct rseq __rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };
 
@@ -93,7 +93,7 @@ int rseq_register_current_thread(void)
 		goto end;
 	}
 	if (errno != EBUSY)
-		__rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
+		RSEQ_WRITE_ONCE(__rseq_abi.cpu_id, RSEQ_CPU_ID_REGISTRATION_FAILED);
 	ret = -1;
 	__rseq_refcount--;
 end:
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 3f63eb362b92..f971a9217145 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -43,7 +43,7 @@
 #define RSEQ_INJECT_FAILED
 #endif
 
-extern __thread volatile struct rseq __rseq_abi;
+extern __thread struct rseq __rseq_abi;
 extern int __rseq_handled;
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
@@ -140,9 +140,9 @@ static inline uint32_t rseq_current_cpu(void)
 static inline void rseq_clear_rseq_cs(void)
 {
 #ifdef __LP64__
-	__rseq_abi.rseq_cs.ptr = 0;
+	RSEQ_WRITE_ONCE(__rseq_abi.rseq_cs.ptr, 0);
 #else
-	__rseq_abi.rseq_cs.ptr.ptr32 = 0;
+	RSEQ_WRITE_ONCE(__rseq_abi.rseq_cs.ptr.ptr32, 0);
 #endif
 }
 
-- 
2.17.1

