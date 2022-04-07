Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75D4F7604
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbiDGG3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbiDGG3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:29:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F0C1F6BF6;
        Wed,  6 Apr 2022 23:27:23 -0700 (PDT)
X-UUID: 93121cf8a2c048c1a70853a77a6974a5-20220407
X-UUID: 93121cf8a2c048c1a70853a77a6974a5-20220407
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 801607603; Thu, 07 Apr 2022 14:27:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 7 Apr 2022 14:27:14 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 14:27:14 +0800
Message-ID: <d8711b8e4d233240eda73db54a625e88b9b3970b.camel@mediatek.com>
Subject: Re: [RESEND v17 3/7] soc: mediatek: add mtk-mmsys support for
 mt8195 vdosys0
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     David Airlie <airlied@linux.ie>, <singo.chang@mediatek.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        <postmaster@vger.kernel.org>,
        "Fabien Parent" <fparent@baylibre.com>,
        John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <roy-cw.yeh@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        <nancy.lin@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <hsinyi@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <moudy.ho@mediatek.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Date:   Thu, 7 Apr 2022 14:27:14 +0800
In-Reply-To: <67b3e42d6a094108f724ed9b8c73f5cd6b2ce219.camel@mediatek.com>
References: <20220407030409.9664-1-jason-jh.lin@mediatek.com>
         <20220407030409.9664-4-jason-jh.lin@mediatek.com>
         <67b3e42d6a094108f724ed9b8c73f5cd6b2ce219.camel@mediatek.com>
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

Hi CK,

Thanks for the reviews.

