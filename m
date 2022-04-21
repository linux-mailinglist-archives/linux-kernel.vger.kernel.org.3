Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2268E50A284
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389334AbiDUOdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389332AbiDUOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:33:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E07F3EB8C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:30:28 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650551426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wShEmRIqP+PgwjBZxai025SkMyaSbdoXWiSCrA1CANk=;
        b=NXcsnXfboVgD7RnNi1jb0LLLXXKBhPiRJi2kSkSS4SnHj/OWXY64w5ZBKdPfzXEZdEjfD6
        y4Hf0j13ozIajXGMxE86q8TJnJwZCwyZr0tFkP0dWKHTzcSDo4aCUsQ6E272oumjzb/Inz
        n25Ghe9MA9FXr8KeBuxBcuFuI85Mn6/gTBgNlsDmAaTAjtfPjio0ly3CEk0JIxvVB+uPpG
        1D1GaCRJfUiwmGwXkvzcNbv7oJpojpW9zaAzbjnWaW+RhY3QUJMkqp5euN/b5dXxF2gzK2
        9hn3T/bJkNpoIE97/XpeHD9wm8FeeRQ6oDulOajpu28X2+1AGodcE+0BVG2EmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650551426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wShEmRIqP+PgwjBZxai025SkMyaSbdoXWiSCrA1CANk=;
        b=jIysM8SuBf7u4r7MvgnN1xi3vnO8hCcgaz9dQuvMwdqQWY13XEarMSeSpJsVmv49Re2aAv
        CByPDZYeQN5yBVDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 14/15] printk: extend console_lock for proper
 kthread support
In-Reply-To: <20220421124119.GB11747@pathway.suse.cz>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-15-john.ogness@linutronix.de>
 <20220421124119.GB11747@pathway.suse.cz>
