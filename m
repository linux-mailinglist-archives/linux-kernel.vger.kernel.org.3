Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A0248D27A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiAMGyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiAMGyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:54:12 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDD8C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 22:54:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o15so16133062lfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 22:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/xflG/TvWV3/3iWK2yYutqh016Xap1/1t8bC2k14nw=;
        b=B4a5Gw4Katx70iQLDcTIOZAdb8/hF/KQLUA7YMhUQkd4qqdtgRwvnBLLZyYbCt0TVC
         4T22TMK9TfNQbfcgqZLs9zf9TqZ8g7joGToZggXtaiq2mrq1qa7Git7p0XHZEGCwpP0p
         sDj/zInNAhAqj1Fkm510wzky2K4dihOirU4/NxGojfiFjrR1DOA3KWz96cIcaS42aWNH
         xDUZi+C4kFx6cDhoR9N5ljg09vXECubRHjBOLCJjjJnt9yBHh6XrUUre3f1vG2WEaDqn
         5qqkio2TXcAiFZv+8YIWrdnTtP+uYi4qU/AG+HR6DMEwwEMA7J1tFlM2Jeq78kUlPY1i
         +H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/xflG/TvWV3/3iWK2yYutqh016Xap1/1t8bC2k14nw=;
        b=YNlk4aC8nbm7Ic9yz95FK7sPMJ/NnO/wnsSSGxGuVX2ex/YiTfVl+U4Z/nUA0NQIpD
         6My76vDev7P17pW4umnP/m7WKogvdeKRIc3SRhzLQyVIQocWtFU+q67sE3f1HLxAV3PT
         XRzmd9+KnMbvuKRkql73VHuXae5aqec1Cg2u9/Xft1GwMVVA4yvtOyvJZcCLtVHrlQ/B
         KlA+szcSWeptTtds6E4uGTiuHO5HGTKW+wbIT0K1RrAlezQCQCAZga/j/ZOI9TonTJX3
         KBbhGzzzdr4Iyg7XjPpAviiheYf7kDrFriVwK5n2CyejyaVpi/QZf6ontS/dWivZ7PY7
         Td3Q==
X-Gm-Message-State: AOAM532kPn9q2Ba5D09Upful7aFudc0jpQ3UzWHzKoYr7SmM5+WByRi2
        vlNd6gULWQnDfUAOA3s0lbuBST1bIs2vLg9umDH9OQ==
X-Google-Smtp-Source: ABdhPJzTYhl9vfK8sy2lvc56F1BQs63yY++onXm7/N0EwHT1Fj2YlJrOC/YLE0mn/OWWjY7DRlU6aKderF3ihd8gpPk=
X-Received: by 2002:a2e:bba1:: with SMTP id y33mr2060235lje.274.1642056849691;
 Wed, 12 Jan 2022 22:54:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641890718.git.zong.li@sifive.com> <78cfa00a02cbd10202040058af22a73caa9c5ae8.1641890718.git.zong.li@sifive.com>
 <CAMuHMdUogbyjU=vBuvocxofGFCwzdQndk9OTnVdP+RNA8HEFZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUogbyjU=vBuvocxofGFCwzdQndk9OTnVdP+RNA8HEFZQ@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 13 Jan 2022 14:53:58 +0800
Message-ID: <CANXhq0qpkArvELBDqOT=bnVCwvR47cxHN7oH1hYKr1Yt7zaGOQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dmaengine: sf-pdma: Get number of channel by
 device tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, Vinod <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 4:28 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Zong,
>
> On Tue, Jan 11, 2022 at 9:51 AM Zong Li <zong.li@sifive.com> wrote:
> > It currently assumes that there are always four channels, it would
> > cause the error if there is actually less than four channels. Change
> > that by getting number of channel from device tree.
> >
> > For backwards-compatible, it uses the default value (i.e. 4) when there
> > is no 'dma-channels' information in dts.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
>
> Thanks for your patch!
>
> > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > @@ -484,21 +484,24 @@ static int sf_pdma_probe(struct platform_device *pdev)
> >         struct sf_pdma *pdma;
> >         struct sf_pdma_chan *chan;
> >         struct resource *res;
> > -       int len, chans;
> > -       int ret;
> > +       int len, ret;
> >         const enum dma_slave_buswidth widths =
> >                 DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
> >                 DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_8_BYTES |
> >                 DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
> >                 DMA_SLAVE_BUSWIDTH_64_BYTES;
> >
> > -       chans = PDMA_NR_CH;
> > -       len = sizeof(*pdma) + sizeof(*chan) * chans;
> > +       len = sizeof(*pdma) + sizeof(*chan) * PDMA_MAX_NR_CH;
>
> Why is the last part added (yes, this is a pre-existing issue)?
> struct sf_pdma already contains space for chans[PDMA_MAX_NR_CH].
> Either drop the last part, or change sf_pdma.chans[] to a flexible
> array member.
>
> BTW, you can use the struct_size() or flex_array_size() helper
> to calculate len.

Thanks for your suggestions, let me fix it in the next version.

>
> >         pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> >         if (!pdma)
> >                 return -ENOMEM;
> >
> > -       pdma->n_chans = chans;
> > +       ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> > +                                  &pdma->n_chans);
> > +       if (ret) {
> > +               dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
> > +               pdma->n_chans = PDMA_MAX_NR_CH;
> > +       }
> >
> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         pdma->membase = devm_ioremap_resource(&pdev->dev, res);
> > @@ -556,7 +559,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
> >         struct sf_pdma_chan *ch;
> >         int i;
> >
> > -       for (i = 0; i < PDMA_NR_CH; i++) {
> > +       for (i = 0; i < pdma->n_chans; i++) {
> >                 ch = &pdma->chans[i];
>
> If dma-channels in DT > PDMA_NR_CH, this becomes an out-of-bound
> access.
>

Okay, let me get the min() between pdma->chans and PDMA_MAX_NR_CH,
please let me know if it isn't good to you.

> >
> >                 devm_free_irq(&pdev->dev, ch->txirq, ch);
> > diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> > index 0c20167b097d..8127d792f639 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.h
> > +++ b/drivers/dma/sf-pdma/sf-pdma.h
> > @@ -22,11 +22,7 @@
> >  #include "../dmaengine.h"
> >  #include "../virt-dma.h"
> >
> > -#define PDMA_NR_CH                                     4
> > -
> > -#if (PDMA_NR_CH != 4)
> > -#error "Please define PDMA_NR_CH to 4"
> > -#endif
> > +#define PDMA_MAX_NR_CH                                 4
> >
> >  #define PDMA_BASE_ADDR                                 0x3000000
> >  #define PDMA_CHAN_OFFSET                               0x1000
> > @@ -118,7 +114,7 @@ struct sf_pdma {
> >         void __iomem            *membase;
> >         void __iomem            *mappedbase;
> >         u32                     n_chans;
> > -       struct sf_pdma_chan     chans[PDMA_NR_CH];
> > +       struct sf_pdma_chan     chans[PDMA_MAX_NR_CH];
> >  };
> >
> >  #endif /* _SF_PDMA_H */
> -
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
