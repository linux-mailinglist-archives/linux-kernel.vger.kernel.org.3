Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E70348E7F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiANJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:59:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55988 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbiANJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:59:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 926421F4673C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642154359;
        bh=+9biWWnH3dbRTPlizbAy98vfhQMljlSloRSnoFf9s1k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LXPvUEKGzuX2+nziPgpVruS368mLNhyyvpWaPM5R66bcq7ptwAUkcyVXOCrgnlbLs
         DTcjGd97r9pd0Mwpo/8UzPTy5fFpHlLSis61jnG9ufUR1f8nB/27zX90LWiX8VapFO
         mEz/c/qs9lgJIr7v/qQi0gJaNoNL17sRB5TyoOa8sqQ5v/Ko7MwMTHIYkAV2RItT8a
         YnTbh6ZAShGuxyYy6A0f5RwzSDkDF6nBOX4Tmqno9FeCPo90/1TwCJg5y7kOmtGqFU
         taR8IAbXtSjvNbjPAM6DVCW3UtwhMGsDl6/zHMBPiBlyJ9dFbh0+PiWw/aH/LCpTXn
         YQE+vsRBE1cbA==
Subject: Re: [v9,1/3] drm/dsi: transfer DSI HS packets ending at the same time
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
 <20220114092110.12137-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <6874ebff-3b20-807d-0fa5-ba21986bb787@collabora.com>
Date:   Fri, 14 Jan 2022 10:59:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220114092110.12137-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/01/22 10:21, Rex-BC Chen ha scritto:
> Since a HS transmission is composed of an arbitrary number
> of bytes that may not be an integer multiple of lanes, some
> lanes may run out of data before others.
> (Defined in 6.1.3 of mipi_DSI_specification_v.01-02-00)
> 
> However, for some DSI RX devices (for example, anx7625),
> there is a limitation that packet number should be the same
> on all DSI lanes. In other words, they need to end a HS at
> the same time.
> 
> Because this limitation is for some specific DSI RX devices,
> it is more reasonable to put the enable control in these
> DSI RX drivers. If DSI TX driver knows the information,
> they can adjust the setting for this situation.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   include/drm/drm_mipi_dsi.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 147e51b6d241..342dfe5a0874 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -137,6 +137,8 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node);
>   #define MIPI_DSI_CLOCK_NON_CONTINUOUS	BIT(10)
>   /* transmit data in low power */
>   #define MIPI_DSI_MODE_LPM		BIT(11)
> +/* transmit data ending in the same hsync for all lanes */
> +#define MIPI_DSI_HS_PKT_END_ALIGNED	BIT(12)
>   
>   enum mipi_dsi_pixel_format {
>   	MIPI_DSI_FMT_RGB888,
> 