Date:   Thu, 21 Apr 2022 16:36:25 +0206
Message-ID: <875yn2h5ku.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-21, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2603,9 +2666,10 @@ static int console_cpu_notify(unsigned int cpu)
>>  		/* If trylock fails, someone else is doing the printing */
>>  		if (console_trylock())
>>  			console_unlock();
>> -
>> -		/* Wake kthread printers. Some may have become usable. */
>> -		wake_up_klogd();
>> +		else {
>> +			/* Some kthread printers may have become usable. */
>> +			wake_up_klogd();
>
> Do you have any particular scenario in mind, please?
> Could CPU hotplug put any printk kthread into a sleep?

I do not have a particular scenario. My reasoning was that a CPU coming
online would affect the conditions of __console_is_usable() for consoles
without CON_ANYTIME. Of course, it would mean that previously a kthread
went to sleep because it was trying to print from a CPU that was
offline. I am doubtful that such a scenario is possible. But you did
uncover some bizarre code paths where task migration could fail during
CPU offlining.

Anyway, you suggested to keep the CON_ANYTIME checks for kthreads in
there. So it seems correct to wake threads anytime the
printer_should_wake() conditions change.

>> @@ -2625,11 +2689,33 @@ void console_lock(void)
>>  	down_console_sem();
>>  	if (console_suspended)
>>  		return;
>> +	console_kthreads_block();
>>  	console_locked = 1;
>>  	console_may_schedule = 1;
>>  }
>>  EXPORT_SYMBOL(console_lock);
>>  
>> +/*
>> + * Lock the console_lock, but rather than blocking all the kthread printers,
>> + * lock a specified kthread printer and hold the lock. This is useful if
>> + * console flags for a particular console need to be updated.
>> + */
>> +void console_lock_single_hold(struct console *con)
>> +{
>> +	might_sleep();
>> +	down_console_sem();
>> +	mutex_lock(&con->lock);
>> +	console_locked = 1;
>> +	console_may_schedule = 1;
>
> This looks wrong. It is a global flag that could be modified
> only when all consoles are blocked.

You are correct. is_console_locked() needs to return false in this
scenario. I will leave out the @console_lock setting and insert a
comment to clarify why.

> This API blocks only the single console. The other consoles are still
> allowed to print actively.

That is the point. VT does not care about the other printers. VT is
using @console_locked to protect itself against itself.

> Another problem will appear with the 15th patch. It will remove
> console_locked variable and is_console_locked() will not longer
> be aware that this console is locked. We will not know that
> it might cause deadlock in the VT code.

From the perspective of VT code the console is _not_ locked. So
is_console_locked() should return false. is_console_locked() is to make
sure that the _VT code_ has called console_lock()/console_trylock(). So
the 15th patch is still correct.

>> @@ -2728,17 +2834,18 @@ static void __console_unlock(void)
>>   *
>>   * @handover will be set to true if a printk waiter has taken over the
>>   * console_lock, in which case the caller is no longer holding the
>> - * console_lock. Otherwise it is set to false.
>> + * console_lock. Otherwise it is set to false. A NULL pointer may be provided
>> + * to disable allowing the console_lock to be taken over by a printk waiter.
>>   *
>>   * Returns false if the given console has no next record to print, otherwise
>>   * true.
>>   *
>> - * Requires the console_lock.
>> + * Requires the console_lock if @handover is non-NULL.
>
>     * Requires con->lock otherwise.

Right. I will update the comments.

>>   */
>> -static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
>> -				     char *dropped_text, bool *handover)
>> +static bool __console_emit_next_record(struct console *con, char *text, char *ext_text,
>> +				       char *dropped_text, bool *handover)
>>  {
>> -	static int panic_console_dropped;
>> +	static atomic_t panic_console_dropped = ATOMIC_INIT(0);
>>  	struct printk_info info;
>>  	struct printk_record r;
>>  	unsigned long flags;
>> @@ -3261,6 +3401,8 @@ void register_console(struct console *newcon)
>>  
>>  	newcon->dropped = 0;
>>  	newcon->thread = NULL;
>> +	newcon->flags |= CON_THD_BLOCKED;
>
> Just to show the complexity added by console_lock_single_hold():
>
> It took me some time to realize that it is correct. The flag
> is needed because the console will be added under console_lock().
> The flag would not be needed when it was added under
> console_lock_single_hold().

?? But it is not added under
console_lock_single_hold(). console_lock_single_hold() is not a
replacement for console_lock(). Their purpose is very
different. console_lock_single_hold() is an internal function to provide
synchronization for @flags and @thread updates of a single console.

Maybe we are getting caught in my "bad naming" trap again. :-/

I do not have any ideas for a function that:

- locks @console_sem to prevent console registration/deregistration

- locks con->lock to provide synchronized @flags and/or @thread updates

>> +	mutex_init(&newcon->lock);
>>  
>>  	if (newcon->flags & CON_PRINTBUFFER) {
>>  		/* Get a consistent copy of @syslog_seq. */
>> @@ -3314,7 +3456,7 @@ int unregister_console(struct console *console)
>>  		return 0;
>>  
>>  	res = -ENODEV;
>> -	console_lock();
>> +	console_lock_single_hold(console);
>>  	if (console_drivers == console) {
>>  		console_drivers=console->next;
>
> Another example of the complexity:
>
> I though that this was not safe. console_drivers is a global list
> and console_lock_single_hold() is supposed to block only a single
> console. But it is actually safe because console_lock_single_hold()
> holds console_sem.

Yes. It is safe.

> Another question is why console_lock_single_hold() is enough
> here and why console_lock() is used in register_console(). I think
> that console_lock_single_hold() will be enough even in
> register_console().

?? And which console would you want to lock? @newcon? It is not
registered yet.

If you want to minimize register_console() locking, it is enough just to
down @console_sem.

> All this is far from obvious. It shows how the API is confusing and
> tricky. And it is another motivation to remove
> console_lock_single_hold().

We need a method to provide @flags synchronization between the kthreads
and console_stop(). Keep in mind that console_lock() does *not* hold the
mutexes. So a completed console_lock() call does *not* mean that the
kthreads are sleeping. They could still lock their own mutex and keep
going. It is not until the kthreads see that CON_THD_BLOCKED is set that
they realize they are not supposed to be running and go to sleep. But
console_stop() could be performing an update to @flags while that
kthread is checking it. It is a data race in code that should be
synchronized.

I spent some time trying to find a good solution for this. Here are the
ideas that I came up with:

1. Use READ_ONCE(short)/WRITE_ONCE(short) because probably that is
   enough to guarantee atomic writes/reads on all platforms.

2. Make @flags atomic_t. This guarentees consistence but would require
   changing how all consoles initialize that field.

3. Create a separate @enabled boolean field in struct console so that
   data races do not matter. This would also change how all consoles
   initialize their struct.

4. Provide a new function that uses the mutex to synchronize, since the
   kthread is already using the mutex.

I ended up choosing #4 because it had the added benefit of allowing
console_start(), console_stop(), console_unregister() to avoid affecting
the other kthreads.

>>  		res = 0;
>> @@ -3676,14 +3835,14 @@ static int printk_kthread_func(void *data)
>>  	kfree(ext_text);
>>  	kfree(text);
>>  
>> -	console_lock();
>> +	mutex_lock(&con->lock);
>
> This is serialized against unregister_console() but not with
> register_console() because they use different locking scheme.

?? In register_console() the thread has not been created yet. There is
nothing to synchronize against.

> Resume:
>
> I would prefer to get rid of console_lock_single_hold() and
> console_unlock_single_release() API.
>
> It was definitely an interesting experiment. I agree that it would
> be nice to do not block the other kthreads when it is not really
> needed. But from my POV, it adds more harm than good at the moment.

So we go with option #1 to solve(?) the @flags synchronization issue? Or
is there another option I missed?

> It is possible that we will want to do such optimizations
> in the future. But it must be easier to understand what exactly
> is serialized which way. At least it should be more documented.
> Also the same API would need to be used on the related code
> paths.

AFAICT it is used in all places that it is appropriate.

John
