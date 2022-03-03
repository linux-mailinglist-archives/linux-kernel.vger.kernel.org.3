Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22994CC018
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiCCOhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiCCOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:37:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C418E40A;
        Thu,  3 Mar 2022 06:37:03 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646318221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=EtdZg/6U94OdYMSqhjBiWjZ+bM7DHb05euHX5YcqsEw=;
        b=AlL3t/k/701s9pNkMnd+L5tdXkxLydMGn0JLzYf5bKsg1Nj2gOfqfV9iBoNmrftKGx9lHv
        sRTHi8M3aEF4qw3apyc2cYa9uU25erymkMk3ZREMPaok+8YM/Y6iX4QxwQPddzHGJFINg0
        6SRi/wioYGNimhHOvP1knzVVssiCEBmzW9V9C0eAaUFnOJF53WtqOechyWaGT+tc/URG4j
        n6UJ6dOrEDFQCZqMPuf9PspzQ80ZFxumbcHn7iIBJ+TAwQwikXL8Ka0s07x+ycePn6Ne2Y
        R48U/Bu+CrJVKXWpqBQuPX+uh3k/aTW+u7cMXauve3sXoQ979ji9fDSafQZzMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646318221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=EtdZg/6U94OdYMSqhjBiWjZ+bM7DHb05euHX5YcqsEw=;
        b=ZdzlD/AKeYc47xfcG7CvYfWHaIvxE6h1mxDBZNkADhwmATnk9vIPpnSQl3OsLaWA2elmml
        hZ1HCR5zbRUsJlDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Corey Minyard <cminyard@mvista.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>, Tejun Heo <tj@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v1 09/13] printk: add functions to allow direct
 printing
In-Reply-To: <Yg5FCVF5c1jDo116@alley>
Date:   Thu, 03 Mar 2022 15:43:00 +0106
Message-ID: <8735jz9k6r.fsf@jogness.linutronix.de>
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
> On Mon 2022-02-07 20:49:19, John Ogness wrote:
>> Once kthread printing is introduced, console printing will no longer
>> occur in the context of the printk caller. However, there are some
>> special contexts where it is desirable for the printk caller to
>> directly print out kernel messages. Using pr_flush() to wait for
>> threaded printers is only possible if the caller is in a sleepable
>> context and the kthreads are active. That is not always the case.
>> 
>> Introduce printk_direct_enter() and printk_direct_exit() functions
>> to explicitly (and globally) activate/deactivate direct console
>> printing.
>
> We should make it more clear what direct console printing means.
>
> It is just the best effort to print messages on consoles when
> they are unused at the moment. By other words, it is the legacy
> mode that uses trylock to get access to consoles.

OK, I will clarify that.

>> Activate direct printing for:
>>  - sysrq
>>  - emergency reboot/shutdown
>>  - cpu and rcu stalls
>>  - hard and soft lockups
>>  - hung tasks
>>  - stack dumps
>
> It would be great to mention what rules of thumb were used to choose
> these locations, see below.

OK.

