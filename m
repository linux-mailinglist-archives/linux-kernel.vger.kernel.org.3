Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98285259DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376584AbiEMC5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbiEMC5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:57:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108175C65F;
        Thu, 12 May 2022 19:57:35 -0700 (PDT)
X-UUID: 3ce5783ff0eb46f5b142587f0d56baed-20220513
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:98ea1677-814b-4f40-935e-ac0c7155e5a8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:79590df2-ab23-4aed-a67b-f96514452486,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 3ce5783ff0eb46f5b142587f0d56baed-20220513
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 299920624; Fri, 13 May 2022 10:57:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 13 May 2022 10:57:24 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 May 2022 10:57:22 +0800
Message-ID: <875b24355315311db3a0c846be5f553b3d0c7498.camel@mediatek.com>
Subject: Re: [DKIM] [PATCH v12, 13/17] media: mediatek: vcodec: Extract H264
 common code
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Tomasz Figa" <tfiga@google.com>
CC:     Irui Wang <irui.wang@mediatek.com>,
        George Sun <george.sun@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
Date:   Fri, 13 May 2022 10:57:22 +0800
In-Reply-To: <03e09da3-c068-a372-a3e5-dc0459f90682@xs4all.nl>
References: <20220512021950.29087-1-yunfei.dong@mediatek.com>
         <20220512021950.29087-14-yunfei.dong@mediatek.com>
         <03e09da3-c068-a372-a3e5-dc0459f90682@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans,

Thanks for your suggestion.
On Thu, 2022-05-12 at 11:31 +0200, Hans Verkuil wrote:
> Hi Yunfei,
> 
> On 5/12/22 04:19, Yunfei Dong wrote:
> > Mt8192 can use some of common code with mt8183. Moves them to
> > a new file in order to reuse.
> > 
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> >  .../media/platform/mediatek/vcodec/Makefile   |   1 +
> >  .../vcodec/vdec/vdec_h264_req_common.c        | 310 +++++++++++++
> >  .../vcodec/vdec/vdec_h264_req_common.h        | 274 +++++++++++
> >  .../mediatek/vcodec/vdec/vdec_h264_req_if.c   | 427 ++----------
> > ------
> >  4 files changed, 629 insertions(+), 383 deletions(-)
> >  create mode 100644
> > drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
> >  create mode 100644
> > drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
> > 
> > diff --git a/drivers/media/platform/mediatek/vcodec/Makefile
> > b/drivers/media/platform/mediatek/vcodec/Makefile
> > index 359619653a0e..3f41d748eee5 100644
> > --- a/drivers/media/platform/mediatek/vcodec/Makefile
> > +++ b/drivers/media/platform/mediatek/vcodec/Makefile
> > @@ -9,6 +9,7 @@ mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
> >  		vdec/vdec_vp8_if.o \
> >  		vdec/vdec_vp9_if.o \
> >  		vdec/vdec_h264_req_if.o \
> > +		vdec/vdec_h264_req_common.o \
> >  		mtk_vcodec_dec_drv.o \
> >  		vdec_drv_if.o \
> >  		vdec_vpu_if.o \
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.
> > c
> > b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.
> > c
> > new file mode 100644
> > index 000000000000..4e7c9d47751d
> > --- /dev/null
> > +++
> > b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.
> > c
> > @@ -0,0 +1,310 @@
> 
> <snip>
> 
> Here there is still a cast to iomem:
> 
> > +void mtk_vdec_h264_copy_scaling_matrix(struct
> > slice_api_h264_scaling_matrix *dst_matrix,
> > +				       const struct
> > v4l2_ctrl_h264_scaling_matrix *src_matrix)
> > +{
> > +	memcpy_toio((void __iomem *)dst_matrix->scaling_list_4x4,
> > src_matrix->scaling_list_4x4,
> > +		    sizeof(dst_matrix->scaling_list_4x4));
> > +
> > +	memcpy_toio((void __iomem *)dst_matrix->scaling_list_8x8,
> > src_matrix->scaling_list_8x8,
> > +		    sizeof(dst_matrix->scaling_list_8x8));
> > +}
> 
> <snip>
> 
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> > b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> > index 27119aa31dd9..b055ceea481d 100644
> > ---
> > a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> > +++
> > b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> 
> <snip>
> 
> > -static void
> > -get_h264_scaling_matrix(struct slice_api_h264_scaling_matrix
> > *dst_matrix,
> > -			const struct v4l2_ctrl_h264_scaling_matrix
> > *src_matrix)
> > -{
> > -	memcpy(dst_matrix->scaling_list_4x4, src_matrix-
> > >scaling_list_4x4,
> > -	       sizeof(dst_matrix->scaling_list_4x4));
> > -
> > -	memcpy(dst_matrix->scaling_list_8x8, src_matrix-
> > >scaling_list_8x8,
> > -	       sizeof(dst_matrix->scaling_list_8x8));
> > -}
> 
> but that function was moved (AFAICT) from vdec_h264_req_if.c where a
> regular memcpy was
> used.
> 
> Did you miss one iomem case?
> 
> Can I change mtk_vdec_h264_copy_scaling_matrix() to:
> 
> void mtk_vdec_h264_copy_scaling_matrix(struct
> slice_api_h264_scaling_matrix *dst_matrix,
> 				       const struct
> v4l2_ctrl_h264_scaling_matrix *src_matrix)
> {
> 	memcpy(dst_matrix->scaling_list_4x4, src_matrix-
> >scaling_list_4x4,
> 	       sizeof(dst_matrix->scaling_list_4x4));
> 
> 	memcpy(dst_matrix->scaling_list_8x8, src_matrix-
> >scaling_list_8x8,
> 	       sizeof(dst_matrix->scaling_list_8x8));
> }
> 
> If that's OK, then I'll do that manually, so no need to post a v13.
> 
> Everything else looks fine, so this is the only issue that needs to
> be resolved.
> 
> Regards,
> 
1: For h264_req_if.c no need to add __iomem anymore. You can help to
change it directly.

2: Could you please help to add for whole series: Tested-by: Nícolas F.
R. A. Prado <nfraprado@collabora.com>

according to Nicolas's mail.

Hi Yunfei,

With this series, and the new scp.img for mt8192 [1] (still waiting to
get
merged), I was able to get the following fluster scores on
mt8192-asurada-spherion:

VP8: 59/61
VP9: 249/303
H.264: 92/135

So for the whole series:

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> 	Hans
> 
Best Regards,
Yunfei Dong
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

