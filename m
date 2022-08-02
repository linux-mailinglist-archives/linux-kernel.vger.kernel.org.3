Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA4587B48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiHBLD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbiHBLDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:03:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D874B0F2;
        Tue,  2 Aug 2022 04:03:19 -0700 (PDT)
Date:   Tue, 02 Aug 2022 11:03:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659438198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRjqNDbAvx25+dXbpS9tJmbsWZem37xTRKdAdYltVtg=;
        b=xRJ0x/ELXnwEKhuCcP9R3khQidIPmMoHsScgPqdlwukSZJ1lcsfYkjK8vAaxCFl7M7fb9x
        LZZu25P27/m55VLG6Ply4cbEiiG2nx/BTqLP/e5xhK/x1sGEyGJNdUIp/EQGlBwAMEbI8g
        H1wrn30qvpb33R5f/8670XW80KWruBF3q6wZz8uz7odzkvvYeMvZ3njCwNPBGK03wRXplZ
        UTBBOo3UjaPLTiyWOUfgHTuMG3QimkJV4z80AMaOXrwrlRkbBX+E2uDex3QS+g9SyR0pOl
        6bqMIRgw+touGurPJL96fGOgRuvVvfmzP69QloDcP2zzVy0udVrUPUjBtC4pnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659438198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRjqNDbAvx25+dXbpS9tJmbsWZem37xTRKdAdYltVtg=;
        b=t7VPVQeUT5mCzNlDogiNIouMIY5qRiNRJhXa9U6Wf4eoHBTp6snUAW8iaPKaF1lBbLdsuX
        Cuuyz6Z1XWOaDJDw==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Introduce sched_asym_cpucap_active()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220729111305.1275158-2-dietmar.eggemann@arm.com>
References: <20220729111305.1275158-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <165943819723.15455.17826453553444162920.tip-bot2@tip-bot2>
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

Commit-ID:     740cf8a760b73e8375bfb4bedcbe9746183350f9
Gitweb:        https://git.kernel.org/tip/740cf8a760b73e8375bfb4bedcbe9746183350f9
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Fri, 29 Jul 2022 13:13:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Aug 2022 12:32:45 +02:00

sched/core: Introduce sched_asym_cpucap_active()

Create an inline helper for conditional code to be only executed on
asymmetric CPU capacity systems. This makes these (currently ~10 and
future) conditions a lot more readable.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220729111305.1275158-2-dietmar.eggemann@arm.com
---
 kernel/sched/cpudeadline.c | 2 +-
 kernel/sched/deadline.c    | 4 ++--
 kernel/sched/fair.c        | 8 ++++----
 kernel/sched/rt.c          | 4 ++--
 kernel/sched/sched.h       | 5 +++++
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 02d970a..57c92d7 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -123,7 +123,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 		unsigned long cap, max_cap = 0;
 		int cpu, max_cpu = -1;
 
-		if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		if (!sched_asym_cpucap_active())
 			return 1;
 
 		/* Ensure the capacity of the CPUs fits the task. */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0ab79d8..8bebc36 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -144,7 +144,7 @@ static inline unsigned long __dl_bw_capacity(int i)
  */
 static inline unsigned long dl_bw_capacity(int i)
 {
-	if (!static_branch_unlikely(&sched_asym_cpucapacity) &&
+	if (!sched_asym_cpucap_active() &&
 	    capacity_orig_of(i) == SCHED_CAPACITY_SCALE) {
 		return dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT;
 	} else {
@@ -1849,7 +1849,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	 * Take the capacity of the CPU into account to
 	 * ensure it fits the requirement of the task.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity))
+	if (sched_asym_cpucap_active())
 		select_rq |= !dl_task_fits_capacity(p, cpu);
 
 	if (select_rq) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c..41486d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4262,7 +4262,7 @@ static inline int task_fits_capacity(struct task_struct *p,
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 {
-	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+	if (!sched_asym_cpucap_active())
 		return;
 
 	if (!p || p->nr_cpus_allowed == 1) {
@@ -6506,7 +6506,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 
 static inline bool asym_fits_capacity(unsigned long task_util, int cpu)
 {
-	if (static_branch_unlikely(&sched_asym_cpucapacity))
+	if (sched_asym_cpucap_active())
 		return fits_capacity(task_util, capacity_of(cpu));
 
 	return true;
@@ -6526,7 +6526,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * On asymmetric system, update task utilization because we will check
 	 * that the task fits with cpu's capacity.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (sched_asym_cpucap_active()) {
 		sync_entity_load_avg(&p->se);
 		task_util = uclamp_task_util(p);
 	}
@@ -6580,7 +6580,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * For asymmetric CPU capacity systems, our domain of interest is
 	 * sd_asym_cpucapacity rather than sd_llc.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (sched_asym_cpucap_active()) {
 		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
 		/*
 		 * On an asymmetric CPU capacity system where an exclusive
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 55f39c8..054b671 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -509,7 +509,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 	unsigned int cpu_cap;
 
 	/* Only heterogeneous systems can benefit from this check */
-	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+	if (!sched_asym_cpucap_active())
 		return true;
 
 	min_cap = uclamp_eff_value(p, UCLAMP_MIN);
@@ -1897,7 +1897,7 @@ static int find_lowest_rq(struct task_struct *task)
 	 * If we're on asym system ensure we consider the different capacities
 	 * of the CPUs when searching for the lowest_mask.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (sched_asym_cpucap_active()) {
 
 		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
 					  task, lowest_mask,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aad7f5e..86fc360 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1813,6 +1813,11 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
+static __always_inline bool sched_asym_cpucap_active(void)
+{
+	return static_branch_unlikely(&sched_asym_cpucapacity);
+}
+
 struct sched_group_capacity {
 	atomic_t		ref;
 	/*
