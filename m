Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E5F4C2AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiBXLcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiBXLcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:32:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46B411C2F;
        Thu, 24 Feb 2022 03:31:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73A2061812;
        Thu, 24 Feb 2022 11:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FD5C340F3;
        Thu, 24 Feb 2022 11:31:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LnJmC6vN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645702294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lQ8C2UM5kyWPBT9HlFb+4NHlK8JKwzfCB1RyzbTjjEs=;
        b=LnJmC6vNb8R5x+ZmM5D3IE/Iwe8kv9fly4feTqFCFCIvVMQD7zOguBS0OmuD9ph/jthpzx
        81YwpTkDc+EipkqVnexkOk7BUu4jtBxj0yvQmaNNc0fWQNzugDviAia0YUh391rhpmDerK
        OxQ3DuwhJiUnJwBAJ85/OqYDp4y0ufc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e870f476 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Feb 2022 11:31:34 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id j12so3132243ybh.8;
        Thu, 24 Feb 2022 03:31:34 -0800 (PST)
X-Gm-Message-State: AOAM530Ej2Y31QfkQccclbSpVFhRjn3vwgJgSzIv64684FlBmmLhqzn6
        U98m6ngJ7Ci2jK5EZb23mdZeQ6N3mM9tR+fHnyg=
X-Google-Smtp-Source: ABdhPJwkEZ4g3wejsfvSMRKpHrjCpRBmssQHgsE9ab4R1a+vjI7JS5xtzIyvKnzwLO/7RYhFCS/tVMH+tXZ70c50tzQ=
X-Received: by 2002:a25:b905:0:b0:61e:23e4:949f with SMTP id
 x5-20020a25b905000000b0061e23e4949fmr1983476ybj.373.1645702292830; Thu, 24
 Feb 2022 03:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20220223185511.628452-1-Jason@zx2c4.com>
In-Reply-To: <20220223185511.628452-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 24 Feb 2022 12:31:22 +0100
X-Gmail-Original-Message-ID: <CAHmME9pMUx_dgo-1SFkD6x4ua4Lgf+d_59v0F6VXGK=UXuD=mA@mail.gmail.com>
Message-ID: <CAHmME9pMUx_dgo-1SFkD6x4ua4Lgf+d_59v0F6VXGK=UXuD=mA@mail.gmail.com>
Subject: Re: [PATCH] random: do crng pre-init loading in worker rather than irq
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>
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

CC +Eric

