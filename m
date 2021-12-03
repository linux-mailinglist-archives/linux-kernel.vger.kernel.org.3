Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648F246730B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351072AbhLCIHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhLCIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:07:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A798CC06173E;
        Fri,  3 Dec 2021 00:03:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB80B6297A;
        Fri,  3 Dec 2021 08:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9DBC53FAD;
        Fri,  3 Dec 2021 08:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638518625;
        bh=SvfGN+PjcnykzpCAThdQO6VCpwrVwDZuHqNRCuT9r+E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YFDgkq/+h5PhS1QAfp/s3FZQIo5S73TuxVAGSeiTVhQiy41kzDhCKLghwM0bzXmM5
         ze0B3BZDvjzHpLejlprVcJZhB8fh5DW6BGTxyBTgdsyAbyIB1RF85fI/9Shi5AmFhv
         7l6u5AiRWvBcPPHsXaWx+Wxcxg/NBXP3UbHQ3q5H7KR6u6NsrQa4USWCs0/oIapxnU
         0b1ZQWDgCXe3T93lx+PI7Si4sur779HcEwUEXGyKRHVpuSdN90y3UvY8AW18r6UJ79
         0K7yB2wUriWgdBom4WRspYUHMwSAe558uHM5U4Zl8f/xxU/lQGrO8Pp8G2fjmpK8gx
         BNFsC2awjjx2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211129153330.37719-8-nbd@nbd.name>
References: <20211129153330.37719-1-nbd@nbd.name> <20211129153330.37719-8-nbd@nbd.name>
Subject: Re: [PATCH v5 07/13] clk: en7523: Add clock driver for Airoha EN7523 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     john@phrozen.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Felix Fietkau <nbd@nbd.name>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 03 Dec 2021 00:03:43 -0800
User-Agent: alot/0.9.1
Message-Id: <20211203080345.2B9DBC53FAD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Felix Fietkau (2021-11-29 07:33:23)
> This driver only registers fixed rate clocks, since the clocks are fully
> initialized by the boot loader and should not be changed later, according
> to Airoha.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  arch/arm/boot/dts/en7523.dtsi |   8 +
>  drivers/clk/Kconfig           |   9 +
>  drivers/clk/Makefile          |   1 +
>  drivers/clk/clk-en7523.c      | 356 ++++++++++++++++++++++++++++++++++
>  4 files changed, 374 insertions(+)
>  create mode 100644 drivers/clk/clk-en7523.c

Pleas don't mix clk driver changes and dts file updates together.
Instead, introduce the clk driver in one patch and add the dts node in
another patch so that the different maintainers can pick up the patch
for the area they maintain.

> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c5b3dc97396a..b542f58c58d2 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -192,6 +192,15 @@ config COMMON_CLK_CS2000_CP
>         help
>           If you say yes here you get support for the CS2000 clock multip=
lier.
> =20
> +config COMMON_CLK_EN7523
> +       bool "Clock driver for Airoha EN7523 SoC system clocks"
> +       depends on OF
> +       depends on ARCH_AIROHA || ARM || COMPILE_TEST

Is this supposed to have parenthesis somewhere? Why is depending on ARM
useful?

> +       default ARCH_AIROHA
> +       help
> +         This driver provides the fixed clocks and gates present on Airo=
ha
> +         ARM silicon.
> +
>  config COMMON_CLK_FSL_FLEXSPI
>         tristate "Clock driver for FlexSPI on Layerscape SoCs"
>         depends on ARCH_LAYERSCAPE || COMPILE_TEST
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e42312121e51..be11d88c1603 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_COMMON_CLK_CDCE925)      +=3D clk-cdce925.o
>  obj-$(CONFIG_ARCH_CLPS711X)            +=3D clk-clps711x.o
>  obj-$(CONFIG_COMMON_CLK_CS2000_CP)     +=3D clk-cs2000-cp.o
>  obj-$(CONFIG_ARCH_SPARX5)              +=3D clk-sparx5.o
> +obj-$(CONFIG_COMMON_CLK_EN7523)                +=3D clk-en7523.o
>  obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)    +=3D clk-fixed-mmio.o
>  obj-$(CONFIG_COMMON_CLK_FSL_FLEXSPI)   +=3D clk-fsl-flexspi.o
>  obj-$(CONFIG_COMMON_CLK_FSL_SAI)       +=3D clk-fsl-sai.o
> diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> new file mode 100644
> index 000000000000..f1774a5bf537
> --- /dev/null
> +++ b/drivers/clk/clk-en7523.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/regmap.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/en7523-clk.h>
> +#include <linux/clk.h>

