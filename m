Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F724813C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhL2OBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:01:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:31128 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235281AbhL2OBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640786510; x=1672322510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ppUtLQur1seW0axm/yRNvFL5dOfSH1Dgy5PjiFsWo/Q=;
  b=YfVC3uvk2dOciqksEmJwOI3Sg8M52/xI+RAllVjSRXAx5wJQoEMP94zb
   NCjT/3VbdGr7us2qPFytYZwsfGEDyWZ5bbXKazafmsm6S1dL/YYZ2CXI2
   zWsBRRkKpkoRwvjfDRkGixuuzP87Zmfef3mD1/9diDrNmjxwHCdi5qcoL
   6jmDCHR2ThR2jFMHremidTOtxR0nRGs3jWHY46M0MEgTvUlzVgRXXifLH
   57FcDcLAWfP6KboraWR+J5jhinB9l+v6ScsdbWl8T1g5poEHSlkxCE1Of
   /UGgHBGrjiIqwTwobptP5gqtWK0Pu9IhvcfOebjSDvnbrngMXneOZK08n
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="302274312"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="302274312"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 06:01:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="524031906"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 06:01:28 -0800
Date:   Wed, 29 Dec 2021 22:01:21 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [rcutorture]  82e310033d:
 WARNING:possible_recursive_locking_detected
Message-ID: <20211229140121.GA10390@xsang-OptiPlex-9020>
References: <20211228151135.GB31268@xsang-OptiPlex-9020>
 <20211229000609.GY4109570@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229000609.GY4109570@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Paul,

On Tue, Dec 28, 2021 at 04:06:09PM -0800, Paul E. McKenney wrote:
> On Tue, Dec 28, 2021 at 11:11:35PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 82e310033d7c21a7a88427f14e0dad78d731a5cd ("rcutorture: Enable multiple concurrent callback-flood kthreads")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: rcutorture
> > version: 
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	test: default
> > 	torture_type: rcu
> > 
> > test-description: rcutorture is rcutorture kernel module load/unload test.
> > test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> > 
> > 
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +-------------------------------------------------------------------------------+------------+------------+
> > |                                                                               | 12e885433d | 82e310033d |
> > +-------------------------------------------------------------------------------+------------+------------+
> > | boot_successes                                                                | 95         | 47         |
> > | boot_failures                                                                 | 31         | 25         |
> > | invoked_oom-killer:gfp_mask=0x                                                | 5          | 4          |
> > | Mem-Info                                                                      | 10         | 16         |
> > | WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_oom_notify[rcutorture]         | 24         | 15         |
> > | EIP:rcutorture_oom_notify                                                     | 24         | 15         |
> > | page_allocation_failure:order:#,mode:#(GFP_NOWAIT|__GFP_COMP),nodemask=(null) | 5          | 12         |
> > | WARNING:possible_recursive_locking_detected                                   | 0          | 15         |
> > | WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog.cold[rcutorture]     | 0          | 6          |
> > | EIP:rcu_torture_fwd_prog.cold                                                 | 0          | 6          |
> > +-------------------------------------------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> Good catch!  Does this following patch address it?

we applied below patch upon next-20211224,
confirmed no "WARNING:possible_recursive_locking_detected" after patch.

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
  gcc-9/i386-randconfig-a002-20211003/debian-i386-20191205.cgz/300s/vm-snb-i386/default/rcutorture/rcu

commit:
  next-20211224
  917801238dcca ("rcutorture: Fix rcu_fwd_mutex deadlock")

   next-20211224 917801238dccaf61a63ffe77890
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          3:100         -1%           2:100   dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
          2:100         -2%            :100   dmesg.BUG:workqueue_lockup-pool
          1:100         -1%            :100   dmesg.EIP:clear_user
          2:100          2%           4:100   dmesg.EIP:rcu_torture_fwd_prog_cr
         15:100         -3%          12:100   dmesg.EIP:rcutorture_oom_notify
          2:100         -2%            :100   dmesg.Kernel_panic-not_syncing:System_is_deadlocked_on_memory
          9:100         -5%           4:100   dmesg.Mem-Info
          2:100         -2%            :100   dmesg.Out_of_memory_and_no_killable_processes
          2:100          2%           4:100   dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_cr[rcutorture]
         15:100         -3%          12:100   dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_oom_notify[rcutorture]
         15:100        -15%            :100   dmesg.WARNING:possible_recursive_locking_detected    <--------
          3:100         -1%           2:100   dmesg.invoked_oom-killer:gfp_mask=0x
          6:100         -4%           2:100   dmesg.page_allocation_failure:order:#,mode:#(GFP_NOWAIT|__GFP_COMP),nodemask=(null)
        100:100          0%         100:100   dmesg.sysctl_table_check_failed


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit dd47cbdcc2f72ba3df1248fb7fe210acca18d09c
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Dec 28 15:59:38 2021 -0800
> 
>     rcutorture: Fix rcu_fwd_mutex deadlock
>     
>     The rcu_torture_fwd_cb_hist() function acquires rcu_fwd_mutex, but is
>     invoked from rcutorture_oom_notify() function, which hold this same
>     mutex across this call.  This commit fixes the resulting deadlock.
>     
>     Reported-by: kernel test robot <oliver.sang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 918a2ea34ba13..9190dce686208 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2184,7 +2184,6 @@ static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
>  	for (i = ARRAY_SIZE(rfp->n_launders_hist) - 1; i > 0; i--)
>  		if (rfp->n_launders_hist[i].n_launders > 0)
>  			break;
> -	mutex_lock(&rcu_fwd_mutex); // Serialize histograms.
>  	pr_alert("%s: Callback-invocation histogram %d (duration %lu jiffies):",
>  		 __func__, rfp->rcu_fwd_id, jiffies - rfp->rcu_fwd_startat);
>  	gps_old = rfp->rcu_launder_gp_seq_start;
> @@ -2197,7 +2196,6 @@ static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
>  		gps_old = gps;
>  	}
>  	pr_cont("\n");
> -	mutex_unlock(&rcu_fwd_mutex);
>  }
>  
>  /* Callback function for continuous-flood RCU callbacks. */
> @@ -2435,7 +2433,9 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
>  			 n_launders, n_launders_sa,
>  			 n_max_gps, n_max_cbs, cver, gps);
>  		atomic_long_add(n_max_cbs, &rcu_fwd_max_cbs);
> +		mutex_lock(&rcu_fwd_mutex); // Serialize histograms.
>  		rcu_torture_fwd_cb_hist(rfp);
> +		mutex_unlock(&rcu_fwd_mutex);
>  	}
>  	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
>  	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
