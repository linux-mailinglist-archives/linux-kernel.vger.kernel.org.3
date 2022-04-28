Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B214512ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbiD1FMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiD1FMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:12:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD85DA56;
        Wed, 27 Apr 2022 22:08:46 -0700 (PDT)
X-UUID: 490704e445534698a66f5c41d3c26818-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:74385a90-308e-4acc-b87f-915beed3df18,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:74385a90-308e-4acc-b87f-915beed3df18,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:058ffd2e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 490704e445534698a66f5c41d3c26818-20220428
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 24281124; Thu, 28 Apr 2022 13:08:40 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 13:08:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 13:08:37 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 13:08:37 +0800
Message-ID: <de775aae07da3ff855d5bf95da996977efadda23.camel@mediatek.com>
Subject: Re: [PATCH V4 07/15] clk: mediatek: reset: Support nonsequence base
 offsets of reset registers
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>, <chun-jie.chen@mediatek.com>,
        <wenst@chromium.org>, <runyang.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 28 Apr 2022 13:08:37 +0800
In-Reply-To: <c643d877-bc0a-a92c-d366-bd27bf580739@collabora.com>
References: <20220427030950.23395-1-rex-bc.chen@mediatek.com>
         <20220427030950.23395-8-rex-bc.chen@mediatek.com>
         <c643d877-bc0a-a92c-d366-bd27bf580739@collabora.com>
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

On Wed, 2022-04-27 at 15:38 +0200, AngeloGioacchino Del Regno wrote:
> Il 27/04/22 05:09, Rex-BC Chen ha scritto:
> > The bank offsets are not serial for all reset registers.
> > For example, there are five infra reset banks for MT8192: 0x120,
> > 0x130,
> > 0x140, 0x150 and 0x730.
> > 
> > To support this,
> > - Change reg_ofs to rst_bank_ofs which is a pointer to base offsets
> > of
> >    the reset register.
> > - Add a new define RST_NR_PER_BANK to define reset number for each
> >    reset bank.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >   drivers/clk/mediatek/clk-mt2701-eth.c |  6 ++++--
> >   drivers/clk/mediatek/clk-mt2701-g3d.c |  6 ++++--
> >   drivers/clk/mediatek/clk-mt2701-hif.c |  6 ++++--
> >   drivers/clk/mediatek/clk-mt2701.c     | 11 +++++++----
> >   drivers/clk/mediatek/clk-mt2712.c     | 15 +++++++++------
> >   drivers/clk/mediatek/clk-mt7622-eth.c |  6 ++++--
> >   drivers/clk/mediatek/clk-mt7622-hif.c |  6 ++++--
> >   drivers/clk/mediatek/clk-mt7622.c     | 11 +++++++----
> >   drivers/clk/mediatek/clk-mt7629-eth.c |  6 ++++--
> >   drivers/clk/mediatek/clk-mt7629-hif.c |  6 ++++--
> >   drivers/clk/mediatek/clk-mt8135.c     | 11 +++++++----
> >   drivers/clk/mediatek/clk-mt8173.c     | 11 +++++++----
> >   drivers/clk/mediatek/clk-mt8183.c     | 14 ++++++++++++--
> >   drivers/clk/mediatek/reset.c          | 11 ++++++-----
> >   drivers/clk/mediatek/reset.h          |  6 ++++--
> >   15 files changed, 87 insertions(+), 45 deletions(-)
> > 
> 
> ..snip..
> 
> > diff --git a/drivers/clk/mediatek/clk-mt2701.c
> > b/drivers/clk/mediatek/clk-mt2701.c
> > index 70a934faa529..ebb1b9975ab0 100644
> > --- a/drivers/clk/mediatek/clk-mt2701.c
> > +++ b/drivers/clk/mediatek/clk-mt2701.c
> > @@ -735,18 +735,21 @@ static const struct mtk_fixed_factor
> > infra_fixed_divs[] = {
> >   	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
> >   };
> >   
> > +static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
> > +static u16 perfcfg_rst_ofs[] = { 0x0, 0x4, };
> 
> Typo: perfcfg -> pericfg ... here and in some more files :))
> 

