Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45D5B1721
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiIHIeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiIHIdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:33:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694D7E1AB8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:33:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u9so36385667ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZlO9z6iariE6j62dDg3WdSSqBdCZFPhJNQtrGMOHOrM=;
        b=yoKt2dR8DpMlh2XORFcltXAYMgjes8PsrrPXKGawrKEhed4y+WSSTQmmNgG0Gf1SJu
         /FfQ3PEPixSLl61o/wNzP2mAl16GeJnsTLbhWLnWfaVkAwo6y83SYrJYUs2zfFeTOmCJ
         KCfvXIX2k6sUR9M4H2LnnadTsaJNBeTiS5ZBjIN9tOf2Kpq6GTWefCkCUFHSnLO/4AAN
         bF2Kwwu1NBRMUHGOV8o4kZ9m3PqjItvKGaAHum8EmxiW7WxhfY/+qFWuKiEN2m/2UZCf
         n8HtcVv1JxiPWMi7HHbrHpse1K4PW6ghIMCVLd1VC32slTHEjJxXugMgMhGNvWgPOPtq
         zkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZlO9z6iariE6j62dDg3WdSSqBdCZFPhJNQtrGMOHOrM=;
        b=6nxLSiY7SRvF6qD+NBfwcWLMOBr7DSKkxmmvqt/2hJfZlzhnUKZRR/BpdoJAnubw72
         HpMfpxTF/7aRaJedfzCmsHeTChyKY/kesFG6eVBeVXVnEBwq+iNpiNcyPe8HOgLD0G3k
         3SZWFTzkCYRlfjXpzSFRFZBHGvjTyz7FWqfedqu7M+lBSa+lHZbfngCinvK3lIOLzSOE
         p3DY2VuQH0JKuXjCABgHK8Fukj2KeM/UnwAkCMRT2P50xAA5fAibdbGEfQqKGNrBZa7r
         DyjPkmzoxDJkAH95itorUQvbX0FINSi0TO/LQgC0DW7oBp7MPNNATboPJgEiQyhTa44W
         /tyg==
X-Gm-Message-State: ACgBeo22kbvjZOUIXNTnZdv5Nz1r1XzAsmSb9DdDkh5MuDFKL7kVkwwr
        rUjantSdCNVURmEfPTnVKOVQrrXDskCNsYEWVCLB5g==
X-Google-Smtp-Source: AA6agR6YdmowLCqDy13X6GVFnJajdgoAbYXT6/9jX+Ol46w4Ykshwr2tFJzDmJvExLu3Rbp1DyOQwdZVX8mDYcaxnJ0=
X-Received: by 2002:a17:907:7242:b0:741:770b:dfc6 with SMTP id
 ds2-20020a170907724200b00741770bdfc6mr5235773ejc.203.1662626019497; Thu, 08
 Sep 2022 01:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-7-b29adfb27a6c@gmail.com> <YxaSBRkAG/hKjFol@google.com>
In-Reply-To: <YxaSBRkAG/hKjFol@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:33:28 +0200
Message-ID: <CACRpkdb2dYvNkyx7O24uURjSYcCPkGR+Gj=weCSG6GdcM1B7Xw@mail.gmail.com>
Subject: Re: [PATCH v1 07/11] PCI: apple: switch to using fwnode_gpiod_get_index()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
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

On Tue, Sep 6, 2022 at 2:19 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> On Sun, Sep 04, 2022 at 11:30:59PM -0700, Dmitry Torokhov wrote:
> > I would like to stop exporting OF-specific gpiod_get_from_of_node()
> > so that gpiolib can be cleaned a bit, so let's switch to the generic
> > fwnode property API.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> > index a2c3c207a04b..d83817d3ff86 100644
> > --- a/drivers/pci/controller/pcie-apple.c
> > +++ b/drivers/pci/controller/pcie-apple.c
> > @@ -516,8 +516,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
> >       u32 stat, idx;
> >       int ret, i;
> >
> > -     reset = gpiod_get_from_of_node(np, "reset-gpios", 0,
> > -                                    GPIOD_OUT_LOW, "PERST#");
> > +     reset = fwnode_gpiod_get_index(of_fwnode_handle(np),
> > +                                    "reset", 0, GPIOD_OUT_LOW, "PERST#");
>
> Hmm, I am looking at the driver and it leaks the reset gpio on
> unbind/unload. I guess it does not matter in practice, but still nice
> not to leak. Thankfully it is easy to cure by switching to devm option:
> devm_fwnode_gpiod_get().
>
> I'll send and updated patch with a new justification.

With that change:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
