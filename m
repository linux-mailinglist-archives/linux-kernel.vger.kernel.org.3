Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68E156B243
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiGHFgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGHFfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:35:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B449426AFC;
        Thu,  7 Jul 2022 22:35:48 -0700 (PDT)
X-UUID: 17bb8d15316e4e4f80e080164af5ba3d-20220708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:2a6a6774-90f1-4a00-bae0-af0bb8878e4a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:5425e186-57f0-47ca-ba27-fe8c57fbf305,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 17bb8d15316e4e4f80e080164af5ba3d-20220708
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1840264530; Fri, 08 Jul 2022 13:35:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 8 Jul 2022 13:35:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jul 2022 13:35:42 +0800
Message-ID: <42c0fd8acfb5a99fd33cb5245a54ed9037124f4f.camel@mediatek.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Initialize decoder parameters
 for each instance
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Fri, 8 Jul 2022 13:35:42 +0800
In-Reply-To: <20220704084930.1625768-1-wenst@chromium.org>
References: <20220704084930.1625768-1-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

Thanks for your patch.

Reviewed-by: Yunfei Dong <yunfei.dong@mediatek.com>

Best Regards,
Yunfei Dong

On Mon, 2022-07-04 at 16:49 +0800, Chen-Yu Tsai wrote:
> The decoder parameters are stored in each instance's context data.
> This
> needs to be initialized per-instance, but a previous fix incorrectly
> changed it to only be initialized for the first opened instance. This
> resulted in subsequent instances not correctly signaling the
> requirement
> for the Requests API.
> 
> Fix this by calling the initializing function outside of the
> v4l2_fh_is_singular() conditional block.
> 
> Fixes: faddaa735c20 ("media: mediatek: vcodec: Initialize decoder
> parameters after getting dec_capability")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This was found during backport of mtk-vcodec patches onto the
> ChromeOS
> v5.10 kernel, which caused one of our tests that does multiple
> concurrent
> decodes to fail, as some decoder instances didn't have their
> requires_requests and supports_requests flags marked correctly.
> Evidently my previous testing of culprit patch was not thorough
> enough.
> 
> This fixes commit faddaa735c20 ("media: mediatek: vcodec: Initialize
> decoder
> parameters after getting dec_capability") in the media stage repo.
> This
> could either be queued up after it, or squashed into it.
> 
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git
> a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index 55dffb61e58c..e0b6ae9d6caa 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -208,11 +208,12 @@ static int fops_vcodec_open(struct file *file)
>  
>  		dev->dec_capability =
>  			mtk_vcodec_fw_get_vdec_capa(dev->fw_handler);
> -		ctx->dev->vdec_pdata->init_vdec_params(ctx);
>  
>  		mtk_v4l2_debug(0, "decoder capability %x", dev-
> >dec_capability);
>  	}
>  
> +	ctx->dev->vdec_pdata->init_vdec_params(ctx);
> +
>  	list_add(&ctx->list, &dev->ctx_list);
>  
>  	mutex_unlock(&dev->dev_mutex);

