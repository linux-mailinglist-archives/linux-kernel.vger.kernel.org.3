Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7A151D451
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390494AbiEFJ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390476AbiEFJ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:29:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E8915A09;
        Fri,  6 May 2022 02:25:24 -0700 (PDT)
X-UUID: 688f16e3e7ce450caa638f2f752d7331-20220506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:ae87eca7-1d53-429e-b0c1-b7b473cea55d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:54
X-CID-INFO: VERSION:1.1.4,REQID:ae87eca7-1d53-429e-b0c1-b7b473cea55d,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_HamU,ACTI
        ON:release,TS:54
X-CID-META: VersionHash:faefae9,CLOUDID:3aced3b2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:adb1611c2d41,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 688f16e3e7ce450caa638f2f752d7331-20220506
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 911729712; Fri, 06 May 2022 17:25:20 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 6 May 2022 17:25:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 May 2022 17:25:18 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 May 2022 17:25:17 +0800
Message-ID: <18560bd9efbcf77bc6b2dc6d2956d7993fcdde85.camel@mediatek.com>
Subject: Re: [PATCH v10, 16/17] media: mediatek: vcodec: support stateless
 VP9 decoding
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 6 May 2022 17:25:17 +0800
In-Reply-To: <20220505222034.fxw6y7wdf7wy3qi4@notapiano>
References: <20220426100828.13429-1-yunfei.dong@mediatek.com>
         <20220426100828.13429-17-yunfei.dong@mediatek.com>
         <20220505222034.fxw6y7wdf7wy3qi4@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thanks for your suggestion.

On Thu, 2022-05-05 at 18:20 -0400, Nícolas F. R. A. Prado wrote:
> On Tue, Apr 26, 2022 at 06:08:27PM +0800, Yunfei Dong wrote:
> > Add support for VP9 decoding using the stateless API,
> > as supported by MT8192. And the drivers is lat and core
> > architecture.
> > 
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > Signed-off-by: George Sun <george.sun@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  .../media/platform/mediatek/vcodec/Makefile   |    1 +
> >  .../vcodec/mtk_vcodec_dec_stateless.c         |   26 +-
> >  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |    1 +
> >  .../vcodec/vdec/vdec_vp9_req_lat_if.c         | 2031
> > +++++++++++++++++
> >  .../platform/mediatek/vcodec/vdec_drv_if.c    |    4 +
> >  .../platform/mediatek/vcodec/vdec_drv_if.h    |    1 +
> >  6 files changed, 2061 insertions(+), 3 deletions(-)
> >  create mode 100644
> > drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> > 
> 
> ...
> 
> > +		use_128 = !frame_is_intra && !vsi-
> > >frame.uh.last_frame_type;
> > +		v4l2_vp9_adapt_coef_probs(pre_frame_ctx_helper,
> > +					  counts_helper,
> > +					  use_128,
> > +					  frame_is_intra);
> 
> Hi Yunfei,
> 
> I'm getting
> 
> ERROR: modpost: "v4l2_vp9_adapt_noncoef_probs"
> [drivers/media/platform/mediatek/vcodec/mtk-vcodec-dec.ko] undefined!
> ERROR: modpost: "v4l2_vp9_adapt_coef_probs"
> [drivers/media/platform/mediatek/vcodec/mtk-vcodec-dec.ko] undefined!
> 
> when building this series.
> 
> Adding
> 	select V4L2_VP9
> to
> 	config VIDEO_MEDIATEK_VCODEC
> solved the issue.
> 
> Thanks,
> Nícolas
I will fix it in next patch

Best Regards,
Yunfei Dong

