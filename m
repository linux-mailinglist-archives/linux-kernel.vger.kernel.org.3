Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47FB53E2CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiFFGJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiFFGJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:09:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0216713F81
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 23:08:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id bo5so11931289pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 23:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6k+dFc6Nvtrf/Msfd6+QxAADjHPGiS46041UYSZkIZk=;
        b=dxW5cCP1FrLBb9/TgPfH8DwjCuNLncZFxzqKunOy/zK6kbVHN4A3mkOf8Jck6fIwQk
         8t8q/V1iaQDYb6KqSKt1cCF8j4ZMBkeuJDkayx5qMQQgZyY6u2GhSuj/7NLjn5aUsGuf
         V4MA5v6r3orwM03Ru0u7BkMfS3b0InBPeYdxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6k+dFc6Nvtrf/Msfd6+QxAADjHPGiS46041UYSZkIZk=;
        b=Vd03zDvKQH1gb5wtCsu9qjazOzTvqa+YNwdNEWDxR7b5BAKMS9y6nnrQPEucgCUOqy
         fvNubkmO5GkLQfMsjg3/+xew101Z/7+fPqN/HwTsu5qnbbYrVf9b5MRHmsRNKYDHeDK0
         dhwYTNi4BGkBrJrScgMpOzqB0m9SEXpYvdlDfgnsDhfkZcf1aWh40bnX/G3z8IiQOvyg
         JPG3F0FMxElvgSbsf6Igqp/c82WVVuQiNfxIP1tGEcensCyDOQJvlnpFBpp/iRqCyes8
         Z2oc507w1b5iBIQTRCorPo16aS9lu8nmtLOlFwRgdiR4eA/6SKa6W/w3tBsnqmYAm9/4
         Xyhw==
X-Gm-Message-State: AOAM53372eJYBAbcYAsZFIvxTzVijFbY+cJDgNHyAhsm8hMCH3i+tmnE
        8XvczDUvEFL7vbTNvmy3+qfRGllloNhdWGJz5dyX8g==
X-Google-Smtp-Source: ABdhPJw9xSkNh+h+Vtbm/VSYma4/+gWmuvUVLv/xA+IhtOU0VNhBKtivOv4H2UfyOonUTfJfE/mvTCwzQk8h7UkWgPc=
X-Received: by 2002:a63:5610:0:b0:3f2:7e19:1697 with SMTP id
 k16-20020a635610000000b003f27e191697mr19540118pgb.74.1654495736443; Sun, 05
 Jun 2022 23:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220605165703.1565234-1-michael@amarulasolutions.com>
 <20220605165703.1565234-3-michael@amarulasolutions.com> <5f34b6d6-c2dd-44f9-c1bc-fe1deb336334@gmail.com>
In-Reply-To: <5f34b6d6-c2dd-44f9-c1bc-fe1deb336334@gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 6 Jun 2022 08:08:45 +0200
Message-ID: <CAOf5uwn6_Tuh-r+8HpthMRDYYc50OnXp4m5TQi49heknfV5yWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] clk: bd718x7: Enable the possibility to mark the
 clock as critical
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Jun 6, 2022 at 7:26 AM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> Hi Michael,
>
> On 6/5/22 19:57, Michael Trimarchi wrote:
> > If the clock is used to generate the osc_32k, we need to mark
> > as critical. clock-critical has no binding description at the moment
> > but it's defined in linux kernel
> >
> > bd71847: pmic@4b {
> > ...
> >       rohm,reset-snvs-powered;
> >
> >       #clock-cells = <0>;
> >       clock-critical = <1>;
> >       clocks = <&osc_32k 0>;
> >       clock-output-names = "clk-32k-out";
> > ...
> > }
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >   drivers/clk/clk-bd718x7.c | 4 ++++
>
> //snip
>
> > @@ -100,6 +101,9 @@ static int bd71837_clk_probe(struct platform_device *pdev)
> >
> >       parent_clk = of_clk_get_parent_name(parent->of_node, 0);
> >
> > +     of_clk_detect_critical(dev->of_node, 0, &flags);
>
> Purely judging the kerneldoc for of_clk_detect_critical - you may have
> hard time getting this accepted.
>

This is the reason for RFC. I have already seen the usage of this in

ainline/master:drivers/clk/st/clk-flexgen.c:
of_clk_detect_critical(np, i, &flex_flags);
mainline/master:drivers/clk/st/clkgen-fsyn.c:
of_clk_detect_critical(np, fschan, &flags);
mainline/master:drivers/clk/st/clkgen-pll.c:
of_clk_detect_critical(np, 0, &pll_flags);
mainline/master:drivers/clk/st/clkgen-pll.c:
of_clk_detect_critical(np, odf, &odf_flags);

> I think you're working on a very valid problem though. Maybe you could
> see if you could align your effort with Marek?
>
> https://lore.kernel.org/all/20220517235919.200375-1-marex@denx.de/T/#m52d6d0831bf43d5f293e35cb27f3021f278d0564
>

I have seen the Marek patcheset now. I don't know if they works anyway
for a clock that is a part of MFD controller

Michael

> Best Regards
>         -- Matti
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>
> Discuss - Estimate - Plan - Report and finally accomplish this:
> void do_work(int time) __attribute__ ((const));



-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
