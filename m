Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DDA5130DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiD1KLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiD1KK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:10:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3114866F99;
        Thu, 28 Apr 2022 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+SJZNg+Xk4heuq73+EyP7PoiE7b/TUnLnQh49H6zDVM=; b=DLyCj+JcSSd05ekrLUtSXIcbsy
        MWFhBPSFxHXc1CB4vrrLg8nk3448Qjti8NSQ/SuTisI3eaS8igzXpOH47fGCu03qwlsTouLJzKCR+
        5ZqCBbiWZUBs5mZNwgvgJCiM8AjMTGkoaNurvNAhxc0QjKfnaSqlfttjCGKMth4oJuG4gPDbgh1yO
        swYb7qZ85rPJJxdzUt0IAHFZQHOWa2vZkQKDGA+GmesYifM4zZ6vBw/UDvUgaA6xqlgbI1pxnVqSm
        hi7yKZXO6OkWSNnN+U5gTSOc3lbPWkxXgLY0gZbkYNe049Za3G6b9SKi+68KD3CGpOg7B5VKv655i
        odN+LnZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk0xB-009Jef-HU; Thu, 28 Apr 2022 10:00:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76C2F3001F7;
        Thu, 28 Apr 2022 12:00:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60D2A2029F872; Thu, 28 Apr 2022 12:00:52 +0200 (CEST)
Date:   Thu, 28 Apr 2022 12:00:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <Ympl1D11gXAxF0s4@hirez.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.757693825@infradead.org>
 <87fslzfmha.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fslzfmha.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:34:09PM -0500, Eric W. Biederman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > Currently ptrace_stop() / do_signal_stop() rely on the special states
> > TASK_TRACED and TASK_STOPPED resp. to keep unique state. That is, this
> > state exists only in task->__state and nowhere else.
> >
> > There's two spots of bother with this:
> >
> >  - PREEMPT_RT has task->saved_state which complicates matters,
> >    meaning task_is_{traced,stopped}() needs to check an additional
> >    variable.
> >
> >  - An alternative freezer implementation that itself relies on a
> >    special TASK state would loose TASK_TRACED/TASK_STOPPED and will
> >    result in misbehaviour.
> >
> > As such, add additional state to task->jobctl to track this state
> > outside of task->__state.
> >
> > NOTE: this doesn't actually fix anything yet, just adds extra state.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -770,7 +773,9 @@ void signal_wake_up_state(struct task_st
> >  	 * By using wake_up_state, we ensure the process will wake up and
> >  	 * handle its death signal.
> >  	 */
> > -	if (!wake_up_state(t, state | TASK_INTERRUPTIBLE))
> > +	if (wake_up_state(t, state | TASK_INTERRUPTIBLE))
> > +		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
> > +	else
> >  		kick_process(t);
> >  }
> 
> This hunk is subtle and I don't think it is actually what we want if the
> code is going to be robust against tsk->__state becoming TASK_FROZEN.

Oooh, indeed. Yes, let me go back to that resume based thing as you
suggest.

But first, let me go read all your patches :-)
