Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42E492EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348987AbiARUGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:06:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49816 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiARUGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:06:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E178BB81803
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 20:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BE7C340E0;
        Tue, 18 Jan 2022 20:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642536406;
        bh=VhJc7R9+z6kDHDc6ufAdOxD1A8NiV4DsHwQwddn6Wmg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tb01A+t13BTzA3px9IFh6fYovxvL+ihLzqKXPS4kd9DGJi4qUwJYJQ9xjTVbGZl9H
         xOETXFjJj2yFgfwdb6/nbbvdtmAsrPgd9tftrNSjGpbZJIvq2e0VllKp2Wzwju1bG7
         zIGasOt52Qv2KEHzCQeK1qus0BsdVnO11WuINpp/EunfdrVKijhlMknUgJJhluLrbt
         EwOOXLkYlO9jl05/WJ0yqXelh2V//YmqQAjiiYwzXxGODL8CyMdTcnwyudI598Dxn9
         UPqaEhraJUa+H6eyg/epP4AKFs9ryCCG4XZBQA48y1cUrdiflgLJ6cRFTWE/l72MBg
         kSZKWJCIYADeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3AC4E5C0A21; Tue, 18 Jan 2022 12:06:46 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:06:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, tj@kernel.org,
        jiangshanlai@gmail.com
Subject: Re: synchronize_rcu_expedited gets stuck in hotplug path
Message-ID: <20220118200646.GJ947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 05:16:39PM +0530, Mukesh Ojha wrote:
> Hi ,
> 
> We are facing one issue in hotplug test where cpuhp/2 gets stuck in below
> path [1] in
> synchronize_rcu_expedited at state CPUHP_AP_ONLINE_DYN and it is not able to
> proceed.
> We see wait_rcu_exp_gp() is queued to cpu2  and it looks like it did not get
> chance to
> run as we see it as in pending state at cpu2 [2].
> 
> So, when exactly cpu2 gets available for scheduling in hotplug path, is it
> after
> CPUHP_AP_ACTIVE?
> 
> It looks to be dead lock here. Can it be fixed by making wait_rcu_exp_gp()
> queued on another wq ?
> or is it a wrong usage of synchronise_rcu in hotplug path?
> 
> [1]
> 
> =======================================================
> Process: cpuhp/2, [affinity: 0x4] cpu: 2 pid: 24 start: 0xffffff87803e4a00
> =====================================================
>     Task name: cpuhp/2 [affinity: 0x4] pid: 24 cpu: 2 prio: 120 start:
> ffffff87803e4a00
>     state: 0x2[D] exit_state: 0x0 stack base: 0xffffffc010160000
>     Last_enqueued_ts:      59.022215498 Last_sleep_ts: 59.022922946
>     Stack:
>     [<ffffffe9f4074354>] __switch_to+0x248
>     [<ffffffe9f5c02474>] __schedule+0x5b0
>     [<ffffffe9f5c02b28>] schedule+0x80
>     [<ffffffe9f42321a4>] synchronize_rcu_expedited+0x1c4
>     [<ffffffe9f423b294>] synchronize_rcu+0x4c
>     [<ffffffe9f6d04ab0>] waltgov_stop[sched_walt]+0x78
>     [<ffffffe9f512fa28>] cpufreq_add_policy_cpu+0xc0
>     [<ffffffe9f512e48c>] cpufreq_online[jt]+0x10f4
>     [<ffffffe9f51323b8>] cpuhp_cpufreq_online+0x14
>     [<ffffffe9f4128d3c>] cpuhp_invoke_callback+0x2f8
>     [<ffffffe9f412c30c>] cpuhp_thread_fun+0x130
>     [<ffffffe9f4187a58>] smpboot_thread_fn+0x180
>     [<ffffffe9f417d98c>] kthread+0x150
>     [<ffffffe9f4013918>] ret_to_user[jt]+0x0
> 
> 
> [2]
> 
> CPU 2
> pool 0
> IDLE Workqueue worker: kworker/2:3 current_work: (None)
> IDLE Workqueue worker: kworker/2:2 current_work: (None)
> IDLE Workqueue worker: kworker/2:1 current_work: (None)
> IDLE Workqueue worker: kworker/2:0 current_work: (None)
> Pending entry: wait_rcu_exp_gp[jt]
> Pending entry: lru_add_drain_per_cpu[jt]
> Pending entry: wq_barrier_func[jt]

Interesting.  Adding Tejun and Lai on CC for their perspective.

As you say, the incoming CPU invoked synchronize_rcu_expedited() which
in turn invoked queue_work().  By default, workqueues will of course
queue that work on the current CPU.  But in this case, the CPU's bit
is not yet set in the cpu_active_mask.  Thus, a workqueue scheduled on
the incoming CPU won't be invoked until CPUHP_AP_ACTIVE, which won't
be reached until after the grace period ends, which cannot happen until
the workqueue handler is invoked.

I could imagine doing something as shown in the (untested) patch below,
but first does this help?

If it does help, would this sort of check be appropriate here or
should it instead go into workqueues?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 60197ea24ceb9..03c0556b29f22 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -849,7 +849,15 @@ void synchronize_rcu_expedited(void)
 		/* Marshall arguments & schedule the expedited grace period. */
 		rew.rew_s = s;
 		INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
-		queue_work(rcu_gp_wq, &rew.rew_work);
+		preempt_disable();
+		if (cpumask_test_cpu(smp_processor_id(), cpu_active_mask)) {
+			preempt_enable();
+			queue_work(rcu_gp_wq, &rew.rew_work);
+		} else {
+			// Avoid incoming CPUs.
+			preempt_enable();
+			queue_work_on(cpumask_first(cpu_active_mask), rcu_gp_wq, &rew.rew_work);
+		}
 	}
 
 	/* Wait for expedited grace period to complete. */
