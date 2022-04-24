Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2231650D08C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 10:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiDXIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiDXIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:52:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D971773F1;
        Sun, 24 Apr 2022 01:49:01 -0700 (PDT)
X-UUID: 58c3337572634859b511d0737ffff2b5-20220424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:4471379d-6c90-4a20-9a38-c1f0b68a0825,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:e0b9bcf0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 58c3337572634859b511d0737ffff2b5-20220424
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 605543717; Sun, 24 Apr 2022 16:48:56 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 24 Apr 2022 16:48:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 24 Apr
 2022 16:48:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 24 Apr 2022 16:48:54 +0800
Message-ID: <a0b90deb9d30fe331493f5fbe8e67a97b698fe49.camel@mediatek.com>
Subject: Re: [PATCH v20 2/8] soc: mediatek: add mtk-mutex support for mt8195
 vdosys0
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Sun, 24 Apr 2022 16:48:54 +0800
In-Reply-To: <074d8c26-3fb7-bee1-d559-7ce96f583fee@gmail.com>
References: <20220419094143.9561-1-jason-jh.lin@mediatek.com>
         <20220419094143.9561-3-jason-jh.lin@mediatek.com>
         <82cc5e6900138e13ed9d75c6d2a42c6d7afc1959.camel@mediatek.com>
         <c3de9ccb314316b5296b115dd3e9f8171577489f.camel@mediatek.com>
         <074d8c26-3fb7-bee1-d559-7ce96f583fee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thanks for the reviews.

On Fri, 2022-04-22 at 14:31 +0200, Matthias Brugger wrote:
> 
> On 22/04/2022 04:32, Jason-JH Lin wrote:
> > Hi CK,
> > 
> > Thanks for the reviews.
> > 
> > On Thu, 2022-04-21 at 14:50 +0800, CK Hu wrote:
> > > Hi, Jason:
> > > 
> > > On Tue, 2022-04-19 at 17:41 +0800, jason-jh.lin wrote:
> > > > Add mtk-mutex support for mt8195 vdosys0.
> > > > 
> > > > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > > > Acked-by: AngeloGioacchino Del Regno <
> > > > angelogioacchino.delregno@collabora.com>
> > > > Tested-by: Fei Shao <fshao@chromium.org>
> > > > ---
> > > >   drivers/soc/mediatek/mtk-mutex.c | 87
> > > > ++++++++++++++++++++++++++++++--
> > > >   1 file changed, 84 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/soc/mediatek/mtk-mutex.c
> > > > b/drivers/soc/mediatek/mtk-mutex.c
> > > > index aaf8fc1abb43..729ee88035ed 100644
> > > > --- a/drivers/soc/mediatek/mtk-mutex.c
> > > > +++ b/drivers/soc/mediatek/mtk-mutex.c
> > > > @@ -17,6 +17,9 @@
> > > >   #define MT8183_MUTEX0_MOD0			0x30
> > > >   #define MT8183_MUTEX0_SOF0			0x2c
> > > >   
> > > > +#define MT8195_DISP_MUTEX0_MOD0			0x30
> > > > +#define MT8195_DISP_MUTEX0_SOF			0x2c
> > > 
> > > This is identical to mt8183, so use mt8183 one instead of
> > > creating
> > > new
> > > one.
> > > 
> > > Regards,
> > > CK
> > > 
> > 
> > I'll fix this in the next version.
> 
> Please send this as a follow-up fix on top of:
> 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.18-next*soc__;Lw!!CTRNKA9wMg0ARbw!0QzNDaejnt54R86SL628fJ9p2BKTOmYBnoz6uPz9X8WsHXeQi3rqPAXmPFRBcw1vEtUu$
>  
> 
> Regards,
> Matthias
> 
OK, I'll send the fix-up patch soon.

Regards,
Jason-JH.Lin

> > 
> > Regards,
> > Jason-JH.Lin.
> > > > 
> > > >   
> > > > +static const struct mtk_mutex_data mt8195_mutex_driver_data =
> > > > {
> > > > +	.mutex_mod = mt8195_mutex_mod,
> > > > +	.mutex_sof = mt8195_mutex_sof,
> > > > +	.mutex_mod_reg = MT8195_DISP_MUTEX0_MOD0,
> > > > +	.mutex_sof_reg = MT8195_DISP_MUTEX0_SOF,
> > > > +};
> > > > +
> > > >   
> > > 
> > > 
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

