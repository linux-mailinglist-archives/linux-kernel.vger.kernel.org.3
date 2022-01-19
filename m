Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90544943C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbiASXQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiASXQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:16:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9265C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:16:25 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m1so14516682lfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t+UvExnMGr7obKnDTWnSkdCN+ME4NSBCGXqXzSw5iSo=;
        b=MqmYEnYdyhMJQDO68f9G4rEyyQ+cVfJ5LtIxWphKLXzEy8AoymRWzSkqsFzbObiG/9
         B6SZD4nbnx8gAGPPA1N689vo/7nMCzNxyUMzHRU4jJFpehDt40vNspf1/xLFyI3Zzgxr
         Fi1V1lpKR10/s2Cj4VlJx5zGTPjW3izAjWbesprmkZX2GuvZIahc9Vx2FQ5OO+PZPn8X
         qmamUxWjfw6sWPgJ0eoYIh70eLo2ztGuEbMTX4+oEpssIFAO6wB8f0TlUyyxtE+UQ0oI
         TS5hPneXt9SBcKOXTgwji36xleJGUNU1Q9IythpsWeGAehy79ed9M1ipdZY9LYVCe9AI
         ZgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t+UvExnMGr7obKnDTWnSkdCN+ME4NSBCGXqXzSw5iSo=;
        b=kcQ9zin3vEzYLn6yFvYMUn34LMOqzQkHJ2yrO1LXP5MwI13ZCmMt7ORCb2keFq/ps8
         d+u3oN+KWmymhhb4CgdUkfM2iMoDim0mFI6K/2Ig2ahY+PmDNf7pxXENEOmB1N7LCR+x
         cSs6uu9jTiNK1/xfYmCqGPijVArjSVU+9ateSOZZnNc25M5MdJKtKJV9EqWrRTu8buUB
         1q8wQXau3z5CZ9cJNJ+nYJCt8Pv4KqOywW0l0MqgiY+dsi6evf+tItHmqzinebV2jWo9
         gpX6hNNSgtMfbKA5pEsAbaRBgVZqNoj1FQG1iV4be67FEnw/uGut5bs2EHf2Fdptovwd
         cOQQ==
X-Gm-Message-State: AOAM53386VoDDz1eCzTbX27nr7FrRHpHTnxaOC3SifjEcVysZQUyStXY
        zJr0DNfCigeveRXScWpE6qyzvg==
X-Google-Smtp-Source: ABdhPJyyVg2TL1sPJO+eUBnw0lNT7DDk9o3klte92k8k0CTTv7NNqC70fAiw84rmP9ZoBDPTQR9mkA==
X-Received: by 2002:a2e:a5c9:: with SMTP id n9mr28015844ljp.220.1642634184142;
        Wed, 19 Jan 2022 15:16:24 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id be28sm97280ljb.37.2022.01.19.15.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 15:16:23 -0800 (PST)
Message-ID: <5db5b998-9563-be71-e87f-d906bf8b438b@linaro.org>
Date:   Thu, 20 Jan 2022 02:16:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/msm/dsi: Fix missing put_device() call in dsi_get_phy
Content-Language: en-GB
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hai Li <hali@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20211230070943.18116-1-linmq006@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211230070943.18116-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2021 10:09, Miaoqian Lin wrote:
> If of_find_device_by_node() succeeds, dsi_get_phy() doesn't
> a corresponding put_device(). Thus add put_device() to fix the exception
> handling.
> 
> Fixes: ec31abf ("drm/msm/dsi: Separate PHY to another platform device")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dsi/dsi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index 75ae3008b68f..35be526e907a 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -40,7 +40,12 @@ static int dsi_get_phy(struct msm_dsi *msm_dsi)
>   
>   	of_node_put(phy_node);
>   
> -	if (!phy_pdev || !msm_dsi->phy) {
> +	if (!phy_pdev) {
> +		DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", __func__);
> +		return -EPROBE_DEFER;
> +	}
> +	if (!msm_dsi->phy) {
> +		put_device(&phy_pdev->dev);
>   		DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", __func__);
>   		return -EPROBE_DEFER;
>   	}


-- 
With best wishes
Dmitry
