Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488BF4D8679
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbiCNOJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiCNOJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:09:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E879812633
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 07:08:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 64DFD210FF;
        Mon, 14 Mar 2022 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647266908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAhNsJjFHxV2he/80ReD7Z27tSC68xKgXFO8RfJmFX8=;
        b=Asvmkn89+FVBxXkRaErKv6FmBlQVS6/ykODx0mBR3VxY45WKDGBRde0w95QkNj2swCjvN/
        OzHUJO5JJOcjHX0yvlsyR8TxrgzcHideMdxQ4qsDSAiK7YL1y2gLR9M/dQ1ZO2ncq1m4n7
        179g6X4yoDY1mm7Q2oLwwEa9rFpTENw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A7A1EA3B9A;
        Mon, 14 Mar 2022 14:08:27 +0000 (UTC)
Date:   Mon, 14 Mar 2022 15:08:24 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
Message-ID: <Yi9MWKt+PByLsi6Y@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <YhYKP/UuSKENGwfj@alley>
 <87tuc7xma0.fsf@jogness.linutronix.de>
 <YioMcSe0P0Z7ksiW@alley>
 <87wnh14wp9.fsf@jogness.linutronix.de>
 <Yisj2PEtjZfHMe6N@alley>
 <87czisbotz.fsf@jogness.linutronix.de>
 <Yit2LN1nCaiUo5y4@alley>
 <87tuc4yvsw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuc4yvsw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-03-11 23:27:51, John Ogness wrote:
> Hi Petr,
> 
> I do not think the example below is showing what you think it does, but
> it does shed light on an important point.
> 
> On 2022-03-11, Petr Mladek <pmladek@suse.com> wrote:
> > CPU0			CPU1			CPU2
> >
> > printk()
> >   // direct mode allowed
> 
> OK, so @printk_direct is >= 1.
> 
> >   console_trylock()
> >   console_unlock()
> >     console_flush_all()
> >
> > 			printk_direct_enter()
> 
> @printk_direct is now >= 2.

I am sorry. I made a mistake in the example. I hope that
the following shows what I wanted to show:

CPU0			CPU1			CPU2

			printk_direct_enter()
			  @printk_direct == 1.

printk()
  // direct mode allowed
  console_trylock()
  console_unlock()

			printk_direct_exit()
			  @printk_direct == 0

    console_flush_all()

      allows_direct_printing() -> false;
      break;

      __console_unlock()
        wakeup_klogd()

						// woken printk_ktread
						console_thread_printing_enter()


      console_trylock()
        atomic_tryblock()
	  //fails because thread active

   return;

			printk_direct_enter()
			  @printk_direct == 1

						console_thread_printing_exit()

My expectation: printk_kthread will go into sleep because the system
		is in direct mode. In this case, nobody would be
		scheduled to continue the printing.



> No, the kthread does not sleep. It will continue printing until it is
> blocked via console_lock()/console_trylock() or until all the records
> are printed.

