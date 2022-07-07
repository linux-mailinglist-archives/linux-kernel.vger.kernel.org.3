Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6CB56A926
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbiGGRKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiGGRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:10:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B82C65E;
        Thu,  7 Jul 2022 10:10:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p4so1740327wms.0;
        Thu, 07 Jul 2022 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VA3SbJt6EBSMC9jnydWIaREGnbjiJhUGWyogd1VBc60=;
        b=bFUBCIKLe6IQ6qKpFInDA68vnotWBxMQeNgiY+32c5hZkyDPLBon+btxmBjOaT4Y00
         JEGKosj0QpNEYt24iNH0xhzZFolz6hudOUcUNksNXyUHGLj0VzjJJrQdoICPPCeQAoH0
         DNvlgcB66YwPwmwNcbRIrvhSVV1O2QMWt3cEd+xRKme9rXjw1u541IIxhfiBT+M0zYzF
         Mqaras7dlF18CgSZuMfGSCvJ5Z8yuTSqJm/NBEIIdZ0jcHSzXf7rD1600FpqAYDYVz37
         VcIBDJZVjXEDiihGtQUD991TWP3ma0P3tfhIYqHjumqI0h3Y8MFStDNct6Mqh9AEK/bq
         I9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VA3SbJt6EBSMC9jnydWIaREGnbjiJhUGWyogd1VBc60=;
        b=yotboA+zNabKqkvIrAcpVN69GKoODNhAjSN7Mj8t5se0Z1kTk+6G/FRVSFWEUP0Lho
         DOxVyty0/cFdjBi9H7lZRUFpSF3JYbFJuUVDcrurMJrPKz4+eAjmDprgYt+PNjTmke85
         6+Jy3UBlnPbf1ll9qtzU3Ox76QD3r5ic/FvYf0avbt5Min6gWIYGFzh9597FRS625KDV
         FPQe/YgyQXzb9xW/fWpEi7JbuG4p0FLJ5N3AlC03CuhbqS1sJ2BBcqPFsqsdfhkkLZbZ
         lIB4W6iA8xIwLf1NeMxIVP1yfH+XcP+5ze4w086BsTd9GBUK2O2XxKJOf1XW5Vw8VEZC
         KIIg==
X-Gm-Message-State: AJIora+LMSy0jXCNjT8XayIGcz3UKnZX7xWwRy8/ox7Ta+/NaKQzl0bY
        K6exh4oncB7mZHX7cvegqm7JISPiB2O4w2+KBV9RIp1LjoQ=
X-Google-Smtp-Source: AGRyM1uKOuyzI23A8kLJo8W49G7VbTQ+827LPYXQYYmMTeuOaUGs/FqsFT/Z7LFMdUkclpe5ALdeM3qoqjfBfNwZMXk=
X-Received: by 2002:a05:600c:3593:b0:3a1:8909:b5b2 with SMTP id
 p19-20020a05600c359300b003a18909b5b2mr5728498wmq.77.1657213813592; Thu, 07
 Jul 2022 10:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <1657210262-17166-1-git-send-email-quic_akhilpo@quicinc.com> <20220707213950.3.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
In-Reply-To: <20220707213950.3.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 7 Jul 2022 10:10:01 -0700
Message-ID: <CAF6AEGudkkUvYjy_7engFGrQy2scdskmc1SRpKN3x0MOxOr1ug@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/msm: Fix cx collapse issue during recovery
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
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

On Thu, Jul 7, 2022 at 9:11 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
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
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 16 ++++++++++++++--
>  drivers/gpu/drm/msm/msm_gpu.c         |  2 --
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 42ed9a3..57a7ad5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1210,8 +1210,20 @@ static void a6xx_recover(struct msm_gpu *gpu)
>          */
>         gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
>
> -       gpu->funcs->pm_suspend(gpu);
> -       gpu->funcs->pm_resume(gpu);
> +       /*
> +        * Now drop all the pm_runtime usage count to allow cx gdsc to collapse.
> +        * First drop the usage count from all active submits
> +        */
> +       for (i = gpu->active_submits; i > 0; i--)
> +               pm_runtime_put(&gpu->pdev->dev);

Would pm_runtime_force_suspend/resume() work instead?

BR,
-R

> +
> +       /* And the final one from recover worker */
> +       pm_runtime_put_sync(&gpu->pdev->dev);
> +
> +       for (i = gpu->active_submits; i > 0; i--)
> +               pm_runtime_get(&gpu->pdev->dev);
> +
> +       pm_runtime_get_sync(&gpu->pdev->dev);
>
>         msm_gpu_hw_init(gpu);
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index f75ff4b..48171b6 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -444,9 +444,7 @@ static void recover_worker(struct kthread_work *work)
>                 /* retire completed submits, plus the one that hung: */
>                 retire_submits(gpu);
>
> -               pm_runtime_get_sync(&gpu->pdev->dev);
>                 gpu->funcs->recover(gpu);
> -               pm_runtime_put_sync(&gpu->pdev->dev);
>
>                 /*
>                  * Replay all remaining submits starting with highest priority
> --
> 2.7.4
>
