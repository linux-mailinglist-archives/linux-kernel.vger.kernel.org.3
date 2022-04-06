Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EC14F65A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbiDFQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbiDFQnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:43:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624262C9921
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:02:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0F8D8210F4;
        Wed,  6 Apr 2022 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649253778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Hj6TUYYZVqI6GTVl4sbxNDtJyuLH+USig48Poeuy3Y=;
        b=ZTtJedVOuUUivWBiZNeXVIWGHPToy8INpeVzddkJzsi1tCJBwPt51ndB5o9nkTBFLul66N
        F1EvY2APVGNLD2Smg9OYEiVxcsjIanFXSFHjYTFeQ9TNrCLLIZwQPGuCAaq3iayqNLG5zt
        2dAmXrpaa9dCGQ3M2++RGe1FJRTaKSQ=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 780F6A3B88;
        Wed,  6 Apr 2022 14:02:57 +0000 (UTC)
Date:   Wed, 6 Apr 2022 16:02:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 06/12] printk: refactor and rework printing
 logic
Message-ID: <Yk2djQKLg0syXqMF@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 15:31:29, John Ogness wrote:
> Refactor/rework printing logic in order to prepare for moving to
> threaded console printing.
> 
> - Move @console_seq into struct console so that the current
>   "position" of each console can be tracked individually.
> 
> - Move @console_dropped into struct console so that the current drop
>   count of each console can be tracked individually.
> 
> - Modify printing logic so that each console independently loads,
>   prepares, and prints its next record.
> 
> - Remove exclusive_console logic. Since console positions are
>   handled independently, replaying past records occurs naturally.
> 
> - Update the comments explaining why preemption is disabled while
>   printing from printk() context.
> 
> With these changes, there is a change in behavior: the console
> replaying the log (formerly exclusive console) will no longer block
> other consoles. New messages appear on the other consoles while the
> newly added console is still replaying.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> +/*
> + * Print out all remaining records to all consoles.
> + *
> + * Requires the console_lock.

It would be nice to document @do_cond_resched, something like:

 * @do_cond_resched is set by the caller. It can be true only in
   schedulable context.

> + *
> + * Returns true if a console was available for flushing, otherwise false.

It is not completely true after adding abandon_console_lock_in_panic().
But it is actually a chance to slightly change the meaning. I suggest
to define it as:

 * Returns true when there was at least one usable console and all
   messages were flushed to all usable consoles.

It will help to better define @next_seq meaning. And it is exactly
the meaning that we need in console_unlock(), see below.

> + *
> + * @next_seq is set to the highest sequence number of all of the consoles that
> + * were flushed.

The value is meaningful only when all consoles were flushed. It would
be nice to make it more clear. If we changed the return value meaning
than we could say:

 * @next_seq is the sequence number after the last available record.
 * The value is valid only when this function returns true. It means
 * that usable consoles are completely flushed.


> + *
> + * @handover will be set to true if a printk waiter has taken over the
> + * console_lock, in which case the caller is no longer holding the
> + * console_lock. Otherwise it is set to false.
> + */
> +static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
> +{
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

The return value is not used in this case. I would return "false"
here and update the meaning as suggested above.

> +			/* Track the highest seq flushed. */
> +			if (con->seq > *next_seq)
> +				*next_seq = con->seq;
> +
> +			if (!progress)
> +				continue;
> +			any_progress = true;
> +
> +			/* Allow panic_cpu to take over the consoles safely */
> +			if (abandon_console_lock_in_panic())
> +				return false;
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
> @@ -2686,125 +2790,33 @@ void console_unlock(void)
>  	 * between lines if allowable.  Not doing so can cause a very long
>  	 * scheduling stall on a slow console leading to RCU stall and
>  	 * softlockup warnings which exacerbate the issue with more
> -	 * messages practically incapacitating the system.
> -	 *
> -	 * console_trylock() is not able to detect the preemptive
> -	 * context reliably. Therefore the value must be stored before
> -	 * and cleared after the "again" goto label.
> +	 * messages practically incapacitating the system. Therefore, create
> +	 * a local to use for the printing loop.
>  	 */
>  	do_cond_resched = console_may_schedule;
> -again:
> -	console_may_schedule = 0;
> -
> -	/*
> -	 * We released the console_sem lock, so we need to recheck if
> -	 * cpu is online and (if not) is there at least one CON_ANYTIME
> -	 * console.
> -	 */
> -	if (!can_use_console()) {
> -		console_locked = 0;
> -		up_console_sem();
> -		return;
> -	}
>  
> -	for (;;) {
> -		size_t ext_len = 0;
> -		int handover;
> -		size_t len;
> +	do {
> +		console_may_schedule = 0;
>  
> -skip:
> -		if (!prb_read_valid(prb, console_seq, &r))
> +		flushed = console_flush_all(do_cond_resched, &next_seq, &handover);
> +		if (handover)
>  			break;
>  
> -		if (console_seq != r.info->seq) {
> -			console_dropped += r.info->seq - console_seq;
> -			console_seq = r.info->seq;
> -			if (panic_in_progress() && panic_console_dropped++ > 10) {
> -				suppress_panic_printk = 1;
> -				pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
> -			}
> -		}
> -
> -		if (suppress_message_printing(r.info->level)) {
> -			/*
> -			 * Skip record we have buffered and already printed
> -			 * directly to the console when we received it, and
> -			 * record that has level above the console loglevel.
> -			 */
> -			console_seq++;
> -			goto skip;
> -		}
> -
> -		/* Output to all consoles once old messages replayed. */
> -		if (unlikely(exclusive_console &&
> -			     console_seq >= exclusive_console_stop_seq)) {
> -			exclusive_console = NULL;
> -		}
> +		__console_unlock();
>  
> -		/*
> -		 * Handle extended console text first because later
> -		 * record_print_text() will modify the record buffer in-place.
> -		 */
> -		if (nr_ext_console_drivers) {
> -			ext_len = info_print_ext_header(ext_text,
> -						sizeof(ext_text),
> -						r.info);
> -			ext_len += msg_print_ext_body(ext_text + ext_len,
> -						sizeof(ext_text) - ext_len,
> -						&r.text_buf[0],
> -						r.info->text_len,
> -						&r.info->dev_info);
> -		}
> -		len = record_print_text(&r,
> -				console_msg_format & MSG_FORMAT_SYSLOG,
> -				printk_time);
> -		console_seq++;
> +		/* Were there any consoles available for flushing? */

The value is false also when abandon_console_lock_in_panic() returned
true. We basically want to break here when we could not do the job.
I would write something like:

		/*
		 * Do not try again when couldn't do the job. It avoids
		 * an infinite loop.
		 */

> +		if (!flushed)
> +			break;
>  
>  		/*
> -		 * While actively printing out messages, if another printk()
> -		 * were to occur on another CPU, it may wait for this one to
> -		 * finish. This task can not be preempted if there is a
> -		 * waiter waiting to take over.
> -		 *
> -		 * Interrupts are disabled because the hand over to a waiter
> -		 * must not be interrupted until the hand over is completed
> -		 * (@console_waiter is cleared).
> +		 * Some context may have added new records after
> +		 * console_flush_all() but before unlocking the console.
> +		 * Re-check if there is a new record to flush. If the trylock
> +		 * fails, another context is already handling the printing.
>  		 */
> -		printk_safe_enter_irqsave(flags);
> -		console_lock_spinning_enable();
> -
> -		stop_critical_timings();	/* don't trace print latency */
> -		call_console_drivers(ext_text, ext_len, text, len);
> -		start_critical_timings();
> -
> -		handover = console_lock_spinning_disable_and_check();
> -		printk_safe_exit_irqrestore(flags);
> -		if (handover)
> -			return;
> -
> -		/* Allow panic_cpu to take over the consoles safely */
> -		if (abandon_console_lock_in_panic())
> -			break;
> -
> -		if (do_cond_resched)
> -			cond_resched();
> -	}
> -
> -	/* Get consistent value of the next-to-be-used sequence number. */
> -	next_seq = console_seq;
> -
> -	console_locked = 0;
> -	up_console_sem();
> -
> -	/*
> -	 * Someone could have filled up the buffer again, so re-check if there's
> -	 * something to flush. In case we cannot trylock the console_sem again,
> -	 * there's a new owner and the console_unlock() from them will do the
> -	 * flush, no worries.
> -	 */
> -	retry = prb_read_valid(prb, next_seq, NULL);
> -	if (retry && !abandon_console_lock_in_panic() && console_trylock())
> -		goto again;
> +	} while (prb_read_valid(prb, next_seq, NULL) &&
> +		 !abandon_console_lock_in_panic() &&

This is not longer needed. Either all messages are proceed or
we are not here because console_flush_all() returned false.

Another motivation to remove it that it is bit racy here. The state
could change only under the console lock.

It is not a big deal. But I would prefer to remove it because it makes
false assumptions about the logic.

> +		 console_trylock());
>  }
>  EXPORT_SYMBOL(console_unlock);


Summary: All the proposed changes are cosmetic. And I like the new code.

Best Regards,
Petr
