Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0943C4A52D1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiAaXCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbiAaXCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:02:00 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C37C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:02:00 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id q145-20020a4a3397000000b002e85c7234b1so3621149ooq.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=07IOc+4sCg1ox/edloQ1DbuVRJUKfQj2aCnLFjL6iTQ=;
        b=Bn4rW4n25XPNIJwkb8Lp3Y4CT3gpNhv1eeQJ4rYPyhwpCfkWPCbBXgTMVdpQQACd9t
         UtCxurE7RDaXdvezgp5HMXscwwHkIzqm8twxCDC7mzydP3LHwH/zqasn8tjOz4zGFSXD
         j9wJDatUBoCjkoIDxDMo3THoCecavFdfsnukm0buW9Mv3U0+PlqlqX2n3uem93mU/eLg
         hxoohDXZ6P2Sv/pWagelPRuq2bGIGGzzhkLZtgcdlB4ydM3Z8eKGnPY5R9B7ZdXJz9SB
         gh46OmYNt+YVZURMlSndeCdHc9qiGqKWgvNBQtrhkURfzwdoSfQhpHQrzfbG5qyIyj/l
         fNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=07IOc+4sCg1ox/edloQ1DbuVRJUKfQj2aCnLFjL6iTQ=;
        b=FrpTh/q5AE9OMox/01Ly47lMXgxmQADJq6fYkO3QEMFDNODTCI1Mi1fD1zK4vBQ36N
         uYjZosA8MYZivXzRvikUNSwlN1yrFxILY95UJ+YVfHZ0ovecoRQSkZ0AVGxwRNaGGCeJ
         H+M5dW4XtwZkPgpvRzuq7QKb04kWkOddJAknGuXZb1FxDa8rXrNcQjB9gkHC5YjklrCA
         otOBbFTbXnIwagCJIXpnhwN3wKKivsqtauodQXujAeiTsuE3O0AQ0F7xamnrPOc6PdIT
         ZZEBoTtKTBCl8jDzCe6aXqygUC86ThCBvQWTlS4pr6vksEjnZYRhKoAKODEH9TzkFihP
         HvDg==
X-Gm-Message-State: AOAM5302GUgomGPY/MN8BlwA7XbSxTDHVnHi59je8TMLw390ZQdHWpmB
        NzzKP7MOHHFai6J+0iZEsD6uKQ==
X-Google-Smtp-Source: ABdhPJx/GYKJ4sp8QsQTJCGodwe9naihFp+6pOwgegfbICsiojZpoJdJyBjOVoo3GHiFJgM+vQVu9w==
X-Received: by 2002:a05:6830:19ed:: with SMTP id t13mr12872041ott.83.1643670119656;
        Mon, 31 Jan 2022 15:01:59 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id n9sm5546723otf.9.2022.01.31.15.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 15:01:59 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:01:57 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/msm/adreno: Update the name of 7c3 gpu
Message-ID: <YfhqZZ4QLuCffQPC@builder.lan>
References: <20220119205012.v2.1.Ibac66e1e0e565313bc28f192e6c94cb508f205eb@changeid>
 <20220119205012.v2.4.Idbc978090270c7b838387acc74d8a06a186a3cf4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119205012.v2.4.Idbc978090270c7b838387acc74d8a06a186a3cf4@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Jan 09:21 CST 2022, Akhil P Oommen wrote:

> Update the name in the gpulist for 7c3 gpu as per the latest
> recommendation.
> 

I was skeptical when this was introduced and you proved my point. Give
it a name based on the Adreno revision or possibly the part number and
leave it at that.

Regards,
Bjorn

> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 946f505..bd4d6a1 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -330,7 +330,7 @@ static const struct adreno_info gpulist[] = {
>  		.hwcg = a660_hwcg,
>  	}, {
>  		.rev = ADRENO_REV(6, 3, 5, ANY_ID),
> -		.name = "Adreno 7c Gen 3",
> +		.name = "Adreno 7c+ Gen 3",
>  		.fw = {
>  			[ADRENO_FW_SQE] = "a660_sqe.fw",
>  			[ADRENO_FW_GMU] = "a660_gmu.bin",
> -- 
> 2.7.4
> 
