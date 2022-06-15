Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E131854CF64
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349794AbiFORIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349665AbiFORIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:08:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D272EA26;
        Wed, 15 Jun 2022 10:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5832AB82073;
        Wed, 15 Jun 2022 17:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62BEC34115;
        Wed, 15 Jun 2022 17:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655312906;
        bh=uUevDAtdKVczJsOCWqw/HIaMs4Q2rIDGzDqW3Q6V1rk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eR4VgOJ+q22D1BGwseG7EhJ8FlaOYN0Qw+SUlzGGCtqeSv17uh0u+2UEOILqGa0Fi
         VzPpLOlCiWhRzCw68Hz/loRNGFg9+MjdHfmuyoYK46aLisWLC9OM5Va6uAWqFk4grJ
         J4PVmCVBE8Xs2KXO9srtSeO3/ZkIbb/zDklzc2HEy9Or1YLhWzh13qqRArHzrMRLN0
         Cf4DgtQKs4SxgFpBjnUUUTxWIAFaudY14dG78vnY0AFx03PiraO1YaWgrz4bK1uTe8
         U75eshA7AFnESjsoe4/+H7DINJGMe7m/nhpxXPvejyVR5KKdLOlBKywfetqmxawn4o
         2+LCbEhKP5gdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 842CB5C05B9; Wed, 15 Jun 2022 10:08:25 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:08:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, willy@infradead.org,
        urezki@gmail.com, rcu@vger.kernel.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rcu/dev] RFC: temporarily reduce rcu tasks kthread sleep
 time for PROVE_RCU
Message-ID: <20220615170825.GS1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220527003909.18998-1-zhouzhouyi@gmail.com>
 <20220607234209.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YqmdhhnPFcoHKC81@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqmdhhnPFcoHKC81@FVFF77S0Q05N>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 09:51:18AM +0100, Mark Rutland wrote:
> Hi Paul,
> 
> On Tue, Jun 07, 2022 at 04:42:09PM -0700, Paul E. McKenney wrote:
> > On Fri, May 27, 2022 at 08:39:09AM +0800, Zhouyi Zhou wrote:
> > > Sometimes, the kernel will boot too fast for rcu_tasks_verify_self_tests
> > > to have all required grace periods.
> 
> As mentioned on IRC, with v5.19-rc2 I consistently see this on arm64 at boot
> time, e.g.
> 
> | call_rcu_tasks() has been failed.
> | ------------[ cut here ]------------
> | WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1751 rcu_tasks_verify_self_tests+0x48/0x74
> | Modules linked in:
> | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc2 #2
> | Hardware name: linux,dummy-virt (DT)
> | pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> | pc : rcu_tasks_verify_self_tests+0x48/0x74
> | lr : rcu_tasks_verify_self_tests+0x6c/0x74
> | sp : ffff80000800bd70
> | x29: ffff80000800bd70 x28: 0000000000000000 x27: ffffbd05c97904c8
> | x26: ffffbd05c98610a0 x25: 0000000000000007 x24: 0000000000000000
> | x23: ffffbd05c9fa0b38 x22: ffffbd05ca42f000 x21: ffffbd05c9514ac0
> | x20: ffffbd05ca038808 x19: ffffbd05ca038808 x18: 0000000000000030
> | x17: 00000000808cf272 x16: 00000000b4c3fe3b x15: fffffffffffe4328
> | x14: 0000000000000001 x13: 2e64656c69616620 x12: 6e65656220736168
> | x11: 202928736b736174 x10: 5f7563725f6c6c61 x9 : 64656c696166206e
> | x8 : 6565622073616820 x7 : 2928736b7361745f x6 : 7563725f6c6c6163
> | x5 : ffff3f48ffbc0c80 x4 : 0000000000000000 x3 : 0000000000000000
> | x2 : 0000000000000000 x1 : 0000000000000001 x0 : 00000000ffffffff
> | Call trace:
> |  rcu_tasks_verify_self_tests+0x48/0x74
> |  do_one_initcall+0x74/0x400
> |  kernel_init_freeable+0x2fc/0x384
> |  kernel_init+0x28/0x130
> |  ret_from_fork+0x10/0x20
> | irq event stamp: 188396
> | hardirqs last  enabled at (188395): [<ffffbd05c7d2b4f4>] vprintk_store+0x3e4/0x4b0
> | hardirqs last disabled at (188396): [<ffffbd05c8d9a494>] el1_dbg+0x24/0x90
> | softirqs last  enabled at (188302): [<ffffbd05c8b95910>] release_sock+0xac/0xd0
> | softirqs last disabled at (188300): [<ffffbd05c8b9588c>] release_sock+0x28/0xd0
> | ---[ end trace 0000000000000000 ]---
> | registered taskstats version 1
> 
> I gave the below diff a go with:
> 
> * 100 UP boots
> * 100 64-CPU SMP boots
> 
> ... in a KVM VM on a ThunderX2 host, and out of those 200 boots I never saw the
> warning.
> 
> So FWIW:
> 
>   Tested-by: Mark Rutland <mark.rutland@arm.com>

