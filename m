Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15D2544863
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbiFIKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbiFIKJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5350D12AEB;
        Thu,  9 Jun 2022 03:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28DA161D1C;
        Thu,  9 Jun 2022 10:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE40C34114;
        Thu,  9 Jun 2022 10:08:51 +0000 (UTC)
Message-ID: <3cd958be-41a8-707d-983a-c9950e913ae5@xs4all.nl>
Date:   Thu, 9 Jun 2022 12:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/4] media: mediatek: vcodec: Fix decoder v4l2 bus_info
 not correctly
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
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
Cc:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220526095737.21118-1-yunfei.dong@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220526095737.21118-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei Dong,

On 5/26/22 11:57, Yunfei Dong wrote:
> Fix v4l2 capability bus_info value with correct chip name according to compatible.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> index 52e5d36aa912..ccfa426a34ab 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> @@ -185,11 +185,32 @@ static int vidioc_vdec_dqbuf(struct file *file, void *priv,
>  	return v4l2_m2m_dqbuf(file, ctx->m2m_ctx, buf);
>  }
>  
> +static int mtk_vcodec_dec_get_chip_name(void *priv)
> +{
> +	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
> +	struct device *dev = &ctx->dev->plat_dev->dev;
> +
> +	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-dec"))
> +		return 8173;
> +	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8183-vcodec-dec"))
> +		return 8183;
> +	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8192-vcodec-dec"))
> +		return 8192;
> +	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8195-vcodec-dec"))
> +		return 8195;
> +	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8186-vcodec-dec"))
> +		return 8186;
> +	else
> +		return 8173;
> +}

Nice, but...

> +
>  static int vidioc_vdec_querycap(struct file *file, void *priv,
>  				struct v4l2_capability *cap)
>  {
> +	int platform_name = mtk_vcodec_dec_get_chip_name(priv);
> +
>  	strscpy(cap->driver, MTK_VCODEC_DEC_NAME, sizeof(cap->driver));
> -	strscpy(cap->bus_info, MTK_PLATFORM_STR, sizeof(cap->bus_info));
> +	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d", platform_name);

...this will result in identical bus_info values for the decoder and encoder
video devices. The bus_info field is supposed to be unique, and that's now
no longer the case.

I suggest changing this to:

	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d-dec", platform_name);

(and '-enc' for the encoder patch).

Regards,

	Hans

>  	strscpy(cap->card, MTK_PLATFORM_STR, sizeof(cap->card));
>  
>  	return 0;
