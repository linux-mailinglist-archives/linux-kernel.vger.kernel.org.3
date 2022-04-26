Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AA350F72C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346417AbiDZJIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346298AbiDZIos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:44:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09DE8595F;
        Tue, 26 Apr 2022 01:34:33 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y19so9727928ljd.4;
        Tue, 26 Apr 2022 01:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FInGpHNCcK/TD9SeWZQkc/p1sMIqORL6XIEEOHsCc5Y=;
        b=CLHRbStTr+GP4H1R32XYex1OOt6UMLD5DVs8Y8EppitDdNDDEv0K1BqpOO1nDGDLMg
         hJUmM6Ct1NCX9Y/dkzc9REBoM5lxcvFeqQxnHg80MVzrsD8euorL5+x4rx9dTAKtpQbv
         ill+cLT7m/IGnGVSKzNglJwi1X6rpeCyAQd1j1+GBdy2wgoTh0NGPUJ9fGWS0KZokdH4
         /OsnqYPGkXtpFRbJ89GF22UABmikkL8DZNS0NNfTlireooayv+sMOgC/kZ8LAs1sDnc7
         TjjWm1xCrlXJNyfL5uatUqV7peHIfAgYeAMsWncycgiRKl2w0EQQU2X9yBpc91yYyJ95
         l+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FInGpHNCcK/TD9SeWZQkc/p1sMIqORL6XIEEOHsCc5Y=;
        b=XknsHJIYonIwDZ2e9Yz+K2ctJW6E7tMKmaf1qfsD6AhDCcnWAAKQUEjr/UBAA5s1ni
         enho2CW/gIJhrT5fSxBKPNGEQunZ54WdI5coYrcX1M8Oyi8QF4Y6KRoDIx+TgabkcLo+
         JkX/66MruvfA1jHEHBmw2oH0IhOCzozyZIEpzpJZQJBYasCB8X0W7xk10xbGjpT69X8j
         +WvShIvu7k4IocIyH+GyMubNDT13ycCFn5gi2cnPrPUb1c7lL3QywggIznLGsGcIiO/P
         KhssPIPhPxbiQxzsmfYEf16BCgvxXGkCCQvqFrjseuyUH/9YDGsysW/Ze0+QnyWCaQZa
         Es3Q==
X-Gm-Message-State: AOAM531oJ4Kas0iZz/iLUPUeWn7I9kNK+XETvhIIPYZMxSNgcU1sput1
        tcu8pwxaiwo5ioLFH5jTSCCaVxn7l34+2p9XXqI=
X-Google-Smtp-Source: ABdhPJxeMid+gRhAqzBjhRPHQFzn6lFG1yCpNvUP7oiHdtWHc0z7NiIkWEb0UaQ2oPUse7gCnz2myidtn5jCf4tPuwk=
X-Received: by 2002:a2e:8e91:0:b0:24d:aac1:f855 with SMTP id
 z17-20020a2e8e91000000b0024daac1f855mr14178666ljk.28.1650962072007; Tue, 26
 Apr 2022 01:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <1646393418-26421-1-git-send-email-vincent.sunplus@gmail.com>
 <1646393418-26421-2-git-send-email-vincent.sunplus@gmail.com> <YlactHJyZ6QnNV5j@matsya>
