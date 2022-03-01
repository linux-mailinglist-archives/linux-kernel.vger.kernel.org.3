Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECBC4C9348
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiCASbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiCASbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:31:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53581DEDD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:30:35 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:30:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646159433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=X/igFnMcoOX+ydXY9MUnlr0F1iHCWfAGr8xhEWYL6WE=;
        b=HQWwZEwuugW2+rq5sKc02C0vnXM6Q/bO48uFSAI8sEU9vOc7Y1QR3evbhzpXApf6Y6nRMW
        Od5ApdEx5aawtviTZFdsljr0FPjSTQZTBnaSjtBALqVLIx6uqhSwmZ6B3p+Fi4xm54rO/4
        ucKcOqSrBKaQIwj5PVxBizX7cq9hr3a6WdJBvScmI6syicfzgs/C2m1hA6zqI62PsdUdFG
        5WeqM6pYXLGWymBHwCUiCkaGXZpngwXzR0qquobbjsclynCQId2NHwtMNuWBKzwgLdgqci
        eANAy6q6OwYF99+wn8E90MEtvI1RsbtFLiDjLBgPjHLe35OgMs5wn324hQY6vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646159433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=X/igFnMcoOX+ydXY9MUnlr0F1iHCWfAGr8xhEWYL6WE=;
        b=nolF4nj6/9ks17p52HZyda3SYrlti8KaEWjBXcfw+0+PCGL99jyaye+DeZ8xqSTPQ7sM5n
        TZ5WdlP0ItvH7VCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched: Make preempt_enable_no_resched() behave like
 preempt_enable() on PREEMPT_RT
Message-ID: <Yh5mSGCbvqDdeCa3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Use the distinction that has been made earlier between
preempt_enable_no_resched() and sched_preempt_enable_no_resched().
sched_preempt_enable_no_resched() is used within the scheduler where an
immediate schedule() follows. preempt_enable_no_resched() is used
outside of the scheduler and an immediate schedule() invocation may not
follow for other reasons.

The lack of an immediate schedule() invocation matters on PREEMPT_RT
where it will introduce latencies while the scheduler expects a context
switch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/preempt.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index b4381f255a5ca..582e43856a532 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -210,7 +210,11 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
-#define preempt_enable_no_resched() sched_preempt_enable_no_resched()
+#ifdef CONFIG_PREEMPT_RT
+# define preempt_enable_no_resched() preempt_enable()
+#else
+# define preempt_enable_no_resched() sched_preempt_enable_no_resched()
+#endif
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 
-- 
2.35.1

