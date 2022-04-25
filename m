Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E050E854
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbiDYShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiDYShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:37:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06107344E5;
        Mon, 25 Apr 2022 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5qVQxZ1OD07RpfMUmbcCjjbi8k9aOtyZiVsapMUQrfA=; b=qTe4B3JbHuwWwHywQg48ldn1cQ
        IDjbGLtRO/AxqE8azkJzUWMFgWYcxoytP/qDgB5TzeiJstYnpvRzexWsRX99/CmVv5Yi+FE4Lclba
        f3pL4zIuTy8S01Bsy+BYR4vzWgadpbORfts/rISRb11Ef15vbF+O2zZizepfO9MmidJm+/XbLA7vA
        XLsMresvSrOqAcu8yZzBmIZe7cyLWfIZoDjdSTuBmbRtSUslz7t+FRTCplUlchqcAP5i/qdxDfkT5
        pC3iyPYt9FJ7NnSY2l34rXIxnSrGkTixIDUys96S8COO6ruC1mvoG9v/ELoTH8NYGNxlC5BHGJifs
        aChvu0DA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj3Wq-008bBp-Cl; Mon, 25 Apr 2022 18:33:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7CB4980C21; Mon, 25 Apr 2022 20:33:43 +0200 (CEST)
Date:   Mon, 25 Apr 2022 20:33:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <20220425183343.GM2731@worktop.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <20220425143537.GA12412@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425143537.GA12412@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:35:37PM +0200, Oleg Nesterov wrote:
> On 04/21, Peter Zijlstra wrote:
> >
> > +static void clear_traced_quiesce(void)
> > +{
> > +	spin_lock_irq(&current->sighand->siglock);
> > +	WARN_ON_ONCE(!(current->jobctl & JOBCTL_TRACED_QUIESCE));
> 
> This WARN_ON_ONCE() doesn't look right, the task can be killed right
> after ptrace_stop() sets JOBCTL_TRACED | JOBCTL_TRACED_QUIESCE and
> drops siglock.

OK, will look at that.

> > @@ -2290,14 +2303,26 @@ static int ptrace_stop(int exit_code, in
> >  		/*
> >  		 * Don't want to allow preemption here, because
> >  		 * sys_ptrace() needs this task to be inactive.
> > -		 *
> > -		 * XXX: implement read_unlock_no_resched().
> >  		 */
> >  		preempt_disable();
> >  		read_unlock(&tasklist_lock);
> > -		cgroup_enter_frozen();
> > +		cgroup_enter_frozen(); // XXX broken on PREEMPT_RT !!!
> > +
> > +		/*
> > +		 * JOBCTL_TRACE_QUIESCE bridges the gap between
> > +		 * set_current_state(TASK_TRACED) above and schedule() below.
> > +		 * There must not be any blocking (specifically anything that
> > +		 * touched ->saved_state on PREEMPT_RT) between here and
> > +		 * schedule().
> > +		 *
> > +		 * ptrace_check_attach() relies on this with its
> > +		 * wait_task_inactive() usage.
> > +		 */
> > +		clear_traced_quiesce();
> 
> Well, I think it should be called earlier under tasklist_lock,
> before preempt_disable() above.
> 
> We need tasklist_lock to protect ->parent, debugger can be killed
> and go away right after read_unlock(&tasklist_lock).
> 
> Still trying to convince myself everything is right with
> JOBCTL_STOPPED/TRACED ...

Can't do it earlier, since cgroup_enter_frozen() can do spinlock (eg.
use ->saved_state).
