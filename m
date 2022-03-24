Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C796E4E69DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353416AbiCXUdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345637AbiCXUdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:33:42 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641DFB919C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:32:10 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id jo24so4678593qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPpa3n2s06jrZNwoClndZqpU6Ql6z/pMZ90k7O8kwtw=;
        b=LBgAA4kVHMVW6W0JaKBRZX7rlwEbGViZvRV8OFsYjMM5th9XRblEmJiSNQBkSmB0WS
         5TUzk8D97tcT6kq+XhEvQUe4BFIIvMX5noUr+B9O7NOAik7G/13edCgd8NYgAbQlqell
         Nod3lRKd6v48KR+5kI23ZdnwaXK0KKMFjXEoeSE7fn9OmsYACiX4ntuhkLWsrpZZJc8s
         3coHMP/RNCnodilVa4xtG06bZ4R5cU1g4peX0noS3t9b9QEj8az9dxlFYxaDSHhfuIoO
         p9F4ZOCUSJ3EnYgMSI64S0JPF05K+A2agAWk2f9AAsq0Wbc5ny7RXLcsG9KyMsefIfS0
         CyPg==
X-Gm-Message-State: AOAM5326lSexIomngtWu9rleag6G1ErcOYSwLGA081qrr/lmOubNxxNF
        qbNDb3ibRjQgN7cUFKynit+b+UV7Vf64Ng==
X-Google-Smtp-Source: ABdhPJwvyu9FFY04Tokw1ZzJe9j4D8rlTjGft6jDTEIp6oWao3FABVccVm8OTDLSW720iZpkhsFg4w==
X-Received: by 2002:a05:6214:29eb:b0:441:67f7:8192 with SMTP id jv11-20020a05621429eb00b0044167f78192mr6152415qvb.1.1648153929104;
        Thu, 24 Mar 2022 13:32:09 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id j7-20020a375507000000b00663273f16d0sm2117366qkb.61.2022.03.24.13.32.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 13:32:08 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2d07ae0b1c4so63138707b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:32:07 -0700 (PDT)
X-Received: by 2002:a81:5a08:0:b0:2db:d8c6:7e4f with SMTP id
 o8-20020a815a08000000b002dbd8c67e4fmr6778760ywb.256.1648153927622; Thu, 24
 Mar 2022 13:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220324175417.1014562-1-f.fainelli@gmail.com> <20220324175417.1014562-3-f.fainelli@gmail.com>
In-Reply-To: <20220324175417.1014562-3-f.fainelli@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Mar 2022 21:31:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWyDLoOit-VYPzLXxLz6W300xpo_wrqj=Pr9sZSwk_OwQ@mail.gmail.com>
Message-ID: <CAMuHMdWyDLoOit-VYPzLXxLz6W300xpo_wrqj=Pr9sZSwk_OwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Clamp MAX_DMA_ADDRESS to 32-bit
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Thu, Mar 24, 2022 at 6:54 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> MAX_DMA_ADDRESS is a virtual address, therefore it needs to fit within a
> 32-bit unsigned quantity. Platforms defining a DMA zone size in
> their machine descriptor can easily overflow this quantity depending on
> the DMA zone size and/or the PAGE_OFFSET setting.
>
> In most cases this is harmless, however in the case of a
> CONFIG_DEBUG_VIRTUAL enabled, __virt_addr_valid() will be unable to
> return that MAX_DMA_ADDRESS is valid because the value passed to that
> function is an unsigned long which has already overflowed.
>
> Fixes: e377cd8221eb ("ARM: 8640/1: Add support for CONFIG_DEBUG_VIRTUAL")
> Fixes: 2fb3ec5c9503 ("ARM: Replace platform definition of ISA_DMA_THRESHOLD/MAX_DMA_ADDRESS")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

> --- a/arch/arm/include/asm/dma.h
> +++ b/arch/arm/include/asm/dma.h
> @@ -8,10 +8,12 @@
>  #ifndef CONFIG_ZONE_DMA
>  #define MAX_DMA_ADDRESS        0xffffffffUL
>  #else
> +#include <linux/minmax.h>
>  #define MAX_DMA_ADDRESS        ({ \
>         extern phys_addr_t arm_dma_zone_size; \
>         arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \

"arm_dma_zone_size < (0x10000000 - PAGE_OFFSET)" looks
like an overflow-avoiding version of
"PAGE_OFFSET + arm_dma_zone_size < 0x10000000".
However, PAGE_OFFSET is always larger than 0x10000000,
so "0x10000000 - PAGE_OFFSET" is a rather large number?

> -               (PAGE_OFFSET + arm_dma_zone_size - 1) : 0xffffffffUL; })
> +               min_t(phys_addr_t, (PAGE_OFFSET + arm_dma_zone_size - 1), 0xffffffffUL) : \
> +               0xffffffffUL; })
>  #endif
>
>  #ifdef CONFIG_ISA_DMA_API

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
