Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71894B2824
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350974AbiBKOmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:42:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbiBKOmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:42:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E73D197
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:42:10 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644590528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ff3RYO1VL3RaZ7AcuPpsVnkyf0E1pjB74UHdlc8BVqM=;
        b=qP/TypnjhS2OHWxpMChFqOHB0umsV2ngIYjDOkrUpLLpP8w5LmPZnM8bZWvH+aCpUO6zSF
        NJi/fVqki66+zfEORThQQ5gimlW7IxzmcG3/wLkyt34aynJKjd0di6C0lsbfJyPs9cMfsB
        oODdATs1zWk2SmJWfDdxDRCTCOois2WI3nz/+kYsa/NtMa7dX6yU6/VxrT1KI7dy1PKyzB
        TzfxUnshg4uD83ryxz6XP7NhFMSvJjBaJhX/UEx8hrQJ3FR8GonXxpemEL3nYESG3B5zco
        nGdTuIPoQBlMML4ih3JJ1GpUthmoXBNnruuQmvjY0Bq2WYcHAuuG6wfN6rDwWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644590528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ff3RYO1VL3RaZ7AcuPpsVnkyf0E1pjB74UHdlc8BVqM=;
        b=A0IeOTZbh9LBUj9vVXDA8JE32aO06xNMGBg+Pab7tsBHwQ/N0cDgM89UtBuUV9h7B0KtoZ
        MWF6r30qlqpFjYCw==
To:     Petr Mladek <pmladek@suse.com>
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
In-Reply-To: <YgZaMkUU5Ve2GV9D@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-2-john.ogness@linutronix.de>
 <YgZaMkUU5Ve2GV9D@alley>
Date:   Fri, 11 Feb 2022 15:48:08 +0106
Message-ID: <87fsopcvnj.fsf@jogness.linutronix.de>
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

On 2022-02-11, Petr Mladek <pmladek@suse.com> wrote:
> On Mon 2022-02-07 20:49:11, John Ogness wrote:
>> Since the printk cpulock is CPU-reentrant and since it is used
>> in all contexts, its usage must be carefully considered and
>> most likely will require programming locklessly. To avoid
>> mistaking the printk cpulock as a typical lock, rename it to
>> cpu_sync. The main functions then become:
>> 
>>     printk_cpu_sync_get_irqsave(flags);
>>     printk_cpu_sync_put_irqrestore(flags);
>
> It is possible that I will understand the motivation later when
> reading the entire patchset. But my initial reaction is confusion ;-)

Actually, the motivation comes from a discussion we had during the RT
Track at Plumbers 2021 [0]. It isn't a lock and so we didn't want to
call it a lock. (More below.)

> From mo POV, it is a lock. It tries to get exclusive access and
> has to wait until the current owner releases it.

It is only exclusive for a CPU. If another context on that CPU tries to
get the "lock" it will succeed. For example:

process context lock() -> success
--- INTERRUPT ---
irq context lock() -> success
--- NMI ---
nmi context lock() -> success

None of these contexts can assume that they have synchronized access
because clearly they have all interrupted each other. If an object does
not provide synchronized access to data, then "lock" is probably not a
good name for that object.

> As you say: "its usage must be carefully considered and most likely
> will  require programming locklessly." I guess that it is related to:
>
>     + There is a risk of deadlocks that are typically associated with
>       locks. After all the word "lock" is part of "deadlock".
>
>     + It requires lockless programming because it is supposed to be
>       terminal lock. It means that no other locks should be taken
>       under it.

It is because (as in the example above), taking this "lock" does not
provide synchronization to data. It is only synchronizing between
CPUs. It was Steven's suggestion to call the thing a cpu_sync object and
nobody in the RT Track seemed to disagree.

> Is there any other API using this naming scheme, please?

No.

> I have get() and put() associated with reference counting. But it has
> an opposite meaning. It usually guards an object from freeing as long
> as there is at least one user. And it allows to have many users.

This _is_ reference counting. In fact, if you look at the implementation
you see:

    atomic_inc(&printk_cpu_sync_nested);

It is allowing multiple users (from the same CPU).

> Regarding the reentrancy. It seems that "_nested" suffix is used for
> this type of locks, for example, mutex_lock_nested(),
> spin_lock_nested().
>
> It might be enough to add "_nested" suffix and explain why it has
> to be used carefully (terminal lock) in a comment.

The internal counter is called "_nested" to make it clear to us printk
developers. IMO the common _get and _put semantics are appropriate
here. The important thing is that the word "lock" is removed. It is not
a lock.

John

[0] https://youtu.be/cZUzc0U1jJ4?t=12946
