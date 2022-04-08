Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D454F8C40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiDHCpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiDHCo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:44:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73BC128651;
        Thu,  7 Apr 2022 19:42:51 -0700 (PDT)
X-UUID: 1668b79055aa48aeacf2f9a4eb05547a-20220408
X-UUID: 1668b79055aa48aeacf2f9a4eb05547a-20220408
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1616430123; Fri, 08 Apr 2022 10:42:46 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 8 Apr 2022 10:42:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Apr
 2022 10:42:44 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 10:42:44 +0800
Message-ID: <1ee8927744624fb0b6e97190e5a4b78cbee69751.camel@mediatek.com>
Subject: Re: [RESEND v17 3/7] soc: mediatek: add mtk-mmsys support for
 mt8195 vdosys0
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
        <postmaster@vger.kernel.org>, <hsinyi@chromium.org>,
        <fshao@chromium.org>, <moudy.ho@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 8 Apr 2022 10:42:44 +0800
In-Reply-To: <8d5c41c0-ac7c-ed1e-726b-0d738bf22fed@collabora.com>
References: <20220407030409.9664-1-jason-jh.lin@mediatek.com>
         <20220407030409.9664-4-jason-jh.lin@mediatek.com>
         <8d5c41c0-ac7c-ed1e-726b-0d738bf22fed@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

Thanks for the reviews.

