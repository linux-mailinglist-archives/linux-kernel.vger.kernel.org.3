Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624EF5662BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiGEFV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGEFVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:21:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE8E12AB4;
        Mon,  4 Jul 2022 22:21:46 -0700 (PDT)
X-UUID: d2c154f60eb3485ab9d19aba9192deaf-20220705
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:81eeccbe-f5f7-4182-b7e0-4cd59783f893,OB:0,LO
        B:30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:81eeccbe-f5f7-4182-b7e0-4cd59783f893,OB:0,LOB:
        30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:413e6d63-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:798126cbb48b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: d2c154f60eb3485ab9d19aba9192deaf-20220705
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1562281353; Tue, 05 Jul 2022 13:21:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 5 Jul 2022 13:21:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jul 2022 13:21:39 +0800
Message-ID: <f834d5612bef6fa216602b3dcbed629f1b4c903b.camel@mediatek.com>
Subject: Re: [PATCH v15 13/16] drm/mediatek: dpi: Add YUV422 output support
From:   CK Hu <ck.hu@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <xinlei.lee@mediatek.com>, <liangxu.xu@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 5 Jul 2022 13:21:39 +0800
In-Reply-To: <20220701035845.16458-14-rex-bc.chen@mediatek.com>
References: <20220701035845.16458-1-rex-bc.chen@mediatek.com>
         <20220701035845.16458-14-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo-Chen:

