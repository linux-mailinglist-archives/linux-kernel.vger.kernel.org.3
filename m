Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0E2570E31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiGKXWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiGKXWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:22:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4962820C1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:22:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l23so11382493ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2g/SRedCTGa3FW1fDb+EmyQOw6AOS/KFbwj3cy8GxXM=;
        b=fAXlbz7CXR4/Kg6TafHz6Jq1ObQFjoGNWKETyL5sK1ogIAZ7eh86yG8EZsMgg7dLi9
         i4WwRk7mJjU5ORPXarDHnJ6nA7DhMcGY5zkpAGZAjIj2sF0ZoSiyOfhWy3cqaB77JJH2
         dTkyj2oPvErEYbjlvTsVHSPFBKhF6aamfznp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2g/SRedCTGa3FW1fDb+EmyQOw6AOS/KFbwj3cy8GxXM=;
        b=T2mMubpvKZoWTrXWfrXy9VY+gPZvTc7bvmQEJg1c7uYSFl1BXk+VPWB2PdvUttyxt0
         m2Dg/yoXEVcmZoeoMoSumExqiV375OXMd/K4iTQ/WwuMmdNzHp2kg8v4Svet6wsOn2CX
         dPX72U3i0+4N4/Y82vuTF4O+QrRvnVrs2YSeKOrmZKaPGGD9EvIJDbhQeiGzwz+wZxyn
         BtoEF5PyF7ud3YU5Dbf5AQxE/2K7+J6NK3kgsKMfpRM7ElrQ+UHZ5pVBjiJGNJFvG+dQ
         ND7M+5UB8hdgQkz2kWW0iJ3jneaXqS6X605DkAkAieTTZsraZB3hCSpUpaWs9PqeB16v
         VU/A==
X-Gm-Message-State: AJIora95takOGkmjyN6bpAywo64LMvVTHNZ3JzYZxgu98tA+CbUWjYIs
        vBe4BQtroH7cS6wbvexU542DqC6wX63rLFnEwg8=
X-Google-Smtp-Source: AGRyM1ur0iCl+jsIDoIacyfBtICju/6mjJiZEWKOfHipN/D/0Uht3c/HTnIC1bGA2K7GNKhVfeCgcw==
X-Received: by 2002:a17:907:8a28:b0:726:a02a:5bea with SMTP id sc40-20020a1709078a2800b00726a02a5beamr21718411ejc.175.1657581759281;
        Mon, 11 Jul 2022 16:22:39 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709064d8a00b0072b33e91f96sm3130082eju.190.2022.07.11.16.22.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 16:22:37 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id z12so8899371wrq.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:22:37 -0700 (PDT)
X-Received: by 2002:adf:d1e9:0:b0:21b:c8f8:3c16 with SMTP id
 g9-20020adfd1e9000000b0021bc8f83c16mr18888013wrd.659.1657581756957; Mon, 11
 Jul 2022 16:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <1657346375-1461-1-git-send-email-quic_akhilpo@quicinc.com> <20220709112837.v2.3.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
In-Reply-To: <20220709112837.v2.3.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 16:22:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=J+yf6Qu0VgJ8A5Lhs_s8Fszw=Oa0XUny5XT-5z56xQ@mail.gmail.com>
Message-ID: <CAD=FV=U=J+yf6Qu0VgJ8A5Lhs_s8Fszw=Oa0XUny5XT-5z56xQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] drm/msm: Fix cx collapse issue during recovery
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 8, 2022 at 11:00 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
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
> (no changes since v1)
>
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 16 ++++++++++++++--
>  drivers/gpu/drm/msm/msm_gpu.c         |  2 --
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 4d50110..7ed347c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1278,8 +1278,20 @@ static void a6xx_recover(struct msm_gpu *gpu)
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
> +
> +       /* And the final one from recover worker */
> +       pm_runtime_put_sync(&gpu->pdev->dev);
> +
> +       for (i = gpu->active_submits; i > 0; i--)
> +               pm_runtime_get(&gpu->pdev->dev);
> +
> +       pm_runtime_get_sync(&gpu->pdev->dev);

In response to v1, Rob suggested pm_runtime_force_suspend/resume().
Those seem like they would work to me, too. Why not use them?
