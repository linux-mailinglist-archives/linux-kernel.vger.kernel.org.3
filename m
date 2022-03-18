Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184F64DD937
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiCRLuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiCRLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:50:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671763E0F4;
        Fri, 18 Mar 2022 04:48:46 -0700 (PDT)
X-UUID: 02ebdfe18eed4ed697dd1f28074c298b-20220318
X-UUID: 02ebdfe18eed4ed697dd1f28074c298b-20220318
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2018278411; Fri, 18 Mar 2022 19:48:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 18 Mar 2022 19:48:40 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 19:48:39 +0800
Message-ID: <8b74600a0f9963328cfb278b0ea1131b5900df3b.camel@mediatek.com>
Subject: Re: [PATCH v2 2/2] phy: mediatek: Add PCIe PHY driver
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Chen-Yu Tsai" <wenst@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <randy.wu@mediatek.com>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Date:   Fri, 18 Mar 2022 19:48:39 +0800
In-Reply-To: <a3ccba54-9076-0966-f282-1943f10a0346@collabora.com>
References: <20220318095417.2016-1-jianjun.wang@mediatek.com>
         <20220318095417.2016-3-jianjun.wang@mediatek.com>
         <a3ccba54-9076-0966-f282-1943f10a0346@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

Thanks for all these suggestions, I'll fix them in the next version.

Thanks.

