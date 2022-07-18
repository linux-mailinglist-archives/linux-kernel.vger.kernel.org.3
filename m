Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC565780D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiGRLe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGRLe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:34:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54FADECA;
        Mon, 18 Jul 2022 04:34:23 -0700 (PDT)
X-UUID: 97de6e35c7034c3999966c78c6b23a80-20220718
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:744aec6b-847c-420c-9334-c55a67eb03c8,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:67aacad7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 97de6e35c7034c3999966c78c6b23a80-20220718
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1844753461; Mon, 18 Jul 2022 19:34:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 18 Jul 2022 19:34:17 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 18 Jul 2022 19:34:16 +0800
Message-ID: <bb7877319b395e764653f14297c130f114799c7e.camel@mediatek.com>
Subject: Re: [PATCH 3/5] media: mediatek: vcodec: Add mt8188 encoder driver
From:   Irui Wang <irui.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
CC:     Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 18 Jul 2022 19:34:16 +0800
In-Reply-To: <98b0edfa-9669-3adb-894d-5d6fce9e2f8f@collabora.com>
References: <20220716093808.29894-1-irui.wang@mediatek.com>
         <20220716093808.29894-4-irui.wang@mediatek.com>
         <98b0edfa-9669-3adb-894d-5d6fce9e2f8f@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Angelo,
On Mon, 2022-07-18 at 11:53 +0200, AngeloGioacchino Del Regno wrote:
> Il 16/07/22 11:38, Irui Wang ha scritto:
> > Add mt8188's compatible "mediatek,mt8188-vcodec-enc".
> > Add mt8188's device private data "mt8188_pdata".
> > Remove platform_get_resource API to get IRQ resoure.
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >   .../mediatek/vcodec/mtk_vcodec_enc_drv.c      | 21 ++++++++++++
> > -------
> >   1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > index 95e8c29ccc65..6b0688b4872d 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > @@ -228,7 +228,6 @@ static int mtk_vcodec_probe(struct
> > platform_device *pdev)
> >   {
> >   	struct mtk_vcodec_dev *dev;
> >   	struct video_device *vfd_enc;
> > -	struct resource *res;
> >   	phandle rproc_phandle;
> >   	enum mtk_vcodec_fw_type fw_type;
> >   	int ret;
> > @@ -272,13 +271,6 @@ static int mtk_vcodec_probe(struct
> > platform_device *pdev)
> >   		goto err_res;
> >   	}
> >   
> > -	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> 
> This needs to be a separated commit with a Fixes tag!
Separate to another patch, thanks.
> 
> > -	if (res == NULL) {
> > -		dev_err(&pdev->dev, "failed to get irq resource");
> > -		ret = -ENOENT;
> > -		goto err_res;
> > -	}
> > -
> >   	dev->enc_irq = platform_get_irq(pdev, 0);
> >   	irq_set_status_flags(dev->enc_irq, IRQ_NOAUTOEN);
> >   	ret = devm_request_irq(&pdev->dev, dev->enc_irq,
> > @@ -428,6 +420,18 @@ static const struct mtk_vcodec_enc_pdata
> > mt8195_pdata = {
> >   	.core_id = VENC_SYS,
> >   };
> >   
> > +static const struct mtk_vcodec_enc_pdata mt8188_pdata = {
> > +	.uses_ext = true,
> > +	.capture_formats = mtk_video_formats_capture_h264,
> > +	.num_capture_formats =
> > ARRAY_SIZE(mtk_video_formats_capture_h264),
> > +	.output_formats = mtk_video_formats_output,
> > +	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
> > +	.min_bitrate = 64,
> > +	.max_bitrate = 50000000,
> > +	.core_id = VENC_SYS,
> > +	.is_34bit = true,
> > +};
> > +
> >   static const struct of_device_id mtk_vcodec_enc_match[] = {
> >   	{.compatible = "mediatek,mt8173-vcodec-enc",
> >   			.data = &mt8173_avc_pdata},
> > @@ -436,6 +440,7 @@ static const struct of_device_id
> > mtk_vcodec_enc_match[] = {
> >   	{.compatible = "mediatek,mt8183-vcodec-enc", .data =
> > &mt8183_pdata},
> >   	{.compatible = "mediatek,mt8192-vcodec-enc", .data =
> > &mt8192_pdata},
> >   	{.compatible = "mediatek,mt8195-vcodec-enc", .data =
> > &mt8195_pdata},
> > +	{.compatible = "mediatek,mt8188-vcodec-enc", .data =
> > &mt8188_pdata},
> 
> Please keep this list alphabetically sorted.
Fix in next version.

Thanks
Best Regards.
> 
> >   	{},
> >   };
> >   MODULE_DEVICE_TABLE(of, mtk_vcodec_enc_match);
> 
> 

