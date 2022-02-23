Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737DC4C0685
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiBWA7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiBWA7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:59:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148ED27B21;
        Tue, 22 Feb 2022 16:58:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o24so36715178wro.3;
        Tue, 22 Feb 2022 16:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyPaBl5xkEft4MC1ElCsdVx+YIi4gPbjLrN+4aUtU3I=;
        b=lFocHm1ll8kbn256FMHTLkXa/aUbph/pSMXOho9y1i63M6UMe3mLCVD8E1ISilUUxh
         JEKRDjItmJrQy7u/Cyx0QR2BPGSHKk4y3R9JUQCIbnwWoF7fO2ON5vrboOPLUMb3aqEt
         c879lK7D3joD4EQm8Xvbk0TKiwRDtueL0VjCaQL38S4avuAzwo0fpLpiUVcKM8Cgg/mC
         rHqsuFlDc447Ik4MbGV6ys1fxiV9QoGv5V2MIpwonh7k0KQIkbMKUqPRfdrumANqjupd
         7UP7Tyq6qnt0vmzeuI0H3kEoVV7oPbcev+A9uoUBkBGAzS6SBVIsfR9sWbLPYSiZlu9r
         3e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyPaBl5xkEft4MC1ElCsdVx+YIi4gPbjLrN+4aUtU3I=;
        b=GZ7UWFW78+hAuHz67x2zVchg7EIkImUVx+sJziaselrL5FRuGchKELWLFUwM2ff0ho
         CD+W+/90kxVTQ3c9cP/XXNpgc/rSbWpcnEwg6p9vehLbYFMS04M6iP878Yj0iEgsczN9
         S2+nR9/NPm1s2/n9GUPzwyG07/LmTW03zqrPDCD3Vzel0ht1EjxEtK2G4YMHTnziaP+K
         fe6IpPR6TuqpHxYc7jTB4tgKNeJSrnWlwaPUrjQ9R415V1xu0N4wOLPVL3C8CXDWYaIm
         FWeVd/4xp5buU5FDkGMV390q0LlpbJrbgdExzb0PakO0vqpX/w+mE8LC3fHqBCYyqhso
         Lj1A==
X-Gm-Message-State: AOAM531rp+m64FXjU0MaZILx5NX/og0QYCePJKRLij4NzR3JZm9aS5dj
        T8KJpAZ5Qlkp1LP9nZCsTMi6YIgEzrQIx+73OWM=
X-Google-Smtp-Source: ABdhPJwJ3XDhDTwhrKJ8MvO+0QY+LlMY8p4dDQtV3Sq9hef5slGj+W0Wl7psN4DOKKetT0K5SdSycUY/8I1NpJIWgCE=
X-Received: by 2002:adf:f68d:0:b0:1e1:db49:a721 with SMTP id
 v13-20020adff68d000000b001e1db49a721mr21586110wrp.297.1645577917576; Tue, 22
 Feb 2022 16:58:37 -0800 (PST)
MIME-Version: 1.0
References: <1645454462-27867-1-git-send-email-quic_akhilpo@quicinc.com> <20220221201039.2.I9436e0e300f76b2e6c34136a0b902e8cfd73e0d6@changeid>
In-Reply-To: <20220221201039.2.I9436e0e300f76b2e6c34136a0b902e8cfd73e0d6@changeid>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 22 Feb 2022 16:58:56 -0800
Message-ID: <CAF6AEGuVZaOdUUf8ccokTQdAXMdW3oVYNx3ae9ShBoh8ibXVOw@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/msm/adreno: Generate name from chipid for 7c3
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
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

On Mon, Feb 21, 2022 at 6:41 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> Use a gpu name which is sprintf'ed from the chipid for 7c3 gpu instead of
> hardcoding one. This helps to avoid code churn in case of a gpu rename.
>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  1 -
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 14 ++++++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index fb26193..89cfd84 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -318,7 +318,6 @@ static const struct adreno_info gpulist[] = {
>                 .hwcg = a660_hwcg,
>         }, {
>                 .rev = ADRENO_REV(6, 3, 5, ANY_ID),
> -               .name = "Adreno 7c Gen 3",
>                 .fw = {
>                         [ADRENO_FW_SQE] = "a660_sqe.fw",
>                         [ADRENO_FW_GMU] = "a660_gmu.bin",
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index f33cfa4..158bbf7 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -929,12 +929,22 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>         struct adreno_platform_config *config = dev->platform_data;
>         struct msm_gpu_config adreno_gpu_config  = { 0 };
>         struct msm_gpu *gpu = &adreno_gpu->base;
> +       struct adreno_rev *rev = &config->rev;
> +       const char *gpu_name;
> +       static char name[8];

I think 8 is not always enough.. but maybe just use devm_kasprintf()
to keep it simpler?

BR,
-R

>
>         adreno_gpu->funcs = funcs;
>         adreno_gpu->info = adreno_info(config->rev);
>         adreno_gpu->gmem = adreno_gpu->info->gmem;
>         adreno_gpu->revn = adreno_gpu->info->revn;
> -       adreno_gpu->rev = config->rev;
> +       adreno_gpu->rev = *rev;
> +
> +       gpu_name = adreno_gpu->info->name;
> +       if (!gpu_name) {
> +               sprintf(name, "%d.%d.%d.%d", rev->core, rev->major, rev->minor,
> +                               rev->patchid);
> +               gpu_name = name;
> +       }
>
>         adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
>
> @@ -948,7 +958,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>         pm_runtime_enable(dev);
>
>         return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
> -                       adreno_gpu->info->name, &adreno_gpu_config);
> +                       gpu_name, &adreno_gpu_config);
>  }
>
>  void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
> --
> 2.7.4
>
