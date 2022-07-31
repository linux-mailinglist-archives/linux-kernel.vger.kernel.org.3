Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B71585FC4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiGaQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiGaQVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:21:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BE6DEED;
        Sun, 31 Jul 2022 09:21:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id w15so789800ljw.1;
        Sun, 31 Jul 2022 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1dGgr0VFGhtLTw2WM/wkztVN6+uje12KM3x5Hxm7DpY=;
        b=i1jAsSiXu3PQvri9Z/MuZh+vK5x12l8cIaezT5HNPS1Vviev0rbKRxjkkZ/EYJ8dcL
         iA9lw0FsFxdqyITig7Ec0qyXRWHo501j0vBocGeijZhsUQ8V79q5lWJxXgvEohqHkCYs
         HRIVOAYKs2ZIjBBLle2wIQl3yRT9hdAV1k1m/4qxqCx6DX2H8+iC92PQRXBRXKKPoPwj
         rEuLISo8Mingm2dpOZ6QpBbRdMgOZmoujhhYj5z2KnLBIbkMLEk4OgV2K8QeDb93a4Ss
         vBrcqcKn0QvaVOAS87nc4wWY3wYAiA2dhhFgLsd+d/F7FH6NMAFSQoQ2YAP6M0n0Yy+0
         qnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1dGgr0VFGhtLTw2WM/wkztVN6+uje12KM3x5Hxm7DpY=;
        b=7pvwYdOxKHGlknxMVKd9dvEq+HUBaGazRFRMp1gnkdj/DisZ4cJ5f3wDTmwfW/ApAE
         4K6pfUNc33CT/ulQUWYYOnW8J8vWT2mdS7LAGEcgaEeYhrkRml+qvWAKjx4pSFYdhcyR
         fCnkcHTqCEZV8mRCu+3fVsc9J+uqB3cIYWGmIAyc0EqFvLxz2WaC9QDojiY8MXiL2F89
         rWpSODcA3saZDMqRynFRirOLLo5PMHk8TaR2CCTXFvilJpOW7T18UK4Rm+pMNRaN7RgC
         jV24OZi4jHhuIiC6Eq2yXtK70Wb6usjmDTXxcp772s9wzOvFw8dMla2bC9/V4qpzKEHi
         BI+A==
X-Gm-Message-State: AJIora81pfALrPnBTh/6rbk3z9LgjQ6oh1BoH/uwGd4Uur+qsI6sxKgr
        GCNj0lutJxvVBHUDlhZSJ0JKhUcCdMAT+H6nXskPtQq7
X-Google-Smtp-Source: AGRyM1v+yPpDbh2c87EFdbeSWze9wULevLuMgW2bBkxqcwF4j94LzukBIAA/N/t/dIwMG5UY2tNq8LtBbuUZEo5uFEk=
X-Received: by 2002:a05:651c:1993:b0:25e:2766:924 with SMTP id
 bx19-20020a05651c199300b0025e27660924mr4343788ljb.231.1659284499650; Sun, 31
 Jul 2022 09:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com> <20220730150952.v3.4.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
In-Reply-To: <20220730150952.v3.4.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 31 Jul 2022 09:22:04 -0700
Message-ID: <CAF6AEGuqptUzOtcjG+oA4BQha3Jk-UzDK-8SF_8v5A+8Dg71uQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] drm/msm: Fix cx collapse issue during recovery
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 2:41 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> There are some hardware logic under CX domain. For a successful
> recovery, we should ensure cx headswitch collapses to ensure all the
> stale states are cleard out. This is especially true to for a6xx family
> where we can GMU co-processor.
>
> Currently, cx doesn't collapse due to a devlink between gpu and its
> smmu. So the *struct gpu device* needs to be runtime suspended to ensure
> that the iommu driver removes its vote on cx gdsc.
>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>
> Changes in v3:
> - Simplied the pm refcount drop since we have just a single refcount now
> for all active submits
>
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 24 +++++++++++++++++++++---
>  drivers/gpu/drm/msm/msm_gpu.c         |  4 +---
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 42ed9a3..1b049c5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1193,7 +1193,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>         struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> -       int i;
> +       int i, active_submits;
>
>         adreno_dump_info(gpu);
>
> @@ -1210,8 +1210,26 @@ static void a6xx_recover(struct msm_gpu *gpu)
>          */
>         gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
>
> -       gpu->funcs->pm_suspend(gpu);
> -       gpu->funcs->pm_resume(gpu);
> +       pm_runtime_dont_use_autosuspend(&gpu->pdev->dev);
> +
> +       /* active_submit won't change until we make a submission */
> +       mutex_lock(&gpu->active_lock);
> +       active_submits = gpu->active_submits;
> +       mutex_unlock(&gpu->active_lock);
> +
> +       /* Drop the rpm refcount from active submits */
> +       if (active_submits)
> +               pm_runtime_put(&gpu->pdev->dev);

Couldn't this race with an incoming submit triggering active_submits
to transition 0 -> 1?  Moving the mutex_unlock() would solve this.

Actually, maybe just move the mutex_unlock() to the end of the entire
sequence.  You could also clear gpu->active_submits and restore it
before unlocking, so you can drop the removal of the WARN_ON_ONCE
(patch 6/8) which should otherwise be squashed into this patch to keep
things bisectable

> +
> +       /* And the final one from recover worker */
> +       pm_runtime_put_sync(&gpu->pdev->dev);
> +
> +       pm_runtime_use_autosuspend(&gpu->pdev->dev);
> +
> +       if (active_submits)
> +               pm_runtime_get(&gpu->pdev->dev);
> +
> +       pm_runtime_get_sync(&gpu->pdev->dev);
>
>         msm_gpu_hw_init(gpu);
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 1945efb..07e55a6 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -426,9 +426,7 @@ static void recover_worker(struct kthread_work *work)
>                 /* retire completed submits, plus the one that hung: */
>                 retire_submits(gpu);
>
> -               pm_runtime_get_sync(&gpu->pdev->dev);
>                 gpu->funcs->recover(gpu);
> -               pm_runtime_put_sync(&gpu->pdev->dev);

Hmm, could this have some fallout on earlier gens?

I guess I should extend the igt msm_recovery test to run on things
prior to a6xx..

BR,
-R

>
>                 /*
>                  * Replay all remaining submits starting with highest priority
> @@ -445,7 +443,7 @@ static void recover_worker(struct kthread_work *work)
>                 }
>         }
>
> -       pm_runtime_put_sync(&gpu->pdev->dev);
> +       pm_runtime_put(&gpu->pdev->dev);
>
>         mutex_unlock(&gpu->lock);
>
> --
> 2.7.4
>
