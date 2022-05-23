Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79C530894
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354614AbiEWFKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiEWFKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:10:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23F12670;
        Sun, 22 May 2022 22:09:59 -0700 (PDT)
X-UUID: 709c3bce4e31438a8bf5d73692a0ec5f-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:4484ef1a-6989-4707-b741-ca015d935a25,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:c1683c7a-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 709c3bce4e31438a8bf5d73692a0ec5f-20220523
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1397988207; Mon, 23 May 2022 13:09:55 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 13:09:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 May 2022 13:09:53 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 May 2022 13:09:53 +0800
Message-ID: <cdfe094579737473b8d97cd584c1b157aaa54fc7.camel@mediatek.com>
Subject: Re: [PATCH v7 05/19] clk: mediatek: reset: Merge and revise reset
 register function
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 23 May 2022 13:09:53 +0800
In-Reply-To: <20220520151212.rrrtekst7uhnojds@notapiano>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
         <20220519125527.18544-6-rex-bc.chen@mediatek.com>
         <20220520151212.rrrtekst7uhnojds@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 11:12 -0400, Nícolas F. R. A. Prado wrote:
> Hi Rex,
> 
> On Thu, May 19, 2022 at 08:55:13PM +0800, Rex-BC Chen wrote:
> > There are two versions for clock reset register control for
> > MediaTek
> > SoCs. The old hardware is one bit per reset control, and does not
> > have separate registers for bit set, clear and read-back
> > operations.
> > This matches the scheme supported by the simple reset driver.
> > 
> > However, because we need to use different data structure from
> > reset_simple_data, we can not use the operation of simple reset
> > driver.
> > For this reason, we keep the original functions and name this
> > version
> > as "MTK_RST_SIMPLE".
> > 
> > In this patch:
> > - Add a version enumeration to separate different reset hardware.
> > - Merge the reset register function of simple and set_clr into one
> >   function "mtk_register_reset_controller".
> > - Rename input variable "num_regs" to "rst_bank_nr" to avoid
> >   confusion. This variable is used to define the quantity of reset
> > bank.
> > - Document mtk_reset_version and mtk_register_reset_controller.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> 
> <snip>
> 
> > index 764a8affe206..2a39eec9cff7 100644
> > --- a/drivers/clk/mediatek/reset.h
> > +++ b/drivers/clk/mediatek/reset.h
> > @@ -9,16 +9,32 @@
> >  #include <linux/reset-controller.h>
> >  #include <linux/types.h>
> >  
> > +/**
> > + * enum mtk_reset_version - Version of MediaTek clock reset
> > controller.
> > + * @MTK_RST_SIMPLE: Use the same registers for bit set and clear.
> > + * @MTK_RST_SET_CLR: Use separate registers for bit set and clear.
> > + * @MTK_RST_MAX: Total quantity of version for MediaTek clock
> > reset controller.
> > + */
> > +enum mtk_reset_version {
> > +	MTK_RST_SIMPLE = 0,
> > +	MTK_RST_SET_CLR,
> > +	MTK_RST_MAX,
> > +};
> > +
> >  struct mtk_reset {
> >  	struct regmap *regmap;
> >  	int regofs;
> >  	struct reset_controller_dev rcdev;
> >  };
> >  
> > +/**
> > + * mtk_register_reset_controller - Register MediaTek clock reset
> > controller
> > + * @np: Pointer to device node.
> > + * @rst_bank_nr: Quantity of reset bank.
> > + * @reg_ofs: Base offset of the reset register.
> > + * @version: Version of MediaTek clock reset controller.
> > + */
> >  void mtk_register_reset_controller(struct device_node *np,
> > -				   unsigned int num_regs, int regofs);
> > -
> > -void mtk_register_reset_controller_set_clr(struct device_node *np,
> > -					   unsigned int num_regs, int
> > regofs);
> > +				   u32 rst_bank_nr, u16 reg_ofs, u8
> > version);
> 
> Why not use 'enum mtk_reset_version' instead of a generic u8? Same
> thing when
> you move it to a struct in patch 6.
> 
> Thanks,
> Nícolas

HEllo Nícolas,

Thanks for the review.
I will modify for both patch 5 and 6 for this in next version.

BRs,
Rex

