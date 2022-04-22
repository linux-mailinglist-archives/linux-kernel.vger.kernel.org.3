Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5048650AF50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444043AbiDVFHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiDVFHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:07:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FE34925D;
        Thu, 21 Apr 2022 22:04:16 -0700 (PDT)
X-UUID: c81f797a5d74416db738f62029d4d5b1-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:aac68887-afca-457c-9930-db042984edd0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:2
X-CID-META: VersionHash:faefae9,CLOUDID:caa290f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:4,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: c81f797a5d74416db738f62029d4d5b1-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1505559958; Fri, 22 Apr 2022 13:04:12 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 22 Apr 2022 13:04:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 13:04:11 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 13:04:11 +0800
Message-ID: <aa9ae5783f5fb7965e055031984b430c47016b7f.camel@mediatek.com>
Subject: Re: [PATCH V2 06/12] clk: mediatek: reset: Revise structure to
 control reset register
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
Date:   Fri, 22 Apr 2022 13:04:11 +0800
In-Reply-To: <801c6a22-1772-2673-1fcf-5cfed54efab1@collabora.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
         <20220420130527.23200-7-rex-bc.chen@mediatek.com>
         <801c6a22-1772-2673-1fcf-5cfed54efab1@collabora.com>
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
> > Add mtk_clk_rst_desc to input the reset register data, and replace
> > the
> > structure "struct mtk_reset" to reset.h, and rename it as
> > "mtk_clk_rst_data". We use them to store reset register data and
> > store reset controller device.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >   drivers/clk/mediatek/clk-mt2701-eth.c |  8 +++++-
> >   drivers/clk/mediatek/clk-mt2701-g3d.c |  8 +++++-
> >   drivers/clk/mediatek/clk-mt2701-hif.c |  8 +++++-
> >   drivers/clk/mediatek/clk-mt2701.c     | 19 ++++++++++++--
> >   drivers/clk/mediatek/clk-mt2712.c     | 19 ++++++++++++--
> >   drivers/clk/mediatek/clk-mt7622-eth.c |  8 +++++-
> >   drivers/clk/mediatek/clk-mt7622-hif.c | 10 ++++++--
> >   drivers/clk/mediatek/clk-mt7622.c     | 19 ++++++++++++--
> >   drivers/clk/mediatek/clk-mt7629-eth.c |  8 +++++-
> >   drivers/clk/mediatek/clk-mt7629-hif.c | 10 ++++++--
> >   drivers/clk/mediatek/clk-mt8135.c     | 19 ++++++++++++--
> >   drivers/clk/mediatek/clk-mt8173.c     | 19 ++++++++++++--
> >   drivers/clk/mediatek/clk-mt8183.c     |  9 +++++--
> >   drivers/clk/mediatek/reset.c          | 36 +++++++++++++---------
> > -----
> >   drivers/clk/mediatek/reset.h          | 15 ++++++++++-
> >   15 files changed, 174 insertions(+), 41 deletions(-)
> > 
> 
> ..snip..
> 
> > diff --git a/drivers/clk/mediatek/reset.c
> > b/drivers/clk/mediatek/reset.c
> > index 8e42deee80a3..d67c13958458 100644
> > --- a/drivers/clk/mediatek/reset.c
> > +++ b/drivers/clk/mediatek/reset.c
> > @@ -14,25 +14,19 @@
> >   
> >   #include "clk-mtk.h"
> >   
> > -struct mtk_reset {
> > -	struct regmap *regmap;
> > -	int regofs;
> > -	struct reset_controller_dev rcdev;
> > -};
> > -
> > -static inline struct mtk_reset *to_rst_data(struct
> > reset_controller_dev *rcdev)
> > +static inline struct mtk_clk_rst_data *to_rst_data(struct
> > reset_controller_dev *rcdev)
> >   {
> 
> to_mtk_clk_rst_data()...
> by the way, it's probably better if you introduce this helper here
> directly,
> instead of introducing it in commit 03/12 and changing it entirely in
> 06/12.
> 
> The rest of the code looks good to me, I'm sure that you'll get my R-
> b in the
> next version.
> 

Hello Angelo,

I will do this in next version.
Thanks!

BRs,
Rex

