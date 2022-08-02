Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0717587B49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiHBLDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiHBLDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:03:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B901A5006A;
        Tue,  2 Aug 2022 04:03:18 -0700 (PDT)
Date:   Tue, 02 Aug 2022 11:03:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659438197;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCBHIINU2YjsU2hp1/1iHB3HY6e1ePfW6cBjqq38S94=;
        b=0STiaicGN6MYJg/hGEAAWZh2C7sjEFTX+MLsgOyKbLg8oeOpgLf/FUgXWnZDtXo70V+YG9
        z0bJm1qyiIZARZnGKXE2TcovyrDH136nzmQLq26YYhQSkpiJXjrnSdrDDSqzZhIF/HSsYN
        L2Plq87XT9T+U9M3OeZFz2v0dQcX7vMAo1tozEEWC02wLh9x6rkg/HL0h1J7vgbuOIPvlD
        rY0SW1qFCewhllzzH4I2onz+qgYAqKnNG4jSeu35L0DoXx7+Pzbk7mdpmg6+1Yk2qo06g8
        IWtUtBer33UXl5BWuXVzh1eAgRWi8oTSY1rmRb/GJpO7Vg3V1pMNOZ7HaVYNFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659438197;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCBHIINU2YjsU2hp1/1iHB3HY6e1ePfW6cBjqq38S94=;
        b=9/3YpoKwhG4SpskrT00BXtXYzyT56Oqs2C6rxttD+gD67uM76ifet6ZoOEC5sdbrcRucfJ
        U0uuzcDpFXNrMpDw==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Make dl_cpuset_cpumask_can_shrink()
 capacity-aware
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220729111305.1275158-3-dietmar.eggemann@arm.com>
References: <20220729111305.1275158-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <165943819623.15455.1128171165437845604.tip-bot2@tip-bot2>
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

Commit-ID:     6092478bcbf4021d3c52144bd456378de043fe58
Gitweb:        https://git.kernel.org/tip/6092478bcbf4021d3c52144bd456378de043fe58
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Fri, 29 Jul 2022 13:13:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Aug 2022 12:32:45 +02:00

sched/deadline: Make dl_cpuset_cpumask_can_shrink() capacity-aware

dl_cpuset_cpumask_can_shrink() is used to validate whether there is
still enough CPU capacity for DL tasks in the reduced cpuset.

Currently it still operates on `# remaining CPUs in the cpuset` (1).
Change this to use the already capacity-aware DL admission control
__dl_overflow() for the `cpumask can shrink` test.

  dl_b->bw = sched_rt_period << BW_SHIFT / sched_rt_period

  dl_b->bw * (1) >= currently allocated bandwidth in root_domain (rd)

  Replace (1) w/ `\Sum CPU capacity in rd >> SCHED_CAPACITY_SHIFT`

Adapt __dl_bw_capacity() to take a cpumask instead of a CPU number
argument so that `rd->span` and `cpumask of the reduced cpuset` can
be used here.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220729111305.1275158-3-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8bebc36..1d9c909 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -124,15 +124,12 @@ static inline int dl_bw_cpus(int i)
 	return cpus;
 }
 
-static inline unsigned long __dl_bw_capacity(int i)
+static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
 {
-	struct root_domain *rd = cpu_rq(i)->rd;
 	unsigned long cap = 0;
+	int i;
 
-	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
-			 "sched RCU must be held");
-
-	for_each_cpu_and(i, rd->span, cpu_active_mask)
+	for_each_cpu_and(i, mask, cpu_active_mask)
 		cap += capacity_orig_of(i);
 
 	return cap;
@@ -148,7 +145,10 @@ static inline unsigned long dl_bw_capacity(int i)
 	    capacity_orig_of(i) == SCHED_CAPACITY_SCALE) {
 		return dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT;
 	} else {
-		return __dl_bw_capacity(i);
+		RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
+				 "sched RCU must be held");
+
+		return __dl_bw_capacity(cpu_rq(i)->rd->span);
 	}
 }
 
@@ -3007,17 +3007,15 @@ bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 				 const struct cpumask *trial)
 {
-	int ret = 1, trial_cpus;
+	unsigned long flags, cap;
 	struct dl_bw *cur_dl_b;
-	unsigned long flags;
+	int ret = 1;
 
 	rcu_read_lock_sched();
 	cur_dl_b = dl_bw_of(cpumask_any(cur));
-	trial_cpus = cpumask_weight(trial);
-
+	cap = __dl_bw_capacity(trial);
 	raw_spin_lock_irqsave(&cur_dl_b->lock, flags);
-	if (cur_dl_b->bw != -1 &&
-	    cur_dl_b->bw * trial_cpus < cur_dl_b->total_bw)
+	if (__dl_overflow(cur_dl_b, cap, 0, 0))
 		ret = 0;
 	raw_spin_unlock_irqrestore(&cur_dl_b->lock, flags);
 	rcu_read_unlock_sched();