On Wed, Feb 23, 2022 at 7:55 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Taking spinlocks from IRQ context is problematic for PREEMPT_RT. That
> is, in part, why we take trylocks instead. But apparently this still
> trips up various lock dependency analyzers. That seems like a bug in the
> analyzers that should be fixed, rather than having to change things
> here.
>
> But maybe there's another reason to change things up: by deferring the
> crng pre-init loading to the worker, we can use the cryptographic hash
> function rather than xor, which is perhaps a meaningful difference when
> considering this data has only been through the relatively weak
> fast_mix() function.
>
> The biggest downside of this approach is that the pre-init loading is
> now deferred until later, which means things that need random numbers
> after interrupts are enabled, but before workqueues are running -- or
> before this particular worker manages to run -- are going to get into
> trouble. Hopefully in the real world, this window is rather small,
> especially since this code won't run until 64 interrupts had occurred.
>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 62 ++++++++++++-------------------------------
>  1 file changed, 17 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 536237a0f073..9fb06fc298d3 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -443,10 +443,6 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
>   * boot time when it's better to have something there rather than
>   * nothing.
>   *
> - * There are two paths, a slow one and a fast one. The slow one
> - * hashes the input along with the current key. The fast one simply
> - * xors it in, and should only be used from interrupt context.
> - *
>   * If account is set, then the crng_init_cnt counter is incremented.
>   * This shouldn't be set by functions like add_device_randomness(),
>   * where we can't trust the buffer passed to it is guaranteed to be
> @@ -455,19 +451,15 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
>   * Returns the number of bytes processed from input, which is bounded
>   * by CRNG_INIT_CNT_THRESH if account is true.
>   */
> -static size_t crng_pre_init_inject(const void *input, size_t len,
> -                                  bool fast, bool account)
> +static size_t crng_pre_init_inject(const void *input, size_t len, bool account)
>  {
>         static int crng_init_cnt = 0;
> +       struct blake2s_state hash;
>         unsigned long flags;
>
> -       if (fast) {
> -               if (!spin_trylock_irqsave(&base_crng.lock, flags))
> -                       return 0;
> -       } else {
> -               spin_lock_irqsave(&base_crng.lock, flags);
> -       }
> +       blake2s_init(&hash, sizeof(base_crng.key));
>
> +       spin_lock_irqsave(&base_crng.lock, flags);
>         if (crng_init != 0) {
>                 spin_unlock_irqrestore(&base_crng.lock, flags);
>                 return 0;
> @@ -476,21 +468,9 @@ static size_t crng_pre_init_inject(const void *input, size_t len,
>         if (account)
>                 len = min_t(size_t, len, CRNG_INIT_CNT_THRESH - crng_init_cnt);
>
> -       if (fast) {
> -               const u8 *src = input;
> -               size_t i;
> -
> -               for (i = 0; i < len; ++i)
> -                       base_crng.key[(crng_init_cnt + i) %
> -                                     sizeof(base_crng.key)] ^= src[i];
> -       } else {
> -               struct blake2s_state hash;
> -
> -               blake2s_init(&hash, sizeof(base_crng.key));
> -               blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
> -               blake2s_update(&hash, input, len);
> -               blake2s_final(&hash, base_crng.key);
> -       }
> +       blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
> +       blake2s_update(&hash, input, len);
> +       blake2s_final(&hash, base_crng.key);
>
>         if (account) {
>                 crng_init_cnt += len;
> @@ -1040,7 +1020,7 @@ void add_device_randomness(const void *buf, size_t size)
>         unsigned long flags;
>
>         if (crng_init == 0 && size)
> -               crng_pre_init_inject(buf, size, false, false);
> +               crng_pre_init_inject(buf, size, false);
>
>         spin_lock_irqsave(&input_pool.lock, flags);
>         _mix_pool_bytes(buf, size);
> @@ -1157,7 +1137,7 @@ void add_hwgenerator_randomness(const void *buffer, size_t count,
>                                 size_t entropy)
>  {
>         if (unlikely(crng_init == 0)) {
> -               size_t ret = crng_pre_init_inject(buffer, count, false, true);
> +               size_t ret = crng_pre_init_inject(buffer, count, true);
>                 mix_pool_bytes(buffer, ret);
>                 count -= ret;
>                 buffer += ret;
> @@ -1298,7 +1278,12 @@ static void mix_interrupt_randomness(struct work_struct *work)
>         local_irq_enable();
>
>         mix_pool_bytes(pool, sizeof(pool));
> -       credit_entropy_bits(1);
> +
> +       if (unlikely(crng_init == 0))
> +               crng_pre_init_inject(pool, sizeof(pool), true);
> +       else
> +               credit_entropy_bits(1);
> +
>         memzero_explicit(pool, sizeof(pool));
>  }
>
> @@ -1331,24 +1316,11 @@ void add_interrupt_randomness(int irq)
>         fast_mix(fast_pool->pool32);
>         new_count = ++fast_pool->count;
>
> -       if (unlikely(crng_init == 0)) {
> -               if (new_count >= 64 &&
> -                   crng_pre_init_inject(fast_pool->pool32, sizeof(fast_pool->pool32),
> -                                        true, true) > 0) {
> -                       fast_pool->count = 0;
> -                       fast_pool->last = now;
> -                       if (spin_trylock(&input_pool.lock)) {
> -                               _mix_pool_bytes(&fast_pool->pool32, sizeof(fast_pool->pool32));
> -                               spin_unlock(&input_pool.lock);
> -                       }
> -               }
> -               return;
> -       }
> -
>         if (new_count & MIX_INFLIGHT)
>                 return;
>
> -       if (new_count < 64 && !time_after(now, fast_pool->last + HZ))
> +       if (new_count < 64 && (!time_after(now, fast_pool->last + HZ) ||
> +                              unlikely(crng_init == 0)))
>                 return;
>
>         if (unlikely(!fast_pool->mix.func))
> --
> 2.35.1
>

FYI, I think you were concerned about those trylocks too. This should
make that go away.

Jason
