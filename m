Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F5554C8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348931AbiFOMs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348826AbiFOMsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:48:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E81758B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:48:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v8so2091503ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=IKkEI1vEAYy+wKZ0nZJbXYdiseAo5I2B96TpHBLOCmU=;
        b=dil/QRv2b/+pgYvnTk+wUqC3Cwp1uy4EqTIdoZshFp3gnU+y7nTLSEE8a+JCYTQdEX
         UspKPIMjc2gz4WLI9G9hDJfvxvT7GmcfRNob78gK3lHxjkKZC1hxjnqsLZ4i/rdku/qK
         TI9sBkSgPSOpBz8jNsWTfDakANzDLpS3/thSMQYt7lkVcQiggvUUcQN96w0D/CU1qf9w
         Z+sgm+WzJEvK8AYrJiDeiNACECWIyr7c5Oi8gSgiF3B2qbigGRAqvoYOkpAwZjxiSFn8
         co8Quua2Iq1d+BF/rUejm4SXYJTNRGY2oca8oOWPmGsegz+1iwQGURpzlOhonvv+70+l
         hZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IKkEI1vEAYy+wKZ0nZJbXYdiseAo5I2B96TpHBLOCmU=;
        b=IVweYlvcnE6T3JODg0lKHLqCK/CpoaSWOf7d5Noc1y0svCHsWrub8PGSyN70slr7iW
         FfAJrsAF0aJfKlGiMRO5GjTBRH7pyxVZZwapj7LLU1Ngm7q4IgcbavnQ8eeQqJAIfLPS
         p2gdnao4L213jTbaICjwN0+svGPLHGoI9oV9gA/XlXaXDyf1S9L9bU6QsIdmi5pYrUM8
         glKW/kDhg6UXB3Yn8I7YRXOJYm0gf/pgXEOev0Sys5a4fNRqvF8UZz7CyxflsY1c2rpr
         b+eNBkK1s1L0MVlXKGghZLDaBtagbFNnNGPevDf3XQxsXo/GhIzi+8ba2NU2i83z+q4o
         zkUQ==
X-Gm-Message-State: AJIora+QysKS2n4yRHKIOq1c6mCs7bphMD1TlkH6hmIqSUYl9/Ry6X9K
        ti662lS1GoeznTtCEesygf0RIA==
X-Google-Smtp-Source: AGRyM1uetcxrCiKpy9pOfOUbCy/it8Y6OjjPF+K52yYDh1v5ozTUJOrEQmpJBZfAc5I/iizeKGJCLg==
X-Received: by 2002:a2e:91c6:0:b0:259:1427:f85c with SMTP id u6-20020a2e91c6000000b002591427f85cmr5091572ljg.405.1655297302558;
        Wed, 15 Jun 2022 05:48:22 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y1-20020a199141000000b0047255d2119bsm1784208lfj.202.2022.06.15.05.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:48:21 -0700 (PDT)
Message-ID: <6ad85a23-0156-2774-1215-ea02257cc107@linaro.org>
Date:   Wed, 15 Jun 2022 15:48:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/msm: Use div64_ul instead of do_div
Content-Language: en-GB
To:     Wan Jiabing <wanjiabing@vivo.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220426132126.686447-1-wanjiabing@vivo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220426132126.686447-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 16:21, Wan Jiabing wrote:
> Fix following coccicheck warning:
> drivers/gpu/drm/msm/msm_gpu_devfreq.c:72:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.
> 
> Use div64_ul instead of do_div to avoid a possible truncation.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_gpu_devfreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> index d2539ca78c29..c2ea978c8921 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> @@ -69,7 +69,7 @@ static void get_raw_dev_status(struct msm_gpu *gpu,
>   	df->time = time;
>   
>   	busy_time *= USEC_PER_SEC;
> -	do_div(busy_time, sample_rate);
> +	busy_time = div64_ul(busy_time, sample_rate);
>   	if (WARN_ON(busy_time > ~0LU))
>   		busy_time = ~0LU;
>   


-- 
With best wishes
Dmitry
