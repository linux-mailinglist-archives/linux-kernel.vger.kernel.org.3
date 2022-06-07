Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3551953FCC8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbiFGLC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242454AbiFGLAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22A337A32
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43DD7B81F02
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FABC34115
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654599394;
        bh=NKzuHbkieQxLoWjyC1x/EN9NN+GQBUg1WX2wv6pDfL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mJQLwNsHZlQHm3kZn3CiBIGshtEJ4sMbydDNYYfGqdLAJwSUppmmSveQYV+6BWxuo
         PcWS9h7x7D/qsF0FEhd8tWoJqe21nXhZe0FcUue12BV7S4h+7UpRdHhhUOJRpD6Byc
         eSWN6Irh2Az8+6D6I6Tspm6386q3I0Mzv948rLBtrWAYRwNBrr4nLmGD+BHzBXT9Ah
         VVn+z3f0KVN/wChKeIfZyW779umDe4KfsvYpD8loIDxnKEZb9rxqH1GaA27GQyud4c
         98Kb6sX+n3n0W6uT1bp3yNVj5hlPmyS014L85rpgb/8rxCrV5zNM8N9wj3UeS9mNnq
         TfTFRjt61COzg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-fdfe64231dso235390fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:56:34 -0700 (PDT)
X-Gm-Message-State: AOAM532TINJNzDEK7LrMHpXuZA2HsKTyssEFuz3YFf4mfW6mudAIUfe5
        XkzJ5D1m5GRxVdATabMFrRqxzUIQQKgAJEIrTgU=
X-Google-Smtp-Source: ABdhPJxhYGdGLx2yHSyMyGxBsWpnSLuLp5S3Cd5eUQSa1FMAKtjD0WGuvymfVc1RLRcZHETjPDQyKen+Rk/IFcqTrOk=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr16121139oan.126.1654599394092; Tue, 07
 Jun 2022 03:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220607100210.683136-1-Jason@zx2c4.com> <CAMj1kXEAuh-tokcqvKCQF5Vq+jZKj4ZM=PyGaHKapXPJKVyOrg@mail.gmail.com>
 <Yp8oOH+9V336LrLk@zx2c4.com> <Yp8rcFrqK/IkzKXj@zx2c4.com>
