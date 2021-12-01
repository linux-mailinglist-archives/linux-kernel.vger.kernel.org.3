Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E61464DA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349225AbhLAMNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349259AbhLAMMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:12:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD06C06175A;
        Wed,  1 Dec 2021 04:09:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9416B1F458EC
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638360565; bh=/uidj4k0zJPUmLFptZ47+9Rl9yr9MrmexaB64VMOX64=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Do5rNVUKnh6urPTkrQHXjoKTciTmUYKZR/jbWV5MjPfMvuHvx5HqSoCShqPY7y0/7
         4/cOnRnbRfkAQl5dg3O4rcBCTVlEOuOdqO+UzKdr7mPhQEnTQRo+y8HEp/7i5aj8uX
         gv0jmm+txjQiHqmmLyRIa/7I/k+AQZMsZnxeGdFnTnH/EAbqzrnaR57X/fLoWE/8t1
         dWBlumJqHcL+6RqwRZZw595Hr76OCpbPLJQAOVIJzlTWZRh/l3yWVpEbonNg3HT3q3
         rGoADhsWdrKribQrR9VHCGtCsdG/jFnMT68WFOQFO6p5S/tmsQEDwReI2IsWjnYTG7
         ikfalqTEyb+4g==
Subject: Re: [PATCH v11, 09/19] media: mtk-vcodec: Add irq interface for multi
 hardware
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211129034201.5767-1-yunfei.dong@mediatek.com>
 <20211129034201.5767-10-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <5b09baac-ac73-03be-09c7-47dc8bdd61a9@collabora.com>
Date:   Wed, 1 Dec 2021 13:09:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211129034201.5767-10-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/11/21 04:41, Yunfei Dong ha scritto:
> Adds irq interface for multi hardware.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  | 33 ++++++++++++++++---
>   .../platform/mtk-vcodec/mtk_vcodec_dec_hw.c   |  2 +-
>   .../platform/mtk-vcodec/mtk_vcodec_drv.h      | 25 ++++++++++----
>   .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  4 +--
>   .../platform/mtk-vcodec/mtk_vcodec_intr.c     | 27 +++++++--------
>   .../platform/mtk-vcodec/mtk_vcodec_intr.h     |  4 +--
>   .../platform/mtk-vcodec/vdec/vdec_h264_if.c   |  2 +-
>   .../mtk-vcodec/vdec/vdec_h264_req_if.c        |  2 +-
>   .../platform/mtk-vcodec/vdec/vdec_vp8_if.c    |  2 +-
>   .../platform/mtk-vcodec/vdec/vdec_vp9_if.c    |  2 +-
>   .../platform/mtk-vcodec/venc/venc_h264_if.c   |  2 +-
>   .../platform/mtk-vcodec/venc/venc_vp8_if.c    |  2 +-
>   12 files changed, 70 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> index 95fbe9be3f6d..ac279c2a3f8a 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> @@ -52,6 +52,20 @@ static int mtk_vcodec_subdev_device_check(struct mtk_vcodec_dev *vdec_dev)
>   	return 0;
>   }
>   
> +static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dev *dev)
> +{
> +	switch (dev->vdec_pdata->hw_arch) {
> +	case MTK_VDEC_PURE_SINGLE_CORE:
> +		 return MTK_VDEC_ONE_CORE;
> +	case MTK_VDEC_LAT_SINGLE_CORE:
> +		return MTK_VDEC_ONE_LAT_ONE_CORE;
> +	default:
> +		mtk_v4l2_err("not support hw arch:%d",
> +			dev->vdec_pdata->hw_arch);

There's no need to break this line... also, what about changing the message to
"hw arch %d not supported"?


Apart from that,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
