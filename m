Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2A4E9039
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbiC1IfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbiC1IfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:35:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD11BE8D;
        Mon, 28 Mar 2022 01:33:36 -0700 (PDT)
X-UUID: 515039d302a24b61a4a1d3226784934f-20220328
X-UUID: 515039d302a24b61a4a1d3226784934f-20220328
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 983933162; Mon, 28 Mar 2022 16:33:30 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Mar 2022 16:33:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Mar
 2022 16:33:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Mar 2022 16:33:29 +0800
Message-ID: <345fd758319f318738fe55d298bd5056320a130e.camel@mediatek.com>
Subject: Re: [PATCH v9 09/22] drm/mediatek: dpi: implement a swap_input
 toggle in SoC config
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Guillaume Ranquet <granquet@baylibre.com>, <airlied@linux.ie>,
        <angelogioacchino.delregno@collabora.com>,
        <chunfeng.yun@mediatek.com>, <chunkuang.hu@kernel.org>,
        <ck.hu@mediatek.com>, <daniel@ffwll.ch>, <deller@gmx.de>,
        <jitao.shi@mediatek.com>, <kishon@ti.com>, <krzk+dt@kernel.org>,
        <maarten.lankhorst@linux.intel.com>, <matthias.bgg@gmail.com>,
        <mripard@kernel.org>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <tzimmermann@suse.de>, <vkoul@kernel.org>
CC:     <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <markyacoub@google.com>
Date:   Mon, 28 Mar 2022 16:33:29 +0800
In-Reply-To: <20220327223927.20848-10-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
         <20220327223927.20848-10-granquet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-28 at 00:39 +0200, Guillaume Ranquet wrote:
> Adds a bit of flexibility to support SoCs without swap_input support
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
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

Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

