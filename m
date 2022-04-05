Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9945C4F3822
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376352AbiDELVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbiDEIsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC33527FE2;
        Tue,  5 Apr 2022 01:36:38 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147779;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLr5NZ+XTqOLEeqR/li+1bApXh7Q5ne1YAbYSsiNIXA=;
        b=ECouRvcdEhIa7PI5amX+ogvgsVt6zYwuxtiPrAuff40Q1QEVOFFuoM2XTudkANc298j+tt
        G7hvkhVXV+zrAbUjWIsJYqXvTDbhpPrBTw1Q4UqgN9ltDedxYX9cFvmpZpHTmo1/Nd1ATk
        MfYO43GHTJgtesLMjHTwrEcYdPHu5LqiVnmBEXPBge9RI1hf8xPqetJ9F+woR3vtwqvOUj
        yOivw2BB4xH3uvwtMC4S7TWLSD5QSLLtvIazcj86ctLREwF6suhS3ObGzfvV862vzFF/8d
        M2SxtsLCtg7UISLkoow1tErMZ472Iw2bbBTM/HxKTkPspIvDR8e72ZIwCLLEjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147779;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLr5NZ+XTqOLEeqR/li+1bApXh7Q5ne1YAbYSsiNIXA=;
        b=rHOEZQQb+QHCRDkGnUcBYzZc8eFtugtY4K0QMYayCeKhHMtbbM/ShWrZQTk6k3PdrmM9cg
        FhAZnEpbnEnWOiBQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Add lock contention tracepoints
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322185709.141236-2-namhyung@kernel.org>
References: <20220322185709.141236-2-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <164914777883.389.9880881024402369750.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     16edd9b511a13e7760ed4b92ba4e39bacda5c86f
Gitweb:        https://git.kernel.org/tip/16edd9b511a13e7760ed4b92ba4e39bacda5c86f
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 22 Mar 2022 11:57:08 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:35 +02:00

locking: Add lock contention tracepoints

This adds two new lock contention tracepoints like below:

 * lock:contention_begin
 * lock:contention_end

The lock:contention_begin takes a flags argument to classify locks.  I
found it useful to identify what kind of locks it's tracing like if
it's spinning or sleeping, reader-writer lock, real-time, and per-cpu.

Move tracepoint definitions into mutex.c so that we can use them
without lockdep.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lkml.kernel.org/r/20220322185709.141236-2-namhyung@kernel.org
---
 include/trace/events/lock.h | 61 ++++++++++++++++++++++++++++++++++--
 kernel/locking/lockdep.c    |  1 +-
 kernel/locking/mutex.c      |  3 ++-
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index d751212..b9b6e3e 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -5,11 +5,21 @@
 #if !defined(_TRACE_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_LOCK_H
 
-#include <linux/lockdep.h>
+#include <linux/sched.h>
 #include <linux/tracepoint.h>
 
+/* flags for lock:contention_begin */
+#define LCB_F_SPIN	(1U << 0)
+#define LCB_F_READ	(1U << 1)
+#define LCB_F_WRITE	(1U << 2)
+#define LCB_F_RT	(1U << 3)
+#define LCB_F_PERCPU	(1U << 4)
+
+
 #ifdef CONFIG_LOCKDEP
 
+#include <linux/lockdep.h>
+
 TRACE_EVENT(lock_acquire,
 
 	TP_PROTO(struct lockdep_map *lock, unsigned int subclass,
@@ -78,8 +88,53 @@ DEFINE_EVENT(lock, lock_acquired,
 	TP_ARGS(lock, ip)
 );
 
-#endif
-#endif
+#endif /* CONFIG_LOCK_STAT */
+#endif /* CONFIG_LOCKDEP */
+
+TRACE_EVENT(contention_begin,
+
+	TP_PROTO(void *lock, unsigned int flags),
+
+	TP_ARGS(lock, flags),
+
+	TP_STRUCT__entry(
+		__field(void *, lock_addr)
+		__field(unsigned int, flags)
+	),
+
+	TP_fast_assign(
+		__entry->lock_addr = lock;
+		__entry->flags = flags;
+	),
+
+	TP_printk("%p (flags=%s)", __entry->lock_addr,
+		  __print_flags(__entry->flags, "|",
+				{ LCB_F_SPIN,		"SPIN" },
+				{ LCB_F_READ,		"READ" },
+				{ LCB_F_WRITE,		"WRITE" },
+				{ LCB_F_RT,		"RT" },
+				{ LCB_F_PERCPU,		"PERCPU" }
+			  ))
+);
+
+TRACE_EVENT(contention_end,
+
+	TP_PROTO(void *lock, int ret),
+
+	TP_ARGS(lock, ret),
+
+	TP_STRUCT__entry(
+		__field(void *, lock_addr)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->lock_addr = lock;
+		__entry->ret = ret;
+	),
+
+	TP_printk("%p (ret=%d)", __entry->lock_addr, __entry->ret)
+);
 
 #endif /* _TRACE_LOCK_H */
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3cbd492..a6e671b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -60,7 +60,6 @@
 
 #include "lockdep_internals.h"
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
 
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5e35859..ee2fd76 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -30,6 +30,9 @@
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/lock.h>
+
 #ifndef CONFIG_PREEMPT_RT
 #include "mutex.h"
 
