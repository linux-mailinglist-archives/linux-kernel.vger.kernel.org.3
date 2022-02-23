Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659F34C0A05
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiBWDMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiBWDL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:11:59 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5665EA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:11:31 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e8so14719571ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O0U/79EjLtUrpYJBtUzSqOjzMDezOuNDhWownL6VLv0=;
        b=YhceP4vMLZwowYK0g+xVT8qDOHotKWjiYCknA/tqJsbaR2OCsrpR7XrBUEfYM9CMzb
         CGlkgVhBaph2Vi6vLpTuaiKlDEv7r79u4WAL/puFusvG0VVSN+BsV6QJmMW7sLqOc+zT
         vL1/aBbzU1LJ6N/LXaspVmo4+tL2MyhG6LvRsomH+gpT9XEySRYD3i6v1vCW2vSZLxj+
         OHm6d/wKGdaq9D2OMf1jMgierxH3vzhO/G6H8bmhfoKHDKSzmYJipOfma81LlXNnG3aC
         wF8EmkZW+c0eiqC67yX/NQK8g0F+RVsdWPiJ5R9LUTsfqLymTyTPRPoykhqssON8c93t
         CgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O0U/79EjLtUrpYJBtUzSqOjzMDezOuNDhWownL6VLv0=;
        b=7B6jKkgN8mhOYhgXNEcKct3SHR/pznEQdoQahuDaYsLIFi8aVpOojQMzKYxU5qVN0m
         w+iD7j0nxbPyc5paYWyCJygRZlT4YoCSeiKTLXilqX4sZ3u9QPls0PqYZwyxSLeS2Jgd
         /ZyzRHR6w9xAnP4cPAPGjVItRcg6ylCT1B8W4kvYEQ++CUPFz7GaVJP/MjPafzApwY8e
         NciOoxYiReBDYpFOWc+Z7Xt2x29gYX/jVSpOtbgaa3iPeTxgmiFGoRW1fnfl1/YG2g5Z
         1BODqunkEJ0eoHXoyvhW6BpQQOq5mx0NOOL1nKowe4yMZUipJ8evE6WdulakbUNSJuLG
         KdZA==
X-Gm-Message-State: AOAM5329IbSc+qLky5hzsAdsrKo6PazOiIYmCriiip3fJxdiD0hPXgxR
        gz9tgboB9l3oX2yvou0F+Is7Mg==
X-Google-Smtp-Source: ABdhPJxOawgiicXBd03JJbBfMaaHtv4v26OmN6NlFSWWnE5H+9tb28Xe+ocBCmmRqjy2yQQ+xmbniw==
X-Received: by 2002:a2e:7009:0:b0:244:d483:b2b1 with SMTP id l9-20020a2e7009000000b00244d483b2b1mr20644597ljc.308.1645585889812;
        Tue, 22 Feb 2022 19:11:29 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y27sm1954570ljd.33.2022.02.22.19.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 19:11:29 -0800 (PST)
Message-ID: <6f1225ea-d889-9cf8-3a3d-181e319bd453@linaro.org>
Date:   Wed, 23 Feb 2022 06:11:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220219183310.557435-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220219183310.557435-1-robdclark@gmail.com>
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

On 19/02/2022 21:33, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Avoid going down devfreq paths on devices where devfreq is not
> initialized.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_gpu_devfreq.c | 31 +++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> index 9bf319be11f6..26a3669a97b3 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> @@ -83,12 +83,17 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
>   static void msm_devfreq_boost_work(struct kthread_work *work);
>   static void msm_devfreq_idle_work(struct kthread_work *work);
>   
> +static bool has_devfreq(struct msm_gpu *gpu)
> +{
> +	return !!gpu->funcs->gpu_busy;

I see that devfreq init will be skipped if gpu_busy is NULL.
Can we use gpu->devfreq instead of this condition?

I noticed that you have replaced some of gpu->devfreq checks with 
has_devreq() calls. Is there any difference?

> +}
> +
>   void msm_devfreq_init(struct msm_gpu *gpu)
>   {
>   	struct msm_gpu_devfreq *df = &gpu->devfreq;
>   
>   	/* We need target support to do devfreq */
> -	if (!gpu->funcs->gpu_busy)
> +	if (!has_devfreq(gpu))
>   		return;
>   
>   	dev_pm_qos_add_request(&gpu->pdev->dev, &df->idle_freq,
> @@ -149,6 +154,9 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
>   {
>   	struct msm_gpu_devfreq *df = &gpu->devfreq;
>   
> +	if (!has_devfreq(gpu))
> +		return;
> +
>   	devfreq_cooling_unregister(gpu->cooling);
>   	dev_pm_qos_remove_request(&df->boost_freq);
>   	dev_pm_qos_remove_request(&df->idle_freq);
> @@ -156,16 +164,24 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
>   
>   void msm_devfreq_resume(struct msm_gpu *gpu)
>   {
> -	gpu->devfreq.busy_cycles = 0;
> -	gpu->devfreq.time = ktime_get();
> +	struct msm_gpu_devfreq *df = &gpu->devfreq;
>   
> -	devfreq_resume_device(gpu->devfreq.devfreq);
> +	if (!has_devfreq(gpu))
> +		return;
> +
> +	df->busy_cycles = 0;
> +	df->time = ktime_get();
> +
> +	devfreq_resume_device(df->devfreq);
>   }
>   
>   void msm_devfreq_suspend(struct msm_gpu *gpu)
>   {
>   	struct msm_gpu_devfreq *df = &gpu->devfreq;
>   
> +	if (!has_devfreq(gpu))
> +		return;
> +
>   	devfreq_suspend_device(df->devfreq);
>   
>   	cancel_idle_work(df);
> @@ -185,6 +201,9 @@ void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor)
>   	struct msm_gpu_devfreq *df = &gpu->devfreq;
>   	uint64_t freq;
>   
> +	if (!has_devfreq(gpu))
> +		return;
> +
>   	freq = get_freq(gpu);
>   	freq *= factor;
>   
> @@ -207,7 +226,7 @@ void msm_devfreq_active(struct msm_gpu *gpu)
>   	struct devfreq_dev_status status;
>   	unsigned int idle_time;
>   
> -	if (!df->devfreq)
> +	if (!has_devfreq(gpu))
>   		return;
>   
>   	/*
> @@ -253,7 +272,7 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
>   {
>   	struct msm_gpu_devfreq *df = &gpu->devfreq;
>   
> -	if (!df->devfreq)
> +	if (!has_devfreq(gpu))
>   		return;
>   
>   	msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),


-- 
With best wishes
Dmitry
