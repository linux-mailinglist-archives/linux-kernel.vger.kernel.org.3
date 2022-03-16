Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561DE4DAC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354497AbiCPIYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiCPIYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:24:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16097DF43
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:23:24 -0700 (PDT)
Date:   Wed, 16 Mar 2022 09:23:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647419001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KufJwsnfI5CF+IvC8AFaW/fYYl7ZQPnkJ0/TGFXMWf4=;
        b=u3498QkUVfjcu0P9/or7uHAM2kFHX8yrHC3/Ad7Hr8PtWbpM1SeXJ9qcYuDk8TGlxds1l9
        J0njii7Fuqd3+3worrsQXicjU/B8GCTEv3Rl8MY783bkTAXdA0b4FRf3gaoCp16F/6rWPt
        qfAO+zksAHwHZPCFHEJkxg8/d35qRF5uC5nLS0JsCyAjtIGh8326wqP/cY2vlkTTXI/TbK
        kdlX8+NCPfpd4WNWcSVRtVfvhreS6Me5ApE28NHTKDSX8Byhl0CWk+2609xHKvSOMX2zaK
        YyxTzXuFlh/yvxswsTeFINOAl+cSDRVFRNnChMAltf6aY/IV0GRjP4V0zJp0UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647419001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KufJwsnfI5CF+IvC8AFaW/fYYl7ZQPnkJ0/TGFXMWf4=;
        b=rr70YkguRBrIGAO97ABRjUp0zDrOik+5WMNNmvkQECrFBjtcckXVVO6KvEFR2eLRbqY8Om
        qO9kX3x6nFof4nBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] ptrace: fix ptrace vs tasklist_lock race on PREEMPT_RT.
Message-ID: <YjGed4pvP1RM9liz@linutronix.de>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
 <20220314185429.GA30364@redhat.com>
 <YjBO8yzxdmjTGNiy@linutronix.de>
 <20220315142944.GA22670@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315142944.GA22670@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-15 15:29:46 [+0100], Oleg Nesterov wrote:
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -3239,7 +3239,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
> > > >  		 * is actually now running somewhere else!
> > > >  		 */
> > > >  		while (task_running(rq, p)) {
> > > > -			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> > > > +			if (match_state &&
> > > > +			    unlikely(!task_state_match_eq(p, match_state)))
> > > >  				return 0;
> > >
> > > So wait_task_inactive() can return 0 but the task can run after that, right?
> > > This is not what we want...
> >
> > Without checking both states you may never observe the requested state
> > because it is set to TASK_RTLOCK_WAIT while waiting for a lock. Other
> > than that, it may run briefly because it tries to acquire a lock or just
> > acquired and this shouldn't be different from a task spinning on a lock.
> 
> I don't understand. wait_task_inactive() is used to ensure that this task
> doesn't and can't run again, until debugger resumes these tracee.
> 
> Now. Unless I missed something, the tracee can leave CPU with saved_state
> = TRACED (so task_state_match_eq() returns T) and wait_task_inactive() will
> return. Then later the tracee will park in schedule again, yes.
> 
> But, for example, what if debugger clears TIF_BLOCKSTEP in between, while
> the tracee is running? Can't this race with __switch_to_xtra() ?

If you describe like that, then it appears better to only look at
->state. Otherwise, yes, you would see the expected state in
->saved_state and the task might still be on the CPU. Even if it is not
actually running/ on the runqueue, it could be the case if the lock has
been made available shortly after.

> Oleg.

Sebastian
