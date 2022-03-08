Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A664D1CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348161AbiCHQJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347960AbiCHQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:09:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7594D61F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:08:40 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F0D211F397;
        Tue,  8 Mar 2022 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646755718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ExqTYTTrDe/PG8TRCZzEu5ImVXn3vPGgtIuI0shBh2A=;
        b=srM8JxeYerba3QWeUkCGf/KePrws+sSVet3tHmNWQrwrdbdaLjMb9MtXMHr2Rxhok/sQLd
        ychUJpFe6o0tbC/n6GRRNFHi5NvGKCq5hk2Q7LlQLQBGeiPn8rzDbHcfzsdTwnZ/Q6ZMQk
        6eCDZiV4sjZOc2ry2MlrF3gcnMfMl9M=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D0C25A3B89;
        Tue,  8 Mar 2022 16:08:38 +0000 (UTC)
Date:   Tue, 8 Mar 2022 17:08:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: two locations: was: Re: [PATCH printk v1 03/13] printk: use
 percpu flag instead of cpu_online()
Message-ID: <Yid/hLD0hMl7kpan@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <Yg0C+UtoegnybA4q@alley>
 <87v8wwh0jw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8wwh0jw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-02 15:55:23, John Ogness wrote:
> On 2022-02-16, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index d1b773823d63..b346e60e9e51 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -2577,11 +2577,11 @@ static int have_callable_console(void)
> >>   *
> >>   * Console drivers may assume that per-cpu resources have been allocated. So
> >>   * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
> >> - * call them until this CPU is officially up.
> >> + * call them until per-cpu resources have been allocated.
> >>   */
> >>  static inline int can_use_console(void)
> >>  {
> >> -	return cpu_online(raw_smp_processor_id()) || have_callable_console();
> >> +	return (printk_percpu_data_ready() || have_callable_console());
> >>  }
> >
> > cpu_online(raw_smp_processor_id()) check is used also in
> > call_console_drivers(). The same logic should be used in both
> > locations.
> >
> > I found this when reviewing 6th patch that replaced both checks
> > with a single one.
> >
> > Note that I am still not sure if this change is correct at all.
> > It will allow to always call the console during CPU hotplug
> > and I am not sure if it is safe. IMHO, it might cause problems when
> > a console driver uses, for example, CPU-bound workqueues.
> 
> You are correct. We must take hotplug into account for !CON_ANYTIME
> consoles. There may be some hotplug callbacks that make memory
> unavailable for the console.
>
> However, I will add the use of printk_percpu_data_ready() in the
> check. !CON_ANYTIME consoles also should not be called until the per-cpu
> areas are ready. For example, it would be bad if a console queued
> irq_work before per-cpu areas are setup (cpu_online() is true during
> this time).
> 
> One of my main concerns was that raw_smp_processor_id() was used for the
> check. It is conceptually wrong to exclude certain consoles based on a
> current CPU when migration is still enabled. I understand that the use
> of can_use_console() is an optimization to avoid doing extra work where
> there are no consoles available. But the task could be preemptible there
> and _conceptually_, could get moved to another CPU before its write()
> callback is called. The cpu_online() check belongs in code where
> preemption is disabled.
> 
> If the context is preemptible, I do not think it will ever see
> !cpu_online(). So I think if the cpu_online() check is limited to
> unlocking when console_trylock() was used, it will be correct.

I investigated the cpu hotplug code and found the following:

1. In the cpu_down() code path, @cpu_online mask is cleared
   by this call chain:

   + take_cpu_down()
     + __cpu_disable()
       + smp_ops.cpu_disable()
	 + native_cpu_disable()   # x86
	   + cpu_disable_common()
	     + remove_cpu_from_maps()
	       + set_cpu_online(cpu, false)

   , where take_cpu_down() is called via:

   + .teardown.single() calback for CPUHP_TEARDOWN_CPU state
     + takedown_cpu()
       + stop_machine_cpuslocked()
         + stop_cpus()
           + __stop_cpus()
             + queue_stop_cpus_work()
	       + cpu_stop_queue_work()

  , which queues the work in cpu_stopper thread that is bound
    to the CPU:

   + cpu_stop_init()
     + smpboot_register_percpu_thread()
       + __smpboot_create_thread()
         + kthread_create_on_cpu()


   Summary: @cpu_online mask is cleared on the affected CPU in
            cpu_stopper thread that is bound to the same CPU.
	    It happens when handling CPUHP_TEARDOWN_CPU.


2. The CPU hotplug states are split into three groups:

     + code running on control CPU (another CPU)
     + low level code running on the hotplugged CPU
     + code running in the hotplug thread on the hotplugged CPU

   It is described in include/linux/cpuhotplug.h:

	/* PREPARE section invoked on a control CPU */
	CPUHP_OFFLINE = 0,
	[...]

	/*
	 * STARTING section invoked on the hotplugged CPU in low level
	 * bringup and teardown code.
	 */
	CPUHP_AP_IDLE_DEAD,
	[...]
	CPUHP_AP_ONLINE,
	CPUHP_TEARDOWN_CPU,

	/* Online section invoked on the hotplugged CPU from the hotplug thread */
	CPUHP_AP_ONLINE_IDLE,
	CPUHP_AP_SCHED_WAIT_EMPTY,
	[...]
	CPUHP_ONLINE,

   , where sched_cpu_wait_empty() is the .teardown.single callback for
     CPUHP_AP_SCHED_WAIT_EMPTY. After this callback, another tasks
     should not be scheduled on this CPU. Any attempt should be
     catched and handled by sched_cpu_dying().

   Note that CPUHP_AP_SCHED_WAIT_EMPTY is called before
   CPUHP_TEARDOWN_CPU when the CPU goes down.

   Summary: @cpu_only mask is cleared for the CPU when other tasks
	    could not longer be sheduled there.


Result: cpu_online(raw_smp_processor_id()) should be safe for our
	purpose. It will return false only the task could not longer
	migrate from the CPU.

	I have to admit that it is far from obvious and tricky like
	hell.


OK, cpu_online(raw_smp_processor_id()) check is not racy. Another
question is whether it is a good check whether the consoles are usable
or not.

I found the following:

1. My understanding is that affinity of IRQs is disabled right after
   clearing @cpu_online mask:

	void cpu_disable_common(void)
	{
		[...]
		remove_cpu_from_maps(cpu);
		[...]
		fixup_irqs();
		[...]
	}

2. Timers must not be used close after clearing @cpu_online mask, see
   see include/linux/cpuhotplug.h:

	/* Must be the last timer callback */
	CPUHP_AP_DUMMY_TIMER_STARTING,
	[...]
	CPUHP_AP_ONLINE,
	CPUHP_TEARDOWN_CPU,


Result: From my POV, cpu_online(raw_smp_processor_id()) marks
	reasonable place in the CPU hotplug code when the conosles
	start/stop being usable.

	But again, it is far from obvious and tricky like hell.


Summary: We need to keep cpu_online(raw_smp_processor_id()) check
	to make the consoles safe during CPU hotplug.

	IMHO, it is not about per-CPU variables. It is more
	about timers, interrupts. The hotplugged CPU is not
	ready call console code at these early hotplug stages.


> Regardless, my v2 will keep cpu_online() checks since they are necessary
> for hotplug support.

Yes, please. We should also somehow document this. But it can be done
separately. It is not necessarily in the scope of your patchset.

Best Regards,
Petr
