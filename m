Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0495B5AADE6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiIBLwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIBLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:52:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E37B81CE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 04:52:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oU5Dr-0004Hs-Bp; Fri, 02 Sep 2022 13:52:31 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oU5Do-0002nP-O3; Fri, 02 Sep 2022 13:52:28 +0200
Date:   Fri, 2 Sep 2022 13:52:28 +0200
From:   Sascha Hauer <sha@pengutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Matthew Wilcox <willy@infradead.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH rcu 04/32] rcu-tasks: Drive synchronous grace periods
 from calling task
Message-ID: <20220902115228.GV24324@pengutronix.de>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
 <20220620225411.3842519-4-paulmck@kernel.org>
 <20220901103625.GA1658@pengutronix.de>
 <20220901172725.GC6159@paulmck-ThinkPad-P17-Gen-1>
 <20220901173304.GA2280413@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901173304.GA2280413@paulmck-ThinkPad-P17-Gen-1>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:33:04AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 01, 2022 at 10:27:25AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 01, 2022 at 12:36:25PM +0200, Sascha Hauer wrote:
> > > Hi Paul,
> > > 
> > > On Mon, Jun 20, 2022 at 03:53:43PM -0700, Paul E. McKenney wrote:
> > > > This commit causes synchronous grace periods to be driven from the task
> > > > invoking synchronize_rcu_*(), allowing these functions to be invoked from
> > > > the mid-boot dead zone extending from when the scheduler was initialized
> > > > to to point that the various RCU tasks grace-period kthreads are spawned.
> > > > This change will allow the self-tests to run in a consistent manner.
> > > > 
> > > > Reported-by: Matthew Wilcox <willy@infradead.org>
> > > > Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > This commit (appeared in mainline as 4a8cc433b8bf) breaks booting my
> > > ARMv7 based i.MX6ul board when CONFIG_PROVE_RCU is enabled. Reverting
> > > this patch on v6.0-rc3 makes my board boot again. See below for a boot
> > > log. The last message is "Running RCU-tasks wait API self tests", after
> > > that the board hangs. Any idea what goes wrong here?
> > 
> > New one on me!
> > 
> > Is it possible to get a stack trace of the hang, perhaps via
> > one form or another of sysrq-T?  Such a stack trace would likely
> > include synchronize_rcu_tasks(), synchronize_rcu_tasks_rude(), or
> > synchronize_rcu_tasks_trace() followed by synchronize_rcu_tasks_generic(),
> > rcu_tasks_one_gp(), and one of rcu_tasks_wait_gp(),
> > rcu_tasks_rude_wait_gp(), or rcu_tasks_wait_gp().
> 
> If there is no chance of sysrq-T, kernel debuggers, kernel crash
> dumps, or any other source of the stack trace, please decorate the
> code path with printk() or similar and let me know where it goes.
> Under normal circumstances, this code path is not sensitive to performance
> perturbations of the printk() persuasion.

Some unrelated bug I was searching for made me turn on early console
output with the "earlycon" parameter. It turned out that when I remove
this parameter then my board boots fine.

I then realized that even with earlycon enabled my board boots fine
when I remove the call to

	pr_info("Running RCU-tasks wait API self tests\n");

Given that I am not sure how useful it is to add more printk. I did that
anyway like this:

> static void rcu_tasks_one_gp(struct rcu_tasks *rtp, bool midboot)
> {
> 	int needgpcb;
> 
> 	printk("%s: mutex_lock... midboot: %d\n", __func__, midboot);
> 	mutex_lock(&rtp->tasks_gp_mutex);
> 	printk("%s: mutex_locked midboot: %d\n", __func__, midboot);
> 
> 	// If there were none, wait a bit and start over.
> 	if (unlikely(midboot)) {
> 		needgpcb = 0x2;
> 	} else {
> 		printk("%s: set_tasks_gp_state(RTGS_WAIT_CBS)...\n", __func__);
> 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
> 		printk("%s: rcuwait_wait_event...\n", __func__);
> 		rcuwait_wait_event(&rtp->cbs_wait,
> 				   (needgpcb = rcu_tasks_need_gpcb(rtp)),
> 				   TASK_IDLE);
>		printk("%s: rcuwait_wait_event done\n", __func__);
> 	}
>

What I see then is:

[    0.156362] synchronize_rcu_tasks_generic: rcu_tasks_one_gp....
[    0.162087] rcu_tasks_one_gp: mutex_lock... midboot: 1
[    0.167386] rcu_tasks_one_gp: mutex_lock... midboot: 0
[    0.172489] rcu_tasks_one_gp: mutex_locked midboot: 0
[    0.177535] rcu_tasks_one_gp: set_tasks_gp_state(RTGS_WAIT_CBS)...
[    0.183525] rcu_tasks_one_gp: rcuwait_wait_event...

Here the board hangs. After some time I get:

[  254.493010] random: crng init done

But that's it.

> 
> > At this point in the boot sequence, there is only one online CPU,
> > correct?

Yes, it's a single core system.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