On Thu, 2022-04-07 at 13:45 +0800, CK Hu wrote:
> Hi, Jason:
> 
> On Thu, 2022-04-07 at 11:04 +0800, jason-jh.lin wrote:
> > 1. Add mt8195 mmsys compatible for vdosys0.
> > 2. Add mt8195 routing table settings and fix build fail.
> > 3. Add clock name, clock driver name and routing table into the
> > driver data
> >    of mt8195 vdosys0.
> > 4. Add get match data by clock name function and clock platform
> > labels
> >    to identify which mmsys node is corresponding to vdosys0.
> > 
> > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   2 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   6 +-
> >  drivers/soc/mediatek/mt8167-mmsys.h         |   2 +-
> >  drivers/soc/mediatek/mt8183-mmsys.h         |   2 +-
> >  drivers/soc/mediatek/mt8186-mmsys.h         |   4 +-
> >  drivers/soc/mediatek/mt8192-mmsys.h         |   4 +-
> >  drivers/soc/mediatek/mt8195-mmsys.h         | 370
> > ++++++++++++++++++++
> >  drivers/soc/mediatek/mt8365-mmsys.h         |   4 +-
> >  drivers/soc/mediatek/mtk-mmsys.c            |  62 ++++
> >  drivers/soc/mediatek/mtk-mmsys.h            |   1 +
> >  drivers/soc/mediatek/mtk-mutex.c            |   8 +-
> >  include/linux/soc/mediatek/mtk-mmsys.h      |  13 +-
> >  12 files changed, 461 insertions(+), 17 deletions(-)
> >  create mode 100644 drivers/soc/mediatek/mt8195-mmsys.h
> > 
> 
> [snip]
> 
> > diff --git a/drivers/soc/mediatek/mtk-mmsys.c
> > b/drivers/soc/mediatek/mtk-mmsys.c
> > index 4fc4c2c9ea20..b2fa239c5f5f 100644
> > --- a/drivers/soc/mediatek/mtk-mmsys.c
> > +++ b/drivers/soc/mediatek/mtk-mmsys.c
> > @@ -4,6 +4,8 @@
> >   * Author: James Liao <jamesjj.liao@mediatek.com>
> >   */
> >  
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> > @@ -17,6 +19,7 @@
> >  #include "mt8183-mmsys.h"
> >  #include "mt8186-mmsys.h"
> >  #include "mt8192-mmsys.h"
> > +#include "mt8195-mmsys.h"
> >  #include "mt8365-mmsys.h"
> >  
> >  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data
> > =
> > {
> > @@ -72,12 +75,24 @@ static const struct mtk_mmsys_driver_data
> > mt8192_mmsys_driver_data = {
> >  	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
> >  };
> >  
> > +static const struct mtk_mmsys_driver_data
> > mt8195_vdosys0_driver_data
> > = {
> > +	.clk_name = "cfg_vdo0",
> > +	.clk_driver = "clk-mt8195-vdo0",
> > +	.routes = mmsys_mt8195_routing_table,
> > +	.num_routes = ARRAY_SIZE(mmsys_mt8195_routing_table),
> > +};
> > +
> >  static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data
> > =
> > {
> >  	.clk_driver = "clk-mt8365-mm",
> >  	.routes = mt8365_mmsys_routing_table,
> >  	.num_routes = ARRAY_SIZE(mt8365_mmsys_routing_table),
> >  };
> >  
> > +static const struct of_device_id mtk_clk_platform_labels[] = {
> > +	{ .compatible = "mediatek,mt8195-mmsys",
> > +	  .data = (void *)"clk-mt8195"},
> > +};
> > +
> >  struct mtk_mmsys {
> >  	void __iomem *regs;
> >  	const struct mtk_mmsys_driver_data *data;
> > @@ -85,6 +100,45 @@ struct mtk_mmsys {
> >  	struct reset_controller_dev rcdev;
> >  };
> >  
> > +static int mtk_mmsys_get_match_data_by_clk_name(const struct
> > mtk_mmsys_driver_data **data,
> > +						struct device *dev)
> > +{
> > +	int i;
> > +	struct clk *clk;
> > +	const char *clk_name;
> > +	const struct of_device_id *of_id =
> > of_match_node(mtk_clk_platform_labels,
> > +							 dev->of_node);
> > +	const struct mtk_mmsys_driver_data *drvdata[] = {
> > +		&mt8195_vdosys0_driver_data,
> > +	};
> > +
> > +	if (!of_id || !of_id->data) {
> > +		dev_err(dev, "Can't find match clk platform labels\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	clk = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(clk)) {
> > +		dev_err(dev, "failed to get mmsys clk\n");
> > +		return PTR_ERR(clk);
> > +	}
> > +
> > +	clk_name = __clk_get_name(clk);
> > +	if (!clk_name) {
> > +		dev_err(dev, "invalid mmsys clk name\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0; i < ARRAY_SIZE(drvdata); i++)
> > +		if (strncmp(drvdata[i]->clk_name, clk_name,
> > strlen(clk_name)) == 0 &&
> > +		    strncmp(drvdata[i]->clk_driver, of_id->data,
> > strlen(of_id->data)) == 0) {
> 
> I think clk_name is enough to identify the mmsys, why do you need
> clk_driver?

I think there might be another chip that needs to get driver data by
clk_name .
So I use "clk-mt8195" in clk_driver to identify the corresponding
platform whose clk_name of mmsys is also "cfg_vod0".

> > +			*data = drvdata[i];
> > +			return 0;
> > +		}
> > +
> > +	return -EINVAL;
> > +}
> > +
> >  void mtk_mmsys_ddp_connect(struct device *dev,
> >  			   enum mtk_ddp_comp_id cur,
> >  			   enum mtk_ddp_comp_id next)
> > @@ -206,6 +260,11 @@ static int mtk_mmsys_probe(struct
> > platform_device *pdev)
> >  	}
> >  
> >  	mmsys->data = of_device_get_match_data(&pdev->dev);
> > +	if (!mmsys->data &&
> > mtk_mmsys_get_match_data_by_clk_name(&mmsys->data, dev) < 0) {
> > +		dev_err(dev, "Couldn't get match driver data\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	platform_set_drvdata(pdev, mmsys);
> >  
> >  	clks = platform_device_register_data(&pdev->dev, mmsys->data-
> > > clk_driver,
> > 
> > @@ -260,6 +319,9 @@ static const struct of_device_id
> > of_match_mtk_mmsys[] = {
> >  		.compatible = "mediatek,mt8192-mmsys",
> >  		.data = &mt8192_mmsys_driver_data,
> >  	},
> > +	{
> > +		.compatible = "mediatek,mt8195-mmsys",
> > +	},
> >  	{
> >  		.compatible = "mediatek,mt8365-mmsys",
> >  		.data = &mt8365_mmsys_driver_data,
> > 
> 
> [snip]
> 
> > b/include/linux/soc/mediatek/mtk-mmsys.h
> > index 4bba275e235a..fb719fd1281c 100644
> > --- a/include/linux/soc/mediatek/mtk-mmsys.h
> > +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> > @@ -16,14 +16,25 @@ enum mtk_ddp_comp_id {
> >  	DDP_COMPONENT_CCORR,
> >  	DDP_COMPONENT_COLOR0,
> >  	DDP_COMPONENT_COLOR1,
> > -	DDP_COMPONENT_DITHER,
> > +	DDP_COMPONENT_DITHER0,
> 
> I would like soc and drm modification to go through different tree,
> so
> this setting would not modify drm driver in this patch.
> 
> DDP_COMPONENT_DITHER0 = DDP_COMPONENT_DITHER,
> 
> Then modify drm driver after this patch.
> 
> Regards,
> CK

OK, I will use this modification at the next version.
Thanks!

Regards,
Jason-JH.Lin

> 
> > +	DDP_COMPONENT_DITHER1,
> > +	DDP_COMPONENT_DP_INTF0,
> > +	DDP_COMPONENT_DP_INTF1,
> >  	DDP_COMPONENT_DPI0,
> >  	DDP_COMPONENT_DPI1,
> > +	DDP_COMPONENT_DSC0,
> > +	DDP_COMPONENT_DSC1,
> >  	DDP_COMPONENT_DSI0,
> >  	DDP_COMPONENT_DSI1,
> >  	DDP_COMPONENT_DSI2,
> >  	DDP_COMPONENT_DSI3,
> >  	DDP_COMPONENT_GAMMA,
> > +	DDP_COMPONENT_MERGE0,
> > +	DDP_COMPONENT_MERGE1,
> > +	DDP_COMPONENT_MERGE2,
> > +	DDP_COMPONENT_MERGE3,
> > +	DDP_COMPONENT_MERGE4,
> > +	DDP_COMPONENT_MERGE5,
> >  	DDP_COMPONENT_OD0,
> >  	DDP_COMPONENT_OD1,
> >  	DDP_COMPONENT_OVL0,
> 
> 
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

