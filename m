Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E012C4CA9DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbiCBQLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbiCBQL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:11:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE30CCC51
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:10:41 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646237438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dpCfdVVubW/5G0sCMTdrqI3pOqQD2o+xFQjD5MgYmgQ=;
        b=WRkhAdBb7SOJYqxgIbggjqJ3ei5dTHS/fVTdC4uahMcr28/kwat/66PI6vs0/wnbIkyNaN
        1KJdJ5UgD54fHrHswSy2LFEgO+yya+YKCRcpIYoqqbl4oG8Lmovb8r/3OZzYwTRhffJ+V0
        eHk6CsMrb34IEl4riAoaqESlwW8FK6sbIHTVH9twnnMStBDrppYGTHrX/NJ1WBE2LddwH5
        xXuGid1H+9IY2Ir2w8DRtoXIJRsU+CICRyr3HL3L4qo/quGspS8ef+EgLUGcThGqoS8E5Q
        D/r62FdKy8XRBhV0gk3a+kg0dLD9R2pWisjg4qQySzz0AzOVZ9MeixKdxZY2ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646237438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dpCfdVVubW/5G0sCMTdrqI3pOqQD2o+xFQjD5MgYmgQ=;
        b=z4vbD2QK33o8oy9EYz0naUUQzwVX5z/N4UycCIzCGPye1jxW5U+whM2OvsNzPn+SOelOCk
        XyTaO5Nn5JV2dYBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 06/13] printk: refactor and rework printing logic
In-Reply-To: <Yg0bjsObmb9Zp1YP@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-7-john.ogness@linutronix.de>
 <Yg0bjsObmb9Zp1YP@alley>
Date:   Wed, 02 Mar 2022 17:16:37 +0106
Message-ID: <87sfs0gwsi.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-16, Petr Mladek <pmladek@suse.com> wrote:
>> Refactor/rework printing logic in order to prepare for moving to threaded
>> console printing.
>> 
>> - Move @console_seq into struct console so that the current "position" of
>>   each console can be tracked individually.
>> 
>> - Move @console_dropped into struct console so that the current drop count
>>   of each console can be tracked individually.
>> 
>> - Modify printing logic so that each console independently loads, prepares,
>>   prints, and delays its next record.
>> 
>> - Remove exclusive_console logic. Since console positions are handled
>>   independently, replaying past records occurs naturally.
>
> It would be great to say if it has any behavior change.
>
> There is one change caused by moving printk_delay(). I suggest to do
> it in a separate patch. See below for more details.

OK. I will do it in a separate patch.

> Another change is that console replaying the log (former exclusive
> console) does not longer block other consoles. New messages appear
> on other consoles while the newly added console is still replaying.
>
> Otherwise it should not change the existing behavior.

OK, I will mention behavior changes.

