Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC354F9E12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiDHUMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbiDHUMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:12:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43367E0A4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EDFAB82B9B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 20:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69CEC385A3;
        Fri,  8 Apr 2022 20:10:26 +0000 (UTC)
Date:   Fri, 8 Apr 2022 16:10:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
Message-ID: <20220408161025.5842a663@gandalf.local.home>
In-Reply-To: <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
References: <20220407161745.7d6754b3@gandalf.local.home>
        <87pmlrkgi3.ffs@tglx>
        <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 07:33:53 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> That said, I would actually prefer a name-change: instead of making
> this about "del_timer_free()", can we please just make this about it
> being "final". Or maybe "del_timer_cancel()" or something like that?
> 
> Because the actual _freeing_ will obviously happen later, and the
> function does nothing of the sort. In fact, there may be situations

I was originally thinking of calling it "del_timer_prepare_free()"

> where you don't free it at all, but just want to be in the situation
> where you want to make sure there are no pending timers until after
> you explicitly re-arm it, even if the timer would otherwise be
> self-arming.

We have that already, it's called "del_timer_sync()". And that's not used
when it should be, and does not catch the case of the timer being rearmed.

The idea of "del_timer_free()" or perhaps "del_timer_sync_terminate()?" is
that once called you will NEVER arm it again. And if you do, it's a bug.

> 
> (That use-case would actually mean removing the WARN_ON_ONCE(), but I
> think that would be a "future use" issue, I'm *not* suggesting it not
> be done initially).

The point of this call is to be used when and only when the timer is about
to be freed. Not to just say "wait till it's done". Because we are hitting
a lot of bugs where the system crashes in the timer code while walking
through the link list of timers where one of the pending timers has been
freed, and we have no idea what timer that was.

Once this API is added, I would go around and add it to all locations that
del_timer(_sync) just before freeing it and call this instead. We already
found a few cases that there's a race after the del_timer_sync() that could
actually rearm the timer before it gets freed. This function would trigger
the WARN_ON(_ONCE).

> 
> I also suspect that 99% of all del_timer_sync() users actually want
> that kind of explicit "del_timer_final()" behavior. Some may not
> _need_ it (because their re-arming already checks for "have I shut
> down?"), but I have this suspicion that we could convert a lot - maybe
> all - of the current del_timer_sync() users to this and try to see if
> we could just make it the rule.

We did find places that use del_timer_sync() that would later legitimately
rearm it. But I agree. Most would be del_timer_final() (or whatever).

> 
> And then we could actually maybe start removing the explicit "shut
> down timer" code. See for example "work->canceling" logic for
> kthreads, which now does double duty (it disables re-arming the timer,
> _and_ it does some "double cancel work avoidance")

Yeah, that's the case we have with the hci_qca.c code that we have right
now. It has a timer where it can be rearmed in the work queue, and the
timer can wake the workqueue. This requires one of those dances to be able
to stop both and prevent one from enabling the other.

Hmm, I guess if we do remove the WARN_ON_ONCE(), and just not enable it
after del_timer_terminate/final() is called then it would remove this race.
You could terminate the timers and then destroy the work queue, and if
there's a pending work happening, you do not have to worry about it
rearming the timers, because they would be shut off, and the mod_timer()
would just return without issue.

Maybe add an API to allow both? One that will cause the warn on, as in (if
anything calls this again, warn about it), and the other that has it not
warn, but just be ignored.

We could differentiate between the two by making a stub function for the
ignore one.

On the warn case:

	timer->fn = NULL;

for the non warn case:

 	timer->fn = timer_null();

and have:

	if (WARN_ON_ONCE(!timer->fn) || unlikely(timer->fn == timer_null))
		return;

del_timer_final();	// warn
del_timer_final_sync(); // no warn

  or

del_timer_sync_final(); // warn
del_timer_sync_final_nowarn(); // no warn

??

[ Let the bike-shedding begin! ]


-- Steve


-- Steve
