Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3824D309A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiCIN5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiCIN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:57:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9DA17C400
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:56:10 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646834168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XGQi5p07+xCquta8JltWUCVKTWHMkgZLeb5CK2EMt0s=;
        b=QyeabP+d+8o1IWvA9ki+Pi/0cWsQHVw5ClaNq7V4dbU9d9WXF+CmHWO7/W/knBxmah/XPo
        +RGsrFWHKGJyhxQs2FWGt3bzYgxe6tLiwY5NqyvnYukEw9DvTl75JaU/8SJCkhkthccByY
        S4R80FOsizTnxq3z0meuyPyaZn2ubyYuJ16JdhW5qH5gx0Ic/yLsCWpmew//5NPHkoBZ/9
        SRDdwF4+5anXp6rUsxRacPhaNfPDLermpHdp2+vKrVCi8eTfGKXMeMgwFxWvJKJUpxvSxz
        IerFvrEiUgpy0on1frCK0m+biHlEQ/R2C1Qir+alzdtvHiPdO33+W8K8cM+dTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646834168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XGQi5p07+xCquta8JltWUCVKTWHMkgZLeb5CK2EMt0s=;
        b=XjxIDFJhhMOVNyrgVQbI5Tl0/oHgOU3vQ/stn4MYv1l7ThRdUHnlNHpbyXYZouybVvJtcq
        euNo9GVRirYbk7AQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
In-Reply-To: <YhYKP/UuSKENGwfj@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <YhYKP/UuSKENGwfj@alley>
Date:   Wed, 09 Mar 2022 15:02:07 +0106
Message-ID: <87tuc7xma0.fsf@jogness.linutronix.de>
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

On 2022-02-23, Petr Mladek <pmladek@suse.com> wrote:
>> +/*
>> + * A variant of console_trylock() that allows specifying if the context may
>> + * sleep. If yes, a trylock on @console_sem is attempted and if successful,
>> + * the threaded printers are paused. This is important to ensure that
>> + * sleepable contexts do not become involved in console_lock handovers and
>> + * will call cond_resched() during the printing loop.
>> + */
>> +static int console_trylock_sched(bool may_schedule)
>> +{
>> +	if (!may_schedule)
>> +		return console_trylock();
>> +
>> +	might_sleep();
>> +
>> +	if (down_trylock_console_sem())
>> +		return 0;
>> +	if (console_suspended) {
>> +		up_console_sem();
>> +		return 0;
>> +	}
>> +	pause_all_consoles();
>
> This is weird. Any trylock function should be fast and non-blocking.
> But pause_all_consoles() uses mutex_lock().
>
> My expectation would be that console_trylock_sched() behaves
> excatly the same as console_trylock() except that it will
> set console_may_schedule by the given parameter.
>
> I would do it the other way. Rename console_trylock() and
> implement:
>
> int console_trylock(void)
> {
> 	return console_trylock_sched(false);
> }
>
> LATER: I got it. It is used by console_trylock_sched() called
>        in console_unlock() when "do_cond_resched == true". In this
>        case, the trylock might wait for the mutexes. It will prevent
>        transfering console_lock from schedulable to atomic context
>        by the check in console_emit_next_record().

Yes!

>        Hmm, I would still prefer to keep console_trylock_sched()
>        behavior sane: non-blocking in all situations. It means
>        that we actually do not need it and console_trylock()
>        is enough.
>
>        It will allow to steal console_lock() from schedulable
>        context. But it is not a regression. And it is only
>        a corner case when console_unlock() re-takes the semaphore
>        after releasing it.

A console waiter must not wait on a schedulable context. The console
waiter is burning the CPU waiting for a transfer. If the console owner
gets scheduled away while still holding the console lock, that is bad.

>        We could do the same optimization in console_unlock() by
>        calling console_emit_next_record() with NULL handover pointer
>        when do_cond_resched == true. But we should do it
>        as a separate patch later.

It is not an optimization, it is needed. Passing a NULL handover pointer
when do_cond_resched == true would handle it correctly, but this feels
like a workaround to me.

The reason for adding console_trylock_sched() is because a context that
previously acquired the console lock via console_lock() wants to try to
reacquire it. If it reacquires the console lock using the kthread
mutexes, the locking scenario returns to the same as it was
before... all kthreads are blocked via their mutex.

You are suggesting that a console_lock() context later tries to
reacquire the console lock, but using the console_trylock() method
(atomic counter) and keeping console_may_schedule=1.

IMHO, _this_ is a weird variant that requires passing in a NULL handover
pointer as a workaround. It introduces a third locking scenario where a
schedulable context is using functions created for atomic use.

Also, as I mentioned in the percpu thread [0], I think we need to avoid
console_trylock() usage in schedulable contexts. Functions need to be
aware in what contexts they are running and call the appropriate
functions for it.

>> @@ -2856,6 +2957,10 @@ void console_unblank(void)
>>  	if (oops_in_progress) {
>>  		if (down_trylock_console_sem() != 0)
>>  			return;
>> +		if (!console_excl_trylock()) {
>> +			up_console_sem();
>> +			return;
>> +		}
>
> It would be better to use
>
>  	if (oops_in_progress) {
> 		if (!console_trylock())
> 			return;
>

Well that is slightly different. It would mean that @console_suspended
is now also considered. I will investigate if that matters, but
currently it is not considered.

John

[0] https://lore.kernel.org/lkml/87mti22i20.fsf@jogness.linutronix.de
