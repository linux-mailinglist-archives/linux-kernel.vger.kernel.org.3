Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04236462A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhK3CfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbhK3Ce7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:34:59 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:31:40 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id o1so38318909uap.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVDoZk/9zs0LuZJfTUkrLmTMcO+6t9gAL4bZt4AyiQs=;
        b=HVeMZMCCCrrZ/G2HoroaRBJ4pJ8F9G4oCdHzhUNUEViOouFx9TBOKDvgTxNQXmvB1m
         sba7mdzVETxiz3pkRoJcB000JhfEZWk4bMsACTdXVFxJYSCkV7u2rywId0chJqHjOKr2
         d6tZWZp4w4CFhODNtx8cXdUHYnRFNbuMV9K8YBDMax7wYUDY1AE9w+rOw+vu7HnD+XbD
         e+289v0Cb1iimoEYieYAo5B4ikmYdmByfyrk8K2OOe0dRX2LD1vMDrmNzqMD4KvvjUsW
         a9TwztWzL+29ILPGZVR9Hs3U1U4wx6wdelIPbjUVhW/r07+y550tVLmPDdVyiacO4WP/
         a8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVDoZk/9zs0LuZJfTUkrLmTMcO+6t9gAL4bZt4AyiQs=;
        b=BkO5b6fJqLhoNInXsVGy2WovA5ENcTRDfVap6Fng4st1HL2sMc8djizoA/hdlAvnG3
         CjQr5HRbCI6sZP0z4J87kmivV/lfM8owd5YhmpDWkJITQfjztSDizDdGydhTng/uuzzK
         +LTPEumGAdD7R20hgXjJU8K8PSMCePPyN/nSs5DwNjIzdo+h7E2t7RuH+VVVPbz55vyR
         UDFCv1bfLX3phRj9HvfwXXZU3q3I+hIcsxnmPLd9NWfC47Gs75EdoPv0NOpTNCp2Nvwu
         Ob56i1SxE+5hU0zb+7KNe/RmVGRGrivuqw5V7MwhG8qin6tXU8jpv80Ll3AgzP08Mp2t
         a+PQ==
X-Gm-Message-State: AOAM53107/h+ZtUrdYHpcSEZ7f3H2sDKRBoHvZ2r/4tW3tsCCPqUuuyw
        9l2X1Plbl/RBO/YX7PXQ/H9grFT0bXoIFHAgOiViCA==
X-Google-Smtp-Source: ABdhPJz0Vecrs+yrziIbvlLWMLYiVg9JQXosPg4SwhL8jWW63xufJYzxX3MrZMmxQohRvK27JdtjmGcfJjziwN0DjnU=
X-Received: by 2002:a67:d31c:: with SMTP id a28mr38212517vsj.20.1638239499435;
 Mon, 29 Nov 2021 18:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20211130022453.28648-1-semen.protsenko@linaro.org>
In-Reply-To: <20211130022453.28648-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 30 Nov 2021 04:31:27 +0200
Message-ID: <CAPLW+4=BcQPqyW4gkq1BTYErv_StqvdLNMwbNWEizz1CEL7mnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] soc: samsung: Add USI driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 at 04:24, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> USIv2 IP-core is found on modern ARM64 Exynos SoCs (like Exynos850) and
> provides selectable serial protocol (one of: UART, SPI, I2C). USIv2
> registers usually reside in the same register map as a particular
> underlying protocol it implements, but have some particular offset. E.g.
> on Exynos850 the USI_UART has 0x13820000 base address, where UART
> registers have 0x00..0x40 offsets, and USI registers have 0xc0..0xdc
> offsets. Desired protocol can be chosen via SW_CONF register from System
> Register block of the same domain as USI.
>
> Before starting to use a particular protocol, USIv2 must be configured
> properly:
>   1. Select protocol to be used via System Register
>   2. Clear "reset" flag in USI_CON
>   3. Configure HWACG behavior (e.g. for UART Rx the HWACG must be
>      disabled, so that the IP clock is not gated automatically); this is
>      done using USI_OPTION register
>   4. Keep both USI clocks (PCLK and IPCLK) running during USI registers
>      modification
>
> This driver implements above behavior. Of course, USIv2 driver should be
> probed before UART/I2C/SPI drivers. It can be achived by embedding
> UART/I2C/SPI nodes inside of USI node (in Device Tree); driver then
> walks underlying nodes and instantiates those. Driver also handles USI
> configuration on PM resume, as register contents can be lost during CPU
> suspend.
>
> This driver is designed with different USI versions in mind. So it
> should be relatively easy to add new USI revisions to it later.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