I see. In the patch, the kthread does not check @printk_direct at all.
I have missed this :-(

From my POV, it is a very non-intuitive behavior. But it seems that
you did it intentionally.


> If that is what you mean, then you are suggesting that the
> console_trylock() spins until all the kthreads have finished their
> current record. This could be a new variant of console_trylock().

No, console_trylock() must not wait. My expectation would be
something like:

static bool printer_should_wake(struct console *con, u64 seq)
{
[...]
	/*
	 * Bail out when direct more is requested. Make sure
	 * that someone tries to continue printing in
	 * the direct mode.
	 */
	if (atomic_read(&printk_direct)) {
		defer_console_output();
		return false;
	}
[...]
}

> That is what atomic consoles are for. Until atomic consoles are
> available, that situation is covered by @oops_in_progress and
> console_flush_on_panic().
 
> > This is the race that I see with console_trylock(). IMHO, if we solve
> > this race then we do not need console_lock_reacquire().
> 
> I do not understand why you continue to mix console_trylock() and
> console_lock_reacquire(). console_lock_reacquire() is only for the
> console_lock() context.

Because the code path in console_unlock() is the same for
console_lock() and console_trylock(). I am sorry but I still do
not see any convincing argument why it is so important to handle
the trylock different way according to how it was taken originally.

The result of console_trylock() and console_reackquire() is exactly
the same:

     + console_sem is taken
     + kthreads are blocked by a single value (flag or counter)

My view, is that the console_trylock_reacquire() is a weird
function that is not necessary. If we really need it to avoid
any race then then the logic is too complex and we have to make
it easier. console_trylock() must always be safe to use!

Simple logic:

If the atomic console_trylock() fails it means that someone else is
already printing. It does not matter if it is another console_lock
owner or kthreads.

If console_trylock() is enough in one code path then it should be
enough also in the other.


Also:

If the console lock is released then anything could happen,
especially the kthreads might start printing. I do not see
any point in stopping them again.

They will start working _only_ when the direct mode is _not_
requested. If they did not start working then we could re-take
the lock atomically and we do not need to set CON_DIRECT flag.

My view is that console_kthreads_atomic_tryblock() is a fast
path how to block the kthreads. IMHO, it is perfectly fine
to use it even in console_lock(). The complicated and
sleeping console_kthreads_block() is needed only
when any kthread is printing and we really need to wait.


OK, you wrote:

<John>
The reason for the reacquire is because (during direct printing) we see
that a new record appeared and we need to make sure it gets printed
(because other direct printers may have aborted, expecting us to print
it).
</John>

Let's make sure that we understand it the same way. When are we
expected to print the pending records directly?

   + When console_lock() was used?   My answer is "No".
   + When @printk_direct > 0         My answer is "Yes".



> > Well, I might be wrong. It is Friday evening. I still do not have
> > the entire picture. I probably should have waited for Monday.
> 
> I believe that you sense a danger with direct printing and
> console_trylock(). It allows for scenarios like your example that end up
> relying on kthreads to finish the printing (if there is no
> panic). Mainline already has this issue because console_lock() can also
> be scheduled away and console_trylock() has no chance to print. This
> really is the same issue and ultimately relies on @oops_in_progress and
> console_flush_on_panic() to get the messages out.

Sure.

> I believe you are hinting at the worst-case scenario: a kthread getting
> scheduled out while printing and never seeing a CPU again because the
> system is so busy. Assuming the system does not panic, no printing would
> be seen on that console anymore, even if direct printing is enabled.

We could not do much about this. As you say, it happens already in current
mainline. If the current console_lock owner is sleeping, it might
never release the console lock. The fallback is in
console_flush_panic().

IMHO, it is worse with the kthreads. Any printk kthread might block switching
to the direct mode and printing messages on other consoles. We should
allow switching to the direct mode ASAP. This is why I suggest that
kthreads should check @printk_direct counter and bail out. It is
similar to
https://lore.kernel.org/all/20220202171821.179394-5-stephen.s.brennan@oracle.com/

It makes the logic symmetric and easier:

   + console_lock() and printk_direct_enter() block kthreads.
	The kthreads will bail out on the next record when printing.

   + console_unlock() and printk_direct_exit() allow using kthreads.

   + console_unlock() will stop direct printing when @printk_direct == 0.

   + printk_kthread() will get blocked when @printk_direct > 0

   + vprintk_emit() and console_unlock() will do the same decision
     according to @printk_direct counter. They will either try
     to printk directly or wake up kthreads.

Slightly unrelated:

   + __console_emit_next_record() should allow handover by a parameter
     passed from the caller. Not by guessing from a global state.


> The only solution I see (aside from atomic consoles) is to disable
> preemption during printing. Perhaps for non-atomic consoles, this is
> what we need to do. That, together with a new console_trylock() variant,
> should avoid this concern. Do you agree? Do we want to go that route?
> 
> Disabling preemption would be a problem moving forward for the fbcon
> because, for the future, I really would like fbcon to live in a
> sleepable context. I already have some new ideas about this. But that is
> not a topic for this series.

I though about this as well. But let's keep the preemption enabled in
the kthreads for now. We could always disable it when it causes
problems in the real life.

Best Regards,
Petr

PS: It seems like we are going in circles. My intention is to keep
    the logic as simple and as clear as possible:

       + if we need lock then use lock

       + if we need trylock then use trylock

       + if we want direct mode then block kthreads and try enter
	 the direct mode ASAP.

       + if kthreads mode is allowed then do nothing in
	 console_unlock() and leave the job to kthreads.

       + console_lock() temporarily blocks kthreads but
	 it handle messages only when direct mode is enforced.
