Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E2D4CAB76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbiCBRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbiCBRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:23:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A9C9A24
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:23:12 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646241790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6P8ltwVCQmRjuFn0TcABJufxoqYaGROP2gDiaqaYdfI=;
        b=sppZoKYESo+VZhpQZtLd7AsvCKYI6ATnhgG632g3AD0Bg4HKJA/nd5gSZ0kOm3aLd+YSM7
        cB/I0EnEIYFFX2MGVg0zAhHn3m4hwKfE6z7a+U+2h3BPNYqnJ75YivX+Z5z3c/EfAlK6Le
        IaR1RuqBNEL94uK5hqgEtIGewIuv7uZeeYEFQkxvV98a/Qw76EzKiy5+j5hs04Nlb0NjnN
        tY2V6dAlha58Qio09j5m6LXU01FdP6kYmmDXmCq6y7/R8DIqYWJPJY/imrxY3FrscegNwI
        n/3TnEN+shb3EEsM+O5ie0PoelXjc6bJsVymdkF8Lbr2b8j32lPm5vQhAHu9Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646241790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6P8ltwVCQmRjuFn0TcABJufxoqYaGROP2gDiaqaYdfI=;
        b=ct8B318MmEQpkOLvLr+tacQgeRBqgitaKH7wwGzFem7VEMg8BsxnVlfwZKC2yh/I6byP96
        R4tjo4BGQH0lJDBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 08/13] printk: add pr_flush()
In-Reply-To: <Yg4fQHlli5L/zLQ6@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-9-john.ogness@linutronix.de>
 <Yg4fQHlli5L/zLQ6@alley>
Date:   Wed, 02 Mar 2022 18:29:09 +0106
Message-ID: <87mti8gtfm.fsf@jogness.linutronix.de>
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

On 2022-02-17, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 02bde45c1149..1e80fd052bd5 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2802,8 +2804,10 @@ void console_unblank(void)
>>  	if (oops_in_progress) {
>>  		if (down_trylock_console_sem() != 0)
>>  			return;
>> -	} else
>> +	} else {
>> +		pr_flush(1000, true);
>
> It would make more sense to flush the consoles after they are
> unblanked. I mean to move this to the end of the function.

Agreed.

> Also it is not obvious why this is not called when oops_in_progress
> is set. I guess that it is because trylock is needed in this case.
> It should be handled inside pr_flush().
>
> I mean that pr_flush() should internally use trylock when
> @oops_in_progress is set. It will make it safe even in this
> mode.

pr_flush() is a might_sleep() function. We agreed on this at
LPC2019.

Creating a pr_flush() that will directly push out the messages (or
busy-wait) in non-preemptible contexts is complicated. It might be
something to attempt for the future, but I would prefer to avoid it at
this stage.

>>  		console_lock();
>> +	}
>>  
>>  	console_locked = 1;
>>  	console_may_schedule = 0;
>> @@ -2869,6 +2873,7 @@ struct tty_driver *console_device(int *index)
>>   */
>>  void console_stop(struct console *console)
>>  {
>> +	pr_flush(1000, true);
>
> It would be enough to flush just the given @console.

For v2 I will create an internal __pr_flush() to allow specifying that
only a single console is flushed. The high level pr_flush() will then
call __pr_flush() specifying all consoles.

> It might be possible to take over the job from the related
> kthread and flush it in this context. Well, I am not sure if
> it is a good idea.

I agree that it might not be a good idea. Let's keep things simple for
now.

>>  	console_lock();
>>  	console->flags &= ~CON_ENABLED;
>>  	console_unlock();
>> @@ -2880,6 +2885,7 @@ void console_start(struct console *console)
>>  	console_lock();
>>  	console->flags |= CON_ENABLED;
>>  	console_unlock();
>> +	pr_flush(1000, true);
>
> Same here.

OK.

>>  }
>>  EXPORT_SYMBOL(console_start);
>>  
>> @@ -3249,6 +3255,71 @@ static int __init printk_late_init(void)
>>  late_initcall(printk_late_init);
>>  
>>  #if defined CONFIG_PRINTK
>> +/**
>> + * pr_flush() - Wait for printing threads to catch up.
>> + *
>
> Alternative solution would be to take over the job from the kthreads
> and flush the consoles in this context. Well, I am not sure
> if it is a good idea or not.

Since pr_flush() is might_sleep() this would be relatively simple. Just
grab the console mutex and go. My concern is that this task may have
different scheduling parameters that could negatively affect the
system. For normal operation, I really would prefer that the designated
kthreads do the work. If "waiting for the kthreads" turns out to be
problematic, then maybe we could go down this path.

>> + * @timeout_ms:        The maximum time (in ms) to wait.
>> + * @reset_on_progress: Reset the timeout if forward progress is seen.
>> + *
>> + * A value of 0 for @timeout_ms means no waiting will occur. A value of -1
>> + * represents infinite waiting.
>> + *
>> + * If @reset_on_progress is true, the timeout will be reset whenever any
>> + * printer has been seen to make some forward progress.
>> + *
>> + * Context: Process context. May sleep while acquiring console lock.
>> + * Return: true if all enabled printers are caught up.
>> + */
>> +bool pr_flush(int timeout_ms, bool reset_on_progress)
>> +{
>> +	int remaining = timeout_ms;
>> +	struct console *con;
>> +	u64 last_diff = 0;
>> +	u64 printk_seq;
>> +	u64 diff;
>> +	u64 seq;
>> +
>> +	might_sleep();
>> +
>> +	seq = prb_next_seq(prb);
>> +
>> +	for (;;) {
>> +		diff = 0;
>> +
>> +		console_lock();
>> +		for_each_console(con) {
>> +			if (!console_is_usable(con))
>> +				continue;
>> +			printk_seq = con->seq;
>> +			if (printk_seq < seq)
>> +				diff += seq - printk_seq;
>> +		}
>> +		console_unlock();
>> +
>> +		if (diff != last_diff && reset_on_progress)
>> +			remaining = timeout_ms;
>> +
>> +		if (diff == 0 || remaining == 0)
>> +			break;
>> +
>> +		if (remaining < 0) {
>> +			/* no timeout limit */
>> +			msleep(100);
>> +		} else if (remaining < 100) {
>> +			msleep(remaining);
>> +			remaining = 0;
>> +		} else {
>> +			msleep(100);
>> +			remaining -= 100;
>> +		}
>> +
>> +		last_diff = diff;
>> +	}
>> +
>> +	return (diff == 0);
>> +}
>> +EXPORT_SYMBOL(pr_flush);
>
> Summary:
>
> The pr_flush() API and the optional timeout look reasonable to me.
>
> Please, handle oops_in_progress in pr_flush() and make it safe in this
> mode. It will allow to move it at the end of console_unblank() where
> it makes more sense.

I will add another oops_in_progress check at the end. pr_flush() will
not be made safe for oops_in_progress. Keep in mind that when
oops_in_progress is set, direct printing will be active, so there should
be no need for pr_flush() anyway.

> I do not resist on flushing only the given consoles in console_stop()
> and console_start(). It is nice to have and can be done later.

It is a simple change. I will do it for v2.

> Also I do not resist on doing the flush in the context of the caller.
> I am not even sure if it is a good idea. We could play with it
> later when there are some problems with the current approach
> in practice.

For now, let's keep it as a waiting function.

John