On Fri, 2022-07-01 at 11:58 +0800, Bo-Chen Chen wrote:
> Dp_intf supports YUV422 as output format. In MT8195 Chrome project,
> YUV422 output format is used for 4K resolution.
> 
> To support this, it is also needed to support color format transfer.
> Color format transfer is a new feature for both dpi and dpintf of
> MT8195.
> 
> The input format could be RGB888 and output format for dp_intf should
> be
> YUV422. Therefore, we add a mtk_dpi_matrix_sel() helper to update the
> DPI_MATRIX_SET register depending on the color format.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c      | 61 +++++++++++++++++++++
> ----
>  drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  6 +++
>  2 files changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 3085033becbd..0a604bf68b1b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -54,7 +54,8 @@ enum mtk_dpi_out_channel_swap {
>  };
>  
>  enum mtk_dpi_out_color_format {
> -	MTK_DPI_COLOR_FORMAT_RGB
> +	MTK_DPI_COLOR_FORMAT_RGB,
> +	MTK_DPI_COLOR_FORMAT_YCBCR_422
>  };
>  
>  struct mtk_dpi {
> @@ -122,6 +123,7 @@ struct mtk_dpi_yc_limit {
>   * @num_output_fmts: Quantity of supported output formats.
>   * @is_ck_de_pol: Support CK/DE polarity.
>   * @swap_input_support: Support input swap function.
> + * @color_fmt_trans_support: Enable color format transfer.
>   * @dimension_mask: Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and
> VSYNC_PORCH
>   *		    (no shift).
>   * @hvsize_mask: Mask of HSIZE and VSIZE mask (no shift).
> @@ -138,6 +140,7 @@ struct mtk_dpi_conf {
>  	u32 num_output_fmts;
>  	bool is_ck_de_pol;
>  	bool swap_input_support;
> +	bool color_fmt_trans_support;
>  	u32 dimension_mask;
>  	u32 hvsize_mask;
>  	u32 channel_swap_shift;
> @@ -406,15 +409,54 @@ static void mtk_dpi_config_disable_edge(struct
> mtk_dpi *dpi)
>  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0,
> EDGE_SEL_EN);
>  }
>  
> +static void mtk_dpi_matrix_sel(struct mtk_dpi *dpi,
> +			       enum mtk_dpi_out_color_format format)

The format would only be MTK_DPI_COLOR_FORMAT_YCBCR_422, so drop the
parameter format.

> +{
> +	u32 matrix_sel;
> +
> +	if (!dpi->conf->color_fmt_trans_support) {

Only YUV format would call this function, and I think YUV support would
imply that color_fmt_trans_support is true. So drop
color_fmt_trans_support.

> +		dev_info(dpi->dev, "matrix_sel is not supported.\n");
> +		return;
> +	}
> +
> +	switch (format) {
> +	case MTK_DPI_COLOR_FORMAT_YCBCR_422:
> +		/*
> +		 * If height is smaller than 720, we need to use
> RGB_TO_BT601
> +		 * to transfer to yuv422. Otherwise, we use
> RGB_TO_JPEG.
> +		 */
> +		if (dpi->mode.hdisplay <= 720)
> +			matrix_sel = MATRIX_SEL_RGB_TO_BT601;
> +		else
> +			matrix_sel = MATRIX_SEL_RGB_TO_JPEG;
> +		break;
> +	default:
> +		matrix_sel = MATRIX_SEL_RGB_TO_JPEG;
> +		break;
> +	}
> +	mtk_dpi_mask(dpi, DPI_MATRIX_SET, matrix_sel,
> INT_MATRIX_SEL_MASK);

it seems that we could drop this function and write register as:

mtk_dpi_mask(dpi, DPI_MATRIX_SET, dpi->mode.hdisplay <= 720
? MATRIX_SEL_RGB_TO_BT601 : MATRIX_SEL_RGB_TO_JPEG,
INT_MATRIX_SEL_MASK);

> +}
> +
>  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>  					enum mtk_dpi_out_color_format
> format)
>  {
> -	/* only support RGB888 */
> -	mtk_dpi_config_yuv422_enable(dpi, false);
> -	mtk_dpi_config_csc_enable(dpi, false);
> -	if (dpi->conf->swap_input_support)
> -		mtk_dpi_config_swap_input(dpi, false);
> -	mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_RGB);
> +	if (format == MTK_DPI_COLOR_FORMAT_YCBCR_422) {
> +		mtk_dpi_config_yuv422_enable(dpi, true);
> +		mtk_dpi_config_csc_enable(dpi, true);
> +		mtk_dpi_matrix_sel(dpi, format);
> +		if (dpi->conf->swap_input_support)

This would never be true because only MT8195 support
MTK_DPI_COLOR_FORMAT_YCBCR_422 and swap_input_support of MT8195 is
false.

Regards,
CK

> +			mtk_dpi_config_swap_input(dpi, true);
> +		else
> +			dev_warn(dpi->dev,
> +				 "Failed to swap input, hw is not
> supported.\n");
> +		mtk_dpi_config_channel_swap(dpi,
> MTK_DPI_OUT_CHANNEL_SWAP_RGB);
> +	} else {
> +		mtk_dpi_config_yuv422_enable(dpi, false);
> +		mtk_dpi_config_csc_enable(dpi, false);
> +		if (dpi->conf->swap_input_support)
> +			mtk_dpi_config_swap_input(dpi, false);
> +		mtk_dpi_config_channel_swap(dpi,
> MTK_DPI_OUT_CHANNEL_SWAP_RGB);
> +	}
>  }
>  
>  static void mtk_dpi_dual_edge(struct mtk_dpi *dpi)
> @@ -649,7 +691,10 @@ static int mtk_dpi_bridge_atomic_check(struct
> drm_bridge *bridge,
>  	dpi->bit_num = MTK_DPI_OUT_BIT_NUM_8BITS;
>  	dpi->channel_swap = MTK_DPI_OUT_CHANNEL_SWAP_RGB;
>  	dpi->yc_map = MTK_DPI_OUT_YC_MAP_RGB;
> -	dpi->color_format = MTK_DPI_COLOR_FORMAT_RGB;
> +	if (out_bus_format == MEDIA_BUS_FMT_YUYV8_1X16)
> +		dpi->color_format = MTK_DPI_COLOR_FORMAT_YCBCR_422;
> +	else
> +		dpi->color_format = MTK_DPI_COLOR_FORMAT_RGB;
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> index 3a02fabe1662..9ce300313f3e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> @@ -217,4 +217,10 @@
>  
>  #define EDGE_SEL_EN			BIT(5)
>  #define H_FRE_2N			BIT(25)
> +
> +#define DPI_MATRIX_SET		0xB4
> +#define INT_MATRIX_SEL_MASK		GENMASK(4, 0)
> +#define MATRIX_SEL_RGB_TO_JPEG		0
> +#define MATRIX_SEL_RGB_TO_BT601		2
> +
>  #endif /* __MTK_DPI_REGS_H */