In-Reply-To: <YlactHJyZ6QnNV5j@matsya>
From:   =?UTF-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Date:   Tue, 26 Apr 2022 16:37:08 +0800
Message-ID: <CAPvp3RgEic_mR1meQqyg1JR3vuuRpsNHMGqyvu3d63TGhn-k6Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] phy: usb: Add USB2.0 phy driver for Sunplus SP7021
To:     Vinod Koul <vkoul@kernel.org>
Cc:     kishon@ti.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vinod Koul <vkoul@kernel.org> =E6=96=BC 2022=E5=B9=B44=E6=9C=8813=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 04-03-22, 19:30, Vincent Shih wrote:
> > Add USB2.0 phy driver for Sunplus SP7021
> >
> > Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> > ---
> >  MAINTAINERS                            |   8 ++
> >  drivers/phy/Kconfig                    |   1 +
> >  drivers/phy/Makefile                   |   1 +
> >  drivers/phy/sunplus/Kconfig            |  12 ++
> >  drivers/phy/sunplus/Makefile           |   2 +
> >  drivers/phy/sunplus/phy-sunplus-usb2.c | 248 +++++++++++++++++++++++++=
++++++++
> >  6 files changed, 272 insertions(+)
> >  create mode 100644 drivers/phy/sunplus/Kconfig
> >  create mode 100644 drivers/phy/sunplus/Makefile
> >  create mode 100644 drivers/phy/sunplus/phy-sunplus-usb2.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 80eebc1..a3bb35e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17947,6 +17947,14 @@ L:   netdev@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/net/ethernet/dlink/sundance.c
> >
> > +SUNPLUS USB2 PHY DRIVER
> > +M:   Vincent Shih <vincent.sunplus@gmail.com>
> > +L:   linux-usb@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/phy/sunplus/Kconfig
> > +F:   drivers/phy/sunplus/Makefile
> > +F:   drivers/phy/sunplus/phy-sunplus-usb2.c
> > +
> >  SUPERH
> >  M:   Yoshinori Sato <ysato@users.sourceforge.jp>
> >  M:   Rich Felker <dalias@libc.org>
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 82b63e6..d97e22e 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -90,6 +90,7 @@ source "drivers/phy/rockchip/Kconfig"
> >  source "drivers/phy/samsung/Kconfig"
> >  source "drivers/phy/socionext/Kconfig"
> >  source "drivers/phy/st/Kconfig"
> > +source "drivers/phy/sunplus/Kconfig"
> >  source "drivers/phy/tegra/Kconfig"
> >  source "drivers/phy/ti/Kconfig"
> >  source "drivers/phy/intel/Kconfig"
> > diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> > index 01e9eff..ed88b6f 100644
> > --- a/drivers/phy/Makefile
> > +++ b/drivers/phy/Makefile
> > @@ -31,6 +31,7 @@ obj-y                                       +=3D allw=
inner/   \
> >                                          samsung/     \
> >                                          socionext/   \
> >                                          st/          \
> > +                                        sunplus/             \
> >                                          tegra/       \
> >                                          ti/          \
> >                                          xilinx/
> > diff --git a/drivers/phy/sunplus/Kconfig b/drivers/phy/sunplus/Kconfig
> > new file mode 100644
> > index 0000000..beb85f4
> > --- /dev/null
> > +++ b/drivers/phy/sunplus/Kconfig
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config PHY_SUNPLUS_USB
> > +     tristate "Sunplus USB2 PHY driver"
> > +     depends on OF && (SOC_SP7021 || COMPILE_TEST)
> > +     select GENERIC_PHY
> > +     help
> > +       Enable this to support the USB 2.0 PHY on Sunplus SP7021
> > +       SoC. The USB 2.0 PHY controller supports battery charger
> > +       and synchronous signals, various power down modes including
> > +       operating, partial and suspend modes, and high-speed,
> > +       full-speed and low-speed data transfer.
> > diff --git a/drivers/phy/sunplus/Makefile b/drivers/phy/sunplus/Makefil=
e
> > new file mode 100644
> > index 0000000..71754d5
> > --- /dev/null
> > +++ b/drivers/phy/sunplus/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_PHY_SUNPLUS_USB)        +=3D phy-sunplus-usb2.o
> > diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunpl=
us/phy-sunplus-usb2.c
> > new file mode 100644
> > index 0000000..a2c17ca
> > --- /dev/null
> > +++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
> > @@ -0,0 +1,248 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Sunplus SP7021 USB 2.0 phy driver
> > + *
> > + * Copyright (C) 2021 Sunplus Technology Inc., All rights reserved.
>
> 2022
>

I will modify it.

> > + *
> > + * Note 1 : non-posted write command for the registers accesses of
> > + * Sunplus SP7021.
> > + *
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset.h>
> > +
> > +#define RF_MASK_V(_mask, _val)                       (((_mask) << 16) =
| (_val))
> > +#define RF_MASK_V_CLR(_mask)                 (((_mask) << 16) | 0)
>
> Please use FIELD_PREP and FIELD_GET macros for these
>

I will modify it.

> > +
> > +#define MASK_BITS                            0xffff
> > +#define OTP_DISC_LEVEL_DEFAULT                       0xd
> > +
> > +// GROUP UPHY
> > +#define CONFIG1                                      0x4
> > +#define J_HS_TX_PWRSAV                               BIT(5)
> > +#define CONFIG3                                      0xc
>
> GENAMSK() ?
>

I will modify it.

>
> > +#define J_FORCE_DISC_ON                              BIT(5)
> > +#define J_DEBUG_CTRL_ADDR_MACRO                      BIT(0)
> > +#define CONFIG7                                      0x1c
> > +#define J_DISC                                       0X1f
> > +#define CONFIG9                                      0x24
> > +#define J_ECO_PATH                           BIT(6)
> > +#define CONFIG16                             0x40
> > +#define J_TBCWAIT_MASK                               GENMASK(6, 5)
> > +#define J_TBCWAIT_1P1_MS                     FIELD_PREP(J_TBCWAIT_MASK=
, 0)
> > +#define J_TVDM_SRC_DIS_MASK                  GENMASK(4, 3)
> > +#define J_TVDM_SRC_DIS_8P2_MS                        FIELD_PREP(J_TVDM=
_SRC_DIS_MASK, 3)
> > +#define J_TVDM_SRC_EN_MASK                   GENMASK(2, 1)
> > +#define J_TVDM_SRC_EN_1P6_MS                 FIELD_PREP(J_TVDM_SRC_EN_=
MASK, 0)
> > +#define J_BC_EN                                      BIT(0)
> > +#define CONFIG17                             0x44
> > +#define IBG_TRIM0_MASK                               GENMASK(7, 5)
> > +#define IBG_TRIM0_SSLVHT                     FIELD_PREP(IBG_TRIM0_MASK=
, 4)
> > +#define J_VDATREE_TRIM_MASK                  GENMASK(4, 1)
> > +#define J_VDATREE_TRIM_DEFAULT                       FIELD_PREP(J_VDAT=
REE_TRIM_MASK, 9)
> > +#define CONFIG23                             0x5c
> > +#define PROB_MASK                            GENMASK(5, 3)
> > +#define PROB                                 FIELD_PREP(PROB_MASK, 7)
> > +
> > +// GROUP MOON4
>
> wrong comments style
>

