Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634A549FE99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350411AbiA1RCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:02:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44348 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350398AbiA1RCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:02:38 -0500
Date:   Fri, 28 Jan 2022 18:02:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643389357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6B/QL3zGvAqYCZbyxVnMq+IjoMyfzI0aBUO5B432cA=;
        b=kQe9RNdvpVldsKvVJQUPyldTqWefmeGNFNs0oMM4rfnYbq18Tjedq0fMY6RyaYNCznNxG/
        uQoKeKQlHv+6hYhzfp9UVST1q6DeKRz4MlZdJ5HZXjwZEfrHGMa/ME+KGbQ28vFC+JqAQ+
        Ujgd/aTATzlxeWjKDnntFdLdgygLt7dDt+t0fxw8bscilScnOnmhTM7nFk0SVxHK/NXKNH
        0mh3RK16cUI3If3yD+asyObkoBklbP1qjecEtGJYrVCZqXKWy/soU7qlcNemKm0LiEHfHb
        qyLK2/F6tJz7X92mZITrixH4aCSzdxUXlgDgjwQbpdoLo7ZD2OVaoaduHeNxWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643389357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6B/QL3zGvAqYCZbyxVnMq+IjoMyfzI0aBUO5B432cA=;
        b=C61544Uiu8Ilho88QpjO0x2krd7AbuYZTdxzUOa0zaOMz8ipb3qIjfySpOLGKjaW/dao0a
        +wtfHenuhXqVq5DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: "BUG: Invalid wait context" in invalidate_batched_entropy
Message-ID: <YfQhrA6P15KQTsrS@linutronix.de>
References: <YfMa0QgsjCVdRAvJ@latitude>
 <CAHmME9pb9A4SN6TTjNvvxKqw1L3gXVOX7KKihfEH4AgKGNGZ2A@mail.gmail.com>
 <YfOqsOiNfURyvFRX@linutronix.de>
 <CAHmME9qBj2gL=spp3AUEo-Ri4r0KQq-KrR-f6dG++xXQvzcA7A@mail.gmail.com>
 <YfQXgaAyBBEYSspV@linutronix.de>
 <CAHmME9qhdRbFT26beStH3JYLiE0mpAZz-jp1jJsJdJNZKFpbvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9qhdRbFT26beStH3JYLiE0mpAZz-jp1jJsJdJNZKFpbvA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-28 17:28:47 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> Gotcha. Surely, then, Andy's patch at least goes some of the way
> toward fixing this, since it outright _removes_ a spinlock_t. There is
> still the other spinlock_t that you want removed, I realize, though
> this doesn't appear to be the one from Jonathan's bug report. It
> sounds like Andy's patch might be one side of the fix, and your patch
> the other?

Only if we want to keep that lock a raw_spinlock_t. And this change
extends your IRQ-off region. Before I was only worried about that one
lock and all the callers. Now we have a little more possibilities.

From looking at get_random_u32(), the whole worst case includes the
whole of extract_crng(). So we have the possible call chain
crng_reseed() -> crng_finalize_init() and here we have
wake_up_interruptible() and kill_fasync() which both can't be called
with disabled interrupts.

> Jason

Sebastian