Thank you, and I will apply this on the next rebase.

> Thanks for this!

Glad it helped.  ;-)

> Just as an aside, I had to grab this thread from lore as I'm not subscribed to
> the RCU list, so there might be others who haven't seen this thread.

Good point!  I just now added linux-kernel on CC, which should allow
people to follow the lore bread crumbs.

							Thanx, Paul

> Mark.
> 
> > commit 3e95d4b287b37ee5f7f82e5ebd749ab89fd706c2
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Jun 7 15:23:52 2022 -0700
> > 
> >     rcu-tasks: Be more patient for RCU Tasks boot-time testing
> >     
> >     The RCU-Tasks family of grace-period primitives can take some time to
> >     complete, and the amount of time can depend on the exact hardware and
> >     software configuration.  Some configurations boot up fast enough that the
> >     RCU-Tasks verification process gets false-positive failures.  This commit
> >     therefore allows up to 30 seconds for the grace periods to complete, with
> >     this value adjustable downwards using the rcupdate.rcu_task_stall_timeout
> >     kernel boot parameter.
> >     
> >     Reported-by: Matthew Wilcox <willy@infradead.org>
> >     Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index f1209ce621c51..1a4c3adc5c397 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -145,6 +145,7 @@ static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
> >  module_param(rcu_task_ipi_delay, int, 0644);
> >  
> >  /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
> > +#define RCU_TASK_BOOT_STALL_TIMEOUT (HZ * 30)
> >  #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
> >  static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
> >  module_param(rcu_task_stall_timeout, int, 0644);
> > @@ -1778,23 +1779,24 @@ struct rcu_tasks_test_desc {
> >  	struct rcu_head rh;
> >  	const char *name;
> >  	bool notrun;
> > +	unsigned long runstart;
> >  };
> >  
> >  static struct rcu_tasks_test_desc tests[] = {
> >  	{
> >  		.name = "call_rcu_tasks()",
> >  		/* If not defined, the test is skipped. */
> > -		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
> > +		.notrun = IS_ENABLED(CONFIG_TASKS_RCU),
> >  	},
> >  	{
> >  		.name = "call_rcu_tasks_rude()",
> >  		/* If not defined, the test is skipped. */
> > -		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
> > +		.notrun = IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
> >  	},
> >  	{
> >  		.name = "call_rcu_tasks_trace()",
> >  		/* If not defined, the test is skipped. */
> > -		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
> > +		.notrun = IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
> >  	}
> >  };
> >  
> > @@ -1805,23 +1807,28 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
> >  
> >  	pr_info("Callback from %s invoked.\n", rttd->name);
> >  
> > -	rttd->notrun = true;
> > +	rttd->notrun = false;
> >  }
> >  
> >  static void rcu_tasks_initiate_self_tests(void)
> >  {
> > +	unsigned long j = jiffies;
> > +
> >  	pr_info("Running RCU-tasks wait API self tests\n");
> >  #ifdef CONFIG_TASKS_RCU
> > +	tests[0].runstart = j;
> >  	synchronize_rcu_tasks();
> >  	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
> >  #endif
> >  
> >  #ifdef CONFIG_TASKS_RUDE_RCU
> > +	tests[1].runstart = j;
> >  	synchronize_rcu_tasks_rude();
> >  	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
> >  #endif
> >  
> >  #ifdef CONFIG_TASKS_TRACE_RCU
> > +	tests[2].runstart = j;
> >  	synchronize_rcu_tasks_trace();
> >  	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
> >  #endif
> > @@ -1831,11 +1838,18 @@ static int rcu_tasks_verify_self_tests(void)
> >  {
> >  	int ret = 0;
> >  	int i;
> > +	unsigned long bst = rcu_task_stall_timeout;
> >  
> > +	if (bst <= 0 || bst > RCU_TASK_BOOT_STALL_TIMEOUT)
> > +		bst = RCU_TASK_BOOT_STALL_TIMEOUT;
> >  	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> > -		if (!tests[i].notrun) {		// still hanging.
> > -			pr_err("%s has been failed.\n", tests[i].name);
> > -			ret = -1;
> > +		while (tests[i].notrun) {		// still hanging.
> > +			if (time_after(jiffies, tests[i].runstart + bst)) {
> > +				pr_err("%s has failed boot-time tests.\n", tests[i].name);
> > +				ret = -1;
> > +				break;
> > +			}
> > +			schedule_timeout_uninterruptible(1);
> >  		}
> >  	}
> >  
> > 
