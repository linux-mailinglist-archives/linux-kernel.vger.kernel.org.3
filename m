Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F052588E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiHCOG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiHCOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:06:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8718354
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B48A9B8215F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7198CC433D6;
        Wed,  3 Aug 2022 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659535614;
        bh=FUpLy7yT54M55nQG6sKMEQx1kqgZE0vNDwbbsbuVheM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CIrIsvdD+5YDtz7+R1rB3CVh91thuzNPrb+Fvj4lEHdWIS4JlVl60i/Ba6EkqngjM
         iFv3+1OnI4HDM15ylPQJZ4LEXGoBnB9ltL6bwBVS4BMTioiFmTqrrogH1uC9rtdFmr
         Lrnv/WEGePTgYXz1llolNl7Ut8uW0f20CUUNCA1UFW3HvpZ0GKvbHjdquHayY0lGF6
         ChK8R62ISf6FgZUl/C9OrL8tDiNwFTs23k52C32sjfwzTD0vzatYZtI5M+L5mDw5ir
         n+Ny/cjE1CpvjTuqeQ9KR3c2D8et3gjXE8N/ZZOS4bFoh+Ev7EUjnO2BuVzP/iH8DJ
         naaEKAhQhDtEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 058B05C092A; Wed,  3 Aug 2022 07:06:53 -0700 (PDT)
Date:   Wed, 3 Aug 2022 07:06:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Liu Song <liusong@linux.alibaba.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/debug: avoid executing show_state and causing rcu
 stall warning
Message-ID: <20220803140653.GD2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
 <20220803084235.5d56d1e4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803084235.5d56d1e4@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 08:42:35AM -0400, Steven Rostedt wrote:
> 
> [ Adding Paul ]
> 
> On Wed,  3 Aug 2022 09:18:45 +0800
> Liu Song <liusong@linux.alibaba.com> wrote:
> 
> > From: Liu Song <liusong@linux.alibaba.com>
> > 
> > If the number of CPUs is large, "sysrq_sched_debug_show" will execute for
> > a long time. Every time I execute "echo t > /proc/sysrq-trigger" on my
> > 128-core machine, the rcu stall warning will be triggered. Moreover,
> > sysrq_sched_debug_show does not need to be protected by rcu_read_lock,
> > and no rcu stall warning will appear after adjustment.
> > 
> > Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> > ---
> >  kernel/sched/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 5555e49..82c117e 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8879,11 +8879,11 @@ void show_state_filter(unsigned int state_filter)
> >  			sched_show_task(p);
> >  	}
> >  
> > +	rcu_read_unlock();
> >  #ifdef CONFIG_SCHED_DEBUG
> >  	if (!state_filter)
> >  		sysrq_sched_debug_show();
> 
> If this is just because sysrq_sched_debug_show() is very slow, does RCU
> have a way to "touch" it? Like the watchdogs have? That is, to tell RCU
> "Yes I know I'm taking a long time, but I'm still making forward progress,
> don't complain about me". Then the sysrq_sched_debug_show() could have:
> 
> 	for_each_online_cpu(cpu) {
> 		/*
> 		 * Need to reset softlockup watchdogs on all CPUs, because
> 		 * another CPU might be blocked waiting for us to process
> 		 * an IPI or stop_machine.
> 		 */
> 		touch_nmi_watchdog();
> 		touch_all_softlockup_watchdogs();
> +		touch_rcu();
> 		print_cpu(NULL, cpu);
> 	}
> 
> ??

There is an rcu_sysrq_start() and rcu_sysrq_end() to suppress this.  These
are invoked by __handle_sysrq().  The value of rcu_cpu_stall_suppress
should be non-zero during the sysrq execution, and this should prevent
RCU CPU stall warnings from being printed.

That said, the code currently does not support overlapping calls to the
various functions that suppress RCU CPU stall warnings.  Except that
the only other use in current mainline is rcu_panic(), which never
unsuppresses.

So could you please check the value of rcu_cpu_stall_suppress?
Just in case some other form of suppression was added somewhere
that I missed?

							Thanx, Paul

> -- Steve
> 
> >  #endif
> > -	rcu_read_unlock();
> >  	/*
> >  	 * Only show locks if all tasks are dumped:
> >  	 */
> 