>> --- a/drivers/tty/sysrq.c
>> +++ b/drivers/tty/sysrq.c
>> @@ -594,9 +594,11 @@ void __handle_sysrq(int key, bool check_mask)
>>  		 * should not) and is the invoked operation enabled?
>>  		 */
>>  		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
>> +			printk_direct_enter();
>>  			pr_info("%s\n", op_p->action_msg);
>>  			console_loglevel = orig_log_level;
>>  			op_p->handler(key);
>> +			printk_direct_exit();
>>  		} else {
>>  			pr_info("This sysrq operation is disabled.\n");
>>  			console_loglevel = orig_log_level;
>
> We should handle all messages the same way, including "This sysrq operation
> is disabled" and "HELP:" section. @suppress_printk is disabled
> for all these messages as well.

OK.

>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3333,9 +3359,15 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
>>  	int pending = __this_cpu_xchg(printk_pending, 0);
>>  
>>  	if (pending & PRINTK_PENDING_OUTPUT) {
>> +		if (pending & PRINTK_DIRECT_OUTPUT)
>> +			printk_direct_enter();
>> +
>>  		/* If trylock fails, someone else is doing the printing */
>>  		if (console_trylock())
>>  			console_unlock();
>> +
>> +		if (pending & PRINTK_DIRECT_OUTPUT)
>> +			printk_direct_exit();
>>  	}
>
> I want to be sure that we are on the same page.
>
> This is a good example where the direct output is used in a
> non-preemtive context. It means that it might cause soft or
> live-lockups. And it might break RT guarantees.

The idea here is that somewhere something was supposed to be direct
printed, but the printing was deferred to irq_work. Then probably it
should be direct printed here.

Also note that I implemented it incorrectly. Really
wake_up_klogd_work_func() should have been changed to:

static void wake_up_klogd_work_func(struct irq_work *irq_work)
{
        int pending = __this_cpu_xchg(printk_pending, 0);

        if (pending & PRINTK_PENDING_OUTPUT &&
            pending & PRINTK_DIRECT_OUTPUT) {
                /* If trylock fails, someone else is doing the printing */
                if (console_trylock())
                        console_unlock();
        }

        if (pending & PRINTK_PENDING_WAKEUP)
                wake_up_interruptible(&log_wait);
}

For v2 I will _not_ create a new PRINTK_DIRECT_OUTPUT flag value nor
will I modify wake_up_klogd_work_func(). Instead I will modify
defer_console_output() like this:

@@ -3256,11 +3659,16 @@ void wake_up_klogd(void)
 
 void defer_console_output(void)
 {
+	int val = PRINTK_PENDING_WAKEUP;
+
 	if (!printk_percpu_data_ready())
 		return;
 
+	if (atomic_read(&printk_direct))
+		val |= PRINTK_PENDING_OUTPUT;
+
 	preempt_disable();
-	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
+	__this_cpu_or(printk_pending, val);
 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	preempt_enable();
 }

So PRINTK_PENDING_WAKEUP will always be sent and PRINTK_PENDING_OUTPUT
will be used for direct output.

> It might be worth it when the system already is in big troubles
> and RT guarantees are already broken. This might be true for:
>
>     + emergency reboot/shutdown
>
> We probably should use it also when @suppress_printk is already
> disabled:
>
>     + sysrq
>
> But I am not sure about situations where only a particular process
> or CPU is in troubles:
>
>     + cpu and rcu stalls
>     + hard and soft lockups
>     + hung tasks
>     + "generic" stack dumps
>
> The risks:
>
> On one hand, I like that it is a conservative approach. It reduces
> the risk of bad user experience with switching to printk kthreads.
>
> On the other hand, it means that the problem with soft/live-lockups
> will still be there. Also the direct output is global and affects
> any messages. It means that we will still need to keep and maintain
> printk_deferred() for scheduler, NMI, console drivers, ...

The reason I was so conservative is because we do not yet have atomic
consoles. Right now direct printing is the only way to achieve some
reliability. I am concerned that putting too much on the threads now
might cause some bad taste for users and put the kthread approach at
risk. All the above scenarios are things that should not occur on a
normally functioning system.

> My preferences:
>
> I prefer to do the changes proposed by this patch (with updated sysrq
> handling) in the 1st stage. It is more conservative. The switch to
> kthreads in most other situations will be big enough step.

Agreed.

> But I think that we might go even further in the future. After all,
> the plan was to use the direct printing only when the system is about
> to die. This might eventually allow to remove printk_deferred()
> and all the possible soft/live-lockups.

Yes. Reliability will come from the planned atomic consoles. For systems
that will have atomic consoles available, direct printing should be safe
from all contexts. For systems without atomic consoles, we may need to
keep the "legacy" direct printing alive.

John
