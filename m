Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AEE4DD84B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiCRKnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiCRKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:43:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB82D7AAF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:41:20 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u3so10843172ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWOV5BQly7uUTCsTTck4r1RI0yVIrTME1+42FK5fZQQ=;
        b=SiW7FZZJDFCCmtv/P0k8Mtvt7QXorjlxwA7T0umUyjkegWZzZLlCvF0CnrOejE+Vvr
         aaeDdNjLs6aIF7gx/lADEa0lxU/kH4CrbGZtc6KBTBbIOE7XPgha7c76W5bh5z/Drtzi
         pGJxIj5HAvxprPe8MHKu9SyLBeLZ3INLaBb54WUjBUIsUbrokvUk4NaOcvIT2hAqWSPr
         CHvJCxQi5252wXdMcw9y3iWNL54T/UqG0ZC5Bnvty3SrLwbKBjAJHvLIggbs2p2/mNa7
         5XnXCvXkBVtXvsaGfY2B6CRwAk4kH3mDe9X1RAFDDKMTzlyusOaG7VB8JMFmCI9cFEkz
         +WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWOV5BQly7uUTCsTTck4r1RI0yVIrTME1+42FK5fZQQ=;
        b=LyyuTDvB7saBd93sCe6RuSGp4rU8k52v7jPkpqh23olVgGF760icfh+LWhSEWLrCra
         GIgGr9KbthOiPTR3bNShWT8kNIIQyX6bR+cEOxQSEo6NWAwR+08WmAmuLig8ccXuOttA
         HnzD1hq9KUVxeytWIJfQIGSUSvElWSMVx3FiaM0b9ryLvynYcnWgql6KLnXTOEaEWlCf
         Lh/EaN0qJZuemvjpw7w3Ex46sSSjy+DAfnNnettRpfoftK2CnV/AGOd/c8JgDXS/FwSH
         gFWAho5xWsObhcgnxh8/L1PqPaHMt+2dXjHHWDo2BRn1xwfhSn+AHBXu6dgFbT956BaF
         soWw==
X-Gm-Message-State: AOAM532cNiqsvQ7o5Fm+yMgtZa7mljthCDOaPp4BIHn0kk/+p6tYVp9N
        hhWK7BI4L3ZMkKPIUkroweJ1jN4JqTOfAYGPkLMBPg==
X-Google-Smtp-Source: ABdhPJxDwbeLUz80HQ2n0RKN6rMdsWCsrNQgSGc5q2vCkMxhKZvT/2ipxlJ/taPnr0E2lKeN+kxT0S5nloOZaPOCaTs=
X-Received: by 2002:a05:651c:1783:b0:249:43a8:b6f9 with SMTP id
 bn3-20020a05651c178300b0024943a8b6f9mr5374258ljb.273.1647600078120; Fri, 18
 Mar 2022 03:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220315220549.2749328-1-chris.packham@alliedtelesis.co.nz>
 <20220315220549.2749328-2-chris.packham@alliedtelesis.co.nz>
 <CAPDyKFpMnno1RjnSMhgUAZc=q4erdNGEFYOW=k13MMMPti7aQA@mail.gmail.com>
 <4b27d0bf-cf30-9c96-f519-9df71091671c@alliedtelesis.co.nz> <88ec8037-38ef-2978-89dd-526f443a30ea@alliedtelesis.co.nz>
In-Reply-To: <88ec8037-38ef-2978-89dd-526f443a30ea@alliedtelesis.co.nz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Mar 2022 11:40:41 +0100
Message-ID: <CAPDyKFoo0GH0XwA3uZ-KF4Vbh2GxwPgia9eJTP+Nfi73COPy-w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: xenon: add AC5 compatible string
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     "huziji@marvell.com" <huziji@marvell.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 at 04:41, Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
>
> On 18/03/22 11:27, Chris Packham wrote:
> >
> > On 17/03/22 23:13, Ulf Hansson wrote:
> >> On Tue, 15 Mar 2022 at 23:05, Chris Packham
> >> <chris.packham@alliedtelesis.co.nz> wrote:
> >>> Import binding documentation from the Marvell SDK which adds
> >>> marvell,ac5-sdhci compatible string and documents the requirements for
> >>> the for the Xenon SDHCI controller on the 98DX2530.
> >>>
> >>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >>> ---
> >>>
> >>> Notes:
> >>>      Changes in v3:
> >>>      - Split from larger series
> >>>      - Add review from Andrew
> >>>      Changes in v2:
> >>>      - New
> >>>
> >>>   .../bindings/mmc/marvell,xenon-sdhci.txt      | 52
> >>> +++++++++++++++++++
> >>>   1 file changed, 52 insertions(+)
> >> Would you mind converting these bindings to the new yaml format, as
> >> the first step?
> >>
> >> Up until this point, I have accepted only very small changes to the
> >> legacy txt based bindings, but I am starting to think that it's time
> >> to reject those too. We need all bindings to move to yaml.
> >>
> >> Sorry, if this causes additional churns for you.
> >
> > If it earns me some good karma it'll probably be worth it. Can I put
> > you down as the maintainer in the yaml binding?
>
> I've fired off a patch for converting the binding
>
> https://lore.kernel.org/linux-devicetree/20220318033521.1432767-1-chris.packham@alliedtelesis.co.nz/T/#u

