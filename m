Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0083F4C6F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiB1OaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiB1OaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:30:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E3D205E4;
        Mon, 28 Feb 2022 06:29:35 -0800 (PST)
Date:   Mon, 28 Feb 2022 15:29:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646058573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TjAcEow0NSJUp2vQoMMRWwS/iFJm6prkulbh5r924f0=;
        b=ZcNtJQXunGmEL5PSjeClPrP4xsd45gSCe3uBzOoxuYxZ53xgvXFYyZQkBz0Osfh3jpMIJk
        oIkhADqNfyA9wz/7QUZZ0/Ef2S4aO3si7fktSTdOF/5cjCaUU0CYlmZJYxkmlkohzjw68u
        UvKZXiB7fADlfKE8OfCvJ9XisoyqnxMTO3a1uOjHY9Q+7fCJ98Lt/6+2C1ltmaOSv04Mmj
        VGMrgtFd1IlbqFvtWWOGRajtuH2V27laHrwU/ND+QOeyeNtxNV8tcZpfU7JuN6iQHtr4VG
        eC8feetSrqyQh54+rTbMsdtbe99bH++MWfZlT5Ek3zaHqT+x2tClV0nsyu84Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646058573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TjAcEow0NSJUp2vQoMMRWwS/iFJm6prkulbh5r924f0=;
        b=jdmZCXfZTa3ABN0aVUinhLQmqloInp6t9d9YC+Unk/0fAIcJD6M9EpsfjOEeBJMf7tUk19
        x/3oJXhyf8WWdQAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: do crng pre-init loading in worker rather
 than irq
Message-ID: <YhzcTOIQx5EkujXq@linutronix.de>
References: <CAHmME9pTfwbs9xUJy_jrdPcrhSyVixSXBM==9EuB8v7ufWe9Pw@mail.gmail.com>
 <20220224152937.12747-1-Jason@zx2c4.com>
 <YhzWE1NqYQFKeL5B@linutronix.de>
 <CAHmME9r7bRh+CeBh98UMVCFgmeMWHQ=r3b-8odgV0tR45hOTbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9r7bRh+CeBh98UMVCFgmeMWHQ=r3b-8odgV0tR45hOTbw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-28 15:17:19 [+0100], Jason A. Donenfeld wrote:
> Hey Sebastian,
Hi Jason,

> On 2/28/22, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > On 2022-02-24 16:29:37 [+0100], Jason A. Donenfeld wrote:
> >> Taking spinlocks from IRQ context is problematic for PREEMPT_RT. That
> >> is, in part, why we take trylocks instead. But apparently this still
> >> trips up various lock dependency analyzers. That seems like a bug in the
> >> analyzers that should be fixed, rather than having to change things
> >> here.
> >
> > Could you please post a lockdep report so I can take a look?
> 
> I thought the problem with lockdep was stated by you somewhere in this thread?
> https://lore.kernel.org/lkml/YfOqsOiNfURyvFRX@linutronix.de/
> "But even then we need to find a way to move the crng init part
> (crng_fast_load()) out of the hard-IRQ."
> And Jonathan posted two related (?) splats he ran into.
> 
> I may have gotten that all wrong, in which case, I'll just excise that
> part from the commit message. I'm pretty sure you want this patch
> either way, right?

Oh, that report. So yes, I want that patch ;)

In this case the lockdep is right. The thing that it affects only
PREEMPT_RT.
That trylock is not the thing that lockdep complains about but the
spin_lock_irqsave() within invalidate_batched_entropy().

Taking a spinlock_t from IRQ context is problematic for PREEMPT_RT,
correct. A spin_try_lock() is also problematic since another spin_lock()
invocation would PI-boost the wrong task (the spin_try_lock() is invoked
from an IRQ-context so the task on CPU (random task or idle) is not the
actual owner). I'm pointing this out because there was also _another_
problem with try_lock from hard-IRQ context which was fixed in the
meantime.

Would it work for you to update the commit message? Basically I'm fine
with the firs sentence but the remaining part is misleading.

> Jason

Sebastian
