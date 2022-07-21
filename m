Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7162157C9DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiGULnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiGULne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:43:34 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011C577481;
        Thu, 21 Jul 2022 04:43:32 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id r21so1001581qtn.11;
        Thu, 21 Jul 2022 04:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqoFgQwvU/6C15HIQr7DoIxTrhMVcDk8Haf+TDoehBc=;
        b=a81SRD6qI2klRNlqaA6Oguy4OUeK4kE57srZp7ELFeb3wHrvb26XlRWlGUDAdf56fy
         JB9Wd7wf7ip/D/eLT5GIqFR11gXYaQO+wOkIDsI9RaBGM+6fGCcBaYYtDUJeinoZUvB7
         iYxpDH/8LYND9ZdYJDgEju5vFRXRBHLgGdBTD3yAd28hQSUWK+tv4ed5td26nuRzz2pX
         3XxUnZE+9DE+oZ/xHL4C0Y4cQgaNR1mjKfaE5gsDb8JRRpop3XOauQiuDZNPypf4Kj2E
         b+W71Avchonchpk0oHrH767Q49DSSZbYOz3wsHTl/JK7JkKKSm9i/YUvGL9EDsIhaXyW
         QQzA==
X-Gm-Message-State: AJIora81uajuO6bLIlIr66wWj0yQCJ8O6l9T5EilRmKiMxHLQxF+Nlcd
        VFRH18DiQEV6s0Bv+kOFIGXmUZKq6Ere+A==
X-Google-Smtp-Source: AGRyM1sB5gCthoSpdzG2LhjQo8gI7vh3c1enkAeLzKt15PKtSXP39bWW2YcNZIXP+SVeSSkoeU340Q==
X-Received: by 2002:a05:622a:102:b0:31d:34f2:2170 with SMTP id u2-20020a05622a010200b0031d34f22170mr32338702qtw.373.1658403811408;
        Thu, 21 Jul 2022 04:43:31 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id l9-20020a37f909000000b006b59eacba61sm1264221qkj.75.2022.07.21.04.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 04:43:31 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id c131so2291420ybf.9;
        Thu, 21 Jul 2022 04:43:30 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr38974765ybq.543.1658403810731; Thu, 21
 Jul 2022 04:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220718195651.7711-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV5s-q13pWXs-ki6o5h8=ZMPL11o08YQx1pawe9EUySBA@mail.gmail.com> <CA+V-a8tqhiO+WBOzAD40A10K+qtVQ4HE87C9PKVpoFgWkkS54w@mail.gmail.com>
In-Reply-To: <CA+V-a8tqhiO+WBOzAD40A10K+qtVQ4HE87C9PKVpoFgWkkS54w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 13:43:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcj2xv8FrCiTLCVQfWzejONCAv_o-VzAkicLAFNd5gPg@mail.gmail.com>
Message-ID: <CAMuHMdWcj2xv8FrCiTLCVQfWzejONCAv_o-VzAkicLAFNd5gPg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: renesas: rzg2l-smarc-som: Add PHY
 interrupt support for ETH{0/1}
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Thu, Jul 21, 2022 at 1:07 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Jul 21, 2022 at 11:47 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Jul 18, 2022 at 9:57 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ3 for ETH0
> > > and ETH1 respectively.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> > > @@ -94,6 +94,8 @@ phy0: ethernet-phy@7 {
> > >                 compatible = "ethernet-phy-id0022.1640",
> > >                              "ethernet-phy-ieee802.3-c22";
> > >                 reg = <7>;
> > > +               interrupt-parent = <&irqc>;
> > > +               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> >
> > 2?
> >
> IRQ2 = SPI 3, the driver expects the SPI number and is used as index
> [0] to map the interrupt in the GIC.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/irqchip/irq-renesas-rzg2l.c?h=next-20220720#n291

Using the SPI number sounds strange to me, as the consumer
(Ethernet PHY) is linked to the IRQC, not to the GIC directly.

> > "The first cell should contain external interrupt number (IRQ0-7)"
> >
> Probably I need to reword this to "The first cell should contain the
> SPI number for IRQ0-7/NMI interrupt lines" ?

Oh, so zero is the NMI?
And 1-8 are IRQ0-7.

All of this should be documented in the bindings.

Probably you want to document the parent interrupts:
  - First entry is NMI,
  - Next 8 entries are IRQ0-7,
  - Next 32 entries are TINT0-31.
Currently it's a flat list.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
