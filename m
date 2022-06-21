Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE95529B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 05:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345146AbiFUDSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345246AbiFUDSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:18:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7A3BC8B;
        Mon, 20 Jun 2022 20:18:32 -0700 (PDT)
X-UUID: e73415c738d548588dbb11c5436c289c-20220621
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:1ae8409a-5334-4130-b8b0-2aa753b368b4,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:1ae8409a-5334-4130-b8b0-2aa753b368b4,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:9a8d982d-1756-4fa3-be7f-474a6e4be921,C
        OID:6e971a356d16,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: e73415c738d548588dbb11c5436c289c-20220621
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 443050633; Tue, 21 Jun 2022 11:18:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 21 Jun 2022 11:18:26 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 21 Jun 2022 11:18:26 +0800
Message-ID: <f8915cb4af91375dc9d7fc9c51f04863dd3e97dd.camel@mediatek.com>
Subject: Re: [PATCH v12 13/14] drm/mediatek: dpi: Only enable dpi after the
 bridge is enabled
From:   CK Hu <ck.hu@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 21 Jun 2022 11:18:26 +0800
In-Reply-To: <20220620121028.29234-14-rex-bc.chen@mediatek.com>
References: <20220620121028.29234-1-rex-bc.chen@mediatek.com>
         <20220620121028.29234-14-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo-Chen:

On Mon, 2022-06-20 at 20:10 +0800, Bo-Chen Chen wrote:
> From: Guillaume Ranquet <granquet@baylibre.com>
> 
> Enabling the dpi too early causes glitches on screen.
> 
> Move the call to mtk_dpi_enable() at the end of the bridge_enable
> callback to ensure everything is setup properly before enabling dpi.
> 
> Fixes: f89c696e7f63 ("drm/mediatek: mtk_dpi: Convert to bridge
> driver")

I think this problem happen in the first patch [1].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/drivers/gpu/drm/mediatek/mtk_dpi.c?h=mediatek-drm-next&id=9e629c17aa8d7a75b8c1d99ed42892cd8ba7cdc4

Regards,
CK

> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index fc76ccad0a82..220e9b18e2cd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -486,7 +486,6 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>  	if (dpi->pinctrl && dpi->pins_dpi)
>  		pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
>  
> -	mtk_dpi_enable(dpi);
>  	return 0;
>  
>  err_pixel:
> @@ -731,6 +730,7 @@ static void mtk_dpi_bridge_enable(struct
> drm_bridge *bridge)
>  
>  	mtk_dpi_power_on(dpi);
>  	mtk_dpi_set_display_mode(dpi, &dpi->mode);
> +	mtk_dpi_enable(dpi);
>  }
>  
>  static enum drm_mode_status

