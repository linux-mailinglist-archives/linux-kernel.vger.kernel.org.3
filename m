Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC715AAE10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiIBME4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiIBMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:04:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AEE2AFA;
        Fri,  2 Sep 2022 05:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 217E7B82A6F;
        Fri,  2 Sep 2022 12:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CB9C433D7;
        Fri,  2 Sep 2022 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662120287;
        bh=RJzkQrYginDaiEze6Bo3xEmoYSFz6uJmuVZ7EbH+59I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t/sO9+33at7eXYHo30eKDNFt6A10JX8BQL80Zk0CtX8wMOH0ViaxuwYKqnhM0qm8U
         9zt8zfZRS3q6viKGVJxSHEPbcZVS2MmNDW0QMq7IVmE4HCf71/PmIB74aTCYWnZ9RM
         LnvqgsdjbhcalC6AdfspIkYOwRpO+Ty9jYcax3XcMqKvTvHdoa9Waxd+pYd1ugkjGR
         kfWp0AML1TK56ToL7yjKjsOP+droGeQhqh+e0gfSIHGMvBJiyVzGEEne/tmwmwq9iT
         S6sdW/MskApjS/00/KzPo1+RSxLBypDbz0iSrSLUpDBC3axaj54JvYINQOkutLcDUF
         wA2nMRjJPA6bw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4BF965C06A7; Fri,  2 Sep 2022 05:04:47 -0700 (PDT)
Date:   Fri, 2 Sep 2022 05:04:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Matthew Wilcox <willy@infradead.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH rcu 04/32] rcu-tasks: Drive synchronous grace periods
 from calling task
Message-ID: <20220902120447.GH6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
 <20220620225411.3842519-4-paulmck@kernel.org>
 <20220901103625.GA1658@pengutronix.de>
 <20220901172725.GC6159@paulmck-ThinkPad-P17-Gen-1>
 <20220901173304.GA2280413@paulmck-ThinkPad-P17-Gen-1>
 <20220902115228.GV24324@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902115228.GV24324@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 01:52:28PM +0200, Sascha Hauer wrote:
> On Thu, Sep 01, 2022 at 10:33:04AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 01, 2022 at 10:27:25AM -0700, Paul E. McKenney wrote:
> > > On Thu, Sep 01, 2022 at 12:36:25PM +0200, Sascha Hauer wrote:
> > > > Hi Paul,
> > > > 
> > > > On Mon, Jun 20, 2022 at 03:53:43PM -0700, Paul E. McKenney wrote:
> > > > > This commit causes synchronous grace periods to be driven from the task
> > > > > invoking synchronize_rcu_*(), allowing these functions to be invoked from
> > > > > the mid-boot dead zone extending from when the scheduler was initialized
> > > > > to to point that the various RCU tasks grace-period kthreads are spawned.
> > > > > This change will allow the self-tests to run in a consistent manner.
> > > > > 
> > > > > Reported-by: Matthew Wilcox <willy@infradead.org>
> > > > > Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > 
> > > > This commit (appeared in mainline as 4a8cc433b8bf) breaks booting my
> > > > ARMv7 based i.MX6ul board when CONFIG_PROVE_RCU is enabled. Reverting
> > > > this patch on v6.0-rc3 makes my board boot again. See below for a boot
> > > > log. The last message is "Running RCU-tasks wait API self tests", after
> > > > that the board hangs. Any idea what goes wrong here?
> > > 
> > > New one on me!
> > > 
> > > Is it possible to get a stack trace of the hang, perhaps via
> > > one form or another of sysrq-T?  Such a stack trace would likely
> > > include synchronize_rcu_tasks(), synchronize_rcu_tasks_rude(), or
> > > synchronize_rcu_tasks_trace() followed by synchronize_rcu_tasks_generic(),
> > > rcu_tasks_one_gp(), and one of rcu_tasks_wait_gp(),
> > > rcu_tasks_rude_wait_gp(), or rcu_tasks_wait_gp().
> > 
> > If there is no chance of sysrq-T, kernel debuggers, kernel crash
> > dumps, or any other source of the stack trace, please decorate the
> > code path with printk() or similar and let me know where it goes.
> > Under normal circumstances, this code path is not sensitive to performance
> > perturbations of the printk() persuasion.
> 
> Some unrelated bug I was searching for made me turn on early console
> output with the "earlycon" parameter. It turned out that when I remove
> this parameter then my board boots fine.
> 
> I then realized that even with earlycon enabled my board boots fine
> when I remove the call to
> 
> 	pr_info("Running RCU-tasks wait API self tests\n");

Ah, there are some printk() fixes in the works.  Maybe this is one area
needed that.  Or maybe not.

> Given that I am not sure how useful it is to add more printk. I did that
> anyway like this:
> 
> > static void rcu_tasks_one_gp(struct rcu_tasks *rtp, bool midboot)
> > {
> > 	int needgpcb;
> > 
> > 	printk("%s: mutex_lock... midboot: %d\n", __func__, midboot);
> > 	mutex_lock(&rtp->tasks_gp_mutex);
> > 	printk("%s: mutex_locked midboot: %d\n", __func__, midboot);
> > 
> > 	// If there were none, wait a bit and start over.
> > 	if (unlikely(midboot)) {
> > 		needgpcb = 0x2;
> > 	} else {
> > 		printk("%s: set_tasks_gp_state(RTGS_WAIT_CBS)...\n", __func__);
> > 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
> > 		printk("%s: rcuwait_wait_event...\n", __func__);
> > 		rcuwait_wait_event(&rtp->cbs_wait,
> > 				   (needgpcb = rcu_tasks_need_gpcb(rtp)),
> > 				   TASK_IDLE);
> >		printk("%s: rcuwait_wait_event done\n", __func__);
> > 	}
> >
> 
> What I see then is:
> 
> [    0.156362] synchronize_rcu_tasks_generic: rcu_tasks_one_gp....
> [    0.162087] rcu_tasks_one_gp: mutex_lock... midboot: 1

So one task gets stuck either in mutex_lock() or the printk() above
and some other task below moves ahead?  Or might some printk()s have
been lost?

> [    0.167386] rcu_tasks_one_gp: mutex_lock... midboot: 0
> [    0.172489] rcu_tasks_one_gp: mutex_locked midboot: 0
> [    0.177535] rcu_tasks_one_gp: set_tasks_gp_state(RTGS_WAIT_CBS)...
> [    0.183525] rcu_tasks_one_gp: rcuwait_wait_event...

Given that everything works with printk()s turned off, my current
suspicion is a printk() issue.

> Here the board hangs. After some time I get:
> 
> [  254.493010] random: crng init done

This looks unrelated.

> But that's it.
> 
> > 
> > > At this point in the boot sequence, there is only one online CPU,
> > > correct?
> 
> Yes, it's a single core system.

OK, then we should be able to rule out SMP issues.  ;-)

								Thanx, Paul

> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
