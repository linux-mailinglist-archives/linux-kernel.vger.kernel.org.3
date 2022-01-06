Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE8D486205
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiAFJWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:22:15 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:43602 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237329AbiAFJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:22:13 -0500
X-UUID: b3e22089bfdc4e59bd7f55b3e4185847-20220106
X-UUID: b3e22089bfdc4e59bd7f55b3e4185847-20220106
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 234049823; Thu, 06 Jan 2022 17:22:10 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 6 Jan 2022 17:22:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Jan
 2022 17:22:06 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 17:22:05 +0800
Message-ID: <c3773ed47126bf3810bc7d78e3ec293f144ccd7f.camel@mediatek.com>
Subject: Re: [PATCH 3/4] phy: mediatek: phy-mtk-hdmi: Reorder and stop
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
Date:   Thu, 6 Jan 2022 17:22:05 +0800
In-Reply-To: <20220103153055.50473-3-angelogioacchino.delregno@collabora.com>
References: <20220103153055.50473-1-angelogioacchino.delregno@collabora.com>
         <20220103153055.50473-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-03 at 16:30 +0100, AngeloGioacchino Del Regno wrote:
> All the headers for phy-mtk-{hdmi,hdmi-mt2701,hdmi-mt8183}.c were
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
>  drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c |  5 +++++
>  drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c |  5 +++++
>  drivers/phy/mediatek/phy-mtk-hdmi.c        |  8 ++++++++
>  drivers/phy/mediatek/phy-mtk-hdmi.h        | 10 +---------
>  4 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> index 09e0dd7499d8..270c5f538483 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> @@ -4,6 +4,11 @@
>   * Author: Chunhui Dai <chunhui.dai@mediatek.com>
>   */
>  
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
>  #include "phy-mtk-hdmi.h"
>  
>  #define HDMI_CON0	0x00
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
> b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
> index e317bf4a9db9..87ba9a3687b7 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
> @@ -4,6 +4,11 @@
>   * Author: Jie Qiu <jie.qiu@mediatek.com>
>   */
>  
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
>  #include "phy-mtk-hdmi.h"
>  
>  #define HDMI_CON0		0x00
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c
> b/drivers/phy/mediatek/phy-mtk-hdmi.c
> index b4193cb4e4e3..e037fa89696c 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
> @@ -4,6 +4,14 @@
>   * Author: Jie Qiu <jie.qiu@mediatek.com>
>   */
>  
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/phy/phy.h>
>  #include "phy-mtk-hdmi.h"
>  
>  inline struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw)
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.h
> b/drivers/phy/mediatek/phy-mtk-hdmi.h
> index a0571271d730..ef81e44a235d 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi.h
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi.h
> @@ -6,17 +6,9 @@
>  
>  #ifndef _MTK_HDMI_PHY_H
>  #define _MTK_HDMI_PHY_H
> -#include <linux/clk.h>
> +
>  #include <linux/clk-provider.h>
> -#include <linux/delay.h>
> -#include <linux/io.h>
> -#include <linux/mfd/syscon.h>
> -#include <linux/module.h>
> -#include <linux/of_device.h>
> -#include <linux/phy/phy.h>
> -#include <linux/platform_device.h>
>  #include <linux/regmap.h>
> -#include <linux/types.h>
Please do not move common headers also into .c files

>  
>  struct mtk_hdmi_phy;
>  

