Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2345144B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343777AbiD2IsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351140AbiD2IsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:48:03 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAF6C4021;
        Fri, 29 Apr 2022 01:44:46 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id i2so5357437qke.12;
        Fri, 29 Apr 2022 01:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVvsKUh93mtPsnlNQathxAWXpj+Qll6q8xdLe3dz68k=;
        b=V1d/GbuzmefHVg4Vw4w0+jpC8UFkaebrCA42UDzcU5r+YsUmd8MflGluv4zrm7OALv
         4zj/jD3oV9RqUQXVfBDZNfsMTeuQBKuqKtlR4ueYL1AkdF+hmHJa7SErcwZr5j9IJp/a
         FdIB/+FsX/6/mYVriTGXIfZl/Ho8B8jJh0cCuRmTmt5NSMmQoDn0SHEomfdByVCqbq2f
         kVLc3AcFr4fXS8SMiGFBfXZ0nYZOEvZdviWoWUOlJHBU59lADjRijKmOiGyarWWNz8cF
         w9ZS0HZ6yEX44g3SiaaJpgKmklLsxAuhKbBSTAsVdv8onUYUNNktYVShRLDjMxHYwIhh
         VjHw==
X-Gm-Message-State: AOAM532rlFYrpYRhLVHDTn7izZYiU9LzdvNbzDyRL01MBxDyvGJBELNo
        wYlHQx8I542bmGxSLFPH3IExrJQI60byQonK
X-Google-Smtp-Source: ABdhPJzEENvNw0JGVOca8hJMOQ3+oYlU5FsiVAyw+Fg1YSZVYdb7G8vV0E/FMOnFwqQlGZxqPO2+Zw==
X-Received: by 2002:a05:620a:29cc:b0:69f:402e:ac38 with SMTP id s12-20020a05620a29cc00b0069f402eac38mr17004080qkp.131.1651221884944;
        Fri, 29 Apr 2022 01:44:44 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id a12-20020ac84d8c000000b002f38c14f35esm1319429qtw.81.2022.04.29.01.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:44:44 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id s30so13284742ybi.8;
        Fri, 29 Apr 2022 01:44:44 -0700 (PDT)
X-Received: by 2002:a5b:24e:0:b0:63d:cba0:3d55 with SMTP id
 g14-20020a5b024e000000b0063dcba03d55mr33655714ybp.613.1651221884000; Fri, 29
 Apr 2022 01:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220421221159.31729-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421221159.31729-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVrcT5iHUZUiCYmD12sS4F66BETBih36G7BzLTLuoQ9eQ@mail.gmail.com> <CA+V-a8sLeQZOX-cTipWotphHFcmY4jUY3errhpBkpr7Q0s4BEQ@mail.gmail.com>
In-Reply-To: <CA+V-a8sLeQZOX-cTipWotphHFcmY4jUY3errhpBkpr7Q0s4BEQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Apr 2022 10:44:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVARiVpch12HOMy8WR5pMnvVK-Mys8ZRnNK2u+y+qozJg@mail.gmail.com>
Message-ID: <CAMuHMdVARiVpch12HOMy8WR5pMnvVK-Mys8ZRnNK2u+y+qozJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: Add Renesas RZ/G2L
 Interrupt Controller
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Apr 29, 2022 at 10:38 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Apr 28, 2022 at 10:32 AM Geert Uytterhoeven
> > On Fri, Apr 22, 2022 at 12:12 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > > @@ -0,0 +1,131 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzg2l-irqc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
> > > +
> > > +maintainers:
> > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> > > +
> > > +description: |
> > > +  IA55 performs various interrupt controls including synchronization for the external
> > > +  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the built-in peripheral
> > > +  interrupts output by each IP. And it notifies the interrupt to the GIC
> > > +    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
> > > +    - GPIO pins used as external interrupt input pins, mapped to 32 GIC SPI interrupts
> > > +    - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
> > > +      stand-up edge detection interrupts)
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/interrupt-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - renesas,r9a07g044-irqc    # RZ/G2L
> > > +      - const: renesas,rzg2l-irqc
> > > +
> > > +  '#interrupt-cells':
> > > +    const: 2
> >
> > What is the meaning of the cells? IRQ number + flags, I assume?
> IRQ number and the type.
>
> > How are the numbers mapped, do you need a DT bindings header?
> No, just plain numbers are used (driver handles the validation of the
> interrupt numbering), for example like below,
>
> &eth0 {
>    ...
>    status = "okay";
>
>    phy0: ethernet-phy@7 {
>      compatible = "ethernet-phy-id0022.1640",
>                            "ethernet-phy-ieee802.3-c22";
>      reg = <7>;
>      interrupt-parent = <&irqc>;
>      interrupts = <3 IRQ_TYPE_LEVEL_LOW>;

OK, so the number must be an external interrupt number (0..7).

>     ...
>   };
> };
>
> And for the GPIO:
>
> key-1 {
>       gpios = <&pinctrl RZG2L_GPIO(43, 0) GPIO_ACTIVE_HIGH>;
>       linux,code = <KEY_1>;
>       linux,input-type = <EV_KEY>;
>       wakeup-source;
>       label = "SW1";
> };

OK, so in this case the interrupt number is obtained implicitly, and
no interrupts property is used.

> > Perhaps it would make sense to increase to 3 cells, so you can use
> > one cell for the type (cfr. e.g. GIC_SPI), and the second for the
> > plain index within the type?
> >
> Could you please elaborate on this. Are you referring to the type here
> as the type to be set up in the GIC?

Please ignore, you don't need the type, as it's always an external
interrupt number, right?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
