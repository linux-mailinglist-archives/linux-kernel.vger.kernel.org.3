Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6352B982
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiERMHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiERMHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:07:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEFDAF1D4;
        Wed, 18 May 2022 05:06:56 -0700 (PDT)
X-UUID: 19150da488a94fdab41ab2d65bdac7cb-20220518
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:cd629019-1e6a-4897-aec4-87e755b2b50b,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:cd629019-1e6a-4897-aec4-87e755b2b50b,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:feb5a6e2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:65e73d4f7736,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 19150da488a94fdab41ab2d65bdac7cb-20220518
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1917153530; Wed, 18 May 2022 20:06:51 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 18 May 2022 20:06:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 May 2022 20:06:49 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 May 2022 20:06:48 +0800
Message-ID: <d101876a72e6248c77ee5de0d1dc52687e225629.camel@mediatek.com>
Subject: Re: [PATCH v6, 6/7] media: mediatek: vcodec: prevent kernel crash
 when scp ipi timeout
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
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 18 May 2022 20:06:48 +0800
In-Reply-To: <31992c67-400e-8e14-38c2-4655995886f5@xs4all.nl>
References: <20220513092526.9670-1-yunfei.dong@mediatek.com>
         <20220513092526.9670-7-yunfei.dong@mediatek.com>
         <ea9a04fb-368d-daca-96ae-9366253a5e91@xs4all.nl>
         <f26d5225fc8c499226c297ed86feb5ee20e8f3d3.camel@mediatek.com>
         <31992c67-400e-8e14-38c2-4655995886f5@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans,

Thanks for your suggestion.

On Wed, 2022-05-18 at 13:34 +0200, Hans Verkuil wrote:
> 
> On 5/18/22 13:29, yunfei.dong@mediatek.com wrote:
> > Dear Hans,
> > 
> > Thanks for your review.
> > On Wed, 2022-05-18 at 11:37 +0200, Hans Verkuil wrote:
> > > Hi Yunfei,
> > > 
> > > On 5/13/22 11:25, Yunfei Dong wrote:
> > > > When SCP timeout during playing video, kernel crashes with
> > > > following
> > > > message. It's caused by accessing NULL pointer in
> > > > vpu_dec_ipi_handler.
> > > > This patch doesn't solve the root cause of NULL pointer, but
> > > > merely
> > > > prevent kernel crashed when encounter the NULL pointer.
> > > 
> > > Is the root cause being addressed as well? Where is the root
> > > cause?
> > > Is it
> > > in this driver or in the scp (i.e. the remoteproc) driver?
> > > 
> > > I need a bit more information to decide whether this series is
> > > ready
> > > to
> > > be merged for 5.20 or not.
> > > 
> > > Regards,
> > > 
> > > 	Hans
> > > 
> > 
> > Vpu will be NUll when scp(micro processor) is hang or crash. Need
> > to
> > keep kernel works well , so add this patch.
> 
> OK, I think this should be stated in the commit log, and also in the
> code
> (see below).
> 
> > 
> > Best Regards,
> > Yunfei Dong
> 
> <snip>
> 
> > > > diff --git
> > > > a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> > > > b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> > > > index 35f4d5583084..1041dd663e76 100644
> > > > --- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> > > > +++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> > > > @@ -91,6 +91,11 @@ static void vpu_dec_ipi_handler(void *data,
> > > > unsigned int len, void *priv)
> > > >  	struct vdec_vpu_inst *vpu = (struct vdec_vpu_inst *)
> > > >  					(unsigned long)msg-
> > > > > ap_inst_addr;
> > > > 
> > > >  
> > > > +	if (!vpu) {
> > > > +		mtk_v4l2_err("ap_inst_addr is NULL");
> 
> E.g., either add a comment here or perhaps change the error message
> to:
> 
> "ap_inst_addr is NULL, did the SCP hang?"
> 
> Or something along those lines.
> 
I will change the message in next patch like below.

mtk_v4l2_err("ap_inst_addr is NULL, did the SCP hang or crash?");

> Shouldn't there be a \n at the end of this message as well? Or does
> mtk_v4l2_err add that?
> 
mtk_v4l2_err add '\n' in the end.
> Regards,
> 
> 	Hans
> 
Best Regards,
Yunfei Dong
> > > > +		return;
> > > > +	}
> > > > +
> > > >  	mtk_vcodec_debug(vpu, "+ id=%X", msg->msg_id);
> > > >  
> > > >  	vpu->failure = msg->status;

