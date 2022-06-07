Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0443E53F426
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiFGCyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiFGCyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:54:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B71A6A026;
        Mon,  6 Jun 2022 19:54:35 -0700 (PDT)
X-UUID: 3955505818d04c8b9969c59d09c432d2-20220607
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:96f292b6-9e19-4a32-9245-f3bdc58d0a67,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:96f292b6-9e19-4a32-9245-f3bdc58d0a67,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:ea47677e-c8dc-403a-96e8-6237210dceee,C
        OID:FAIL,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,Fil
        e:nil,QS:0,BEC:nil
X-UUID: 3955505818d04c8b9969c59d09c432d2-20220607
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 472154471; Tue, 07 Jun 2022 10:54:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 7 Jun 2022 10:54:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 7 Jun 2022 10:54:27 +0800
Message-ID: <6dcb95f2f91d91fc8fd87a86ba988eee0168df19.camel@mediatek.com>
Subject: Re: [PATCH v10 07/21] drm/mediatek: dpi: implement a CK/DE pol
 toggle in SoC config
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-fbdev@vger.kernel.org>
Date:   Tue, 7 Jun 2022 10:54:27 +0800
In-Reply-To: <356624f3283f9203007ab21bedf15744d86e16f8.camel@mediatek.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
         <20220523104758.29531-8-granquet@baylibre.com>
         <356624f3283f9203007ab21bedf15744d86e16f8.camel@mediatek.com>
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

On Mon, 2022-05-30 at 15:44 +0800, CK Hu wrote:
> Hi, Guillaume:
> 
> On Mon, 2022-05-23 at 12:47 +0200, Guillaume Ranquet wrote:
> > Adds a bit of flexibility to support SoCs without CK/DE pol support
> 
> It seems that DP_INTF has no CK/DE pol function. If so, could you
> explain why DP_INTF has this difference with DPI?
> 
> Regards,
> CK
> 

Hello CK,

Dp_intf does not support CK/DE polarity because the polarity
information is not used for eDP and DP while dp_intf is only for eDP
and DP.

I will add this in commit message in next version.

BRs,
Bo-Chen

> > 
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index 4746eb342567..545a1337cc89 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -125,6 +125,7 @@ struct mtk_dpi_conf {
> >  	bool edge_sel_en;
> >  	const u32 *output_fmts;
> >  	u32 num_output_fmts;
> > +	bool is_ck_de_pol;
> >  	const struct mtk_dpi_yc_limit *limit;
> >  };
> >  
> > @@ -211,13 +212,20 @@ static void mtk_dpi_config_pol(struct mtk_dpi
> > *dpi,
> >  			       struct mtk_dpi_polarities *dpi_pol)
> >  {
> >  	unsigned int pol;
> > +	unsigned int mask;
> >  
> > -	pol = (dpi_pol->ck_pol == MTK_DPI_POLARITY_RISING ? 0 : CK_POL)
> > > 
> > 
> > -	      (dpi_pol->de_pol == MTK_DPI_POLARITY_RISING ? 0 : DE_POL)
> > > 
> > 
> > -	      (dpi_pol->hsync_pol == MTK_DPI_POLARITY_RISING ? 0 :
> > HSYNC_POL) |
> > +	mask = HSYNC_POL | VSYNC_POL;
> > +	pol = (dpi_pol->hsync_pol == MTK_DPI_POLARITY_RISING ? 0 :
> > HSYNC_POL) |
> >  	      (dpi_pol->vsync_pol == MTK_DPI_POLARITY_RISING ? 0 :
> > VSYNC_POL);
> > -	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, pol,
> > -		     CK_POL | DE_POL | HSYNC_POL | VSYNC_POL);
> > +	if (dpi->conf->is_ck_de_pol) {
> > +		mask |= CK_POL | DE_POL;
> > +		pol |= (dpi_pol->ck_pol == MTK_DPI_POLARITY_RISING ?
> > +			0 : CK_POL) |
> > +		       (dpi_pol->de_pol == MTK_DPI_POLARITY_RISING ?
> > +			0 : DE_POL);
> > +	}
> > +
> > +	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, pol, mask);
> >  }
> >  
> >  static void mtk_dpi_config_3d(struct mtk_dpi *dpi, bool en_3d)
> > @@ -799,6 +807,7 @@ static const struct mtk_dpi_conf mt8173_conf =
> > {
> >  	.max_clock_khz = 300000,
> >  	.output_fmts = mt8173_output_fmts,
> >  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> > +	.is_ck_de_pol = true,
> >  	.limit = &mtk_dpi_limit,
> >  };
> >  
> > @@ -809,6 +818,7 @@ static const struct mtk_dpi_conf mt2701_conf =
> > {
> >  	.max_clock_khz = 150000,
> >  	.output_fmts = mt8173_output_fmts,
> >  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> > +	.is_ck_de_pol = true,
> >  	.limit = &mtk_dpi_limit,
> >  };
> >  
> > @@ -818,6 +828,7 @@ static const struct mtk_dpi_conf mt8183_conf =
> > {
> >  	.max_clock_khz = 100000,
> >  	.output_fmts = mt8183_output_fmts,
> >  	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
> > +	.is_ck_de_pol = true,
> >  	.limit = &mtk_dpi_limit,
> >  };
> >  
> > @@ -827,6 +838,7 @@ static const struct mtk_dpi_conf mt8192_conf =
> > {
> >  	.max_clock_khz = 150000,
> >  	.output_fmts = mt8173_output_fmts,
> >  	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> > +	.is_ck_de_pol = true,
> >  	.limit = &mtk_dpi_limit,
> >  };
> >  
> 
> 

