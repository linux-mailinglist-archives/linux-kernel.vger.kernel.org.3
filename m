Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4441A585924
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 10:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiG3IVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 04:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3IVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 04:21:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB943240B3;
        Sat, 30 Jul 2022 01:21:44 -0700 (PDT)
Date:   Sat, 30 Jul 2022 08:21:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659169303;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GRmTVsZ8q987tdymI6cdzIGtqdzCcKVr7InVX396Ek=;
        b=YVkcofyPDERULFyhQsaiSRd3P+Vn+lkgBFNE2o7tl/vxwe3NMcN/CIn9C7FUoDFDIjH+pD
        EaCtQ913eKvnFXB61gEmUlNXjLWWdNJ7LsmxduNuLqVNmlbbZRiAbraUzmovPo6IQrk61N
        EFSe5XtgY2oraM2Q03AKhnFlAiAv03Lmne8PtMeANkD533I0YBWL7MYWnLKwKH545ljHaX
        WbrM6e3gw14I2Z4872z6TC4mpAKrVWbkyWJTUPSwd0yKrjYl88IweIriEDIGNMWshm1ioN
        NoJ/C+4U4qA5MJNHYHZ5b1HcPb5VgxQuaZ6Rtn9jV3LKXnrtr+O1n6SzjOKpOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659169303;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GRmTVsZ8q987tdymI6cdzIGtqdzCcKVr7InVX396Ek=;
        b=tvy6kG8q3n3kRRKOiw7E8d5XjoXAO6So11zzVIaT4Uogazelm+XbunT5FTTEs35w+prQOD
        /6IAF6gbw5OPdBBw==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_* flags
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com>
References: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <165916930174.15455.14411545182545206079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c040fc3cb4ce18e1be54df6294f6a4004d2664ec
Gitweb:        https://git.kernel.org/tip/c040fc3cb4ce18e1be54df6294f6a4004d2664ec
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Wed, 22 Jun 2022 15:46:16 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 30 Jul 2022 10:14:18 +02:00

rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_* flags

The pretty much unused RSEQ_CS_FLAG_NO_RESTART_ON_* flags introduce
complexity in rseq, and are subtly buggy [1]. Solving those issues
requires introducing additional complexity in the rseq implementation
for each supported architecture.

Considering that it complexifies the rseq ABI, I am proposing that we
deprecate those flags. [2]

So far there appears to be consensus from maintainers of user-space
projects impacted by this feature that its removal would be a welcome
simplification. [3]

The deprecation approach proposed here is to issue WARN_ON_ONCE() when
encountering those flags and kill the offending process with sigsegv.
This should allow us to quickly identify whether anyone yells at us for
removing this.

Link: https://lore.kernel.org/lkml/20220618182515.95831-1-minhquangbui99@gmail.com/ [1]
Link: https://lore.kernel.org/lkml/258546133.12151.1655739550814.JavaMail.zimbra@efficios.com/ [2]
Link: https://lore.kernel.org/lkml/87pmj1enjh.fsf@email.froward.int.ebiederm.org/ [3]
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20220622194617.1155957-1-mathieu.desnoyers@efficios.com
---
 kernel/rseq.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 97ac20b..81d7dc8 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -18,8 +18,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
 
-#define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
-				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
+#define RSEQ_CS_NO_RESTART_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT | \
+				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
+				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
 
 /*
  *
@@ -175,23 +176,15 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	u32 flags, event_mask;
 	int ret;
 
+	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS))
+		return -EINVAL;
+
 	/* Get thread flags. */
 	ret = get_user(flags, &t->rseq->flags);
 	if (ret)
 		return ret;
 
-	/* Take critical section flags into account. */
-	flags |= cs_flags;
-
-	/*
-	 * Restart on signal can only be inhibited when restart on
-	 * preempt and restart on migrate are inhibited too. Otherwise,
-	 * a preempted signal handler could fail to restart the prior
-	 * execution context on sigreturn.
-	 */
-	if (unlikely((flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL) &&
-		     (flags & RSEQ_CS_PREEMPT_MIGRATE_FLAGS) !=
-		     RSEQ_CS_PREEMPT_MIGRATE_FLAGS))
+	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS))
 		return -EINVAL;
 
 	/*
@@ -203,7 +196,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	t->rseq_event_mask = 0;
 	preempt_enable();
 
-	return !!(event_mask & ~flags);
+	return !!event_mask;
 }
 
 static int clear_rseq_cs(struct task_struct *t)
