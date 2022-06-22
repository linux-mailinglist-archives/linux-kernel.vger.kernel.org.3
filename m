Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B223E554035
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355830AbiFVBow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355750AbiFVBon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:44:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7205630546;
        Tue, 21 Jun 2022 18:44:42 -0700 (PDT)
X-UUID: 71deec2e79434e01958a2c632e2a0c65-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:7a8acf2d-bd8e-4dee-8cb7-d2e9845682c0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:40
X-CID-INFO: VERSION:1.1.6,REQID:7a8acf2d-bd8e-4dee-8cb7-d2e9845682c0,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:40
X-CID-META: VersionHash:b14ad71,CLOUDID:da0428ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:8cd89d9b3457,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 71deec2e79434e01958a2c632e2a0c65-20220622
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 592251373; Wed, 22 Jun 2022 09:44:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 09:44:33 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 22 Jun 2022 09:44:32 +0800
Message-ID: <be1069684f0482984234fb4e8509615dca2e602a.camel@mediatek.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Initialize decoder parameters
 after getting dec_capability
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Tomasz Figa" <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Fritz Koenig" <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 22 Jun 2022 09:44:32 +0800
In-Reply-To: <320bf3dd2bef0afec794d610b446d0085dcfe362.camel@ndufresne.ca>
References: <20220618072929.28783-1-yunfei.dong@mediatek.com>
         <320bf3dd2bef0afec794d610b446d0085dcfe362.camel@ndufresne.ca>
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

Hi Nicolas,

Thanks for your comments.

I already sent patch v2 to add fixes table in June 20.

Best Regards,
Yunfei Dong
On Tue, 2022-06-21 at 10:20 -0400, Nicolas Dufresne wrote:
> Hi Yunfei,
> 
> Le samedi 18 juin 2022 à 15:29 +0800, Yunfei Dong a écrit :
> > Need to get dec_capability from scp first, then initialize decoder
> > supported format and other parameters according to dec_capability
> > value.
> 
> Perhaps something to improve in the future. On top of describing the
> fix, it
> could be useful to describe what issues is being fixed, and which
> platform will
> benefit.
> 
> > 
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> 
> To add to this, this looks like a bug fix, can you relate it to an
> original
> commit and add a Fixes: tag here ?
> 
> regards,
> Nicolas
> 
> > ---
> >  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c     | 2 --
> >  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 2 ++
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > index 1465ddff1c6b..41589470da32 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > @@ -112,8 +112,6 @@ void mtk_vcodec_dec_set_default_params(struct
> > mtk_vcodec_ctx *ctx)
> >  {
> >  	struct mtk_q_data *q_data;
> >  
> > -	ctx->dev->vdec_pdata->init_vdec_params(ctx);
> > -
> >  	ctx->m2m_ctx->q_lock = &ctx->dev->dev_mutex;
> >  	ctx->fh.m2m_ctx = ctx->m2m_ctx;
> >  	ctx->fh.ctrl_handler = &ctx->ctrl_hdl;
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> > index 4103d7c1b638..99d7b15f2b9d 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> > @@ -208,6 +208,8 @@ static int fops_vcodec_open(struct file *file)
> >  
> >  		dev->dec_capability =
> >  			mtk_vcodec_fw_get_vdec_capa(dev->fw_handler);
> > +		ctx->dev->vdec_pdata->init_vdec_params(ctx);
> > +
> >  		mtk_v4l2_debug(0, "decoder capability %x", dev-
> > >dec_capability);
> >  	}
> >  
> 
> 

