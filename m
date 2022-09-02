Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E817C5AB788
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiIBR2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiIBR2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:28:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA3D9E86;
        Fri,  2 Sep 2022 10:28:33 -0700 (PDT)
Date:   Fri, 02 Sep 2022 17:28:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662139711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgbIj5FsHP6tcoCvp3d4sxM6dEM9XPjAhWIpWa7gTWk=;
        b=2AqGH5YDAGLAR5kIsxj6tLsP4E1tRKcRt2Xy/a12Gusu85ySrO/XpvARgXNClgPhht1w2n
        fa751vKIRluL++C/V8bv4I/uuOkcueZecjtN0Ok+42Uh1sqODuGusUjpA4Eep4nFD/mtpc
        pg1RNgt6FJeHSBdqGBhy5lnyOdqZ1Ll59fpblI6GJDJ6JDDY8hjLBxo1nuNznzOhTUWsRp
        NEfOKjX6hlLIKXdEo05oApIrwoCo0NhOFw5ToUwEF3Vbr/GmD3xrzHHrJ5z7FBtqQOaZMq
        OqsbNZ3WlKzDaXiQ6Dg5oSm4Sc3ep5c3OR6PvHGh8mra94BEffhwgsffE3k77Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662139711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgbIj5FsHP6tcoCvp3d4sxM6dEM9XPjAhWIpWa7gTWk=;
        b=vkBdB6hKz1itrdYpeQFX8uqyh0sCaoVZrVwH2fy45B3gA29kCkEzmIb+UfO+krSuhDcNK1
        ig27KEC4BdorMgCQ==
From:   "tip-bot2 for Shang XiaoJing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Add dl_task_is_earliest_deadline helper
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220826083453.698-1-shangxiaojing@huawei.com>
References: <20220826083453.698-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Message-ID: <166213971034.401.1742000676911551186.tip-bot2@tip-bot2>
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

Commit-ID:     973bee493a1f75c6c0752a74fb9396cbc34f026e
Gitweb:        https://git.kernel.org/tip/973bee493a1f75c6c0752a74fb9396cbc34f026e
Author:        Shang XiaoJing <shangxiaojing@huawei.com>
AuthorDate:    Fri, 26 Aug 2022 16:34:53 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Sep 2022 11:19:54 +02:00

sched/deadline: Add dl_task_is_earliest_deadline helper

Wrap repeated code in helper function dl_task_is_earliest_deadline, which
return true if there is no deadline task on the rq at all, or task's
deadline earlier than the whole rq.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Link: https://lore.kernel.org/r/20220826083453.698-1-shangxiaojing@huawei.com
---
 kernel/sched/deadline.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d116d2b..34271af 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1810,6 +1810,14 @@ static void yield_task_dl(struct rq *rq)
 
 #ifdef CONFIG_SMP
 
+static inline bool dl_task_is_earliest_deadline(struct task_struct *p,
+						 struct rq *rq)
+{
+	return (!rq->dl.dl_nr_running ||
+		dl_time_before(p->dl.deadline,
+			       rq->dl.earliest_dl.curr));
+}
+
 static int find_later_rq(struct task_struct *task);
 
 static int
@@ -1852,9 +1860,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 		int target = find_later_rq(p);
 
 		if (target != -1 &&
-				(dl_time_before(p->dl.deadline,
-					cpu_rq(target)->dl.earliest_dl.curr) ||
-				(cpu_rq(target)->dl.dl_nr_running == 0)))
+		    dl_task_is_earliest_deadline(p, cpu_rq(target)))
 			cpu = target;
 	}
 	rcu_read_unlock();
@@ -2221,9 +2227,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		later_rq = cpu_rq(cpu);
 
-		if (later_rq->dl.dl_nr_running &&
-		    !dl_time_before(task->dl.deadline,
-					later_rq->dl.earliest_dl.curr)) {
+		if (!dl_task_is_earliest_deadline(task, later_rq)) {
 			/*
 			 * Target rq has tasks of equal or earlier deadline,
 			 * retrying does not release any lock and is unlikely
@@ -2251,9 +2255,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		 * its earliest one has a later deadline than our
 		 * task, the rq is a good one.
 		 */
-		if (!later_rq->dl.dl_nr_running ||
-		    dl_time_before(task->dl.deadline,
-				   later_rq->dl.earliest_dl.curr))
+		if (dl_task_is_earliest_deadline(task, later_rq))
 			break;
 
 		/* Otherwise we try again. */
@@ -2424,9 +2426,7 @@ static void pull_dl_task(struct rq *this_rq)
 		 *  - it will preempt the last one we pulled (if any).
 		 */
 		if (p && dl_time_before(p->dl.deadline, dmin) &&
-		    (!this_rq->dl.dl_nr_running ||
-		     dl_time_before(p->dl.deadline,
-				    this_rq->dl.earliest_dl.curr))) {
+		    dl_task_is_earliest_deadline(p, this_rq)) {
 			WARN_ON(p == src_rq->curr);
 			WARN_ON(!task_on_rq_queued(p));
 
