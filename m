Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93D257626A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiGONDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGONDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:03:23 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F60014D0F;
        Fri, 15 Jul 2022 06:03:21 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y195so8412052yby.0;
        Fri, 15 Jul 2022 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9yO8MfMUBm0zXpBSRICBb2k8H22ZvfoQekpeKKbMY8=;
        b=ZU1aQErjkHvtpffZqs7vqEZpq/ovaXDqORhIxjOaZ3hb5CFW6gw1K4YSQPQq4o6FGa
         YIC7PQs0eVG06radEeZN8txXfy3Pu2jMIZIdEk7DgKebiINetikDJYHYcyk/dyQGwuXi
         ADBh1phiFHM9PU6/0C81GGu54kS3V2Hq28+heFMJV/FVLtvupIq7FbUUPNkyuKw8ZnWy
         hU6/OadU/8VM9b3gozezC14ioTpVz+atovwvKrg3GZuyeOEjMhwVLzSdaZGDQGY6G+09
         iKofJLZPvA3H2v+XzXWZ1l2XH9vbG/7GiS3d0LfrR2sOJDaR+gm70/w1KRnaTWKy3YmF
         FQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9yO8MfMUBm0zXpBSRICBb2k8H22ZvfoQekpeKKbMY8=;
        b=WXqoAWEL5tbrv8T6sXt/+tH6ATEcaR4YIcw4OsLRxL1PxUA9ug3mEJnEV+Hevu+N78
         0463dx0CluiG+jA0cmQZ3l7Lber9n3sxH1Liyk8TD6ma6QKO5oHwkqi95k+HdnoASAyz
         hjVvzNinXB68kGzZ/y9Nwlot1blJRgvPMgJfVy1/cSGd78pES9crTxzLp4VGdxgiuGBi
         KUCbXH9y+gDNl+dq7kqUOI9brwwvhP2Yp23U0TsTCfzS/CE5cXtvGyuD4rouCquWH+Pk
         +836gav+E39YmekKrjJsUTqcsc2Iss5L3hfdgXrELSwqqqYBNDEOUyqr4LtJE/YrRBNi
         A6Bw==
X-Gm-Message-State: AJIora8/rYMhQvfTOfMSWkn0U6uAGwz0utFykAHTwmxtgvzJXnEUQnej
        o4IBXZ4D4Gg/qINGVGHnxmCjgnSLnc06u8DheBbSPHH/pRg=
X-Google-Smtp-Source: AGRyM1vLMjs9/c27OFxyPZrjW40XpOuneI9SyNRB6WWhNQnummhq5sWLiwm+0JFxrahzVXtTzLFcqnFmXHtsf0ARIE8=
X-Received: by 2002:a05:6902:1143:b0:66e:eb08:4c23 with SMTP id
 p3-20020a056902114300b0066eeb084c23mr14473306ybu.570.1657890200260; Fri, 15
 Jul 2022 06:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220715112607.591-1-peterwu.pub@gmail.com> <20220715112607.591-8-peterwu.pub@gmail.com>
