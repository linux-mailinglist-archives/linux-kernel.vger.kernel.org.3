Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263D0545156
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbiFIPzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbiFIPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:55:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7981EEED;
        Thu,  9 Jun 2022 08:55:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v14so6749107wra.5;
        Thu, 09 Jun 2022 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPTTw8mZS9qCqg/rFDlQPOOF9JZNn3O4I/G+LvFjh/Q=;
        b=QialQ71u5h76TuIsgfz8dTTuieX6GOZtpi/pEA88S5lSgzjPfNUnULivDt8ZjtB3dI
         w2nmUBrdFpsLA2f3HvxbN52Nulpu6anBFcWKoG7glkUpkkeW5Gm5DihmZq37IDWN1yCj
         F3zU+QPMH/8KPVo260ok04Z93xCfb66fWJY9TaZYzWMwJVzzxPratCF17+qvWV8ekncM
         acKNX+/0I+HxZCHM74fnO++RZjW+xKOs6cTGj6Jm2XWIWeQbNvMHmcBqV5qJZEtuLbcU
         j0HdGGdKJX7ehQLoWf6uTbbJS5VDltOz+WogObcsh20ovV76ST6GPBU978P23cPPWzQN
         KDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPTTw8mZS9qCqg/rFDlQPOOF9JZNn3O4I/G+LvFjh/Q=;
        b=OlOtMqVDBzK6+hocHB0vtRVlfcciJLN8Cy9KKi5EdaUx/KEwxedLCtlkPHclzTLUJY
         XIYn+1P2m2I8wGvy7PgzA1ckhY58zCm8fovgmy4f8iNNGKq322Ep4RxUw6AvmI3X7yel
         srH1lgpvULR3yjEqCNC3ViZY6cUbwzc2HCrZtwtLlXWjlcyYg0bP1nNtKErq3eSCgnWo
         YhNIDPqkxK1Sou8SusH4dLTedu4RPoZ7xlInwRsHL1/kSrqOK4MDHrmUh5q0+dHGw/+z
         qudi8Pst/ucbveQ0C+8XdIYagFuxHdOCVvDJmN2Wd/byJEBecdd1tscfpnpkRkWE1565
         ArRw==
X-Gm-Message-State: AOAM530YEcAGEemmxEMJi9E4GhGAexQhDvIqB3b50GJJ6KCx4vM7olfF
        B6kTAT8B7IuAHtrrxSDsWg7ljMIpkenTCmPo44w=
X-Google-Smtp-Source: ABdhPJy1Qwk8DTTOTC4BRQxtoXpppd8s00/nGGaO6B2/Pm9OwblAacmmt5Zq7YgvOZToG8V6Ig8bQnivX+/mNfU1Fas=
X-Received: by 2002:a5d:47c3:0:b0:219:b391:b748 with SMTP id
 o3-20020a5d47c3000000b00219b391b748mr4753347wrc.221.1654790099704; Thu, 09
 Jun 2022 08:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220609073317.1.Ie846c5352bc307ee4248d7cab998ab3016b85d06@changeid>
In-Reply-To: <20220609073317.1.Ie846c5352bc307ee4248d7cab998ab3016b85d06@changeid>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 9 Jun 2022 08:54:47 -0700
Message-ID: <CAF6AEGvAJqWK7peyTBDjQH_XCT3=XfqKrxsdkYD4s=DxbR4r7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Grab the GPU runtime in a6xx routines, not the
 GMU one
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Sean Paul <sean@poorly.run>, Wang Qing <wangqing@vivo.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 9, 2022 at 7:34 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> From testing on sc7180-trogdor devices, reading the GMU registers
> needs the GMU clocks to be enabled. Those clocks get turned on in
> a6xx_gmu_resume(). Confusingly enough, that function is called as a
> result of the runtime_pm of the GPU "struct device", not the GMU
> "struct device".
>
> Let's grab a reference to the correct device. Incidentally, this makes
> us match the a5xx routine more closely.
>
> This is easily shown to fix crashes that happen if we change the GPU's
> pm_runtime usage to not use autosuspend. It's also believed to fix
> some long tail GPU crashes even with autosuspend.
>
> NOTE: the crashes I've seen were fixed by _only_ fixing
> a6xx_gpu_busy(). However, I believe that the same arguments should be
> made to a6xx_gmu_set_freq() so I've changed that function too.
>
> Fixes: eadf79286a4b ("drm/msm: Check for powered down HW in the devfreq callbacks")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 +++---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 9f76f5b15759..b79ad2e0649c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -129,13 +129,13 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
>          * This can get called from devfreq while the hardware is idle. Don't
>          * bring up the power if it isn't already active
>          */
> -       if (pm_runtime_get_if_in_use(gmu->dev) == 0)
> +       if (pm_runtime_get_if_in_use(&gpu->pdev->dev) == 0)

IMHO, if we do end up using the GPU's runpm instead of the GMU's, we
should probably just move this _get_if_in_use() into msm_gpu_devfreq,
etc.  (And probably also this should be "<= 0".. I have that change
locally but haven't sent a patch yet

BR,
-R

>                 return;
>
>         if (!gmu->legacy) {
>                 a6xx_hfi_set_freq(gmu, perf_index);
>                 dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
> -               pm_runtime_put(gmu->dev);
> +               pm_runtime_put(&gpu->pdev->dev);
>                 return;
>         }
>
> @@ -159,7 +159,7 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
>                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
>
>         dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
> -       pm_runtime_put(gmu->dev);
> +       pm_runtime_put(&gpu->pdev->dev);
>  }
>
>  unsigned long a6xx_gmu_get_freq(struct msm_gpu *gpu)
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 841e47a0b06b..87568d0b6ef8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1659,7 +1659,7 @@ static u64 a6xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
>         *out_sample_rate = 19200000;
>
>         /* Only read the gpu busy if the hardware is already active */
> -       if (pm_runtime_get_if_in_use(a6xx_gpu->gmu.dev) == 0)
> +       if (pm_runtime_get_if_in_use(&gpu->pdev->dev) == 0)
>                 return 0;
>
>         busy_cycles = gmu_read64(&a6xx_gpu->gmu,
> @@ -1667,7 +1667,7 @@ static u64 a6xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
>                         REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H);
>
>
> -       pm_runtime_put(a6xx_gpu->gmu.dev);
> +       pm_runtime_put(&gpu->pdev->dev);
>
>         return busy_cycles;
>  }
> --
> 2.36.1.255.ge46751e96f-goog
>
