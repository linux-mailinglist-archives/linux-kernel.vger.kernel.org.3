Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC254E8ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbiC1HUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiC1HUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:20:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380CF17062;
        Mon, 28 Mar 2022 00:18:55 -0700 (PDT)
X-UUID: c10b793ef49a4ab4b043d96b3d782ea3-20220328
X-UUID: c10b793ef49a4ab4b043d96b3d782ea3-20220328
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1811055432; Mon, 28 Mar 2022 15:18:49 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 28 Mar 2022 15:18:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Mar 2022 15:18:47 +0800
Message-ID: <39a65a1d6b507803885cfe7edcdf364732b59cfa.camel@mediatek.com>
Subject: Re: [PATCH v9 07/22] drm/mediatek: dpi: move dpi limits to SoC
 config
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
Date:   Mon, 28 Mar 2022 15:18:44 +0800
In-Reply-To: <20220327223927.20848-8-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
         <20220327223927.20848-8-granquet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-28 at 00:39 +0200, Guillaume Ranquet wrote:
> Add flexibility by moving the dpi limits to the SoC specific config
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 4554e2de1430..4746eb342567 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -125,6 +125,7 @@ struct mtk_dpi_conf {
>  	bool edge_sel_en;
>  	const u32 *output_fmts;
>  	u32 num_output_fmts;
> +	const struct mtk_dpi_yc_limit *limit;
>  };
>  
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val,
> u32 mask)
> @@ -235,9 +236,10 @@ static void mtk_dpi_config_fb_size(struct
> mtk_dpi *dpi, u32 width, u32 height)
>  	mtk_dpi_mask(dpi, DPI_SIZE, height << VSIZE, VSIZE_MASK);
>  }
>  
> -static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi,
> -					 struct mtk_dpi_yc_limit
> *limit)
> +static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi)
>  {
> +	const struct mtk_dpi_yc_limit *limit = dpi->conf->limit;
> +
>  	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_bottom << Y_LIMINT_BOT,
>  		     Y_LIMINT_BOT_MASK);
>  	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_top << Y_LIMINT_TOP,
> @@ -449,7 +451,6 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>  static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  				    struct drm_display_mode *mode)
>  {
> -	struct mtk_dpi_yc_limit limit;
>  	struct mtk_dpi_polarities dpi_pol;
>  	struct mtk_dpi_sync_param hsync;
>  	struct mtk_dpi_sync_param vsync_lodd = { 0 };
> @@ -484,11 +485,6 @@ static int mtk_dpi_set_display_mode(struct
> mtk_dpi *dpi,
>  	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
>  		pll_rate, vm.pixelclock);
>  
> -	limit.c_bottom = 0x0010;
> -	limit.c_top = 0x0FE0;
> -	limit.y_bottom = 0x0010;
> -	limit.y_top = 0x0FE0;
> -
>  	dpi_pol.ck_pol = MTK_DPI_POLARITY_FALLING;
>  	dpi_pol.de_pol = MTK_DPI_POLARITY_RISING;
>  	dpi_pol.hsync_pol = vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ?
> @@ -536,7 +532,7 @@ static int mtk_dpi_set_display_mode(struct
> mtk_dpi *dpi,
>  	else
>  		mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive);
>  
> -	mtk_dpi_config_channel_limit(dpi, &limit);
> +	mtk_dpi_config_channel_limit(dpi);
>  	mtk_dpi_config_bit_num(dpi, dpi->bit_num);
>  	mtk_dpi_config_channel_swap(dpi, dpi->channel_swap);
>  	mtk_dpi_config_yc_map(dpi, dpi->yc_map);
> @@ -790,12 +786,20 @@ static const u32 mt8183_output_fmts[] = {
>  	MEDIA_BUS_FMT_RGB888_2X12_BE,
>  };
>  
> +static const struct mtk_dpi_yc_limit mtk_dpi_limit = {
> +	.c_bottom = 0x0010,
> +	.c_top = 0x0FE0,
> +	.y_bottom = 0x0010,
> +	.y_top = 0x0FE0,
> +};
> +
>  static const struct mtk_dpi_conf mt8173_conf = {
>  	.cal_factor = mt8173_calculate_factor,
>  	.reg_h_fre_con = 0xe0,
>  	.max_clock_khz = 300000,
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> +	.limit = &mtk_dpi_limit,
>  };
>  
>  static const struct mtk_dpi_conf mt2701_conf = {
> @@ -805,6 +809,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
>  	.max_clock_khz = 150000,
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> +	.limit = &mtk_dpi_limit,
>  };
>  
>  static const struct mtk_dpi_conf mt8183_conf = {
> @@ -813,6 +818,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
>  	.max_clock_khz = 100000,
>  	.output_fmts = mt8183_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
> +	.limit = &mtk_dpi_limit,
>  };
>  
>  static const struct mtk_dpi_conf mt8192_conf = {
> @@ -821,6 +827,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
>  	.max_clock_khz = 150000,
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> +	.limit = &mtk_dpi_limit,
>  };
>  
>  static int mtk_dpi_probe(struct platform_device *pdev)

Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

