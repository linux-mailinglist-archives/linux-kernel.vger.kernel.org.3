Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEADC4C7D14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiB1WMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiB1WMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:12:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232BC7904
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:11:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EAE5B81681
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC05FC340EE;
        Mon, 28 Feb 2022 22:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646086314;
        bh=8N9m4m7fgIVhig+Sl3sSZ8XvIZEeaE/jG6b8CDpmhHg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=N/B2p266PFmLAbWF3PsItviDxDTwqoAJVFwY6BX2OsPBcZBUd6hfazE8Sc9JpjazM
         5M/Q+2LbymNXcYW5vZVl3vDY0wkY1pz9JQ58WbZuy+cFQo6dhkL6ulhpN+fAYw+wnf
         4cgkdohDuNKvmBwufpcgdBEmi1gERm93NeK2FZww0gHKNNwIdnO4G5N/O7LVsOflj2
         JceIJ+1HC+YWAWaXHXp3hZY3EJ+zJbRzO8BHzkMDcPJP0nAF0zbQFO5t9qbrpm4AfB
         1IUZlraBTZqL5eiFMjv9NVuzSg4oyYnypOE5Epnjf9vVR2YcQgVIwGFQQNdeT6iHM+
         ukkezLk9FpMAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8A2F45C0379; Mon, 28 Feb 2022 14:11:54 -0800 (PST)
Date:   Mon, 28 Feb 2022 14:11:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     rostedt@goodmis.org, bristot@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Message-ID: <20220228221154.GN4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220228141423.259691-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228141423.259691-1-nsaenzju@redhat.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 03:14:23PM +0100, Nicolas Saenz Julienne wrote:
> At the moment running osnoise on an isolated CPU and a PREEMPT_RCU
> kernel might have the side effect of extending grace periods too much.
> This will eventually entice RCU to schedule a task on the isolated CPU
> to end the overly extended grace period, adding unwarranted noise to the
> CPU being traced in the process.
> 
> So, check if we're the only ones running on this isolated CPU and that
> we're on a PREEMPT_RCU setup. If so, let's force quiescent states in
> between measurements.
> 
> Non-PREEMPT_RCU setups don't need to worry about this as osnoise main
> loop's cond_resched() will go though a quiescent state for them.
> 
> Note that this same exact problem is what extended quiescent states were
> created for. But adapting them to this specific use-case isn't trivial
> as it'll imply reworking entry/exit and dynticks/context tracking code.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  kernel/trace/trace_osnoise.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 870a08da5b48..4928358f6e88 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -21,7 +21,9 @@
>  #include <linux/uaccess.h>
>  #include <linux/cpumask.h>
>  #include <linux/delay.h>
> +#include <linux/tick.h>
>  #include <linux/sched/clock.h>
> +#include <linux/sched/isolation.h>
>  #include <uapi/linux/sched/types.h>
>  #include <linux/sched.h>
>  #include "trace.h"
> @@ -1295,6 +1297,7 @@ static int run_osnoise(void)
>  	struct osnoise_sample s;
>  	unsigned int threshold;
>  	u64 runtime, stop_in;
> +	unsigned long flags;
>  	u64 sum_noise = 0;
>  	int hw_count = 0;
>  	int ret = -1;
> @@ -1386,6 +1389,22 @@ static int run_osnoise(void)
>  					osnoise_stop_tracing();
>  		}
>  
> +		/*
> +		 * Check if we're the only ones running on this nohz_full CPU
> +		 * and that we're on a PREEMPT_RCU setup. If so, let's fake a
> +		 * QS since there is no way for RCU to know we're not making
> +		 * use of it.
> +		 *
> +		 * Otherwise it'll be done through cond_resched().
> +		 */
> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
> +		    !housekeeping_cpu(raw_smp_processor_id(), HK_FLAG_MISC) &&
> +		    tick_nohz_tick_stopped()) {
> +			local_irq_save(flags);
> +			rcu_momentary_dyntick_idle();
> +			local_irq_restore(flags);

What is supposed to happen in this case is that RCU figures out that
there is a nohz_full CPU running for an extended period of time in the
kernel and takes matters into its own hands.  This goes as follows on
a HZ=1000 kernel with default RCU settings:

o	At about 20 milliseconds into the grace period, RCU makes
	cond_resched() report quiescent states, among other things.
	As you say, this does not help for CONFIG_PREEMPT=n kernels.

o	At about 30 milliseconds into the grace period, RCU forces an
	explicit context switch on the wayward CPU.  This should get
	the CPU's attention even in CONFIG_PREEMPT=y kernels.

So what is happening for you instead?

							Thanx, Paul

> +		}
> +
>  		/*
>  		 * For the non-preemptive kernel config: let threads runs, if
>  		 * they so wish.
> -- 
> 2.35.1
> 
