Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49735508802
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378472AbiDTMYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353046AbiDTMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:24:52 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B931DC4;
        Wed, 20 Apr 2022 05:22:06 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i196so1624489ioa.1;
        Wed, 20 Apr 2022 05:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIMuGelOwwNQPwE8FTN91rI+ZWWawKZ6vr/oEWb7r+g=;
        b=L9rw5Zhh1ttkACZ/UGkE41DhurYpDRfwGSN0hXY3lcyM86w4izh9lfYEKMQA2eqfl5
         2YnZx5keDv1+QJa5V6FjhombQD+A7uRVFdVH5in7N87ElIKD774KuDHwcEVQ3FHUwvY7
         F1ugXlCzETRdv2V/dHui53j2ZCkbyjbv6M7XT8C859yRfW3GY8ptWYCq7Acj+NHGGDZe
         Z8TQqJepf7XKTF9shFLSwBQ2fld+kNvCVXZyjXI2PPp2ApIYjJ6CMOsB9ayJfhKXn1E1
         uKXVJdXz85Rmi4YVg9eRM8nW2tzIdU//ZPnPbffGTfGWcAF4XZqxMBjPaB/4YCto+tdP
         yBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIMuGelOwwNQPwE8FTN91rI+ZWWawKZ6vr/oEWb7r+g=;
        b=XWQyAnVUXLbpkmcTd0dIvmj+mFKHD1zwGsqSzja4Iob2ZeQ4RSKySwFoC2XkdsXnsW
         kpvmKbao+WAPLHjXmfzm/GcSNFGC89YJG+9w/gl3y73Qn3aAkIvJxxAdVQWlN+EXHDCj
         pebegsUmdE+B5iQK/pf//1K0+d1tI94hx37Xhp3gIhWn8dBt7xZC4EQbAKLvZTXL6IAG
         oX27Q9750NTchMxmsfR15NDuelwk5IVrskdWHHJWsyqz8gL9VWg77ME/pHs9lXb39RdQ
         lkINPxFP+qhXHn5INHZpJNLWO2CTeOKOMlNd15se0EmWhiMVJRyHvXPJlxHNU2byLT1W
         61uA==
X-Gm-Message-State: AOAM533rAPMYT6vKLS7ojvgTNu51ke74Pd+a2frqmj9HuMAlgXtDwxrm
        Q74o9KD9qSKpw8epNfMKiMREN6SHWfCkYCWz+30=
X-Google-Smtp-Source: ABdhPJzTPl3fpisqquEunK202EZu+8nIk8CqPrym6nw4Ij8xrv+W8LHM0AuAQ5fzaPtaanpkSEYPKBd97UXjkMJwTQo=
X-Received: by 2002:a05:6602:1c6:b0:657:2c41:7d0 with SMTP id
 w6-20020a05660201c600b006572c4107d0mr94775iot.31.1650457326295; Wed, 20 Apr
 2022 05:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220330094126.30252-1-alistair@alistair23.me>
 <20220330094126.30252-2-alistair@alistair23.me> <45acc349-8fea-f755-065c-c561949c45af@roeck-us.net>
In-Reply-To: <45acc349-8fea-f755-065c-c561949c45af@roeck-us.net>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 20 Apr 2022 22:21:40 +1000
Message-ID: <CAKmqyKOqjperoku_uOy4sCa6LmCUtfB7SCvhLEKxLtcwDkzRyA@mail.gmail.com>
Subject: Re: [PATCH v20 1/4] mfd: silergy,sy7636a: Add config option
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Zhang Rui <rui.zhang@intel.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 6:02 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/30/22 02:41, Alistair Francis wrote:
> > Add a specific MFD_SY7636A config option.
> >
> > As part of this change we can use MFD_SY7636A as a dependency for all
> > SY7636a components and also remove the name from MFD_SIMPLE_MFD_I2C as
> > it no longer needs to be selectable.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Any chance of getting this in for 5.18? It would be nice to have the
configs all sorted before the release

Alistair

>
> > ---
> >   drivers/hwmon/Kconfig     |  1 +
> >   drivers/mfd/Kconfig       | 12 +++++++++++-
> >   drivers/regulator/Kconfig |  1 +
> >   3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 68a8a27ab3b7..74b60d24e740 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1693,6 +1693,7 @@ config SENSORS_SIS5595
> >
> >   config SENSORS_SY7636A
> >       tristate "Silergy SY7636A"
> > +     depends on MFD_SY7636A
> >       help
> >         If you say yes here you get support for the thermistor readout of
> >         the Silergy SY7636A PMIC.
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 3b59456f5545..c47cb755757b 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1095,6 +1095,16 @@ config MFD_SPMI_PMIC
> >         Say M here if you want to include support for the SPMI PMIC
> >         series as a module.  The module will be called "qcom-spmi-pmic".
> >
> > +config MFD_SY7636A
> > +     tristate "Silergy SY7636A voltage regulator"
> > +     depends on I2C
> > +     select MFD_SIMPLE_MFD_I2C
> > +     help
> > +       Enable support for Silergy SY7636A voltage regulator.
> > +
> > +       To enable support for building sub-devices as modules,
> > +       choose M here.
> > +
> >   config MFD_RDC321X
> >       tristate "RDC R-321x southbridge"
> >       select MFD_CORE
> > @@ -1202,7 +1212,7 @@ config MFD_SI476X_CORE
> >         module will be called si476x-core.
> >
> >   config MFD_SIMPLE_MFD_I2C
> > -     tristate "Simple Multi-Functional Device support (I2C)"
> > +     tristate
> >       depends on I2C
> >       select MFD_CORE
> >       select REGMAP_I2C
> > diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> > index 5ef2306fce04..c8ce6e5eea24 100644
> > --- a/drivers/regulator/Kconfig
> > +++ b/drivers/regulator/Kconfig
> > @@ -1219,6 +1219,7 @@ config REGULATOR_STW481X_VMMC
> >
> >   config REGULATOR_SY7636A
> >       tristate "Silergy SY7636A voltage regulator"
> > +     depends on MFD_SY7636A
> >       help
> >         This driver supports Silergy SY3686A voltage regulator.
> >
>
