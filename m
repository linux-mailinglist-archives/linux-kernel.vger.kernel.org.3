Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7287E4A86A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351362AbiBCOgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:36:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351342AbiBCOdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:52 -0500
Date:   Thu, 03 Feb 2022 14:33:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898831;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znfUhutvepz7DeR7g7rXe8R0vY+RYgHaHIrICHi1kzE=;
        b=faYHyT4z73OTglhc5Eoquh15qNHk09+0x32kv+MTM2drvBGaIrI4+Vlt0LqlYlOX2x75DG
        TD44pHPezgQy2dl6EaGX8eIrfUa9WSy2ZDKaZrhL/WN1+wugmgDI4Ho00Q/dYYzkAScUAl
        /bTQT/pC/N+nU4dxFMl2duut7FPbfNqQA6Rp5KqNb4ExpAt19Vt0YDChYB/YNha1R1FKYk
        cW4a9E4DF9wRdDEQl2NhRp5naDhRdHvhrGic2BbXmIh+v1MVm6dNZdnuq62hPVYPICuR7h
        0gsysceEfH8PE8xocGh1WPeE7tje1DIL6L5lC7M437NPKqMoutjOAfrG7A8jrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898831;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znfUhutvepz7DeR7g7rXe8R0vY+RYgHaHIrICHi1kzE=;
        b=PV+R3ViP8aWRloRrf64pDJuLq8J0Ac3YI+Hz/hCMzpyJYMfkgM4S/VDo1ZFKqDRMqe/KAt
        8d1FbD1iTlRjM+Cg==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Remove volatile from __rseq_abi
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-5-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-5-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389883020.16921.17584681770566486508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     94b80a19ebfe347a01301d750040a61c38200e2b
Gitweb:        https://git.kernel.org/tip/94b80a19ebfe347a01301d750040a61c38200e2b
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:42 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:34 +01:00

selftests/rseq: Remove volatile from __rseq_abi

This is done in preparation for the selftest uplift to become compatible
with glibc-2.35.

All accesses to the __rseq_abi fields are volatile, but remove the
volatile from the TLS variable declaration, otherwise we are stuck with
volatile for the upcoming rseq_get_abi() helper.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-5-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/rseq.c | 4 ++--
 tools/testing/selftests/rseq/rseq.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index bfe1b26..1f905b6 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -30,7 +30,7 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
-__thread volatile struct rseq_abi __rseq_abi = {
+__thread struct rseq_abi __rseq_abi = {
 	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
 };
 
@@ -92,7 +92,7 @@ int rseq_register_current_thread(void)
 		goto end;
 	}
 	if (errno != EBUSY)
-		__rseq_abi.cpu_id = RSEQ_ABI_CPU_ID_REGISTRATION_FAILED;
+		RSEQ_WRITE_ONCE(__rseq_abi.cpu_id, RSEQ_ABI_CPU_ID_REGISTRATION_FAILED);
 	ret = -1;
 	__rseq_refcount--;
 end:
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index cb6bbc5..d580f8e 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -43,7 +43,7 @@
 #define RSEQ_INJECT_FAILED
 #endif
 
-extern __thread volatile struct rseq_abi __rseq_abi;
+extern __thread struct rseq_abi __rseq_abi;
 extern int __rseq_handled;
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
@@ -139,7 +139,7 @@ static inline uint32_t rseq_current_cpu(void)
 
 static inline void rseq_clear_rseq_cs(void)
 {
-	__rseq_abi.rseq_cs.arch.ptr = 0;
+	RSEQ_WRITE_ONCE(__rseq_abi.rseq_cs.arch.ptr, 0);
 }
 
 /*
