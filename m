Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A7857C6B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiGUIo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiGUIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:44:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750077E83E;
        Thu, 21 Jul 2022 01:44:43 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:44:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658393082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/HxTgTi2hh26sKnEn3z6YHkmbekBR6IHKx5QyttQJk=;
        b=bRIH2TXWPrArPWnxq08UNTia3teOGOrYyg0G9NGGi75ei1OBfFF2WjS6kNM4Su4gywuiRX
        anwUsQ4mN0jbHmzWCT/b9ElT9IS4Wsdd59CeZI8sH4zO5JSxBR3JQfXPogBxmYQc5Zcb7c
        seuGncDQ+2Ya4M3CEEUlxJaaspUCDEdZprvHiEDnfcm9IiPNLQyXEawPe4bHz0WCjpbFfJ
        4CeCRv3bodKby6yZcPNKrvn3v9618JvAyr5/jNNX5lcO6X0WH3ynJftLIBlJj2OKjL0r3f
        qffRyb6ggAlETVsUDj0/kJTqB74KonNuWJSY9gtQTScL/t7hB2uMFGIAN0fhvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658393082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/HxTgTi2hh26sKnEn3z6YHkmbekBR6IHKx5QyttQJk=;
        b=Z0f5Aj5JpN+x92QV+fBZK+ud7BDpZBUZhMqYmh2n4Zh69h1DUpyi5hJ4ShK2lHHwRK+XKS
        6CRSOco1cznzL0AA==
From:   "tip-bot2 for Nicolas Saenz Julienne" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] nohz/full, sched/rt: Fix missed tick-reenabling bug
 in dequeue_task_rt()
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220628092259.330171-1-nsaenzju@redhat.com>
References: <20220628092259.330171-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Message-ID: <165839308090.15455.9464474001123522013.tip-bot2@tip-bot2>
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

Commit-ID:     5c66d1b9b30f737fcef85a0b75bfe0590e16b62a
Gitweb:        https://git.kernel.org/tip/5c66d1b9b30f737fcef85a0b75bfe0590e16b62a
Author:        Nicolas Saenz Julienne <nsaenzju@redhat.com>
AuthorDate:    Tue, 28 Jun 2022 11:22:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Jul 2022 10:39:38 +02:00

nohz/full, sched/rt: Fix missed tick-reenabling bug in dequeue_task_rt()

dequeue_task_rt() only decrements 'rt_rq->rt_nr_running' after having
called sched_update_tick_dependency() preventing it from re-enabling the
tick on systems that no longer have pending SCHED_RT tasks but have
multiple runnable SCHED_OTHER tasks:

  dequeue_task_rt()
    dequeue_rt_entity()
      dequeue_rt_stack()
        dequeue_top_rt_rq()
	  sub_nr_running()	// decrements rq->nr_running
	    sched_update_tick_dependency()
	      sched_can_stop_tick()	// checks rq->rt.rt_nr_running,
	      ...
        __dequeue_rt_entity()
          dec_rt_tasks()	// decrements rq->rt.rt_nr_running
	  ...

Every other scheduler class performs the operation in the opposite
order, and sched_update_tick_dependency() expects the values to be
updated as such. So avoid the misbehaviour by inverting the order in
which the above operations are performed in the RT scheduler.

Fixes: 76d92ac305f2 ("sched: Migrate sched to use new tick dependency mask model")
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lore.kernel.org/r/20220628092259.330171-1-nsaenzju@redhat.com
---
 kernel/sched/rt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed96..55f39c8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -480,7 +480,7 @@ static inline void rt_queue_push_tasks(struct rq *rq)
 #endif /* CONFIG_SMP */
 
 static void enqueue_top_rt_rq(struct rt_rq *rt_rq);
-static void dequeue_top_rt_rq(struct rt_rq *rt_rq);
+static void dequeue_top_rt_rq(struct rt_rq *rt_rq, unsigned int count);
 
 static inline int on_rt_rq(struct sched_rt_entity *rt_se)
 {
@@ -601,7 +601,7 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 	rt_se = rt_rq->tg->rt_se[cpu];
 
 	if (!rt_se) {
-		dequeue_top_rt_rq(rt_rq);
+		dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
 		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
 		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
 	}
@@ -687,7 +687,7 @@ static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 
 static inline void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 {
-	dequeue_top_rt_rq(rt_rq);
+	dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
 }
 
 static inline int rt_rq_throttled(struct rt_rq *rt_rq)
@@ -1089,7 +1089,7 @@ static void update_curr_rt(struct rq *rq)
 }
 
 static void
-dequeue_top_rt_rq(struct rt_rq *rt_rq)
+dequeue_top_rt_rq(struct rt_rq *rt_rq, unsigned int count)
 {
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 
@@ -1100,7 +1100,7 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
 
 	BUG_ON(!rq->nr_running);
 
-	sub_nr_running(rq, rt_rq->rt_nr_running);
+	sub_nr_running(rq, count);
 	rt_rq->rt_queued = 0;
 
 }
@@ -1486,18 +1486,21 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct sched_rt_entity *back = NULL;
+	unsigned int rt_nr_running;
 
 	for_each_sched_rt_entity(rt_se) {
 		rt_se->back = back;
 		back = rt_se;
 	}
 
-	dequeue_top_rt_rq(rt_rq_of_se(back));
+	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
 
 	for (rt_se = back; rt_se; rt_se = rt_se->back) {
 		if (on_rt_rq(rt_se))
 			__dequeue_rt_entity(rt_se, flags);
 	}
+
+	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
 }
 
 static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
