Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA94C9289
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiCASFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiCASFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:05:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5E34CD6F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:05:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AEFFB81B9D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C296C340EE;
        Tue,  1 Mar 2022 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646157910;
        bh=jA5B8md3s/3R+ogbYRVIPt5GdqcXM7G3nBlb4j1FWQc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sTo7+y9iYx6Ep33QNArh7hMV1/y/RKdNkUJdNh/zBXm/w1Axf0FLOT3DJ9snDH4mk
         8HQ7cTkeKgR/R9yH8er8qyRQ7YcJVNTZ9hzThxkD7QZeVMmcjWrZUqNOKEox4zqP0d
         opunB6K5xpNplMRlk5qWuD5gn/pUEdSvI/XSdz9oo+0br4I5tWsMAy8BKA/aah7eI6
         4tv8pLEfIVjCUazlwpjEE/6PjolkGqWsS66ve0FY18DNB2yuIoa9TBy+6s5pfC8ZmG
         QGJmyMDA87xlzzlPdmgJPk0n2IR7yebaNTQPYFt8V3H+kJ/WD020lnVjO0K7XMj0N2
         1GtgYUb6E3u3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C77315C0440; Tue,  1 Mar 2022 10:05:09 -0800 (PST)
Date:   Tue, 1 Mar 2022 10:05:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, mtosatti@redhat.com
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Message-ID: <20220301180509.GQ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <137d3573-051f-5374-70d6-cc99b44d00da@kernel.org>
 <b604526d3186f6cd3da189abb70bd1ad9a6105c5.camel@redhat.com>
 <69e92bc6-0917-17e9-1b61-d884d30ba42c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e92bc6-0917-17e9-1b61-d884d30ba42c@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 06:55:23PM +0100, Daniel Bristot de Oliveira wrote:
> On 3/1/22 11:52, Nicolas Saenz Julienne wrote:
> > On Mon, 2022-02-28 at 21:00 +0100, Daniel Bristot de Oliveira wrote:
> >> On 2/28/22 15:14, Nicolas Saenz Julienne wrote:
> >>> At the moment running osnoise on an isolated CPU and a PREEMPT_RCU
> >>> kernel might have the side effect of extending grace periods too much.
> >>> This will eventually entice RCU to schedule a task on the isolated CPU
> >>> to end the overly extended grace period, adding unwarranted noise to the
> >>> CPU being traced in the process.
> >>>
> >>> So, check if we're the only ones running on this isolated CPU and that
> >>> we're on a PREEMPT_RCU setup. If so, let's force quiescent states in
> >>> between measurements.
> >>>
> >>> Non-PREEMPT_RCU setups don't need to worry about this as osnoise main
> >>> loop's cond_resched() will go though a quiescent state for them.
> >>>
> >>> Note that this same exact problem is what extended quiescent states were
> >>> created for. But adapting them to this specific use-case isn't trivial
> >>> as it'll imply reworking entry/exit and dynticks/context tracking code.
> >>>
> >>> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> >>> ---
> >>>  kernel/trace/trace_osnoise.c | 19 +++++++++++++++++++
> >>>  1 file changed, 19 insertions(+)
> >>>
> >>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> >>> index 870a08da5b48..4928358f6e88 100644
> >>> --- a/kernel/trace/trace_osnoise.c
> >>> +++ b/kernel/trace/trace_osnoise.c
> >>> @@ -21,7 +21,9 @@
> >>>  #include <linux/uaccess.h>
> >>>  #include <linux/cpumask.h>
> >>>  #include <linux/delay.h>
> >>> +#include <linux/tick.h>
> >>>  #include <linux/sched/clock.h>
> >>> +#include <linux/sched/isolation.h>
> >>>  #include <uapi/linux/sched/types.h>
> >>>  #include <linux/sched.h>
> >>>  #include "trace.h"
> >>> @@ -1295,6 +1297,7 @@ static int run_osnoise(void)
> >>>  	struct osnoise_sample s;
> >>>  	unsigned int threshold;
> >>>  	u64 runtime, stop_in;
> >>> +	unsigned long flags;
> >>>  	u64 sum_noise = 0;
> >>>  	int hw_count = 0;
> >>>  	int ret = -1;
> >>> @@ -1386,6 +1389,22 @@ static int run_osnoise(void)
> >>>  					osnoise_stop_tracing();
> >>>  		}
> >>>  
> >>> +		/*
> >>> +		 * Check if we're the only ones running on this nohz_full CPU
> >>> +		 * and that we're on a PREEMPT_RCU setup. If so, let's fake a
> >>> +		 * QS since there is no way for RCU to know we're not making
> >>> +		 * use of it.
> >>> +		 *
> >>> +		 * Otherwise it'll be done through cond_resched().
> >>> +		 */
> >>> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
> >>> +		    !housekeeping_cpu(raw_smp_processor_id(), HK_FLAG_MISC) &&
> >>
> >> Does this restrict to only isolcpus cpus?
> > 
> > nohz_full CPUs actually, IIUC HK_FLAG_MISC isn't set if isolcpus is used, which
> > is deprecated anyway.
> 
> Perfecto!
> 
> > 
> >> what if this CPU was isolated via other methods?
> > 
> > osnoise with an uncontested FIFO priority for example?
> 
> No, I was mentioning something like tuna/tasket/systemd/cgroup, anything other
> than isolcpus... as it is doing (I miss interpreted the HK_FLAG_MISC).
> 
> I do not agree on using busy-loop with FIFO.
> 
> I believe in that case
> > RCU will start throwing "rcu_preempt detected stalls" style warnings. As it
> > won't be able to preempt the osnoise CPU to force the grace period ending.
> > 
> > I see your point though, this would also help in that situation. We could maybe
> > relax the entry barrier to rcu_momentary_dyntick_idle(). I think it's safe to
> > call it regardless of nohz_full/tick state for most cases, I just wanted to
> > avoid the overhead. The only thing that worries me is PREEMPT_RT and its
> > rt_spinlocks, which can be preempted.
> 
> no, that was not my point.
> 
> > 
> >>> +		    tick_nohz_tick_stopped()) {
> >>> +			local_irq_save(flags);
> >>
> >> This code is always with interrupts enabled, so local_irq_disable()/enable()
> >> should be enough (and faster).
> > 
> > Noted.
> > 
> >>> +			rcu_momentary_dyntick_idle();
> >>> +			local_irq_restore(flags);
> >>> +		}
> >>
> >> Question, if we set this once, we could avoid setting it on every loop unless we
> >> have a preemption from another thread, right?
> > 
> > This tells RCU the CPU went through a quiescent state, which removes it from
> > the current grace period accounting. It's different from an extended quiescent
> > state, which fully disables the CPU from RCU's perspective.
> 
> Got it!
> 
> > We don't need to do it on every iteration, but as Paul explained in the mail
> > thread it has to happen at least every ~20-30ms.
> 
> I see, as long as it costs < 1 us, I am ok. If it gets > 1us in a reasonably
> fast machine, we start see HW noise where it does not exist, and that would
> reduce the resolution of osnoise. AFAICS, it is not causing that problem, but we
> need to make it as lightweight as possible.

In the common case, it is atomically incrementing a local per-CPU counter
and doing a store.  This should be quite cheap.

The uncommon case is when the osnoise process was preempted or otherwise
interfered with during a recent RCU read-side critical section and
preemption was disabled around that critical section's outermost
rcu_read_unlock().  This can be quite expensive.  But I would expect
you to just not do this.  ;-)

							Thanx, Paul
