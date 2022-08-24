Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E85A029F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbiHXUVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239953AbiHXUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:21:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F053058509
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B98D61871
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 20:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885FEC433D6;
        Wed, 24 Aug 2022 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661372460;
        bh=NOf72QKODirrDmUvYantOE0140y5ossinOzMvF5uJG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1T6N4sJrTq3MjfG5g87VXI8g4c7/Dn4tjSZz4tvIQQPmNViUj6xvz39G4+GdAJmre
         NOrv/DLGZQCrHi/J5z//XxHBGJ7E2vVzcM+2YzUvMjdl3Lm5nVYqWpxXs279yyaL05
         J5vCnaa7AJrCPG+xjqoJqua+Nfnst2txhZ6YQI+o=
Date:   Wed, 24 Aug 2022 13:20:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@redhat.com, frederic@kernel.org, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-Id: <20220824132058.d88d3230a3cc9c07f38c9237@linux-foundation.org>
In-Reply-To: <20220817191524.201253713@redhat.com>
References: <20220817191346.287594886@redhat.com>
        <20220817191524.201253713@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 16:13:48 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:

> From: Aaron Tomlin <atomlin@redhat.com>
> 
> In the context of the idle task and an adaptive-tick mode/or a nohz_full
> CPU, quiet_vmstat() can be called: before stopping the idle tick,
> entering an idle state and on exit. In particular, for the latter case,
> when the idle task is required to reschedule, the idle tick can remain
> stopped and the timer expiration time endless i.e., KTIME_MAX. Now,
> indeed before a nohz_full CPU enters an idle state, CPU-specific vmstat
> counters should be processed to ensure the respective values have been
> reset and folded into the zone specific 'vm_stat[]'. That being said, it
> can only occur when: the idle tick was previously stopped, and
> reprogramming of the timer is not required.

I'd like to see input from tick/sched maintainers before toughing this
one, please.

> --- linux-2.6.orig/kernel/time/tick-sched.c
> +++ linux-2.6/kernel/time/tick-sched.c
> @@ -26,6 +26,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/context_tracking.h>
>  #include <linux/mm.h>
> +#include <linux/rcupdate.h>
>  
>  #include <asm/irq_regs.h>
>  
> @@ -519,6 +520,20 @@ void __tick_nohz_task_switch(void)
>  	}
>  }
>  
> +void __tick_nohz_user_enter_prepare(void)
> +{
> +	struct tick_sched *ts;
> +
> +	if (tick_nohz_full_cpu(smp_processor_id())) {
> +		ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +		if (ts->tick_stopped)
> +			quiet_vmstat();
> +		rcu_nocb_flush_deferred_wakeup();
> +	}
> +}
> +EXPORT_SYMBOL_GPL(__tick_nohz_user_enter_prepare);
> +
>  /* Get the boot-time nohz CPU list from the kernel parameters. */
>  void __init tick_nohz_full_setup(cpumask_var_t cpumask)
>  {
> @@ -890,6 +905,9 @@ static void tick_nohz_stop_tick(struct t
>  		ts->do_timer_last = 0;
>  	}
>  
> +	/* Attempt to fold when the idle tick is stopped or not */
> +	quiet_vmstat();
> +
>  	/* Skip reprogram of event if its not changed */
>  	if (ts->tick_stopped && (expires == ts->next_tick)) {
>  		/* Sanity check: make sure clockevent is actually programmed */
> @@ -911,7 +929,6 @@ static void tick_nohz_stop_tick(struct t
>  	 */
>  	if (!ts->tick_stopped) {
>  		calc_load_nohz_start();
> -		quiet_vmstat();
>  
>  		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
>  		ts->tick_stopped = 1;

Putting vmstat stuff inside core timer code is unattractive, to say the
least!

