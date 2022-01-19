Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38204943C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiASXQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbiASXQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:16:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B157C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:16:38 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x7so14435250lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4frs59YJlPKUn4ECIxS4w+UO9vELx/wX9L+HYGD0PPU=;
        b=kaXFa7BU8V7n0wYiOXe2T9/reNlqGfjeXzP039cx3hxNLazSCKozFUK9BE5fyMQ0dl
         OSja1kfX+A4kjBk1KKJhJkDqece5eBg9fzndnGgXTGdGJPIL8F/lu2H/pH4XC/lfSnIh
         PWcxSW0D8IIWERHvwEbmTW3FoO4urZnQs1qrAYYcCdcSInl8yvO/gfAwZVYuC2BAlG7V
         +JaARezbrGsrTjGa8g5WDQSMCcHlo6d72+tL2ehABfolCUR5VA4elB4lPo+uB+heu1YO
         AaDLVjX2PkJqjiJpRDHOtO7eUzEB8FByqX1eO9vcE1LtU2K+mMZggpq3qzc0CQm5F1g3
         RKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4frs59YJlPKUn4ECIxS4w+UO9vELx/wX9L+HYGD0PPU=;
        b=E8Cu7H++CQqms6pCzDioivN87/817DLOfgmSQb2Fil5etb1uOyd4RMZzCqpLjDoqrm
         t306uYmmsqgWFmCYbGuMcHg+ZS6P6xzDDOmC/NiD5mr1MPT0jSEXWpBL6OZMGSuNAqna
         TXO8yDlF8GxeS4fCVgzHaHEtEuzewqhELksdaF63Z1OkR3W7K+Xvq2CgiOtFR+qsvmVC
         5HbG3ZmtIoPMh+NRIqF0gRBKsfKYx9rjPfy4zwwoL7y46zLNU0dZMIZqhGvSZCO8X9d1
         2y8rVrragY2MflrcKhKzi6Ql5l0WtPG8frUjsjHKDXyTGnIq2VHSVL++5maL4A+ePOuO
         v8Qg==
X-Gm-Message-State: AOAM533Eob1ocdfdaRRAKEghIHCURWk2H6+/7asvs4GugJds4+4Hmjm9
        kIpLM13UNyqpxTSJK9J/5R89KEymTIstSQ==
X-Google-Smtp-Source: ABdhPJzBN1gta2RG1WiG9bwGJXAws9yfXg5qJWQC6wtU3f13U+qPjvj0TL8vz4P8MaEzRyRe6yD7gQ==
X-Received: by 2002:ac2:4e0b:: with SMTP id e11mr16126235lfr.296.1642634196566;
        Wed, 19 Jan 2022 15:16:36 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u15sm106159lfo.194.2022.01.19.15.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 15:16:35 -0800 (PST)
Message-ID: <8042df9c-5dba-a857-e62f-3ea66c2cd218@linaro.org>
Date:   Thu, 20 Jan 2022 02:16:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/msm/hdmi: Fix missing put_device() call in
 msm_hdmi_get_phy
Content-Language: en-GB
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220107085026.23831-1-linmq006@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220107085026.23831-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 11:50, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling path.
> 
> Fixes: e00012b256d4 ("drm/msm/hdmi: Make HDMI core get its PHY")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/hdmi/hdmi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index 75b64e6ae035..a439794a32e8 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -95,10 +95,15 @@ static int msm_hdmi_get_phy(struct hdmi *hdmi)
>   
>   	of_node_put(phy_node);
>   
> -	if (!phy_pdev || !hdmi->phy) {
> +	if (!phy_pdev) {
>   		DRM_DEV_ERROR(&pdev->dev, "phy driver is not ready\n");
>   		return -EPROBE_DEFER;
>   	}
> +	if (!hdmi->phy) {
> +		DRM_DEV_ERROR(&pdev->dev, "phy driver is not ready\n");
> +		put_device(&phy_pdev->dev);
> +		return -EPROBE_DEFER;
> +	}
>   
>   	hdmi->phy_dev = get_device(&phy_pdev->dev);
>   


-- 
With best wishes
Dmitry
