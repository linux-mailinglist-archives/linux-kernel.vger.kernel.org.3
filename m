Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B65375F1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiE3HvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiE3Hua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:50:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B096300;
        Mon, 30 May 2022 00:50:28 -0700 (PDT)
X-UUID: c0e55e53b2994df78afd0a8347674eaf-20220530
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:fcd94474-4a89-4cd6-8c90-41c62bcbb644,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:b113c0b8-3c45-407b-8f66-25095432a27a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: c0e55e53b2994df78afd0a8347674eaf-20220530
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1881320135; Mon, 30 May 2022 15:50:24 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 30 May 2022 15:50:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 30 May 2022 15:50:23 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 May 2022 15:50:22 +0800
Message-ID: <2c88fd4c308e86536d5996b3f32f68d05d452e23.camel@mediatek.com>
Subject: Re: [PATCH v10 08/21] drm/mediatek: dpi: implement a swap_input
 toggle in SoC config
From:   CK Hu <ck.hu@mediatek.com>
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, "Helge Deller" <deller@gmx.de>,
        Jitao shi <jitao.shi@mediatek.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-fbdev@vger.kernel.org>
Date:   Mon, 30 May 2022 15:50:23 +0800
In-Reply-To: <20220523104758.29531-9-granquet@baylibre.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
         <20220523104758.29531-9-granquet@baylibre.com>
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

Hi, Guillaume:


On Mon, 2022-05-23 at 12:47 +0200, Guillaume Ranquet wrote:
> Adds a bit of flexibility to support SoCs without swap_input support
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 545a1337cc89..454f8563efae 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -126,6 +126,7 @@ struct mtk_dpi_conf {
>  	const u32 *output_fmts;
>  	u32 num_output_fmts;
>  	bool is_ck_de_pol;
> +	bool swap_input_support;
>  	const struct mtk_dpi_yc_limit *limit;
>  };
>  
> @@ -378,18 +379,21 @@ static void mtk_dpi_config_color_format(struct
> mtk_dpi *dpi,
>  	    (format == MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
>  		mtk_dpi_config_yuv422_enable(dpi, false);
>  		mtk_dpi_config_csc_enable(dpi, true);
> -		mtk_dpi_config_swap_input(dpi, false);
> +		if (dpi->conf->swap_input_support)
> +			mtk_dpi_config_swap_input(dpi, false);
>  		mtk_dpi_config_channel_swap(dpi,
> MTK_DPI_OUT_CHANNEL_SWAP_BGR);
>  	} else if ((format == MTK_DPI_COLOR_FORMAT_YCBCR_422) ||
>  		   (format == MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL)) {
>  		mtk_dpi_config_yuv422_enable(dpi, true);
>  		mtk_dpi_config_csc_enable(dpi, true);
> -		mtk_dpi_config_swap_input(dpi, true);
> +		if (dpi->conf->swap_input_support)
> +			mtk_dpi_config_swap_input(dpi, true);

As [1], please keep in touch with Mediatek engineer.

Regards,
CK

[1] 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220218145437.18563-8-granquet@baylibre.com/

>  		mtk_dpi_config_channel_swap(dpi,
> MTK_DPI_OUT_CHANNEL_SWAP_RGB);
>  	} else {
>  		mtk_dpi_config_yuv422_enable(dpi, false);
>  		mtk_dpi_config_csc_enable(dpi, false);
> -		mtk_dpi_config_swap_input(dpi, false);
> +		if (dpi->conf->swap_input_support)
> +			mtk_dpi_config_swap_input(dpi, false);
>  		mtk_dpi_config_channel_swap(dpi,
> MTK_DPI_OUT_CHANNEL_SWAP_RGB);
>  	}
>  }
> @@ -808,6 +812,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
>  	.is_ck_de_pol = true,
> +	.swap_input_support = true,
>  	.limit = &mtk_dpi_limit,
>  };
>  
> @@ -819,6 +824,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
>  	.is_ck_de_pol = true,
> +	.swap_input_support = true,
>  	.limit = &mtk_dpi_limit,
>  };
>  
> @@ -829,6 +835,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
>  	.output_fmts = mt8183_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
>  	.is_ck_de_pol = true,
> +	.swap_input_support = true,
>  	.limit = &mtk_dpi_limit,
>  };
>  
> @@ -839,6 +846,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
>  	.is_ck_de_pol = true,
> +	.swap_input_support = true,
>  	.limit = &mtk_dpi_limit,
>  };
>  

