Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072C64F8553
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345867AbiDGQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiDGQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:56:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069063BF7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:54:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C57101F85F;
        Thu,  7 Apr 2022 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649350440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dcvuNZmzf9IanKboANqk11ZG1S1mH/HQloafcR5di/E=;
        b=vOdTkOEgefoWGNss7iZx6b0aqJsoCT3qjrhpLn1fX+o9ZGI6btnZDvhlOJs5jVGBdtQTBN
        yPFSrh3SnsttT36a3bgFVWVPueDkxVjHAFGsUjAzsDTlUk1Gj4QVi0E284kkMyu7T1g4Ck
        iZMMxP7KhAy5RbOs+I0zigTFYBpHVx0=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A4797A3B87;
        Thu,  7 Apr 2022 16:54:00 +0000 (UTC)
Date:   Thu, 7 Apr 2022 18:53:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: wake_up_klogd(): was: Re: [PATCH printk v2 10/12] printk: add
 kthread console printers
Message-ID: <Yk8XJ7NX2JGOQLna@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 15:31:33, John Ogness wrote:
> Create a kthread for each console to perform console printing. During
> normal operation (@system_state == SYSTEM_RUNNING), the kthread
> printers are responsible for all printing on their respective
> consoles.
> 
> During non-normal operation, console printing is done as it has been:
> within the context of the printk caller or within irq work triggered
> by the printk caller.
> 
> Console printers synchronize against each other and against console
> lockers by taking the console lock for each message that is printed.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3445,40 +3659,64 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
>  	int pending = this_cpu_xchg(printk_pending, 0);
>  
>  	if (pending & PRINTK_PENDING_OUTPUT) {
> +		printk_prefer_direct_enter();

Please, rename PRINTK_PENDING_OUTPUT to PRINTK_PENDING_DIRECT_OUTPUT.

The change confused me a lot. I wrote many lines about why it is
(not) needed. Then I continued the review and found that it started making
sense after the change in defer_console_output(). ;-)

This patch changes the meaning of the flag. It would deserve renaming.

> +
>  		/* If trylock fails, someone else is doing the printing */
>  		if (console_trylock())
>  			console_unlock();
> +
> +		printk_prefer_direct_exit();
>  	}
>  
>  	if (pending & PRINTK_PENDING_WAKEUP)
> -		wake_up_interruptible(&log_wait);
> +		wake_up_interruptible_all(&log_wait);

This would deserve some explanation in the commit message.
I think that this actually was needed even before. IMHO, more
pending waiters had to wait for more new messages. It was
not guaranteed the the woken waiter woke another one.

It would be nice to put it into separate patch and do it first.

>  }
>  
>  static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
>  	IRQ_WORK_INIT_LAZY(wake_up_klogd_work_func);
>  
> -void wake_up_klogd(void)
> +static void __wake_up_klogd(int val)
>  {
>  	if (!printk_percpu_data_ready())
>  		return;
>  
>  	preempt_disable();
> -	if (waitqueue_active(&log_wait)) {
> -		this_cpu_or(printk_pending, PRINTK_PENDING_WAKEUP);
> +	/*
> +	 * Guarantee any new records can be seen by printing threads before
> +	 * checking if the wait queue is empty.
> +	 *
> +	 * The full memory barrier within wq_has_sleeper() pairs with the full
> +	 * memory barrier within set_current_state() of
> +	 * prepare_to_wait_event(), which is called after ___wait_event() adds
> +	 * the waiter but before it has checked the wait condition.
> +	 *
> +	 * See printk_kthread_func:A for the pairing memory barrier.
> +	 */

I guess that this problem was there even before but it was less
visible. Do I get it correctly, please?


> +	if (wq_has_sleeper(&log_wait) || /* LMM(__wake_up_klogd:A) */
> +	    (val & PRINTK_PENDING_OUTPUT)) {
> +		this_cpu_or(printk_pending, val);
>  		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
>  	}
>  	preempt_enable();
>  }
>  
> +void wake_up_klogd(void)
> +{
> +	__wake_up_klogd(PRINTK_PENDING_WAKEUP);
> +}
> +
>  void defer_console_output(void)
>  {
> -	if (!printk_percpu_data_ready())
> -		return;

	/* Always wakeup waiters because there are not only printk kthreads. */
> +	int val = PRINTK_PENDING_WAKEUP;

IMHO, this was actually needed even before. Otherwise, nobody woken
log waiters for deferred messages.

IMHO, it is a regression caused by moving wake_up_klogd() from
console_unlock() to vprintk_emit(). It was the commit
43a17111c2553925f6 ("printk: wake up klogd in vprintk_emit").

If I am right then we should fix it separately.


> -	preempt_disable();
> -	this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
> -	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
> -	preempt_enable();
> +	/*
> +	 * If console deferring was called with preferred direct printing,
> +	 * make the irqwork perform the direct printing.
> +	 */
> +	if (atomic_read(&printk_prefer_direct))
> +		val |= PRINTK_PENDING_OUTPUT;
> +
> +	__wake_up_klogd(val);
>  }

And we should call defer_console_output() also in
printk_prefer_direct_enter() to make sure that a potential
pending messages are printed.

My understanding is that the kthreads stop processing the messages
when the direct output is preferred. I think that this was not
the case in v1 and I asked you do it this way so that kthreads
do not block entering the direct mode.

Best Regards,
Petr
