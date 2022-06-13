Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0E654823E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbiFMI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbiFMI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:29:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83FA1ADAB;
        Mon, 13 Jun 2022 01:29:26 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:29:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655108965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8ybaNOpb+Xzgu09rlonaLEaUaXVpl9eFk0iE6Yu0vA=;
        b=O/HHrDryVsH1zOjBLlHwe4z7Of/eckrWon05p/hMwb/TTSIVP+WELoz+UqKgdhODejMMi6
        Tn6Ct/ryAuQXUxlFsJjit2XXzEsV0YVYEnL7zxYZmuGLqhUOGdMM/Zxxy9KRmB2KMUikI0
        171fLHKo55y4sz56YNMSEyDsnpbIzLFwpZzRkg+FKzDZCwA10XSZneWdBSPlp8x1VrcJv5
        Jig6aFfm4JlqyUnwcSSe7DlWLbVr/5r+mXJKJ4YuXWMxmEbv9ZfvZ3++6mv3JeszYQ9Uu7
        /pB/DJZDD/5HuBuVmPxSYyuadeVfQe7k9BERrhs+xqS8WNySYi2wjyrAHtlrQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655108965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8ybaNOpb+Xzgu09rlonaLEaUaXVpl9eFk0iE6Yu0vA=;
        b=mqVG5oeMxmoVFkOpzK/WnC6G6+TMISqNO7OFnAC6jz3r2NThZThMzjVkdTUaZ8Ko29tO1G
        5Kk6/nDN1/qFCwBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix balance_push() vs __sched_setscheduler()
Cc:     "Jing-Ting Wu" <jing-ting.wu@mediatek.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220519134706.GH2578@worktop.programming.kicks-ass.net>
References: <20220519134706.GH2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165510896380.4207.14196064953007841266.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     04193d590b390ec7a0592630f46d559ec6564ba1
Gitweb:        https://git.kernel.org/tip/04193d590b390ec7a0592630f46d559ec6564ba1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 07 Jun 2022 22:41:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:15:07 +02:00

sched: Fix balance_push() vs __sched_setscheduler()

The purpose of balance_push() is to act as a filter on task selection
in the case of CPU hotplug, specifically when taking the CPU out.

It does this by (ab)using the balance callback infrastructure, with
the express purpose of keeping all the unlikely/odd cases in a single
place.

In order to serve its purpose, the balance_push_callback needs to be
(exclusively) on the callback list at all times (noting that the
callback always places itself back on the list the moment it runs,
also noting that when the CPU goes down, regular balancing concerns
are moot, so ignoring them is fine).

And here-in lies the problem, __sched_setscheduler()'s use of
splice_balance_callbacks() takes the callbacks off the list across a
lock-break, making it possible for, an interleaving, __schedule() to
see an empty list and not get filtered.

Fixes: ae7927023243 ("sched: Optimize finish_lock_switch()")
Reported-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
Link: https://lkml.kernel.org/r/20220519134706.GH2578@worktop.programming.kicks-ass.net
---
 kernel/sched/core.c  | 36 +++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h |  5 +++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bfa7452..da0bf6f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4798,25 +4798,55 @@ static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
 
 static void balance_push(struct rq *rq);
 
+/*
+ * balance_push_callback is a right abuse of the callback interface and plays
+ * by significantly different rules.
+ *
+ * Where the normal balance_callback's purpose is to be ran in the same context
+ * that queued it (only later, when it's safe to drop rq->lock again),
+ * balance_push_callback is specifically targeted at __schedule().
+ *
+ * This abuse is tolerated because it places all the unlikely/odd cases behind
+ * a single test, namely: rq->balance_callback == NULL.
+ */
 struct callback_head balance_push_callback = {
 	.next = NULL,
 	.func = (void (*)(struct callback_head *))balance_push,
 };
 
-static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+static inline struct callback_head *
+__splice_balance_callbacks(struct rq *rq, bool split)
 {
 	struct callback_head *head = rq->balance_callback;
 
+	if (likely(!head))
+		return NULL;
+
 	lockdep_assert_rq_held(rq);
-	if (head)
+	/*
+	 * Must not take balance_push_callback off the list when
+	 * splice_balance_callbacks() and balance_callbacks() are not
+	 * in the same rq->lock section.
+	 *
+	 * In that case it would be possible for __schedule() to interleave
+	 * and observe the list empty.
+	 */
+	if (split && head == &balance_push_callback)
+		head = NULL;
+	else
 		rq->balance_callback = NULL;
 
 	return head;
 }
 
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	return __splice_balance_callbacks(rq, true);
+}
+
 static void __balance_callbacks(struct rq *rq)
 {
-	do_balance_callbacks(rq, splice_balance_callbacks(rq));
+	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
 
 static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0125961..47b89a0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1693,6 +1693,11 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Don't (re)queue an already queued item; nor queue anything when
+	 * balance_push() is active, see the comment with
+	 * balance_push_callback.
+	 */
 	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
 		return;
 