I'm sorry for sending this v2 series as a bunch of separate mails. My
msmtp failed in the middle of submission, two times in a row. If it's
a bother, please tell me and I'll re-send as v3.

> Changes in v2:
>   - Replaced arch_initcall() with module_platform_driver()
>   - Reworked the whole driver for the easy adoption of other USI
>     revisions
>   - Added "mode" validation right after reading it from device tree
>   - Handled new USI_V2_NONE value
>
>  drivers/soc/samsung/Kconfig      |  14 ++
>  drivers/soc/samsung/Makefile     |   2 +
>  drivers/soc/samsung/exynos-usi.c | 274 +++++++++++++++++++++++++++++++
>  3 files changed, 290 insertions(+)
>  create mode 100644 drivers/soc/samsung/exynos-usi.c
>
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index e2cedef1e8d1..a9f8b224322e 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -23,6 +23,20 @@ config EXYNOS_CHIPID
>           Support for Samsung Exynos SoC ChipID and Adaptive Supply Voltage.
>           This driver can also be built as module (exynos_chipid).
>
> +config EXYNOS_USI
> +       tristate "Exynos USI (Universal Serial Interface) driver"
> +       default ARCH_EXYNOS && ARM64
> +       depends on ARCH_EXYNOS || COMPILE_TEST
> +       select MFD_SYSCON
> +       help
> +         Enable support for USI block. USI (Universal Serial Interface) is an
> +         IP-core found in modern Samsung Exynos SoCs, like Exynos850 and
> +         ExynosAutoV0. USI block can be configured to provide one of the
> +         following serial protocols: UART, SPI or High Speed I2C.
> +
> +         This driver allows one to configure USI for desired protocol, which
> +         is usually done in USI node in Device Tree.
> +
>  config EXYNOS_PMU
>         bool "Exynos PMU controller driver" if COMPILE_TEST
>         depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 2ae4bea804cf..9f59d1905ab0 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -4,6 +4,8 @@ obj-$(CONFIG_EXYNOS_ASV_ARM)    += exynos5422-asv.o
>  obj-$(CONFIG_EXYNOS_CHIPID)    += exynos_chipid.o
>  exynos_chipid-y                        += exynos-chipid.o exynos-asv.o
>
> +obj-$(CONFIG_EXYNOS_USI)       += exynos-usi.o
> +
>  obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o
>
>  obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)   += exynos3250-pmu.o exynos4-pmu.o \
> diff --git a/drivers/soc/samsung/exynos-usi.c b/drivers/soc/samsung/exynos-usi.c
> new file mode 100644
> index 000000000000..6e4112696f49
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-usi.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Linaro Ltd.
> + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * Samsung Exynos USI driver (Universal Serial Interface).
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include <dt-bindings/soc/samsung,exynos-usi.h>
> +
> +/* USIv2: System Register: SW_CONF register bits */
> +#define USI_V2_SW_CONF_NONE    0x0
> +#define USI_V2_SW_CONF_UART    BIT(0)
> +#define USI_V2_SW_CONF_SPI     BIT(1)
> +#define USI_V2_SW_CONF_I2C     BIT(2)
> +#define USI_V2_SW_CONF_MASK    (USI_V2_SW_CONF_UART | USI_V2_SW_CONF_SPI | \
> +                                USI_V2_SW_CONF_I2C)
> +
> +/* USIv2: USI register offsets */
> +#define USI_CON                        0x04
> +#define USI_OPTION             0x08
> +
> +/* USIv2: USI register bits */
> +#define USI_CON_RESET          BIT(0)
> +#define USI_OPTION_CLKREQ_ON   BIT(1)
> +#define USI_OPTION_CLKSTOP_ON  BIT(2)
> +
> +enum exynos_usi_ver {
> +       USI_VER2 = 2,
> +};
> +
> +struct exynos_usi_variant {
> +       enum exynos_usi_ver ver;        /* USI IP-core version */
> +       unsigned int sw_conf_mask;      /* SW_CONF mask for all protocols */
> +       size_t min_mode;                /* first index in exynos_usi_modes[] */
> +       size_t max_mode;                /* last index in exynos_usi_modes[] */
> +};
> +
> +struct exynos_usi {
> +       struct device *dev;
> +       void __iomem *regs;             /* USI register map */
> +       struct clk *pclk;               /* USI bus clock */
> +       struct clk *ipclk;              /* USI operating clock */
> +
> +       size_t mode;                    /* current USI SW_CONF mode index */
> +       bool clkreq_on;                 /* always provide clock to IP */
> +
> +       /* System Register */
> +       struct regmap *sysreg;          /* System Register map */
> +       unsigned int sw_conf;           /* SW_CONF register offset in sysreg */
> +
> +       const struct exynos_usi_variant *data;
> +};
> +
> +struct exynos_usi_mode {
> +       const char *name;               /* mode name */
> +       unsigned int val;               /* mode register value */
> +};
> +
> +static const struct exynos_usi_mode exynos_usi_modes[] = {
> +       [USI_V2_NONE] = { .name = "none", .val = USI_V2_SW_CONF_NONE },
> +       [USI_V2_UART] = { .name = "uart", .val = USI_V2_SW_CONF_UART },
> +       [USI_V2_SPI] =  { .name = "spi",  .val = USI_V2_SW_CONF_SPI },
> +       [USI_V2_I2C] =  { .name = "i2c",  .val = USI_V2_SW_CONF_I2C },
> +};
> +
> +static const struct exynos_usi_variant exynos_usi_v2_data = {
> +       .ver            = USI_VER2,
> +       .sw_conf_mask   = USI_V2_SW_CONF_MASK,
> +       .min_mode       = USI_V2_NONE,
> +       .max_mode       = USI_V2_I2C,
> +};
> +
> +static const struct of_device_id exynos_usi_dt_match[] = {
> +       {
> +               .compatible = "samsung,exynos-usi-v2",
> +               .data = &exynos_usi_v2_data,
> +       },
> +       { }, /* sentinel */
> +};
> +MODULE_DEVICE_TABLE(of, exynos_usi_dt_match);
> +
> +/**
> + * exynos_usi_set_sw_conf - Set USI block configuration mode
> + * @usi: USI driver object
> + * @mode: Mode index
> + *
> + * Select underlying serial protocol (UART/SPI/I2C) in USI IP-core.
> + *
> + * Return: 0 on success, or negative error code on failure.
> + */
> +static int exynos_usi_set_sw_conf(struct exynos_usi *usi, size_t mode)
> +{
> +       unsigned int val;
> +       int ret;
> +
> +       if (mode < usi->data->min_mode || mode > usi->data->max_mode)
> +               return -EINVAL;
> +
> +       val = exynos_usi_modes[mode].val;
> +       ret = regmap_update_bits(usi->sysreg, usi->sw_conf,
> +                                usi->data->sw_conf_mask, val);
> +       if (ret)
> +               return ret;
> +
> +       usi->mode = mode;
> +       dev_dbg(usi->dev, "protocol: %s\n", exynos_usi_modes[usi->mode].name);
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos_usi_enable - Initialize USI block
> + * @usi: USI driver object
> + *
> + * USI IP-core start state is "reset" (on startup and after CPU resume). This
> + * routine enables USI block by clearing the reset flag. It also configures
> + * HWACG behavior (needed e.g. for UART Rx). It should be performed before
> + * underlying protocol becomes functional.
> + *
> + * Return: 0 on success, or negative error code on failure.
> + */
> +static int exynos_usi_enable(const struct exynos_usi *usi)
> +{
> +       u32 val;
> +       int ret;
> +
> +       ret = clk_prepare_enable(usi->pclk);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(usi->ipclk);
> +       if (ret)
> +               goto err_pclk;
> +
> +       /* Enable USI block */
> +       val = readl(usi->regs + USI_CON);
> +       val &= ~USI_CON_RESET;
> +       writel(val, usi->regs + USI_CON);
> +       udelay(1);
> +
> +       /* Continuously provide the clock to USI IP w/o gating */
> +       if (usi->clkreq_on) {
> +               val = readl(usi->regs + USI_OPTION);
> +               val &= ~USI_OPTION_CLKSTOP_ON;
> +               val |= USI_OPTION_CLKREQ_ON;
> +               writel(val, usi->regs + USI_OPTION);
> +       }
> +
> +       clk_disable_unprepare(usi->ipclk);
> +err_pclk:
> +       clk_disable_unprepare(usi->pclk);
> +       return ret;
> +}
> +
> +static int exynos_usi_configure(struct exynos_usi *usi)
> +{
> +       int ret;
> +
> +       ret = exynos_usi_set_sw_conf(usi, usi->mode);
> +       if (ret)
> +               return ret;
> +
> +       if (usi->data->ver == USI_VER2)
> +               return exynos_usi_enable(usi);
> +
> +       return 0;
> +}
> +
> +static int exynos_usi_parse_dt(struct device_node *np, struct exynos_usi *usi)
> +{
> +       int ret;
> +       u32 mode;
> +
> +       ret = of_property_read_u32(np, "samsung,mode", &mode);
> +       if (ret)
> +               return ret;
> +       if (mode < usi->data->min_mode || mode > usi->data->max_mode)
> +               return -EINVAL;
> +       usi->mode = mode;
> +
> +       usi->sysreg = syscon_regmap_lookup_by_phandle(np, "samsung,sysreg");
> +       if (IS_ERR(usi->sysreg))
> +               return PTR_ERR(usi->sysreg);
> +
> +       ret = of_property_read_u32_index(np, "samsung,sysreg", 1,
> +                                        &usi->sw_conf);
> +       if (ret)
> +               return ret;
> +
> +       usi->clkreq_on = of_property_read_bool(np, "samsung,clkreq-on");
> +
> +       return 0;
> +}
> +
> +static int exynos_usi_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct exynos_usi *usi;
> +       int ret;
> +
> +       usi = devm_kzalloc(dev, sizeof(*usi), GFP_KERNEL);
> +       if (!usi)
> +               return -ENOMEM;
> +
> +       usi->dev = dev;
> +       platform_set_drvdata(pdev, usi);
> +
> +       usi->data = of_device_get_match_data(dev);
> +       if (!usi->data)
> +               return -EINVAL;
> +
> +       ret = exynos_usi_parse_dt(np, usi);
> +       if (ret)
> +               return ret;
> +
> +       if (usi->data->ver == USI_VER2) {
> +               usi->regs = devm_platform_ioremap_resource(pdev, 0);
> +               if (IS_ERR(usi->regs))
> +                       return PTR_ERR(usi->regs);
> +
> +               usi->pclk = devm_clk_get(dev, "pclk");
> +               if (IS_ERR(usi->pclk))
> +                       return PTR_ERR(usi->pclk);
> +
> +               usi->ipclk = devm_clk_get(dev, "ipclk");
> +               if (IS_ERR(usi->ipclk))
> +                       return PTR_ERR(usi->ipclk);
> +       }
> +
> +       ret = exynos_usi_configure(usi);
> +       if (ret)
> +               return ret;
> +
> +       /* Make it possible to embed protocol nodes into USI np */
> +       return of_platform_populate(np, NULL, NULL, dev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int exynos_usi_resume_noirq(struct device *dev)
> +{
> +       struct exynos_usi *usi = dev_get_drvdata(dev);
> +
> +       return exynos_usi_configure(usi);
> +}
> +#endif
> +
> +static const struct dev_pm_ops exynos_usi_pm = {
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, exynos_usi_resume_noirq)
> +};
> +
> +static struct platform_driver exynos_usi_driver = {
> +       .driver = {
> +               .name           = "exynos-usi",
> +               .pm             = &exynos_usi_pm,
> +               .of_match_table = exynos_usi_dt_match,
> +       },
> +       .probe = exynos_usi_probe,
> +};
> +
> +module_platform_driver(exynos_usi_driver);
> +
> +MODULE_DESCRIPTION("Samsung USI driver");
> +MODULE_AUTHOR("Sam Protsenko <semen.protsenko@linaro.org>");
> +MODULE_LICENSE("GPL");
> --
> 2.30.2
>
