Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF55692CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiGFTox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiGFTow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:44:52 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B9CE10
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:44:51 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id i11so19775303qtr.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xk9jCiZm2Js85fOqnIyfJ1E/QY9zrE8vBax6/mtwBTY=;
        b=K6RLQ2ZXMkrMqtdRQQoj1wZA99YoTs5ZvXoXJX5yWeRpJdHyT+388bFQtwXjqgTVj9
         WRSukJS1Rp/u2Y6W1xEo1X90ZGjq8Ue2DADZL1QhEUAWKykXxgRbta647sOMxU2FatkC
         1XVWQLkHVpV+9W3xwu9uneqe33t+OW+ODyHezF/no73UU75ByC++H3FhyDkKIiSdr+A4
         9TBLPao1IA5BH+gpauFsWEXOt004U/tGwsu9fREp/qdYHt+qG9RSdwEASStHGrdECT0k
         BJCeED51H6eRC6ryAxJ2lb78syq8bwQUEQAL9or2YhiI/l5frTpy+vBEndvOqZw8AG0K
         0HIg==
X-Gm-Message-State: AJIora/s02VgwpgiZeLwVoffgNAmXNlpP4ZPl85a19yTZmC0L8UbaJ5a
        gUcDGJhh+AKrd3IzjGGWkM2+pet56gFegHKo
X-Google-Smtp-Source: AGRyM1s0g+gaJcMjbzWj/h4nMdVSFvE3MYDpLf/AEBuCkOucShO9FoHZpXx7LdUYcm+FxeoGEwD0gg==
X-Received: by 2002:a05:622a:138b:b0:31e:8086:a31a with SMTP id o11-20020a05622a138b00b0031e8086a31amr11175354qtk.320.1657136689989;
        Wed, 06 Jul 2022 12:44:49 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id bp13-20020a05620a458d00b006af10bd3635sm24954604qkb.57.2022.07.06.12.44.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 12:44:49 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31c86fe1dddso103016077b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:44:49 -0700 (PDT)
X-Received: by 2002:a81:1090:0:b0:31c:9be5:6c95 with SMTP id
 138-20020a811090000000b0031c9be56c95mr19613587ywq.384.1657136688673; Wed, 06
 Jul 2022 12:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220706164606.68528-1-f.fainelli@gmail.com>
In-Reply-To: <20220706164606.68528-1-f.fainelli@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 21:44:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJG0cA4v+pfyeO8PpzFxtrggNeRrfEB8QFBiEZjYPt3A@mail.gmail.com>
Message-ID: <CAMuHMdVJG0cA4v+pfyeO8PpzFxtrggNeRrfEB8QFBiEZjYPt3A@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Fix MAX_DMA_ADDRESS overflow
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        open list <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
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

On Wed, Jul 6, 2022 at 6:46 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> added a check to determine whether arm_dma_zone_size is exceeding the
> amount of kernel virtual address space available between the upper 4GB
> virtual address limit and PAGE_OFFSET in order to provide a suitable
> definition of MAX_DMA_ADDRESS that should fit within the 32-bit virtual
> address space. The quantity used for comparison was off by a missing
> trailing 0, leading to MAX_DMA_ADDRESS to be overflowing a 32-bit
> quantity.
>
> This was caught with the bcm2711 platforms which defines a dma_zone_size
> of 1GB, and using a PAGE_OFFSET of 0xc000_0000 (CONFIG_VMSPLIT_3G) with
> CONFIG_DEBUG_VIRTUAL enabled would lead to MAX_DMA_ADDRESS being
> 0x1_0000_0000 which overflows the unsigned long type used throughout
> __pa() and __virt_addr_valid(). Because the virtual address passed to
> __virt_addr_valid() would now be 0, the function would loudly warn, thus
> making the platform unable to boot properly.
>
> Fixes: 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
>
> - simplify the patch and drop the first patch that attempted to fix an
>   off by one in the calculation.

Thanks for the update!

> --- a/arch/arm/include/asm/dma.h
> +++ b/arch/arm/include/asm/dma.h
> @@ -10,7 +10,7 @@
>  #else
>  #define MAX_DMA_ADDRESS        ({ \
>         extern phys_addr_t arm_dma_zone_size; \
> -       arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
                                                  ^^^^^^^^^^
0x10000000ULL, as the constant doesn't fit in 32-bit.
However, both gcc (9.4.0) and sparse don't seem to complain about
the missing suffix (anymore?).

> +       arm_dma_zone_size && arm_dma_zone_size < (0x100000000 - PAGE_OFFSET) ? \
>                 (PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
>  #endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
