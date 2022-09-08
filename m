Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2AF5B26AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiIHT0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIHTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:25:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802809E13C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:25:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 65so8702221pfx.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 12:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3S3TgS7iK2ozBJhM8YAZns0sUBBeIKf5Pkpn/yRLzAY=;
        b=SKPprRfmTseF3CsTo59H6bxctE0pyajXRQU3GYANwXMdu/9lBtYeyi/eJpx3z8lja/
         Ba/ttJlp4vrZ862EamZswK8DWSgZHQ6eKf0lzS2EYpFBfYMZlQlEzhRNqLg1MbCCw8uE
         TxRWyhXPs/9p+ZAceve/fKsfEUTozyOPNWVMEtstHPcYXCnU4EHQUv67kdxogNzzKvcz
         bi1zdWpxcB/13pHFBmHaq23lYJkeYPGsHCDZ50DAqWvLVefAjssqZcirOts8oikdTMSz
         d/xX6qFWGTYvfu9s9s/feCD7miZ/pJtKRUwwpgc7EKFlbHDYrhD7hcMsGF35qVO4v0E2
         fXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3S3TgS7iK2ozBJhM8YAZns0sUBBeIKf5Pkpn/yRLzAY=;
        b=q387ilrkXYA9eRmRhexIgzLHv+FjQrfTLB6zvscovNgZwIfL1lf0a6eV5PZT8tlu3j
         NlqnoFgKE8/ZAQa3blGsgTGGJJD3Wzh7SU0LFkHvFV7PjezPFKNPW6ACPyc2I+WlltAf
         3if9A4wYOCtLBrgYr4ogkqrZ9NJnbNlSFRdKRGH4xDDAVTslqYwlX7bsBlWyr/A4O78L
         f7J/+CJOggCdP6mN7CxHsGP05ygwyD9F7G+Ea5/+jq00qAjSbyoAlM6K7dYpFb3tgU/o
         q+rC/+48SY/BQ1tnoKpfJrIly0GNTg50E2D2IDdfLRewzlUNpEx5KgESXzqLH0RkA8xx
         1WuA==
X-Gm-Message-State: ACgBeo3a+3Z8QRrrsK04ncFqDPjT06huc8v8JAuxBVWXQ5JjD59uahel
        QEqDumfhzJzlP2c38mHQImHICmXWk/GXHXL5b/2ndg==
X-Google-Smtp-Source: AA6agR6vu+hiv2fosIx74neSLsNOYc1oSH3ZhEa4dBoKATsPyt8MRLxwstjq3AQ69BiM3JiLXaPJVWADzXpKhLGPg94=
X-Received: by 2002:a63:4c03:0:b0:431:58b8:cb91 with SMTP id
 z3-20020a634c03000000b0043158b8cb91mr8956475pga.440.1662665157887; Thu, 08
 Sep 2022 12:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com> <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
 <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de>
In-Reply-To: <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 8 Sep 2022 12:25:46 -0700
Message-ID: <CAJ+vNU0voeMW06Je6nyrV1Ud3sT8Us+RACcQtsKUwKVaXF+dQw@mail.gmail.com>
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
To:     Marek Vasut <marex@denx.de>, Stephen Boyd <sboyd@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 9:55 AM Marek Vasut <marex@denx.de> wrote:
>
> On 9/8/22 18:00, Tim Harvey wrote:
> > On Thu, Sep 1, 2022 at 9:14 PM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>
> >> Hi Tim,
> >>
> >> On 9/2/22 01:23, Tim Harvey wrote:
> >>> Greetings,
> >>>
> >>> I've found that the bd71847 clk driver (CONFIG_COMMON_CLK_BD718XX
> >>> drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847 C32K_OUT
> >>> pin) which is connected IMX8MM RTC_XTALI which ends up disabling the
> >>> IMX RTC as well as the IMX WDOG functionality.
> >>
> >> //snip
> >>
> >>> This happens via clk_unprepare_unused() as nothing is flagging the
> >>> clk-32k-out as being used. What should be added to the device-tree to
> >>> signify that this clk is indeed necessary and should not be disabled?
> >>
> >> I have seen following proposal from Marek Vasut:
> >>
> >> https://lore.kernel.org/all/20220517235919.200375-1-marex@denx.de/T/#m52d6d0831bf43d5f293e35cb27f3021f278d0564
> >>
> >> I am not sure if the discussion is completed though. I guess it was
> >> agreed this was needed/usefull and maybe the remaining thing to decide
> >> was just the property naming.
> >>
> >> Best Regards
> >>          -- Matti
> >>
> >
> > Thanks Matti,
> >
> > Marek - has there been any progress on determining how best to keep
> > certain clocks from being disabled?
>
> No. You can read the discussion above.

Marek,

I wasn't on the linux-clk list at that time so can't respond to the
thread but the discussion seems to have died out a couple of months
ago with no agreement between you or Stephen on how to deal with it.

So where do we take this from here? It looks like there are about 18
boards with dt's using "rohm,bd718*" which would all have non working
RTC/WDOG with CONFIG_COMMON_CLK_BD718XX enabled (which it is in
arch/arm64/configs/defconfig) right?

$ git grep "rohm,bd718" arch/ | cut
-d: -f1
arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dts
arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts

Best Regards,

Tim
