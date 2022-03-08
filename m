Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4124D0CD7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241836AbiCHAiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiCHAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:38:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7072D2CCA3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646699873; x=1678235873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ywwjoV2BWy6X+hnNFU3ifYjAswzVR8I6irSTeAw8JxM=;
  b=Rvr+sKkSTi3X+jaecb00xCogBUOK8MofvEaAwZIZ7YteL8DFBaOTLLoj
   lJGFKDxZhfitU9ofxBg7cFVxQ/tOh7cyRX6Cj4sIMGilyF0niDsyw9R6f
   4LSm+OK8Mr6/QxbgI8VoyUddcRowyqUcdGvalb9duvg3ZJKvqXApkJNaW
   miOGMKRhhme4RzyRNPsXXTXZ3CezxXSwKPQ5hrfaybVHOu2OC/FqRVJiZ
   9wCihJi4MX1V+JKVzDIurbc3JyfGKi7U/r4fFfV7PA2TfO6LY9s0vQ316
   QPZBqlNJQ5rOqYqHq38StIdagrnPfSbkrMWKZ2n+NTJx0Z/QEe/b1Bl0i
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254275067"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="254275067"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 16:37:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="643462427"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 16:37:52 -0800
Date:   Mon, 7 Mar 2022 16:37:51 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/split_lock: Make life miserable for split lockers
Message-ID: <YialXwpbED5kAUaZ@agluck-desk3.sc.intel.com>
References: <20220217012721.9694-1-tony.luck@intel.com>
 <877d95l7jo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d95l7jo.ffs@tglx>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 11:30:35PM +0100, Thomas Gleixner wrote:
> Tony,
> 
> On Wed, Feb 16 2022 at 17:27, Tony Luck wrote:
> > Questions for this RFC:
> >
> > 1) Does this need to be a new option? Maybe just update the
> >    existing "warn" mode to add this level of extra pain.
> 
> That's fine. Warn is the default today, right?

Yes. Warn is the current default.
Does "That's fine" mean ok to change exiting warn code to add
this level of pain? Or OK to add a new option?

> > 2) Under what circumstances will work a function scheduled with
> >    schedule_delayed_work() run on different CPU?
> 
> Under many...
> 
> >    I've covered the obvious case of the CPU being taken offline before
> >    the work is run. But are there other cases?
> 
> scheduled_delayed_work_on() is what you are looking for.

That sounds like the right choice ... I just didn't dig deep
enough into the options available.

> > 3) Should I add even more pain with an msleep() before even trying
> >    to get the semaphore?
> 
> No objections from me.

Will do in next version.

> > +static void __split_lock_reenable(struct work_struct *work)
> > +{
> > +	sld_update_msr(true);
> > +	up(&buslock_sem);
> > +}
> > +
> > +/*
> > + * If a CPU goes offline with pending delayed work to
> > + * re-enable split lock detection then the delayed work
> > + * will be executed on some other CPU. That handles releasing
> > + * the buslock_sem, but because it executes on a different
> > + * CPU probably won't re-enable split lock detection. This
> > + * is a problem on HT systems since the sibling CPU on the
> > + * same core may then be left running with split lock
> > + * detection disabled.
> > + *
> > + * Unconditionally re-enable detection here.
> 
> Had to think twice whether this works under all circumstances. It
> actually works because of how CPU hotunplug works nowadays. It
> guarantees that after the initial CPU down state sched_cpu_deactivate()
> no task which is running or affine to the CPU can get back to user space
> on that CPU. That was not always the case, that's why I had to think
> twice :)
> 
> But I'm not yet convinced that this is required at all.
> 
> > + */
> > +static int splitlock_cpu_offline(unsigned int cpu)
> > +{
> > +	sld_update_msr(true);
> > +
> > +	return 0;
> > +}
> > +
> > +static DECLARE_DELAYED_WORK(split_lock_reenable, __split_lock_reenable);
> > +
> >  static void split_lock_warn(unsigned long ip)
> >  {
> >  	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
> >  			    current->comm, current->pid, ip);
> >  
> > -	/*
> > -	 * Disable the split lock detection for this task so it can make
> > -	 * progress and set TIF_SLD so the detection is re-enabled via
> > -	 * switch_to_sld() when the task is scheduled out.
> > -	 */
> > +	switch (sld_state) {
> > +	case sld_warn:
> > +		/* This task will keep running with split lock disabled */
> > +		set_tsk_thread_flag(current, TIF_SLD);
> > +		break;
> > +	case sld_sequential:
> > +		/* Only allow one buslocked disabled core at a time */
> > +		if (down_interruptible(&buslock_sem) == -EINTR)
> > +			return;
> > +		schedule_delayed_work(&split_lock_reenable, 2);
> 
> Hmm. This does not set TIF_SLD. So:
> 
>  task hits splitlock
>    #AC
>      down(sema);
>      schedule_work();
>      disable_sld();
> 
>  task is preempted or schedules out voluntarily
> 
>    -> SLD stays disabled for the incoming task which is wrong and it
>       stays disabled up to the point where the timer fires or a task
>       switch with TIF_SLD mismatch happens. 
> 
> Not what we want, right?

It isn't ideal. We just gave a free pass to some other tasks to
do split locks for up to two jiffies. But they would have been
given those two jiffies later had they taken an #AC trap ... so
they just bypassed the queue to get what we would have given them
later.

> So the right thing to do is to set TIF_SLD also for the sequential
> case. Now how to do that delayed split lock reenable for the task in
> question?
> 
> 	case sld_sequential:
> 		if (down_interruptible(&buslock_sem) == -EINTR)
> 			return;
> 		set_tsk_thread_flag(current, TIF_SLD);
>                 buslock_sequential_task = current;
>                 get_task_struct(current);
> 		schedule_delayed_work_on(smp_processor_id(), &split_lock_reenable, 2);
> 
> and then the work function does:
> 
>     clear_tsk_thread_flag(buslock_sequential_task, TIF_SLD);
>     put_task_struct(buslock_sequential_task);
>     buslock_sequential_task = NULL;
>     up(&buslock_sem);
>     
> With that you spare the cpu hotplug callback as well simply because it's
> guaranteed that the SLD state is handled correctly when the task in
> question schedules out. I.e. it does not matter at all on which CPU the
> timer goes off if the CPU on which is was armed is offlined before it
> fires.
> 
> But that's nasty too because if the task schedules away from the CPU on
> which it hit the buslock in the first place and then stays on the other
> CPU in user space forever (think NOHZ_FULL) then it can buslock forever
> too.

Agreed. Trying to get this "perfect" has many ugly corner cases.

> The question is whether this is something to worry about. If so, then we
> need to go back to the drawing board.

I don't think it is worth worrying about. The case you describe is
a process that is about to be preempted when the #AC trap happens.
In that case this CPU (in fact both HT threads on this core) get
two jiffies of free split locks.  Cases from here:

1) The original process gets to run on either of these threads
before the timeout. They get to execute their split lock and carry
on running.

2) The process is scheduled on a different core during the two jiffie
window. They take an #AC trap and block on the semaphore until the
original core releases. Then they get their chance to run on this new
core.

3) The original process doesn't get rescheduled for two jiffies, then
runs somewhere. The original core has released the sempahore and re-enabled
split lock checking. So the process takes #AC, gets the semaphore, kernel
disables split lock checking ... and we try again.

Now it is possible that the process may repeatedly be preempted in between
getting the semaphore and actually getting all the way to user space
to split a lock ... but can only happen if there are multiple processes
splitting locks. The goal of this patch is to be mean to all of them. If
we happen to be extra mean to some of them, well so be it.

-Tony
