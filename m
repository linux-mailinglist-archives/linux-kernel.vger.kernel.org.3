Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B665549C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245628AbiFMSvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242766AbiFMSvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:51:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD006EF043
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40B05B81058
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA20C34114;
        Mon, 13 Jun 2022 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655135506;
        bh=bvv8Ks9vTHqLMQ4ZJjX3WpyJc2ifEuumLm+pu7oKAoA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pktU8Iim+NWim2sM6J1BclqFSN3G2pwgtG/kxoohXvSVhm3prnb3qcMdjV7J5o2YZ
         MVuFwiQF3Jjf7Yan+HCRL76T/pluQteHXHkjFatT25i7U6r8lbqZo/BNFuCKFotOFh
         bJfeqaVjmhaBFVUP7u0XqenJkfFup00Olk64XN9QG34UYzV6uGqikks09AmDu5ykB+
         WZsJTqLezQAKMtexQQfUVihDEVVAclFZcJTV6d+G0l07P+3Aeq8OnY3L6VMwxf5cYM
         +l5w4Kwyi+k5ab2kzOXW5t43/SdWao/95vCFWNPf+pg1DIyvBOKwMnfGCba2mIbpUr
         4fMk8VLzOzn3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 88EF05C0510; Mon, 13 Jun 2022 08:51:45 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:51:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, frederic@kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] 8e274732115f ("printk: extend console_lock for per-console
 locking")
Message-ID: <20220613155145.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
 <87v8t5l39z.fsf@jogness.linutronix.de>
 <20220613042937.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
 <87tu8pgcj0.fsf@jogness.linutronix.de>
 <YqcSJyTnuRVAPmLI@alley>
 <YqdSw/fJvnkRbjvc@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqdSw/fJvnkRbjvc@alley>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 05:07:47PM +0200, Petr Mladek wrote:
> On Mon 2022-06-13 12:32:08, Petr Mladek wrote:
> > On Mon 2022-06-13 11:10:19, John Ogness wrote:
> > > On 2022-06-12, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > >> As I suspected, the final printk's cannot direct print because the
> > > >> kthread was printing. Using the below patch did seem to address your
> > > >> problem. But this is probably not the way forward.
> > > >
> > > > When I apply it, I still lose output, perhaps due to different timing?
> > > > Doing the pr_flush(1000, true) just before the call to kernel_power_off()
> > > > has been working quite well thus far, though.
> > > 
> > > @Petr, I like the idea of the kthreads getting out of the way rather
> > > than trying to direct print themselves (for this situation). It still
> > > isn't optimal because that final pr_emerg("Power down\n") might come
> > > before the kthread has finished its current line. But in that case the
> > > kthread may not have much a chance to finish the printing anyway.
> > 
> > I wonder if we could somehow combine it with pr_flush(timeout).
> > 
> > The kthread might bail-out when pr_flush() is running. It will
> > know that someone would continue printing. The timeout might
> > help to avoid a deadlock. We could somehow reuse
> > console_trylock_spinning() code here.
> > > 
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index ea3dd55709e7..45c6c2b0b104 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -3729,7 +3729,9 @@ static bool printer_should_wake(struct console *con, u64 seq)
> > >  		return true;
> > >  
> > >  	if (con->blocked ||
> > > -	    console_kthreads_atomically_blocked()) {
> > > +	    console_kthreads_atomically_blocked() ||
> > > +	    system_state > SYSTEM_RUNNING ||
> > > +	    oops_in_progress) {
> > >  		return false;
> > >  	}
> > 
> > Also this is an interesting idea. We know that panic() will try
> > to flush the messages. Well, panic() is not always called
> > after Oops.
> 
> I tried to combine the various approaches and findings into
> the following patch.
> 
> It introduces try_block_console_kthread() function. It tries
> to summon console_lock() so that it is later available for
> printk().
> 
> The function causes that console kthreads will not longer
> handle the messages. Also it waits until all kthreads leave
> the critical section and allow to take the global console lock.
> 
> It can be safely called in atomic context because it uses
> busy wait by udelay(). Infinite waiting is prevented by
> timeout currectly hardcoded to 10s.
> 
> The function is used in panic() and kernel_shutdown_prepare()
> when we know that the system is going down and kthreads will
> not be usable any longer.
> 
> 
> Problems:
> 
>   + Just the best effort.
>   + Does not help on single CPU system.
> 
> 
> Testing:
> 
> I tried Paul's RCU torture test few times. It always failed without
> this patch and always succeded with this patch. If I got the resutls
> corretly.
> 
> 
> Possible improvements and alternative approaches:
> 
>    + Prevent console kthreads from sleeping in critical
>      section. Replace mutex with a spinlock?
> 
>    + Allow to steal con->lock similar way like the global
>      console_sem.
> 
>    + Modify console kthreads process priority to make them
>      scheduled immediately on another CPU.
> 
> 
> What do you think, please?

And rcutorture thinks well of this one, also.  ;-)

