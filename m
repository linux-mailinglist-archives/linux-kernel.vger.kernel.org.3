Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04626509105
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381902AbiDTUFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbiDTUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:05:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB72D3D1F1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:02:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650484960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rw61XOnK2LlAL1QUPDdFwRfFubN8dIiDFdU2t5HEqdU=;
        b=nInXqK97creRW33FYO5D4px1FNlXxfgnGxaYO10HOPPSvgN78g7wdM8QJ4P1AQgpEZRsjN
        WzKBJkSlZbC+sUC1VLG6hK+ZptIJys09gHrXy0ro2i4ieLygMYS1G7FKjTsnqu6bB8afnx
        57OjLL499G3JAt+H2WJ6iAmPGNXzSVW9KoDQYBX6aVbU64E0fRqVyHKapF3yBFvr1SHZ7r
        U0XoRw+eA0kJEyhpaWcBA0Pt0AJ8yvWGr1sXVPqGzXp5D2QNA2YIXCyRx/evk1MMrG4QCW
        AgG8bVrvnJ+ZPooBnzQ3d2ZVyFbvJigZ4KoAUK126R4SjF3bISFFkUQsb2wC1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650484960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rw61XOnK2LlAL1QUPDdFwRfFubN8dIiDFdU2t5HEqdU=;
        b=X+a1EAyYUGP7OvDojvpCwoxupuRcLae0RdErdJ3mbGepcFI18W1jrmI4R1q9t0vh1wlUUM
        tZIuff03eP5fbDCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH printk v3 13/15] printk: add kthread console printers
In-Reply-To: <YmBIr1mkmIN1Zkb+@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-14-john.ogness@linutronix.de>
 <YmBIr1mkmIN1Zkb+@alley>
Date:   Wed, 20 Apr 2022 22:08:39 +0206
Message-ID: <87h76nwmjk.fsf@jogness.linutronix.de>
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

On 2022-04-20, Petr Mladek <pmladek@suse.com> wrote:
> On Wed 2022-04-20 01:52:35, John Ogness wrote:
>> @@ -2280,10 +2295,10 @@ asmlinkage int vprintk_emit(int facility, int level,
>>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
>>  
>>  	/* If called from the scheduler, we can not call up(). */
>> -	if (!in_sched) {
>> +	if (!in_sched && allow_direct_printing()) {
>
> allow_direct_printing() is racy here. But I think that we could live
> with it, see below.

Well, it is not racy for its intended purpose, which is a context that
does:

printk_prefer_direct_enter();
printk();
printk_prefer_direct_exit();

It is only racy for _other_ contexts that might end up direct
printing. But since those other contexts don't have a preference, I see
no problem with it.

>> @@ -3524,7 +3774,16 @@ void defer_console_output(void)
>>  	 * New messages may have been added directly to the ringbuffer
>>  	 * using vprintk_store(), so wake any waiters as well.
>>  	 */
>> -	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
>> +	int val = PRINTK_PENDING_WAKEUP;
>> +
>> +	/*
>> +	 * If console deferring was called with preferred direct printing,
>> +	 * make the irqwork perform the direct printing.
>> +	 */
>> +	if (atomic_read(&printk_prefer_direct))
>> +		val |= PRINTK_PENDING_DIRECT_OUTPUT;
>
> We actually need:
>
> 	/*
> 	 * Make sure that someone will handle the messages when direct
> 	 * printing is allowed. It happens when the kthreads are less
> 	 * reliable or unusable at all.
> 	 */
> 	if (allow_direct_printing())
> 		val |= PRINTK_PENDING_DIRECT_OUTPUT;

Agreed. I will update the comments appropriately as well.

> It is racy. But the same race is also in vprintk_emit().

It is not racy for the intended purpose, so I think it is fine.

> False positive is fine. console_flush_all() will bail out when
> the direct printing gets disabled in the meantime.
>
> False negative is worse. But we will still queue PRINTK_PENDING_WAKEUP
> that will try to wake up the kthreads that should still be around.
>
> And it was always problem even with console_trylock() approach.
> Failure means an expectation that someone else is doing the printing.
> It might be either a kthread or the current console_lock owner.
> But it is never guaranteed because both might be sleeping.

By "sleeping" I guess you mean "scheduled out". The console_lock owner
or mutex/atomic_t holder will be within printing code. And if a kthread
sees new records available, it will continue rather than wait.

> We do our best by calling pr_flush() or console_flush_on_panic()
> on various places. Also PRINTK_PENDING_WAKEUP will always try to wake
> up the kthreads.

Yes.

> Anyway, we should document this somewhere. At least in the commit
> message.
>
> My dream is Documentation/core-api/printk-design.rst but I do not
> want to force you to do it ;-)

I would be happy to contribute to such a document.

John
