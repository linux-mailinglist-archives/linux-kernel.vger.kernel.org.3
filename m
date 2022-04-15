Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14702502A91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353813AbiDOM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbiDOM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF8F8CA0E9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650027383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uyWzLLY6zGqxInGh2+sNYAMObbPBDa6X39ZjtDI6sX0=;
        b=gCnT0A6ejH7P3X+M6BwEv9Jk0nGFI0dLVUInEjsaFksS+zBgCVWbbnj9ekXImO1jVYhZGu
        mmjEkLCFKjDuXqVFRNE8HuLrUBA5Du5/b95/n93hVdmo8buR1+BQVHrU36Av9dK1AkAztC
        3Gsuhqvci/THdNuFsKqAMfoD8P57XXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-Hs68ioQbM-iu0jwZ_uVSDQ-1; Fri, 15 Apr 2022 08:56:17 -0400
X-MC-Unique: Hs68ioQbM-iu0jwZ_uVSDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A30CC811E80;
        Fri, 15 Apr 2022 12:56:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8D7412167D68;
        Fri, 15 Apr 2022 12:56:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 15 Apr 2022 14:56:16 +0200 (CEST)
Date:   Fri, 15 Apr 2022 14:56:12 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220415125611.GB15217@redhat.com>
References: <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <YlleTwxqx4keRYd4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlleTwxqx4keRYd4@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15, Peter Zijlstra wrote:
>
> On Fri, Apr 15, 2022 at 12:16:44PM +0200, Oleg Nesterov wrote:
> >
> > Lets forget about 3-5 which I didn't read carefully yet. So why do we
> > need TRACED_FROZEN?
>
> The purpose of 1/5 was to not have any unique state in __state. To at
> all times be able to reconstruct __state from outside information (where
> needed).
>
> Agreed that this particular piece of state isn't needed until 5/5, but
> the concept is independent (also 5/5 is insanely large already).

OK, so in my opinion it would be more clean if TRACED_FROZEN comes in a
separate (and simple) patch before 5/5.

I won't really argue, but to me this flag looks confusing and unnecessary
in 1-2 (which btw look like a -stable material to me).

> > Can't we simply change signal_wake_up_state(),
> >
> > 	void signal_wake_up_state(struct task_struct *t, unsigned int state)
> > 	{
> > 		set_tsk_thread_flag(t, TIF_SIGPENDING);
> > 		/*
> > 		 * TASK_WAKEKILL also means wake it up in the stopped/traced/killable
> > 		 * case. We don't check t->state here because there is a race with it
> > 		 * executing another processor and just now entering stopped state.
> > 		 * By using wake_up_state, we ensure the process will wake up and
> > 		 * handle its death signal.
> > 		 */
> > 		if (wake_up_state(t, state | TASK_INTERRUPTIBLE))
> > 			t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
> > 		else
> > 			kick_process(t);
> > 	}
> >
> > ?
>
> This would be broken when we so signal_wake_up_state() when state
> doesn't match. Does that happen? I'm thikning siglock protects us from
> the most obvious races, but still.

Yes, even set_tsk_thread_flag(TIF_SIGPENDING) is not safe without siglock.

> Also, signal_wake_up_state() really can do with that
> lockdep_assert_held() as well ;-)

OK, lets add lockdep_assert_held() at the start of signal_wake_up_state ?

Agreed, this probably needs a comment, but this looks much simpler and
more understandable than 2 additional "if (resume)" checks in
signal_wake_up() and ptrace_signal_wake_up().

> > > > -	spin_lock_irq(&task->sighand->siglock);
> > > >  	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
> > > >  	    !__fatal_signal_pending(task)) {
> > > >  		task->jobctl |= JOBCTL_TRACED_FROZEN;
> > > >  		WRITE_ONCE(task->__state, __TASK_TRACED);
> > > >  		ret = true;
> > > >  	}
> > >
> > > I would feel much better if this were still a task_func_call()
> > > validating !->on_rq && !->on_cpu.
> >
> > Well, but "on_rq || on_cpu" would mean that wait_task_inactive() is buggy ?
>
> Yes, but I'm starting to feel a little paranoid here. Better safe than
> sorry etc..

OK, can we simply add

	WARN_ON_ONCE(ret && (on_rq || on_cpu));

after unlock_task_sighand() ? this is racy without rq_lock but should
catch the possible problems.

> > 	- do you agree we can avoid JOBCTL_TRACED_FROZEN in 1-2 ?
>
> We can for the sake of 2 avoid TRACED_FROZEN, but as explained at the
> start, the point of 1 was to ensure there is no unique state in __state,
> and I think in that respect we can keep it, hmm?

See above... I understand the purpose of TRACED_FROZEN (I hope ;),
but not in 1-2, and unless I missed something the change in signal_wake_up
above simply looks better to me, but of course this is subjective.

> > 	- will you agree if I change ptrace_freeze_traced() to rely
> > 	  on __state == TASK_TRACED rather than task_is_traced() ?
>
> Yes.

Great, thanks. I'll return tomorrow.

Oleg.

