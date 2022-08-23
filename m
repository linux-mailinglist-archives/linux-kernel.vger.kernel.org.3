Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C475C59E2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358188AbiHWLlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357317AbiHWLfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:35:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010E876947;
        Tue, 23 Aug 2022 02:27:32 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:27:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661246850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GqvtbssgkxrjrADkNfvVn2zUp2RSSCAT5f187YXR6jQ=;
        b=J9g0/SDvAuzb6dfiiWkClAxTQ3pJzlUZMdWmmRdVh24n9l3G+qd/SV0y/eh4NK3hNdGpMl
        KqgRJlELvPOKnMY9bIwYjnB6Q2nAtyTr57RqG/O+kC1YljFaeNc1iwmG3xTIfjW1+HVzss
        KoEDWpuIHuFaKr//5z5kCaF/zD8GJNQCohifr/buLHYK11HHtfLgXWcmnPS0hT0Q+Z62lM
        buOhEiVedULXWZHreFBnupdoD017Y5SGBrG6S8qYtgQ9Z8QOH3B+Ad4DxyZddT8HO9hJyS
        O0j84WC9CMqr6w0zdM04df7Wgc3RC/lP8VE1GS1XPun6CufbYllaD8c2XZJpMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661246850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GqvtbssgkxrjrADkNfvVn2zUp2RSSCAT5f187YXR6jQ=;
        b=eWNxD0dAqival1GwMf4R1Ujv/9tbO9NuOayb6oP2D5GdbLaEJXc7Ytfw651swuB4NYfAbK
        l9cooISEMsLet+AA==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Don't init util/runnable_avg for !fair task
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818124805.601-10-zhouchengming@bytedance.com>
References: <20220818124805.601-10-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166124684880.401.13181895170938824207.tip-bot2@tip-bot2>
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

Commit-ID:     e4fe074d6c359c19b74564fa1364fe48343cfa5d
Gitweb:        https://git.kernel.org/tip/e4fe074d6c359c19b74564fa1364fe48343cfa5d
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Thu, 18 Aug 2022 20:48:05 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Aug 2022 11:01:20 +02:00

sched/fair: Don't init util/runnable_avg for !fair task

post_init_entity_util_avg() init task util_avg according to the cpu util_avg
at the time of fork, which will decay when switched_to_fair() some time later,
we'd better to not set them at all in the case of !fair task.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220818124805.601-10-zhouchengming@bytedance.com
---
 kernel/sched/fair.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef325b5..e8c1b88 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -833,20 +833,6 @@ void post_init_entity_util_avg(struct task_struct *p)
 	long cpu_scale = arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq)));
 	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
 
-	if (cap > 0) {
-		if (cfs_rq->avg.util_avg != 0) {
-			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
-			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
-
-			if (sa->util_avg > cap)
-				sa->util_avg = cap;
-		} else {
-			sa->util_avg = cap;
-		}
-	}
-
-	sa->runnable_avg = sa->util_avg;
-
 	if (p->sched_class != &fair_sched_class) {
 		/*
 		 * For !fair tasks do:
@@ -861,6 +847,20 @@ void post_init_entity_util_avg(struct task_struct *p)
 		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
 		return;
 	}
+
+	if (cap > 0) {
+		if (cfs_rq->avg.util_avg != 0) {
+			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
+			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
+
+			if (sa->util_avg > cap)
+				sa->util_avg = cap;
+		} else {
+			sa->util_avg = cap;
+		}
+	}
+
+	sa->runnable_avg = sa->util_avg;
 }
 
 #else /* !CONFIG_SMP */
