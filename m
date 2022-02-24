Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1654D4C2F09
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiBXPMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiBXPMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:12:20 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D77E5BC;
        Thu, 24 Feb 2022 07:11:48 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 3C4C920140A;
        Thu, 24 Feb 2022 15:11:46 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 931B0801A3; Thu, 24 Feb 2022 16:11:16 +0100 (CET)
Date:   Thu, 24 Feb 2022 16:11:16 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        bigeasy@linutronix.de, Sultan Alsawaf <sultan@kerneltoast.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: do crng pre-init loading in worker rather than
 irq
Message-ID: <YhegFNGbcgpILo2r@owl.dominikbrodowski.net>
References: <20220223185511.628452-1-Jason@zx2c4.com>
 <Yhc4LwK3biZFIqwQ@owl.dominikbrodowski.net>
 <CAHmME9oesPzz4ofe-wo_ZViM=uahL6WQo8-5ov7xjJN8ui1rsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oesPzz4ofe-wo_ZViM=uahL6WQo8-5ov7xjJN8ui1rsg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Feb 24, 2022 at 10:49:12AM +0100 schrieb Jason A. Donenfeld:
> On 2/24/22, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > Am Wed, Feb 23, 2022 at 07:55:11PM +0100 schrieb Jason A. Donenfeld:
> >> Taking spinlocks from IRQ context is problematic for PREEMPT_RT. That
> >> is, in part, why we take trylocks instead. But apparently this still
> >> trips up various lock dependency analyzers. That seems like a bug in the
> >> analyzers that should be fixed, rather than having to change things
> >> here.
> >>
> >> But maybe there's another reason to change things up: by deferring the
> >> crng pre-init loading to the worker, we can use the cryptographic hash
> >> function rather than xor, which is perhaps a meaningful difference when
> >> considering this data has only been through the relatively weak
> >> fast_mix() function.
> >>
> >> The biggest downside of this approach is that the pre-init loading is
> >> now deferred until later, which means things that need random numbers
> >> after interrupts are enabled, but before workqueues are running -- or
> >> before this particular worker manages to run -- are going to get into
> >> trouble. Hopefully in the real world, this window is rather small,
> >> especially since this code won't run until 64 interrupts had occurred.
> >>
> >> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> >> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Theodore Ts'o <tytso@mit.edu>
> >> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >> ---
> >>  drivers/char/random.c | 62 ++++++++++++-------------------------------
> >>  1 file changed, 17 insertions(+), 45 deletions(-)
> >>
> >> diff --git a/drivers/char/random.c b/drivers/char/random.c
> >> index 536237a0f073..9fb06fc298d3 100644
> >> --- a/drivers/char/random.c
> >> +++ b/drivers/char/random.c
> >> @@ -1298,7 +1278,12 @@ static void mix_interrupt_randomness(struct
> >> work_struct *work)
> >>  	local_irq_enable();
> >>
> >>  	mix_pool_bytes(pool, sizeof(pool));
> >> -	credit_entropy_bits(1);
> >> +
> >> +	if (unlikely(crng_init == 0))
> >> +		crng_pre_init_inject(pool, sizeof(pool), true);
> >> +	else
> >> +		credit_entropy_bits(1);
> >> +
> >>  	memzero_explicit(pool, sizeof(pool));
> >>  }
> >
> > Might it make sense to call crng_pre_init_inject() before mix_pool_bytes?
> 
> What exactly is the difference you see mattering in the order? I keep
> chasing my tail trying to think about it.

We had that order beforehand -- and even if it probably doesn't matter, this
means crng_pre_init_inject() gets called a tiny bit earlier. That means
there's a chance to progres to crng_init=1 a tiny bit earlier as well.

Thanks,
	Dominik
