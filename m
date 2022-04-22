Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0A50AF4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444031AbiDVFEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiDVFE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:04:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100848E63;
        Thu, 21 Apr 2022 22:01:33 -0700 (PDT)
X-UUID: 3355754f0de6467da89cc1623f69eabb-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:f6f9202b-312c-4d25-a452-6857833d45db,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:47
X-CID-INFO: VERSION:1.1.4,REQID:f6f9202b-312c-4d25-a452-6857833d45db,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:47
X-CID-META: VersionHash:faefae9,CLOUDID:4c97baef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:4,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: 3355754f0de6467da89cc1623f69eabb-20220422
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1672261687; Fri, 22 Apr 2022 13:01:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 13:01:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 13:01:25 +0800
Message-ID: <60f3595612dba17e5cb115e468e39b7ca551d027.camel@mediatek.com>
Subject: Re: [PATCH V2 04/12] clk: mediatek: reset: Merge and revise reset
 register function
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
Date:   Fri, 22 Apr 2022 13:01:25 +0800
In-Reply-To: <a2341eae-3a3a-ca26-8ce7-a4ba9219566c@collabora.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
         <20220420130527.23200-5-rex-bc.chen@mediatek.com>
         <a2341eae-3a3a-ca26-8ce7-a4ba9219566c@collabora.com>
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
> > Merge the reset register function of simple and set_clr into one
> > function.
> > - Input the version number to determine which version we will use.
> > - Rename reset register function to "mtk_clk_register_rst_ctrl"
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
> >   drivers/clk/mediatek/clk-mt8135.c     |  4 +--
> >   drivers/clk/mediatek/clk-mt8173.c     |  4 +--
> >   drivers/clk/mediatek/clk-mt8183.c     |  3 ++-
> >   drivers/clk/mediatek/clk-mtk.h        | 13 ++++++----
> >   drivers/clk/mediatek/reset.c          | 35 ++++++++++++--------
> > -------
> >   15 files changed, 44 insertions(+), 45 deletions(-)
> > 
> 
> ..snip..
> 
> > diff --git a/drivers/clk/mediatek/reset.c
> > b/drivers/clk/mediatek/reset.c
> > index 6574b19daf0f..8e42deee80a3 100644
> > --- a/drivers/clk/mediatek/reset.c
> > +++ b/drivers/clk/mediatek/reset.c
> > @@ -65,14 +65,23 @@ static const struct reset_control_ops
> > mtk_reset_ops_set_clr = {
> >   	.reset = mtk_reset_set_clr,
> >   };
> >   
> > -static void mtk_register_reset_controller_common(struct
> > device_node *np,
> > -			unsigned int num_regs, int regofs,
> > -			const struct reset_control_ops *reset_ops)
> > +static const struct reset_control_ops *rst_op[MTK_RST_MAX] = {
> > +	[MTK_RST_SIMPLE] = &reset_simple_ops,
> > +	[MTK_RST_SET_CLR] = &mtk_reset_ops_set_clr,
> > +};
> 
> I don't think that we really need this to go to .rodata to get an
> improvement
> in boot times in the order of nanoseconds....
> 
> > +
> > +void mtk_clk_register_rst_ctrl(struct device_node *np,
> > +			       u32 reg_num, u16 reg_ofs, u8 version)
> >   {
> >   	struct mtk_reset *data;
> >   	int ret;
> >   	struct regmap *regmap;
> >   
> > +	if (version >= MTK_RST_MAX) {
> > +		pr_err("Error version number: %d\n", version);
> > +		return;
> > +	}
> > +
> >   	regmap = device_node_to_regmap(np);
> >   	if (IS_ERR(regmap)) {
> >   		pr_err("Cannot find regmap for %pOF: %pe\n", np,
> > regmap);
> > @@ -84,10 +93,10 @@ static void
> > mtk_register_reset_controller_common(struct device_node *np,
> >   		return;
> >   
> >   	data->regmap = regmap;
> > -	data->regofs = regofs;
> > +	data->regofs = reg_ofs;
> >   	data->rcdev.owner = THIS_MODULE;
> > -	data->rcdev.nr_resets = num_regs * 32;
> > -	data->rcdev.ops = reset_ops;
> > +	data->rcdev.nr_resets = reg_num * 32;
> > +	data->rcdev.ops = rst_op[version];
> >   	data->rcdev.of_node = np;
> 
> ...hence, I would prefer to see something like:
> 
> 	switch (version) {
> 	case MTK_RST_SIMPLE:
> 		data->rcdev.ops = &reset_simple_ops;
> 		break;
> 	case MTK_RST_SET_CLR:
> 		data->rcdev.ops = &mtk_reset_ops_set_clr;
> 		break;
> 	default:
> 		pr_err("Unknown reset version %d\n", version);
> 		return;
> 	}
> 
> Like that, you'd also replace that if branch at the beginning where
> you
> do the reset version sanity check.
> If you don't want to allocate a struct mtk_reset before running this
> switch,
> you can also declare a `struct reset_control_ops *rcops = NULL;`
> locally and
> then assign `data->rcdev.ops = rcops;` later: that would also be
> acceptable.
> 
> Cheers,
> Angelo

Hello Angelo,

I will do this in next version.

BRs,
Rex

