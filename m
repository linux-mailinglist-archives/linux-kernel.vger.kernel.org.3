Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9265B1218
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIHB1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIHB1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:27:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C68832EC;
        Wed,  7 Sep 2022 18:27:08 -0700 (PDT)
X-UUID: 199aebecb2ae4928a2b07bf8e63537e9-20220908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Jxm4Q2hjq51exmAQAAZplPtyEj8SEXfXis2YBGKt1cc=;
        b=cT8deU1OrEnLsdPHGk6Gwo9e0L2itARCNUwgnMnf80crObpD2K2MYnpNZUjQughHsrHSeWJwl/AG5eC5+/cIMrUT5HSqOc6JYpHLuJRLPudwZv76zKSufRVljfq+Fp51u4Hs29k3VhNyNii5oac13iacBqCcr72AVTus4dknm7M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:d80803f6-70ab-45ef-b724-b24b7cbafe5c,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:6afd0757-e800-47dc-8adf-0c936acf4f1b,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 199aebecb2ae4928a2b07bf8e63537e9-20220908
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 84008891; Thu, 08 Sep 2022 09:27:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 8 Sep 2022 09:27:03 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Sep 2022 09:27:00 +0800
Message-ID: <696a84dbd54a5c591b78a6c7e043aedb2db85d9b.camel@mediatek.com>
Subject: Re: [PATCH v2 7/7] phy: phy-mtk-tphy: fix the phy type setting issue
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Thu, 8 Sep 2022 09:27:00 +0800
In-Reply-To: <9a7abae0-e31e-6beb-74ce-96462d847a88@collabora.com>
References: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
         <20220829080830.5378-7-chunfeng.yun@mediatek.com>
         <9a7abae0-e31e-6beb-74ce-96462d847a88@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-31 at 10:31 +0200, AngeloGioacchino Del Regno wrote:
> Il 29/08/22 10:08, Chunfeng Yun ha scritto:
> > The PHY type is not set if the index is non zero, prepare type
> > value according to the index, like as mask value.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> I agree with this change and I'd be happy to give you my R-b tag, but
> this
> commit clearly needs to be backported, so you need a Fixes tag, or a
> Cc to stable.
A good point, will add it in next version, thanks a lot

> 
> Thanks,
> Angelo
> 
> > ---
> > v2: no changes
> > ---
> >   drivers/phy/mediatek/phy-mtk-tphy.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c
> > b/drivers/phy/mediatek/phy-mtk-tphy.c
> > index e0f227a0d3cc..cc10298bc70d 100644
> > --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> > +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> > @@ -915,7 +915,7 @@ static int phy_type_syscon_get(struct
> > mtk_phy_instance *instance,
> >   static int phy_type_set(struct mtk_phy_instance *instance)
> >   {
> >   	int type;
> > -	u32 mask;
> > +	u32 offset;
> >   
> >   	if (!instance->type_sw)
> >   		return 0;
> > @@ -938,8 +938,9 @@ static int phy_type_set(struct mtk_phy_instance
> > *instance)
> >   		return 0;
> >   	}
> >   
> > -	mask = RG_PHY_SW_TYPE << (instance->type_sw_index *
> > BITS_PER_BYTE);
> > -	regmap_update_bits(instance->type_sw, instance->type_sw_reg,
> > mask, type);
> > +	offset = instance->type_sw_index * BITS_PER_BYTE;
> > +	regmap_update_bits(instance->type_sw, instance->type_sw_reg,
> > +			   RG_PHY_SW_TYPE << offset, type << offset);
> >   
> >   	return 0;
> >   }
> > 
> 
> 

