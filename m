Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD0758D1AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbiHIBS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiHIBSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:18:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980DCE39
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:18:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660007901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=8SQSH8TTiuVOugw6acnW6qYCETJqOYR4qoLYJgkrRjI=;
        b=aW7D/2wUUsGYDV5EWxVgdAOKzyEcuYQGzJd61kIsSWQHwGs68+cn7weco1CZLcFo+yL84m
        hcsXy7MQPxV+Hag3TjovwPKDaYIkboBn0We1OkNpsxvG+TnFJzpUGFjHiA6xEonDUgC4uF
        cJ6DsqDe2vr7J3isMb5IwPRDZ00e1COnumj3VWrUKfJVAj19y4ogGY/ThKKCAaLBeyPL/u
        5/4FHL8dUNTG2xc5HADzi3f+PzhuD3NenEKtxpTAYU8W1O4+xkuqcOZPfSWHwo1guLSzVi
        FhuB1Ny5TkAXcVcrF5CcFWtUhd3R6ye6Eo7MOJnkM1wnv/SZpzW2MDyNdzBI7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660007901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=8SQSH8TTiuVOugw6acnW6qYCETJqOYR4qoLYJgkrRjI=;
        b=E3AR0NvryMHNCcgBMyYHf0AsU7BZC8w2lpi7W995pyh9lfkpLs4WNrcAJmzOHsPys5nSBu
        215spmB1rCcdtGAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>,
        Mel Gorman <mgorman@suse.com>
Subject: Re: [GIT PULL] printk for 5.20
In-Reply-To: <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
Date:   Tue, 09 Aug 2022 03:18:20 +0200
Message-ID: <87r11qp63n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Tue, Aug 02 2022 at 20:19, Linus Torvalds wrote:
> On Mon, Aug 1, 2022 at 8:08 AM Petr Mladek <pmladek@suse.com> wrote:
>>
>> - Completely disable printing on consoles with CONFIG_RT.
> And guys, I want to make it really clear how disappointed I am with
> the printk tree lately. There seems to be some kind of hardline
> religious fervor having taken over to make these kinds of "this is how
> it has to be done, screw any sanity or common sense".
...
> Put another way: not only am I not pulling this, I'm concerned that I
> will not be pulling printk patches in the future either because of
> where these pull requests seem to be trending.

I really have to stand up for the printk maintainers here.

Especially Petr has done an extraordinary job in the past few years.
There have been hickups, but with such a semantically ill defined
mechanism like printk() that's not a surprise at all.

Let me add some historical background here.

In Sept. 2019, i.e. almost 3 years ago, we all - including you - sat
together at Plumbers in Lisbon and agreed that printk() in it's back
then form is a nightmare not only for PREEMPT_RT. We also agreed back
then that seperating out the console writes into individual printk
threads makes sense because it also gets rid of the fully serializing
nature of printk() which exists for historical but not for technical
reasons. Also the magic oops_in_progress heuristics have been declared
to be just duct tape, as the still existing (after 25+ years of Linux)
situation with graphics demonstrates on a daily basis. We all agreed
that a dedicated atomic_write() which also allows to prioritize your
favourite pet pieve of making laptops more debugable by utilizing
persistant storage simpler and what's more important more reliable.

It took whopping 2.5 years to get to the point to reach this seperation
as it required to rewrite the buffers and other infrastructure. This was
very responsible and cautionosly guided by Petr and the other members of
the printk() maintainer team. Along with that went quite some
improvements like realistic timestamping and other details which matter
for dmesg power users.

The printk threads were added in the 5.19 merge window and unfortunately
reverted between 5.19-rc3 and 5.19-rc4 for the very wrong reason:

   Some embedded boards failed to boot.

     The root cause is missing locking in the init functions of the
     related UART drivers.

     This is not a problem of threaded printk(), Those are existing bugs
     in these drivers which can be triggered on a 5.18 kernel. They are
     hard to trigger and nobody cared so far because they were neither
     bisectable nor reliably reproducible. The threaded printk() change
     made them reproducible and the bisect pointed at the messenger and
     not at the root cause.

Nevertheless it was decided to throw away valuable work for no real good
reason. That revert costs me constantly ~2 seconds of boot time on one my
main development machines. Not much, but ~10% and I know that quite some
folks in the fastboot camp give a leg for 10%.

The right decision would have been to offer this by boot or config
parameter and not to throw the baby out with the bathwater.

I know it's my fault because I was AFK that week...

Coming back to the commit in question which made you (rightfully) upset.

I agree that it should never have happened, but OTOH it's a very clear
message of developer frustration to you:

On one hand you can't get tired of "praising" the RT people about their
responsible approach to solve fundamental shortcomigs in the kernel, but
at the same time you're pulling whatever new fancy "technology" which
comes around the corner and then makes my and your inbox full of
security issues. That's obviously not a problem, right?

Neither is it a problem that all of these "feature" developers can
rightfully ignore PREEMPT_RT and offload all the resulting problems to
the RT people, right?

I might be wrong, but you seem to have a fundamental misunderstanding of
the scope and importance of PREEEMPT_RT:

>  Oh, I agree that it probably is a pretty small community.

Pull the rug under that "pretty small community" and the industrial
world is comming to a grinding halt. That grinding halt will affect your
power grid, your water supply and quite some other essential things
which are listed under Civil Infrastructure. Plus the new fangled edge
computing, modern cars ....

There is a reason that at least some major industry players have
invested into the RT project for the last couple of years. All major
distro players have commercially supported RT offerings for years and
they are surely not doing this just for fun.

There are freeriders as always. Space*, car*, distro* ,,,,

> And I also think that people who are really into RT are basically
> always going to have extra patches anyway - I think the bulk of the
> core stuff has made it upstream, but not *all* has made it.

At the point of this writing the only outstanding issue is printk, which
prevents PREEMPT_RT from being enabled in your tree on x86[64] and
ARM[64].

This still does not justify the commit in question, but clearly points
out that there is an attitude problem.

Which attitude problem?

   The attitude problem that PREEMPT_RT is just a niche, but the larger
   kernel community is happy to consume the benefits of that allegded
   niche without giving anything back.

Think about that.

Thanks,

        Thomas
