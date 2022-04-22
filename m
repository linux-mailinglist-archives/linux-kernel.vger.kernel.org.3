Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE62550AF55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444067AbiDVFIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243064AbiDVFIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:08:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA884B412;
        Thu, 21 Apr 2022 22:05:25 -0700 (PDT)
X-UUID: 6b66d811a4244f2e87c18a690203fe82-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:044238de-f1ff-4a2f-8a0a-034877c69cd9,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:55
X-CID-INFO: VERSION:1.1.4,REQID:044238de-f1ff-4a2f-8a0a-034877c69cd9,OB:0,LOB:
        0,IP:0,URL:8,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:55
X-CID-META: VersionHash:faefae9,CLOUDID:8dab90f0-da02-41b4-b6df-58f4ccd36682,C
        OID:c0ed5e5f9af5,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:4,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 6b66d811a4244f2e87c18a690203fe82-20220422
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1914481289; Fri, 22 Apr 2022 13:05:18 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 13:05:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 13:05:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 13:05:16 +0800
Message-ID: <1418de018e42343fead3a81dc59209158369d3a9.camel@mediatek.com>
Subject: Re: [PATCH V2 08/12] clk: mediatek: reset: Add new register reset
 function with device
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <allen-kh.cheng@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 22 Apr 2022 13:05:16 +0800
In-Reply-To: <bff10500-4b63-9553-2ce0-3e46eb261d7a@collabora.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
         <20220420130527.23200-9-rex-bc.chen@mediatek.com>
         <bff10500-4b63-9553-2ce0-3e46eb261d7a@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-21 at 11:07 +0200, AngeloGioacchino Del Regno wrote:
> Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> > Some clock drvier only support device_node, so we still remain
> > register reset function with device_node and add a function to
> > register reset controller with device.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >   drivers/clk/mediatek/clk-mt2701-eth.c |  2 +-
> >   drivers/clk/mediatek/clk-mt2701-g3d.c |  2 +-
> >   drivers/clk/mediatek/clk-mt2701-hif.c |  2 +-
> >   drivers/clk/mediatek/clk-mt2701.c     |  4 +--
> >   drivers/clk/mediatek/clk-mt2712.c     |  4 +--
> >   drivers/clk/mediatek/clk-mt7622-eth.c |  2 +-
> >   drivers/clk/mediatek/clk-mt7622-hif.c |  4 +--
> >   drivers/clk/mediatek/clk-mt7622.c     |  4 +--
> >   drivers/clk/mediatek/clk-mt7629-eth.c |  2 +-
> >   drivers/clk/mediatek/clk-mt7629-hif.c |  4 +--
> >   drivers/clk/mediatek/clk-mt8183.c     |  2 +-
> >   drivers/clk/mediatek/reset.c          | 43
> > +++++++++++++++++++++++++++
> >   drivers/clk/mediatek/reset.h          |  2 ++
> >   13 files changed, 61 insertions(+), 16 deletions(-)
> > 
> 
> 
> ..snip..
> 
> > diff --git a/drivers/clk/mediatek/reset.c
> > b/drivers/clk/mediatek/reset.c
> > index b164b1da7dd3..1173111af3ab 100644
> > --- a/drivers/clk/mediatek/reset.c
> > +++ b/drivers/clk/mediatek/reset.c
> > @@ -107,4 +107,47 @@ int mtk_clk_register_rst_ctrl(struct
> > device_node *np,
> >   	return ret;
> >   }
> >   
> > +int mtk_clk_register_rst_ctrl_with_dev(struct device *dev,
> > +				       const struct mtk_clk_rst_desc
> > *desc)
> > +{
> > +	struct device_node *np = dev->of_node;
> > +	struct regmap *regmap;
> > +	struct mtk_clk_rst_data *data;
> > +	int ret;
> > +
> > +	if (!desc) {
> > +		dev_err(dev, "mtk clock reset desc is NULL\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (desc->version >= MTK_RST_MAX) {
> > +		dev_err(dev, "Error version number: %d\n", desc-
> > >version);
> > +		return -EINVAL;
> > +	}
> > +
> > +	regmap = device_node_to_regmap(np);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(dev, "Cannot find regmap %pe\n", regmap);
> > +		return -EINVAL;
> > +	}
> > +
> > +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	data->desc = desc;
> > +	data->regmap = regmap;
> > +	data->rcdev.owner = THIS_MODULE;
> > +	data->rcdev.nr_resets = desc->reg_num * 32;
> > +	data->rcdev.ops = rst_op[desc->version];
> > +	data->rcdev.of_node = np;
> > +	data->rcdev.dev = dev;
> > +
> > +	ret = devm_reset_controller_register(dev, &data->rcdev);
> > +	if (ret)
> > +		dev_err(dev, "could not register reset controller:
> > %d\n", ret);
> 
> 	if (ret) {
> 		dev_err(dev, "could not register reset controller:
> %d\n", ret);
> 		return ret;
> 	}
> 
> 	return 0;
> 
> > +
> > +	return ret;
> > +}
> > +
> >   MODULE_LICENSE("GPL");

Hello Angelo,

ok, I will do this in next version.

BRs,
Rex

