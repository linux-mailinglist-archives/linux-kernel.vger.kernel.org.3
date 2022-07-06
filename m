Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C47D5692D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiGFTqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiGFTqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:46:31 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D69D113
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:46:30 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id b125so11831351qkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzKPVM36HgKf4aTcBSLZ6d0AvqZ3GVLYImBDwTeAfd0=;
        b=ypO6KHNRtDAslyDvb46GCGTNS4knWWDN1aa0jlAElKnwQOME2l12HlWpBsQZH8Tn0R
         ldjDLxPHClk/nrOiF7Acy8tofC0zhYrMQ3UHBBqWbVzUf0v7QVzDVVIpmixcHhqm+pon
         48UDwBGFeU2U+K25MG8N/OjqTYHcoO+CplbtGHIGa2au3HBV/bjHSBTWNUiU5vV9O197
         EVwA2RLPDcAbAxjndhpwH0JmNg24psKhcWqPgPMczapjwponQDGBSq4TDxs2Xv/h0v16
         ofKAQbP+woom4KbtsgP7Va9vlmIfCHrBOmi3Euuj05RQaLRgPzCVdwok3e2WRCbZeOq9
         x2/w==
X-Gm-Message-State: AJIora97JSZg4mDKmhO4+cIwdU2UFEhgBbGJ4VJHMAUD0VfRwa+ZSDtC
        7KmnSUZsIMn7L8VsJzTrlN3JiFeLcLYouMUY
X-Google-Smtp-Source: AGRyM1sKOXHcdIBTMeSN274ZnDgPwl4kooZlp6CQWVgUeC2x7V6yXx3TQK15jyeNYXcAZsTfxT5l5Q==
X-Received: by 2002:a05:620a:4725:b0:6af:1f48:46f3 with SMTP id bs37-20020a05620a472500b006af1f4846f3mr29084553qkb.238.1657136789480;
        Wed, 06 Jul 2022 12:46:29 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id ea2-20020a05620a488200b006a79d8c8198sm20449821qkb.135.2022.07.06.12.46.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 12:46:28 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-31cb2c649f7so76050987b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:46:28 -0700 (PDT)
X-Received: by 2002:a81:af27:0:b0:31c:833f:eda5 with SMTP id
 n39-20020a81af27000000b0031c833feda5mr26773318ywh.358.1657136788156; Wed, 06
 Jul 2022 12:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220706164606.68528-1-f.fainelli@gmail.com> <CAMuHMdVJG0cA4v+pfyeO8PpzFxtrggNeRrfEB8QFBiEZjYPt3A@mail.gmail.com>
In-Reply-To: <CAMuHMdVJG0cA4v+pfyeO8PpzFxtrggNeRrfEB8QFBiEZjYPt3A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 21:46:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVyNAUtrNhkDn=OOQo6BnjJtL-mwLcC75naxHjVQwBjuw@mail.gmail.com>
Message-ID: <CAMuHMdVyNAUtrNhkDn=OOQo6BnjJtL-mwLcC75naxHjVQwBjuw@mail.gmail.com>
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

On Wed, Jul 6, 2022 at 9:44 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jul 6, 2022 at 6:46 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> > added a check to determine whether arm_dma_zone_size is exceeding the
> > amount of kernel virtual address space available between the upper 4GB
> > virtual address limit and PAGE_OFFSET in order to provide a suitable
> > definition of MAX_DMA_ADDRESS that should fit within the 32-bit virtual
> > address space. The quantity used for comparison was off by a missing
> > trailing 0, leading to MAX_DMA_ADDRESS to be overflowing a 32-bit
> > quantity.
> >
> > This was caught with the bcm2711 platforms which defines a dma_zone_size
> > of 1GB, and using a PAGE_OFFSET of 0xc000_0000 (CONFIG_VMSPLIT_3G) with
> > CONFIG_DEBUG_VIRTUAL enabled would lead to MAX_DMA_ADDRESS being
> > 0x1_0000_0000 which overflows the unsigned long type used throughout
> > __pa() and __virt_addr_valid(). Because the virtual address passed to
> > __virt_addr_valid() would now be 0, the function would loudly warn, thus
> > making the platform unable to boot properly.
> >
> > Fixes: 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> > Changes in v2:
> >
> > - simplify the patch and drop the first patch that attempted to fix an
> >   off by one in the calculation.
>
> Thanks for the update!
>
> > --- a/arch/arm/include/asm/dma.h
> > +++ b/arch/arm/include/asm/dma.h
> > @@ -10,7 +10,7 @@
> >  #else
> >  #define MAX_DMA_ADDRESS        ({ \
> >         extern phys_addr_t arm_dma_zone_size; \
> > -       arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
>                                                   ^^^^^^^^^^
> 0x10000000ULL, as the constant doesn't fit in 32-bit.
> However, both gcc (9.4.0) and sparse don't seem to complain about
> the missing suffix (anymore?).
>
> > +       arm_dma_zone_size && arm_dma_zone_size < (0x100000000 - PAGE_OFFSET) ? \

Obviously my comment applies to the _new_ line, not to the removed
line...

> >                 (PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
> >  #endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
