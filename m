Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AEE48D358
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiAMIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:04:58 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:63711 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiAMIE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:04:56 -0500
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 7v68nVqnqniux7v68nzdc1; Thu, 13 Jan 2022 09:04:52 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 13 Jan 2022 09:04:52 +0100
X-ME-IP: 90.126.236.122
Message-ID: <2e676870-11f2-b5fa-faf1-d6633e801a5a@wanadoo.fr>
Date:   Thu, 13 Jan 2022 09:04:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 1/3] drm/bridge: anx7625: Convert to use devm_kzalloc
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
References: <20220113073158.2171673-1-hsinyi@chromium.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220113073158.2171673-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/01/2022 à 08:31, Hsin-Yi Wang a écrit :
> Use devm_kzalloc instead of kzalloc and drop kfree(). Let the memory
> handled by driver detach.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Xin Ji <xji@analogixsemi.com>
> ---
>   drivers/gpu/drm/bridge/analogix/anx7625.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 0b858c78abe8b6..dbe708eb3bcf11 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2515,7 +2515,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>   		return -ENODEV;
>   	}
>   
> -	platform = kzalloc(sizeof(*platform), GFP_KERNEL);
> +	platform = devm_kzalloc(dev, sizeof(*platform), GFP_KERNEL);
>   	if (!platform) {
>   		DRM_DEV_ERROR(dev, "fail to allocate driver data\n");
>   		return -ENOMEM;
> @@ -2527,7 +2527,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>   	if (ret) {
>   		if (ret != -EPROBE_DEFER)
>   			DRM_DEV_ERROR(dev, "fail to parse DT : %d\n", ret);
> -		goto free_platform;
> +		return ret;
>   	}
>   
>   	platform->client = client;
> @@ -2552,7 +2552,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>   	if (!platform->hdcp_workqueue) {
>   		dev_err(dev, "fail to create work queue\n");
>   		ret = -ENOMEM;
> -		goto free_platform;
> +		return ret;
>   	}
>   
>   	platform->pdata.intp_irq = client->irq;
> @@ -2637,9 +2637,6 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>   	if (platform->hdcp_workqueue)
>   		destroy_workqueue(platform->hdcp_workqueue);
>   
> -free_platform:
> -	kfree(platform);
> -
>   	return ret;
>   }
>   

Hi,

you also need to update anx7625_i2c_remove() accordingly, otherwise you 
introduce a double free.

CJ


