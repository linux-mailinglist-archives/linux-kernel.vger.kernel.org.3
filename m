Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4545B542AC2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiFHJHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiFHJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:05:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB833B60B6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58755B82606
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101F1C341C6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654676675;
        bh=mb7wSkN8jvPB+WAq0VUpI6GigZN7Y0LbxGtiI8+txLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xnsxzz+qUz80qbBBvqQ+QCiV4RqU8h3TGG4nVvp4LCbzKxe6zoYLmXJBLOUQOvnCz
         9KpMrhHVNXZ3/88PXbYvKx+I2OTfOzbs69G5yzIbcwqk/29cYiJLU9yo4MpEYO5Y8P
         FQ+1PGPPyXdQ2OPfl55sH5M3Tcf5PN2+6yaPIhCac0sgFNwek11PaWmSnDBb0EFXlv
         x/fsIYUg8zWQiRqJifZzEPaE7VPeJglyVK7ujgl21SURCAIzNYY9wa3pnoE7YYKFGH
         C35i5Vv4fILkwPyEsKQA68VkM1Np7sxgowlLUrD8pcaCxZZxFaskJXTcAU8oCMXx2t
         LIUgmnipytxfg==
Received: by mail-oi1-f174.google.com with SMTP id s124so9043117oia.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:24:34 -0700 (PDT)
X-Gm-Message-State: AOAM531Dqas4bgKcU7nPMfA+8HodTRI9hsjZ3Kl8N7OkleGOkSy4/Kqq
        dqDHO/iza7Im7gpM/leYLL/JDoRzUAI7EqIKpcw=
X-Google-Smtp-Source: ABdhPJw03BDzzvLonfN/ypOZmks1XwcawN8XKZuO6awjwAHnNx3Lys+ui40b1XzgJzTd1I4qjM1PG7zKththQ/kYyQw=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr1722849oib.126.1654676674178; Wed, 08
 Jun 2022 01:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220607100210.683136-1-Jason@zx2c4.com>
In-Reply-To: <20220607100210.683136-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Jun 2022 10:24:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGxdT=yNNdu8q2dvTZgVuiiZqbZvxnS5pwAp8VgnYh8UQ@mail.gmail.com>
Message-ID: <CAMj1kXGxdT=yNNdu8q2dvTZgVuiiZqbZvxnS5pwAp8VgnYh8UQ@mail.gmail.com>
Subject: Re: [PATCH] random: do not use jump labels before they are initialized
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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

On Tue, 7 Jun 2022 at 12:04, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> [ I would like to pursue fixing this more directly first before actually
>   merging this, but I thought I'd send this to the list now anyway as a
>   the "backup" plan. If I can't figure out how to make headway on the
>   main plan in the next few days, it'll be easy to just do this. ]
>
> Stephen reported that a static key warning splat appears during early
> boot on systems that credit randomness from device trees that contain an
> "rng-seed" property, because because setup_machine_fdt() is called
> before jump_label_init() during setup_arch():
>
>  static_key_enable_cpuslocked(): static key '0xffffffe51c6fcfc0' used before call to jump_label_init()
>  WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:166 static_key_enable_cpuslocked+0xb0/0xb8
>  Modules linked in:
>  CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0+ #224 44b43e377bfc84bc99bb5ab885ff694984ee09ff
>  pstate: 600001c9 (nZCv dAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : static_key_enable_cpuslocked+0xb0/0xb8
>  lr : static_key_enable_cpuslocked+0xb0/0xb8
>  sp : ffffffe51c393cf0
>  x29: ffffffe51c393cf0 x28: 000000008185054c x27: 00000000f1042f10
>  x26: 0000000000000000 x25: 00000000f10302b2 x24: 0000002513200000
>  x23: 0000002513200000 x22: ffffffe51c1c9000 x21: fffffffdfdc00000
>  x20: ffffffe51c2f0831 x19: ffffffe51c6fcfc0 x18: 00000000ffff1020
>  x17: 00000000e1e2ac90 x16: 00000000000000e0 x15: ffffffe51b710708
>  x14: 0000000000000066 x13: 0000000000000018 x12: 0000000000000000
>  x11: 0000000000000000 x10: 00000000ffffffff x9 : 0000000000000000
>  x8 : 0000000000000000 x7 : 61632065726f6665 x6 : 6220646573752027
>  x5 : ffffffe51c641d25 x4 : ffffffe51c13142c x3 : ffff0a00ffffff05
>  x2 : 40000000ffffe003 x1 : 00000000000001c0 x0 : 0000000000000065
>  Call trace:
>   static_key_enable_cpuslocked+0xb0/0xb8
>   static_key_enable+0x2c/0x40
>   crng_set_ready+0x24/0x30
>   execute_in_process_context+0x80/0x90
>   _credit_init_bits+0x100/0x154
>   add_bootloader_randomness+0x64/0x78
>   early_init_dt_scan_chosen+0x140/0x184
>   early_init_dt_scan_nodes+0x28/0x4c
>   early_init_dt_scan+0x40/0x44
>   setup_machine_fdt+0x7c/0x120
>   setup_arch+0x74/0x1d8
>   start_kernel+0x84/0x44c
>   __primary_switched+0xc0/0xc8
>  ---[ end trace 0000000000000000 ]---
>  random: crng init done
>  Machine model: Google Lazor (rev1 - 2) with LTE
>
> A trivial fix went in to address this on arm64, 73e2d827a501 ("arm64:
> Initialize jump labels before setup_machine_fdt()"). But it appears that
> fixing it on other platforms might not be so trivial. Instead, defer the
> setting of the static branch until later in the boot process.
>
> Fixes: f5bda35fba61 ("random: use static branch for crng_ready()")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/char/random.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 4862d4d3ec49..f9a020ec08b9 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -650,7 +650,8 @@ static void __cold _credit_init_bits(size_t bits)
>
>         if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
>                 crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
> -               execute_in_process_context(crng_set_ready, &set_ready);
> +               if (static_key_initialized)
> +                       execute_in_process_context(crng_set_ready, &set_ready);
>                 wake_up_interruptible(&crng_init_wait);
>                 kill_fasync(&fasync, SIGIO, POLL_IN);
>                 pr_notice("crng init done\n");
> @@ -779,6 +780,14 @@ int __init random_init(const char *command_line)
>         unsigned int i, arch_bytes;
>         unsigned long entropy;
>
> +       /*
> +        * If we were initialized by the bootloader before jump labels are
> +        * initialized, then we should enable the static branch here, where
> +        * it's guaranteed that jump labels have been initialized.
> +        */
> +       if (!static_branch_likely(&crng_is_ready) && crng_init >= CRNG_READY)
> +               crng_set_ready(NULL);
> +
>  #if defined(LATENT_ENTROPY_PLUGIN)
>         static const u8 compiletime_seed[BLAKE2S_BLOCK_SIZE] __initconst __latent_entropy;
>         _mix_pool_bytes(compiletime_seed, sizeof(compiletime_seed));
> --
> 2.35.1
>