I will modify it.

> > +static int sp_uphy_init(struct phy *phy)
> > +{
> > +     struct sp_usbphy *usbphy =3D phy_get_drvdata(phy);
> > +     struct nvmem_cell *cell;
> > +     char *disc_name =3D "disc_vol";
> > +     ssize_t otp_l =3D 0;
> > +     char *otp_v;
> > +     u32 val, set, pll_pwr_on, pll_pwr_off;
> > +
> > +     /* Default value modification */
> > +     writel(RF_MASK_V(MASK_BITS, 0x4002), usbphy->moon4_regs + UPHY_CO=
NTROL0);
> > +     writel(RF_MASK_V(MASK_BITS, 0x8747), usbphy->moon4_regs + UPHY_CO=
NTROL1);
> > +
> > +     /* PLL power off/on twice */
> > +     pll_pwr_off =3D (readl(usbphy->moon4_regs + UPHY_CONTROL3) & ~MAS=
K_BITS)
> > +                     | MO1_UPHY_PLL_POWER_OFF_SEL | MO1_UPHY_PLL_POWER=
_OFF;
> > +     pll_pwr_on =3D (readl(usbphy->moon4_regs + UPHY_CONTROL3) & ~MASK=
_BITS)
> > +                     | MO1_UPHY_PLL_POWER_OFF_SEL;
> > +
> > +     writel(RF_MASK_V(MASK_BITS, pll_pwr_off), usbphy->moon4_regs + UP=
HY_CONTROL3);
> > +     mdelay(1);
> > +     writel(RF_MASK_V(MASK_BITS, pll_pwr_on), usbphy->moon4_regs + UPH=
Y_CONTROL3);
> > +     mdelay(1);
> > +     writel(RF_MASK_V(MASK_BITS, pll_pwr_off), usbphy->moon4_regs + UP=
HY_CONTROL3);
> > +     mdelay(1);
> > +     writel(RF_MASK_V(MASK_BITS, pll_pwr_on), usbphy->moon4_regs + UPH=
Y_CONTROL3);
> > +     mdelay(1);
>
> why delay on each register write?
>

They are for the stabilities of capacitors charge/discharge in the PCB boar=
d.

> > +     writel(RF_MASK_V(MASK_BITS, 0x0), usbphy->moon4_regs + UPHY_CONTR=
OL3);
> > +
> > +     /* board uphy 0 internal register modification for tid certificat=
ion */
> > +     cell =3D nvmem_cell_get(usbphy->dev, disc_name);
> > +     if (IS_ERR_OR_NULL(cell)) {
> > +             if (PTR_ERR(cell) =3D=3D -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> > +     }
> > +
> > +     otp_v =3D nvmem_cell_read(cell, &otp_l);
> > +     nvmem_cell_put(cell);
> > +
> > +     if (otp_v) {
> > +             set =3D *(otp_v + 1);
> > +             set =3D (set << (sizeof(char) * 8)) | *otp_v;
> > +             set =3D (set >> usbphy->disc_vol_addr_off) & J_DISC;
> > +     }
> > +
> > +     if (!otp_v || set =3D=3D 0)
> > +             set =3D OTP_DISC_LEVEL_DEFAULT;
> > +
> > +     val =3D readl(usbphy->phy_regs + CONFIG7);
> > +     val =3D (val & ~J_DISC) | set;
> > +     writel(val, usbphy->phy_regs + CONFIG7);
>
> maybe add a updatel() macro

I will add it.

>
> > +static const struct phy_ops sp_uphy_ops =3D {
> > +     .init           =3D sp_uphy_init,
>
> no power_on/off/exit routines??

I will implement them.

>
> > +static const struct of_device_id sp_uphy_dt_ids[] =3D {
> > +     {.compatible =3D "sunplus,sp7021-usb2-phy",
> > +      .data =3D &sp_uphy_ops,},
>
> why should the ops be in driver data?

I will modify it.

>
> --
> ~Vinod

Thanks for your review.
