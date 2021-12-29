Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41052480E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbhL2AGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhL2AGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:06:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC67BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C82A6135A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 00:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D3CC36AE7;
        Wed, 29 Dec 2021 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640736370;
        bh=FmTOpyC+Uihuv8InsJW28vRQSTYEGvWcZ/wYx/QEI8Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=az2LwHRSfig1Buc0l/ZtJKrkP5nybK/nyNNyRmsxOz6BbiNkBjWaBloQyJRVZpDZo
         jJhtC1Cn1mPwBDckHqeiotxtJRnGYdn3uYxdI4jphDioIpC1HY+UDhYsToT7OpBWU9
         PZ+TS+NJIcdVbylfNNNPIKAsAUMHjhHBFwH7BjsOJf6IwywJMoiePxdBm1Gve2g+m/
         ZIm/I47m90SJJ7kZriOXl2vFX55Ls8+evxj6Wwp+lqVLtehXYn5rEeT7JUq9gkhZhD
         jTaGsifQPR1J60yvinmCtT3t+J9Gl/AEu/6jMBc7qT8kFMfdS56/bzmMVUYP5D1zGY
         Po7VVnrIgC3bA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9DB3E5C19E9; Tue, 28 Dec 2021 16:06:09 -0800 (PST)
Date:   Tue, 28 Dec 2021 16:06:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [rcutorture]  82e310033d:
 WARNING:possible_recursive_locking_detected
Message-ID: <20211229000609.GY4109570@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211228151135.GB31268@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228151135.GB31268@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 11:11:35PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 82e310033d7c21a7a88427f14e0dad78d731a5cd ("rcutorture: Enable multiple concurrent callback-flood kthreads")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 	torture_type: rcu
> 
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-------------------------------------------------------------------------------+------------+------------+
> |                                                                               | 12e885433d | 82e310033d |
> +-------------------------------------------------------------------------------+------------+------------+
> | boot_successes                                                                | 95         | 47         |
> | boot_failures                                                                 | 31         | 25         |
> | invoked_oom-killer:gfp_mask=0x                                                | 5          | 4          |
> | Mem-Info                                                                      | 10         | 16         |
> | WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_oom_notify[rcutorture]         | 24         | 15         |
> | EIP:rcutorture_oom_notify                                                     | 24         | 15         |
> | page_allocation_failure:order:#,mode:#(GFP_NOWAIT|__GFP_COMP),nodemask=(null) | 5          | 12         |
> | WARNING:possible_recursive_locking_detected                                   | 0          | 15         |
> | WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog.cold[rcutorture]     | 0          | 6          |
> | EIP:rcu_torture_fwd_prog.cold                                                 | 0          | 6          |
> +-------------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

Good catch!  Does this following patch address it?

							Thanx, Paul

------------------------------------------------------------------------

commit dd47cbdcc2f72ba3df1248fb7fe210acca18d09c
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Dec 28 15:59:38 2021 -0800

    rcutorture: Fix rcu_fwd_mutex deadlock
    
    The rcu_torture_fwd_cb_hist() function acquires rcu_fwd_mutex, but is
    invoked from rcutorture_oom_notify() function, which hold this same
    mutex across this call.  This commit fixes the resulting deadlock.
    
    Reported-by: kernel test robot <oliver.sang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 918a2ea34ba13..9190dce686208 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2184,7 +2184,6 @@ static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
 	for (i = ARRAY_SIZE(rfp->n_launders_hist) - 1; i > 0; i--)
 		if (rfp->n_launders_hist[i].n_launders > 0)
 			break;
-	mutex_lock(&rcu_fwd_mutex); // Serialize histograms.
 	pr_alert("%s: Callback-invocation histogram %d (duration %lu jiffies):",
 		 __func__, rfp->rcu_fwd_id, jiffies - rfp->rcu_fwd_startat);
 	gps_old = rfp->rcu_launder_gp_seq_start;
@@ -2197,7 +2196,6 @@ static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
 		gps_old = gps;
 	}
 	pr_cont("\n");
-	mutex_unlock(&rcu_fwd_mutex);
 }
 
 /* Callback function for continuous-flood RCU callbacks. */
@@ -2435,7 +2433,9 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 			 n_launders, n_launders_sa,
 			 n_max_gps, n_max_cbs, cver, gps);
 		atomic_long_add(n_max_cbs, &rcu_fwd_max_cbs);
+		mutex_lock(&rcu_fwd_mutex); // Serialize histograms.
 		rcu_torture_fwd_cb_hist(rfp);
+		mutex_unlock(&rcu_fwd_mutex);
 	}
 	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
