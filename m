Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6E04F8C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiDHBoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiDHBoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:44:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A8C12F16E;
        Thu,  7 Apr 2022 18:42:17 -0700 (PDT)
X-UUID: 860e54d77ec040c5a98a4ae2c7253c72-20220408
X-UUID: 860e54d77ec040c5a98a4ae2c7253c72-20220408
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 972807619; Fri, 08 Apr 2022 09:42:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Apr 2022 09:42:10 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 09:42:10 +0800
Message-ID: <429d177cf655c82fbe37e93b3cb452bd08ab3b5e.camel@mediatek.com>
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
Date:   Fri, 8 Apr 2022 09:42:10 +0800
In-Reply-To: <f04154f2908d3420bc48ed35273a1d4866bd40af.camel@mediatek.com>
References: <20220407030409.9664-1-jason-jh.lin@mediatek.com>
         <20220407030409.9664-4-jason-jh.lin@mediatek.com>
         <f04154f2908d3420bc48ed35273a1d4866bd40af.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,

Thanks for the reviews.

On Thu, 2022-04-07 at 13:58 +0800, CK Hu wrote:
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
> > 
> 
> [snip]
> 
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
> > 
> 
> [snip]
> 
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
> 
> Why not
> 
> strcmp(drvdata[i]->clk_name, clk_name) == 0
> 
> Regards,
> CK
> 

I would like to block strings without '\0', but it doesn't seem
necessary. So I will change to strcmp at the next version.

Regards,
Jason-JH.Lin

> > +		    strncmp(drvdata[i]->clk_driver, of_id->data,
> > strlen(of_id->data)) == 0) {
> > +			*data = drvdata[i];
> > +			return 0;
> > +		}
> > +
> > +	return -EINVAL;
> > +}
> > +
> >  
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> 
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!0MJsfiFOYUann5GooGDcIv4Lgm1FaCXDl8dDFCwiONgD0zJn0PQwJuV05-tZNZwVBxVS$
>  
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

