Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3124A9AF9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359305AbiBDOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiBDOas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:30:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC3EC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 06:30:48 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:30:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643985046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jSEnkoWzdxHyyoV71J8PkXILWbNnu9fJrQ2PwEZGfk8=;
        b=Vd8lTU4TFi/KP97bzf7o0+Yr5B0Wz9jGm+86ku+F+HaShW0II2BivN0rkvEifiBCUg8OWx
        X63phdfES5sxYbcCq7VNkq2+l2G7K2+g6qbnsBqS7fReECltU+3hlalHTJRnCEJQan2nMd
        zlZdvbWxuWGXZfvr7VhsF1iNN2BT5CuEEgUCthe48BWH5hayI+ZWe95GRLm0ajC74Rt3oW
        LQJOl2L65DU7s5ZTYZwMTl3xhIyMCqJRy7VKrWSQPJeVGsD+V9MVIIprsKwWgR5bBe78Qi
        B63AI9PdpvvJdoph4VnGGUzlzttELR30RZEba1GxhwALzEWGN803EIGd423FHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643985046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jSEnkoWzdxHyyoV71J8PkXILWbNnu9fJrQ2PwEZGfk8=;
        b=LBJsw5FqrBUPV5M3NGSg4727JzQnCWwA0UA+xT1IMO+BRp+Es+xAEcx1LmtjQE6otiwkO+
        UECew99aV7XCzhAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] random: remove batched entropy locking
Message-ID: <Yf04lcQIatnGspAb@linutronix.de>
References: <CAHmME9pe2BEJV4WiZNHmDmH_XK621Qqr1JCBdgTNZmr4JGBA4w@mail.gmail.com>
 <20220128223548.97807-1-Jason@zx2c4.com>
 <CAHmME9qtjZX2kVNSQqUsTrZv1cdR8y6n3yZS-RnpVCCzX9okcA@mail.gmail.com>
 <Yf0JlXf3ARsBpL9K@linutronix.de>
 <CAHmME9r0XxX3LqNLpVeqAjDQ_OVskPf15QOwxtZYy0tb_x_7HQ@mail.gmail.com>
 <Yf0xy4kZ2Mn65yp8@linutronix.de>
 <CAHmME9oOMhRVybTgHXT+oOXhMkdx7FVY7oSc-rHr=6AvZCVo=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9oOMhRVybTgHXT+oOXhMkdx7FVY7oSc-rHr=6AvZCVo=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-04 15:11:34 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> On Fri, Feb 4, 2022 at 3:02 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > The commit in tree you cited is b43db859a36cb553102c9c80431fc44618703bda.
> > It does not mention anything regarding faster nor the performance
> > improvement and conditions (hoth path, etc). It still has a stable tag.
> 
> It dropped the Cc: stable@. It still has the Fixes:. I can get rid of
> the Fixes: too. I'll improve that message a bunch for a potential v3.

Either you argue for bug fixing or performance improvement and I made it
clear that it is not bug fixing. That Fixes: tag is enough for Greg to
backport it.

> > > Maybe it'd be best to retain the spinlock_t, which will amount to
> > > disabling interrupts on !PREEMPT_RT, since it'll never be contended,
> > > but will turn into a mutex on PREEMPT_RT, where it'll do the right
> > > thing from an exclusivity perspective. Would this be reasonable?
> >
> > what does retain the spinlock_t mean since we already have a spinlock_t?
> 
> The idea would be to keep using spinlock_t like we do now -- no change
> there -- but move to using this atomic generation counter so that
> there's never any contention. Actually, though, I worry that that
> approach would throw out the gains we're getting by chucking the
> spinlock in the first place.

It is a per-CPU spinlock_t so there should be no contention if there is
no cross-CPU access. The overhead are two atomic operations.

> What if we keep a spinlock_t there on PREEMPT_RT but stick with
> disabling interrupts on !PREEMPT_RT? I wish there was a solution or an
> API that amounted to the same thing so there wouldn't need to be an
> #ifdef, but I don't know what that'd be.

If it is still to much try to look for locallock_t and
local_lock_irqsave(). This is kind of like your local_irq_save() but
you have lockdep annotations and PREEMPT_RT has a spinlock_t like
behaviour. It also documents in-code what the scope of your locking is.

> Jason

Sebastian
