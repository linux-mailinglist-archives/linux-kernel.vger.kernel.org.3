Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19F54B8CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiBPPn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:43:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiBPPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:43:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F516FDC5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:43:12 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0F9C31F37D;
        Wed, 16 Feb 2022 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645026191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7fufCI37ElOCHc4jtLBskTpccS92f9EHiCptN23HoQ=;
        b=qouWV1rSaMfJxxtb4PaKStLD8lpXkCIHfZFnBaZ8wnxR/+xjDMvW+6v+TI5s+gIaRxfS7h
        LQpbadJN6VefN2A8DL3HihRRoY4az4a0uI2hZclpwO9Ob9ona5YVeKjkn/K174OmkBSWpq
        AbTEnYtdZMqTv0j7fVxtynQgFhL1WRY=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B78CCA3B85;
        Wed, 16 Feb 2022 15:43:10 +0000 (UTC)
Date:   Wed, 16 Feb 2022 16:43:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 06/13] printk: refactor and rework printing
 logic
Message-ID: <Yg0bjsObmb9Zp1YP@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:16, John Ogness wrote:
> Refactor/rework printing logic in order to prepare for moving to threaded
> console printing.
> 
> - Move @console_seq into struct console so that the current "position" of
>   each console can be tracked individually.
> 
> - Move @console_dropped into struct console so that the current drop count
>   of each console can be tracked individually.
> 
> - Modify printing logic so that each console independently loads, prepares,
>   prints, and delays its next record.
> 
> - Remove exclusive_console logic. Since console positions are handled
>   independently, replaying past records occurs naturally.

It would be great to say if it has any behavior change.

There is one change caused by moving printk_delay(). I suggest to do
it in a separate patch. See below for more details.

Another change is that console replaying the log (former exclusive
console) does not longer block other consoles. New messages appear
on other consoles while the newly added console is still replaying.

Otherwise it should not change the existing behavior.


> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2226,8 +2194,6 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		in_sched = true;
>  	}
>  
> -	printk_delay(level);
> -
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
>  
>  	/* If called from the scheduler, we can not call up(). */
> @@ -2560,31 +2524,167 @@ int is_console_locked(void)
>  EXPORT_SYMBOL(is_console_locked);
>  
>  /*
> - * Check if we have any console that is capable of printing while cpu is
> - * booting or shutting down. Requires console_sem.
> + * Check if the given console is currently capable and allowed to print
> + * records.
> + *
> + * Requires the console_lock.
>   */
> -static int have_callable_console(void)
> +static inline bool console_is_usable(struct console *con)
>  {
> -	struct console *con;
> +	if (!(con->flags & CON_ENABLED))
> +		return false;
>  
> -	for_each_console(con)
> -		if ((con->flags & CON_ENABLED) &&
> -				(con->flags & CON_ANYTIME))
> -			return 1;
> +	if (!con->write)
> +		return false;
>  
> -	return 0;
> +	/*
> +	 * Console drivers may assume that per-cpu resources have been
> +	 * allocated. So unless they're explicitly marked as being able to
> +	 * cope (CON_ANYTIME) don't call them until per-cpu resources have
> +	 * been allocated.
> +	 */
> +	if (!printk_percpu_data_ready() &&
> +	    !(con->flags & CON_ANYTIME))
> +		return false;

Just for record. I am not completely sure about this check. It is
being discussed in the 3rd patch.


> +
> +	return true;
> +}
> +
> +static void __console_unlock(void)
> +{
> +	console_locked = 0;
> +	up_console_sem();
> +}
> +
> +/*
> + * Print one record for the given console. The record printed is whatever
> + * record is the next available record for the given console.
> + *
> + * Requires the console_lock.
> + *
> + * Returns false if the given console has no next record to print, otherwise
> + * true.
> + *
> + * @handover will be set to true if a printk waiter has taken over the
> + * console_lock, in which case the caller is no longer holding the
> + * console_lock. Otherwise it is set to false.
> + */
> +static bool console_emit_next_record(struct console *con, bool *handover)
> +{
> +	static char ext_text[CONSOLE_EXT_LOG_MAX];
> +	static char text[CONSOLE_LOG_MAX];
> +	struct printk_info info;
> +	struct printk_record r;
> +	unsigned long flags;
> +	char *write_text;
> +	size_t len;
> +
> +	prb_rec_init_rd(&r, &info, text, sizeof(text));
> +
> +	*handover = false;
> +
> +	if (!prb_read_valid(prb, con->seq, &r))
> +		return false;
> +
> +	if (con->seq != r.info->seq) {
> +		con->dropped += r.info->seq - con->seq;
> +		con->seq = r.info->seq;
> +	}
> +
> +	/* Skip record that has level above the console loglevel. */
> +	if (suppress_message_printing(r.info->level)) {
> +		con->seq++;
> +		goto skip;
> +	}
> +
> +	if (con->flags & CON_EXTENDED) {
> +		write_text = &ext_text[0];
> +		len = info_print_ext_header(ext_text, sizeof(ext_text), r.info);
> +		len += msg_print_ext_body(ext_text + len, sizeof(ext_text) - len,
> +					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
> +	} else {
> +		write_text = &text[0];
> +		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
> +	}
> +
> +	/*
> +	 * While actively printing out messages, if another printk()
> +	 * were to occur on another CPU, it may wait for this one to
> +	 * finish. This task can not be preempted if there is a
> +	 * waiter waiting to take over.
> +	 *
> +	 * Interrupts are disabled because the hand over to a waiter
> +	 * must not be interrupted until the hand over is completed
> +	 * (@console_waiter is cleared).
> +	 */
> +	printk_safe_enter_irqsave(flags);
> +	console_lock_spinning_enable();
> +
> +	stop_critical_timings();	/* don't trace print latency */
> +	call_console_driver(con, write_text, len);
> +	start_critical_timings();
> +
> +	con->seq++;
> +
> +	*handover = console_lock_spinning_disable_and_check();
> +	printk_safe_exit_irqrestore(flags);
> +
> +	printk_delay(r.info->level);

This is the desired behavior when the messages are printed by
kthreads. Though, it will delay the output more times when
more consoles are registered and the messages are printed
synchronously from console_unlock().

It is probably not super important. The delay is used only
for debugging and people probably adjust it by a personal
taste.

Anyway, we should not hide this behavior change in this hude patch.
IMHO, it is perfectly fine to keep the delay in vprintk_emit() for
now. We could move it into console_flush_all() and kthread loops
in a separate patch later.

> +skip:
> +	return true;
>  }
>  
>  /*
> - * Can we actually use the console at this time on this cpu?
> + * Print out all remaining records to all consoles.
> + *
> + * Requires the console_lock.
> + *
> + * Returns true if a console was available for flushing, otherwise false.
>   *
> - * Console drivers may assume that per-cpu resources have been allocated. So
> - * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
> - * call them until per-cpu resources have been allocated.
> + * @next_seq is set to the highest sequence number of all of the consoles that
> + * were flushed.
> + *
> + * @handover will be set to true if a printk waiter has taken over the
> + * console_lock, in which case the caller is no longer holding the
> + * console_lock. Otherwise it is set to false.
>   */
> -static inline int can_use_console(void)
> +static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
>  {
> -	return (printk_percpu_data_ready() || have_callable_console());
> +	bool any_usable = false;
> +	struct console *con;
> +	bool any_progress;
> +
> +	*next_seq = 0;
> +	*handover = false;
> +
> +	do {
> +		any_progress = false;
> +
> +		for_each_console(con) {
> +			bool progress;
> +
> +			if (!console_is_usable(con))
> +				continue;
> +			any_usable = true;
> +
> +			progress = console_emit_next_record(con, handover);
> +			if (*handover)
> +				return true;
> +
> +			/* Track the highest seq flushed. */
> +			if (con->seq > *next_seq)
> +				*next_seq = con->seq;
> +
> +			if (!progress)
> +				continue;
> +			any_progress = true;
> +
> +			if (do_cond_resched)
> +				cond_resched();
> +		}
> +	} while (any_progress);
> +
> +	return any_usable;
>  }
>  
>  /**

I do not see any other problem. And I like this approach.

console_flush_all() might be a bit complicated for people that see
it for the first time. But console_unlock() complicated as well.
From my POV, the new code looks better than the previous one.

Best Regards,
Petr
