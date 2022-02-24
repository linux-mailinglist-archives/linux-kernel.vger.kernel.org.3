Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFA04C2F33
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiBXPQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiBXPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:16:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A490F19F453;
        Thu, 24 Feb 2022 07:15:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AD67B825CF;
        Thu, 24 Feb 2022 15:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1D2C340F1;
        Thu, 24 Feb 2022 15:15:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="opWrzKXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645715740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AYMmFtYfxtYduaRQdFoVBaC1AjUunzPzlgwL3Kxqsls=;
        b=opWrzKXjMwy02iJhploX6UhEv5WuCraJD5l6hd0TMcYDdiV+FvO3dIt+2uzTglkGSn23og
        D4Ewt4xLV1hZkBR0WIZxGWsLU97itaW8TL6q4t15thUSJVkNc7vGQUF+arKa9RiFadZY6L
        n0D1vtGSgnFEavC7QoYVmpsOn+IiFuA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c4fc0267 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Feb 2022 15:15:40 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id e140so106311ybh.9;
        Thu, 24 Feb 2022 07:15:39 -0800 (PST)
X-Gm-Message-State: AOAM530dQO8XnGF+R2fqkP3kLdlsvRjnqLb2/KwOryl4SS7U5w38nBmk
        kPhw4NG9TTP9XyAyw1pSiAFBOaHEqCHtER1SsRg=
X-Google-Smtp-Source: ABdhPJy1mn0IIilUcEGgQDxJCiwrf3zfXxRDcx1LSPxEsXJhIaG/BKMnlLSWcKU4MVe2FRfI24p8IFy156nHWeebWds=
X-Received: by 2002:a25:e204:0:b0:610:cb53:b753 with SMTP id
 h4-20020a25e204000000b00610cb53b753mr2694722ybe.267.1645715739207; Thu, 24
 Feb 2022 07:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20220223185511.628452-1-Jason@zx2c4.com> <Yhc4LwK3biZFIqwQ@owl.dominikbrodowski.net>
 <CAHmME9oesPzz4ofe-wo_ZViM=uahL6WQo8-5ov7xjJN8ui1rsg@mail.gmail.com> <YhegFNGbcgpILo2r@owl.dominikbrodowski.net>
In-Reply-To: <YhegFNGbcgpILo2r@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 24 Feb 2022 16:15:28 +0100
X-Gmail-Original-Message-ID: <CAHmME9pTfwbs9xUJy_jrdPcrhSyVixSXBM==9EuB8v7ufWe9Pw@mail.gmail.com>
Message-ID: <CAHmME9pTfwbs9xUJy_jrdPcrhSyVixSXBM==9EuB8v7ufWe9Pw@mail.gmail.com>
Subject: Re: [PATCH] random: do crng pre-init loading in worker rather than irq
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 4:11 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Am Thu, Feb 24, 2022 at 10:49:12AM +0100 schrieb Jason A. Donenfeld:
> > On 2/24/22, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > > Am Wed, Feb 23, 2022 at 07:55:11PM +0100 schrieb Jason A. Donenfeld:
> > >> Taking spinlocks from IRQ context is problematic for PREEMPT_RT. That
> > >> is, in part, why we take trylocks instead. But apparently this still
> > >> trips up various lock dependency analyzers. That seems like a bug in the
> > >> analyzers that should be fixed, rather than having to change things
> > >> here.
> > >>
> > >> But maybe there's another reason to change things up: by deferring the
> > >> crng pre-init loading to the worker, we can use the cryptographic hash
> > >> function rather than xor, which is perhaps a meaningful difference when
> > >> considering this data has only been through the relatively weak
> > >> fast_mix() function.
> > >>
> > >> The biggest downside of this approach is that the pre-init loading is
> > >> now deferred until later, which means things that need random numbers
> > >> after interrupts are enabled, but before workqueues are running -- or
> > >> before this particular worker manages to run -- are going to get into
> > >> trouble. Hopefully in the real world, this window is rather small,
> > >> especially since this code won't run until 64 interrupts had occurred.
> > >>
> > >> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > >> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > >> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > >> Cc: Theodore Ts'o <tytso@mit.edu>
> > >> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > >> ---
> > >>  drivers/char/random.c | 62 ++++++++++++-------------------------------
> > >>  1 file changed, 17 insertions(+), 45 deletions(-)
> > >>
> > >> diff --git a/drivers/char/random.c b/drivers/char/random.c
> > >> index 536237a0f073..9fb06fc298d3 100644
> > >> --- a/drivers/char/random.c
> > >> +++ b/drivers/char/random.c
> > >> @@ -1298,7 +1278,12 @@ static void mix_interrupt_randomness(struct
> > >> work_struct *work)
> > >>    local_irq_enable();
> > >>
> > >>    mix_pool_bytes(pool, sizeof(pool));
> > >> -  credit_entropy_bits(1);
> > >> +
> > >> +  if (unlikely(crng_init == 0))
> > >> +          crng_pre_init_inject(pool, sizeof(pool), true);
> > >> +  else
> > >> +          credit_entropy_bits(1);
> > >> +
> > >>    memzero_explicit(pool, sizeof(pool));
> > >>  }
> > >
> > > Might it make sense to call crng_pre_init_inject() before mix_pool_bytes?
> >
> > What exactly is the difference you see mattering in the order? I keep
> > chasing my tail trying to think about it.
>
> We had that order beforehand -- and even if it probably doesn't matter, this
> means crng_pre_init_inject() gets called a tiny bit earlier. That means
> there's a chance to progres to crng_init=1 a tiny bit earlier as well.

Alright, I'll send a v2.