Thanks, I will have a look!

>
> For this change specifically I might park it. When I looked at the
> actual changes that were being made in the Marvell SDK they're doing
> something weird with dma addresses and of_dma_get_range() which won't
> work . The boards we're making won't have MMC and I don't have the
> desire to help Marvell bring their code up to scratch (at least not for
> a driver I don't need).

I see.

Then you deserve a special thanks for helping out with the DT conversion!

Kind regards
Uffe

>
> >
> >>
> >> Kind regards
> >> Uffe
> >>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> >>> b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> >>> index c51a62d751dc..43df466f0cb3 100644
> >>> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> >>> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> >>> @@ -14,6 +14,7 @@ Required Properties:
> >>>     - "marvell,armada-ap806-sdhci": For controllers on Armada AP806.
> >>>     - "marvell,armada-ap807-sdhci": For controllers on Armada AP807.
> >>>     - "marvell,armada-cp110-sdhci": For controllers on Armada CP110.
> >>> +  - "marvell,ac5-sdhci": For CnM on AC5, AC5X and derived.
> >>>
> >>>   - clocks:
> >>>     Array of clocks required for SDHC.
> >>> @@ -33,6 +34,13 @@ Required Properties:
> >>>       in below.
> >>>       Please also check property marvell,pad-type in below.
> >>>
> >>> +  * For "marvell,ac5-sdhci", one or two register areas.
> >>> +    (reg-names "ctrl" & "decoder").
> >>> +    The first one is mandatory for the Xenon IP registers.
> >>> +    The second one is for systems where DMA mapping is required and
> >>> is the
> >>> +    related address decoder register (the value to configure is
> >>> derived from
> >>> +    the parent "dma-ranges").
> >>> +
> >>>     * For other compatible strings, one register area for Xenon IP.
> >>>
> >>>   Optional Properties:
> >>> @@ -171,3 +179,47 @@ Example:
> >>>
> >>>                  marvell,pad-type = "sd";
> >>>          };
> >>> +
> >>> +
> >>> +- For eMMC with compatible "marvell,ac5-sdhci" with one reg range
> >>> (no dma):
> >>> +       sdhci0: sdhci@805c0000 {
> >>> +               compatible = "marvell,ac5-sdhci";
> >>> +               reg = <0x0 0x805c0000 0x0 0x300>;
> >>> +               reg-names = "ctrl", "decoder";
> >>> +               interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> >>> +               clocks = <&core_clock>;
> >>> +               clock-names = "core";
> >>> +               status = "okay";
> >>> +               bus-width = <8>;
> >>> +               /*marvell,xenon-phy-slow-mode;*/
> >>> +               non-removable;
> >>> +               mmc-ddr-1_8v;
> >>> +               mmc-hs200-1_8v;
> >>> +               mmc-hs400-1_8v;
> >>> +       };
> >>> +
> >>> +- For eMMC with compatible "marvell,ac5-sdhci" with two reg ranges
> >>> (with dma):
> >>> +       mmc_dma: mmc-dma-peripherals@80500000 {
> >>> +               compatible = "simple-bus";
> >>> +               #address-cells = <0x2>;
> >>> +               #size-cells = <0x2>;
> >>> +               ranges;
> >>> +               dma-ranges = <0x2 0x0 0x2 0x80000000 0x1 0x0>;
> >>> +               dma-coherent;
> >>> +
> >>> +               sdhci0: sdhci@805c0000 {
> >>> +                       compatible = "marvell,ac5-sdhci",
> >>> "marvell,armada-ap806-sdhci";
> >>> +                       reg = <0x0 0x805c0000 0x0 0x300>, <0x0
> >>> 0x80440230 0x0 0x4>;
> >>> +                       reg-names = "ctrl", "decoder";
> >>> +                       interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> >>> +                       clocks = <&core_clock>;
> >>> +                       clock-names = "core";
> >>> +                       status = "okay";
> >>> +                       bus-width = <8>;
> >>> +                       /*marvell,xenon-phy-slow-mode;*/
> >>> +                       non-removable;
> >>> +                       mmc-ddr-1_8v;
> >>> +                       mmc-hs200-1_8v;
> >>> +                       mmc-hs400-1_8v;
> >>> +               };
> >>> +       };
> >>> --
> >>> 2.35.1
> >>>
