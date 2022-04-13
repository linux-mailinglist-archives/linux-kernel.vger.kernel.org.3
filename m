Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27D4FFFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiDMT66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiDMT65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:58:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0DA60AB2;
        Wed, 13 Apr 2022 12:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O6WqLRXrVlqDetuLF1Pm12GQvG6RBtczG4mwC7noCkE=; b=EdKKqzak+ppSChEiXSXMyoYkVm
        U5e5DX0pbpkuey1aDyBbO9x5HZh+d/SfiLmDDIDaTig/+yyJuUtb5Ntz3CvRWGjbTns14m6KiihP+
        BxXVOiNB/hCoOYtQ+chcWYie+pSqTBu8x6aSG7QwzKtgtYb85dHHGDklTWVNfMUKxDshxH5B6cdKX
        cZDEkgzMNbh7GkT26Xnwm/r3EefkmDspr4I0RyyKFdgGeLGZLvuzpuP2Tfx2FjFllc20QWuUj0xKt
        9HTpHHVaQo/VUeLNDbyjqT1Gbfw7CwG3k1csj6KBD6zznAwY5EW+Ghznwhoz5uaT6d370fDqQIcsU
        OjLV5gbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nej66-00EWwR-MH; Wed, 13 Apr 2022 19:56:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E76F798623C; Wed, 13 Apr 2022 21:56:12 +0200 (CEST)
Date:   Wed, 13 Apr 2022 21:56:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220413195612.GC2762@worktop.programming.kicks-ass.net>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413192053.GY2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:20:53PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 13, 2022 at 08:59:10PM +0200, Oleg Nesterov wrote:
> 
> 
> > +		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> > +		// wrong, needs siglock
> > +		current->jobctl &= ~JOBCTL_TRACED_XXX;
> > +		wake_up_bit(&current->jobctl, ~JOBCTL_TRACED_XXX_BIT);
> 		  __wake_up_common_lock()
> 		    spin_lock_irqsave()
> 		      current_save_and_set_rtlock_wait_state();
> 
> 			> +	if (wait_on_bit(&task->jobctl, JOBCTL_TRACED_XXX_BIT, TASK_KILLABLE))
> 			> +		return -EINTR;
> 			> +	// now that the tracee cleared JOBCTL_TRACED_XXX_BIT
> 			> +	// wait_task_inactive() should succeed or fail "really soon".
> 			> +	if (!wait_task_inactive(child, __TASK_TRACED))
> 			> +		return ret;
> 
> 
> 	*whoopsie* ?
> 
> >  		preempt_enable_no_resched();
> >  		freezable_schedule();
> >  		cgroup_leave_frozen(true);

Something that might work; since there's only the one ptracer, is to
instead do something like:

	current->jobctl &= ~JOBCTL_TRACED_XXX; // siglock
	if (current->ptrace)
		wake_up_process(current->parent);
	preempt_enable_no_resched();
	schedule();


vs

	for (;;) {
		set_current_state(TASK_UNINTERRUPTIBLE);
		if (!(p->jobctl & JOBCTL_TRACED_XXX))
			break;
		schedule();
	}
	__set_current_state(TASK_RUNNING);

	if (!wait_task_inactive(...))


ptrace_detach() needs some additional magic as well I think, but this
might just work.
