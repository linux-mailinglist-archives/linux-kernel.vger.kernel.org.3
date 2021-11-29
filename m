Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7572E461FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379983AbhK2SzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:55:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45470 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380204AbhK2SxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:53:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 686D51F449C6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638211803; bh=DTF6/FoSwYiYGCQeoAe8IMEzQbDr/Pj8OzaQzKmLoHE=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=bV7vNqcFjGUj3U7+VKWwZ0rIe3g02ThjK/M9MaaPfPUD+/z/CatifaJg6bCIdaHRU
         +hRlBpC3X24dKfxHnihxPLvhN8HxhOQA4cv7/ojx6FJZmDL0C4FgLuHYteg82Sa9k/
         dCdzKn+2a1oWb41jTwdqvMaqZP/86Pews4ieAW50b0qcf155Cg1sqH0lVkcNQxwQR8
         2BM+vdseCcv5eu1d9OTrSCTpQm7VEHDF6Sn7QlPuPv4CKej6Mj24oEpVRglCH971Se
         X7uWL6MVNOcvbMkNGWkZMX5EJT8XbvOTBrEahreeo+9EW9pxSAAXPNMmLHQPvGtTiP
         ulZWTb1ZoXYgQ==
Subject: Re: next/master bisection: baseline.dmesg.alert on
 qemu_arm64-virt-gicv3
To:     "Paul E. McKenney" <paulmck@kernel.org>, Martin Lau <kafai@fb.com>
References: <61a14e72.1c69fb81.a607d.66fb@mx.google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-doc@vger.kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Joerg Roedel <jroedel@suse.de>, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, kernelci@groups.io,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <42cba265-2616-9382-324f-11718c8dca0c@collabora.com>
Date:   Mon, 29 Nov 2021 18:50:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <61a14e72.1c69fb81.a607d.66fb@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Please see the bisection report below about a new kernel alert
message.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

Some more details can be found here:

  https://linux.kernelci.org/test/case/id/61a4f02ad5a9e3a5f218f6f6/

The bisection was run on QEMU but it seems to appear on all
platforms as it's not an architecture-specific change.
Presumably, none of the platforms in KernelCI is setting a value
for rcu_task_enqueue_lim at the moment.

Alert messages normally highlight potential problems, so ideally
they would need to be resolved.  Should the message in this case
really be a pr_alert(), and if so what would be the recommended
way to avoid it?

Best wishes,
Guillaume


GitHub: https://github.com/kernelci/kernelci-project/issues/78

