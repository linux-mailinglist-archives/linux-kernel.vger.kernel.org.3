Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0425B5888C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiHCIkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiHCIkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:40:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605701CB21;
        Wed,  3 Aug 2022 01:40:09 -0700 (PDT)
Date:   Wed, 03 Aug 2022 08:40:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659516007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JXmHOlYXR1w8dz7T89GOgxSZ8Owasc4ZCod57g8KkMs=;
        b=Zp8MMsXGF27arY6+W1xL8xyabiQDbxBjJnmn7epwllx+DXIBPyfWq4P2ZemY1PF1av8FfW
        nBzd08jv61W+COVbYrf0x0qjZbPiHKOcjY3ktr08bIiPD2z0B6WVrgMWrT58/4ZFmqe2Qn
        XO2LGbQzg5YRnQv6yUhO+n9x28jpb4ofLXt6xkSUweOTnSriWc8xiwfs0y/Pb1zDZnx7d0
        RJPuQN1v3tBldzFxfD88UGqm9N+st2qycxV49b98yIzUBTtqbICr3MJlqtDWPN1w8LgYzF
        vc2pS1EvnfjGx+LNIFYK1nBktNKHEDYGC0xx7QKDGpoPQgHxiLqovCXPGq19ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659516007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JXmHOlYXR1w8dz7T89GOgxSZ8Owasc4ZCod57g8KkMs=;
        b=2yy0m9t45FGd9foJlEffeec13f2nD5ESshKe1qTfKueRhMbV5UGj6t0FZFtKUx1NwAd9wB
        RuRIxiz3HsgvJRDg==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched, cpuset: Fix dl_cpu_busy() panic due to
 empty cs->cpus_allowed
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220803015451.2219567-1-longman@redhat.com>
References: <20220803015451.2219567-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <165951600567.15455.17749747397311406497.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b6e8d40d43ae4dec00c8fea2593eeea3114b8f44
Gitweb:        https://git.kernel.org/tip/b6e8d40d43ae4dec00c8fea2593eeea3114b8f44
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Tue, 02 Aug 2022 21:54:51 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Aug 2022 10:34:26 +02:00

sched, cpuset: Fix dl_cpu_busy() panic due to empty cs->cpus_allowed

With cgroup v2, the cpuset's cpus_allowed mask can be empty indicating
that the cpuset will just use the effective CPUs of its parent. So
cpuset_can_attach() can call task_can_attach() with an empty mask.
This can lead to cpumask_any_and() returns nr_cpu_ids causing the call
to dl_bw_of() to crash due to percpu value access of an out of bound
CPU value. For example:

	[80468.182258] BUG: unable to handle page fault for address: ffffffff8b6648b0
	  :
	[80468.191019] RIP: 0010:dl_cpu_busy+0x30/0x2b0
	  :
	[80468.207946] Call Trace:
	[80468.208947]  cpuset_can_attach+0xa0/0x140
	[80468.209953]  cgroup_migrate_execute+0x8c/0x490
	[80468.210931]  cgroup_update_dfl_csses+0x254/0x270
	[80468.211898]  cgroup_subtree_control_write+0x322/0x400
	[80468.212854]  kernfs_fop_write_iter+0x11c/0x1b0
	[80468.213777]  new_sync_write+0x11f/0x1b0
	[80468.214689]  vfs_write+0x1eb/0x280
	[80468.215592]  ksys_write+0x5f/0xe0
	[80468.216463]  do_syscall_64+0x5c/0x80
	[80468.224287]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Fix that by using effective_cpus instead. For cgroup v1, effective_cpus
is the same as cpus_allowed. For v2, effective_cpus is the real cpumask
to be used by tasks within the cpuset anyway.

Also update task_can_attach()'s 2nd argument name to cs_effective_cpus to
reflect the change. In addition, a check is added to task_can_attach()
to guard against the possibility that cpumask_any_and() may return a
value >= nr_cpu_ids.

Fixes: 7f51412a415d ("sched/deadline: Fix bandwidth check/update when migrating tasks between exclusive cpusets")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20220803015451.2219567-1-longman@redhat.com
---
 include/linux/sched.h  | 2 +-
 kernel/cgroup/cpuset.c | 2 +-
 kernel/sched/core.c    | 8 +++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 88b8817..6a06016 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1813,7 +1813,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
+extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 71a4188..58aadfd 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2239,7 +2239,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		goto out_unlock;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		ret = task_can_attach(task, cs->cpus_allowed);
+		ret = task_can_attach(task, cs->effective_cpus);
 		if (ret)
 			goto out_unlock;
 		ret = security_task_setscheduler(task);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5555e49..addc3c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8980,7 +8980,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 }
 
 int task_can_attach(struct task_struct *p,
-		    const struct cpumask *cs_cpus_allowed)
+		    const struct cpumask *cs_effective_cpus)
 {
 	int ret = 0;
 
@@ -8999,9 +8999,11 @@ int task_can_attach(struct task_struct *p,
 	}
 
 	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
-					      cs_cpus_allowed)) {
-		int cpu = cpumask_any_and(cpu_active_mask, cs_cpus_allowed);
+					      cs_effective_cpus)) {
+		int cpu = cpumask_any_and(cpu_active_mask, cs_effective_cpus);
 
+		if (unlikely(cpu >= nr_cpu_ids))
+			return -EINVAL;
 		ret = dl_cpu_busy(cpu, p);
 	}
 