On Fri, 2022-03-18 at 11:57 +0100, AngeloGioacchino Del Regno wrote:
> Il 18/03/22 10:54, Jianjun Wang ha scritto:
> > Add PCIe GEN3 PHY driver support on MediaTek chipsets.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > ---
> >   drivers/phy/mediatek/Kconfig        |  11 ++
> >   drivers/phy/mediatek/Makefile       |   1 +
> >   drivers/phy/mediatek/phy-mtk-pcie.c | 246
> > ++++++++++++++++++++++++++++
> >   3 files changed, 258 insertions(+)
> >   create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
> > 
> > diff --git a/drivers/phy/mediatek/Kconfig
> > b/drivers/phy/mediatek/Kconfig
> > index 55f8e6c048ab..387ed1b3f2cc 100644
> > --- a/drivers/phy/mediatek/Kconfig
> > +++ b/drivers/phy/mediatek/Kconfig
> > @@ -55,3 +55,14 @@ config PHY_MTK_MIPI_DSI
> >   	select GENERIC_PHY
> >   	help
> >   	  Support MIPI DSI for Mediatek SoCs.
> > +
> > +config PHY_MTK_PCIE
> > +	tristate "MediaTek PCIe-PHY Driver"
> > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +	depends on OF
> > +	select GENERIC_PHY
> > +	help
> > +	  Say 'Y' here to add support for MediaTek PCIe PHY driver.
> > +	  This driver create the basic PHY instance and provides
> > initialize
> > +	  callback for PCIe GEN3 port, it supports software efuse
> > +	  initialization.
> > diff --git a/drivers/phy/mediatek/Makefile
> > b/drivers/phy/mediatek/Makefile
> > index ace660fbed3a..788c13147f63 100644
> > --- a/drivers/phy/mediatek/Makefile
> > +++ b/drivers/phy/mediatek/Makefile
> > @@ -6,6 +6,7 @@
> >   obj-$(CONFIG_PHY_MTK_TPHY)		+= phy-mtk-tphy.o
> >   obj-$(CONFIG_PHY_MTK_UFS)		+= phy-mtk-ufs.o
> >   obj-$(CONFIG_PHY_MTK_XSPHY)		+= phy-mtk-xsphy.o
> > +obj-$(CONFIG_PHY_MTK_PCIE)		+= phy-mtk-pcie.o
> >   
> >   phy-mtk-hdmi-drv-y			:= phy-mtk-hdmi.o
> >   phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-
> > mt2701.o
> > diff --git a/drivers/phy/mediatek/phy-mtk-pcie.c
> > b/drivers/phy/mediatek/phy-mtk-pcie.c
> > new file mode 100644
> > index 000000000000..0f5d7c7e2b7e
> > --- /dev/null
> > +++ b/drivers/phy/mediatek/phy-mtk-pcie.c
> > @@ -0,0 +1,246 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022 MediaTek Inc.
> > + * Author: Jianjun Wang <jianjun.wang@mediatek.com>
> > + */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/compiler_types.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#include "phy-mtk-io.h"
> > +
> > +#define PEXTP_ANA_GLB_00_REG		0x9000
> > +#define PEXTP_ANA_LN0_TRX_REG		0xa000
> > +#define PEXTP_ANA_TX_OFFSET		0x04
> > +#define PEXTP_ANA_RX_OFFSET		0x3c
> > +#define PEXTP_ANA_LANE_OFFSET		0x100
> > +
> > +/* PEXTP_GLB_00_REG[28:24] Internal Resistor Selection of TX Bias
> > Current */
> > +#define EFUSE_GLB_INTR_SEL		GENMASK(28, 24)
> > +#define EFUSE_GLB_INTR_VAL(x)		((0x1f & (x)) << 24)
> > +
> > +/* PEXTP_ANA_LN_RX_REG[3:0] RX impedance selection */
> > +#define EFUSE_LN_RX_SEL			GENMASK(3, 0)
> > +#define EFUSE_LN_RX_VAL(x)		(0xf & (x))
> > +
> > +/* PEXTP_ANA_LN_TX_REG[5:2] TX PMOS impedance selection */
> > +#define EFUSE_LN_TX_PMOS_SEL		GENMASK(5, 2)
> > +#define EFUSE_LN_TX_PMOS_VAL(x)		((0xf & (x)) << 2)
> > +
> > +/* PEXTP_ANA_LN_TX_REG[11:8] TX NMOS impedance selection */
> > +#define EFUSE_LN_TX_NMOS_SEL		GENMASK(11, 8)
> > +#define EFUSE_LN_TX_NMOS_VAL(x)		((0xf & (x)) << 8)
> > +
> > +/* Efuse data for each lane */
> 
> What about some kerneldoc?
> 
> /**
>   * struct mtk_pcie_lane_efuse - eFuse data for each lane
>   * @tx_pmos:
>   ......etc :))
> 
> > +struct mtk_pcie_lane_efuse {
> > +	u32 tx_pmos;
> > +	u32 tx_nmos;
> > +	u32 rx_data;
> > +	bool lane_efuse_supported;
> > +};
> > +
> 
> Same here
> 
> /**
>   * struct mtk_pcie_phy - PCIe phy driver main structure
>   * @dev: ......
> 
> > +struct mtk_pcie_phy {
> > +	struct device *dev;
> > +	struct phy *phy;
> > +	void __iomem *sif_base;
> > +
> > +	/*
> > +	 * Support software efuse initialization,
> > +	 * currently we only support 2 lane in maximum.
> > +	 */
> 
> Obviously, if you add kerneldoc, this comment would get moved to that
> kerneldoc.
> 
> > +	bool sw_efuse_supported;
> > +	u32 efuse_glb_intr;
> 
> 
> > +	struct mtk_pcie_lane_efuse efuse[2];
> 
> If you dynamically allocate this one, you will be able to support any
> number
> of lanes, futureproofing this driver and giving it more flexibility.
> 
> > +};
> > +
> 
> ..snip..
> 
> > +
> > +static int mtk_pcie_efuse_read_for_lane(struct mtk_pcie_phy
> > *pcie_phy,
> > +					unsigned int lane)
> > +{
> > +	struct device *dev = pcie_phy->dev;
> > +	struct mtk_pcie_lane_efuse *data;
> > +	char efuse_id[15];
> > +	int ret;
> > +
> > +	if (lane >= ARRAY_SIZE(pcie_phy->efuse))
> > +		return dev_err_probe(pcie_phy->dev, -EINVAL,
> > +				     "Requested lane number %d exceeds
> > maximum %ld\n",
> > +				     lane, ARRAY_SIZE(pcie_phy->efuse)
> > - 1);
> 
> I don't like seeing dev_err_probe() outside of a probe function, but
> I acknowledge
> that the Linux documentation doesn't seem to give any direction about
> that, so
> this is a personal preference, at this point.
> 
> > +
> > +	data = &pcie_phy->efuse[lane];
> > +
> > +	snprintf(efuse_id, sizeof(efuse_id), "tx_ln%d_pmos", lane);
> > +	ret = nvmem_cell_read_variable_le_u32(dev, efuse_id, &data-
> > >tx_pmos);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read %s\n",
> > efuse_id);
> > +
> > +	snprintf(efuse_id, sizeof(efuse_id), "tx_ln%d_nmos", lane);
> > +	ret = nvmem_cell_read_variable_le_u32(dev, efuse_id, &data-
> > >tx_nmos);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read %s\n",
> > efuse_id);
> > +
> > +	snprintf(efuse_id, sizeof(efuse_id), "rx_ln%d", lane);
> > +	ret = nvmem_cell_read_variable_le_u32(dev, efuse_id, &data-
> > >rx_data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read %s\n",
> > efuse_id);
> > +
> > +	if (!(data->tx_pmos || data->tx_nmos || data->rx_data))
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "No efuse data found for lane%d,
> > but dts enable it\n",
> > +				     lane);
> > +
> > +	data->lane_efuse_supported = true;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_pcie_read_efuse(struct mtk_pcie_phy *pcie_phy)
> > +{
> > +	struct device *dev = pcie_phy->dev;
> > +	bool nvmem_enabled;
> > +	int ret;
> > +
> > +	nvmem_enabled = device_property_read_bool(dev, "nvmem-cells");
> > +	if (!nvmem_enabled)
> > +		return -ENODEV;
> > +
> > +	ret = nvmem_cell_read_variable_le_u32(dev, "glb_intr",
> > +					      &pcie_phy-
> > >efuse_glb_intr);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read
> > glb_intr\n");
> > +
> > +	pcie_phy->sw_efuse_supported = true;
> > +
> > +	ret = mtk_pcie_efuse_read_for_lane(pcie_phy, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mtk_pcie_efuse_read_for_lane(pcie_phy, 1);
> > +	if (ret)
> > +		return ret;
> 
> To give some more future-proofing to this driver, I would instead
> either add a
> u32 devicetree property "num-lanes" or, if the same SoC may not have
> a different
> number of lanes across controller instances, I would add a number of
> lanes
> parameter as data for each of_match.
> 
> You'd be at that point using a for loop here like:
> 
> for (i = 0; i < pcie_phy->num_lanes, i++) {
> 	ret = mtk_pcie_efuse_read_for_lane(pcie_phy, i);
> 	if (ret)
> 		return ret;
> }
> 
> Of course, the same logic would apply to mtk_pcie_phy_init(), where
> you are
> instead calling mtk_pcie_efuse_set_lane().
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_pcie_phy_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct phy_provider *provider;
> > +	struct mtk_pcie_phy *pcie_phy;
> > +
> > +	pcie_phy = devm_kzalloc(dev, sizeof(*pcie_phy), GFP_KERNEL);
> > +	if (!pcie_phy)
> > +		return -ENOMEM;
> > +
> > +	pcie_phy->dev = dev;
> > +
> > +	pcie_phy->sif_base =
> > devm_platform_ioremap_resource_byname(pdev, "sif");
> > +	if (IS_ERR(pcie_phy->sif_base))
> > +		return dev_err_probe(dev, PTR_ERR(pcie_phy->sif_base),
> > +				     "Failed to map phy-sif base\n");
> > +
> > +	pcie_phy->phy = devm_phy_create(dev, dev->of_node,
> > &mtk_pcie_phy_ops);
> > +	if (IS_ERR(pcie_phy->phy))
> > +		return dev_err_probe(dev, PTR_ERR(pcie_phy->phy),
> > +				     "Failed to create PCIe phy\n");
> > +
> > +	/*
> > +	 * Failed to read the efuse data is not a fatal problem,
> > +	 * ignore the failure and keep going.
> > +	 */
> > +	mtk_pcie_read_efuse(pcie_phy);
> 
> If you get an -EPROBE_DEFER here, you surely want to defer probing
> this driver,
> so, yes you're free to ignore the other failures, but you should fix
> that corner
> case.
> 
> Everything else looks good, so, please make sure to add me to the
> Cc's for the
> next version of this series for me to give you a faster review.
> 
> Regards,
> Angelo
> 

