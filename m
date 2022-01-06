Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B7486182
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiAFIij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:38:39 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:51946 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236650AbiAFIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:38:36 -0500
X-UUID: defbefcfb5d74b27b84f2dc6dd8a30f8-20220106
X-UUID: defbefcfb5d74b27b84f2dc6dd8a30f8-20220106
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 940994645; Thu, 06 Jan 2022 16:38:34 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 6 Jan 2022 16:38:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Jan
 2022 16:38:33 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 16:38:32 +0800
Message-ID: <509b82079256ffaa0d844ae5a79a436fced16f3f.camel@mediatek.com>
Subject: Re: [PATCH 2/3] phy: mediatek: phy-mtk-mipi-dsi: Reorder and stop
 implicit header inclusion
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <chunkuang.hu@kernel.org>
CC:     <p.zabel@pengutronix.de>, <kishon@ti.com>, <vkoul@kernel.org>,
        <matthias.bgg@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date:   Thu, 6 Jan 2022 16:38:32 +0800
In-Reply-To: <20220103145324.48008-2-angelogioacchino.delregno@collabora.com>
References: <20220103145324.48008-1-angelogioacchino.delregno@collabora.com>
         <20220103145324.48008-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-03 at 15:53 +0100, AngeloGioacchino Del Regno wrote:
> All the headers for phy-mtk-mipi-{dsi,dsi-mt8173,dsi-mt8183}.c were
> included from phy-mtk-mipi-dsi.h, but this isn't optimal: in order to
> increase readability and sensibly reduce build times, the inclusions
> should be done per-file, also avoiding to include unused headers and
> should not be implicit.
> 
> For this reason, move the inclusions to each file and remove unused
> ones.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c |  4 ++++
>  drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c |  4 ++++
>  drivers/phy/mediatek/phy-mtk-mipi-dsi.c        |  7 +++++++
>  drivers/phy/mediatek/phy-mtk-mipi-dsi.h        | 10 ++--------
>  4 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
> b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
> index 95a0d9a3cca7..59f028da9d3e 100644
> --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
> @@ -4,7 +4,11 @@
>   * Author: jitao.shi <jitao.shi@mediatek.com>
>   */
>  
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/phy/phy.h>
>  #include "phy-mtk-mipi-dsi.h"
>  
>  #define MIPITX_DSI_CON		0x00
> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> index 01b59527669e..6c6b192485ba 100644
> --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> @@ -4,7 +4,11 @@
>   * Author: jitao.shi <jitao.shi@mediatek.com>
>   */
>  
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/phy/phy.h>
>  #include "phy-mtk-mipi-dsi.h"
>  
>  #define MIPITX_LANE_CON		0x000c
> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> index 51b1b1d4ad38..6f7425b0bf5b 100644
> --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> @@ -3,7 +3,14 @@
>   * Copyright (c) 2015 MediaTek Inc.
>   */
>  
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/phy/phy.h>
>  #include "phy-mtk-mipi-dsi.h"
>  
>  inline struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw
> *hw)
> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
> b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
> index 8d32e9027a15..4eb5fc91e083 100644
> --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
> @@ -7,16 +7,10 @@
>  #ifndef _MTK_MIPI_TX_H
>  #define _MTK_MIPI_TX_H
>  
> -#include <linux/clk.h>
>  #include <linux/clk-provider.h>
> -#include <linux/delay.h>
> -#include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/nvmem-consumer.h>
> -#include <linux/of_device.h>
> -#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/regmap.h>
>  #include <linux/phy/phy.h>
> -#include <linux/slab.h>
>  
I don't think it's good idea to move the common headers into .c files

>  struct mtk_mipitx_data {
>  	const u32 mppll_preserve;

