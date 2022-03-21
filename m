Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64C4E2280
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbiCUItt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345416AbiCUItp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:49:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A6336322
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:48:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r64so8049418wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=brnXMh1CbWOf98YxRTTsbDywHUHYCG+alkGn638zm4M=;
        b=BlvyFCPLzsBlbqrGCBKMzUMgqnN4kBv+EO9dx8QQtssv6ckryQh3ESbB0tYPRif6dL
         PQn/As6uwDdRoWY21u8wppLgTnZykIXKGSFnDgt5Po/mkiunB+qy9MsDY0yTY/uKF3WB
         sAs24txOAa24hCWmiTH5GQ5e/6zgUSgXaQ/s5vHQCnF7ZqYuBFE8jlJ271X3Ifp3kSbk
         oRviKWNDfWLbKPJgE5HwmEtlVjLHpSWY8BjQzOumsFJdcizDE0EhG6WrDquo1l55Bjhb
         01MutrJ5hAhUt8Zx0TeSLGebmKBFqikFDcqdcQ5V9/MzSWjEheVNeNdpOQPPiqstNcwj
         MpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=brnXMh1CbWOf98YxRTTsbDywHUHYCG+alkGn638zm4M=;
        b=2WlCKx7xfJH9cCHsSshEMH6097eeL2fRacMD8fTiam7rkYv4p7aRGEWxquQgDUnJoa
         h8XayvqwhNMVYe8IBcfGiiLeJWQmhq0PHnzef54pOErZoWka8OwnG9NeogBziueVH0/x
         oqAn4VH5CNdFH5pjHtgbgjGqFFM0lUBrgmBWuNIeiVSLmHdNd8iM8SRcXHSKIZCjiuZ1
         tdnnpJkBDrdcOAvgL14DFGYFLf1r/d8MkcUZcK3jjxpCMd4twzokSVokjaYagaWJvEOy
         XWXPR/pG7H+iM9mBsd1eR3v2019TtkzNLzSZT5bwLD4d1H662gVUO91WY6BSZfIlV8V8
         4CiQ==
X-Gm-Message-State: AOAM531vydYsqM8lcrqKalgmL0wRb1clbC2AauAxiVCg9438tUQrOOsv
        A3ulsE8DK98XDqAOHBn4aKun2w==
X-Google-Smtp-Source: ABdhPJxnXFWsEU7vaoMmlVg9NGIu10kQCl58O2xgYQ/I7PBvG0Dpr0PE2qPzya1IuKdxtEa00L4u6A==
X-Received: by 2002:a7b:c14d:0:b0:38c:801a:a8b3 with SMTP id z13-20020a7bc14d000000b0038c801aa8b3mr15884385wmi.40.1647852496516;
        Mon, 21 Mar 2022 01:48:16 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm8691375wry.53.2022.03.21.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 01:48:15 -0700 (PDT)
Date:   Mon, 21 Mar 2022 08:48:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alistair Francis <alistair@alistair23.me>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v18 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
Message-ID: <Yjg7zS0kFAM0EhZO@google.com>
References: <20220124121009.108649-1-alistair@alistair23.me>
 <20220124121009.108649-3-alistair@alistair23.me>
 <CAMuHMdVNgVQzjrdybbnfCEr+G5Q4ztjRCC29RF9HwGnhKkPn3Q@mail.gmail.com>
 <CAKmqyKOnezw8_dDY-c69F77KVxmb-C3t=N3H23GurKbrxWDAgg@mail.gmail.com>
 <CAMuHMdVy4E1pX+VLLq_05FX4pM+BPZycQgn68ArGh2s8qL24=w@mail.gmail.com>
 <7792b3b6-e196-c3c7-5875-9eb4da488a95@roeck-us.net>
 <CAKmqyKO2x0V6p8LVsgq54f1KcghVhW2jw6zmUOFxbf6Zh+0BNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKO2x0V6p8LVsgq54f1KcghVhW2jw6zmUOFxbf6Zh+0BNA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022, Alistair Francis wrote:

> On Sun, Mar 20, 2022 at 12:48 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 3/19/22 02:28, Geert Uytterhoeven wrote:
> > > Hi Alistair,
> > >
> > > On Sat, Mar 19, 2022 at 3:36 AM Alistair Francis <alistair23@gmail.com> wrote:
> > >> On Tue, Mar 8, 2022 at 8:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >>> Thanks for your patch, which is now commit bae5a4acef67db88
> > >>> ("mfd: simple-mfd-i2c: Add a Kconfig name") in mfd/for-mfd-next.
> > >>>
> > >>> On Mon, Jan 24, 2022 at 1:24 PM Alistair Francis <alistair@alistair23.me> wrote:
> > >>>> Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
> > >>>> device so that it can be enabled via menuconfig.
> > >>>
> > >>> Which still does not explain why this would be needed...
> > >>>
> > >>>> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > >>>> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > >>>
> > >>>> --- a/drivers/mfd/Kconfig
> > >>>> +++ b/drivers/mfd/Kconfig
> > >>>> @@ -1188,7 +1188,7 @@ config MFD_SI476X_CORE
> > >>>>            module will be called si476x-core.
> > >>>>
> > >>>>   config MFD_SIMPLE_MFD_I2C
> > >>>> -       tristate
> > >>>> +       tristate "Simple Multi-Functional Device support (I2C)"
> > >>>>          depends on I2C
> > >>>>          select MFD_CORE
> > >>>>          select REGMAP_I2C
> > >>>
> > >>> The help text states:
> > >>>
> > >>> | This driver creates a single register map with the intention for it
> > >>> | to be shared by all sub-devices.
> > >>>
> > >>> Yes, that's what MFD does?
> > >>>
> > >>> | Once the register map has been successfully initialised, any
> > >>> | sub-devices represented by child nodes in Device Tree will be
> > >>> | subsequently registered.
> > >>>
> > >>> OK...?
> > >>>
> > >>> Still, no clue about what this driver really does, and why and when
> > >>> it would be needed.
> > >>>
> > >>> There is one driver symbol that selects MFD_SIMPLE_MFD_I2C.
> > >>> There are no driver symbols that depend on this symbol.
> > >>>
> > >>> If you have a driver in the pipeline that can make use of this,
> > >>> can't it just select MFD_SIMPLE_MFD_I2C, so the symbol itself can
> > >>> stay invisible?
> > >>
> > >> My patch "mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a"
> > >> allows using this driver for the silergy,sy7636a MFD. So it's nice to
> > >> be able to enable and disable it as required.
> > >
> > > So after that patch, enabling MFD_SIMPLE_MFD_I2C will enable
> > > support for an ever-growing random bunch of devices, none of which
> > > is described in the help text?
> > > To me, ghat doesn't look like the way to go forward...
> > >
> >
> > I am probably missing something. Why not something like the following ?
> >
> > config MFD_SY7636A
> >          tristate "Silergy SY7636A voltage regulator"
> >          depends on I2C
> >          select MFD_SIMPLE_MFD_I2C
> >          help
> >            Enable support for Silergy SY7636A voltage regulator.
> >
> >            To enable support for building sub-devices as modules,
> >            choose M here.
> >
> >
> > This would be quite similar to MFD_SL28CPLD which essentially does
> > the same (and, unless I am missing something, doesn't have its own
> > driver either). Sub-devices would then depend on MFD_SY7636A.
> 
> That's fine with me.
> 
> As you said this patch is already in the mfd/for-mfd-next tree, should
> I resend the series?

Making the symbol selectable-only is fine with me also.

Please send a subsequent patch.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
