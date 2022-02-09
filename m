Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71DA4AFFFE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiBIWRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:17:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiBIWRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:17:18 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E4C1DC2D4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:17:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h8so3677826lfj.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=T9akMQGOGv0TdBQ+Zhymh6XiC98Y7uCuYr8S0QfufYw=;
        b=So89NUtFvR12bmWOhO2nI5d8soc5b89oiH6ChTJGXB7g1HWfnQxgnN07opHsWJJbDY
         +YcN7dVNKQiiXNQNyqF64SdA5fDsk/RHoHiSAtN+aD7T/RpjjWAAiezNp03ig23l4YWi
         dXoxKgcP5yNxjFunr8JDwDmPnZjzNobzJ90mlchJ+akOWikw7A7mYM62pzQEW1PD10sx
         /j5luWQKYxjGaxpaAxFNNnfI7KLJbBkjz3c1dA/Y4YO+OqpZCSSAWBwhv48NUUCq24bu
         yWq3UtqIkCiHf3ONkQQuUSth6JYjyjgwM7f9sur8i6IjrY6uyLYA4JYlB2zGUH0fMNVK
         o3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T9akMQGOGv0TdBQ+Zhymh6XiC98Y7uCuYr8S0QfufYw=;
        b=B/4Y7XWoC0eqsb5sWDlkV7RMyVeJPc7J7TH4KoYhTjUObdw2nYxKJBZ2Gcs3Tk/r/R
         wqqT7DOdraYC8RMviCMIXmy1ceNS6P4rGqtR3Rrt6Tp3+TZ7qejIdR/md2aBIMbmQPbG
         0N5mMvY4OvIXg8VtdSht5lb8KoKZBWbesumrujj9/shGutVm53HOzijaxK8JoP0syfOO
         eNnHk5Iejhme4NK1ZzNkOFNOrgXRuALHfrS8rqZbA/YpEKrkoe4A4nVLdZfsCR7mN3EZ
         OVbAcMHxg6bQYu+TPkold88gfGVQ0NBHT7JP0mYmjjo5lu9ZROGSLDdF0XTbSQQNg9ug
         sUag==
X-Gm-Message-State: AOAM533IzxT1b44G74R7DUGLGI5L6BmcTruJ4NMmPrfc38fTdil8kI0n
        Ib3L4K9lQOGUtZJXd3acpAh+gQ==
X-Google-Smtp-Source: ABdhPJxW/IKBuQbesqGO3kgP8T+UCOU7nfSM5QCDmtANUvL9RHgmlLxrVB+EsyElYkDADCFQXe+zNw==
X-Received: by 2002:a05:6512:1502:: with SMTP id bq2mr3004500lfb.551.1644445038733;
        Wed, 09 Feb 2022 14:17:18 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k21sm2527309lfg.252.2022.02.09.14.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 14:17:18 -0800 (PST)
Message-ID: <6ea0e85e-1ade-f102-86c2-4b71dbc24285@linaro.org>
Date:   Thu, 10 Feb 2022 01:17:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: gpu: drm: msm: use div64_u64() instead of do_div()
Content-Language: en-GB
To:     Qing Wang <wangqing@vivo.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1644395837-3845-1-git-send-email-wangqing@vivo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1644395837-3845-1-git-send-email-wangqing@vivo.com>
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

On 09/02/2022 11:37, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
> 
> fix do_div.cocci warning:
> do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_gpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 2c1049c..aa4617b
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -648,7 +648,7 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>   	/* Calculate the clock frequency from the number of CP cycles */
>   	if (elapsed) {
>   		clock = (stats->cpcycles_end - stats->cpcycles_start) * 1000;
> -		do_div(clock, elapsed);
> +		div64_u64(clock, elapsed);
>   	}
>   
>   	trace_msm_gpu_submit_retired(submit, elapsed, clock,


-- 
With best wishes
Dmitry