Hello Angelo,

Thanks for your review!

I will fix them.

> > +
> >   static const struct mtk_clk_rst_desc clk_rst_desc[] = {
> >   	/* infrasys */
> >   	{
> >   		.version = MTK_RST_SIMPLE,
> > -		.rst_bank_nr = 2,
> > -		.reg_ofs = 0x30,
> > +		.rst_bank_ofs = infrasys_rst_ofs,
> > +		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
> >   	},
> >   	/* pericfg */
> >   	{
> >   		.version = MTK_RST_SIMPLE,
> > -		.rst_bank_nr = 2,
> > -		.reg_ofs = 0x0,
> > +		.rst_bank_ofs = perfcfg_rst_ofs,
> > +		.rst_bank_nr = ARRAY_SIZE(perfcfg_rst_ofs),
> >   	},
> >   };
> >   
> > diff --git a/drivers/clk/mediatek/clk-mt2712.c
> > b/drivers/clk/mediatek/clk-mt2712.c
> > index cef7c79788ec..2a9d70dd97d6 100644
> > --- a/drivers/clk/mediatek/clk-mt2712.c
> > +++ b/drivers/clk/mediatek/clk-mt2712.c
> > @@ -1258,18 +1258,21 @@ static const struct mtk_pll_data plls[] = {
> >   		0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
> >   };
> >   
> > +static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
> > +static u16 perfcfg_rst_ofs[] = { 0x0, 0x4, };
> > +
> >   static const struct mtk_clk_rst_desc clk_rst_desc[] = {
> > -	/* infra */
> > +	/* infrasys */
> 
> Instead of renaming these here, if you really want this renamed, can
> you please
> do that in patch [06/15]?
> 

I will remove them.

> >   	{
> >   		.version = MTK_RST_SIMPLE,
> > -		.rst_bank_nr = 2,
> > -		.reg_ofs = 0x30,
> > +		.rst_bank_ofs = infrasys_rst_ofs,
> > +		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
> >   	},
> 
> ..snip..
> 
> > diff --git a/drivers/clk/mediatek/reset.h
> > b/drivers/clk/mediatek/reset.h
> > index 91358e8cb851..83840ecf8b27 100644
> > --- a/drivers/clk/mediatek/reset.h
> > +++ b/drivers/clk/mediatek/reset.h
> > @@ -9,6 +9,8 @@
> >   #include <linux/reset-controller.h>
> >   #include <linux/types.h>
> >   
> > +#define RST_NR_PER_BANK 32
> > +
> >   /**
> >    * enum mtk_reset_version - Version of MediaTek clock reset
> > controller.
> >    * @MTK_RST_SIMPLE: Use the same registers for bit set and clear.
> > @@ -24,12 +26,12 @@ enum mtk_reset_version {
> >   /**
> >    * struct mtk_clk_rst_desc - Description of MediaTek clock reset.
> >    * @version: Reset version which is defined in enum
> > mtk_reset_version.
> > - * @reg_ofs: Base offset of the reset register.
> > + * @rst_bank_ofs: Pointer to base offsets of the reset register.
> 
> Instead of generically saying that this is a pointer, it would be
> more
> appropriate to say that this is a pointer to an array containing base
> offsets (etc).
> 

ok, I will modify it.

BRs,
Rex

> Thanks,
> Angelo
> 
> >    * @rst_bank_nr: Quantity of reset bank.
> >    */
> >   struct mtk_clk_rst_desc {
> >   	u8 version;
> > -	u16 reg_ofs;
> > +	u16 *rst_bank_ofs;
> >   	u32 rst_bank_nr;
> >   };
> >   

