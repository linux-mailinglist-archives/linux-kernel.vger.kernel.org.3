Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1883C5AE5FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiIFKzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiIFKzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:55:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF3431EE4;
        Tue,  6 Sep 2022 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Y0roWy6gX2XtbWEokgETyquug6E6kJuCO0sZW0VN8U=; b=F/ucS8VVaIgnsMd6MqXTQGfx2X
        VSKFDJ60a7OACbRwpr07d0EJFjuMiEm33+jZxYfStVAkpJKxv1pSQHAYETzhe751bso6vWctlOU7M
        QMWqnmk+qdcN3FEble4rcnDlK0PQzW7C2gry40ZEcRnnC+jglLT4ytIWsq/ajyO+MSDBpRQuVRZPa
        y1fwwtMDRW6FVdU2+Pbr9HdCK+9apXcejtKPp5InFGHKsvGEgjQN043RPUv+SRuDHGmrFHgtSoO0P
        0ap+wwt6hBrEa3vtVynt/SiOPiu+yQTVFo99F1nNGAub64rFNOieAICysk8c7mM87QCoRrMwTJLp6
        O7c3dImw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVWE1-00AKVh-9w; Tue, 06 Sep 2022 10:54:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96BC2300244;
        Tue,  6 Sep 2022 12:54:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5971C2B65387A; Tue,  6 Sep 2022 12:54:34 +0200 (CEST)
Date:   Tue, 6 Sep 2022 12:54:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] sched: Change wait_task_inactive()s match_state
Message-ID: <Yxcm6oOTbmCbsHvj@hirez.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.856734578@infradead.org>
 <YxSBlPb/oZ6x0jfw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxSBlPb/oZ6x0jfw@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 12:44:36PM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Make wait_task_inactive()'s @match_state work like ttwu()'s @state.
> > 
> > That is, instead of an equal comparison, use it as a mask. This allows
> > matching multiple block conditions.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/core.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3295,7 +3295,7 @@ unsigned long wait_task_inactive(struct
> >  		 * is actually now running somewhere else!
> >  		 */
> >  		while (task_running(rq, p)) {
> > -			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> > +			if (match_state && !(READ_ONCE(p->__state) & match_state))
> >  				return 0;
> 
> We lose the unlikely annotation there - but I guess it probably never 
> really mattered anyway?

So any wait_task_inactive() caller does want that case to be true, but
the whole match_state precondition mostly wrecks things anyway. If
anything it should've been:

		if (likely(match_state && !(READ_ONCE(p->__state) & match_state)))
			return 0;

but I can't find it in me to care too much here.

> Suggestion #1:
> 
> - Shouldn't we rename task_running() to something like task_on_cpu()? The 
>   task_running() primitive is similar to TASK_RUNNING but is not based off 
>   any TASK_FLAGS.

That looks like a simple enough patch, lemme go do that.

> Suggestion #2:
> 
> - Shouldn't we eventually standardize on task->on_cpu on UP kernels too? 
>   They don't really matter anymore, and doing so removes #ifdefs and makes 
>   the code easier to read.

Probably, but that sounds like something that'll spiral out of control
real quick, so I'll leave that on the TODO list somewhere.

> >  			cpu_relax();
> >  		}
> > @@ -3310,7 +3310,7 @@ unsigned long wait_task_inactive(struct
> >  		running = task_running(rq, p);
> >  		queued = task_on_rq_queued(p);
> >  		ncsw = 0;
> > -		if (!match_state || READ_ONCE(p->__state) == match_state)
> > +		if (!match_state || (READ_ONCE(p->__state) & match_state))
> >  			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
> >  		task_rq_unlock(rq, p, &rf);
> 
> Suggestion #3:
> 
> - Couldn't the following users with a 0 mask:
> 
>     drivers/powercap/idle_inject.c:         wait_task_inactive(iit->tsk, 0);
>     fs/coredump.c:                  wait_task_inactive(ptr->task, 0);
> 
>   Use ~0 instead (exposed as TASK_ANY or so) and then we can drop the
>   !match_state special case?
> 
>   They'd do something like:
> 
>     drivers/powercap/idle_inject.c:         wait_task_inactive(iit->tsk, TASK_ANY);
>     fs/coredump.c:                  wait_task_inactive(ptr->task, TASK_ANY);
> 
>   It's not an entirely 100% equivalent transformation though, but looks OK 
>   at first sight: ->__state will be some nonzero mask for genuine tasks 
>   waiting to schedule out, so any match will be functionally the same as a 
>   0 flag telling us not to check any of the bits, right? I might be missing 
>   something though.

I too am thinking that should work. Added patch for that.
