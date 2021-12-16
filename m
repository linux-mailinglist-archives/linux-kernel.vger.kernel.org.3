Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD2B4767C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhLPCMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhLPCMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:12:42 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089F9C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:12:41 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a37so35042189ljq.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oN/BkkxAzh0TiMVlSBz5FLbx67Y+EoaSkeGmdT8a2+8=;
        b=hqMjUvbseGgiGYDl5Qbaq4vQtnZIGaJQXqPHIq4tnU6P7v+h++jnmsE4PxuiA+AH8N
         /VM9sAODroW2HZ09MIr5DM4idU9+EI/mt6VAl7mSUjvsoVI229LH2eqNkLZjCthCYotX
         PXLS4Vro8Kmeox/ihgl55IUOWY6C263GJ0xqxHrp/5liDKyPqD5TI5AZmpxN0n4MBnJ8
         75ioiYeFBomV0uBquc5/Y0QjNaBfNvzxDVt28p31WJNdlueFp739E2MpwaEs09V1Vi1f
         3h9JzIHtOX48MibsEofJIAqAECm+1R6XVSGZZz0+O+ibY7pR5kwPrkM5Og3Ax+otckMJ
         9c0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oN/BkkxAzh0TiMVlSBz5FLbx67Y+EoaSkeGmdT8a2+8=;
        b=GUB2PdVKCqR+95nSpI3W6FMjbxz6kA09R7epFi/DSGDgc7TBrC4261KOdrr06XnNVu
         ehLq2OfVnE3te88ELRSN8FhURlAVP2lrOArYDQjj10/zcBcoqL3pRe+DnoE8Oq8FECye
         9vY4OTKHUJKEpH73RsjYiMNPTNStYyBEeWFYT728fp6t++Sgz8CWrS6OrHFzzvy+Alpi
         ZsZZPweVHaE08y087BvghPGTCDbC0qdmeEr5aJy/GTWR4xL8/V77ofz7hjG8PScaIfne
         2am0q9czEDw3NYpMCpo+12Dq+G4hV+lDTRDZxj5MqbnJfZ5guPVn/X8KFu0ZiwlDRs8e
         H79A==
X-Gm-Message-State: AOAM531gXxBdqR0BLVhqypYUvW4JQuWQzQ34mEth14sHWua8oMPMnYcJ
        klawoAPPvNmo0O65FmbcJOA42w==
X-Google-Smtp-Source: ABdhPJwFkqpGRH3//LQhIXXRkFcjQiigOlWwY/xfN/YQ/h/cjLG5rE/ffQ/Bqh+WemHQh9E+4OLXCw==
X-Received: by 2002:a2e:b163:: with SMTP id a3mr13430601ljm.264.1639620760128;
        Wed, 15 Dec 2021 18:12:40 -0800 (PST)
Received: from ?IPV6:2001:470:dd84:abc0::8a5? ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id m3sm798052lji.112.2021.12.15.18.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 18:12:39 -0800 (PST)
Message-ID: <ccd98cd9-f8c1-d4df-3849-3844e8b82e89@linaro.org>
Date:   Thu, 16 Dec 2021 05:12:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/3] drm/msm/disp: Export helper for capturing snapshot
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211215174524.1742389-1-robdclark@gmail.com>
 <20211215174524.1742389-3-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211215174524.1742389-3-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 20:45, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> We'll re-use this for debugfs.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/disp/msm_disp_snapshot.c | 28 +++++++++++++++-----
>   drivers/gpu/drm/msm/disp/msm_disp_snapshot.h | 10 +++++++
>   2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> index a4a7cb06bc87..580ea01b13ab 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> @@ -28,29 +28,43 @@ static ssize_t __maybe_unused disp_devcoredump_read(char *buffer, loff_t offset,
>   	return count - iter.remain;
>   }
>   
> -static void _msm_disp_snapshot_work(struct kthread_work *work)
> +struct msm_disp_state *
> +msm_disp_snapshot_state_sync(struct msm_kms *kms)
>   {
> -	struct msm_kms *kms = container_of(work, struct msm_kms, dump_work);
>   	struct drm_device *drm_dev = kms->dev;
>   	struct msm_disp_state *disp_state;
> -	struct drm_printer p;
> +
> +	WARN_ON(!mutex_is_locked(&kms->dump_mutex));
>   
>   	disp_state = kzalloc(sizeof(struct msm_disp_state), GFP_KERNEL);
>   	if (!disp_state)
> -		return;
> +		return ERR_PTR(-ENOMEM);
>   
>   	disp_state->dev = drm_dev->dev;
>   	disp_state->drm_dev = drm_dev;
>   
>   	INIT_LIST_HEAD(&disp_state->blocks);
>   
> -	/* Serialize dumping here */
> -	mutex_lock(&kms->dump_mutex);
> -
>   	msm_disp_snapshot_capture_state(disp_state);
>   
> +	return disp_state;
> +}
> +
> +static void _msm_disp_snapshot_work(struct kthread_work *work)
> +{
> +	struct msm_kms *kms = container_of(work, struct msm_kms, dump_work);
> +	struct drm_device *drm_dev = kms->dev;

drivers/gpu/drm/msm/disp/msm_disp_snapshot.c:56:28: warning: unused 
variable ‘drm_dev’ [-Wunused-variable]
    56 |         struct drm_device *drm_dev = kms->dev;

I will apply the fixup locally.

> +	struct msm_disp_state *disp_state;
> +	struct drm_printer p;
> +
> +	/* Serialize dumping here */
> +	mutex_lock(&kms->dump_mutex);
> +	disp_state = msm_disp_snapshot_state_sync(kms);
>   	mutex_unlock(&kms->dump_mutex);
>   
> +	if (IS_ERR(disp_state))
> +		return;
> +
>   	if (MSM_DISP_SNAPSHOT_DUMP_IN_CONSOLE) {
>   		p = drm_info_printer(disp_state->drm_dev->dev);
>   		msm_disp_state_print(disp_state, &p);
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
> index 31ad68be3391..b5f452bd7ada 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
> @@ -84,6 +84,16 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev);
>    */
>   void msm_disp_snapshot_destroy(struct drm_device *drm_dev);
>   
> +/**
> + * msm_disp_snapshot_state_sync - synchronously snapshot display state
> + * @kms:  the kms object
> + *
> + * Returns state or error
> + *
> + * Must be called with &kms->dump_mutex held
> + */
> +struct msm_disp_state *msm_disp_snapshot_state_sync(struct msm_kms *kms);
> +
>   /**
>    * msm_disp_snapshot_state - trigger to dump the display snapshot
>    * @drm_dev:	handle to drm device
> 


-- 
With best wishes
Dmitry
