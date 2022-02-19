Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9C4BC9F1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbiBSShM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:37:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiBSShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:37:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307BB22BD7;
        Sat, 19 Feb 2022 10:36:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso10829347wmq.4;
        Sat, 19 Feb 2022 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAZG7JbLQbeA7Yj+mlgqX0k/1mUajJPRecROZ8iw+8c=;
        b=OJkpULWy9BPv8scnQFQP2MQL1Ele2xge0o1Pj1x9KMbJpLTUJkfiqfOhC8PZShcBpk
         USH+xwYud1/tctwvjUFm4YSlNGlPl1+sidtvBa/dgyDHyKaOUuSfW3pczbOlDssg4cVp
         gzZa1HsPNwCi4Ih5A449CLnvRVQKmMQ7IeiaI90t+1NT1GBWQTitdtMDZOsjU5s9nLbh
         bZ1SUilCoBwTMCAMziP4GMfswYU39HlTxFDjXpgkX9tTPS7UPzqwjbYVuBjISxniMmI/
         wah3lBe/4YtVwzOcDzO3QHVqPUxUBsyRHMuJP9qBc3YYLiTVZFSGNab2SxKJSLd2LC1x
         oD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAZG7JbLQbeA7Yj+mlgqX0k/1mUajJPRecROZ8iw+8c=;
        b=z7ooAE5GhhcJWneuisnLrdk4lZ8IDVYxqAIB+fi3/XY74r9vqaCBqErmdc4nVtPc0G
         ckIeNkBlJF4DGH9R564SHAtAmNKWRuKHbSvR4hP3vTOicAyswvtKjiKDevYbWCpcT1DU
         dhEohF3cJfH43jti2CBUqIg0/hfSE6OeUzzC1YzRM0ulvdYDK51ZTx0bN6yvgYyYi1ey
         lqjAddWDkNYLeR/uZtBZ0AeRPT56oabN69xiHZtSdnUy+fOxLKIi1ua9Wrecwnaz2lja
         RJ7i7/uTUnveVa3y1tdty4zIj4bo3w9GVe5X7tCcR1Q28kKwaX8inTWFuWv7fjURRezI
         pEsg==
X-Gm-Message-State: AOAM5326dMo4WZBAlGu0sVkJoTQhad5uJh7uC7cJ6k2NB5Jhswetp8ps
        HL6A84opo43XDf6WfKaHobse7YnBcmpBvcJlT9M=
X-Google-Smtp-Source: ABdhPJyhZ8HikhSS8fR813GuqsYCfEmMiKIonHQ8cVxp0BFB8dDWVsnhF7MitnZKn+FSIYqhR59KYeBOOaChHlUi2dU=
X-Received: by 2002:a05:600c:1e0a:b0:37d:342c:36ac with SMTP id
 ay10-20020a05600c1e0a00b0037d342c36acmr11851160wmb.168.1645295809620; Sat, 19
 Feb 2022 10:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20220219183310.557435-1-robdclark@gmail.com>
In-Reply-To: <20220219183310.557435-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sat, 19 Feb 2022 10:37:09 -0800
Message-ID: <CAF6AEGviF8r=0gyqh6wWCc5O+JCJwgjLVrL-K3qfVXUvRH-ZDw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 10:32 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Avoid going down devfreq paths on devices where devfreq is not
> initialized.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>

forgot to add:

Fixes: 6aa89ae1fb04 ("drm/msm/gpu: Cancel idle/boost work on suspend")

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 31 +++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> index 9bf319be11f6..26a3669a97b3 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> @@ -83,12 +83,17 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
>  static void msm_devfreq_boost_work(struct kthread_work *work);
>  static void msm_devfreq_idle_work(struct kthread_work *work);
>
> +static bool has_devfreq(struct msm_gpu *gpu)
> +{
> +       return !!gpu->funcs->gpu_busy;
> +}
> +
>  void msm_devfreq_init(struct msm_gpu *gpu)
>  {
>         struct msm_gpu_devfreq *df = &gpu->devfreq;
>
>         /* We need target support to do devfreq */
> -       if (!gpu->funcs->gpu_busy)
> +       if (!has_devfreq(gpu))
>                 return;
>
>         dev_pm_qos_add_request(&gpu->pdev->dev, &df->idle_freq,
> @@ -149,6 +154,9 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
>  {
>         struct msm_gpu_devfreq *df = &gpu->devfreq;
>
> +       if (!has_devfreq(gpu))
> +               return;
> +
>         devfreq_cooling_unregister(gpu->cooling);
>         dev_pm_qos_remove_request(&df->boost_freq);
>         dev_pm_qos_remove_request(&df->idle_freq);
> @@ -156,16 +164,24 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
>
>  void msm_devfreq_resume(struct msm_gpu *gpu)
>  {
> -       gpu->devfreq.busy_cycles = 0;
> -       gpu->devfreq.time = ktime_get();
> +       struct msm_gpu_devfreq *df = &gpu->devfreq;
>
> -       devfreq_resume_device(gpu->devfreq.devfreq);
> +       if (!has_devfreq(gpu))
> +               return;
> +
> +       df->busy_cycles = 0;
> +       df->time = ktime_get();
> +
> +       devfreq_resume_device(df->devfreq);
>  }
>
>  void msm_devfreq_suspend(struct msm_gpu *gpu)
>  {
>         struct msm_gpu_devfreq *df = &gpu->devfreq;
>
> +       if (!has_devfreq(gpu))
> +               return;
> +
>         devfreq_suspend_device(df->devfreq);
>
>         cancel_idle_work(df);
> @@ -185,6 +201,9 @@ void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor)
>         struct msm_gpu_devfreq *df = &gpu->devfreq;
>         uint64_t freq;
>
> +       if (!has_devfreq(gpu))
> +               return;
> +
>         freq = get_freq(gpu);
>         freq *= factor;
>
> @@ -207,7 +226,7 @@ void msm_devfreq_active(struct msm_gpu *gpu)
>         struct devfreq_dev_status status;
>         unsigned int idle_time;
>
> -       if (!df->devfreq)
> +       if (!has_devfreq(gpu))
>                 return;
>
>         /*
> @@ -253,7 +272,7 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
>  {
>         struct msm_gpu_devfreq *df = &gpu->devfreq;
>
> -       if (!df->devfreq)
> +       if (!has_devfreq(gpu))
>                 return;
>
>         msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
> --
> 2.34.1
>
