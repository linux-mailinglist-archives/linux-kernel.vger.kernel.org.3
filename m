Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB54E5694A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiGFVpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiGFVpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:45:43 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473BA201B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:45:42 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id z13so20203403qts.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEhHuL2rf2OqYhNIoNagWMkBVp66HkNFO4TGyz8+m94=;
        b=XiXp5q37x44ETaesOJad4rUE41xecOCYZsli2+GzX6DnQ6T/sOGJmL3Doq+Cq74GZW
         NvMAWV8Rmpk0wwxEjwl0d/ZRMNPISODQUjMtCUt93h85C3wBIHwPF7OGWnCPtuuXV6ON
         8WOHaPf+0ngk6BesP/a1kn3uUmRE/38+d/R2MhU2SDzNHog0+vBhUZzwKQR2Rc825ObW
         4Zg7ppQfMA1x0IG2l92svd8yXkmL9ON/Qeu0fGNmNZq3Ds+ulvvoPytdhk8FSfVTFyuH
         NwW7p3MyXV3DWTCXh5K7OmE7zprY+LWsFQEKG+tPT0Mrbf7hrew7oLT7t30afvwlXmIC
         bZ4w==
X-Gm-Message-State: AJIora/bsMST1XPz76Ni6jOAGNArmrxohiv2xKvSMZbwBYcuQ+8OK1Vc
        F5eCMkwjOUWXMT4R4dNMU4V/usbrx3ne0Alj
X-Google-Smtp-Source: AGRyM1uMPnJ9Vc24B3wMMDWG7kg+GWdHpxZroKVrEVfJ9u6fRMboJhYIAfmCm2JJ69Jhs+n2D/ZJYw==
X-Received: by 2002:a05:6214:202f:b0:432:4810:1b34 with SMTP id 15-20020a056214202f00b0043248101b34mr18819070qvf.35.1657143941278;
        Wed, 06 Jul 2022 14:45:41 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id i11-20020a05620a248b00b006af4f9b77fdsm24252039qkn.44.2022.07.06.14.45.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 14:45:40 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id g4so29459529ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:45:40 -0700 (PDT)
X-Received: by 2002:a05:6902:701:b0:66e:a06d:53d7 with SMTP id
 k1-20020a056902070100b0066ea06d53d7mr4141554ybt.604.1657143940425; Wed, 06
 Jul 2022 14:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220706164606.68528-1-f.fainelli@gmail.com> <CAMuHMdVJG0cA4v+pfyeO8PpzFxtrggNeRrfEB8QFBiEZjYPt3A@mail.gmail.com>
 <dba1161c-4cee-0dfd-df62-385396e62679@gmail.com>
In-Reply-To: <dba1161c-4cee-0dfd-df62-385396e62679@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 23:45:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWovMGhUuMp5To96V-OD5nBQ7CNQPnx_ZxtCQFhbUQuYA@mail.gmail.com>
Message-ID: <CAMuHMdWovMGhUuMp5To96V-OD5nBQ7CNQPnx_ZxtCQFhbUQuYA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Jul 6, 2022 at 10:27 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 7/6/22 12:44, Geert Uytterhoeven wrote:
> > On Wed, Jul 6, 2022 at 6:46 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >> Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> >> added a check to determine whether arm_dma_zone_size is exceeding the
> >> amount of kernel virtual address space available between the upper 4GB
> >> virtual address limit and PAGE_OFFSET in order to provide a suitable
> >> definition of MAX_DMA_ADDRESS that should fit within the 32-bit virtual
> >> address space. The quantity used for comparison was off by a missing
> >> trailing 0, leading to MAX_DMA_ADDRESS to be overflowing a 32-bit
> >> quantity.
> >>
> >> This was caught with the bcm2711 platforms which defines a dma_zone_size
> >> of 1GB, and using a PAGE_OFFSET of 0xc000_0000 (CONFIG_VMSPLIT_3G) with
> >> CONFIG_DEBUG_VIRTUAL enabled would lead to MAX_DMA_ADDRESS being
> >> 0x1_0000_0000 which overflows the unsigned long type used throughout
> >> __pa() and __virt_addr_valid(). Because the virtual address passed to
> >> __virt_addr_valid() would now be 0, the function would loudly warn, thus
> >> making the platform unable to boot properly.
> >>
> >> Fixes: 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >> Changes in v2:
> >>
> >> - simplify the patch and drop the first patch that attempted to fix an
> >>    off by one in the calculation.
> >
> > Thanks for the update!
> >
> >> --- a/arch/arm/include/asm/dma.h
> >> +++ b/arch/arm/include/asm/dma.h
> >> @@ -10,7 +10,7 @@
> >>   #else
> >>   #define MAX_DMA_ADDRESS        ({ \
> >>          extern phys_addr_t arm_dma_zone_size; \
> >> -       arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
> >                                                    ^^^^^^^^^^
> > 0x10000000ULL, as the constant doesn't fit in 32-bit.
> > However, both gcc (9.4.0) and sparse don't seem to complain about
> > the missing suffix (anymore?).
>
> Thanks, I will the ULL suffix in v3.

I just remembered the suffix is not needed (but doesn't hurt), because
hexadecimal constants automatically have the right unsigned type.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
