Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6849C48A55D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346465AbiAKB5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbiAKB5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:57:06 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD3AC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:56:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id br17so19867152lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tezxY2J06qhj7ov7742qW1p6EILBDEbMRTBUVeQPkvo=;
        b=buCvymbn8/qQJdU8bjvND2DQ21cgq5eCD6EU/xlyXOirMVhyD8bmJNLG7SO20LjLa+
         kxl+6Oc/q6NqZbLRk95NMCHkXOaAgreCkl/EoML1qCcIlK8L9MZK/9quEN5n726JDmRA
         LANIBuHAbucgweYbvAr1kDzt09xwsubl7LrqhSxenMnXvfCOt9y1gbRnx05K1G+USBNJ
         DbFPFiAMblWbhWo3UE+QeHZzEwU519n1kF471TZ1Dwl/duIPnUa3whZzHExWTSUvTC7L
         aTpsA7ViXESqUf+5xCsQIhFm3JETYA8SvftBHWdTGGs0y2qL66/IlaqEy9zqAjS7J2m4
         Rjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tezxY2J06qhj7ov7742qW1p6EILBDEbMRTBUVeQPkvo=;
        b=kFiYlGy+BgclI+b/pf/79QGZUQ0StLUtgOYYrbyQMjWaEkeoQNOdK3yP6xEEfBJ5pM
         l3uprQo5fhRkL13fq6+M1okw5vEKqdbd8RjwwdHM4/fwBGdwfzR7qC2ZqJs57FyiWUoo
         2hgZnFtdzps7SzkPqmTJExKBDS8LWBUBlIeB5S+qzm6FiaxC3aast3et8M1FscO+o4Ps
         M2W0hkqdH3Y84YSC13P22/5aSMfGu2TzfSjQYgEUtMdg+QGV2iKBo0yLH9QSmR38HV8a
         8yjZ7759aUiNOh5e5IEEJCWmC1hDhYk/lrTy0abh9SRoGYXCr1x2rfcq/Zh1mKS4zeeP
         uTlA==
X-Gm-Message-State: AOAM530AD/qdWyTNA+oC+y4vx5TgCquPpK6lpPJGD8M+SpUPlhqVHnkh
        on3Mol6YJ+3uhTItu/VTI9LculWni4njvMVygxAIow==
X-Google-Smtp-Source: ABdhPJyYj1U9xCeV1tG6jxMxA24J+Bqp8dsehDAUbfCEY4gC63Hr3XQfMqUzDBAVXliFyH+P/Eil7hBWTmWek2HHg/4=
X-Received: by 2002:a05:6512:260a:: with SMTP id bt10mr1754644lfb.223.1641866216357;
 Mon, 10 Jan 2022 17:56:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641289490.git.zong.li@sifive.com> <0419b2865c87f72adeb4edee9113a959e468b4a5.1641289490.git.zong.li@sifive.com>
 <CAMuHMdUyYVBXAeJ8XS9OsUePpFLgpCXYT5rH_bJCvCg3eaav_w@mail.gmail.com>
In-Reply-To: <CAMuHMdUyYVBXAeJ8XS9OsUePpFLgpCXYT5rH_bJCvCg3eaav_w@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 11 Jan 2022 09:56:45 +0800
Message-ID: <CANXhq0psEs0X=w6n4_HA5P3bWWac00byGQ4CaivJSBPZMjgwdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: Add dma-channels for pdma device node
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

On Mon, Jan 10, 2022 at 5:00 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Zong,
>
> On Wed, Jan 5, 2022 at 6:44 AM Zong Li <zong.li@sifive.com> wrote:
> > Add dma-channels property, then we can determine how many channels there
> > by device tree, rather than statically defines it in PDMA driver
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > @@ -34,12 +34,17 @@ properties:
> >      minItems: 1
> >      maxItems: 8
> >
> > +  dma-channels:
> > +    minimum: 1
> > +    maximum: 4
>
> As per my comment on [PATCH 3/3], perhaps you want to use a default
> value of 4, and document that here, too?
>

Thanks for your reminder, it should be modified as well. I would
change it and add a description in the next version.

> > +
> >    '#dma-cells':
> >      const: 1
> >
> >  required:
> >    - compatible
> >    - reg
> > +  - dma-channels
> >    - interrupts
> >    - '#dma-cells'
> >
>
>
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
