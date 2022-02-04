Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443084A9A8B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359200AbiBDOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359191AbiBDOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:01:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E662CC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 06:01:51 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:01:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643983308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8cIGjn05QsEEMpX1hWJ4gweSqMP6J0Ol5xFJI7nf6G0=;
        b=4eMm03kdF74+Hh+eCMctgQ6JuKMFSYPVYw1iMSdejyEoS2mRIj+r7T5D/VtyBl8JHc06LC
        RsBLpn5IFPIH1WkNUPx2oypHC4auggrP1KSpH7A+ggCvDZEeLXoE/q4+JU2OLkXx/88+ye
        qX8vvGdVAOiAGW9Tvnh0mM0yBvPShT3CexvEmt1MrrKkCRI2NurWJH3YWOxbcYYHAvXxNn
        jbo5xJ6OnK5UsJpqlw5KwkENfnGgTZXE5TVhoL8ynh9KVasq5QEV43mPcyMEh32DVolTrJ
        GNmwVRfL1Y7eYxSqCTgGJ+LWsdJvuzRhkDUO3lbfICy14jCgwusO7mm+YzYTHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643983308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8cIGjn05QsEEMpX1hWJ4gweSqMP6J0Ol5xFJI7nf6G0=;
        b=HS8bgltX7XitUeIHMvlw0MRbnLBRulW0ng4hZGa6Ftx+TwAOkR2XwtUPB7t5ekKJYfFfPa
        bJWvl+u1bzxRFRAg==
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
Message-ID: <Yf0xy4kZ2Mn65yp8@linutronix.de>
References: <CAHmME9pe2BEJV4WiZNHmDmH_XK621Qqr1JCBdgTNZmr4JGBA4w@mail.gmail.com>
 <20220128223548.97807-1-Jason@zx2c4.com>
 <CAHmME9qtjZX2kVNSQqUsTrZv1cdR8y6n3yZS-RnpVCCzX9okcA@mail.gmail.com>
 <Yf0JlXf3ARsBpL9K@linutronix.de>
 <CAHmME9r0XxX3LqNLpVeqAjDQ_OVskPf15QOwxtZYy0tb_x_7HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9r0XxX3LqNLpVeqAjDQ_OVskPf15QOwxtZYy0tb_x_7HQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-04 14:42:03 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> Please calm down a bit: this patch doesn't minimize the importance of
> working out a real solution for PREEMPT_RT, and I'm not under the
> illusion that this one here is the silver bullet. It does, however,
> have other merits, which may or may not have anything to do with
> PREEMPT_RT. To reiterate: I am taking your PREEMPT_RT concerns
> seriously, and I want to come up with a solution to that, which we're
> working toward more broadly in that other thread.
> 
> Per your feedback on v1, this is no longer marked for stable and no
> longer purports to fix the PREEMPT_RT issues entirely. Actually, a
> large motivation for this includes the reason why Andy's original
> patch was laying around in the first place: we're trying to make this
> code faster.

The commit in tree you cited is b43db859a36cb553102c9c80431fc44618703bda.
It does not mention anything regarding faster nor the performance
improvement and conditions (hoth path, etc). It still has a stable tag.

> I can improve the commit message a bit though.
> 
> On Fri, Feb 4, 2022 at 12:10 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > - This splat only occurs with CONFIG_PROVE_RAW_LOCK_NESTING enabled.
> 
> Right, the commit message for v2 mentions that.
> 
> > - The problem identified by the splat affects only PREEMPT_RT. Non-RT is
> >   not affected by this.
> 
> Right.
> 
> >
> > - This patch disables interrupts and invokes extract_crng() which leads
> >   to other problems.
> 
> The existing code, which uses a spinlock, also disables interrupts,
> right? So this isn't actually regressing in that regard. It just
> doesn't fix your PREEMPT_RT issue, right?

The existing code uses spin_lock_irqsave() which do not disable on
PREEMPT_RT. The local_irq_save() on the hand does.

> Or is the issue you see that spinlock_t is a mutex on PREEMPT_RT, so
> we're disabling interrupts here in a way that we _weren't_ originally,
> in a PREEMPT_RT context? If that's the case, then I think I see your
> objection.

Exactly.
 
> I wonder if it'd be enough here to disable preemption instead? But
> then we run into trouble if this is called from an interrupt.

Disabling preemption does not allow to acquire sleeping locks so no win.

> Maybe it'd be best to retain the spinlock_t, which will amount to
> disabling interrupts on !PREEMPT_RT, since it'll never be contended,
> but will turn into a mutex on PREEMPT_RT, where it'll do the right
> thing from an exclusivity perspective. Would this be reasonable?

what does retain the spinlock_t mean since we already have a spinlock_t?

> Andy? Any suggestions?
> 
> Jason

Sebastian
