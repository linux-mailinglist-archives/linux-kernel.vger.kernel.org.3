Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1F49FDE3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350032AbiA1QTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350009AbiA1QTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:19:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3DC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:19:16 -0800 (PST)
Date:   Fri, 28 Jan 2022 17:19:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643386754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWbLt59QRjjf4mfB+2ZMl5qQv7LD3/z5tyJey6mlcdw=;
        b=N/Pys4MJJNYjFIbO6SBLi4q89mwxDz5yB58cRI3PyqXO/1PgJrrZ0VN6PORfGHQqEMKHIE
        5X+4nJ0yMMogR3u3u0n45ehMCsBA0ytqQZEghAC4lG2pJU+olbghVTMm9nWzc3HQf53Xci
        1yr9NSgWPa0VtZB8Qzr1R0azWN804/22sml0208Csfv0V1UBBXePwUdraHt0TW47aF2yYf
        PFcSgcwi9tZkCbhniy139NBZ8VZ9oiDqNaDQOt5S4ni7B376t+vkHAHSyqKqXIafL66HV5
        8ez+6r0wcg4LijcKYMKDAmSR29F/EfPDmI4nlqJBK4tVs3ovU9anqkfzye4N2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643386754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWbLt59QRjjf4mfB+2ZMl5qQv7LD3/z5tyJey6mlcdw=;
        b=Tn7xOEIVL7am3ZEBGblh9lDGM/RIJl5EO2LPn26MRYq2WT+kCucCK71eDjn0IEP8ZbQf1d
        83FMDTqV7TwYVbAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: "BUG: Invalid wait context" in invalidate_batched_entropy
Message-ID: <YfQXgaAyBBEYSspV@linutronix.de>
References: <YfMa0QgsjCVdRAvJ@latitude>
 <CAHmME9pb9A4SN6TTjNvvxKqw1L3gXVOX7KKihfEH4AgKGNGZ2A@mail.gmail.com>
 <YfOqsOiNfURyvFRX@linutronix.de>
 <CAHmME9qBj2gL=spp3AUEo-Ri4r0KQq-KrR-f6dG++xXQvzcA7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9qBj2gL=spp3AUEo-Ri4r0KQq-KrR-f6dG++xXQvzcA7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-28 17:04:13 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian/Jonathan,
> 
> On Fri, Jan 28, 2022 at 9:35 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > This report is due to CONFIG_PROVE_LOCKING=y _and_
> > CONFIG_PROVE_RAW_LOCK_NESTING=y. It reports a nesting problem
> > (raw_spinlock_t -> spinlock_t lock ordering) which becomes a real
> > problem on PREEMPT_RT.
> 
> Hmm, I'm still having a tough time reproducing this. I'm trying to
> understand your intuition. Is the problem you see that something else
> in the IRQ path uses a raw_spinlock_t, and then with that lock still
> held, we call invalidate_batched_entropy(), which takes an ordinary
> spinlock_t, non-raw? And taking a spinlock-t while holding a
> raw_spinlock_t is illegal?

Correct. You must not acquire a spinlock_t while holding a
raw_spinlock_t. This is because on PREEMPT_RT the spinlock_t is a
sleeping lock while raw_spinlock_t disables preemption/ interrupts and
sleeping is not possible.
	Documentation/locking/locktypes.rst

On non-PREEMPT both lock types (spinlock_t & raw_spinlock_t) behave in
the same way but lockdep can tell them apart with
CONFIG_PROVE_RAW_LOCK_NESTING=y and show code that is problematic on RT.

> Jason

Sebastian
