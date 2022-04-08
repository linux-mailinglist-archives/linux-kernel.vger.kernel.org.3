Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91D84F9E2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiDHUcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiDHUcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:32:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9381CFFF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:30:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649449798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FSsp/Ai8IS4EMVPoIXL9eSaIoSuhbUgToxXTX7vK4OY=;
        b=UTZd9YbwMzUJ3IqOsUVxkkT7n3UzC52oqPZTdeDkrSzaaVV4YfV+WAqZjJMxreXkgtXqac
        e9e0/79aGg8lRZfrAg/aoirhY3c0kEOctMdjmGqfAY6ixd5Be8rc5zDOTnS3g0MR+qZR48
        loBkaoA0J5tuHayrK6diiH9KBIB7IEm6RPjulESkuAoBu2RzJw+nW3w3PvJoN1H2b8IPW4
        swQ+p7XGbTVvvqqa/cuTrv193yhCtC5foCF7e7LgueX2IldeEWvPse2ieFbVXWIkPaDttL
        sFFrrJrF7Cn+IZwD2hVCnpCmjIhANaYH33in7jKl3yhJPPJ7NOJ9GBIJOTYQiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649449798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FSsp/Ai8IS4EMVPoIXL9eSaIoSuhbUgToxXTX7vK4OY=;
        b=INhSwqUtz7+ishyg4N8A/OJryHCUym4jPD4rff7MXIaQGVhrfCHBXyK6LW0DOmGdbwK1ZG
        J0IkO094CrmRUFCQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
In-Reply-To: <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
References: <20220407161745.7d6754b3@gandalf.local.home>
 <87pmlrkgi3.ffs@tglx>
 <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
Date:   Fri, 08 Apr 2022 22:29:58 +0200
Message-ID: <87v8vjiaih.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08 2022 at 07:33, Linus Torvalds wrote:
> On Fri, Apr 8, 2022 at 12:37 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> So this would become:
>>
>> -       BUG_ON(!timer->function);
>> +       if (WARN_ON(!timer->function))
>> +               return -EBROKEN;
>
> Yes. But please make it a WARN_ON_ONCE(), just on basic principles. I
> can't imagine this happening a lot, but at the same time I don't think
> there's any reason _not_ to just always use WARN_ON_ONCE() for these
> kinds of "serious bug, but should never happen" situations.
>
> Because we don't want some "user can trigger this and spam the logs"
> situation either.

Fair enough.

> That said, I would actually prefer a name-change: instead of making
> this about "del_timer_free()", can we please just make this about it
> being "final". Or maybe "del_timer_cancel()" or something like that?

I was anyway thinking to use the timer_* namespace if we want to go for
this.

timer_shutdown() perhaps?

> Because the actual _freeing_ will obviously happen later, and the
> function does nothing of the sort. In fact, there may be situations
> where you don't free it at all, but just want to be in the situation
> where you want to make sure there are no pending timers until after
> you explicitly re-arm it, even if the timer would otherwise be
> self-arming.
> 
> (That use-case would actually mean removing the WARN_ON_ONCE(), but I
> think that would be a "future use" issue, I'm *not* suggesting it not
> be done initially).

Well, you'd have to reinitialize it first before the explicit rearm
because the shutdown cleared the function pointer or if we use a flag
then the flag would prevent arming it again.

> I also suspect that 99% of all del_timer_sync() users actually want
> that kind of explicit "del_timer_final()" behavior. Some may not
> _need_ it (because their re-arming already checks for "have I shut
> down?"), but I have this suspicion that we could convert a lot - maybe
> all - of the current del_timer_sync() users to this and try to see if
> we could just make it the rule.

Hmm. That would mean, that we still check the function pointer for NULL
without warning and just return. That would indeed be a good argument
for not having the warning at all.

But, there is a twist. While most callsites ignore the return value of
mod_timer() there are 39 (about 2%) which actually care. So that needs
some thought. Though code which cares about these details is mostly
networking core code and not the random driver thing. Though there are a
few suspects in drivers too including bluetooth, but the latter is what
started this whole discussion. See below.

> And then we could actually maybe start removing the explicit "shut
> down timer" code. See for example "work->canceling" logic for
> kthreads, which now does double duty (it disables re-arming the timer,
> _and_ it does some "double cancel work avoidance")

This serializes the cancel against _any_ queuing of that work including
the queueing from an already running timer callback which is blocked on
the worker lock. The shutdown thing wont help there I think.

The problem where it could help is shutdown code for timers plus other
entities with circular dependencies. The problem which started this was
some bluetooth thing which has two timers and a workqueue. The timers
can queue work and the workqueue can arm timers....

So well written drivers have a priv->shutdown flag which makes timer
callbacks and workqueue functions aware that a shutdown is in progress
so they can take appropriate action. That's not necessarily trivial and
I've decoded my share of subtle problems in that realm over the years.

The bluetooth thing in question does not fall into that category, it
even just used del_timer() before destroying the work queue.

What a shutdown function would prevent here is UAF, but I'm not entirely
sure whether it will simplify coordinated shutdown and remove the
requirement of a priv->shutdown flag all over the place. It might make
some of the driver muck just get stuck in the shutdown, but that's
definitely an improvement over a potential UAF which happens every blue
moons.

Thanks,

        tglx





