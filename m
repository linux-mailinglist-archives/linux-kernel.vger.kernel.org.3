Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3815B50AF4A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444023AbiDVFDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiDVFDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:03:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207EA48E63;
        Thu, 21 Apr 2022 22:00:43 -0700 (PDT)
X-UUID: e63f8a270946463b8bee1185845cbf92-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:f266f48a-3a5f-41b1-97e5-8d5c82e14438,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:47
X-CID-INFO: VERSION:1.1.4,REQID:f266f48a-3a5f-41b1-97e5-8d5c82e14438,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:47
X-CID-META: VersionHash:faefae9,CLOUDID:e78690f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:4,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: e63f8a270946463b8bee1185845cbf92-20220422
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1450099664; Fri, 22 Apr 2022 13:00:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 13:00:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 13:00:38 +0800
Message-ID: <b185812f94da4cef829c7e2a93c6419568196af4.camel@mediatek.com>
Subject: Re: [PATCH V2 03/12] clk: mediatek: reset: Refine functions of
 set_clr
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
Date:   Fri, 22 Apr 2022 13:00:38 +0800
In-Reply-To: <d833bb7f-ee48-602d-9793-5d717d3b5582@collabora.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
         <20220420130527.23200-4-rex-bc.chen@mediatek.com>
         <d833bb7f-ee48-602d-9793-5d717d3b5582@collabora.com>
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
> > To make driver more readable, revise functions of set_clr.
> > - Add to_rst_data().
> > - Extract common code within assert and deassert to
> >    mtk_reset_update_set_clr().
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >   drivers/clk/mediatek/reset.c | 32 +++++++++++++++++++++--------
> > ---
> >   1 file changed, 21 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/clk/mediatek/reset.c
> > b/drivers/clk/mediatek/reset.c
> > index 9110d0b4229f..6574b19daf0f 100644
> > --- a/drivers/clk/mediatek/reset.c
> > +++ b/drivers/clk/mediatek/reset.c
> > @@ -20,26 +20,36 @@ struct mtk_reset {
> >   	struct reset_controller_dev rcdev;
> >   };
> >   
> > -static int mtk_reset_assert_set_clr(struct reset_controller_dev
> > *rcdev,
> > -	unsigned long id)
> > +static inline struct mtk_reset *to_rst_data(struct
> > reset_controller_dev *rcdev)
> 
> to_mtk_reset() looks more consistent, as many developers are using
> the naming
> "to_{struct_name}".

Hello Angelo,

ok, I will fix this in next version.

> 
> Also, can you please mention the indentation fixes in the commit
> description?
> 

I add another refinement patch in next version.

BRs,
Rex

> Thanks,
> Angelo
> 

