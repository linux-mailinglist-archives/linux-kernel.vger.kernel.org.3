Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F444E8F02
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbiC1HdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiC1HdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:33:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F7751E4B;
        Mon, 28 Mar 2022 00:31:33 -0700 (PDT)
X-UUID: 10bfd5f56ccd47739d9962a536d27e70-20220328
X-UUID: 10bfd5f56ccd47739d9962a536d27e70-20220328
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 860874880; Mon, 28 Mar 2022 15:31:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 28 Mar 2022 15:31:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Mar 2022 15:31:28 +0800
Message-ID: <8c7d47869dc8a9e8580740fe25bb2fd289253a4d.camel@mediatek.com>
Subject: Re: [PATCH v9 08/22] drm/mediatek: dpi: implement a CK/DE pol
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
Date:   Mon, 28 Mar 2022 15:31:28 +0800
In-Reply-To: <20220327223927.20848-9-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
         <20220327223927.20848-9-granquet@baylibre.com>
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
> Adds a bit of flexibility to support SoCs without CK/DE pol support
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 4746eb342567..545a1337cc89 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -125,6 +125,7 @@ struct mtk_dpi_conf {
>  	bool edge_sel_en;
>  	const u32 *output_fmts;
>  	u32 num_output_fmts;
> +	bool is_ck_de_pol;
>  	const struct mtk_dpi_yc_limit *limit;
>  };
>  
> @@ -211,13 +212,20 @@ static void mtk_dpi_config_pol(struct mtk_dpi
> *dpi,
>  			       struct mtk_dpi_polarities *dpi_pol)
>  {
>  	unsigned int pol;
> +	unsigned int mask;
>  
> -	pol = (dpi_pol->ck_pol == MTK_DPI_POLARITY_RISING ? 0 : CK_POL)
> |
> -	      (dpi_pol->de_pol == MTK_DPI_POLARITY_RISING ? 0 : DE_POL)
> |
> -	      (dpi_pol->hsync_pol == MTK_DPI_POLARITY_RISING ? 0 :
> HSYNC_POL) |
> +	mask = HSYNC_POL | VSYNC_POL;
> +	pol = (dpi_pol->hsync_pol == MTK_DPI_POLARITY_RISING ? 0 :
> HSYNC_POL) |
>  	      (dpi_pol->vsync_pol == MTK_DPI_POLARITY_RISING ? 0 :
> VSYNC_POL);
> -	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, pol,
> -		     CK_POL | DE_POL | HSYNC_POL | VSYNC_POL);
> +	if (dpi->conf->is_ck_de_pol) {
> +		mask |= CK_POL | DE_POL;
> +		pol |= (dpi_pol->ck_pol == MTK_DPI_POLARITY_RISING ?
> +			0 : CK_POL) |
> +		       (dpi_pol->de_pol == MTK_DPI_POLARITY_RISING ?
> +			0 : DE_POL);
> +	}
> +
> +	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, pol, mask);
>  }
>  
>  static void mtk_dpi_config_3d(struct mtk_dpi *dpi, bool en_3d)
> @@ -799,6 +807,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
>  	.max_clock_khz = 300000,
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> +	.is_ck_de_pol = true,
>  	.limit = &mtk_dpi_limit,
>  };
>  
> @@ -809,6 +818,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
>  	.max_clock_khz = 150000,
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> +	.is_ck_de_pol = true,
>  	.limit = &mtk_dpi_limit,
>  };
>  
> @@ -818,6 +828,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
>  	.max_clock_khz = 100000,
>  	.output_fmts = mt8183_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
> +	.is_ck_de_pol = true,
>  	.limit = &mtk_dpi_limit,
>  };
>  
> @@ -827,6 +838,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
>  	.max_clock_khz = 150000,
>  	.output_fmts = mt8173_output_fmts,
>  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> +	.is_ck_de_pol = true,
>  	.limit = &mtk_dpi_limit,
>  };
>  

Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

