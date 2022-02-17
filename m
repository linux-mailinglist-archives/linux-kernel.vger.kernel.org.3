Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204724BA063
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbiBQMwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:52:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiBQMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:52:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A25811177;
        Thu, 17 Feb 2022 04:52:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DDB722198B;
        Thu, 17 Feb 2022 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645102349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tyHPwCNPfq65pA6srXtfqfI8xME48EMpMVy56Z9fhpg=;
        b=NSPTIcx1ySv0mzLL75TzejXYcjjtBLleLqzl3Q9+3taChEadXpWRIvIRJbmoB8nQbRUl2z
        MEEWvG0fvHydt7n+1ddS0ycXFPEgLFuJR7vfiZmSnl+Qc2IHCH6V2uHqbULFD76zwNVWGD
        BsAhfOokdB7Jd16e9SCfekm8cRKIKF4=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DCB07A3B83;
        Thu, 17 Feb 2022 12:52:28 +0000 (UTC)
Date:   Thu, 17 Feb 2022 13:52:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
Message-ID: <Yg5FCVF5c1jDo116@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-10-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:19, John Ogness wrote:
> Once kthread printing is introduced, console printing will no longer
> occur in the context of the printk caller. However, there are some
> special contexts where it is desirable for the printk caller to
> directly print out kernel messages. Using pr_flush() to wait for
> threaded printers is only possible if the caller is in a sleepable
> context and the kthreads are active. That is not always the case.
> 
> Introduce printk_direct_enter() and printk_direct_exit() functions
> to explicitly (and globally) activate/deactivate direct console
> printing.

We should make it more clear what direct console printing means.

It is just the best effort to print messages on consoles when
they are unused at the moment. By other words, it is the legacy
mode that uses trylock to get access to consoles.

> Activate direct printing for:
>  - sysrq
>  - emergency reboot/shutdown
>  - cpu and rcu stalls
>  - hard and soft lockups
>  - hung tasks
>  - stack dumps

It would be great to mention what rules of thumb were used to choose
these locations, see below.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/sysrq.c     |  2 ++
>  include/linux/printk.h  | 11 +++++++++++
>  kernel/hung_task.c      | 11 ++++++++++-
>  kernel/printk/printk.c  | 39 ++++++++++++++++++++++++++++++++++++++-
>  kernel/rcu/tree_stall.h |  2 ++
>  kernel/reboot.c         | 14 +++++++++++++-
>  kernel/watchdog.c       |  4 ++++
>  kernel/watchdog_hld.c   |  4 ++++
>  lib/dump_stack.c        |  2 ++
>  lib/nmi_backtrace.c     |  2 ++
>  10 files changed, 88 insertions(+), 3 deletions(-)
> 
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -594,9 +594,11 @@ void __handle_sysrq(int key, bool check_mask)
>  		 * should not) and is the invoked operation enabled?
>  		 */
>  		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
> +			printk_direct_enter();
>  			pr_info("%s\n", op_p->action_msg);
>  			console_loglevel = orig_log_level;
>  			op_p->handler(key);
> +			printk_direct_exit();
>  		} else {
>  			pr_info("This sysrq operation is disabled.\n");
>  			console_loglevel = orig_log_level;

We should handle all messages the same way, including "This sysrq operation
is disabled" and "HELP:" section. @suppress_printk is disabled
for all these messages as well.


> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3333,9 +3359,15 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
>  	int pending = __this_cpu_xchg(printk_pending, 0);
>  
>  	if (pending & PRINTK_PENDING_OUTPUT) {
> +		if (pending & PRINTK_DIRECT_OUTPUT)
> +			printk_direct_enter();
> +
>  		/* If trylock fails, someone else is doing the printing */
>  		if (console_trylock())
>  			console_unlock();
> +
> +		if (pending & PRINTK_DIRECT_OUTPUT)
> +			printk_direct_exit();
>  	}

I want to be sure that we are on the same page.

This is a good example where the direct output is used in a
non-preemtive context. It means that it might cause soft or
live-lockups. And it might break RT guarantees.

It might be worth it when the system already is in big troubles
and RT guarantees are already broken. This might be true for:

    + emergency reboot/shutdown

We probably should use it also when @suppress_printk is already
disabled:

    + sysrq

But I am not sure about situations where only a particular process
or CPU is in troubles:

    + cpu and rcu stalls
    + hard and soft lockups
    + hung tasks
    + "generic" stack dumps


The risks:

On one hand, I like that it is a conservative approach. It reduces
the risk of bad user experience with switching to printk kthreads.

On the other hand, it means that the problem with soft/live-lockups
will still be there. Also the direct output is global and affects
any messages. It means that we will still need to keep and maintain
printk_deferred() for scheduler, NMI, console drivers, ...


My preferences:

I prefer to do the changes proposed by this patch (with updated sysrq
handling) in the 1st stage. It is more conservative. The switch to
kthreads in most other situations will be big enough step.

But I think that we might go even further in the future. After all,
the plan was to use the direct printing only when the system is about
to die. This might eventually allow to remove printk_deferred()
and all the possible soft/live-lockups.

Best Regards,
Petr
