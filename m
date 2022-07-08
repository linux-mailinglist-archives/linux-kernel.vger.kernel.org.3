Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75AA56B549
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbiGHJT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiGHJT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:19:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8A52A948;
        Fri,  8 Jul 2022 02:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD362B82564;
        Fri,  8 Jul 2022 09:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796F9C341CD;
        Fri,  8 Jul 2022 09:19:21 +0000 (UTC)
Message-ID: <daf5e3e6-8a13-3c16-5fa6-9c4e69883c49@xs4all.nl>
Date:   Fri, 8 Jul 2022 11:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/6] media: mediatek: vcodec: Revert driver name change in
 encoder capabilities
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20220701105237.932332-1-wenst@chromium.org>
 <20220701105237.932332-5-wenst@chromium.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220701105237.932332-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/22 12:52, Chen-Yu Tsai wrote:
> This partially reverts commit fd9f8050e355d7fd1e126cd207b06c96cde7f783.
> 
> The driver name field should contain the actual driver name, not some
> otherwise unused string macro from the driver. To make this clear,
> copy the name from the driver's name field.
> 
> Fixes: fd9f8050e355 ("media: mediatek: vcodec: Change encoder v4l2 capability value")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 1 +
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> index 4140b4dd85bf..dc6aada882d9 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> @@ -22,6 +22,7 @@
>  #define MTK_VCODEC_DRV_NAME	"mtk_vcodec_drv"

Note that this patch removes the last user of this define, so
you can drop that define as well.

>  #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
>  #define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
> +#define MTK_PLATFORM_STR	"platform:mt8173"

Why add this?

>  
>  #define MTK_VCODEC_MAX_PLANES	3
>  #define MTK_V4L2_BENCHMARK	0
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> index ccc753074816..30aac54d97fa 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> @@ -232,11 +232,13 @@ static int mtk_vcodec_enc_get_chip_name(void *priv)
>  static int vidioc_venc_querycap(struct file *file, void *priv,
>  				struct v4l2_capability *cap)
>  {
> +	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
> +	struct device *dev = &ctx->dev->plat_dev->dev;
>  	int platform_name = mtk_vcodec_enc_get_chip_name(priv);
>  
> -	strscpy(cap->driver, MTK_VCODEC_DRV_NAME, sizeof(cap->driver));
> -	strscpy(cap->card, MTK_VCODEC_ENC_NAME, sizeof(cap->card));
> +	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
>  	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d-enc", platform_name);
> +	strscpy(cap->card, MTK_PLATFORM_STR, sizeof(cap->card));

The next patch changes cap->card again, and leaves MTK_PLATFORM_STR unused.

>  
>  	return 0;
>  }

I think it makes more sense to combine patches 1-3 and 4-6 into single
patches, one for the decoder, one for the encoder. It's easier to follow
since they all touch on the same querycap function.

Regards,

	Hans
