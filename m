Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E5F530896
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355557AbiEWFKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354800AbiEWFKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:10:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D01CB3E;
        Sun, 22 May 2022 22:10:29 -0700 (PDT)
X-UUID: ffc78b5fa16d42acb026987f6f69902f-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:4c192c35-0dbe-4a1c-89e0-1983061c566c,OB:20,L
        OB:30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:4c192c35-0dbe-4a1c-89e0-1983061c566c,OB:20,LOB
        :30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:b9712ce3-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:c4fd7da82419,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: ffc78b5fa16d42acb026987f6f69902f-20220523
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 335405418; Mon, 23 May 2022 13:10:24 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 13:10:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 May 2022 13:10:23 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 May 2022 13:10:23 +0800
Message-ID: <197adcf4e702e0ff5fab0fe07019c6535d90cb47.camel@mediatek.com>
Subject: Re: [PATCH v7 07/19] clk: mediatek: reset: Support nonsequence base
 offsets of reset registers
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
Date:   Mon, 23 May 2022 13:10:23 +0800
In-Reply-To: <20220520151854.kkr2tezmrfniks4j@notapiano>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
         <20220519125527.18544-8-rex-bc.chen@mediatek.com>
         <20220520151854.kkr2tezmrfniks4j@notapiano>
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

On Fri, 2022-05-20 at 11:18 -0400, Nícolas F. R. A. Prado wrote:
> Hi Rex,
> 
> On Thu, May 19, 2022 at 08:55:15PM +0800, Rex-BC Chen wrote:
> > The bank offsets are not serial for all reset registers.
> > For example, there are five infra reset banks for MT8192: 0x120,
> > 0x130,
> > 0x140, 0x150 and 0x730.
> > 
> > To support this,
> > - Change reg_ofs to rst_bank_ofs which is a pointer to base offsets
> > of
> >   the reset register.
> > - Add a new define RST_NR_PER_BANK to define reset number for each
> >   reset bank.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> 
> <snip>
> 
> > diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c
> > b/drivers/clk/mediatek/clk-mt2701-g3d.c
> > index 9cfd589939e5..5cbc5c42204d 100644
> > --- a/drivers/clk/mediatek/clk-mt2701-g3d.c
> > +++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
> > @@ -35,10 +35,12 @@ static const struct mtk_gate g3d_clks[] = {
> >  	GATE_G3D(CLK_G3DSYS_CORE, "g3d_core", "mfg_sel", 0),
> >  };
> >  
> > +static u16 rst_ofs[] = { 0xC, };
> 
> Very nitpicky, but you could have left the hex lowercase '0xc'.
> 
> Thanks,
> Nícolas

Hello Nícolas,

ok, I will modify it in next version.

BRs,
Rex

