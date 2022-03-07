Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6E4CF3C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiCGIi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCGIiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:38:24 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC9B1C6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:37:28 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2d6d0cb5da4so154735737b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6x5yVDLBVFqVJQNZ+OEdQbw27fgZWH2Vrmnv9e+WIA=;
        b=oNhgYRxfC5S7Flav03PFuf0rKKCE1fufuLFFan6hXVBjpSOfsSMnXBp4h2wik/njKd
         91RQgRcuaWeCEIreQbS23aCelM6cQM927Z6zYvena3xPhX/EbcZYVf1pXWn/UHGguVqO
         K2dcx/WFIciVIgUJg6j2gunB1QhflbZ9WWaz5mhcysoBCYf4XbjaXP2arDS86gyk6Whv
         Fy0TdFWNL6/dvv3rSHgocQnjfmtxiXyjTLLdqb6oxObw0ZLXSd2iTALIhmrpIPhT4yhx
         LPRRT2WhEJDGKz3oI1Udexe3bON05QXHXPqDUhbfXuQVslCHzamXeETBxry7RtIbIAS2
         xMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6x5yVDLBVFqVJQNZ+OEdQbw27fgZWH2Vrmnv9e+WIA=;
        b=8Q9r+oAa3UC/F4lF3r1wGOZ/wDAUIix0HPp3oNLFTMe+cd+g5NeEY4EYuq7U3oSqZO
         StwuzeIRn5IKg/JWEmopI3Rszdb9gZslWZtD1uREfGn/U2HWitXR6VknTxPLkCTgbNfz
         IRt0xhNfsvsN2yGKkkQPvx/HXvZpbTODQarQ+B+D+eBSqm5snItJJMZbo3eDHgjYCLI6
         C0mcu8vMkWkrLEc8R9tbVhkvnAuPyGCPeJzPuMW7Ez0hpq5WD+KYVXyez8zjKgoQg96w
         u7RBCVbZu+/+1MqZsNB53dr47smPUbTcxHe9vK+oUygD8TvoZU3EiDmXaoATjPoMU1M0
         z5Sg==
X-Gm-Message-State: AOAM532B/g1khjy3VkdMQcVONODiGCHI5o7qLEWCxr+EVq6ijoRPGk4y
        N20dOfJN96ZPBkDrqcIrutBQPWNCwHsAB52QTXVOocmI548V8j3k
X-Google-Smtp-Source: ABdhPJxkcnqrAUZ0/BuHe0V4d9rKIzD/3EzUc+kmn55bYHjaih5zVBAoZ44017nG3klZVXrKnoyRs3z6yh7rXxMOItE=
X-Received: by 2002:a81:c45:0:b0:2dc:59c4:3555 with SMTP id
 66-20020a810c45000000b002dc59c43555mr7687451ywm.36.1646642247656; Mon, 07 Mar
 2022 00:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20220219183310.557435-1-robdclark@gmail.com>
In-Reply-To: <20220219183310.557435-1-robdclark@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 7 Mar 2022 14:07:16 +0530
Message-ID: <CA+G9fYv6dPUsPzbFLr9PxJoe4eRAUdQyD4xT4hh4-xw=n9r=Bw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sun, 20 Feb 2022 at 00:02, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Avoid going down devfreq paths on devices where devfreq is not
> initialized.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

I have tested this patch and the reported kernel crash is fixed [1].

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

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


--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4664600#L1894
