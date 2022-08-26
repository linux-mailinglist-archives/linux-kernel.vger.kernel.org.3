Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF45A25AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbiHZKPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343588AbiHZKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:15:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF531A446
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:14:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq23so1383154lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nBDls8p7zWKgMsdae7qsDU8nms79A1faHjvYu7tARvE=;
        b=piJ7BEpevaGNdTfb+iohBsjVd8y6wP7fyx2scpDUXdludX6+pLspOYMOnspr5RJUmE
         OIh1n/nMbN506hH3wRUECtpn215qzlyev8PAdv9fkUrfkWN8RbOIkAAv7iCnj/GpRewr
         6b8p81mVhXkt+JAB6KBcurlZ+unI6qZhm+lUuSOQ1aVLUbncBRWCYQHGm7l3rhjuEEDJ
         RjWZPIryyeV1a9Ua7OflgMFcrcgLy0YL1gskTh695mZRAbIF7D/CS172snBeNCYvtNLW
         KiLBOlEow99lBrYt00L0fYGxGF8kqOX5BJxf2PcQjnNJbHR8CkNz3o+2HAoT3HYzO0fA
         RAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nBDls8p7zWKgMsdae7qsDU8nms79A1faHjvYu7tARvE=;
        b=baN8h2DSG7Kx4wvmRAtorBctH6yV6S470CJxIZuI7+apkIAfmxlu3PwCHu9h3j6qok
         0sZ1weQ9JWuUOaPGr95ViaJqYRC2YGZtrIX2e5Nn4oD6i5sAJlvnVp5AfIUsIMlA4hsD
         xQdU2kYPJXBEmD0SAQY4fRv5ouY8YeXcp1kcOsCyy9uBgRNeT9SCO5LZ+DA2URMTRCXn
         mVCXEm9xx+0OFP4fOpwaBIp0DpXLrHo4CyQ8hS/fF6sMS7gJvkMe6ft7RnVghilvzkxw
         KL+lMqY4e7Wkt/0UD85KVnidgDgInRIDVGPmp21Yl32OVWzU6UhXQRU9xqit9hct9beM
         miEw==
X-Gm-Message-State: ACgBeo00TOPVXN9iln5Ozu7F+1lYcdOg/m/jzVFv5wcT24i7y1FVQy0T
        BxXBBbND2mUKzEFWTD7PYOL7Fg==
X-Google-Smtp-Source: AA6agR7caUbLwyQSa715SFZUEGY9QFvmhTYs0wWUx3epIqtDxGXY7MC1nfcBGHa9KKFMrtkkLdDXyw==
X-Received: by 2002:a19:915c:0:b0:492:f06d:b3b1 with SMTP id y28-20020a19915c000000b00492f06db3b1mr2554374lfj.1.1661508894364;
        Fri, 26 Aug 2022 03:14:54 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y7-20020a05651c106700b0025e42f8e771sm414675ljm.34.2022.08.26.03.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:14:53 -0700 (PDT)
Message-ID: <ad2db009-8660-db05-60d9-fea61a5cde26@linaro.org>
Date:   Fri, 26 Aug 2022 13:14:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] drm/msm/dp: correct 1.62G link rate at
 dp_catalog_ctrl_config_msa()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1661372150-3764-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1661372150-3764-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 23:15, Kuogee Hsieh wrote:
> At current implementation there is an extra 0 at 1.62G link rate which cause
> no correct pixel_div selected for 1.62G link rate to calculate mvid and nvid.
> This patch delete the extra 0 to have mvid and nvid be calculated correctly.
> 
> Changes in v2:
> -- fix Fixes tag's text
> 
> Changes in v3:
> -- fix misspelling of "Reviewed-by"
> 
> Fixes: 937f941ca06f  ("drm/msm/dp: Use qmp phy for DP PLL and PHY")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> 

No extra empty lines between the tags please. I'll correct this manually 
while applying.

> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_catalog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index 7257515..676279d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -431,7 +431,7 @@ void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog,
>   
>   	if (rate == link_rate_hbr3)
>   		pixel_div = 6;
> -	else if (rate == 1620000 || rate == 270000)
> +	else if (rate == 162000 || rate == 270000)
>   		pixel_div = 2;
>   	else if (rate == link_rate_hbr2)
>   		pixel_div = 4;

-- 
With best wishes
Dmitry

