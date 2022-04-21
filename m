Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFB0509900
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385702AbiDUHYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiDUHYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:24:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A12318340;
        Thu, 21 Apr 2022 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/C9+3qUeBS+g+il8GEFlGStsowiK3WH4YnoDjaHKK9Y=; b=YLcyMQWUra46az+F4lcpWwI+sy
        eiorDaQRwdnLR8EGGH9CeRC0dm8tq7Bbb4LIOEAs6YnBFI1rm0GJm9B4czOUq0DRrfK3UrJhI1+80
        ADSBtoeflXov2wCyDW/EqrNL/5kHlFh5eMYwFMr4XwXzNAx9ZjTRVeYIMhRiBRVbYSftPCw1fBWNs
        u15E5Q3cz4Q8td4QA8yPJcW5ljsjTnLo2xEbbzECvpjRxyahORyGFGtBTxwVrufUXo3fOdNBKZ1+t
        gqtBv+1/ogeup/gu8AIi+W+fqrOgHH/SWyqQqR4IFQN1TId6shT1+baGm5RwvFprfNmv4i2VJYfmz
        yBdGRn4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhR8I-004rKD-04; Thu, 21 Apr 2022 07:21:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C08E9861A4; Thu, 21 Apr 2022 09:21:38 +0200 (CEST)
Date:   Thu, 21 Apr 2022 09:21:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC][PATCH] ptrace: Don't change __state
Message-ID: <20220421072138.GI2731@worktop.programming.kicks-ass.net>
References: <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
 <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
 <20220418170104.GA16199@redhat.com>
 <20220420131731.GF2731@worktop.programming.kicks-ass.net>
 <20220420180323.GA14947@redhat.com>
 <875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:54:15PM -0500, Eric W. Biederman wrote:
> 
> I was thinking about this and I have an approach from a different
> direction.  In particular it removes the need for ptrace_freeze_attach
> and ptrace_unfreeze_attach to change __state.  Instead a jobctl
> bit is used to suppress waking up a process with TASK_WAKEKILL.
> 
> I think this would be a good technique to completely decouple
> PREEMPT_RT from the work that ptrace_freeze_attach does.
> 
> Comments?

On first read-through, I like it! A few comments down below..

> @@ -216,13 +217,11 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>  	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
>  	 * Recheck state under the lock to close this race.
>  	 */
> -	spin_lock_irq(&task->sighand->siglock);
> -	if (READ_ONCE(task->__state) == __TASK_TRACED) {
> -		if (__fatal_signal_pending(task))
> -			wake_up_state(task, __TASK_TRACED);
> -		else
> -			WRITE_ONCE(task->__state, TASK_TRACED);
> -	}
> +	spin_unlock_irq(&task->sighand->siglock);

  ^^^^ this should be spin_lock_irq(...)

> +	WARN_ON(!(task->jobctl & JOBCTL_DELAY_WAKEKILL));
> +	task->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
> +	if (fatal_signal_pending(task))
> +		wake_up_state(task, TASK_WAKEKILL);
>  	spin_unlock_irq(&task->sighand->siglock);
>  }
>  
> @@ -256,7 +255,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  	 */
>  	read_lock(&tasklist_lock);
>  	if (child->ptrace && child->parent == current) {
> -		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
> +		WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
>  		/*
>  		 * child->sighand can't be NULL, release_task()
>  		 * does ptrace_unlink() before __exit_signal().
> @@ -267,13 +266,13 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  	read_unlock(&tasklist_lock);
>  
>  	if (!ret && !ignore_state) {
> -		if (!wait_task_inactive(child, __TASK_TRACED)) {
> +		if (!wait_task_inactive(child, TASK_TRACED)) {

This is still very dubious, there are spinlocks between
set_current_state(TASK_TRACED) and schedule(), so wait_task_inactive()
can fail where we don't want it to due to TASK_TRACED being temporarily
held in ->saved_state.

>  			/*
>  			 * This can only happen if may_ptrace_stop() fails and
>  			 * ptrace_stop() changes ->state back to TASK_RUNNING,
> -			 * so we should not worry about leaking __TASK_TRACED.
> +			 * so we should not worry about leaking JOBCTL_DELAY_WAKEKILL.
>  			 */
> +			WARN_ON(!(child->jobctl & JOBCTL_DELAY_WAKEKILL));
>  			ret = -ESRCH;
>  		}
>  	}
