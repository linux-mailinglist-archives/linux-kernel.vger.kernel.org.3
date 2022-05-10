Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A05A521C65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345022AbiEJOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344074AbiEJOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:11:55 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFEB140C7E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:45:39 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id j14so5723600vkp.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4j5heW0SerX1dieMEzzQdRhIZ6klymqFRtGtKNhBQuk=;
        b=SiyNLu7AHEf3GjUlWecnD8l40Ymi1BtHejii/bov0Deqt9T4Q68tQHv0njIy1tR2xt
         qG+CDpaSZ/WGqw9NrG1VrpLBN4L09mqEIEku2wTae1LicTA6SOS/P92SHD+iWL+zdl5o
         nC2FBS9VYkT96HbEnmYsFjVVXg2MqMf+NhfD/UUKCsczqsVSnDDWY/uQBLHIxC73LpnJ
         q7zacFrP7yuBmiTwXtMEpIpUS9QKpnoehw4GYjm+s017kw3lYB54EDv31kp/xwr3AKIQ
         96KjMa0Dfyj8NpLVWzriQygy04OWUR2+tTuqQH/e7D0kxWNd70/sb3IiEnUueJhBgn8Z
         rnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4j5heW0SerX1dieMEzzQdRhIZ6klymqFRtGtKNhBQuk=;
        b=nnP4HJPUuO8/FH+A57SbBd/F9YyLyzV7mT/84+z7TYhdBT+8rd3IZosQHNzTfcx1ZQ
         dRK+CZ1PoFbUVLrYSmprQBDxOSnjbVVcZXBaZSE29e0imKSxCwQ2Jexy6USW6pWdZtEv
         lRuIoIeDsGuj3XyjARHJY4pnxM9jj6wphPEOhaz2MA5x7jSx0cl3VggTKD/m3zt0PN4n
         BSCqRSNaZAuFsBOMsjpCCVkjJx/rgiDr6l/ag5zmJ9OfUkgs0k4S0ZKRlQc/FDxnaLDR
         +pkzVMja7jXwOheIUT7UesqoKEfVqi4ClvLmYjOtPAsTcr4dbo99Pd05ZOEibmA9UU71
         +X+w==
X-Gm-Message-State: AOAM533rhB4sUEA6WFOBdb7RO0CB6KckkHpq3hXcklPHqIZoW9d64Zmb
        jpfqY3B1QRCdvrTWyqIdn6Z9SqrjCCQW7XEY5jej
X-Google-Smtp-Source: ABdhPJxGIqCToS46n+iZzm0SUIPobgqUeb2jhvw87sSHzFZlBUIAmrFKMDAH6MTXtrngcJbRiE82T+o3gN9Bkcz1J60=
X-Received: by 2002:a05:6122:910:b0:352:720e:de05 with SMTP id
 j16-20020a056122091000b00352720ede05mr11832050vka.7.1652190334429; Tue, 10
 May 2022 06:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220510132116.506572-1-conor.dooley@microchip.com> <20220510132116.506572-2-conor.dooley@microchip.com>