On Thu, 2022-04-07 at 11:11 +0200, AngeloGioacchino Del Regno wrote:
> Il 07/04/22 05:04, jason-jh.lin ha scritto:
> > 1. Add mt8195 mmsys compatible for vdosys0.
> > 2. Add mt8195 routing table settings and fix build fail.
> > 3. Add clock name, clock driver name and routing table into the
> > driver data
> >     of mt8195 vdosys0.
> > 4. Add get match data by clock name function and clock platform
> > labels
> >     to identify which mmsys node is corresponding to vdosys0.
> > 
> > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   2 +-
> >   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   6 +-
> >   drivers/soc/mediatek/mt8167-mmsys.h         |   2 +-
> >   drivers/soc/mediatek/mt8183-mmsys.h         |   2 +-
> >   drivers/soc/mediatek/mt8186-mmsys.h         |   4 +-
> >   drivers/soc/mediatek/mt8192-mmsys.h         |   4 +-
> >   drivers/soc/mediatek/mt8195-mmsys.h         | 370
> > ++++++++++++++++++++
> >   drivers/soc/mediatek/mt8365-mmsys.h         |   4 +-
> >   drivers/soc/mediatek/mtk-mmsys.c            |  62 ++++
> >   drivers/soc/mediatek/mtk-mmsys.h            |   1 +
> >   drivers/soc/mediatek/mtk-mutex.c            |   8 +-
> >   include/linux/soc/mediatek/mtk-mmsys.h      |  13 +-
> >   12 files changed, 461 insertions(+), 17 deletions(-)
> >   create mode 100644 drivers/soc/mediatek/mt8195-mmsys.h
> > 
> 
> ..snip..
> 
> > diff --git a/drivers/soc/mediatek/mtk-mmsys.c
> > b/drivers/soc/mediatek/mtk-mmsys.c
> > index 4fc4c2c9ea20..b2fa239c5f5f 100644
> > --- a/drivers/soc/mediatek/mtk-mmsys.c
> > +++ b/drivers/soc/mediatek/mtk-mmsys.c
> > @@ -4,6 +4,8 @@
> >    * Author: James Liao <jamesjj.liao@mediatek.com>
> >    */
> >   
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> >   #include <linux/delay.h>
> >   #include <linux/device.h>
> >   #include <linux/io.h>
> > @@ -17,6 +19,7 @@
> >   #include "mt8183-mmsys.h"
> >   #include "mt8186-mmsys.h"
> >   #include "mt8192-mmsys.h"
> > +#include "mt8195-mmsys.h"
> >   #include "mt8365-mmsys.h"
> >   
> >   static const struct mtk_mmsys_driver_data
> > mt2701_mmsys_driver_data = {
> > @@ -72,12 +75,24 @@ static const struct mtk_mmsys_driver_data
> > mt8192_mmsys_driver_data = {
> >   	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
> >   };
> >   
> > +static const struct mtk_mmsys_driver_data
> > mt8195_vdosys0_driver_data = {
> > +	.clk_name = "cfg_vdo0",
> > +	.clk_driver = "clk-mt8195-vdo0",
> > +	.routes = mmsys_mt8195_routing_table,
> > +	.num_routes = ARRAY_SIZE(mmsys_mt8195_routing_table),
> > +};
> > +
> >   static const struct mtk_mmsys_driver_data
> > mt8365_mmsys_driver_data = {
> >   	.clk_driver = "clk-mt8365-mm",
> >   	.routes = mt8365_mmsys_routing_table,
> >   	.num_routes = ARRAY_SIZE(mt8365_mmsys_routing_table),
> >   };
> >   
> > +static const struct of_device_id mtk_clk_platform_labels[] = {
> > +	{ .compatible = "mediatek,mt8195-mmsys",
> > +	  .data = (void *)"clk-mt8195"},
> 
> I have a hunch that MT8195 won't be the first and last SoC having
> multiple
> mmsys channels. I would tend to think that there will be more....
> 

Yes, there will be another SoC with multiple mmsys channels...

> ....so, to make it clean from the beginning, I think that you should,
> at
> this point, assign a struct to that .data pointer, instead of
> declaring a
> drvdata struct into mtk_mmsys_get_match_data_by_clk_name().
> 
> Besides, I think that this kind of usage for __clk_get_name() may be
> an API
> abuse... but I'm not sure about that... in any case:
> - if it's not an abuse, then you should simply pass
> mt8195_vdosys0_driver_data,
>    or an array of pointers to mtk_mmsys_driver_data;
> - if this is an abuse, you can do the same checks by looking at the
> iostart
>    (mmio base address) of the vdosys{0,1} node(s).

Do you mean that I should change clk_name to iostart like this?

mt8195_vdosys0_driver_data = {
	.iostart = 0x1c01a000, // instead of clk_name
	.clk_driver = "clk-mt8195-vdo0",
	.routes = mmsys_mt8195_routing_table,
	.num_routes = ARRAY_SIZE(mmsys_mt8195_routing_table),
};

Just to confirm that address information can be disclosed here.
If it is not appropriate to use address here, I'll keep using clk_name.

> Honestly, though, I'm not even sure that you need this different
> of_device_id
> array here... since you could simply wrap the mtk_mmsys_driver_data
> in the
> of_match_mtk_mmsys that you have below... here's another idea:
> 
> struct mtk_mmsys_match_data {
> 	const struct mtk_mmsys_driver_data *drv_data[];
> 	unsigned short num_drv_data;
> };
> 
> ...so that:
> 
> static int some_function_handling_multi_mmsys(struct mtk_mmsys
> *mmsys,
> 					      struct
> mtk_mmsys_match_data *match)
> {
> 	int i;
> 
> 	i = [ logic to find the right match->drv_data entry here ]
> 
> 	return i;
> }
> 
> static int mtk_mmsys_probe()
> {
> 	.... variables, something else ....
> 
> 	if (match_data->num_drv_data > 1) {
> 		/* This SoC has multiple mmsys channels */
> 		ret = some_function_handling_multi_mmsys(mmsys);
> 		if (ret < 0)
> 			return ret;
> 
> 		mmsys->data = match_data->drv_data[ret];
> 	} else {
> 		dev_dbg(dev, "Using single mmsys channel\n");
> 		mmsys->data = match_data->drv_data[0];
> 	}
> 
> 	...everything else that mtk_mmsys_probe does ...
> }

I've tried this idea in my local environment and it looks good.
So I'll apply this at the next version. Thanks for your idea!

> What I'm trying to communicate with this is that the currently chosen
> solution
> looks a bit fragile and needs to be made robust.
> In comparison, even if it's not technically right to have two
> different compatibles
> for the same hardware (and shall not be done), the former solution,
> even if wrong,
> was more robust than this one, imo.
> 
> Regards,
> Angelo

Because we don't have a property to identify the different mmsys
directly (not using multi-mmsys handle function).

Although it make the code more complicated and not robust, but I think
this time it should be implemented for other multi-mmsys SoC in the
feature.


Regards,
Jason-JH.Lin

- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

