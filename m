Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3C948E79A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiANJgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiANJgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:36:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3136C061574;
        Fri, 14 Jan 2022 01:36:49 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 72FA71F466F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642153007;
        bh=pFIPIy9RdFXB+9xAvQLstpQYOgxW4GoQbae/UEltiWE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Tt0qSzhsWQ5EVH6VjZyCyTHylaUwo1BQR0kHlLZvfN2B3BBVCP12vhFPduPFVvWOM
         +PYV6SAKKjEYKDY30Qmkt33KfjNFJoBrODPR0XfMMkmmKVzyqcWJWtEdGUR/WrpNGE
         tOBje8PM8F+jjp5LVPEgUHsGSnGxI9Z2e74ZUBG+59+fo4Tw8xKmdMMWbEmD+XgcfV
         oEBXslQIgU7unasQkcDYVu6wZho/5u7POprK1bLaJRpGkQeQG8QclIo5CqT0UodInQ
         4YtD4eFVMRQ7pt2AixdLlaESbe8cGsIVc4FcnPcqLq+mNXJhheVtiCZ04HnQ/5h1F5
         F+ZiAYGZ6SJCQ==
Subject: Re: [v9,2/3] drm/mediatek: implement the DSI hs packets aligned
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        matthias.bgg@gmail.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, andrzej.hajda@intel.com, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de
Cc:     xji@analogixsemi.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
References: <20220114092110.12137-1-rex-bc.chen@mediatek.com>
 <20220114092110.12137-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <4076cb55-4546-6bbd-1a1f-19395dcd9ccd@collabora.com>
Date:   Fri, 14 Jan 2022 10:36:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220114092110.12137-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/01/22 10:21, Rex-BC Chen ha scritto:
> Some DSI RX devices require the packets on all lanes aligned at the end.
> Otherwise, there will be some issues of shift or scroll for screen.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Hello,
thanks for the patch! However, there's something to improve...

> ---
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 5d90d2eb0019..ccdda15f5a66 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -195,6 +195,8 @@ struct mtk_dsi {
>   	struct clk *hs_clk;
>   
>   	u32 data_rate;
> +	/* force dsi line end without dsi_null data */
> +	bool hs_packet_end_aligned;

There's no need to introduce a new variable here...

>   
>   	unsigned long mode_flags;
>   	enum mipi_dsi_pixel_format format;
> @@ -500,6 +502,13 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>   		DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\n");
>   	}
>   
> +	if (dsi->hs_packet_end_aligned) {

You can simply check mode_flags here:
	if (dsi->mode_flags & MIPI_DSI_HS_PKT_END_ALIGNED) {

> +		horizontal_sync_active_byte = roundup(horizontal_sync_active_byte, dsi->lanes) - 2;
> +		horizontal_frontporch_byte = roundup(horizontal_frontporch_byte, dsi->lanes) - 2;
> +		horizontal_backporch_byte = roundup(horizontal_backporch_byte, dsi->lanes) - 2;
> +		horizontal_backporch_byte -= (vm->hactive * dsi_tmp_buf_bpp + 2) % dsi->lanes;
> +	}
> +
>   	writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
>   	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
>   	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
> @@ -794,6 +803,9 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host *host,
>   	dsi->lanes = device->lanes;
>   	dsi->format = device->format;
>   	dsi->mode_flags = device->mode_flags;
> +	dsi->hs_packet_end_aligned = (dsi->mode_flags &
> +				      MIPI_DSI_HS_PKT_END_ALIGNED)
> +				     ? true : false;

...so there's no need for this one, either.

>   
>   	return 0;
>   }
> 

Regards,
- Angelo

