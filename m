Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDCB50AF58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444049AbiDVFJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiDVFJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:09:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299471BEA0;
        Thu, 21 Apr 2022 22:06:18 -0700 (PDT)
X-UUID: dc04ede448414c53a2c1d20c16f1f93f-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:61758deb-bd43-4fa3-8d57-eadb4d22b023,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:2
X-CID-META: VersionHash:faefae9,CLOUDID:7bb290f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:4,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: dc04ede448414c53a2c1d20c16f1f93f-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1964622933; Fri, 22 Apr 2022 13:06:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 13:06:11 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 13:06:11 +0800
Message-ID: <59876cd509fed9348f3ec80a468409dd25ab5efe.camel@mediatek.com>
Subject: Re: [PATCH V2 09/12] clk: mediatek: reset: Add support for input
 offset and bit from DT
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
Date:   Fri, 22 Apr 2022 13:06:11 +0800
In-Reply-To: <b9839f51-fef1-c54a-3024-674209987f13@collabora.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
         <20220420130527.23200-10-rex-bc.chen@mediatek.com>
         <b9839f51-fef1-c54a-3024-674209987f13@collabora.com>
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
> > To use the clock reset function easier, we implement the of_xlate.
> > This function is only adopted in version MTK_SET_CLR because of
> > the method of id calculation.
> > 
> > There is no impact for original use. If the argument number is not
> > larger than 1, it will return original id.
> > 
> > With this implementation if we want to set offset 0x120 and bit 16,
> > we can just write something like "resets = <&infra_rst 0x120 16>;".
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >   drivers/clk/mediatek/reset.c | 24 ++++++++++++++++++++++++
> >   drivers/clk/mediatek/reset.h |  1 +
> >   2 files changed, 25 insertions(+)
> > 
> > diff --git a/drivers/clk/mediatek/reset.c
> > b/drivers/clk/mediatek/reset.c
> > index 1173111af3ab..dbe812062bf5 100644
> > --- a/drivers/clk/mediatek/reset.c
> > +++ b/drivers/clk/mediatek/reset.c
> > @@ -59,6 +59,20 @@ static const struct reset_control_ops
> > mtk_reset_ops_set_clr = {
> >   	.reset = mtk_reset_set_clr,
> >   };
> >   
> > +static int reset_xlate(struct reset_controller_dev *rcdev,
> > +		       const struct of_phandle_args *reset_spec)
> > +{
> > +	unsigned int offset, bit;
> > +
> > +	if (reset_spec->args_count <= 1)
> > +		return reset_spec->args[0];
> > +
> > +	offset = reset_spec->args[0];
> > +	bit = reset_spec->args[1];
> > +
> > +	return (offset >> 4) * 32 + bit;
> > +}
> > +
> >   static const struct reset_control_ops *rst_op[MTK_RST_MAX] = {
> >   	[MTK_RST_SIMPLE] = &reset_simple_ops,
> >   	[MTK_RST_SET_CLR] = &mtk_reset_ops_set_clr,
> > @@ -98,6 +112,11 @@ int mtk_clk_register_rst_ctrl(struct
> > device_node *np,
> >   	data->rcdev.ops = rst_op[desc->version];
> >   	data->rcdev.of_node = np;
> >   
> > +	if (desc->version == MTK_RST_SET_CLR) {
> 
> ...following my previous advice to use switch(version), this would
> fit in
> just fine :-)
> 
> Everything else looks ok.
> 
> Cheers,
> Angelo

Hello Angelo,

I will add this judgement in reset_xlate()

BRs,
Rex

