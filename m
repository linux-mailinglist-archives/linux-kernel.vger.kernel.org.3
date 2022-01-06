Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D947D48620D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbiAFJYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:24:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55166 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237364AbiAFJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:24:12 -0500
X-UUID: 945a0748c908428b9978267c7bd64838-20220106
X-UUID: 945a0748c908428b9978267c7bd64838-20220106
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 467672720; Thu, 06 Jan 2022 17:24:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Jan 2022 17:24:07 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 17:24:07 +0800
Message-ID: <3a1bffc6f677ef9790749a366424fe5effda90f7.camel@mediatek.com>
Subject: Re: [PATCH 2/4] phy: mediatek: phy-mtk-hdmi: Reorder to remove
 forward declarations
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <chunkuang.hu@kernel.org>
CC:     <p.zabel@pengutronix.de>, <kishon@ti.com>, <vkoul@kernel.org>,
        <matthias.bgg@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date:   Thu, 6 Jan 2022 17:24:07 +0800
In-Reply-To: <20220103153055.50473-2-angelogioacchino.delregno@collabora.com>
References: <20220103153055.50473-1-angelogioacchino.delregno@collabora.com>
         <20220103153055.50473-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-03 at 16:30 +0100, AngeloGioacchino Del Regno wrote:
> Forward declarations for mtk_hdmi_power_{on,off} aren't necessary:
> move mtk_hdmi_phy_dev_ops down to remove forward declarations.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/phy/mediatek/phy-mtk-hdmi.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c
> b/drivers/phy/mediatek/phy-mtk-hdmi.c
> index 707e90691e6e..b4193cb4e4e3 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
> @@ -6,15 +6,6 @@
>  
>  #include "phy-mtk-hdmi.h"
>  
> -static int mtk_hdmi_phy_power_on(struct phy *phy);
> -static int mtk_hdmi_phy_power_off(struct phy *phy);
> -
> -static const struct phy_ops mtk_hdmi_phy_dev_ops = {
> -	.power_on = mtk_hdmi_phy_power_on,
> -	.power_off = mtk_hdmi_phy_power_off,
> -	.owner = THIS_MODULE,
> -};
> -
>  inline struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw)
>  {
>  	return container_of(hw, struct mtk_hdmi_phy, pll_hw);
> @@ -43,6 +34,12 @@ static int mtk_hdmi_phy_power_off(struct phy *phy)
>  	return 0;
>  }
>  
> +static const struct phy_ops mtk_hdmi_phy_dev_ops = {
> +	.power_on = mtk_hdmi_phy_power_on,
> +	.power_off = mtk_hdmi_phy_power_off,
> +	.owner = THIS_MODULE,
> +};
> +
>  static const struct phy_ops *
>  mtk_hdmi_phy_dev_get_ops(const struct mtk_hdmi_phy *hdmi_phy)
>  {
Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks a lot


