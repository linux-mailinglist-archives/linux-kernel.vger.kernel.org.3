Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167EF530890
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353324AbiEWFJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiEWFJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:09:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845C27E;
        Sun, 22 May 2022 22:08:58 -0700 (PDT)
X-UUID: b48d37840d4d4fc49977017e3604f6d5-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:59c833d4-dc9e-461f-8595-d251fed4c0ce,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:59c833d4-dc9e-461f-8595-d251fed4c0ce,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:df5d3c7a-5ef6-470b-96c9-bdb8ced32786,C
        OID:c4fd7da82419,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: b48d37840d4d4fc49977017e3604f6d5-20220523
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 408698336; Mon, 23 May 2022 13:08:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 13:08:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 May 2022 13:08:52 +0800
Message-ID: <9a401f9e0bc1324e801ba05ec4a2269fa82322f2.camel@mediatek.com>
Subject: Re: [PATCH v7 04/19] clk: mediatek: reset: Extract common drivers
 to update function
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
Date:   Mon, 23 May 2022 13:08:52 +0800
In-Reply-To: <20220520145551.b2sqheaizkegna3n@notapiano>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
         <20220519125527.18544-5-rex-bc.chen@mediatek.com>
         <20220520145551.b2sqheaizkegna3n@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 10:55 -0400, Nícolas F. R. A. Prado wrote:
> On Thu, May 19, 2022 at 08:55:12PM +0800, Rex-BC Chen wrote:
> > To make drivers more clear and readable, we extract common code
> > within assert and deassert to mtk_reset_update_set_clr() and
> > mtk_reset_update().
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/clk/mediatek/reset.c | 38 +++++++++++++++++++++-----------
> > ----
> >  1 file changed, 22 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/clk/mediatek/reset.c
> > b/drivers/clk/mediatek/reset.c
> > index 5cbbcc22a4fc..22fa9f09752c 100644
> > --- a/drivers/clk/mediatek/reset.c
> > +++ b/drivers/clk/mediatek/reset.c
> > @@ -12,24 +12,27 @@
> >  
> >  #include "reset.h"
> >  
> > -static int mtk_reset_assert(struct reset_controller_dev *rcdev,
> > -			    unsigned long id)
> > +static int mtk_reset_update(struct reset_controller_dev *rcdev,
> > +			    unsigned long id, bool deassert)
> 
> I'd have called the bool 'assert', and then passed true on assert and
> false on
> deassert, as I think that's slightly more intuitive, but that's just
> personal
> preference. It's fine like this as well.
> 
> Thanks,
> Nícolas
> 

Hello Nícolas,

Thanks for your advice, but I think I will keep the original logic in
next version.

BRs,
Rex


> >  {
> >  	struct mtk_reset *data = container_of(rcdev, struct mtk_reset,
> > rcdev);
> > +	unsigned int val = deassert ? 0 : ~0;
> >  
> >  	return regmap_update_bits(data->regmap,
> >  				  data->regofs + ((id / 32) << 2),
> > -				  BIT(id % 32), ~0);
> > +				  BIT(id % 32), val);
> > +}
> > +
> > +static int mtk_reset_assert(struct reset_controller_dev *rcdev,
> > +			    unsigned long id)
> > +{
> > +	return mtk_reset_update(rcdev, id, false);
> >  }
> >  
> >  static int mtk_reset_deassert(struct reset_controller_dev *rcdev,
> >  			      unsigned long id)
> >  {
> > -	struct mtk_reset *data = container_of(rcdev, struct mtk_reset,
> > rcdev);
> > -
> > -	return regmap_update_bits(data->regmap,
> > -				  data->regofs + ((id / 32) << 2),
> > -				  BIT(id % 32), 0);
> > +	return mtk_reset_update(rcdev, id, true);
> >  }
> >  
> >  static int mtk_reset(struct reset_controller_dev *rcdev, unsigned
> > long id)
> > @@ -43,24 +46,27 @@ static int mtk_reset(struct
> > reset_controller_dev *rcdev, unsigned long id)
> >  	return mtk_reset_deassert(rcdev, id);
> >  }
> >  
> > -static int mtk_reset_assert_set_clr(struct reset_controller_dev
> > *rcdev,
> > -				    unsigned long id)
> > +static int mtk_reset_update_set_clr(struct reset_controller_dev
> > *rcdev,
> > +				    unsigned long id, bool deassert)
> >  {
> >  	struct mtk_reset *data = container_of(rcdev, struct mtk_reset,
> > rcdev);
> > +	unsigned int deassert_ofs = deassert ? 0x4 : 0;
> >  
> >  	return regmap_write(data->regmap,
> > -			    data->regofs + ((id / 32) << 4),
> > +			    data->regofs + ((id / 32) << 4) +
> > deassert_ofs,
> >  			    BIT(id % 32));
> >  }
> >  
> > +static int mtk_reset_assert_set_clr(struct reset_controller_dev
> > *rcdev,
> > +				    unsigned long id)
> > +{
> > +	return mtk_reset_update_set_clr(rcdev, id, false);
> > +}
> > +
> >  static int mtk_reset_deassert_set_clr(struct reset_controller_dev
> > *rcdev,
> >  				      unsigned long id)
> >  {
> > -	struct mtk_reset *data = container_of(rcdev, struct mtk_reset,
> > rcdev);
> > -
> > -	return regmap_write(data->regmap,
> > -			    data->regofs + ((id / 32) << 4) + 0x4,
> > -			    BIT(id % 32));
> > +	return mtk_reset_update_set_clr(rcdev, id, true);
> >  }
> >  
> >  static int mtk_reset_set_clr(struct reset_controller_dev *rcdev,
> > -- 
> > 2.18.0
> > 
> > 

