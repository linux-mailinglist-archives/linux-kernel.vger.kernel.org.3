Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7D54DC071
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiCQHuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCQHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:50:33 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA0BD3719
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:49:16 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2dbd8777564so49450807b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxhKs33qKz6suXNHm1jB53sEskKF4ehz7UKKwX7WH2I=;
        b=UroNxQQhcYn985C7c6vcxusQLfDBM+C2CO8CHxjLA1nsurUzi5xOkQ7eU0yGHUax4/
         Zy/odR/jxAAvMnxTnlVJnOkBko5/+fR9X6OdcfRtBTLNYcMcpR/tb0e8mjLnEJv1w1Un
         qtl9toarqI6xoRpuz4tdrN/DmsMVvdwHDnMBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxhKs33qKz6suXNHm1jB53sEskKF4ehz7UKKwX7WH2I=;
        b=E4ZuGFNXqurqsUEph3x8nxC3BSgWDrO6jxTEfTKmulEEb3Qe3Okdajey4R6OYR24k6
         imCXds9gA4o+RnG1UKQ601tUPIi8ENrWnlXQtcP+b5ODorhwHH9bfL7gX6GszQtX9Gyi
         5LMZUScKQ16hOxwx/IXtJfKmQGED5w35XytLmRFiwLhynEWAABuQJGwqHBaPXAjB9h1W
         2hxm/iooZsBRu8ABBBg9tEs9jwYqrglXOnWA3spRslFjtUL9+CofkriPm4CQkKk5cyB+
         FTAg9hzUF3xmtXunHOu35bgpRS15H+o7hUBP+o+JmhLJqZ0RI8eVTSHhi3M+i/JKx/Pq
         z4hA==
X-Gm-Message-State: AOAM533WBfRPZgXdGKXEEpbKlXeFOkckqBJnOtaPl9Z/ru4YVQJ76u6K
        3F7IUGlwORHJ+ZUPRn2rVNfCUS3Cv1pcH92L2d6Gcw==
X-Google-Smtp-Source: ABdhPJygD5+S+JgKaE9mUCzyufJmjkB9OUVTcyUSN6SZ1eaIaWsdz/JRaHZmaWs9B4adB/ypoNHHUdsFjVRMQD2gXbs=
X-Received: by 2002:a0d:e297:0:b0:2e5:9bbc:2455 with SMTP id
 l145-20020a0de297000000b002e59bbc2455mr4377377ywe.21.1647503356026; Thu, 17
 Mar 2022 00:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220311133527.5914-1-jianjun.wang@mediatek.com> <20220311133527.5914-2-jianjun.wang@mediatek.com>
In-Reply-To: <20220311133527.5914-2-jianjun.wang@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 17 Mar 2022 15:49:05 +0800
Message-ID: <CAGXv+5GxML3Ga5ampXdLBpPr52C99OiJXg65qn2p_spzP4dhPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] phy: mediatek: Add PCIe PHY driver
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, Randy.Wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 9:46 PM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
>
> Add PCIe GEN3 PHY driver support on MediaTek chipsets.
>
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/phy/mediatek/Kconfig        |  11 ++
>  drivers/phy/mediatek/Makefile       |   1 +
>  drivers/phy/mediatek/phy-mtk-pcie.c | 198 ++++++++++++++++++++++++++++
>  3 files changed, 210 insertions(+)
>  create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
>
> diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
> index 55f8e6c048ab..387ed1b3f2cc 100644
> --- a/drivers/phy/mediatek/Kconfig
> +++ b/drivers/phy/mediatek/Kconfig
> @@ -55,3 +55,14 @@ config PHY_MTK_MIPI_DSI
>         select GENERIC_PHY
>         help
>           Support MIPI DSI for Mediatek SoCs.
> +
> +config PHY_MTK_PCIE
> +       tristate "MediaTek PCIe-PHY Driver"
> +       depends on ARCH_MEDIATEK || COMPILE_TEST
> +       depends on OF
> +       select GENERIC_PHY
> +       help
> +         Say 'Y' here to add support for MediaTek PCIe PHY driver.
> +         This driver create the basic PHY instance and provides initialize
> +         callback for PCIe GEN3 port, it supports software efuse
> +         initialization.
> diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
> index ace660fbed3a..788c13147f63 100644
> --- a/drivers/phy/mediatek/Makefile
> +++ b/drivers/phy/mediatek/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_PHY_MTK_TPHY)             += phy-mtk-tphy.o
>  obj-$(CONFIG_PHY_MTK_UFS)              += phy-mtk-ufs.o
>  obj-$(CONFIG_PHY_MTK_XSPHY)            += phy-mtk-xsphy.o
> +obj-$(CONFIG_PHY_MTK_PCIE)             += phy-mtk-pcie.o
>
>  phy-mtk-hdmi-drv-y                     := phy-mtk-hdmi.o
>  phy-mtk-hdmi-drv-y                     += phy-mtk-hdmi-mt2701.o
> diff --git a/drivers/phy/mediatek/phy-mtk-pcie.c b/drivers/phy/mediatek/phy-mtk-pcie.c
> new file mode 100644
> index 000000000000..45a67d9171f6
> --- /dev/null
> +++ b/drivers/phy/mediatek/phy-mtk-pcie.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Jianjun Wang <jianjun.wang@mediatek.com>
> + */
> +

