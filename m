Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658704D0B15
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbiCGWbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbiCGWbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:31:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3F9193FE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:30:38 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646692236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JDsxEU9WPk1sgHwX5/LZeqY6i9h0U7lu/oUKMZUs2po=;
        b=YbhIFyYSmneBNYROTnYFvcF1htsSPfaSz9uV8vdEOpT8DOmfzy1Gbtdss6eRSFJ+ZEpGDY
        1PnGrjPmzbypjjOD0J6pfi1kgA9jSNzQ+ls0uacayvKWcS9udmMWHps/YNgrncvJVokrmO
        MF4Hc8Ks6SA5Vq8SvdYBOnPalMyHP7hzpate0MQsrWIdvSwTBsduFakuntX7HzOvQHgZJj
        fAwtL+GK6aZt35lntMcdsBqeb0E3F8YaGkeAz0MyNkeN0mO8Y81ljR/W/uhRPYVPb/uPrZ
        +ICCzLQmvGvBVHja0lFeoqphzY4362WsupFAtqIK4l+JiHliyb7/B0R/yYtMyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646692236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JDsxEU9WPk1sgHwX5/LZeqY6i9h0U7lu/oUKMZUs2po=;
        b=KXZWI3Vv37Op6bxLy+OKfi+bSBXzCT6bqPzjS4oos0DuQEzR7jFBX5FMH0T2tn/QDX6IDA
        o+cs4Ni3g6GdVDAw==
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86/split_lock: Make life miserable for split lockers
In-Reply-To: <20220217012721.9694-1-tony.luck@intel.com>
References: <20220217012721.9694-1-tony.luck@intel.com>
Date:   Mon, 07 Mar 2022 23:30:35 +0100
Message-ID: <877d95l7jo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

On Wed, Feb 16 2022 at 17:27, Tony Luck wrote:
> Questions for this RFC:
>
> 1) Does this need to be a new option? Maybe just update the
>    existing "warn" mode to add this level of extra pain.

That's fine. Warn is the default today, right?

> 2) Under what circumstances will work a function scheduled with
>    schedule_delayed_work() run on different CPU?

Under many...

>    I've covered the obvious case of the CPU being taken offline before
>    the work is run. But are there other cases?

scheduled_delayed_work_on() is what you are looking for.

> 3) Should I add even more pain with an msleep() before even trying
>    to get the semaphore?

No objections from me.

> +static void __split_lock_reenable(struct work_struct *work)
> +{
> +	sld_update_msr(true);
> +	up(&buslock_sem);
> +}
> +
> +/*
> + * If a CPU goes offline with pending delayed work to
> + * re-enable split lock detection then the delayed work
> + * will be executed on some other CPU. That handles releasing
> + * the buslock_sem, but because it executes on a different
> + * CPU probably won't re-enable split lock detection. This
> + * is a problem on HT systems since the sibling CPU on the
> + * same core may then be left running with split lock
> + * detection disabled.
> + *
> + * Unconditionally re-enable detection here.

Had to think twice whether this works under all circumstances. It
actually works because of how CPU hotunplug works nowadays. It
guarantees that after the initial CPU down state sched_cpu_deactivate()
no task which is running or affine to the CPU can get back to user space
on that CPU. That was not always the case, that's why I had to think
twice :)

But I'm not yet convinced that this is required at all.

> + */
> +static int splitlock_cpu_offline(unsigned int cpu)
> +{
> +	sld_update_msr(true);
> +
> +	return 0;
> +}
> +
> +static DECLARE_DELAYED_WORK(split_lock_reenable, __split_lock_reenable);
> +
>  static void split_lock_warn(unsigned long ip)
>  {
>  	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
>  			    current->comm, current->pid, ip);
>  
> -	/*
> -	 * Disable the split lock detection for this task so it can make
> -	 * progress and set TIF_SLD so the detection is re-enabled via
> -	 * switch_to_sld() when the task is scheduled out.
> -	 */
> +	switch (sld_state) {
> +	case sld_warn:
> +		/* This task will keep running with split lock disabled */
> +		set_tsk_thread_flag(current, TIF_SLD);
> +		break;
> +	case sld_sequential:
> +		/* Only allow one buslocked disabled core at a time */
> +		if (down_interruptible(&buslock_sem) == -EINTR)
> +			return;
> +		schedule_delayed_work(&split_lock_reenable, 2);

Hmm. This does not set TIF_SLD. So:

 task hits splitlock
   #AC
     down(sema);
     schedule_work();
     disable_sld();

 task is preempted or schedules out voluntarily

   -> SLD stays disabled for the incoming task which is wrong and it
      stays disabled up to the point where the timer fires or a task
      switch with TIF_SLD mismatch happens. 

Not what we want, right?

So the right thing to do is to set TIF_SLD also for the sequential
case. Now how to do that delayed split lock reenable for the task in
question?

	case sld_sequential:
		if (down_interruptible(&buslock_sem) == -EINTR)
			return;
		set_tsk_thread_flag(current, TIF_SLD);
                buslock_sequential_task = current;
                get_task_struct(current);
		schedule_delayed_work_on(smp_processor_id(), &split_lock_reenable, 2);

and then the work function does:

    clear_tsk_thread_flag(buslock_sequential_task, TIF_SLD);
    put_task_struct(buslock_sequential_task);
    buslock_sequential_task = NULL;
    up(&buslock_sem);
    
With that you spare the cpu hotplug callback as well simply because it's
guaranteed that the SLD state is handled correctly when the task in
question schedules out. I.e. it does not matter at all on which CPU the
timer goes off if the CPU on which is was armed is offlined before it
fires.

But that's nasty too because if the task schedules away from the CPU on
which it hit the buslock in the first place and then stays on the other
CPU in user space forever (think NOHZ_FULL) then it can buslock forever
too.

The question is whether this is something to worry about. If so, then we
need to go back to the drawing board.

Thanks,

        tglx
