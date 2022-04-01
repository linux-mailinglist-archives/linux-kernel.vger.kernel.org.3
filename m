Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE794EE9BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbiDAIaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDAI37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:29:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CD424B5D4;
        Fri,  1 Apr 2022 01:28:06 -0700 (PDT)
X-UUID: f63152e4361742fda2355397c663cf3d-20220401
X-UUID: f63152e4361742fda2355397c663cf3d-20220401
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1068890426; Fri, 01 Apr 2022 16:28:01 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 1 Apr 2022 16:27:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 1 Apr
 2022 16:27:58 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Apr 2022 16:27:57 +0800
Message-ID: <61b8e1e7e53a0d560b0e0a4107c63922190e7cec.camel@mediatek.com>
Subject: Re: [PATCH] media: mediatek: vcodec: fix v4l2 compliance decoder
 cmd test fail
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Benjamin Gaignard" <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Fritz Koenig" <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        "Steve Cho" <stevecho@chromium.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 1 Apr 2022 16:27:57 +0800
In-Reply-To: <38c9685e-380e-87ce-4a3a-5d274c0892fa@collabora.com>
References: <20220401030406.6437-1-yunfei.dong@mediatek.com>
         <38c9685e-380e-87ce-4a3a-5d274c0892fa@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Thanks for your suggestion.

On Fri, 2022-04-01 at 09:50 +0200, AngeloGioacchino Del Regno wrote:
> Il 01/04/22 05:04, Yunfei Dong ha scritto:
> > Will return -EINVAL using standard framework api when test
> > stateless
> > decoder with cmd VIDIOC_(TRY)DECODER_CMD.
> > 
> > Using another return value to adjust v4l2 compliance test for user
> > driver(GStreamer/Chrome) won't use decode cmd.
> > 
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> 
> Hello Yunfei,
> 
> this patch is a fix.. hence, this needs an appropriate Fixes: tag.
> Please add one.
> 
Add "Fixes: " in patch v2.
> Thanks,
> Angelo
> 
Thanks,
Yunfei Dong
> > ---
> >   drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > index 3859e4c651c6..69b0e797d342 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > @@ -51,8 +51,7 @@ static int vidioc_try_decoder_cmd(struct file
> > *file, void *priv,
> >   
> >   	/* Use M2M stateless helper if relevant */
> >   	if (ctx->dev->vdec_pdata->uses_stateless_api)
> > -		return v4l2_m2m_ioctl_stateless_try_decoder_cmd(file,
> > priv,
> > -								cmd);
> > +		return -ENOTTY;
> >   	else
> >   		return v4l2_m2m_ioctl_try_decoder_cmd(file, priv, cmd);
> >   }