Please include linux/bits.h for GENMASK().

> +#include <linux/io.h>
> +#include <linux/iopoll.h>

You don't need these two headers.

You could include linux/compiler_types.h for definition of __iomem.

> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>

> +#include <linux/of_address.h>
> +#include <linux/of_device.h>

Nor do you need these two.

> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>

Please include linux/slab.h for kmalloc() and friends.

> +
> +#include "phy-mtk-io.h"
> +
> +#define PEXTP_ANA_GLB_00_REG           0x9000
> +#define PEXTP_ANA_LN0_TX_REG           0xA004
> +#define PEXTP_ANA_LN0_RX_REG           0xA03C
> +#define PEXTP_ANA_LN1_TX_REG           0xA104
> +#define PEXTP_ANA_LN1_RX_REG           0xA13c
> +
> +/* PEXTP_GLB_00_RG[28:24] Internal Resistor Selection of TX Bias Current */
> +#define EFUSE_GLB_INTR_SEL             GENMASK(28, 24)
> +#define EFUSE_GLB_INTR_VAL(x)          ((0x1f & (x)) << 24)
> +
> +/* PEXTP_ANA_LN_RX_RG[3:0] LN0 RX impedance selection */
> +#define EFUSE_LN_RX_SEL                        GENMASK(3, 0)
> +#define EFUSE_LN_RX_VAL(x)             (0xf & (x))
> +
> +/* PEXTP_ANA_LN_TX_RG[5:2] LN0 TX PMOS impedance selection */
> +#define EFUSE_LN_TX_PMOS_SEL           GENMASK(5, 2)
> +#define EFUSE_LN_TX_PMOS_VAL(x)                ((0xf & (x)) << 2)
> +
> +/* PEXTP_ANA_LN_TX_RG[11:8] LN0 TX NMOS impedance selection */
> +#define EFUSE_LN_TX_NMOS_SEL           GENMASK(11, 8)
> +#define EFUSE_LN_TX_NMOS_VAL(x)                ((0xf & (x)) << 8)

Register definitions look good. I matched them to the datasheet.

