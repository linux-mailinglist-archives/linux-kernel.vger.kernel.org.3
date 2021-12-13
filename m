Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0734728E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbhLMKP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:15:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36776 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240839AbhLMKCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:02:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E58D81F422D4
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639389763; bh=gbwMY8tv7htkSgQhxyiYITlrUTUsJaPP690NeQU6YUQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EU11AE4wrTQEE+5LfvBgVxBkiE++ZIemMYyUK2B+hSS6eJlY/R0cwCg4KczXtV85K
         vVohGdjYANIWOHL6bzUmMFYYOCUsABOL4FQNdnB5XZsiujMneDka+KmSgY+XqyTswi
         Q4GAwtC//aDpKYEFXBJz1zJ90R8FOGD4ojbWqXyr5Fpx7EIU1jTi/aspJE4E5k//Vv
         Y0TKL11uPblz25B1JNQBmqSnvnrrHktxrcMj3PvgwCA1xcFREg+olOOnr3IIebmBlu
         /KdbveU3l7mNYSfN4Dh9IeWggwcAj9cFhS5A5DT/+GgdxI4CHdNgnxy28q1GzzkkGb
         se5mtDkliq2Bg==
Subject: Re: [PATCH] drm/mediatek: hdmi: Perform NULL pointer check for
 mtk_hdmi_conf
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dafna.hirschfeld@collabora.com, kernel@collabora.com
References: <20211028074311.57842-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <000ba19e-0220-f5c3-0efd-abb8338bb8f2@collabora.com>
Date:   Mon, 13 Dec 2021 11:02:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028074311.57842-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/10/21 09:43, AngeloGioacchino Del Regno ha scritto:
> In commit 41ca9caaae0b ("drm/mediatek: hdmi: Add check for CEA modes only")
> a check for CEA modes was added to function mtk_hdmi_bridge_mode_valid()
> in order to address possible issues on MT8167; moreover, with commit
> c91026a938c2 ("drm/mediatek: hdmi: Add optional limit on maximal HDMI mode clock")
> another similar check was introduced.
> 
> Unfortunately though, at the time of writing, MT8173 does not provide
> any mtk_hdmi_conf structure and this is crashing the kernel with NULL
> pointer upon entering mtk_hdmi_bridge_mode_valid(), which happens as
> soon as a HDMI cable gets plugged in.
> 
> To fix this regression, add a NULL pointer check for hdmi->conf in the
> said function, restoring HDMI functionality and avoiding NULL pointer
> kernel panics.
> 
> Fixes: 41ca9caaae0b ("drm/mediatek: hdmi: Add check for CEA modes only")
> Fixes: c91026a938c2 ("drm/mediatek: hdmi: Add optional limit on maximal HDMI mode clock")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_hdmi.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 5838c44cbf6f..3196189429bc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1224,12 +1224,14 @@ static int mtk_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
>   			return MODE_BAD;
>   	}
>   
> -	if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
> -		return MODE_BAD;
> +	if (hdmi->conf) {
> +		if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
> +			return MODE_BAD;
>   
> -	if (hdmi->conf->max_mode_clock &&
> -	    mode->clock > hdmi->conf->max_mode_clock)
> -		return MODE_CLOCK_HIGH;
> +		if (hdmi->conf->max_mode_clock &&
> +		    mode->clock > hdmi->conf->max_mode_clock)
> +			return MODE_CLOCK_HIGH;
> +	}
>   
>   	if (mode->clock < 27000)
>   		return MODE_CLOCK_LOW;
> 

Hello, friendly ping!

Can I please get a review (or merge) of this commit?

This is an important fix for a null pointer KP and restores HDMI functionality.

Thanks,
- Angelo
