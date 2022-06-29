Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1074560452
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiF2PSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiF2PSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:18:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0135F1090
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:18:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1o6ZRy-0004xL-3C; Wed, 29 Jun 2022 17:17:54 +0200
Message-ID: <7158eb7c000c1698d36fe2b32d8f6d040462a6f1.camel@pengutronix.de>
Subject: Re: [PATCH V2 9/9] interconnect: imx: Add platform driver for imx8mp
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Date:   Wed, 29 Jun 2022 17:17:52 +0200
In-Reply-To: <20220616073320.2203000-10-peng.fan@oss.nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
         <20220616073320.2203000-10-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 16.06.2022 um 15:33 +0800 schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add a platform driver for the i.MX8MP SoC describing bus topology, based
> on internal documentation.

This series is missing the compatible addition in drivers/devfreq/imx-
bus.c to make the platform driver probe.

Other than that, looks good.

Regards,
Lucas

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/interconnect/imx/Kconfig  |   4 +
>  drivers/interconnect/imx/Makefile |   2 +
>  drivers/interconnect/imx/imx8mp.c | 259 ++++++++++++++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 drivers/interconnect/imx/imx8mp.c
> 
> diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
> index be2928362bb7..c772552431f5 100644
> --- a/drivers/interconnect/imx/Kconfig
> +++ b/drivers/interconnect/imx/Kconfig
> @@ -15,3 +15,7 @@ config INTERCONNECT_IMX8MN
>  config INTERCONNECT_IMX8MQ
>  	tristate "i.MX8MQ interconnect driver"
>  	depends on INTERCONNECT_IMX
> +
> +config INTERCONNECT_IMX8MP
> +	tristate "i.MX8MP interconnect driver"
> +	depends on INTERCONNECT_IMX
> diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
> index 21fd5233754f..16d256cdeab4 100644
> --- a/drivers/interconnect/imx/Makefile
> +++ b/drivers/interconnect/imx/Makefile
> @@ -2,8 +2,10 @@ imx-interconnect-objs			:= imx.o
>  imx8mm-interconnect-objs       		:= imx8mm.o
>  imx8mq-interconnect-objs       		:= imx8mq.o
>  imx8mn-interconnect-objs       		:= imx8mn.o
> +imx8mp-interconnect-objs       		:= imx8mp.o
>  
>  obj-$(CONFIG_INTERCONNECT_IMX)		+= imx-interconnect.o
>  obj-$(CONFIG_INTERCONNECT_IMX8MM)	+= imx8mm-interconnect.o
>  obj-$(CONFIG_INTERCONNECT_IMX8MQ)	+= imx8mq-interconnect.o
>  obj-$(CONFIG_INTERCONNECT_IMX8MN)	+= imx8mn-interconnect.o
> +obj-$(CONFIG_INTERCONNECT_IMX8MP)	+= imx8mp-interconnect.o
> diff --git a/drivers/interconnect/imx/imx8mp.c b/drivers/interconnect/imx/imx8mp.c
> new file mode 100644
> index 000000000000..2be2e9e2974e
> --- /dev/null
> +++ b/drivers/interconnect/imx/imx8mp.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Interconnect framework driver for i.MX8MP SoC
> + *
> + * Copyright 2022 NXP
> + * Peng Fan <peng.fan@nxp.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/interconnect/fsl,imx8mp.h>
> +
> +#include "imx.h"
> +
> +static const struct imx_icc_node_adj_desc imx8mp_noc_adj = {
> +	.bw_mul = 1,
> +	.bw_div = 16,
> +	.main_noc = true,
> +};
> +
> +static struct imx_icc_noc_setting noc_setting_nodes[] = {
> +	[IMX8MP_ICM_MLMIX] = {
> +		.reg = 0x180,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICM_DSP] = {
> +		.reg = 0x200,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICM_SDMA2PER] = {
> +		.reg = 0x280,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 4,
> +	},
> +	[IMX8MP_ICM_SDMA2BURST] = {
> +		.reg = 0x300,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 4,
> +	},
> +	[IMX8MP_ICM_SDMA3PER] = {
> +		.reg = 0x380,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 4,
> +	},
> +	[IMX8MP_ICM_SDMA3BURST] = {
> +		.reg = 0x400,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 4,
> +	},
> +	[IMX8MP_ICM_EDMA] = {
> +		.reg = 0x480,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 4,
> +	},
> +	[IMX8MP_ICM_GPU3D] = {
> +		.reg = 0x500,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICM_GPU2D] = {
> +		.reg = 0x580,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICM_HRV] = {
> +		.reg = 0x600,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 2,
> +		.ext_control = 1,
> +	},
> +	[IMX8MP_ICM_LCDIF_HDMI] = {
> +		.reg = 0x680,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 2,
> +		.ext_control = 1,
> +	},
> +	[IMX8MP_ICM_HDCP] = {
> +		.reg = 0x700,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 5,
> +	},
> +	[IMX8MP_ICM_NOC_PCIE] = {
> +		.reg = 0x780,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICM_USB1] = {
> +		.reg = 0x800,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICM_USB2] = {
> +		.reg = 0x880,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICM_PCIE] = {
> +		.reg = 0x900,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICM_LCDIF_RD] = {
> +		.reg = 0x980,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 2,
> +		.ext_control = 1,
> +	},
> +	[IMX8MP_ICM_LCDIF_WR] = {
> +		.reg = 0xa00,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 2,
> +		.ext_control = 1,
> +	},
> +	[IMX8MP_ICM_ISI0] = {
> +		.reg = 0xa80,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 2,
> +		.ext_control = 1,
> +	},
> +	[IMX8MP_ICM_ISI1] = {
> +		.reg = 0xb00,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 2,
> +		.ext_control = 1,
> +	},
> +	[IMX8MP_ICM_ISI2] = {
> +		.reg = 0xb80,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 2,
> +		.ext_control = 1,
> +	},
> +	[IMX8MP_ICM_ISP0] = {
> +		.reg = 0xc00,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 7,
> +	},
> +	[IMX8MP_ICM_ISP1] = {
> +		.reg = 0xc80,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 7,
> +	},
> +	[IMX8MP_ICM_DWE] = {
> +		.reg = 0xd00,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 7,
> +	},
> +	[IMX8MP_ICM_VPU_G1] = {
> +		.reg = 0xd80,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICM_VPU_G2] = {
> +		.reg = 0xe00,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICM_VPU_H1] = {
> +		.reg = 0xe80,
> +		.mode = IMX_NOC_MODE_FIXED,
> +		.prio_level = 3,
> +	},
> +	[IMX8MP_ICN_MEDIA] = {
> +		.ignore = true,
> +	},
> +	[IMX8MP_ICN_VIDEO] = {
> +		.ignore = true,
> +	},
> +	[IMX8MP_ICN_AUDIO] = {
> +		.ignore = true,
> +	},
> +	[IMX8MP_ICN_HDMI] = {
> +		.ignore = true,
> +	},
> +	[IMX8MP_ICN_GPU] = {
> +		.ignore = true,
> +	},
> +	[IMX8MP_ICN_HSIO] = {
> +		.ignore = true,
> +	},
> +};
> +
> +/* Describe bus masters, slaves and connections between them */
> +static struct imx_icc_node_desc nodes[] = {
> +	DEFINE_BUS_INTERCONNECT("NOC", IMX8MP_ICN_NOC, &imx8mp_noc_adj,
> +				IMX8MP_ICS_DRAM, IMX8MP_ICN_MAIN),
> +
> +	DEFINE_BUS_SLAVE("OCRAM", IMX8MP_ICS_OCRAM, NULL),
> +	DEFINE_BUS_SLAVE("DRAM", IMX8MP_ICS_DRAM, NULL),
> +	DEFINE_BUS_MASTER("A53", IMX8MP_ICM_A53, IMX8MP_ICN_NOC),
> +	DEFINE_BUS_MASTER("SUPERMIX", IMX8MP_ICM_SUPERMIX, IMX8MP_ICN_NOC),
> +	DEFINE_BUS_MASTER("GIC", IMX8MP_ICM_GIC, IMX8MP_ICN_NOC),
> +	DEFINE_BUS_MASTER("MLMIX", IMX8MP_ICM_MLMIX, IMX8MP_ICN_NOC),
> +
> +	DEFINE_BUS_INTERCONNECT("NOC_AUDIO", IMX8MP_ICN_AUDIO, NULL, IMX8MP_ICN_NOC),
> +	DEFINE_BUS_MASTER("DSP", IMX8MP_ICM_DSP, IMX8MP_ICN_AUDIO),
> +	DEFINE_BUS_MASTER("SDMA2PER", IMX8MP_ICM_SDMA2PER, IMX8MP_ICN_AUDIO),
> +	DEFINE_BUS_MASTER("SDMA2BURST", IMX8MP_ICM_SDMA2BURST, IMX8MP_ICN_AUDIO),
> +	DEFINE_BUS_MASTER("SDMA3PER", IMX8MP_ICM_SDMA3PER, IMX8MP_ICN_AUDIO),
> +	DEFINE_BUS_MASTER("SDMA3BURST", IMX8MP_ICM_SDMA3BURST, IMX8MP_ICN_AUDIO),
> +	DEFINE_BUS_MASTER("EDMA", IMX8MP_ICM_EDMA, IMX8MP_ICN_AUDIO),
> +
> +	DEFINE_BUS_INTERCONNECT("NOC_GPU", IMX8MP_ICN_GPU, NULL, IMX8MP_ICN_NOC),
> +	DEFINE_BUS_MASTER("GPU 2D", IMX8MP_ICM_GPU2D, IMX8MP_ICN_GPU),
> +	DEFINE_BUS_MASTER("GPU 3D", IMX8MP_ICM_GPU3D, IMX8MP_ICN_GPU),
> +
> +	DEFINE_BUS_INTERCONNECT("NOC_HDMI", IMX8MP_ICN_HDMI, NULL, IMX8MP_ICN_NOC),
> +	DEFINE_BUS_MASTER("HRV", IMX8MP_ICM_HRV, IMX8MP_ICN_HDMI),
> +	DEFINE_BUS_MASTER("LCDIF_HDMI", IMX8MP_ICM_LCDIF_HDMI, IMX8MP_ICN_HDMI),
> +	DEFINE_BUS_MASTER("HDCP", IMX8MP_ICM_HDCP, IMX8MP_ICN_HDMI),
> +
> +	DEFINE_BUS_INTERCONNECT("NOC_HSIO", IMX8MP_ICN_HSIO, NULL, IMX8MP_ICN_NOC),
> +	DEFINE_BUS_MASTER("NOC_PCIE", IMX8MP_ICM_NOC_PCIE, IMX8MP_ICN_HSIO),
> +	DEFINE_BUS_MASTER("USB1", IMX8MP_ICM_USB1, IMX8MP_ICN_HSIO),
> +	DEFINE_BUS_MASTER("USB2", IMX8MP_ICM_USB2, IMX8MP_ICN_HSIO),
> +	DEFINE_BUS_MASTER("PCIE", IMX8MP_ICM_PCIE, IMX8MP_ICN_HSIO),
> +
> +	DEFINE_BUS_INTERCONNECT("NOC_MEDIA", IMX8MP_ICN_MEDIA, NULL, IMX8MP_ICN_NOC),
> +	DEFINE_BUS_MASTER("LCDIF_RD", IMX8MP_ICM_LCDIF_RD, IMX8MP_ICN_MEDIA),
> +	DEFINE_BUS_MASTER("LCDIF_WR", IMX8MP_ICM_LCDIF_WR, IMX8MP_ICN_MEDIA),
> +	DEFINE_BUS_MASTER("ISI0", IMX8MP_ICM_ISI0, IMX8MP_ICN_MEDIA),
> +	DEFINE_BUS_MASTER("ISI1", IMX8MP_ICM_ISI1, IMX8MP_ICN_MEDIA),
> +	DEFINE_BUS_MASTER("ISI2", IMX8MP_ICM_ISI2, IMX8MP_ICN_MEDIA),
> +	DEFINE_BUS_MASTER("ISP0", IMX8MP_ICM_ISP0, IMX8MP_ICN_MEDIA),
> +	DEFINE_BUS_MASTER("ISP1", IMX8MP_ICM_ISP1, IMX8MP_ICN_MEDIA),
> +	DEFINE_BUS_MASTER("DWE", IMX8MP_ICM_DWE, IMX8MP_ICN_MEDIA),
> +
> +	DEFINE_BUS_INTERCONNECT("NOC_VIDEO", IMX8MP_ICN_VIDEO, NULL, IMX8MP_ICN_NOC),
> +	DEFINE_BUS_MASTER("VPU G1", IMX8MP_ICM_VPU_G1, IMX8MP_ICN_VIDEO),
> +	DEFINE_BUS_MASTER("VPU G2", IMX8MP_ICM_VPU_G2, IMX8MP_ICN_VIDEO),
> +	DEFINE_BUS_MASTER("VPU H1", IMX8MP_ICM_VPU_H1, IMX8MP_ICN_VIDEO),
> +	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MP_ICN_MAIN, NULL,
> +				IMX8MP_ICN_NOC, IMX8MP_ICS_OCRAM),
> +};
> +
> +static int imx8mp_icc_probe(struct platform_device *pdev)
> +{
> +	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), noc_setting_nodes);
> +}
> +
> +static int imx8mp_icc_remove(struct platform_device *pdev)
> +{
> +	return imx_icc_unregister(pdev);
> +}
> +
> +static struct platform_driver imx8mp_icc_driver = {
> +	.probe = imx8mp_icc_probe,
> +	.remove = imx8mp_icc_remove,
> +	.driver = {
> +		.name = "imx8mp-interconnect",
> +	},
> +};
> +
> +module_platform_driver(imx8mp_icc_driver);
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:imx8mp-interconnect");


