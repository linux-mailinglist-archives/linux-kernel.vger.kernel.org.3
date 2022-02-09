Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6F4AE6CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbiBICkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243903AbiBIBzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:55:00 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA60C06157B;
        Tue,  8 Feb 2022 17:54:58 -0800 (PST)
X-UUID: 327fe49623704569b14410ec47a335d1-20220209
X-UUID: 327fe49623704569b14410ec47a335d1-20220209
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 530702992; Wed, 09 Feb 2022 09:54:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 9 Feb 2022 09:54:53 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 09:54:53 +0800
Message-ID: <caebc48b7704f5e90a7513e9857644fea29b39a6.camel@mediatek.com>
Subject: Re: [v2 3/3] clk: mediatek: Integrate vppsys with mtk-mmsys in
 MT8195
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 9 Feb 2022 09:54:53 +0800
In-Reply-To: <e5ca60a0-4fee-0d6b-0714-77dc51f5a7cf@collabora.com>
References: <20220110005902.27148-1-chun-jie.chen@mediatek.com>
         <20220110005902.27148-4-chun-jie.chen@mediatek.com>
         <e5ca60a0-4fee-0d6b-0714-77dc51f5a7cf@collabora.com>
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

On Mon, 2022-01-10 at 22:36 +0800, AngeloGioacchino Del Regno wrote:
> Il 10/01/22 01:59, Chun-Jie Chen ha scritto:
> > Integrate vpp0 and vpp1 with mtk-mmsys driver which
> > will populate device by platform_device_register_data
> > to start vppsys clock driver.
> > 
> > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> 
> Hello Chun-Jie,
> 
> I agree with this series and I would be happy to give you my R-b, but
> this patch will make these clocks to *never* probe in in the targeted
> kernel version.
> 
> You forgot to mention that this patch will break vpp0/vpp1 clocks
> entirely
> unless applied on top of patch series [1].
> 
> Please, either mention that said series is *required* for this one to
> work
> as expected, or move series [1], patches 6 and 7 to this series
> instead;
> since the MDP3 driver will need quite a while to get merged, I would
> suggest
> to move the patches here, as to get something "complete" to merge.
> 
> [1]: 
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=568283__;!!CTRNKA9wMg0ARbw!wmrogRswnz6kpeUHCcHn5KDCMwLDf-hiX-e2cPQgx_5-V6YnB_dAbRZRayxp0K_Jbu00$
>  
> 

Thanks for your reminder, I only mention the dependence patch in v1,
but forgot it in v2.


> > ---
> >   drivers/clk/mediatek/clk-mt8195-vpp0.c | 42 +++++++++++++++++--
> > -------
> >   drivers/clk/mediatek/clk-mt8195-vpp1.c | 42 +++++++++++++++++--
> > -------
> >   2 files changed, 56 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c
> > b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> > index c3241466a8d0..68c375bfce8b 100644
> > --- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
> > +++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> > @@ -86,25 +86,39 @@ static const struct mtk_gate vpp0_clks[] = {
> >   	GATE_VPP0_2(CLK_VPP0_WARP1_MDP_DL_ASYNC,
> > "vpp0_warp1_mdp_dl_async", "top_wpe_vpp", 3),
> >   };
> >   
> > -static const struct mtk_clk_desc vpp0_desc = {
> > -	.clks = vpp0_clks,
> > -	.num_clks = ARRAY_SIZE(vpp0_clks),
> > -};
> > +static int clk_mt8195_vpp0_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node = dev->parent->of_node;
> > +	struct clk_onecell_data *clk_data;
> > +	int r;
> >   
> > -static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
> > -	{
> > -		.compatible = "mediatek,mt8195-vppsys0",
> > -		.data = &vpp0_desc,
> > -	}, {
> > -		/* sentinel */
> > -	}
> > -};
> > +	clk_data = mtk_alloc_clk_data(CLK_VPP0_NR_CLK);
> > +	if (!clk_data)
> > +		return -ENOMEM;
> > +
> > +	r = mtk_clk_register_gates(node, vpp0_clks,
> > ARRAY_SIZE(vpp0_clks), clk_data);
> > +	if (r)
> > +		goto free_vpp0_data;
> > +
> > +	r = of_clk_add_provider(node, of_clk_src_onecell_get,
> > clk_data);
> > +	if (r)
> > +		goto unregister_clk;
> > +
> > +	return r;
> > +
> > +unregister_clk:
> > +	mtk_clk_unregister(clk_data);
> > +
> > +free_vpp0_data:
> > +	mtk_free_clk_data(clk_data);
> > +	return r;
> > +}
> >   
> >   static struct platform_driver clk_mt8195_vpp0_drv = {
> > -	.probe = mtk_clk_simple_probe,
> > +	.probe = clk_mt8195_vpp0_probe,
> >   	.driver = {
> >   		.name = "clk-mt8195-vpp0",
> > -		.of_match_table = of_match_clk_mt8195_vpp0,
> >   	},
> >   };
> >   builtin_platform_driver(clk_mt8195_vpp0_drv);
> > diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c
> > b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> > index ce0b9a40a179..237077c60f54 100644
> > --- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
> > +++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> > @@ -84,25 +84,39 @@ static const struct mtk_gate vpp1_clks[] = {
> >   	GATE_VPP1_1(CLK_VPP1_VPP_SPLIT_26M, "vpp1_vpp_split_26m",
> > "clk26m", 26),
> >   };
> >   
> > -static const struct mtk_clk_desc vpp1_desc = {
> > -	.clks = vpp1_clks,
> > -	.num_clks = ARRAY_SIZE(vpp1_clks),
> > -};
> > +static int clk_mt8195_vpp1_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node = dev->parent->of_node;
> > +	struct clk_onecell_data *clk_data;
> > +	int r;
> >   
> > -static const struct of_device_id of_match_clk_mt8195_vpp1[] = {
> > -	{
> > -		.compatible = "mediatek,mt8195-vppsys1",
> > -		.data = &vpp1_desc,
> > -	}, {
> > -		/* sentinel */
> > -	}
> > -};
> > +	clk_data = mtk_alloc_clk_data(CLK_VPP1_NR_CLK);
> > +	if (!clk_data)
> > +		return -ENOMEM;
> > +
> > +	r = mtk_clk_register_gates(node, vpp1_clks,
> > ARRAY_SIZE(vpp1_clks), clk_data);
> > +	if (r)
> > +		goto free_vpp1_data;
> > +
> > +	r = of_clk_add_provider(node, of_clk_src_onecell_get,
> > clk_data);
> > +	if (r)
> > +		goto unregister_clk;
> > +
> > +	return r;
> > +
> > +unregister_clk:
> > +	mtk_clk_unregister(clk_data);
> > +
> > +free_vpp1_data:
> > +	mtk_free_clk_data(clk_data);
> > +	return r;
> > +}
> >   
> >   static struct platform_driver clk_mt8195_vpp1_drv = {
> > -	.probe = mtk_clk_simple_probe,
> > +	.probe = clk_mt8195_vpp1_probe,
> >   	.driver = {
> >   		.name = "clk-mt8195-vpp1",
> > -		.of_match_table = of_match_clk_mt8195_vpp1,
> >   	},
> >   };
> >   builtin_platform_driver(clk_mt8195_vpp1_drv);
> > 
> 
> 
> -- 
> AngeloGioacchino Del Regno
> Software Engineer
> 
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718

