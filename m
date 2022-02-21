Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A694BE76B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377877AbiBUOcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:32:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377875AbiBUOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:31:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D842022B0F;
        Mon, 21 Feb 2022 06:31:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7C2781F437D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645453874;
        bh=mk0k2/MEJmiURqVRoi1Wk1mPXDdi5cLxGGCrvu3Zv+o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cAHt7Se+QbWvrlRL1ngiD9HhR8lKnozQrO13TG0uDtl7RyS2/LEdrMtzyAOBlbMHv
         mp0bZ9zLZgs1g0nPN0Sh01/GvEXPhDTOv7WjzJLOrx+S3y3ONUNvHrvGkEAd4g/za3
         FFBbM3R1VepHpLyS3iwOuiZ5hs7HSkDxwUDhnHcmLXzRZsT6Sws7LvaRyttjdj1mJg
         1/3tzkg59CBmstvES4lryQ95TF9kRHRW3Gy/Yszr7sJUSBUMitEClrh7awHB6L+2PV
         REfUL7zqfeiDuydEepo85W2hreRiHcj3ilQ9qyvLbUK84xmS5NsLN58QNXc3hcy/K9
         zTrhFB6wOe+hQ==
Message-ID: <0a6fe69b-245a-c889-15be-3136c29d3d61@collabora.com>
Date:   Mon, 21 Feb 2022 15:31:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v8 10/19] drm/mediatek: dpi: move swap_shift to board
 config
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
References: <20220218145437.18563-1-granquet@baylibre.com>
 <20220218145437.18563-11-granquet@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220218145437.18563-11-granquet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 15:54, Guillaume Ranquet ha scritto:
> Add flexibility by moving the swap shift value to board config
> 

Same board->SoC as all the other commits..

> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 0d3acd08ea358..ec221e24e0fee 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -131,6 +131,7 @@ struct mtk_dpi_conf {
>   	u32 dimension_mask;
>   	// Mask used for HSIZE and VSIZE (no shift)
>   	u32 hvsize_mask;
> +	u32 channel_swap_shift;
>   	const struct mtk_dpi_yc_limit *limit;
>   };
>   
> @@ -349,7 +350,8 @@ static void mtk_dpi_config_channel_swap(struct mtk_dpi *dpi,
>   		break;
>   	}
>   
> -	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, val << CH_SWAP, CH_SWAP_MASK);
> +	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, val << CH_SWAP,
> +		     CH_SWAP_MASK << dpi->conf->channel_swap_shift);

I would say that this should be instead:
	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING,

		     val << dpi->conf->channel_swap_shift, CH_SWAP_MASK);


>   }
>   
>   static void mtk_dpi_config_yuv422_enable(struct mtk_dpi *dpi, bool enable)
> @@ -821,6 +823,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
>   	.swap_input_support = true,
>   	.dimension_mask = HPW_MASK,
>   	.hvsize_mask = HSIZE_MASK,
> +	.channel_swap_shift = CH_SWAP,
>   	.limit = &mtk_dpi_limit,
>   };
>   
> @@ -835,6 +838,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
>   	.swap_input_support = true,
>   	.dimension_mask = HPW_MASK,
>   	.hvsize_mask = HSIZE_MASK,
> +	.channel_swap_shift = CH_SWAP,
>   	.limit = &mtk_dpi_limit,
>   };
>   
> @@ -848,6 +852,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
>   	.swap_input_support = true,
>   	.dimension_mask = HPW_MASK,
>   	.hvsize_mask = HSIZE_MASK,
> +	.channel_swap_shift = CH_SWAP,
>   	.limit = &mtk_dpi_limit,
>   };
>   
> @@ -861,6 +866,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
>   	.swap_input_support = true,
>   	.dimension_mask = HPW_MASK,
>   	.hvsize_mask = HSIZE_MASK,
> +	.channel_swap_shift = CH_SWAP,
>   	.limit = &mtk_dpi_limit,
>   };
>   



