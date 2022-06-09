Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1C65453CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345275AbiFISML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbiFISMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:12:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32623AD8AC;
        Thu,  9 Jun 2022 11:12:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c21so383561wrb.1;
        Thu, 09 Jun 2022 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7S2ceE7woIMIKL2mO+qhG9DggNJZRzCyjYT++CIPsP0=;
        b=VShGNdmPe5Ks9p3j3gghuphe1A+GdpCaffaHxCr6UiuN9pqECJ2MWvjqBdlsDXMsyH
         S8R9knU06ocOFSSXI4j5op6AJT9LI9/NrMUut81/RtI5m7FxWXvlos9r/WD2l9L5qFw8
         Vw6f6XurBOU2w/zYkO6XRBXSwwqjKeh3tIvoldR+0R3DL1pNkhzZGzh6bWAcaCXFRi79
         hJoM+GnfgC1hCuOdAAt7KzIlUbbJJfJ1dD+/V2BSIiRGwua7GyqcWLIe4kPQikt84lkF
         g9OyNmQyuuV+IvbmTM2YE163d0qicOp6STsqwj6xtmwiTIzbUIfCnMrUH9mohiix6nzL
         rOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7S2ceE7woIMIKL2mO+qhG9DggNJZRzCyjYT++CIPsP0=;
        b=f2lvISSxNhzy9t3geuzonQqKOSK66FQFjQ4Qd9VZBX3cRx9AEFCipeYGiMQmrU5WAS
         n7GEStn6awM4d0gu/V07pHKLFowKsLgSoECibIBApzfKnvGecC0XiZvV7ildOxCumL4i
         kbQM5EYoXuPuKkx6FSMQ8301Iolg2CSLQ1cTOFw8wTNFtHVD48W1K3vbHVsmpjWfe56T
         TF/Pebc53rKum/4rnq6qxA/TQaoZjxbIal4YWP49YPSzxTUuKq9ZJF2tF7g59cUyVlQG
         wT7hA/d8c4xE2YzR4aC4MmPDcmMUMNfGSkn2WLIljWJ6wyjWdE71YQ0iuj3WXcud3BW7
         zL0A==
X-Gm-Message-State: AOAM530KlwWnP0PSCWbYOQNCUFxVEQSstY0tZDjnVQn8e1fJsmvAUokK
        jkZL/2zS9mVaGMfaO6kf9aLjbnq4iDYGOx4x398=
X-Google-Smtp-Source: ABdhPJwD7FKBXrJFMbznl/HrU3Hzhn/j7/p5HiR1eA4JgejzkmBEL5sdzRlQV9VVsmRRTQ1YGu9EohS8AxoJuTW+qgc=
X-Received: by 2002:a5d:6487:0:b0:218:35ed:d4ea with SMTP id
 o7-20020a5d6487000000b0021835edd4eamr25251350wri.344.1654798319418; Thu, 09
 Jun 2022 11:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220609094716.v2.1.Ie846c5352bc307ee4248d7cab998ab3016b85d06@changeid>
 <a4abf2dd-7bb9-2638-9684-8c140a22491e@quicinc.com>
In-Reply-To: <a4abf2dd-7bb9-2638-9684-8c140a22491e@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 9 Jun 2022 11:12:03 -0700
Message-ID: <CAF6AEGs3aLoAiiA1hMFu_k6oBAs1bA6Htu3BRFjkg0eU72-1Zw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm: Grab the GPU runtime in a6xx routines, not
 the GMU one
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
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

On Thu, Jun 9, 2022 at 11:04 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 6/9/2022 10:17 PM, Douglas Anderson wrote:
> > >From testing on sc7180-trogdor devices, reading the GMU registers
> > needs the GMU clocks to be enabled. Those clocks get turned on in
> > a6xx_gmu_resume(). Confusingly enough, that function is called as a
> > result of the runtime_pm of the GPU "struct device", not the GMU
> > "struct device".
> >
> > Let's grab a reference to the correct device. Incidentally, this makes
> > us match the a5xx routine more closely.
> >
> > This is easily shown to fix crashes that happen if we change the GPU's
> > pm_runtime usage to not use autosuspend. It's also believed to fix
> > some long tail GPU crashes even with autosuspend.
> >
> > NOTE: the crashes I've seen were fixed by _only_ fixing
> > a6xx_gpu_busy(). However, I believe that the same arguments should be
> > made to a6xx_gmu_set_freq() so I've fixed that case too. To make that
> > fix clean, we've moved the pm runtime grabbing into the GPU file.
> >
> > As a bonus fix with this change, we change the pm_runtime get
> > functions to check for <= 0 instead of ==. This handles the case where
> > pm_runtime is disabled.
> >
> > Fixes: eadf79286a4b ("drm/msm: Check for powered down HW in the devfreq callbacks")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Move the set_freq runtime pm grab to the GPU file.
> > - Use <= for the pm_runtime test, not ==.
> >
> >   drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  9 ---------
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 13 +++++++++++--
> >   2 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > index 9f76f5b15759..2410815e77b4 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > @@ -125,17 +125,9 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
> >
> >       trace_msm_gmu_freq_change(gmu->freq, perf_index);
> >
> > -     /*
> > -      * This can get called from devfreq while the hardware is idle. Don't
> > -      * bring up the power if it isn't already active
> > -      */
> > -     if (pm_runtime_get_if_in_use(gmu->dev) == 0)
> > -             return;
> > -
> >       if (!gmu->legacy) {
> >               a6xx_hfi_set_freq(gmu, perf_index);
> >               dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
> > -             pm_runtime_put(gmu->dev);
> >               return;
> >       }
> >
> > @@ -159,7 +151,6 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
> >               dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
> >
> >       dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
> > -     pm_runtime_put(gmu->dev);
> >   }
> >
> >   unsigned long a6xx_gmu_get_freq(struct msm_gpu *gpu)
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index 42ed9a3c4905..54efd9b76ea6 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -1659,7 +1659,7 @@ static u64 a6xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
> >       *out_sample_rate = 19200000;
> >
> >       /* Only read the gpu busy if the hardware is already active */
> > -     if (pm_runtime_get_if_in_use(a6xx_gpu->gmu.dev) == 0)
> > +     if (pm_runtime_get_if_in_use(&gpu->pdev->dev) <= 0)
> You are changing the behavior here when CONFIG_PM is not enabled.

I'd guess the odds of anything working with PM=n are low

BR,
-R

> -Akhil.
> >               return 0;
> >
> >       busy_cycles = gmu_read64(&a6xx_gpu->gmu,
> > @@ -1667,7 +1667,7 @@ static u64 a6xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
> >                       REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H);
> >
> >
> > -     pm_runtime_put(a6xx_gpu->gmu.dev);
> > +     pm_runtime_put(&gpu->pdev->dev);
> >
> >       return busy_cycles;
> >   }
> > @@ -1677,9 +1677,18 @@ static void a6xx_gpu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
> >       struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> >       struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> >
> > +     /*
> > +      * This can get called from devfreq while the hardware is idle. Don't
> > +      * bring up the power if it isn't already active
> > +      */
> > +     if (pm_runtime_get_if_in_use(&gpu->pdev->dev) <= 0)
> > +             return;
> > +
> >       mutex_lock(&a6xx_gpu->gmu.lock);
> >       a6xx_gmu_set_freq(gpu, opp);
> >       mutex_unlock(&a6xx_gpu->gmu.lock);
> > +
> > +     pm_runtime_put(&gpu->pdev->dev);
> >   }
> >
> >   static struct msm_gem_address_space *
>
