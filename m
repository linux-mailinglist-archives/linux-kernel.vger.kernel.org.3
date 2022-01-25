Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41EC49BBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiAYTP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:15:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33282 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiAYTPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:15:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8965FB818C2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475CAC340E0;
        Tue, 25 Jan 2022 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643138152;
        bh=sdxgb5HjQuP41O+/z47BfzmPcZv7v2ik+prUZ/cjteM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rPoojFN29KTbq+IOW6fklTIqc//3MTm+h5HA7YNXM6rgkAfF7KE9hxehjnb03LN3X
         ihimvMW+Fol9ywjatjOox2xV03/qqjnWMtW7H1pVaWaZGTB1C9Q8L2OIjzkE1Y/T3n
         z3FqY+wKtqBSTVtUzKZL9NeFvMRHP8gx8dcqiyQGlHn6zwtPQeVuvSglGl3+Ac0VMW
         GnQ8RNr9CxyMFXO1eznJvLXyh6X81DM/CC0uA2nZnPIeb5/hJDbI0RhThKru3jUG/r
         z7WKZOoNhjoGIb6uc33TjXnChdZfNbsos3YYcgv+ECkx1iC8aSOuGHlaCQUHtpPIxg
         V4X2B9O0uTa2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C79A85C0641; Tue, 25 Jan 2022 11:15:51 -0800 (PST)
Date:   Tue, 25 Jan 2022 11:15:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add per-CPU rcuc task info to RCU CPU stall
 warnings
Message-ID: <20220125191551.GR4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220125024744.4186726-1-qiang1.zhang@intel.com>
 <df2d15fe-bc81-bdb1-1c31-2d717f274ab0@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df2d15fe-bc81-bdb1-1c31-2d717f274ab0@gnuweeb.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:04:04PM +0700, Ammar Faizi wrote:
> On 1/25/22 9:47 AM, Zqiang wrote:
> > When the 'use_softirq' be set zero, all RCU_SOFTIRQ processing
> > be moved to per-CPU rcuc kthreads, if the rcuc kthreads is
> > being starved, quiescent state can not report in time. the
> > RCU stall may be triggered. this commit adds a stack trace of
> > this CPU and dump rcuc kthreads stack to help analyze what
> > prevents rcuc kthreads from running.
> > 
> > Suggested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> 
> For https://lore.kernel.org/lkml/20220125024744.4186726-1-qiang1.zhang@intel.com/T/
> 
> ```
> 
> Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> ```

I queued this wordsmithed as shown below.  Please check to see if
I messed anything up.  And thank you both!

							Thanx, Paul

------------------------------------------------------------------------

commit 72bdc0a6f8cfb7cc56238dc850b7fe236e7371cb
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Tue Jan 25 10:47:44 2022 +0800

    rcu: Add per-CPU rcuc task dumps to RCU CPU stall warnings
    
    When the rcutree.use_softirq kernel boot parameter is set to zero, all
    RCU_SOFTIRQ processing is carried out by the per-CPU rcuc kthreads.
    If these kthreads are being starved, quiescent states will not be
    reported, which in turn means that the grace period will not end, which
    can in turn trigger RCU CPU stall warnings.  This commit therefore dumps
    stack traces of stalled CPUs' rcuc kthreads, which can help identify
    what is preventing those kthreads from running.
    
    Suggested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
    Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f071c49b37118..e6ad532cffe78 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2859,10 +2859,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
 {
 	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
 	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
+	unsigned long *j = this_cpu_ptr(&rcu_data.rcuc_activity);
 	int spincnt;
 
 	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
 	for (spincnt = 0; spincnt < 10; spincnt++) {
+		WRITE_ONCE(*j, jiffies);
 		local_bh_disable();
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
@@ -2883,6 +2885,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 	schedule_timeout_idle(2);
 	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
 	*statusp = RCU_KTHREAD_WAITING;
+	WRITE_ONCE(*j, jiffies);
 }
 
 static struct smp_hotplug_thread rcu_cpu_thread_spec = {
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a87f31b1701db..926673ebe355f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -241,6 +241,7 @@ struct rcu_data {
 					/* rcuc per-CPU kthread or NULL. */
 	unsigned int rcu_cpu_kthread_status;
 	char rcu_cpu_has_work;
+	unsigned long rcuc_activity;
 
 	/* 7) Diagnostic data, including RCU CPU stall warnings. */
 	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4781aa338c7c1..6082dd23408f8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -994,12 +994,15 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
  */
 static void rcu_cpu_kthread_setup(unsigned int cpu)
 {
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 #ifdef CONFIG_RCU_BOOST
 	struct sched_param sp;
 
 	sp.sched_priority = kthread_prio;
 	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
 #endif /* #ifdef CONFIG_RCU_BOOST */
+
+	WRITE_ONCE(rdp->rcuc_activity, jiffies);
 }
 
 #ifdef CONFIG_RCU_BOOST
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 21bebf7c9030b..0c5d8516516af 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -379,6 +379,15 @@ static bool rcu_is_gp_kthread_starving(unsigned long *jp)
 	return j > 2 * HZ;
 }
 
+static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp)
+{
+	unsigned long j = jiffies - READ_ONCE(rdp->rcuc_activity);
+
+	if (jp)
+		*jp = j;
+	return j > 2 * HZ;
+}
+
 /*
  * Print out diagnostic information for the specified stalled CPU.
  *
@@ -430,6 +439,29 @@ static void print_cpu_stall_info(int cpu)
 	       falsepositive ? " (false positive?)" : "");
 }
 
+static void rcuc_kthread_dump(struct rcu_data *rdp)
+{
+	int cpu;
+	unsigned long j;
+	struct task_struct *rcuc;
+
+	rcuc = rdp->rcu_cpu_kthread_task;
+	if (!rcuc)
+		return;
+
+	cpu = task_cpu(rcuc);
+	if (cpu_is_offline(cpu) || idle_cpu(cpu))
+		return;
+
+	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
+		return;
+
+	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
+	sched_show_task(rcuc);
+	if (!trigger_single_cpu_backtrace(cpu))
+		dump_cpu_task(cpu);
+}
+
 /* Complain about starvation of grace-period kthread.  */
 static void rcu_check_gp_kthread_starvation(void)
 {
@@ -601,6 +633,9 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
+	if (!use_softirq)
+		rcuc_kthread_dump(rdp);
+
 	rcu_dump_cpu_stacks();
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
