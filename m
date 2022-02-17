Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783DA4B9E97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbiBQLaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:30:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbiBQLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:30:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ABD26A2C9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:30:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FDC61E58
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8857C340E8;
        Thu, 17 Feb 2022 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645097415;
        bh=4emmqHfthmmB8ODpGrbr2bPW1dMIbwSnyFkKqBB7iL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKPCUNOIHrQS6+ABFE5ecNx+WgsXYdAVx+wGfmVG4NfzN5P8+BfMwjhv/oNkr+7is
         hvwmtvzv2uQF9vld+OpOfToEFLjbDgxU8UNWW+a1tqRUCuJAU+o8EQ80MQoRVK8KcR
         ELKmtTFdpSFgeT6bEPMqgHdI5W9K/NyH4aNPyMYKexcz47Po7oxC1efFNcmIiQ9Oag
         b6oKwhWNimE0cBsapNpNSFpigvoRLsCGOyddqrjLjYtyIcUzPcd8yD1Wa3wS74XeJY
         M49ImJqDqTQajRtaSLfa2VIQqS5aUWXnjIydTWgz/IzONvKgR+aA8f1WUteB/fDAHV
         SPOoVvdxLMA2Q==
Date:   Thu, 17 Feb 2022 12:30:12 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/5] rcu/nocb: Move rcu_nocb_is_setup to rcu_state
Message-ID: <20220217113012.GB742892@lothringen>
References: <20220216154208.696069-1-frederic@kernel.org>
 <20220216154208.696069-3-frederic@kernel.org>
 <20220216213035.GA2442742@paulmck-ThinkPad-P17-Gen-1>
 <20220217015332.GA2455440@paulmck-ThinkPad-P17-Gen-1>
 <20220217052804.GA2461302@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217052804.GA2461302@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 09:28:04PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 16, 2022 at 05:53:32PM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 16, 2022 at 01:30:35PM -0800, Paul E. McKenney wrote:
> > > On Wed, Feb 16, 2022 at 04:42:05PM +0100, Frederic Weisbecker wrote:
> > > > In order to avoid scattering the global RCU states, move the RCU nocb
> > > > initialization witness within rcu_state.
> > > > 
> > > > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > > Build testing for CONFIG_NO_HZ_FULL=n kernels suggested the following
> > > patch be merged into this one.  Or does this variable need to be used
> > > somewhere?  Either way, please let me know!
> > 
> > TASKS03, TREE04, and TREE07 don't like this much, according to git
> > bisect.  They are the ones with nohz_full CPUs, in case that is crucial.
> > Trying again after reverting this commit locally.
> > 
> > If that works, I would be tempted to try the modification shown below.
> 
> And that does pass significant rcutorture testing, but over to you.  ;-)

Ah no we still need that variable, but I screwed up and wrongly converted
need_rcu_nocb_mask to rcu_state.nocb_is_setup somewhere.

Here is the v2 of the culprit patch (sorry):

---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Mon, 14 Feb 2022 14:23:39 +0100
Subject: [PATCH] rcu/nocb: Move rcu_nocb_is_setup to rcu_state

In order to avoid scattering the global RCU states, move the RCU nocb
initialization witness within rcu_state.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h | 13 +++++--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 19fc9acce3ce..735fc410d76a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -368,6 +368,7 @@ struct rcu_state {
 	arch_spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
+	int nocb_is_setup;			/* nocb is setup from boot */
 };
 
 /* Values for rcu_state structure's gp_flags field. */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 02e1d05a11fc..3c00240833d6 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -60,9 +60,6 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
  * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
  * If the list is invalid, a warning is emitted and all CPUs are offloaded.
  */
-
-static bool rcu_nocb_is_setup;
-
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
@@ -72,7 +69,7 @@ static int __init rcu_nocb_setup(char *str)
 			cpumask_setall(rcu_nocb_mask);
 		}
 	}
-	rcu_nocb_is_setup = true;
+	rcu_state.nocb_is_setup = true;
 	return 1;
 }
 __setup("rcu_nocbs", rcu_nocb_setup);
@@ -1172,10 +1169,10 @@ void __init rcu_init_nohz(void)
 				return;
 			}
 		}
-		rcu_nocb_is_setup = true;
+		rcu_state.nocb_is_setup = true;
 	}
 
-	if (!rcu_nocb_is_setup)
+	if (!rcu_state.nocb_is_setup)
 		return;
 
 #if defined(CONFIG_NO_HZ_FULL)
@@ -1233,7 +1230,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	struct task_struct *t;
 	struct sched_param sp;
 
-	if (!rcu_scheduler_fully_active || !rcu_nocb_is_setup)
+	if (!rcu_scheduler_fully_active || !rcu_state.nocb_is_setup)
 		return;
 
 	/* If there already is an rcuo kthread, then nothing to do. */
@@ -1279,7 +1276,7 @@ static void __init rcu_spawn_nocb_kthreads(void)
 {
 	int cpu;
 
-	if (rcu_nocb_is_setup) {
+	if (rcu_state.nocb_is_setup) {
 		for_each_online_cpu(cpu)
 			rcu_spawn_cpu_nocb_kthread(cpu);
 	}
-- 
2.25.1
