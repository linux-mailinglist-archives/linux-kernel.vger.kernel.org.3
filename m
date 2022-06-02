Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9353B3DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiFBGu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiFBGu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C729B2E3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7A7461771
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B63C3411D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:50:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aNj5wDRx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654152620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2P89j5+o3Rp89iJMGKJmsuc6ZelmP8cli4ajK4rWJs=;
        b=aNj5wDRx4r3EeOZO1vVsnbGgwEjmUae/Ypy+3lN16iy4rz9mg9Pld8AbQAzoRS4xK0b5c6
        MzuHFnmBtUw9L11IRyoL1oo4J54t+zKQOcQFMv3KuTTAj6vTMqqqO+uVxP+95p42zbFQQw
        4cc6KwjmaYCT8MwAX4JyX4xRJPYrxQc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0441acf7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 2 Jun 2022 06:50:20 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id r82so6701631ybc.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:50:19 -0700 (PDT)
X-Gm-Message-State: AOAM532OwiirrQK+Pv4F2cfcvftIofVoMfLKTfcAWpU41fEq0k5k/ntH
        CRn8tGgGg7OwGLWYLsjwZCnjl+x+7Bf7Jv69uSk=
X-Google-Smtp-Source: ABdhPJzxWw5WFqv2Oajsg3PeJKxJk6CaYFbBvzfjTNZwPWBgHdTM/gEtYZRyZNDpjitahKGGQx3Q4mFqNaV2TBtdO9E=
X-Received: by 2002:a25:7901:0:b0:64a:a1d9:43dd with SMTP id
 u1-20020a257901000000b0064aa1d943ddmr3616900ybc.271.1654152618491; Wed, 01
 Jun 2022 23:50:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6403:b0:17b:2ce3:1329 with HTTP; Wed, 1 Jun 2022
 23:50:17 -0700 (PDT)
In-Reply-To: <20220602022109.780348-1-swboyd@chromium.org>
References: <20220602022109.780348-1-swboyd@chromium.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 2 Jun 2022 08:50:17 +0200
X-Gmail-Original-Message-ID: <CAHmME9rRb1x2ke7diS+ghdqhJBQgB2fOjNeaBsNaT9GcAq7DAg@mail.gmail.com>
Message-ID: <CAHmME9rRb1x2ke7diS+ghdqhJBQgB2fOjNeaBsNaT9GcAq7DAg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Initialize jump labels before setup_machine_fdt()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

Hi Stephen,

On 6/2/22, Stephen Boyd <swboyd@chromium.org> wrote:
> A static key warning splat appears during early boot on arm64 systems
> that credit randomness from devicetrees that contain an "rng-seed"
> property. This is because setup_machine_fdt() is called before
> jump_label_init() during setup_arch(). Let's swap the order of these two
> calls so that jump labels are initialized before the devicetree is
> unflattened and the rng seed is credited.
>
>  static_key_enable_cpuslocked(): static key '0xffffffe51c6fcfc0' used before
> call to jump_label_init()
>  WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:166
> static_key_enable_cpuslocked+0xb0/0xb8
>  Modules linked in:
>  CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0+ #224
> 44b43e377bfc84bc99bb5ab885ff694984ee09ff
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
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Fixes: f5bda35fba61 ("random: use static branch for crng_ready()")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Thanks for fixing this.

    Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

In looking at the matter more in depth, it looks like riscv does
things in the right order, but arm32 still does not. AFAICT, it uses
the logic in init/main.c, in which jump_label_init() is called before
setup_arch()->setup_machine_fdt(). Want to submit a patch for arm32?

Jason