In-Reply-To: <20220510132116.506572-2-conor.dooley@microchip.com>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Tue, 10 May 2022 22:45:08 +0900
Message-ID: <CABMQnVKU9FYpm1mqcD3U5ZGPqYWoFYpg6t6yEX9EtW_=9dxziA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rtc: Add driver for Microchip PolarFire SoC
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        daire.mcnamara@microchip.com, lewis.hanly@microchip.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2022=E5=B9=B45=E6=9C=8810=E6=97=A5(=E7=81=AB) 22:19 Conor Dooley <conor.doo=
ley@microchip.com>:
>
> Add support for the built-in RTC on Microchip PolarFire SoC
>
> Co-Developed-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/rtc/Kconfig    |  10 ++
>  drivers/rtc/Makefile   |   1 +
>  drivers/rtc/rtc-mpfs.c | 328 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 339 insertions(+)
>  create mode 100644 drivers/rtc/rtc-mpfs.c
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 41c65b4d2baf..a194422328da 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1966,4 +1966,14 @@ config RTC_DRV_MSC313
>           This driver can also be built as a module, if so, the module
>           will be called "rtc-msc313".
>
> +config RTC_DRV_POLARFIRE_SOC
> +       tristate "Microchip PolarFire SoC built-in RTC"
> +       depends on SOC_MICROCHIP_POLARFIRE
> +       help
> +         If you say yes here you will get support for the
> +         built-in RTC on Polarfire SoC.
> +
> +         This driver can also be built as a module, if so, the module
> +         will be called "rtc-mpfs".
> +
>  endif # RTC_CLASS
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 2d827d8261d5..25ee5ba870a9 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -130,6 +130,7 @@ obj-$(CONFIG_RTC_DRV_PIC32) +=3D rtc-pic32.o
>  obj-$(CONFIG_RTC_DRV_PL030)    +=3D rtc-pl030.o
>  obj-$(CONFIG_RTC_DRV_PL031)    +=3D rtc-pl031.o
>  obj-$(CONFIG_RTC_DRV_PM8XXX)   +=3D rtc-pm8xxx.o
> +obj-$(CONFIG_RTC_DRV_POLARFIRE_SOC)    +=3D rtc-mpfs.o
>  obj-$(CONFIG_RTC_DRV_PS3)      +=3D rtc-ps3.o
>  obj-$(CONFIG_RTC_DRV_PXA)      +=3D rtc-pxa.o
>  obj-$(CONFIG_RTC_DRV_R7301)    +=3D rtc-r7301.o
> diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
> new file mode 100644
> index 000000000000..57867878f9c6
> --- /dev/null
> +++ b/drivers/rtc/rtc-mpfs.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microchip MPFS RTC driver
> + *
> + * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
> + *
> + * Author: Daire McNamara <daire.mcnamara@microchip.com>
> + *         & Conor Dooley <conor.dooley@microchip.com>
> + */
> +#include "linux/bits.h"
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/slab.h>
> +#include <linux/rtc.h>
> +
> +#define CONTROL_REG            0x00
> +#define MODE_REG               0x04
> +#define PRESCALER_REG          0x08
> +#define ALARM_LOWER_REG                0x0c
> +#define ALARM_UPPER_REG                0x10
> +#define COMPARE_LOWER_REG      0x14
> +#define COMPARE_UPPER_REG      0x18
> +#define DATETIME_LOWER_REG     0x20
> +#define DATETIME_UPPER_REG     0x24
> +
> +#define CONTROL_RUNNING_BIT    BIT(0)
> +#define CONTROL_START_BIT      BIT(0)
> +#define CONTROL_STOP_BIT       BIT(1)
> +#define CONTROL_ALARM_ON_BIT   BIT(2)
> +#define CONTROL_ALARM_OFF_BIT  BIT(3)
> +#define CONTROL_RESET_BIT      BIT(4)
> +#define CONTROL_UPLOAD_BIT     BIT(5)
> +#define CONTROL_DOWNLOAD_BIT   BIT(6)
> +#define CONTROL_DOWNLOAD_BIT   BIT(6)
> +#define CONTROL_WAKEUP_CLR_BIT BIT(8)
> +#define CONTROL_WAKEUP_SET_BIT BIT(9)
> +#define CONTROL_UPDATED_BIT    BIT(10)
> +
> +#define MODE_CLOCK_CALENDAR    BIT(0)
> +#define MODE_WAKE_EN           BIT(1)
> +#define MODE_WAKE_RESET                BIT(2)
> +#define MODE_WAKE_CONTINUE     BIT(3)
> +
> +#define MAX_PRESCALER_COUNT    GENMASK(25, 0)
> +#define DATETIME_UPPER_MASK    GENMASK(29, 0)
> +#define ALARM_UPPER_MASK       GENMASK(10, 0)
> +
> +struct mpfs_rtc_dev {
> +       struct rtc_device *rtc;
> +       void __iomem *base;
> +       int wakeup_irq;
> +       u32 prescaler;
> +};
> +
> +static void mpfs_rtc_start(struct mpfs_rtc_dev *rtcdev)
> +{
> +       u32 ctrl;
> +
> +       ctrl =3D readl(rtcdev->base + CONTROL_REG);
> +       ctrl &=3D ~(CONTROL_STOP_BIT | CONTROL_START_BIT);
> +       ctrl |=3D CONTROL_START_BIT;
> +       writel(ctrl, rtcdev->base + CONTROL_REG);
> +}
> +
> +static void mpfs_rtc_clear_irq(struct mpfs_rtc_dev *rtcdev)
> +{
> +       u32 val =3D readl(rtcdev->base + CONTROL_REG);
> +
> +       val &=3D ~(CONTROL_ALARM_ON_BIT | CONTROL_STOP_BIT);
> +       val |=3D CONTROL_ALARM_OFF_BIT;
> +       writel(val, rtcdev->base + CONTROL_REG);
> +       /*
> +        * Ensure that the posted write to the CONTROL_REG register compl=
eted before
> +        * returning from this function. Not doing this may result in the=
 interrupt
> +        * only being cleared some time after this function returns.
> +        */
> +       (void)readl(rtcdev->base + CONTROL_REG);
> +}
> +
> +static int mpfs_rtc_readtime(struct device *dev, struct rtc_time *tm)
> +{
> +       struct mpfs_rtc_dev *rtcdev =3D dev_get_drvdata(dev);
> +       u64 time;
> +
> +       time =3D ((u64)readl(rtcdev->base + DATETIME_UPPER_REG) & DATETIM=
E_UPPER_MASK) << 32;
> +       time |=3D readl(rtcdev->base + DATETIME_LOWER_REG);
> +       rtc_time64_to_tm(time + rtcdev->rtc->range_min, tm);
> +
> +       return 0;
> +}
> +
> +static int mpfs_rtc_settime(struct device *dev, struct rtc_time *tm)
> +{
> +       struct mpfs_rtc_dev *rtcdev =3D dev_get_drvdata(dev);
> +       u32 ctrl, prog;
> +       u64 time;
> +
> +       time =3D rtc_tm_to_time64(tm) - rtcdev->rtc->range_min;
> +
> +       writel((u32)time, rtcdev->base + DATETIME_LOWER_REG);
> +       writel((u32)(time >> 32) & DATETIME_UPPER_MASK, rtcdev->base + DA=
TETIME_UPPER_REG);
> +
> +       ctrl =3D readl(rtcdev->base + CONTROL_REG);
> +       ctrl &=3D ~CONTROL_STOP_BIT;
> +       ctrl |=3D CONTROL_UPLOAD_BIT;
> +       writel(ctrl, rtcdev->base + CONTROL_REG);
> +
> +       do {
> +               prog =3D readl(rtcdev->base + CONTROL_REG);
> +               prog &=3D CONTROL_UPLOAD_BIT;
> +       } while (prog);
> +
> +       mpfs_rtc_start(rtcdev);
> +
> +       return 0;
> +}
> +
> +static int mpfs_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alr=
m)
> +{
> +       struct mpfs_rtc_dev *rtcdev =3D dev_get_drvdata(dev);
> +       u32 mode =3D readl(rtcdev->base + MODE_REG);
> +       u64 time;
> +
> +       mode =3D readl(rtcdev->base + MODE_REG);
> +
> +       if (mode & MODE_WAKE_EN)
> +               alrm->enabled =3D true;
> +       else
> +               alrm->enabled =3D false;
> +
> +       time =3D (u64)readl(rtcdev->base + ALARM_LOWER_REG) << 32;
> +       time |=3D (readl(rtcdev->base + ALARM_UPPER_REG) & ALARM_UPPER_MA=
SK);
> +       rtc_time64_to_tm(time + rtcdev->rtc->range_min, &alrm->time);
> +
> +       return 0;
> +}
> +
> +static int mpfs_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm=
)
> +{
> +       struct mpfs_rtc_dev *rtcdev =3D dev_get_drvdata(dev);
> +       u32 mode, ctrl;
> +       u64 time;
> +
> +       /* Disable the alarm before updating */
> +       ctrl =3D readl(rtcdev->base + CONTROL_REG);
> +       ctrl |=3D CONTROL_ALARM_OFF_BIT;
> +       writel(ctrl, rtcdev->base + CONTROL_REG);
> +
> +       time =3D rtc_tm_to_time64(&alrm->time) - rtcdev->rtc->range_min;
> +
> +       writel((u32)time, rtcdev->base + ALARM_LOWER_REG);
> +       writel((u32)(time >> 32) & ALARM_UPPER_MASK, rtcdev->base + ALARM=
_UPPER_REG);
> +
> +       /* Bypass compare register in alarm mode */
> +       writel(GENMASK(31, 0), rtcdev->base + COMPARE_LOWER_REG);
> +       writel(GENMASK(29, 0), rtcdev->base + COMPARE_UPPER_REG);
> +
> +       /* Configure the RTC to enable the alarm. */
> +       ctrl =3D readl(rtcdev->base + CONTROL_REG);
> +       mode =3D readl(rtcdev->base + MODE_REG);
> +       if (alrm->enabled) {
> +               mode =3D MODE_WAKE_EN | MODE_WAKE_CONTINUE;
> +               /* Enable the alarm */
> +               ctrl &=3D ~CONTROL_ALARM_OFF_BIT;
> +               ctrl |=3D CONTROL_ALARM_ON_BIT;
> +       }
> +       ctrl &=3D ~CONTROL_STOP_BIT;
> +       ctrl |=3D CONTROL_START_BIT;
> +       writel(ctrl, rtcdev->base + CONTROL_REG);
> +       writel(mode, rtcdev->base + MODE_REG);
> +
> +       return 0;
> +}
> +
> +static int mpfs_rtc_alarm_irq_enable(struct device *dev, unsigned int en=
abled)
> +{
> +       struct mpfs_rtc_dev *rtcdev =3D dev_get_drvdata(dev);
> +       u32 ctrl;
> +
> +       ctrl =3D readl(rtcdev->base + CONTROL_REG);
> +       ctrl &=3D ~(CONTROL_ALARM_ON_BIT | CONTROL_ALARM_OFF_BIT | CONTRO=
L_STOP_BIT);
> +
> +       if (enabled)
> +               ctrl |=3D CONTROL_ALARM_ON_BIT;
> +       else
> +               ctrl |=3D CONTROL_ALARM_OFF_BIT;
> +
> +       writel(ctrl, rtcdev->base + CONTROL_REG);
> +
> +       return 0;
> +}
> +
> +static inline struct clk *mpfs_rtc_init_clk(struct device *dev)
> +{
> +       struct clk *clk;
> +       int ret;
> +
> +       clk =3D devm_clk_get(dev, "rtc");
> +       if (IS_ERR(clk))
> +               return clk;
> +
> +       ret =3D clk_prepare_enable(clk);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unpr=
epare, clk);
> +       return clk;
> +}
> +
> +static irqreturn_t mpfs_rtc_wakeup_irq_handler(int irq, void *d)
> +{
> +       struct mpfs_rtc_dev *rtcdev =3D d;
> +       unsigned long pending;
> +
> +       pending =3D readl(rtcdev->base + CONTROL_REG);
> +       pending &=3D CONTROL_ALARM_ON_BIT;
> +       mpfs_rtc_clear_irq(rtcdev);
> +
> +       rtc_update_irq(rtcdev->rtc, 1, RTC_IRQF | RTC_AF);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static const struct rtc_class_ops mpfs_rtc_ops =3D {
> +       .read_time              =3D mpfs_rtc_readtime,
> +       .set_time               =3D mpfs_rtc_settime,
> +       .read_alarm             =3D mpfs_rtc_readalarm,
> +       .set_alarm              =3D mpfs_rtc_setalarm,
> +       .alarm_irq_enable       =3D mpfs_rtc_alarm_irq_enable,
> +};
> +
> +static int mpfs_rtc_probe(struct platform_device *pdev)
> +{
> +       struct mpfs_rtc_dev *rtcdev;
> +       struct clk *clk;
> +       int ret;
> +
> +       rtcdev =3D devm_kzalloc(&pdev->dev, sizeof(struct mpfs_rtc_dev), =
GFP_KERNEL);
> +       if (!rtcdev)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, rtcdev);
> +
> +       rtcdev->rtc =3D devm_rtc_allocate_device(&pdev->dev);
> +       if (IS_ERR(rtcdev->rtc))
> +               return PTR_ERR(rtcdev->rtc);
> +
> +       rtcdev->rtc->ops =3D &mpfs_rtc_ops;
> +
> +       /* range is capped by alarm max, lower reg is 31:0 & upper is 10:=
0 */
> +       rtcdev->rtc->range_max =3D GENMASK_ULL(42, 0);
> +
> +       clk =3D mpfs_rtc_init_clk(&pdev->dev);
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       rtcdev->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(rtcdev->base)) {
> +               dev_dbg(&pdev->dev, "invalid ioremap resources\n");
> +               return PTR_ERR(rtcdev->base);
> +       }
> +
> +       rtcdev->wakeup_irq =3D platform_get_irq(pdev, 0);
> +       if (rtcdev->wakeup_irq <=3D 0) {
> +               dev_dbg(&pdev->dev, "could not get wakeup irq\n");
> +               return rtcdev->wakeup_irq;
> +       }
> +       ret =3D devm_request_irq(&pdev->dev, rtcdev->wakeup_irq, mpfs_rtc=
_wakeup_irq_handler, 0,
> +                              dev_name(&pdev->dev), rtcdev);
> +       if (ret) {
> +               dev_dbg(&pdev->dev, "could not request wakeup irq\n");
> +               return ret;
> +       }
> +
> +       // prescaler hardware adds 1 to reg value

I prefer to unify the comment format.

> +       rtcdev->prescaler =3D clk_get_rate(devm_clk_get(&pdev->dev, "rtcr=
ef")) - 1;

The prescaler variables seem to be used only in this function.
I think it can be deleted from struct mpfs_rtc_dev.

> +
> +       if (rtcdev->prescaler > MAX_PRESCALER_COUNT) {
> +               dev_dbg(&pdev->dev, "invalid prescaler %d\n", rtcdev->pre=
scaler);
> +               return -EPERM;
> +       }
> +
> +       writel(rtcdev->prescaler, rtcdev->base + PRESCALER_REG);
> +       dev_info(&pdev->dev, "prescaler set to: 0x%X \r\n", rtcdev->presc=
aler);
> +
> +       device_init_wakeup(&pdev->dev, true);
> +       ret =3D dev_pm_set_wake_irq(&pdev->dev, rtcdev->wakeup_irq);
> +       if (ret)
> +               dev_err(&pdev->dev, "failed to enable irq wake\n");
> +
> +       return devm_rtc_register_device(rtcdev->rtc);
> +}

Best regatds,
  Nobuhiro
