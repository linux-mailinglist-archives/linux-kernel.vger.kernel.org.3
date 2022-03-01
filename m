Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310664C9249
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiCAR5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiCAR5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:57:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C95D1BA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:56:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C500861357
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29497C340EE;
        Tue,  1 Mar 2022 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646157382;
        bh=KNC5nSGmXjciHrAe+9Qx+SWGJhjMMOyFywU8E99Slbc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JsJfgWlvZ2WOaqmcvElq73WqElR/QNmiFXpoHXSlU/vLesEMovv4vBQzl8F7NIoig
         oEFaIbmmEKfdXi0ooyvC9f7dIlQHX8gZgWHGyh/wIElP9cVOAQZv1IL0wpBOcj5KdM
         hxwenR0yWyID3c/h40HisC7G9pKArDdmdHJ0dlJJEVxXqlbS4vK4TewAZ3MZLXSxCJ
         wL2kKlu/Sh0+NjACG2tf8cJEwcZEiHpZApRVTlhShFFh5okNyGY5WecpIahcHQKiYV
         91ZgQgLRtyHQUusxeKIlp1XOiVU++9i4XmYpLA8rZKu1LY8xXKVdptsGmXUhBU2ddm
         I4iU7sQZD5qIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AC9AB5C0440; Tue,  1 Mar 2022 09:56:21 -0800 (PST)
Date:   Tue, 1 Mar 2022 09:56:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     rostedt@goodmis.org, bristot@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Message-ID: <20220301175621.GP4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <20220228221154.GN4285@paulmck-ThinkPad-P17-Gen-1>
 <1b388cdc409fdfae75ef2280674d8211e5b6194e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b388cdc409fdfae75ef2280674d8211e5b6194e.camel@redhat.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 11:00:08AM +0100, Nicolas Saenz Julienne wrote:
> On Mon, 2022-02-28 at 14:11 -0800, Paul E. McKenney wrote:
> > On Mon, Feb 28, 2022 at 03:14:23PM +0100, Nicolas Saenz Julienne wrote:
> > > At the moment running osnoise on an isolated CPU and a PREEMPT_RCU
> > > kernel might have the side effect of extending grace periods too much.
> > > This will eventually entice RCU to schedule a task on the isolated CPU
> > > to end the overly extended grace period, adding unwarranted noise to the
> > > CPU being traced in the process.

Ah, I misread the above paragraph.  Apologies!

Nevertheless, could you please add something explicit to the effect that
RCU is completing grace periods as required?

> > > So, check if we're the only ones running on this isolated CPU and that
> > > we're on a PREEMPT_RCU setup. If so, let's force quiescent states in
> > > between measurements.

And yes, if you don't want RCU to try to forcibly extract a quiescent
state from you, you must supply a quiescent state to RCU.  ;-)

> > > Non-PREEMPT_RCU setups don't need to worry about this as osnoise main
> > > loop's cond_resched() will go though a quiescent state for them.
> > > 
> > > Note that this same exact problem is what extended quiescent states were
> > > created for. But adapting them to this specific use-case isn't trivial
> > > as it'll imply reworking entry/exit and dynticks/context tracking code.
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > > ---
> > >  kernel/trace/trace_osnoise.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> > > index 870a08da5b48..4928358f6e88 100644
> > > --- a/kernel/trace/trace_osnoise.c
> > > +++ b/kernel/trace/trace_osnoise.c
> > > @@ -21,7 +21,9 @@
> > >  #include <linux/uaccess.h>
> > >  #include <linux/cpumask.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/tick.h>
> > >  #include <linux/sched/clock.h>
> > > +#include <linux/sched/isolation.h>
> > >  #include <uapi/linux/sched/types.h>
> > >  #include <linux/sched.h>
> > >  #include "trace.h"
> > > @@ -1295,6 +1297,7 @@ static int run_osnoise(void)
> > >  	struct osnoise_sample s;
> > >  	unsigned int threshold;
> > >  	u64 runtime, stop_in;
> > > +	unsigned long flags;
> > >  	u64 sum_noise = 0;
> > >  	int hw_count = 0;
> > >  	int ret = -1;
> > > @@ -1386,6 +1389,22 @@ static int run_osnoise(void)
> > >  					osnoise_stop_tracing();
> > >  		}
> > >  
> > > +		/*
> > > +		 * Check if we're the only ones running on this nohz_full CPU
> > > +		 * and that we're on a PREEMPT_RCU setup. If so, let's fake a
> > > +		 * QS since there is no way for RCU to know we're not making
> > > +		 * use of it.
> > > +		 *
> > > +		 * Otherwise it'll be done through cond_resched().
> > > +		 */
> > > +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
> > > +		    !housekeeping_cpu(raw_smp_processor_id(), HK_FLAG_MISC) &&
> > > +		    tick_nohz_tick_stopped()) {
> > > +			local_irq_save(flags);
> > > +			rcu_momentary_dyntick_idle();

And yes, rcu_momentary_dyntick_idle() is a good way to supply a quiescent
state to RCU.  This won't help Tasks RCU or Tasks Rude RCU, but you can
avoid those by avoiding changing tracing state while running osnoise.

> > > +			local_irq_restore(flags);
> > 
> > What is supposed to happen in this case is that RCU figures out that
> > there is a nohz_full CPU running for an extended period of time in the
> > kernel and takes matters into its own hands.  This goes as follows on
> > a HZ=1000 kernel with default RCU settings:
> > 
> > o	At about 20 milliseconds into the grace period, RCU makes
> > 	cond_resched() report quiescent states, among other things.
> > 	As you say, this does not help for CONFIG_PREEMPT=n kernels.
> > 
> > o	At about 30 milliseconds into the grace period, RCU forces an
> > 	explicit context switch on the wayward CPU.  This should get
> > 	the CPU's attention even in CONFIG_PREEMPT=y kernels.
> > 
> > So what is happening for you instead?
> 
> Well, that's exactly what I'm seeing, but it doesn't play well with osnoise.

Whew!!!  ;-)

> Here's a simplified view of what the tracer does:
> 
> 	time1 = get_time();
> 	while(1) {
> 		time2 = get_time();
> 		if (time2 - time1 > threshold)
> 			trace_noise();
> 		cond_resched();
> 		time1 = time2;
> 	}
> 
> This is pinned to a specific CPU, and in the most extreme cases is expected to
> take 100% of CPU time. Eventually, some SMI, NMI/interrupt, or process
> execution will trigger the threshold, and osnoise will provide some nice traces
> explaining what happened.
> 
> RCU forcing a context switch on the wayward CPU is introducing unwarranted
> noise as it's triggered by the fact we're measuring and wouldn't happen
> otherwise.
> 
> If this were user-space, we'd be in an EQS, which would make this problem go
> away. An option would be mimicking this behaviour (assuming irq entry/exit code
> did the right thing):
> 
> 	rcu_eqs_enter(); <--
> 	time1 = get_time();
> 	while(1) {
> 		time2 = get_time();
> 		if (time2 - time1 > threshold)
> 			trace_noise();
> 		rcu_eqs_exit(); <--
> 		cond_resched();
> 		rcu_eqs_enter(); <--
> 		time1 = time2;
> 	}
> 
> But given the tight loop this isn't much different than what I'm proposing at
> the moment, isn't it? rcu_momentary_dyntick_idle() just emulates a really fast
> EQS entry/exit.

And that is in fact exactly what rcu_momentary_dyntick_idle() was
intended for:

Acked-by: Paul E. McKenney <paulmck@kernel.org>