>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2560,31 +2524,167 @@ int is_console_locked(void)
>>  EXPORT_SYMBOL(is_console_locked);
>>  
>>  /*
>> - * Check if we have any console that is capable of printing while cpu is
>> - * booting or shutting down. Requires console_sem.
>> + * Check if the given console is currently capable and allowed to print
>> + * records.
>> + *
>> + * Requires the console_lock.
>>   */
>> -static int have_callable_console(void)
>> +static inline bool console_is_usable(struct console *con)
>>  {
>> -	struct console *con;
>> +	if (!(con->flags & CON_ENABLED))
>> +		return false;
>>  
>> -	for_each_console(con)
>> -		if ((con->flags & CON_ENABLED) &&
>> -				(con->flags & CON_ANYTIME))
>> -			return 1;
>> +	if (!con->write)
>> +		return false;
>>  
>> -	return 0;
>> +	/*
>> +	 * Console drivers may assume that per-cpu resources have been
>> +	 * allocated. So unless they're explicitly marked as being able to
>> +	 * cope (CON_ANYTIME) don't call them until per-cpu resources have
>> +	 * been allocated.
>> +	 */
>> +	if (!printk_percpu_data_ready() &&
>> +	    !(con->flags & CON_ANYTIME))
>> +		return false;
>
> Just for record. I am not completely sure about this check. It is
> being discussed in the 3rd patch.

Yes. In that discussion I mention that I will change it for v2.

>> +
>> +	return true;
>> +}
>> +
>> +static void __console_unlock(void)
>> +{
>> +	console_locked = 0;
>> +	up_console_sem();
>> +}
>> +
>> +/*
>> + * Print one record for the given console. The record printed is whatever
>> + * record is the next available record for the given console.
>> + *
>> + * Requires the console_lock.
>> + *
>> + * Returns false if the given console has no next record to print, otherwise
>> + * true.
>> + *
>> + * @handover will be set to true if a printk waiter has taken over the
>> + * console_lock, in which case the caller is no longer holding the
>> + * console_lock. Otherwise it is set to false.
>> + */
>> +static bool console_emit_next_record(struct console *con, bool *handover)
>> +{
>> +	static char ext_text[CONSOLE_EXT_LOG_MAX];
>> +	static char text[CONSOLE_LOG_MAX];
>> +	struct printk_info info;
>> +	struct printk_record r;
>> +	unsigned long flags;
>> +	char *write_text;
>> +	size_t len;
>> +
>> +	prb_rec_init_rd(&r, &info, text, sizeof(text));
>> +
>> +	*handover = false;
>> +
>> +	if (!prb_read_valid(prb, con->seq, &r))
>> +		return false;
>> +
>> +	if (con->seq != r.info->seq) {
>> +		con->dropped += r.info->seq - con->seq;
>> +		con->seq = r.info->seq;
>> +	}
>> +
>> +	/* Skip record that has level above the console loglevel. */
>> +	if (suppress_message_printing(r.info->level)) {
>> +		con->seq++;
>> +		goto skip;
>> +	}
>> +
>> +	if (con->flags & CON_EXTENDED) {
>> +		write_text = &ext_text[0];
>> +		len = info_print_ext_header(ext_text, sizeof(ext_text), r.info);
>> +		len += msg_print_ext_body(ext_text + len, sizeof(ext_text) - len,
>> +					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
>> +	} else {
>> +		write_text = &text[0];
>> +		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
>> +	}
>> +
>> +	/*
>> +	 * While actively printing out messages, if another printk()
>> +	 * were to occur on another CPU, it may wait for this one to
>> +	 * finish. This task can not be preempted if there is a
>> +	 * waiter waiting to take over.
>> +	 *
>> +	 * Interrupts are disabled because the hand over to a waiter
>> +	 * must not be interrupted until the hand over is completed
>> +	 * (@console_waiter is cleared).
>> +	 */
>> +	printk_safe_enter_irqsave(flags);
>> +	console_lock_spinning_enable();
>> +
>> +	stop_critical_timings();	/* don't trace print latency */
>> +	call_console_driver(con, write_text, len);
>> +	start_critical_timings();
>> +
>> +	con->seq++;
>> +
>> +	*handover = console_lock_spinning_disable_and_check();
>> +	printk_safe_exit_irqrestore(flags);
>> +
>> +	printk_delay(r.info->level);
>
> This is the desired behavior when the messages are printed by
> kthreads. Though, it will delay the output more times when
> more consoles are registered and the messages are printed
> synchronously from console_unlock().
>
> It is probably not super important. The delay is used only
> for debugging and people probably adjust it by a personal
> taste.
>
> Anyway, we should not hide this behavior change in this hude patch.
> IMHO, it is perfectly fine to keep the delay in vprintk_emit() for
> now. We could move it into console_flush_all() and kthread loops
> in a separate patch later.

OK, I will move it in a separate patch. And I will move it into the
kthreads and console_flush_all() so that the delay is only once per
successful output.

John
