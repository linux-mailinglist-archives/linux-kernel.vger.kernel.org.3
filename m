Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961A4552A06
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345071AbiFUDpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiFUDpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:45:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05932608;
        Mon, 20 Jun 2022 20:45:36 -0700 (PDT)
X-UUID: b7fdfcf5c7a748fd8a1dfadf081090fc-20220621
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:5dff3486-10ec-4403-8b42-44ec0fc02bb6,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:5dff3486-10ec-4403-8b42-44ec0fc02bb6,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:d64e992d-1756-4fa3-be7f-474a6e4be921,C
        OID:74302c5e0f4a,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: b7fdfcf5c7a748fd8a1dfadf081090fc-20220621
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1599764465; Tue, 21 Jun 2022 11:45:30 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 21 Jun 2022 11:45:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 21 Jun 2022 11:45:29 +0800
Message-ID: <6af179e2995ce2f4f2e7c72f10516afb0c1604a3.camel@mediatek.com>
Subject: Re: [PATCH v12 11/14] drm/mediatek: dpi: Add tvd_clk enable/disable
 flow
From:   CK Hu <ck.hu@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
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
Date:   Tue, 21 Jun 2022 11:45:29 +0800
In-Reply-To: <7bffe5226a80474f150ef67e36d2b75ea8e8a9d8.camel@mediatek.com>
References: <20220620121028.29234-1-rex-bc.chen@mediatek.com>
         <20220620121028.29234-12-rex-bc.chen@mediatek.com>
         <218de671054a2c02d47a0bb4a31a0b07d24d7eee.camel@mediatek.com>
         <7bffe5226a80474f150ef67e36d2b75ea8e8a9d8.camel@mediatek.com>
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

On Tue, 2022-06-21 at 11:11 +0800, Rex-BC Chen wrote:
> On Tue, 2022-06-21 at 10:55 +0800, CK Hu wrote:
> > Hi, Bo-Chen:
> > 
> > On Mon, 2022-06-20 at 20:10 +0800, Bo-Chen Chen wrote:
> > > We should enable/disable tvd_clk when power_on/power_off, so add
> > > this
> > > patch to do this.
> > 
> > Without this patch, what would happen?
> > It seems this patch is redundant for these SoCs:
> > 
> > static const struct of_device_id mtk_dpi_of_ids[] = {
> > 	{ .compatible = "mediatek,mt2701-dpi",
> > 	  .data = &mt2701_conf,
> > 	},
> > 	{ .compatible = "mediatek,mt8173-dpi",
> > 	  .data = &mt8173_conf,
> > 	},
> > 	{ .compatible = "mediatek,mt8183-dpi",
> > 	  .data = &mt8183_conf,
> > 	},
> > 	{ .compatible = "mediatek,mt8192-dpi",
> > 	  .data = &mt8192_conf,
> > 	},
> > 	{ },
> > };
> > 
> > Regards,
> > CK
> > 
> 
> Hello CK,
> 
> IMO, this is a bug fix patch. From the usage of clock, if we want to
> use it, we should enable it . Therefore, I think we should add this
> and
> I will add a fix tag for this patch.

I think mt8173 chromebook use this driver for HDMI output. So mt8173
chromebook HDMI could not work normally?

Regards,
CK

> 
> BRs,
> Bo-Chen
> > 
> > > 
> > > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dpi.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > index 2717b1741b7a..f83ecb154457 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > @@ -455,6 +455,7 @@ static void mtk_dpi_power_off(struct mtk_dpi
> > > *dpi)
> > >  	mtk_dpi_disable(dpi);
> > >  	clk_disable_unprepare(dpi->pixel_clk);
> > >  	clk_disable_unprepare(dpi->engine_clk);
> > > +	clk_disable_unprepare(dpi->tvd_clk);
> > >  }
> > >  
> > >  static int mtk_dpi_power_on(struct mtk_dpi *dpi)
> > > @@ -464,10 +465,16 @@ static int mtk_dpi_power_on(struct mtk_dpi
> > > *dpi)
> > >  	if (++dpi->refcount != 1)
> > >  		return 0;
> > >  
> > > +	ret = clk_prepare_enable(dpi->tvd_clk);
> > > +	if (ret) {
> > > +		dev_err(dpi->dev, "Failed to enable tvd pll: %d\n",
> > > ret);
> > > +		goto err_refcount;
> > > +	}
> > > +
> > >  	ret = clk_prepare_enable(dpi->engine_clk);
> > >  	if (ret) {
> > >  		dev_err(dpi->dev, "Failed to enable engine clock:
> > > %d\n", ret);
> > > -		goto err_refcount;
> > > +		goto err_engine;
> > >  	}
> > >  
> > >  	ret = clk_prepare_enable(dpi->pixel_clk);
> > > @@ -484,6 +491,8 @@ static int mtk_dpi_power_on(struct mtk_dpi
> > > *dpi)
> > >  
> > >  err_pixel:
> > >  	clk_disable_unprepare(dpi->engine_clk);
> > > +err_engine:
> > > +	clk_disable_unprepare(dpi->tvd_clk);
> > >  err_refcount:
> > >  	dpi->refcount--;
> > >  	return ret;
> > 
> > 
> 
> 

