Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C494ED161
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 03:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352335AbiCaBqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 21:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiCaBq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:46:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045AE483AD;
        Wed, 30 Mar 2022 18:44:38 -0700 (PDT)
X-UUID: ca2ca1f7ce0641319e9e23fe5e4d21e9-20220331
X-UUID: ca2ca1f7ce0641319e9e23fe5e4d21e9-20220331
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 800871722; Thu, 31 Mar 2022 09:44:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 31 Mar 2022 09:44:30 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 31 Mar 2022 09:44:30 +0800
Message-ID: <524f93ebeaa9c2ad74b0f5dbb2703afa4c8e0bac.camel@mediatek.com>
Subject: Re: [PATCH v16 5/8] soc: mediatek: add mtk-mutex support for mt8195
 vdosys0
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <hsinyi@chromium.org>, <fshao@chromium.org>,
        <moudy.ho@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 31 Mar 2022 09:44:30 +0800
In-Reply-To: <72e5b8ed21a796f6f756b0ee42b363c158f18cd3.camel@mediatek.com>
References: <20220307032859.3275-1-jason-jh.lin@mediatek.com>
         <20220307032859.3275-6-jason-jh.lin@mediatek.com>
         <72e5b8ed21a796f6f756b0ee42b363c158f18cd3.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,

Thanks for the reviews.

On Fri, 2022-03-18 at 15:21 +0800, CK Hu wrote:
> Hi, Jason:
> 
> On Mon, 2022-03-07 at 11:28 +0800, jason-jh.lin wrote:
> > Add mtk-mutex support for mt8195 vdosys0.
> > 
> > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > Acked-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/soc/mediatek/mtk-mutex.c | 103
> > ++++++++++++++++++++++++++++++-
> >  1 file changed, 100 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-mutex.c
> > b/drivers/soc/mediatek/mtk-mutex.c
> > index aaf8fc1abb43..1c7ffcdadcea 100644
> > --- a/drivers/soc/mediatek/mtk-mutex.c
> > +++ b/drivers/soc/mediatek/mtk-mutex.c
> > @@ -17,6 +17,9 @@
> >  #define MT8183_MUTEX0_MOD0			0x30
> >  #define MT8183_MUTEX0_SOF0			0x2c
> >  
> > +#define MT8195_DISP_MUTEX0_MOD0			0x30
> > +#define MT8195_DISP_MUTEX0_SOF			0x2c
> > +
> >  #define DISP_REG_MUTEX_EN(n)			(0x20 + 0x20 *
> > (n))
> >  #define DISP_REG_MUTEX(n)			(0x24 + 0x20 * (n))
> >  #define DISP_REG_MUTEX_RST(n)			(0x28 + 0x20 *
> > (n))
> > @@ -96,6 +99,36 @@
> >  #define MT8173_MUTEX_MOD_DISP_PWM1		24
> >  #define MT8173_MUTEX_MOD_DISP_OD		25
> >  

[snip]

> > > +#define MT8195_MUTEX_MOD_DISP_VPP_MERGE		20
> > > +#define MT8195_MUTEX_MOD_DISP_DP_INTF0		21
> > > +#define MT8195_MUTEX_MOD_DISP_VPP1_DL_RELAY0	22
> > > 
> > > Useless, remove.
> > > 
> > > > +#define MT8195_MUTEX_MOD_DISP_VPP1_DL_RELAY1	23
> > > 
> > > Ditto.
> > > 
> > > Regards,
> > > CK
> > 
> > Although these definitions are not used, they represent the
> > functionality provided by this register.
> > 
> > I think we can show that we have these capabilities by defining
> them.
> > 
> > Can we keep these definitions?
> 
> OK, but add some information that we could know how to use it. What's
> these DL_RELAY and when should we add these to mutex?
> 
> Regards,
> CK

DL_RELAY is used for the cross mmsys mux settings.
We won't use these setting currently, so I think
I just remove these useless define.

Thanks.

Regards,
Jason-JH.Lin


[snip]

-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

