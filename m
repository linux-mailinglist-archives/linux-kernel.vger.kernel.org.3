Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9634B673B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiBOJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:13:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiBOJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:13:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E177826116
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:13:34 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8CDDF210ED;
        Tue, 15 Feb 2022 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644916413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uz6OzIcAWv/Rk6HPbiTNN5tr/kjnVKiKcw2IYCxjeZY=;
        b=rksepW39RKomXVeHwIr18y6mLptyKzSvdKVupxC3M42ZN8kt1Ao6PG9dVFSc3HU0IsBhmF
        h0UIqZX4gBfWIa6s3PAxM6OuD+RSzVQH0DwRCdZW6R74C0u4vvKQ235XBVLNebKhXp5CQR
        4u2YE9oheUux4D3zXqKv++apjnamh3c=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 38BC8A3B81;
        Tue, 15 Feb 2022 09:13:33 +0000 (UTC)
Date:   Tue, 15 Feb 2022 10:13:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH printk v1 01/13] printk: rename cpulock functions
Message-ID: <YgtuvC5rqfSsAIWW@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-2-john.ogness@linutronix.de>
 <YgZaMkUU5Ve2GV9D@alley>
 <87fsopcvnj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsopcvnj.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-02-11 15:48:08, John Ogness wrote:
> On 2022-02-11, Petr Mladek <pmladek@suse.com> wrote:
> > On Mon 2022-02-07 20:49:11, John Ogness wrote:
> >> Since the printk cpulock is CPU-reentrant and since it is used
> >> in all contexts, its usage must be carefully considered and
> >> most likely will require programming locklessly. To avoid
> >> mistaking the printk cpulock as a typical lock, rename it to
> >> cpu_sync. The main functions then become:
> >> 
> >>     printk_cpu_sync_get_irqsave(flags);
> >>     printk_cpu_sync_put_irqrestore(flags);
> >
> > It is possible that I will understand the motivation later when
> > reading the entire patchset. But my initial reaction is confusion ;-)
> 
> Actually, the motivation comes from a discussion we had during the RT
> Track at Plumbers 2021 [0]. It isn't a lock and so we didn't want to
> call it a lock. (More below.)

Thanks for the link. I have listened to the discussion. And I am still not
persuaded ;-)


> > From mo POV, it is a lock. It tries to get exclusive access and
> > has to wait until the current owner releases it.
> 
> It is only exclusive for a CPU. If another context on that CPU tries to
> get the "lock" it will succeed. For example:
> 
> process context lock() -> success
> --- INTERRUPT ---
> irq context lock() -> success
> --- NMI ---
> nmi context lock() -> success
> 
> None of these contexts can assume that they have synchronized access
> because clearly they have all interrupted each other. If an object does
> not provide synchronized access to data, then "lock" is probably not a
> good name for that object.

All _nested_ locks have these limits. In fact, _all_ locks have these
limits. This is why it is common to take many locks (chain of locks)
if you really want to serialize some things. This is why there are
ABBA problems.


> > As you say: "its usage must be carefully considered and most likely
> > will  require programming locklessly." I guess that it is related to:
> >
> >     + There is a risk of deadlocks that are typically associated with
> >       locks. After all the word "lock" is part of "deadlock".
> >
> >     + It requires lockless programming because it is supposed to be
> >       terminal lock. It means that no other locks should be taken
> >       under it.
> 
> It is because (as in the example above), taking this "lock" does not
> provide synchronization to data. It is only synchronizing between
> CPUs. It was Steven's suggestion to call the thing a cpu_sync object and
> nobody in the RT Track seemed to disagree.

IMHO, the main task of this API is to synchronize CPUs. It is normal that
a lock does not protect all objects that are accessed under the lock.


> > I have get() and put() associated with reference counting. But it has
> > an opposite meaning. It usually guards an object from freeing as long
> > as there is at least one user. And it allows to have many users.
> 
> This _is_ reference counting. In fact, if you look at the implementation
> you see:
> 
>     atomic_inc(&printk_cpu_sync_nested);
> 
> It is allowing multiple users (from the same CPU).

Yes. My point is that reference counting prevents releasing of an
object. It does not prevent parallel access. The parallel access
is prevented by locks.

From my POV, the main task of this API is to prevent parallel
printing from other CPUs. Even Steven Rostedt wrote in the chat
"This makes it a lock" see the recording[0] around the time 2:46:14.


> > Regarding the reentrancy. It seems that "_nested" suffix is used for
> > this type of locks, for example, mutex_lock_nested(),
> > spin_lock_nested().
> >
> > It might be enough to add "_nested" suffix and explain why it has
> > to be used carefully (terminal lock) in a comment.
> 
> The internal counter is called "_nested" to make it clear to us printk
> developers. IMO the common _get and _put semantics are appropriate
> here. The important thing is that the word "lock" is removed. It is not
> a lock.

Why is it so important to get rid of the word "lock", please?

Well, I probably understand it. The API must be used carefully.
This whole discussion is about how to make the risks more obvious.

My main fear are deadlocks caused when someone tries to get this
"cpu_sync" thing. This is why I would like to call it a lock.

I guess that you are more concerned about races between different
contexts when implementing atomic consoles. This is why you prefer
to avoid the word "lock".

OK, this discussion helped me to improve my mental model about
this API. So, the name is getting less important for me. I would
still slightly prefer to keep "lock". But I am fine with the renaming
to "put/get".

[0] https://youtu.be/cZUzc0U1jJ4?t=12946

Best Regards,
Petr
