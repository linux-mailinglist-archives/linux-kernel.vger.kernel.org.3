Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B81F50AEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 05:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443833AbiDVEBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDVEBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:01:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AD84E3A7;
        Thu, 21 Apr 2022 20:58:41 -0700 (PDT)
X-UUID: a16b5bc0407b40ec8c56e6d5a17aecfc-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:28b2e4a0-a850-4a01-96e1-b159076f3c24,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:6,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:6
X-CID-META: VersionHash:faefae9,CLOUDID:4ca58ef0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:4,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: a16b5bc0407b40ec8c56e6d5a17aecfc-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1221863590; Fri, 22 Apr 2022 11:58:37 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 22 Apr 2022 11:58:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 11:58:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 11:58:36 +0800
Message-ID: <496c00b0225e8e2ce567225b94e1ce0f3ab8096d.camel@mediatek.com>
Subject: Re: [PATCH V2 02/12] clk: mediatek: reset: Use simple reset
 operations
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <runyang.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <allen-kh.cheng@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 22 Apr 2022 11:58:36 +0800
In-Reply-To: <CAGXv+5FJBKYoEuazH9broYSM4uOy=e_3O-86tOOQrsp0xH=4wQ@mail.gmail.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
         <20220420130527.23200-3-rex-bc.chen@mediatek.com>
         <CAGXv+5FJBKYoEuazH9broYSM4uOy=e_3O-86tOOQrsp0xH=4wQ@mail.gmail.com>
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

Hello Cehn-Yu,

On Thu, 2022-04-21 at 15:52 +0800, Chen-Yu Tsai wrote:
> On Wed, Apr 20, 2022 at 9:05 PM Rex-BC Chen <rex-bc.chen@mediatek.com
> > wrote:
> > 
> > There are two version for clock reset register control of MediaTek
> > SoCs.
> > The reset operations before MT8183 can use simple reset to cover.
> 
> I would go slightly into more detail, i.e.
> 
>     The old hardware is one bit per reset control, and does not have
>     separate registers for bit set, clear and read-back operations.
> This
>     matches the scheme supported by the simple reset driver. ...
> 
> > Therefore, we replace mtk_reset_ops with reset_simple_ops.
> 
>    ... to remove redundant code.
> 
> The "why" is more important than "what" in commit logs. "What" you
> did
> is already visible in the diff.
> 

Got it, I will modify this in next version.

> > In addition, we also rename mtk_register_reset_controller to
> > mtk_register_reset_controller_simple.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  drivers/clk/mediatek/Kconfig          |  1 +
> >  drivers/clk/mediatek/clk-mt2701-eth.c |  2 +-
> >  drivers/clk/mediatek/clk-mt2701-g3d.c |  2 +-
> >  drivers/clk/mediatek/clk-mt2701-hif.c |  2 +-
> >  drivers/clk/mediatek/clk-mt2701.c     |  4 +--
> >  drivers/clk/mediatek/clk-mt2712.c     |  4 +--
> >  drivers/clk/mediatek/clk-mt7622-eth.c |  2 +-
> >  drivers/clk/mediatek/clk-mt7622-hif.c |  4 +--
> >  drivers/clk/mediatek/clk-mt7622.c     |  4 +--
> >  drivers/clk/mediatek/clk-mt7629-eth.c |  2 +-
> >  drivers/clk/mediatek/clk-mt7629-hif.c |  4 +--
> >  drivers/clk/mediatek/clk-mt8135.c     |  4 +--
> >  drivers/clk/mediatek/clk-mt8173.c     |  4 +--
> >  drivers/clk/mediatek/clk-mtk.h        |  6 ++--
> >  drivers/clk/mediatek/reset.c          | 43 +++------------------
> > ------
> >  15 files changed, 27 insertions(+), 61 deletions(-)
> 
> [...]
> 
> >  void mtk_register_reset_controller_set_clr(struct device_node *np,
> >         unsigned int num_regs, int regofs)
> >  {
> >         mtk_register_reset_controller_common(np, num_regs, regofs,
> > -               &mtk_reset_ops_set_clr);
> > +                                            &mtk_reset_ops_set_clr
> > );
> 
> This change is unrelated and should not be included.
> 
> ChenYu
> 

I add a refinement patch in next version, and I will move this to that
patch.

BRs,
Rex

> 
> >  }
> > 
> >  MODULE_LICENSE("GPL");
> > --
> > 2.18.0
> > 

