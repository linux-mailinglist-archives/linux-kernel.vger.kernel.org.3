Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47B4DC371
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiCQKA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiCQKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:00:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFCBD3714
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:59:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r6so6581946wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUt2tWkZnzZmR22TBfzVAfjbYftNAG6kYb5PLZxCQe0=;
        b=jgPd4/lzC2G8C7BxbIVBbZg/T/CeFLTTtdnT7GDQIMkDTo3olfLtrfpc2XKCmFMmLN
         1Ova22BUpr4EodnpmV4Us7t7xKvV6+Esqjh2hNtkN1dB9CtVfUXFClvd9PfYf7z22COq
         HvGTOMyMWbS0rIEfjLDuu2TOeyboi4LUHLuIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zUt2tWkZnzZmR22TBfzVAfjbYftNAG6kYb5PLZxCQe0=;
        b=rF0NuI4pByROVxCAocK9g2n3PvO4VGxeda6hxJRU8TLuDVzdJwuTMHDUpMDtbKQHBu
         fhkAh35XeXEVy3I7UhunpzAL8JfC9wyn7eb0h3DzU/F/Rg8qAf/asOBfBeH1/TnmQ4Yr
         opIuihxfpG6yktTxEPg7fmfhwBDx0zeNcIb4wvQQrgipC7yVTLp3jc1gMyxsucDc5QYb
         M/WsLhUQb9q5+lc7cYpmucL/or2g0jjOtFEjHyF7GojbJWIkUbLkCeV6RaiPGIhtiGH3
         1wRdUU55AzhHcpWT0+SapnlrSFG7MODyfKKbc9t1Bfb81xWBZhluYxKNuW9wHsU5r/pJ
         yohA==
X-Gm-Message-State: AOAM533zwsSaDK/umS44tVA9KYq+Hi+ogSMV6NT5woW3NCwa2nDJb3ON
        tcP5COBJEWJ0hNlT60A/d8trLQ==
X-Google-Smtp-Source: ABdhPJyVRbvMqP3RkZC3MlKGRoYqlAqtY6uzXCzQNDy205UCPIRTLqvSpNmTlOSJ5ttBBEhl2Snd4A==
X-Received: by 2002:a05:6000:1688:b0:203:8efe:e0b0 with SMTP id y8-20020a056000168800b002038efee0b0mr3108580wrd.289.1647511148160;
        Thu, 17 Mar 2022 02:59:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm4016772wrs.73.2022.03.17.02.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 02:59:07 -0700 (PDT)
Date:   Thu, 17 Mar 2022 10:59:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] drm/msm/gpu: Park scheduler threads for system
 suspend
Message-ID: <YjMGac4Hnjmg1wE8@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220310234611.424743-1-robdclark@gmail.com>
 <20220310234611.424743-3-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310234611.424743-3-robdclark@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 03:46:05PM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In the system suspend path, we don't want to be racing with the
> scheduler kthreads pushing additional queued up jobs to the hw
> queue (ringbuffer).  So park them first.  While we are at it,
> move the wait for active jobs to complete into the new system-
> suspend path.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 68 ++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 8859834b51b8..0440a98988fc 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -619,22 +619,82 @@ static int active_submits(struct msm_gpu *gpu)
>  static int adreno_runtime_suspend(struct device *dev)
>  {
>  	struct msm_gpu *gpu = dev_to_gpu(dev);
> -	int remaining;
> +
> +	/*
> +	 * We should be holding a runpm ref, which will prevent
> +	 * runtime suspend.  In the system suspend path, we've
> +	 * already waited for active jobs to complete.
> +	 */
> +	WARN_ON_ONCE(gpu->active_submits);
> +
> +	return gpu->funcs->pm_suspend(gpu);
> +}
> +
> +static void suspend_scheduler(struct msm_gpu *gpu)
> +{
> +	int i;
> +
> +	/*
> +	 * Shut down the scheduler before we force suspend, so that
> +	 * suspend isn't racing with scheduler kthread feeding us
> +	 * more work.
> +	 *
> +	 * Note, we just want to park the thread, and let any jobs
> +	 * that are already on the hw queue complete normally, as
> +	 * opposed to the drm_sched_stop() path used for handling
> +	 * faulting/timed-out jobs.  We can't really cancel any jobs
> +	 * already on the hw queue without racing with the GPU.
> +	 */
> +	for (i = 0; i < gpu->nr_rings; i++) {
> +		struct drm_gpu_scheduler *sched = &gpu->rb[i]->sched;
> +		kthread_park(sched->thread);

Shouldn't we have some proper interfaces for this? Also I'm kinda
wondering how other drivers do this, feels like we should have a standard
way.

Finally not flushing out all in-flight requests sounds a bit like a bad
idea for system suspend/resume since that's also the hibernation path, and
that would mean your shrinker/page reclaim stops working. At least in full
generality. Which ain't good for hibernation.

Adding Christian and Andrey.
-Daniel

> +	}
> +}
> +
> +static void resume_scheduler(struct msm_gpu *gpu)
> +{
> +	int i;
> +
> +	for (i = 0; i < gpu->nr_rings; i++) {
> +		struct drm_gpu_scheduler *sched = &gpu->rb[i]->sched;
> +		kthread_unpark(sched->thread);
> +	}
> +}
> +
> +static int adreno_system_suspend(struct device *dev)
> +{
> +	struct msm_gpu *gpu = dev_to_gpu(dev);
> +	int remaining, ret;
> +
> +	suspend_scheduler(gpu);
>  
>  	remaining = wait_event_timeout(gpu->retire_event,
>  				       active_submits(gpu) == 0,
>  				       msecs_to_jiffies(1000));
>  	if (remaining == 0) {
>  		dev_err(dev, "Timeout waiting for GPU to suspend\n");
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out;
>  	}
>  
> -	return gpu->funcs->pm_suspend(gpu);
> +	ret = pm_runtime_force_suspend(dev);
> +out:
> +	if (ret)
> +		resume_scheduler(gpu);
> +
> +	return ret;
>  }
> +
> +static int adreno_system_resume(struct device *dev)
> +{
> +	resume_scheduler(dev_to_gpu(dev));
> +	return pm_runtime_force_resume(dev);
> +}
> +
>  #endif
>  
>  static const struct dev_pm_ops adreno_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(adreno_system_suspend, adreno_system_resume)
>  	SET_RUNTIME_PM_OPS(adreno_runtime_suspend, adreno_runtime_resume, NULL)
>  };
>  
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
