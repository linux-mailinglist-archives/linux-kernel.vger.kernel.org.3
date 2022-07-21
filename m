Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8FD57C6B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiGUIor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiGUIon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:44:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809BC7F50E;
        Thu, 21 Jul 2022 01:44:42 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:44:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658393081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FzDtUCBVDarM3BYezObGDuNytmVTRaxqo+H18+2TjpQ=;
        b=gQqPjCFYGtT1ovWOjuM+J80YePf8vp5eCq4IGnLf+m9EocevlXjqsoEhg1wc0+ZYWYRKAO
        JYlzpDfw0WzicwI3n1kNTzPrck5yXM3hjSeNcr0ZXG30KGcHx2MSSoCTW2Hl+Ip39cjFjH
        Hg4rFB8H817c+Gwigi+4WyU/cHtq4iw3k48zkpHgHRWLVTCnRBQjRy++FLyTIwD+CB5QYA
        MtLQj9fVR0+0x/kYoXx5FS6zWDWSGih21BNbi2SATilyESspQ5+TKKOS9XfSazPgMJX8uP
        oxPlvkFQRacJqZz4KmCt/ODIySUNlXce3f6RBPE3Pw1iHRauylCDSNISv3Xjxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658393081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FzDtUCBVDarM3BYezObGDuNytmVTRaxqo+H18+2TjpQ=;
        b=Ylp471lYWeUzbPZdu/qjfctZCm+rEsgOIBR4IKZ9qDN70SxntuEp8C1A97pmPSGkMzNy6J
        6deQeVsHmyOcxrBw==
From:   "tip-bot2 for Cruz Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Fix the bug that task won't enqueue
 into core tree when update cookie
Cc:     Cruz Zhao <CruzZhao@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com>
References: <1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <165839307992.15455.12098942648295607427.tip-bot2@tip-bot2>
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

Commit-ID:     91caa5ae242465c3ab9fd473e50170faa7e944f4
Gitweb:        https://git.kernel.org/tip/91caa5ae242465c3ab9fd473e50170faa7e944f4
Author:        Cruz Zhao <CruzZhao@linux.alibaba.com>
AuthorDate:    Tue, 28 Jun 2022 15:57:23 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Jul 2022 10:39:39 +02:00

sched/core: Fix the bug that task won't enqueue into core tree when update cookie

In function sched_core_update_cookie(), a task will enqueue into the
core tree only when it enqueued before, that is, if an uncookied task
is cookied, it will not enqueue into the core tree until it enqueue
again, which will result in unnecessary force idle.

Here follows the scenario:
  CPU x and CPU y are a pair of SMT siblings.
  1. Start task a running on CPU x without sleeping, and task b and
     task c running on CPU y without sleeping.
  2. We create a cookie and share it to task a and task b, and then
     we create another cookie and share it to task c.
  3. Simpling core_forceidle_sum of task a and b from /proc/PID/sched

And we will find out that core_forceidle_sum of task a takes 30%
time of the sampling period, which shouldn't happen as task a and b
have the same cookie.

Then we migrate task a to CPU x', migrate task b and c to CPU y', where
CPU x' and CPU y' are a pair of SMT siblings, and sampling again, we
will found out that core_forceidle_sum of task a and b are almost zero.

To solve this problem, we enqueue the task into the core tree if it's
on rq.

Fixes: 6e33cad0af49("sched: Trivial core scheduling cookie management")
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com
---
 kernel/sched/core_sched.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 5103502..93878cb 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -56,7 +56,6 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 	unsigned long old_cookie;
 	struct rq_flags rf;
 	struct rq *rq;
-	bool enqueued;
 
 	rq = task_rq_lock(p, &rf);
 
@@ -68,14 +67,16 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 	 */
 	SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(rq));
 
-	enqueued = sched_core_enqueued(p);
-	if (enqueued)
+	if (sched_core_enqueued(p))
 		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
 
 	old_cookie = p->core_cookie;
 	p->core_cookie = cookie;
 
-	if (enqueued)
+	/*
+	 * Consider the cases: !prev_cookie and !cookie.
+	 */
+	if (cookie && task_on_rq_queued(p))
 		sched_core_enqueue(rq, p);
 
 	/*