In-Reply-To: <Yp8rcFrqK/IkzKXj@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Jun 2022 12:56:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHV833uMJYrdUagJpH5hoj4ivC6zxMJvNnxLAF2NG3_sg@mail.gmail.com>
Message-ID: <CAMj1kXHV833uMJYrdUagJpH5hoj4ivC6zxMJvNnxLAF2NG3_sg@mail.gmail.com>
Subject: Re: [PATCH] random: do not use jump labels before they are initialized
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 at 12:42, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey again,
>
> On Tue, Jun 07, 2022 at 12:28:08PM +0200, Jason A. Donenfeld wrote:
> > Hi Ard,
> >
> > On Tue, Jun 07, 2022 at 12:13:29PM +0200, Ard Biesheuvel wrote:
> > > Hi Jason,
> > >
> > > On Tue, 7 Jun 2022 at 12:04, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > [ I would like to pursue fixing this more directly first before actually
> > > >   merging this, but I thought I'd send this to the list now anyway as a
> > > >   the "backup" plan. If I can't figure out how to make headway on the
> > > >   main plan in the next few days, it'll be easy to just do this. ]
> > > >
> > >
> > > What more direct fix did you have in mind here?
> >
> > A non-broken version of https://lore.kernel.org/lkml/20220603121543.360283-1-Jason@zx2c4.com/
> >
> > As I mentioned in https://lore.kernel.org/lkml/Yp8kQrBgE3WVqqC5@zx2c4.com/ ,
> >
> >     I would like a few days to see if there's some trivial way of not
> >     needing that on arm32. If it turns out to be easy, then I'd prefer the
> >     direct fix akin to the arm64 one. If it turns out to be not easy, then
> >     I'll merge the backup commit.
> >
> > > > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > > > index 4862d4d3ec49..f9a020ec08b9 100644
> > > > --- a/drivers/char/random.c
> > > > +++ b/drivers/char/random.c
> > > > @@ -650,7 +650,8 @@ static void __cold _credit_init_bits(size_t bits)
> > > >
> > > >         if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
> > > >                 crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
> > > > -               execute_in_process_context(crng_set_ready, &set_ready);
> > > > +               if (static_key_initialized)
> > > > +                       execute_in_process_context(crng_set_ready, &set_ready);
> > >
> > > Can we just drop this entirely, and rely on the hunk below to set the
> > > static key? What justifies having two code paths that set the static
> > > key in different ways on different architectures?
> >
> > No, we can't. The hunk below (A) is called from init/main.c some time after
> > jump_label_init(). The hunk above (B) is called whenever we reach the
> > 256-bit mark.
> >
> > The order is (B)(A) on machines that get seeded from efi or device tree.
> > The order is (A)(B) on all other machines, which reach the 256-bit mark
> > at "some point"... could be after a second, a minute, whenever enough
> > estimated entropy has been accounted.
>
> Just thinking about this a bit more, I should note that this is not the
> first problem caused by EFI/DT doing its thing mega early in the boot
> process. Dominik and I fixed up what felt like endless bugs all of
> basically that same form back in January. Before it mostly had to do
> with workqueues not being available yet. Now it has to do with jump
> labels.
>
> So in thinking about how to fix this, the two approaches thus far
> discussed are:
>
> 1. initialize jump labels earlier, e.g. the arm64 patch (and proposed
>    arm32 patch).
> 2. defer the static key enabling until later, e.g. this patch.
>
> As a third, I could just defer doing anything with the bootloader seed
> until random_init(). This might actually be the simplest solution...
> I'll sketch something out. A downside, which might be sort of
> significant, is that a few odd things actually use randomness before
> random_init() is called. So these would miss out on having that seed.
> I'll have to look what exactly to see if we're actually getting anything
> real out of that.
>

This is kind of the point of using a firmware provided seed, i.e.,
that it is available much earlier than anything else.

Could we do this to defer the static key manipulation? That way, the
first call to crng_reseed() that occurs after the static keys API
becomes available will set the static key, and patch itself away at
the same time.

---------->8-------------

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b691b9d59503..fad4e1a043ce 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -110,7 +110,8 @@ EXPORT_SYMBOL(rng_is_initialized);

 static void __cold crng_set_ready(struct work_struct *work)
 {
-       static_branch_enable(&crng_is_ready);
+       if (static_key_initialized)
+               static_branch_enable(&crng_is_ready);
 }

 /* Used by wait_for_random_bytes(), and considered an entropy
collector, below. */
@@ -202,6 +203,7 @@ static void extract_entropy(void *buf, size_t len);
 /* This extracts a new crng key from the input pool. */
 static void crng_reseed(void)
 {
+       static struct execute_work set_ready;
        unsigned long flags;
        unsigned long next_gen;
        u8 key[CHACHA_KEY_SIZE];
@@ -221,8 +223,10 @@ static void crng_reseed(void)
                ++next_gen;
        WRITE_ONCE(base_crng.generation, next_gen);
        WRITE_ONCE(base_crng.birth, jiffies);
-       if (!static_branch_likely(&crng_is_ready))
+       if (!static_branch_likely(&crng_is_ready)) {
+               execute_in_process_context(crng_set_ready, &set_ready);
                crng_init = CRNG_READY;
+       }
        spin_unlock_irqrestore(&base_crng.lock, flags);
        memzero_explicit(key, sizeof(key));
 }
@@ -634,7 +638,6 @@ static void extract_entropy(void *buf, size_t len)

 static void __cold _credit_init_bits(size_t bits)
 {
-       static struct execute_work set_ready;
        unsigned int new, orig, add;
        unsigned long flags;

@@ -650,7 +653,6 @@ static void __cold _credit_init_bits(size_t bits)

        if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
                crng_reseed(); /* Sets crng_init to CRNG_READY under
base_crng.lock. */
-               execute_in_process_context(crng_set_ready, &set_ready);
                wake_up_interruptible(&crng_init_wait);
                kill_fasync(&fasync, SIGIO, POLL_IN);
                pr_notice("crng init done\n");