Is this include used?

> +
> +#define REG_PCI_CONTROL                        0x88
> +#define   REG_PCI_CONTROL_PERSTOUT     BIT(29)
> +#define   REG_PCI_CONTROL_PERSTOUT1    BIT(26)
> +#define   REG_PCI_CONTROL_REFCLK_EN1   BIT(22)
> +#define REG_GSW_CLK_DIV_SEL            0x1b4
[...]
> +
> +static struct clk *en7523_register_pcie_clk(struct device *dev,
> +                                           void __iomem *np_base)
> +{
> +       static const struct clk_ops pcie_gate_ops =3D {
> +               .is_enabled =3D en7523_pci_is_enabled,
> +               .enable =3D en7523_pci_enable,
> +               .disable =3D en7523_pci_disable,
> +       };
> +       struct clk_init_data init =3D {
> +               .name =3D "pcie",
> +               .ops =3D &pcie_gate_ops,
> +       };
> +       struct en_clk_gate *cg;
> +       struct clk *clk;
> +
> +       cg =3D devm_kzalloc(dev, sizeof(*cg), GFP_KERNEL);
> +       if (!cg)
> +               return NULL;
> +
> +       cg->base =3D np_base;
> +       cg->hw.init =3D &init;
> +       en7523_pci_disable(&cg->hw);
> +
> +       clk =3D clk_register(NULL, &cg->hw);

Please use clk_hw_register

> +       if (IS_ERR(clk))
> +               clk =3D NULL;
> +
> +       return clk;
> +}
> +
> +static void en7523_register_clocks(struct device *dev, struct clk_onecel=
l_data *clk_data,
> +                                  void __iomem *base, void __iomem *np_b=
ase)
> +{
> +       struct clk *clk;
> +       u32 rate;
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(en7523_base_clks); i++) {
> +               const struct en_clk_desc *desc =3D &en7523_base_clks[i];
> +
> +               rate =3D en7523_get_base_rate(base, i);
> +               rate /=3D en7523_get_div(base, i);
> +
> +               clk =3D clk_register_fixed_rate(NULL, desc->name, NULL, 0=
, rate);
> +               if (IS_ERR(clk)) {
> +                       pr_err("Failed to register clk %s: %ld\n",
> +                              desc->name, PTR_ERR(clk));
> +                       continue;
> +               }
> +
> +               clk_data->clks[desc->id] =3D clk;
> +       }
> +
> +       clk =3D en7523_register_pcie_clk(dev, np_base);
> +       clk_data->clks[EN7523_CLK_PCIE] =3D clk;
> +
> +       clk_data->clk_num =3D EN7523_NUM_CLOCKS;
> +}
> +
> +static int en7523_clk_probe(struct platform_device *pdev)
> +{
> +       struct device_node *node =3D pdev->dev.of_node;
> +       struct clk_onecell_data *clk_data;
> +       void __iomem *base, *np_base;
> +       int r;
> +
> +       base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       np_base =3D devm_platform_ioremap_resource(pdev, 1);
> +       if (IS_ERR(base))
> +               return PTR_ERR(np_base);
> +
> +       clk_data =3D devm_kzalloc(&pdev->dev, sizeof(*clk_data), GFP_KERN=
EL);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       clk_data->clks =3D devm_kcalloc(&pdev->dev, EN7523_NUM_CLOCKS,
> +                                     sizeof(*clk_data->clks), GFP_KERNEL=
);
> +       if (!clk_data->clks)
> +               return -ENOMEM;
> +
> +       en7523_register_clocks(&pdev->dev, clk_data, base, np_base);
> +
> +       r =3D of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);

Please add a clk_hw provider instead of a clk provider.

> +       if (r)
