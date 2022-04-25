Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6850E4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiDYPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiDYPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:48:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1321EE097;
        Mon, 25 Apr 2022 08:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96E1861193;
        Mon, 25 Apr 2022 15:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F030DC385A4;
        Mon, 25 Apr 2022 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650901534;
        bh=kEg9Ej+RVwE10sPW8R1T8nYIpOqUg2eB7gujP8uczO4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pCftuB9E269d9NR9dr4LmxSuKMQSaU/x7e4yP561h/x+35/Pistz2MhOtWIOtAoph
         hYWmyJ0vdTLAVYHV7Jbh+YEHcFZkOmEmwVFZa3V1EJZyrOzgFHDde/6JLFu4GzTwEC
         PEEAjC8PWJNLJrClxAF3oUiohgXXXAa0KcCnUl1GXX+iGMyHbvw2GIksoXVrLPecfi
         kAoZDVuBJlm14Dar+h+Ouf3cMM1iYF3M78nJhw1iSuEqsH5NZKvoOXgDmRjSUiCbmp
         +92iKvjHjchI4SIOoR6o0u4u8PXMBFf8aUuCNbRzLSAMk2V/HL9wDM3ka6JlcOiYb8
         cSmTu3m6SZcoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 95FC45C042D; Mon, 25 Apr 2022 08:45:33 -0700 (PDT)
Date:   Mon, 25 Apr 2022 08:45:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Message-ID: <20220425154533.GT4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220425010404.3249118-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425010404.3249118-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:04:04AM +0800, Zqiang wrote:
> If the rcutree.use_softirq is configured, when RCU Stall event
> happened, dump status of all rcuc kthreads who due to starvation
> prevented grace period ends on CPUs that not report quiescent
> state.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  rework rcuc_kthread_dump function
>  v2->v3:
>  merge this rcuc-stalled information into print_cpu_stall_info()
>  v3->v4:
>  print rcuc info only when rcuc kthread is starved
> 
>  kernel/rcu/tree_stall.h | 49 ++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)

I have queued this for testing and further review, thank you!

I did the usual wordsmithing, plus I got rid of a couple of space
characters that are extraneous in the common case (one of yours and one
pre-existing instance).

Could you please generate an actual stall of this type?  You might
need to add a delay to the rcuc code, but other than that, please see
the rcutorture blog series [1] and in particular the post on forcing
stall warnings [2].

							Thanx, Paul

[1] https://paulmck.livejournal.com/61432.html
[2] https://paulmck.livejournal.com/58077.html

------------------------------------------------------------------------

commit 66226e2acda8b31b60137b1ae71244df68541a01
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Mon Apr 25 09:04:04 2022 +0800

    rcu: Dump all rcuc kthreads status for CPUs that not report quiescent state
    
    If the rcutree.use_softirq kernel boot parameter is disabled, then it is
    possible that a RCU CPU stall is due to the rcuc kthreads being starved of
    CPU time.  There is currently no easy way to infer this from the RCU CPU
    stall warning output.  This commit therefore adds a string of the form "
    rcuc=%ld jiffies(starved)" to a given CPU's output if the corresponding
    rcuc kthread has been starved for more than two seconds.
    
    [ paulmck: Eliminate extraneous space characters. ]
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d7956c03edbd4..0a25a4ea6eef8 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -407,7 +407,19 @@ static bool rcu_is_gp_kthread_starving(unsigned long *jp)
 
 static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp)
 {
-	unsigned long j = jiffies - READ_ONCE(rdp->rcuc_activity);
+	int cpu;
+	struct task_struct *rcuc;
+	unsigned long j;
+
+	rcuc = rdp->rcu_cpu_kthread_task;
+	if (!rcuc)
+		return false;
+
+	cpu = task_cpu(rcuc);
+	if (cpu_is_offline(cpu) || idle_cpu(cpu))
+		return false;
+
+	j = jiffies - READ_ONCE(rdp->rcuc_activity);
 
 	if (jp)
 		*jp = j;
@@ -432,6 +444,9 @@ static void print_cpu_stall_info(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	char *ticks_title;
 	unsigned long ticks_value;
+	bool rcuc_starved;
+	unsigned long j;
+	char buf[32];
 
 	/*
 	 * We could be printing a lot while holding a spinlock.  Avoid
@@ -449,7 +464,10 @@ static void print_cpu_stall_info(int cpu)
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
+	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
+	if (rcuc_starved)
+		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -462,32 +480,10 @@ static void print_cpu_stall_info(int cpu)
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
+	       rcuc_starved ? buf : "",
 	       falsepositive ? " (false positive?)" : "");
 }
 
-static void rcuc_kthread_dump(struct rcu_data *rdp)
-{
-	int cpu;
-	unsigned long j;
-	struct task_struct *rcuc;
-
-	rcuc = rdp->rcu_cpu_kthread_task;
-	if (!rcuc)
-		return;
-
-	cpu = task_cpu(rcuc);
-	if (cpu_is_offline(cpu) || idle_cpu(cpu))
-		return;
-
-	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
-		return;
-
-	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
-	sched_show_task(rcuc);
-	if (!trigger_single_cpu_backtrace(cpu))
-		dump_cpu_task(cpu);
-}
-
 /* Complain about starvation of grace-period kthread.  */
 static void rcu_check_gp_kthread_starvation(void)
 {
@@ -659,9 +655,6 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
-	if (!use_softirq)
-		rcuc_kthread_dump(rdp);
-
 	rcu_dump_cpu_stacks();
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