Thank you both!!!

							Thanx, Paul

> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 10ec29bc0135..78f27ca15922 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -173,6 +173,7 @@ extern void printk_prefer_direct_enter(void);
>  extern void printk_prefer_direct_exit(void);
>  
>  extern bool pr_flush(int timeout_ms, bool reset_on_progress);
> +extern void try_block_console_kthreads(int timeout_ms);
>  
>  /*
>   * Please don't use printk_ratelimit(), because it shares ratelimiting state
> diff --git a/kernel/panic.c b/kernel/panic.c
> index a3c758dba15a..4cf13c37bd08 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -297,6 +297,7 @@ void panic(const char *fmt, ...)
>  		 * unfortunately means it may not be hardened to work in a
>  		 * panic situation.
>  		 */
> +		try_block_console_kthreads(10000);
>  		smp_send_stop();
>  	} else {
>  		/*
> @@ -304,6 +305,7 @@ void panic(const char *fmt, ...)
>  		 * kmsg_dump, we will need architecture dependent extra
>  		 * works in addition to stopping other CPUs.
>  		 */
> +		try_block_console_kthreads(10000);
>  		crash_smp_send_stop();
>  	}
>  
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ea3dd55709e7..0bcd4f5cf2fc 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -250,6 +250,8 @@ static atomic_t console_kthreads_active = ATOMIC_INIT(0);
>  #define console_kthread_printing_exit() \
>  	atomic_dec(&console_kthreads_active)
>  
> +static bool block_console_kthreads;
> +
>  /*
>   * Helper macros to handle lockdep when locking/unlocking console_sem. We use
>   * macros instead of functions so that _RET_IP_ contains useful information.
> @@ -3686,6 +3688,24 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
>  }
>  EXPORT_SYMBOL(pr_flush);
>  
> +void try_block_console_kthreads(int timeout_ms)
> +{
> +	block_console_kthreads = true;
> +
> +	while (timeout_ms > 0) {
> +		if (console_trylock()) {
> +			console_unlock();
> +			return;
> +		}
> +
> +		udelay(1000);
> +		timeout_ms -= 1;
> +	}
> +
> +	/* Failed to block console kthreads. Let them do the job. */
> +	block_console_kthreads = false;
> +}
> +
>  static void __printk_fallback_preferred_direct(void)
>  {
>  	printk_prefer_direct_enter();
> @@ -3729,7 +3749,8 @@ static bool printer_should_wake(struct console *con, u64 seq)
>  		return true;
>  
>  	if (con->blocked ||
> -	    console_kthreads_atomically_blocked()) {
> +	    console_kthreads_atomically_blocked() ||
> +	    block_console_kthreads) {
>  		return false;
>  	}
>  
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index a091145ee710..222bdd076cd0 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -270,6 +270,7 @@ static void kernel_shutdown_prepare(enum system_states state)
>  	blocking_notifier_call_chain(&reboot_notifier_list,
>  		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
>  	system_state = state;
> +	try_block_console_kthreads(10000);
>  	usermodehelper_disable();
>  	device_shutdown();
>  }
