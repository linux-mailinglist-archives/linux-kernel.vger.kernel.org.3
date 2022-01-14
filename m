Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC448E7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiANJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiANJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:57:23 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C3C061574;
        Fri, 14 Jan 2022 01:57:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5DC0C1F4673C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642154242;
        bh=Y9ZEklpVcSHZrMGoj2Y3KVzohZyX3zxs0Ezly9VHhpg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JnrT35XwaOs6lYaGiXSrOqPHkN1N7cCn85YEnAVyYjWHUz4/qyKT5UdXY8jtWX9Kr
         l2XdD8n7/lKmhUafoc8Iv+Mksvn9vjkYB8juOV0gCHudna0OsFDhwPtHYxkADBO74J
         bTZyEzpPLpLh7qqnBiM0ANBdxV2Ljb2EQ5lyKKciRpJpFuslb2WAehkTIgqNrGieiJ
         PZcObstdy5bnRWgOr8IHO/ZiPODEkx7zHt9HyMiDFMZ+imWNQLjvxKjVLiqjWSeikV
         O2da0RvCN1fOb3ISg47GotgLR8e5Ud65ryMPNbEKegWaGAUXLYYxEfh14vZNzlX4KA
         jBhexYGY3iZtg==
Subject: Re: [v9, 3/3] drm/bridge: anx7625: config hs packets end aligned to
 avoid screen shift
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
 <20220114092110.12137-4-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <cd19a827-d132-1011-9445-7e425817102a@collabora.com>
Date:   Fri, 14 Jan 2022 10:57:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220114092110.12137-4-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/01/22 10:21, Rex-BC Chen ha scritto:
> This device requires the packets on lanes aligned at the end to fix
> screen shift or scroll.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/bridge/analogix/anx7625.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 2346dbcc505f..fe32ab0878ae 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1673,7 +1673,8 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO	|
>   		MIPI_DSI_MODE_VIDEO_SYNC_PULSE	|
> -		MIPI_DSI_MODE_VIDEO_HSE;
> +		MIPI_DSI_MODE_VIDEO_HSE	|
> +		MIPI_DSI_HS_PKT_END_ALIGNED;
>   
>   	ret = devm_mipi_dsi_attach(dev, dsi);
>   	if (ret) {
> 