In-Reply-To: <20220715112607.591-8-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jul 2022 15:02:43 +0200
Message-ID: <CAHp75Veb3e2q-6J6fHwTrMLPXNirSH9=NpcDeNwjBiSydjiJRA@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] mfd: mt6370: Add MediaTek MT6370 support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 1:28 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> This adds support for the MediaTek MT6370 SubPMIC. MediaTek MT6370 is a
> SubPMIC consisting of a single cell battery charger with ADC monitoring,
> RGB LEDs, dual channel flashlight, WLED backlight driver, display bias
> voltage supply, one general purpose LDO, and the USB Type-C & PD controller
> complies with the latest USB Type-C and PD standards.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> v5
>
> - Add the comma in the last REGMAP_IRQ_REG_LINE(),
>   DEFINE_RES_IRQ_NAMED() and MFD_CELL_RES()
> - Add the prefix in the first parameter of all mfd_cell
> - Move enum and struct mt6370_info to mt6370.h
> - Remove struct device *dev in struct mt6370_info
> - Revise the description of Kconfig help text
> - Revise MODULE_DESCRIPTION()
> ---
>  drivers/mfd/Kconfig  |  16 +++
>  drivers/mfd/Makefile |   1 +
>  drivers/mfd/mt6370.c | 281 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/mt6370.h |  99 ++++++++++++++++++
>  4 files changed, 397 insertions(+)
>  create mode 100644 drivers/mfd/mt6370.c
>  create mode 100644 drivers/mfd/mt6370.h
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456..a9bcae3 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -937,6 +937,22 @@ config MFD_MT6360
>           PMIC part includes 2-channel BUCKs and 2-channel LDOs
>           LDO part includes 4-channel LDOs
>
> +config MFD_MT6370
> +       tristate "MediaTek MT6370 SubPMIC"
> +       select MFD_CORE
> +       select REGMAP_I2C
> +       select REGMAP_IRQ
> +       depends on I2C
> +       help
> +         Say Y here to enable MT6370 SubPMIC functional support.
> +         It consists of a single cell battery charger with ADC monitoring, RGB
> +         LEDs, dual channel flashlight, WLED backlight driver, display bias
> +         voltage supply, one general purpose LDO, and the USB Type-C & PD
> +         controller complies with the latest USB Type-C and PD standards.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called "mt6370".
> +
>  config MFD_MT6397
>         tristate "MediaTek MT6397 PMIC Support"
>         select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 8c69867..81dbed3 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -173,6 +173,7 @@ obj-$(CONFIG_MFD_MAX8998)   += max8998.o max8998-irq.o
>  obj-$(CONFIG_MFD_MP2629)       += mp2629.o
>
>  obj-$(CONFIG_MFD_MT6360)       += mt6360-core.o
> +obj-$(CONFIG_MFD_MT6370)       += mt6370.o
>  mt6397-objs                    := mt6397-core.o mt6397-irq.o mt6358-irq.o
>  obj-$(CONFIG_MFD_MT6397)       += mt6397.o
>
> diff --git a/drivers/mfd/mt6370.c b/drivers/mfd/mt6370.c
> new file mode 100644
> index 0000000..070c1c7
> --- /dev/null
> +++ b/drivers/mfd/mt6370.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Richtek Technology Corp.
> + *
> + * Author: ChiYuan Huang <cy_huang@richtek.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "mt6370.h"
> +
> +#define MT6370_REG_DEV_INFO    0x100
> +#define MT6370_REG_CHG_IRQ1    0x1C0
> +#define MT6370_REG_CHG_MASK1   0x1E0
> +
> +#define MT6370_VENID_MASK      GENMASK(7, 4)
> +
> +#define MT6370_NUM_IRQREGS     16
> +#define MT6370_USBC_I2CADDR    0x4E
> +#define MT6370_REG_ADDRLEN     2
> +#define MT6370_REG_MAXADDR     0x1FF
> +
> +#define MT6370_VENID_RT5081    0x8
> +#define MT6370_VENID_RT5081A   0xA
> +#define MT6370_VENID_MT6370    0xE
> +#define MT6370_VENID_MT6371    0xF
> +#define MT6370_VENID_MT6372P   0x9
> +#define MT6370_VENID_MT6372CP  0xB
> +
> +static const struct regmap_irq mt6370_irqs[] = {
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DIRCHGON, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_TREG, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_AICR, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_MIVR, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_PWR_RDY, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FL_CHG_VINOVP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_VSYSUV, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_VSYSOV, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_VBATOV, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_VINOVPCHG, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_TS_BAT_COLD, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_TS_BAT_COOL, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_TS_BAT_WARM, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_TS_BAT_HOT, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_TS_STATC, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_FAULT, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_STATC, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_TMR, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_BATABS, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_ADPBAD, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_RVP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_TSHUTDOWN, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_IINMEAS, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_ICCMEAS, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHGDET_DONE, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_WDTMR, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_SSFINISH, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_RECHG, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_TERM, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHG_IEOC, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_ADC_DONE, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_PUMPX_DONE, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_BST_BATUV, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_BST_MIDOV, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_BST_OLP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_ATTACH, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DETACH, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_HVDCP_STPDONE, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_HVDCP_VBUSDET_DONE, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_HVDCP_DET, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_CHGDET, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DCDT, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DIRCHG_VGOK, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DIRCHG_WDTMR, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DIRCHG_UC, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DIRCHG_OC, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DIRCHG_OV, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_OVPCTRL_SWON, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_OVPCTRL_UVP_D, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_OVPCTRL_UVP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_OVPCTRL_OVP_D, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_OVPCTRL_OVP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED_STRBPIN, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED_TORPIN, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED_TX, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED_LVF, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED2_SHORT, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED1_SHORT, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED2_STRB, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED1_STRB, 8),
> +       REGMAP_IRQ_REG_LINE(mT6370_IRQ_FLED2_STRB_TO, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED1_STRB_TO, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED2_TOR, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED1_TOR, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_OTP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_VDDA_OVP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_VDDA_UV, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_LDO_OC, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_BLED_OCP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_BLED_OVP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DSV_VNEG_OCP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DSV_VPOS_OCP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DSV_BST_OCP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DSV_VNEG_SCP, 8),
> +       REGMAP_IRQ_REG_LINE(MT6370_IRQ_DSV_VPOS_SCP, 8),
> +};
> +
> +static const struct regmap_irq_chip mt6370_irq_chip = {
> +       .name           = "mt6370-irqs",
> +       .status_base    = MT6370_REG_CHG_IRQ1,
> +       .mask_base      = MT6370_REG_CHG_MASK1,
> +       .num_regs       = MT6370_NUM_IRQREGS,
> +       .irqs           = mt6370_irqs,
> +       .num_irqs       = ARRAY_SIZE(mt6370_irqs),
> +};
> +
> +static const struct resource mt6370_regulator_irqs[] = {
> +       DEFINE_RES_IRQ_NAMED(MT6370_IRQ_DSV_VPOS_SCP, "db_vpos_scp"),
> +       DEFINE_RES_IRQ_NAMED(MT6370_IRQ_DSV_VNEG_SCP, "db_vneg_scp"),
> +       DEFINE_RES_IRQ_NAMED(MT6370_IRQ_DSV_BST_OCP, "db_vbst_ocp"),
> +       DEFINE_RES_IRQ_NAMED(MT6370_IRQ_DSV_VPOS_OCP, "db_vpos_ocp"),
> +       DEFINE_RES_IRQ_NAMED(MT6370_IRQ_DSV_VNEG_OCP, "db_vneg_ocp"),
> +       DEFINE_RES_IRQ_NAMED(MT6370_IRQ_LDO_OC, "ldo_oc"),
> +};
> +
> +static const struct mfd_cell mt6370_devices[] = {
> +       MFD_CELL_OF("mt6370-adc",
> +                   NULL, NULL, 0, 0, "mediatek,mt6370-adc"),
> +       MFD_CELL_OF("mt6370-charger",
> +                   NULL, NULL, 0, 0, "mediatek,mt6370-charger"),
> +       MFD_CELL_OF("mt6370-backlight",
> +                   NULL, NULL, 0, 0, "mediatek,mt6370-backlight"),
> +       MFD_CELL_OF("mt6370-flashlight",
> +                   NULL, NULL, 0, 0, "mediatek,mt6370-flashlight"),
> +       MFD_CELL_OF("mt6370-indicator",
> +                   NULL, NULL, 0, 0, "mediatek,mt6370-indicator"),
> +       MFD_CELL_OF("mt6370-tcpc",
> +                   NULL, NULL, 0, 0, "mediatek,mt6370-tcpc"),
> +       MFD_CELL_RES("mt6370-regulator", mt6370_regulator_irqs),
> +};
> +
> +static int mt6370_check_vendor_info(struct device *dev, struct regmap *rmap)
> +{
> +       unsigned int devinfo;
> +       int ret;
> +
> +       ret = regmap_read(rmap, MT6370_REG_DEV_INFO, &devinfo);
> +       if (ret)
> +               return ret;
> +
> +       switch (FIELD_GET(MT6370_VENID_MASK, devinfo)) {
> +       case MT6370_VENID_RT5081:
> +       case MT6370_VENID_RT5081A:
> +       case MT6370_VENID_MT6370:
> +       case MT6370_VENID_MT6371:
> +       case MT6370_VENID_MT6372P:
> +       case MT6370_VENID_MT6372CP:
> +               return 0;
> +       default:
> +               dev_err(dev, "Unknown Vendor ID 0x%02x\n", devinfo);
> +               return -ENODEV;
> +       }
> +}
> +
> +static int mt6370_regmap_read(void *context, const void *reg_buf,
> +                             size_t reg_size, void *val_buf, size_t val_size)
> +{
> +       struct mt6370_info *info = context;
> +       const u8 *u8_buf = reg_buf;
> +       u8 bank_idx, bank_addr;
> +       int ret;
> +
> +       bank_idx = u8_buf[0];
> +       bank_addr = u8_buf[1];
> +
> +       ret = i2c_smbus_read_i2c_block_data(info->i2c[bank_idx], bank_addr,
> +                                           val_size, val_buf);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (ret != val_size)
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static int mt6370_regmap_write(void *context, const void *data, size_t count)
> +{
> +       struct mt6370_info *info = context;
> +       const u8 *u8_buf = data;
> +       u8 bank_idx, bank_addr;
> +       int len = count - MT6370_REG_ADDRLEN;
> +
> +       bank_idx = u8_buf[0];
> +       bank_addr = u8_buf[1];
> +
> +       return i2c_smbus_write_i2c_block_data(info->i2c[bank_idx], bank_addr,
> +                                             len, data + MT6370_REG_ADDRLEN);
> +}
> +
> +static const struct regmap_bus mt6370_regmap_bus = {
> +       .read           = mt6370_regmap_read,
> +       .write          = mt6370_regmap_write,
> +};
> +
> +static const struct regmap_config mt6370_regmap_config = {
> +       .reg_bits               = 16,
> +       .val_bits               = 8,
> +       .reg_format_endian      = REGMAP_ENDIAN_BIG,
> +       .max_register           = MT6370_REG_MAXADDR,
> +};
> +
> +static int mt6370_probe(struct i2c_client *i2c)
> +{
> +       struct mt6370_info *info;
> +       struct i2c_client *usbc_i2c;
> +       struct regmap *regmap;
> +       struct device *dev = &i2c->dev;
> +       int ret;
> +
> +       info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       usbc_i2c = devm_i2c_new_dummy_device(dev, i2c->adapter,
> +                                            MT6370_USBC_I2CADDR);
> +       if (IS_ERR(usbc_i2c))
> +               return dev_err_probe(dev, PTR_ERR(usbc_i2c),
> +                                    "Failed to register USBC I2C client\n");
> +
> +       /* Assign I2C client for PMU and TypeC */
> +       info->i2c[MT6370_PMU_I2C] = i2c;
> +       info->i2c[MT6370_USBC_I2C] = usbc_i2c;
> +
> +       regmap = devm_regmap_init(dev, &mt6370_regmap_bus,
> +                                 info, &mt6370_regmap_config);
> +       if (IS_ERR(regmap))
> +               return dev_err_probe(dev, PTR_ERR(regmap),
> +                                    "Failed to init regmap\n");
> +
> +       ret = mt6370_check_vendor_info(dev, regmap);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to check vendor info\n");
> +
> +       ret = devm_regmap_add_irq_chip(dev, regmap, i2c->irq,
> +                                      IRQF_ONESHOT, -1, &mt6370_irq_chip,
> +                                      &info->irq_data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to add irq chip\n");
> +
> +       return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> +                                   mt6370_devices, ARRAY_SIZE(mt6370_devices),
> +                                   NULL, 0,
> +                                   regmap_irq_get_domain(info->irq_data));
> +}
> +
> +static const struct of_device_id mt6370_match_table[] = {
> +       { .compatible = "mediatek,mt6370" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, mt6370_match_table);
> +
> +static struct i2c_driver mt6370_driver = {
> +       .driver = {
> +               .name = "mt6370",
> +               .of_match_table = mt6370_match_table,
> +       },
> +       .probe_new = mt6370_probe,
> +};
> +module_i2c_driver(mt6370_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("MediaTek MT6370 SubPMIC Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mfd/mt6370.h b/drivers/mfd/mt6370.h
> new file mode 100644
> index 0000000..094e59e
> --- /dev/null
> +++ b/drivers/mfd/mt6370.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2022 Richtek Technology Corp.
> + *
> + * Author: ChiYuan Huang <cy_huang@richtek.com>
> + */
> +
> +#ifndef __MFD_MT6370_H__
> +#define __MFD_MT6370_H__
> +
> +/* IRQ definitions */
> +#define MT6370_IRQ_DIRCHGON            0
> +#define MT6370_IRQ_CHG_TREG            4
> +#define MT6370_IRQ_CHG_AICR            5
> +#define MT6370_IRQ_CHG_MIVR            6
> +#define MT6370_IRQ_PWR_RDY             7
> +#define MT6370_IRQ_FL_CHG_VINOVP       11
> +#define MT6370_IRQ_CHG_VSYSUV          12
> +#define MT6370_IRQ_CHG_VSYSOV          13
> +#define MT6370_IRQ_CHG_VBATOV          14
> +#define MT6370_IRQ_CHG_VINOVPCHG       15
> +#define MT6370_IRQ_TS_BAT_COLD         20
> +#define MT6370_IRQ_TS_BAT_COOL         21
> +#define MT6370_IRQ_TS_BAT_WARM         22
> +#define MT6370_IRQ_TS_BAT_HOT          23
> +#define MT6370_IRQ_TS_STATC            24
> +#define MT6370_IRQ_CHG_FAULT           25
> +#define MT6370_IRQ_CHG_STATC           26
> +#define MT6370_IRQ_CHG_TMR             27
> +#define MT6370_IRQ_CHG_BATABS          28
> +#define MT6370_IRQ_CHG_ADPBAD          29
> +#define MT6370_IRQ_CHG_RVP             30
> +#define MT6370_IRQ_TSHUTDOWN           31
> +#define MT6370_IRQ_CHG_IINMEAS         32
> +#define MT6370_IRQ_CHG_ICCMEAS         33
> +#define MT6370_IRQ_CHGDET_DONE         34
> +#define MT6370_IRQ_WDTMR               35
> +#define MT6370_IRQ_SSFINISH            36
> +#define MT6370_IRQ_CHG_RECHG           37
> +#define MT6370_IRQ_CHG_TERM            38
> +#define MT6370_IRQ_CHG_IEOC            39
> +#define MT6370_IRQ_ADC_DONE            40
> +#define MT6370_IRQ_PUMPX_DONE          41
> +#define MT6370_IRQ_BST_BATUV           45
> +#define MT6370_IRQ_BST_MIDOV           46
> +#define MT6370_IRQ_BST_OLP             47
> +#define MT6370_IRQ_ATTACH              48
> +#define MT6370_IRQ_DETACH              49
> +#define MT6370_IRQ_HVDCP_STPDONE       51
> +#define MT6370_IRQ_HVDCP_VBUSDET_DONE  52
> +#define MT6370_IRQ_HVDCP_DET           53
> +#define MT6370_IRQ_CHGDET              54
> +#define MT6370_IRQ_DCDT                        55
> +#define MT6370_IRQ_DIRCHG_VGOK         59
> +#define MT6370_IRQ_DIRCHG_WDTMR                60
> +#define MT6370_IRQ_DIRCHG_UC           61
> +#define MT6370_IRQ_DIRCHG_OC           62
> +#define MT6370_IRQ_DIRCHG_OV           63
> +#define MT6370_IRQ_OVPCTRL_SWON                67
> +#define MT6370_IRQ_OVPCTRL_UVP_D       68
> +#define MT6370_IRQ_OVPCTRL_UVP         69
> +#define MT6370_IRQ_OVPCTRL_OVP_D       70
> +#define MT6370_IRQ_OVPCTRL_OVP         71
> +#define MT6370_IRQ_FLED_STRBPIN                72
> +#define MT6370_IRQ_FLED_TORPIN         73
> +#define MT6370_IRQ_FLED_TX             74
> +#define MT6370_IRQ_FLED_LVF            75
> +#define MT6370_IRQ_FLED2_SHORT         78
> +#define MT6370_IRQ_FLED1_SHORT         79
> +#define MT6370_IRQ_FLED2_STRB          80
> +#define MT6370_IRQ_FLED1_STRB          81
> +#define mT6370_IRQ_FLED2_STRB_TO       82
> +#define MT6370_IRQ_FLED1_STRB_TO       83
> +#define MT6370_IRQ_FLED2_TOR           84
> +#define MT6370_IRQ_FLED1_TOR           85
> +#define MT6370_IRQ_OTP                 93
> +#define MT6370_IRQ_VDDA_OVP            94
> +#define MT6370_IRQ_VDDA_UV             95
> +#define MT6370_IRQ_LDO_OC              103
> +#define MT6370_IRQ_BLED_OCP            118
> +#define MT6370_IRQ_BLED_OVP            119
> +#define MT6370_IRQ_DSV_VNEG_OCP                123
> +#define MT6370_IRQ_DSV_VPOS_OCP                124
> +#define MT6370_IRQ_DSV_BST_OCP         125
> +#define MT6370_IRQ_DSV_VNEG_SCP                126
> +#define MT6370_IRQ_DSV_VPOS_SCP                127
> +
> +enum {
> +       MT6370_USBC_I2C = 0,
> +       MT6370_PMU_I2C,
> +       MT6370_MAX_I2C
> +};
> +
> +struct mt6370_info {
> +       struct i2c_client *i2c[MT6370_MAX_I2C];
> +       struct regmap_irq_chip_data *irq_data;
> +};
> +
> +#endif /* __MFD_MT6375_H__ */
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