On 26/11/2021 21:15, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.dmesg.alert on qemu_arm64-virt-gicv3
> 
> Summary:
>   Start:      f30a24ed97b40 Add linux-next specific files for 20211126
>   Plain log:  https://storage.kernelci.org/next/master/next-20211126/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/clang-13/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20211126/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/clang-13/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
>   Result:     dc9166f1253df rcu-tasks: Use more callback queues if contention encountered
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     qemu_arm64-virt-gicv3
>   CPU arch:   arm64
>   Lab:        lab-collabora
>   Compiler:   clang-13
>   Config:     defconfig+CONFIG_ARM64_64K_PAGES=y
>   Test case:  baseline.dmesg.alert
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit dc9166f1253df20e01b0132ece22efaeb5b0a7e0
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Nov 24 15:12:15 2021 -0800
> 
>     rcu-tasks: Use more callback queues if contention encountered
>     
>     The rcupdate.rcu_task_enqueue_lim module parameter allows system
>     administrators to tune the number of callback queues used by the RCU
>     Tasks flavors.  However if callback storms are infrequent, it would
>     be better to operate with a single queue on a given system unless and
>     until that system actually needed more queues.  Systems not needing
>     more queues can then avoid the overhead of checking the extra queues
>     and especially avoid the overhead of fanning workqueue handlers out to
>     all CPUs to invoke callbacks.
>     
>     This commit therefore switches to using all the CPUs' callback queues if
>     call_rcu_tasks_generic() encounters too much lock contention.  The amount
>     of lock contention to tolerate defaults to 100 contended lock acquisitions
>     per jiffy, and can be adjusted using the new rcupdate.rcu_task_contend_lim
>     module parameter.
>     
>     Such switching is undertaken only if the rcupdate.rcu_task_enqueue_lim
>     module parameter is negative, which is its default value (-1).
>     This allows savvy systems administrators to set the number of queues
>     to some known good value and to not have to worry about the kernel doing
>     any second guessing.
>     
>     Reported-by: Martin Lau <kafai@fb.com>
>     Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f3761fe42c8..fc5e20afaeefa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4813,6 +4813,14 @@
>  			period to instead use normal non-expedited
>  			grace-period processing.
>  
> +	rcupdate.rcu_task_contend_lim= [KNL]
> +			Set the minimum number of callback-queuing-time
> +			lock-contention events per jiffy required to
> +			cause the RCU Tasks flavors to switch to per-CPU
> +			callback queuing.  This switching only occurs
> +			when rcupdate.rcu_task_enqueue_lim is set to
> +			the default value of -1.
> +
>  	rcupdate.rcu_task_enqueue_lim= [KNL]
>  			Set the number of callback queues to use for the
>  			RCU Tasks family of RCU flavors.  The default
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 0cb20e5b3e856..7da3b500fb901 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -142,6 +142,10 @@ module_param(rcu_task_stall_timeout, int, 0644);
>  static int rcu_task_enqueue_lim __read_mostly = -1;
>  module_param(rcu_task_enqueue_lim, int, 0444);
>  
> +static bool rcu_task_cb_adjust;
> +static int rcu_task_contend_lim __read_mostly = 100;
> +module_param(rcu_task_contend_lim, int, 0444);
> +
>  /* RCU tasks grace-period state for debugging. */
>  #define RTGS_INIT		 0
>  #define RTGS_WAIT_WAIT_CBS	 1
> @@ -207,8 +211,11 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  	int lim;
>  
>  	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> -	if (rcu_task_enqueue_lim < 0)
> -		rcu_task_enqueue_lim = nr_cpu_ids;
> +	if (rcu_task_enqueue_lim < 0) {
> +		rcu_task_enqueue_lim = 1;
> +		rcu_task_cb_adjust = true;
> +		pr_alert("%s: Setting adjustable number of callback queues.\n", __func__);
> +	}
>  	else if (rcu_task_enqueue_lim == 0)
>  		rcu_task_enqueue_lim = 1;
>  	lim = rcu_task_enqueue_lim;
> @@ -251,6 +258,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  {
>  	unsigned long flags;
>  	unsigned long j;
> +	bool needadjust = false;
>  	bool needwake;
>  	struct rcu_tasks_percpu *rtpcp;
>  
> @@ -266,7 +274,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  			rtpcp->rtp_jiffies = j;
>  			rtpcp->rtp_n_lock_retries = 0;
>  		}
> -		rtpcp->rtp_n_lock_retries++;
> +		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
> +		    READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
> +			needadjust = true;  // Defer adjustment to avoid deadlock.
>  	}
>  	if (!rcu_segcblist_is_enabled(&rtpcp->cblist)) {
>  		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
> @@ -276,6 +286,15 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  	needwake = rcu_segcblist_empty(&rtpcp->cblist);
>  	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
>  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> +	if (unlikely(needadjust)) {
> +		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> +		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
> +			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids));
> +			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
> +			pr_alert("Switching %s to per-CPU callback queuing.\n", rtp->name);
> +		}
> +		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> +	}
>  	/* We can't create the thread unless interrupts are enabled. */
>  	if (needwake && READ_ONCE(rtp->kthread_ptr)) {
>  		irq_work_queue(&rtpcp->rtp_irq_work);
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [8ced7ca3570333998ad2088d5a6275701970e28e] Merge tag 'block-5.16-2021-11-25' of git://git.kernel.dk/linux-block
> git bisect good 8ced7ca3570333998ad2088d5a6275701970e28e
> # bad: [f30a24ed97b401416118756fa35fbe5d28f999e3] Add linux-next specific files for 20211126
> git bisect bad f30a24ed97b401416118756fa35fbe5d28f999e3
> # good: [d7359ce68f20102beeec57e760b746e1f76ab65c] Merge branch 'mtd/next' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
> git bisect good d7359ce68f20102beeec57e760b746e1f76ab65c
> # good: [6eb0c6fb36d50e66ca0b686ec0eebd7eddff811b] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
> git bisect good 6eb0c6fb36d50e66ca0b686ec0eebd7eddff811b
> # bad: [e62c6fa2d7d055d657c00734314d6abc664d28b5] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> git bisect bad e62c6fa2d7d055d657c00734314d6abc664d28b5
> # good: [0ebaaa3b9daaf0341c75a66b8b33399e23e40a8f] Merge branch 'edac-for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
> git bisect good 0ebaaa3b9daaf0341c75a66b8b33399e23e40a8f
> # bad: [556fc834ce0be2f0dbfd8ae2bfb3840326d12cb9] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
> git bisect bad 556fc834ce0be2f0dbfd8ae2bfb3840326d12cb9
> # good: [ad3b4071d577f2779c706a22956b6d167710459b] refscale: Simplify the errexit checkpoint
> git bisect good ad3b4071d577f2779c706a22956b6d167710459b
> # good: [24f474cf45326225f613b58b191600311109695b] rcutorture: Cause TREE02 and TREE10 scenarios to do more callback flooding
> git bisect good 24f474cf45326225f613b58b191600311109695b
> # bad: [731f2830b96ce040e52b227346087e0dc3a6f5d0] Merge branch 'linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
> git bisect bad 731f2830b96ce040e52b227346087e0dc3a6f5d0
> # bad: [3a528960b4b5d4069e4b066a1d9278862e902abc] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> git bisect bad 3a528960b4b5d4069e4b066a1d9278862e902abc
> # bad: [a106e93308b6c60944c9021fc2cad377639584a2] rcu/nocb: Remove rdp from nocb list when de-offloaded
> git bisect bad a106e93308b6c60944c9021fc2cad377639584a2
> # good: [a3d09240cbfd98525dbd7038a4ec1afb4bc896a2] rcu-tasks: Avoid raw-spinlocked wakeups from call_rcu_tasks_generic()
> git bisect good a3d09240cbfd98525dbd7038a4ec1afb4bc896a2
> # bad: [4e83e8074d198b5849926d4a7d921063b24c0250] rcutorture: Test RCU Tasks lock-contention detection
> git bisect bad 4e83e8074d198b5849926d4a7d921063b24c0250
> # bad: [dc9166f1253df20e01b0132ece22efaeb5b0a7e0] rcu-tasks: Use more callback queues if contention encountered
> git bisect bad dc9166f1253df20e01b0132ece22efaeb5b0a7e0
> # first bad commit: [dc9166f1253df20e01b0132ece22efaeb5b0a7e0] rcu-tasks: Use more callback queues if contention encountered
> -------------------------------------------------------------------------------
> 

