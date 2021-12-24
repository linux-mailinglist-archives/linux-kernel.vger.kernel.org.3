Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CECA47EE26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352386AbhLXKEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 05:04:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35350 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbhLXKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 05:04:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 86E311F45CBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1640340240;
        bh=Cqq6tirJ0J1L4jiIGUBseXI83U5oUF+xGxcJB7JV+C0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dfMkblv93jkQ9u4GG5y3VrGIMYCal8Wg2B4CuGt/AMloQSpze8SpDQWdAxc+CMqbs
         CzoEo2FU5K861VHCrosQq/X11VYRk4GSRK5gssnCyikKfJXEiB4FyHsa6iOp1fxPF7
         YJ4QoZfc4LcVvvv6wI6b1SBy0lxPPpoUKk+FaP7AmKdcaW6eC0YxVVv0zr3fjZx7js
         Ainq/P1V/ZcacTvpaiDmM5MuBAphVuIvF+UKUcQvSS2MXaL5qfx674+o8rP6B6lx2L
         PK0tbflhmxbS1qiTUN+iWVyDHmIGYt+JGGcr+vgxvtbbwXqJv6yi7xkr+PIN8J152M
         mBT3oAJw6/Q8Q==
Subject: Re: [PATCH v2 2/5] phy: phy-mtk-tphy: add support efuse setting
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
 <20211218082802.5256-2-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <bc841baa-e025-b0b8-8dbd-f438fd6981f7@collabora.com>
Date:   Fri, 24 Dec 2021 11:03:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211218082802.5256-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/12/21 09:27, Chunfeng Yun ha scritto:
> Due to some SoCs have a bit shift issue that will drop a bit for usb3
> phy or pcie phy, fix it by adding software efuse reading and setting,
> but only support it optionally for version 2/3.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: changes suggested by Vinod
>      1. fix typo of version in commit message
>      2. use dev_dbg() instead of dev_info()
> ---
>   drivers/phy/mediatek/phy-mtk-tphy.c | 162 ++++++++++++++++++++++++++++
>   1 file changed, 162 insertions(+)
> 

Hello Chunfeng, thanks for the patch!
However, there are a few things to improve...

> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> index cdcef865fe9e..98a942c607a6 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -12,6 +12,7 @@
>   #include <linux/iopoll.h>
>   #include <linux/mfd/syscon.h>
>   #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>   #include <linux/of_address.h>
>   #include <linux/of_device.h>
>   #include <linux/phy/phy.h>
> @@ -41,6 +42,9 @@
>   #define SSUSB_SIFSLV_V2_U3PHYD		0x200
>   #define SSUSB_SIFSLV_V2_U3PHYA		0x400
>   
> +#define U3P_MISC_REG1		0x04
> +#define MR1_EFUSE_AUTO_LOAD_DIS		BIT(6)
> +
>   #define U3P_USBPHYACR0		0x000
>   #define PA0_RG_U2PLL_FORCE_ON		BIT(15)
>   #define PA0_USB20_PLL_PREDIV		GENMASK(7, 6)
> @@ -133,6 +137,8 @@
>   #define P3C_RG_SWRST_U3_PHYD_FORCE_EN	BIT(24)
>   
>   #define U3P_U3_PHYA_REG0	0x000
> +#define P3A_RG_IEXT_INTR		GENMASK(15, 10)
> +#define P3A_RG_IEXT_INTR_VAL(x)		((0x3f & (x)) << 10)
>   #define P3A_RG_CLKDRV_OFF		GENMASK(3, 2)
>   #define P3A_RG_CLKDRV_OFF_VAL(x)	((0x3 & (x)) << 2)
>   
> @@ -187,6 +193,19 @@
>   #define P3D_RG_FWAKE_TH		GENMASK(21, 16)
>   #define P3D_RG_FWAKE_TH_VAL(x)	((0x3f & (x)) << 16)
>   
> +#define U3P_U3_PHYD_IMPCAL0		0x010
> +#define P3D_RG_FORCE_TX_IMPEL		BIT(31)
> +#define P3D_RG_TX_IMPEL			GENMASK(28, 24)
> +#define P3D_RG_TX_IMPEL_VAL(x)		((0x1f & (x)) << 24)
> +
> +#define U3P_U3_PHYD_IMPCAL1		0x014
> +#define P3D_RG_FORCE_RX_IMPEL		BIT(31)
> +#define P3D_RG_RX_IMPEL			GENMASK(28, 24)
> +#define P3D_RG_RX_IMPEL_VAL(x)		((0x1f & (x)) << 24)
> +
> +#define U3P_U3_PHYD_RSV			0x054
> +#define P3D_RG_EFUSE_AUTO_LOAD_DIS	BIT(12)
> +
>   #define U3P_U3_PHYD_CDR1		0x05c
>   #define P3D_RG_CDR_BIR_LTD1		GENMASK(28, 24)
>   #define P3D_RG_CDR_BIR_LTD1_VAL(x)	((0x1f & (x)) << 24)
> @@ -307,6 +326,11 @@ struct mtk_phy_pdata {
>   	 * 48M PLL, fix it by switching PLL to 26M from default 48M
>   	 */
>   	bool sw_pll_48m_to_26m;
> +	/*
> +	 * Some SoCs (e.g. mt8195) drop a bit when use auto load efuse,
> +	 * support sw way, also support it for v2/v3 optionally.
> +	 */
> +	bool sw_efuse_supported;
>   	enum mtk_phy_version version;
>   };
>   
> @@ -336,6 +360,10 @@ struct mtk_phy_instance {
>   	struct regmap *type_sw;
>   	u32 type_sw_reg;
>   	u32 type_sw_index;
> +	u32 efuse_sw_en;
> +	u32 efuse_intr;
> +	u32 efuse_tx_imp;
> +	u32 efuse_rx_imp;
>   	int eye_src;
>   	int eye_vrt;
>   	int eye_term;
> @@ -1040,6 +1068,130 @@ static int phy_type_set(struct mtk_phy_instance *instance)
>   	return 0;
>   }
>   
> +static int phy_efuse_get(struct mtk_tphy *tphy, struct mtk_phy_instance *instance)
> +{
> +	struct device *dev = &instance->phy->dev;
> +	int ret = 0;
> +
> +	/* tphy v1 doesn't support sw efuse, skip it */
> +	if (!tphy->pdata->sw_efuse_supported) {
> +		instance->efuse_sw_en = 0;
> +		return 0;
> +	}
> +
> +	/* software efuse is optional */
> +	instance->efuse_sw_en = device_property_read_bool(dev, "nvmem-cells");
> +	if (!instance->efuse_sw_en)
> +		return 0;
> +
> +	switch (instance->type) {
> +	case PHY_TYPE_USB2:
> +		ret = nvmem_cell_read_variable_le_u32(dev, "intr", &instance->efuse_intr);
> +		if (ret) {
> +			dev_err(dev, "fail to get u2 intr efuse, %d\n", ret);
> +			break;
> +		}
> +
> +		/* no efuse, ignore it */
> +		if (!instance->efuse_intr) {
> +			dev_warn(dev, "no u2 intr efuse, but dts enable it\n");
> +			instance->efuse_sw_en = 0;
> +			break;
> +		}
> +
> +		dev_dbg(dev, "u2 efuse - intr %x\n", instance->efuse_intr);
> +		break;
> +
> +	case PHY_TYPE_USB3:
> +	case PHY_TYPE_PCIE:
> +		ret = nvmem_cell_read_variable_le_u32(dev, "intr", &instance->efuse_intr);
> +		if (ret) {
> +			dev_err(dev, "fail to get u3 intr efuse, %d\n", ret);
> +			break;
> +		}
> +
> +		ret = nvmem_cell_read_variable_le_u32(dev, "rx_imp", &instance->efuse_rx_imp);
> +		if (ret) {
> +			dev_err(dev, "fail to get u3 rx_imp efuse, %d\n", ret);
> +			break;
> +		}
> +
> +		ret = nvmem_cell_read_variable_le_u32(dev, "tx_imp", &instance->efuse_tx_imp);
> +		if (ret) {
> +			dev_err(dev, "fail to get u3 tx_imp efuse, %d\n", ret);
> +			break;
> +		}
> +
> +		/* no efuse, ignore it */
> +		if (!instance->efuse_intr &&
> +		    !instance->efuse_rx_imp &&
> +		    !instance->efuse_rx_imp) {
> +			dev_warn(dev, "no u3 intr efuse, but dts enable it\n");
> +			instance->efuse_sw_en = 0;
> +			break;
> +		}
> +
> +		dev_dbg(dev, "u3 efuse - intr %x, rx_imp %x, tx_imp %x\n",
> +			instance->efuse_intr, instance->efuse_rx_imp,instance->efuse_tx_imp);
> +		break;
> +	default:
> +		dev_err(dev, "no sw efuse for type %d\n", instance->type);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void phy_efuse_set(struct mtk_phy_instance *instance)

The name for this function is a bit misleading and one may think that this
is writing efuses (aka blowing a fuse array), which doesn't look like being
the case at all.

What about changing it to phy_set_sw_efuse_params(), or something similar?


Thank you,
- Angelo
