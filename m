Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173A54A69B6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbiBBBth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiBBBtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:49:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D7FC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 17:49:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6082E615C1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 01:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C01C340E9;
        Wed,  2 Feb 2022 01:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643766574;
        bh=RTmYpnGd33fQq66ts+42Bz9Fkwc85HNB8NZhHYmtebU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FFwWhSB3hGWmYtwSsXqIpiGSpQi4JQWMz31rrjaK9Ev7fVGplc9JEAnIjW8SrKzI3
         RFcIp02JlMkIhbx3s8Fx3R1IuXITpOT4m7003yY6DG4Ce4Pcn3GZbqeY4pM4/qdK7m
         q3KWLI65Ki4XOlzX/lq92aMul3d0LJQb/gxquifJL7G2O59fDcpH7z12Eu06WaHPNc
         RLO2eZX5Yj6wAAJjGeYX3nVnVQMpU7bEoklXsCnsBnhKGSs5h7QNOf+ihlAQAt6KDz
         l95ecpraFazijQvmJ27F0+gPllz/C4cMP4CRCvZ0L4DKEceY1M8d97venYx7ar9xDu
         hVyXyo84R+RAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 675E35C0138; Tue,  1 Feb 2022 17:49:34 -0800 (PST)
Date:   Tue, 1 Feb 2022 17:49:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tick: Detect and fix jiffies update stall
Message-ID: <20220202014934.GI4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220202000107.416695-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202000107.416695-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 01:01:07AM +0100, Frederic Weisbecker wrote:
> On some rare cases, the timekeeper CPU may be delaying its jiffies
> update duty for a while. Known causes include:
> 
> * The timekeeper is waiting on stop_machine in a MULTI_STOP_DISABLE_IRQ
>   or MULTI_STOP_RUN state. Disabled interrupts prevent from timekeeping
>   updates while waiting for the target CPU to complete its
>   stop_machine() callback.
> 
> * The timekeeper vcpu has VMEXIT'ed for a long while due to some overload
>   on the host.
> 
> Detect and fix these situations with emergency timekeeping catchups.
> 
> Original-patch-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Nice, thank you!

So I should revert your earlier patch, apply this one, and then test
the result?

							Thanx, Paul

> ---
>  kernel/time/tick-sched.c | 17 +++++++++++++++++
>  kernel/time/tick-sched.h |  4 ++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 17a283ce2b20..c89f50a7e690 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -169,6 +169,8 @@ static ktime_t tick_init_jiffy_update(void)
>  	return period;
>  }
>  
> +#define MAX_STALLED_JIFFIES 5
> +
>  static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
>  {
>  	int cpu = smp_processor_id();
> @@ -196,6 +198,21 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
>  	if (tick_do_timer_cpu == cpu)
>  		tick_do_update_jiffies64(now);
>  
> +	/*
> +	 * If jiffies update stalled for too long (timekeeper in stop_machine()
> +	 * or VMEXIT'ed for several msecs), force an update.
> +	 */
> +	if (ts->last_tick_jiffies != jiffies) {
> +		ts->stalled_jiffies = 0;
> +		ts->last_tick_jiffies = READ_ONCE(jiffies);
> +	} else {
> +		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
> +			tick_do_update_jiffies64(now);
> +			ts->stalled_jiffies = 0;
> +			ts->last_tick_jiffies = READ_ONCE(jiffies);
> +		}
> +	}
> +
>  	if (ts->inidle)
>  		ts->got_idle_tick = 1;
>  }
> diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
> index d952ae393423..504649513399 100644
> --- a/kernel/time/tick-sched.h
> +++ b/kernel/time/tick-sched.h
> @@ -49,6 +49,8 @@ enum tick_nohz_mode {
>   * @timer_expires_base:	Base time clock monotonic for @timer_expires
>   * @next_timer:		Expiry time of next expiring timer for debugging purpose only
>   * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
> + * @last_tick_jiffies:	Value of jiffies seen on last tick
> + * @stalled_jiffies:	Number of stalled jiffies detected across ticks
>   */
>  struct tick_sched {
>  	struct hrtimer			sched_timer;
> @@ -77,6 +79,8 @@ struct tick_sched {
>  	u64				next_timer;
>  	ktime_t				idle_expires;
>  	atomic_t			tick_dep_mask;
> +	unsigned long			last_tick_jiffies;
> +	unsigned int			stalled_jiffies;
>  };
>  
>  extern struct tick_sched *tick_get_tick_sched(int cpu);
> -- 
> 2.25.1
> 