> +struct mtk_pcie_phy {
> +       struct device *dev;
> +       struct phy *phy;
> +       void __iomem *sif_base;
> +};
> +
> +static int mtk_pcie_phy_init(struct phy *phy)
> +{
> +       struct mtk_pcie_phy *pcie_phy = phy_get_drvdata(phy);
> +       struct device *dev = pcie_phy->dev;
> +       bool nvmem_enabled;
> +       u32 glb_intr, tx_pmos, tx_nmos, rx_data;
> +       int ret;
> +
> +       nvmem_enabled = device_property_read_bool(dev, "nvmem-cells");
> +       if (!nvmem_enabled)
> +               return 0;
> +
> +       /* Set efuse value for lane0 */
> +       ret = nvmem_cell_read_variable_le_u32(dev, "tx_ln0_pmos", &tx_pmos);
> +       if (ret) {
> +               dev_err(dev, "%s: Failed to read tx_ln0_pmos\n", __func__);
> +               return ret;
> +       }
> +
> +       ret = nvmem_cell_read_variable_le_u32(dev, "tx_ln0_nmos", &tx_nmos);
> +       if (ret) {
> +               dev_err(dev, "%s: Failed to read tx_ln0_nmos\n", __func__);
> +               return ret;
> +       }
> +
> +       ret = nvmem_cell_read_variable_le_u32(dev, "rx_ln0", &rx_data);
> +       if (ret) {
> +               dev_err(dev, "%s: Failed to read rx_ln0\n", __func__);
> +               return ret;
> +       }
> +
> +       /* Don't wipe the old data if there is no data in efuse cell */
> +       if (!(tx_pmos || tx_nmos || rx_data)) {
> +               dev_warn(dev, "%s: No efuse data found, but dts enable it\n",
> +                        __func__);
> +               return 0;
> +       }
> +
> +       mtk_phy_update_bits(pcie_phy->sif_base + PEXTP_ANA_LN0_TX_REG,
> +                           EFUSE_LN_TX_PMOS_SEL,
> +                           EFUSE_LN_TX_PMOS_VAL(tx_pmos));
> +
> +       mtk_phy_update_bits(pcie_phy->sif_base + PEXTP_ANA_LN0_TX_REG,
> +                           EFUSE_LN_TX_NMOS_SEL,
> +                           EFUSE_LN_TX_NMOS_VAL(tx_nmos));
> +
> +       mtk_phy_update_bits(pcie_phy->sif_base + PEXTP_ANA_LN0_RX_REG,
> +                           EFUSE_LN_RX_SEL, EFUSE_LN_RX_VAL(rx_data));
> +
> +       /* Set global data */
> +       ret = nvmem_cell_read_variable_le_u32(dev, "glb_intr", &glb_intr);
> +       if (ret) {
> +               dev_err(dev, "%s: Failed to read glb_intr\n", __func__);
> +               return ret;
> +       }
> +
> +       mtk_phy_update_bits(pcie_phy->sif_base + PEXTP_ANA_GLB_00_REG,
> +                           EFUSE_GLB_INTR_SEL, EFUSE_GLB_INTR_VAL(glb_intr));
> +
> +       /*
> +        * Set efuse value for lane1, only available for the platform which
> +        * supports two lane.
> +        */
> +       ret = nvmem_cell_read_variable_le_u32(dev, "tx_ln1_pmos", &tx_pmos);
> +       if (ret) {
> +               dev_err(dev, "%s: Failed to read tx_ln1_pmos, efuse value not support for lane 1\n",
> +                       __func__);
> +               return 0;
> +       }
> +
> +       ret = nvmem_cell_read_variable_le_u32(dev, "tx_ln1_nmos", &tx_nmos);
> +       if (ret) {
> +               dev_err(dev, "%s: Failed to read tx_ln1_pmos\n", __func__);
> +               return ret;
> +       }
> +
> +       ret = nvmem_cell_read_variable_le_u32(dev, "rx_ln1", &rx_data);
> +       if (ret) {
> +               dev_err(dev, "%s: Failed to read rx_ln1\n", __func__);
> +               return ret;
> +       }
> +
> +       if (!(tx_pmos || tx_nmos || rx_data))
> +               return 0;
> +
> +       mtk_phy_update_bits(pcie_phy->sif_base + PEXTP_ANA_LN1_TX_REG,
> +                           EFUSE_LN_TX_PMOS_SEL,
> +                           EFUSE_LN_TX_PMOS_VAL(tx_pmos));
> +
> +       mtk_phy_update_bits(pcie_phy->sif_base + PEXTP_ANA_LN1_TX_REG,
> +                           EFUSE_LN_TX_NMOS_SEL,
> +                           EFUSE_LN_TX_NMOS_VAL(tx_nmos));
> +
> +       mtk_phy_update_bits(pcie_phy->sif_base + PEXTP_ANA_LN1_RX_REG,
> +                           EFUSE_LN_RX_SEL, EFUSE_LN_RX_VAL(rx_data));
> +
> +       return 0;
> +}
> +
> +static const struct phy_ops mtk_pcie_phy_ops = {
> +       .init   = mtk_pcie_phy_init,

This function doesn't look like it is enabling any resources, and there
is no .exit counterpart. You could simply call this in the probe function.

Or maybe the hardware settings get reset during suspend, and you want the
settings reinitialized when the consumer calls phy_init() again? This
design limitation and decision should be noted in a comment.


Also, it is better to do the NVMEM readout at probe time, so if
nvmem_cell_read_* returns -EPROBE_DEFER, you get proper probe
sequencing.

Consumers likely won't be expecting -EPROBE_DEFER from phy_init().

> +       .owner  = THIS_MODULE,
> +};
> +
> +static int mtk_pcie_phy_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct phy_provider *provider;
> +       struct mtk_pcie_phy *pcie_phy;
> +
> +       pcie_phy = devm_kzalloc(dev, sizeof(*pcie_phy), GFP_KERNEL);
> +       if (!pcie_phy)
> +               return -ENOMEM;
> +
> +       pcie_phy->dev = dev;
> +
> +       pcie_phy->sif_base = devm_platform_ioremap_resource_byname(pdev, "sif");
> +       if (IS_ERR(pcie_phy->sif_base)) {
> +               dev_err(dev, "%s: Failed to map phy-sif base\n", __func__);
> +               return PTR_ERR(pcie_phy->sif_base);

Use "return dev_err_probe(...)".

> +       }
> +
> +       pcie_phy->phy = devm_phy_create(dev, dev->of_node, &mtk_pcie_phy_ops);
> +       if (IS_ERR(pcie_phy->phy)) {
> +               dev_err(dev, "%s: Failed to create PCIe phy\n", __func__);
> +               return PTR_ERR(pcie_phy->phy);

Same here.

> +       }
> +
> +       phy_set_drvdata(pcie_phy->phy, pcie_phy);
> +
> +       provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +       return PTR_ERR_OR_ZERO(provider);

No error message if it fails?

Also, small nit: many prefer not to use PTR_ERR_OR_ZERO, as it adds a line
that needs to be changed if the core needs to be extended.

> +}
> +
> +static const struct of_device_id mtk_pcie_phy_of_match[] = {
> +       { .compatible = "mediatek,pcie-phy" },

As mentioned for the binding patch, use a SoC specific compatible string.


Regards
ChenYu


> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, mtk_pcie_phy_of_match);
> +
> +static struct platform_driver mtk_pcie_phy_driver = {
> +       .probe  = mtk_pcie_phy_probe,
> +       .driver = {
> +               .name = "mtk-pcie-phy",
> +               .of_match_table = mtk_pcie_phy_of_match,
> +       },
> +};
> +module_platform_driver(mtk_pcie_phy_driver);
> +
> +MODULE_DESCRIPTION("MediaTek PCIe PHY driver");
> +MODULE_AUTHOR("Jianjun Wang <jianjun.wang@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
