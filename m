Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC3E54DF35
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiFPKgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiFPKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:36:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185375DA02;
        Thu, 16 Jun 2022 03:36:44 -0700 (PDT)
X-UUID: f64867246d454b2ea8a3edf5c0c17e71-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:b5e36c6b-1f88-4956-9cce-bdbd5923cc85,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:0f47bf48-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: f64867246d454b2ea8a3edf5c0c17e71-20220616
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1702781592; Thu, 16 Jun 2022 18:36:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 16 Jun 2022 18:36:37 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 16 Jun 2022 18:36:37 +0800
Message-ID: <2200b1296a527340d1fa556e0f8ed929cff01c9c.camel@mediatek.com>
Subject: Re: [PATCH v11 04/12] drm/mediatek: dpi: implement a swap_input
 toggle in SoC config
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, <chunkuang.hu@kernel.org>,
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
Date:   Thu, 16 Jun 2022 18:36:36 +0800
In-Reply-To: <e431cca23add678bb39dbc75d783d239914d256a.camel@mediatek.com>
References: <20220613064841.10481-1-rex-bc.chen@mediatek.com>
         <20220613064841.10481-5-rex-bc.chen@mediatek.com>
         <e431cca23add678bb39dbc75d783d239914d256a.camel@mediatek.com>
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

On Tue, 2022-06-14 at 13:27 +0800, CK Hu wrote:
> Hi, Bo-Chen:
> 
> On Mon, 2022-06-13 at 14:48 +0800, Bo-Chen Chen wrote:
> > From: Guillaume Ranquet <granquet@baylibre.com>
> > 
> > The hardware design of dp_intf does not support input swap, so we
> > add
> > a bit of flexibility to support SoCs without swap_input support.
> > 
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > [Bo-Chen: Add modification reason in commit message.]
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index 15218c1e8c11..c1438c744120 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -126,6 +126,7 @@ struct mtk_dpi_conf {
> >  	const u32 *output_fmts;
> >  	u32 num_output_fmts;
> >  	bool is_ck_de_pol;
> > +	bool swap_input_support;
> >  	const struct mtk_dpi_yc_limit *limit;
> >  };
> >  
> > @@ -378,18 +379,21 @@ static void
> > mtk_dpi_config_color_format(struct
> > mtk_dpi *dpi,
> >  	    (format == MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
> >  		mtk_dpi_config_yuv422_enable(dpi, false);
> >  		mtk_dpi_config_csc_enable(dpi, true);
> > -		mtk_dpi_config_swap_input(dpi, false);
> > +		if (dpi->conf->swap_input_support)
> > +			mtk_dpi_config_swap_input(dpi, false);
> >  		mtk_dpi_config_channel_swap(dpi,
> > MTK_DPI_OUT_CHANNEL_SWAP_BGR);
> >  	} else if ((format == MTK_DPI_COLOR_FORMAT_YCBCR_422) ||
> >  		   (format == MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL)) {
> >  		mtk_dpi_config_yuv422_enable(dpi, true);
> >  		mtk_dpi_config_csc_enable(dpi, true);
> > -		mtk_dpi_config_swap_input(dpi, true);
> > +		if (dpi->conf->swap_input_support)
> > +			mtk_dpi_config_swap_input(dpi, true);
> 
> In this case, we need swap input, but hardware does not support, so
> just skip config hardware and everything works fine? Should print any
> error message?
> 
> Regards,
> CK
> 

ok, I will add warning message for this.

> >  		mtk_dpi_config_channel_swap(dpi,
> > MTK_DPI_OUT_CHANNEL_SWAP_RGB);
> >  	} else {
> >  		mtk_dpi_config_yuv422_enable(dpi, false);
> >  		mtk_dpi_config_csc_enable(dpi, false);
> > -		mtk_dpi_config_swap_input(dpi, false);
> > +		if (dpi->conf->swap_input_support)
> > +			mtk_dpi_config_swap_input(dpi, false);
> >  		mtk_dpi_config_channel_swap(dpi,
> > MTK_DPI_OUT_CHANNEL_SWAP_RGB);
> >  	}
> >  }
> > @@ -808,6 +812,7 @@ static const struct mtk_dpi_conf mt8173_conf =
> > {
> >  	.output_fmts = mt8173_output_fmts,
> >  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> >  	.is_ck_de_pol = true,
> > +	.swap_input_support = true,
> >  	.limit = &mtk_dpi_limit,
> >  };
> >  
> > @@ -819,6 +824,7 @@ static const struct mtk_dpi_conf mt2701_conf =
> > {
> >  	.output_fmts = mt8173_output_fmts,
> >  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> >  	.is_ck_de_pol = true,
> > +	.swap_input_support = true,
> >  	.limit = &mtk_dpi_limit,
> >  };
> >  
> > @@ -829,6 +835,7 @@ static const struct mtk_dpi_conf mt8183_conf =
> > {
> >  	.output_fmts = mt8183_output_fmts,
> >  	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
> >  	.is_ck_de_pol = true,
> > +	.swap_input_support = true,
> >  	.limit = &mtk_dpi_limit,
> >  };
> >  
> > @@ -839,6 +846,7 @@ static const struct mtk_dpi_conf mt8192_conf =
> > {
> >  	.output_fmts = mt8183_output_fmts,
> >  	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
> >  	.is_ck_de_pol = true,
> > +	.swap_input_support = true,
> >  	.limit = &mtk_dpi_limit,
> >  };
> >  
> 
> 

