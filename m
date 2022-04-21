Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224EB50A99D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392148AbiDUUCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351747AbiDUUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:02:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377954D9F9;
        Thu, 21 Apr 2022 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HDKHu1E76IDSGv1OM3uK8i7f9RkzuL23ZGT+an3JVfA=; b=k8RHSSpPio9cut8zxiDXw+oWYN
        nqQx7cidp5PFTX1VQvaplpGZSmPE6vshU3YO6wnnys/QSmKvZiIhsD/4Iq0av8WWK4q6JqzdjA3Oe
        ZcpzVv+Rmg3vPhknwZ8OVIdG+JheDQW3t0vDg3C8sPD7MOnXe5jJDsIFGcnCVTnUvS1hNexAHjUky
        SPz2+fvggaBRvrp8rJ1+vDsz67swOoxCVm5aKbo9v8VAt+t7lZ6mrTjvRQMzpy7PxJm8Ym0SlXieh
        ZSnl9dXJXbjd83hFbFgOP74BZIDmevx8yBGKonUxuUPBUf7gKTf9e0j6yshGds151meSr92yB+c9h
        hQYBWhmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhcx3-007VdD-1b; Thu, 21 Apr 2022 19:58:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CAC49861C1; Thu, 21 Apr 2022 21:58:52 +0200 (CEST)
Date:   Thu, 21 Apr 2022 21:58:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <20220421195852.GP2731@worktop.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <20220421182325.GC20402@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421182325.GC20402@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:23:26PM +0200, Oleg Nesterov wrote:
> On 04/21, Peter Zijlstra wrote:
> >
> > Rework ptrace_check_attach() / ptrace_unfreeze_traced() to not rely on
> > task->__state as much.
> 
> Looks good after the quick glance... but to me honest I got lost and
> I need to apply these patches and read the code carefully.
> 
> However, I am not able to do this until Monday, sorry.

Sure, no worries. Take your time.

> Just one nit for now,
> 
> >  static void ptrace_unfreeze_traced(struct task_struct *task)
> >  {
> > -	if (READ_ONCE(task->__state) != __TASK_TRACED)
> > +	if (!task_is_traced(task))
> >  		return;
> >  
> >  	WARN_ON(!task->ptrace || task->parent != current);
> >  
> > -	/*
> > -	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
> > -	 * Recheck state under the lock to close this race.
> > -	 */
> >  	spin_lock_irq(&task->sighand->siglock);
> > -	if (READ_ONCE(task->__state) == __TASK_TRACED) {
> > +	if (task_is_traced(task)) {
> 
> I think ptrace_unfreeze_traced() should not use task_is_traced() at all.
> I think a single lockless
> 
> 	if (task->jobctl & JOBCTL_DELAY_WAKEKILL)
> 		return;
> 
> at the start should be enough?

I think so. That is indeed cleaner. I'll make the change if I don't see
anything wrong with it in the morning when the brain has woken up again
;-)

> 
> Nobody else can set this flag. It can be cleared by the tracee if it was
> woken up, so perhaps we can check it again but afaics this is not strictly
> needed.
> 
> > +//		WARN_ON_ONCE(!(task->jobctl & JOBCTL_DELAY_WAKEKILL));
> 
> Did you really want to add the commented WARN_ON_ONCE?

I did that because:

@@ -1472,8 +1479,7 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_lo
                                  request == PTRACE_INTERRUPT);
        if (!ret) {
                ret = compat_arch_ptrace(child, request, addr, data);
-               if (ret || request != PTRACE_DETACH)
-                       ptrace_unfreeze_traced(child);
+               ptrace_unfreeze_traced(child);
        }

Can now call unfreeze too often. I left the comment in because I need to
think more about why Eric did that and see if it really is needed.
