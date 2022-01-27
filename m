Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE849E61F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbiA0Pdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiA0Pdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:33:49 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3988BC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:33:49 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id 2so5380476uax.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYlyRT8MryrVm8WUK1FdOweuPDLL3YnH5oihq3jLfy8=;
        b=faQ/HBXgsVjlFmHlztd/KP6medHPDl1H40RAw4sNhxx4j+v4T9cABadDRt4fqVbS/7
         HoU1auK3P7ZZe+KD5GOYPWBJqxCHKPFu4VIfTE6ubOg/KdtOdnA5XsD0H3GrFIwSzskQ
         1HHR2PZyk1ZjzKMj/4sqEnXRPeMq8yi4crW/a2ygrh4Z8wUHgvO1Nssnj1ivyXyhJu7Z
         fztbePPUKNZ6KwLJ6xZgjpLsAG9jEtYQp3Jh93mkNl7MbBg429tfNflHYckk2PCGYaYC
         auoz8BlYUWv1v4T/HedGWsASZmhlFtJo6hecLX7KATt16Okxd7KhXXn9/WM2ogNjAGbm
         XH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYlyRT8MryrVm8WUK1FdOweuPDLL3YnH5oihq3jLfy8=;
        b=ZiX8BrMVKEH6LwN1PXuONHK1Q6I20Hu38ZkyvaJhwRprQAn84z2M2D3RuJnXXYqAgZ
         4l1IAFOKEGa3QEyD+f+QzmWV1YxwY0WVrydkOuqFbRCmDP/Hm1dWLbSpqdoI7vzhmAlP
         mQi0fLU/zQkLFhTP1kOjYo19PuIKq3tmMcj27QOXuV6A6zGJoQ0YeARGEV0PajwBFv73
         MJiiwxU/PgTzze771ArWFeZQDaOLxzbeKNQ7ZL3wYKCaRQcte6ggmNhKmDf76KRjXF4S
         TBmrVzeiOAbzj9m4qNCfNmxUxod9UY+g9cxZO/jfmuo/YPSsBaIDxZD6jp0vFLuBzxge
         oSog==
X-Gm-Message-State: AOAM532hcywDREEPTUG3cN+/qD8rOQPkypu+4SwgruKd1n/uvyC6QBH1
        VT3FURh/ZWI3BZVYiOixNWrAMt9gKwzET/+OI2/ULg==
X-Google-Smtp-Source: ABdhPJzxLZy3Br1wvhjHjXo3hgQ5U9hjIEoMs8/OZbFqoQCuAXkCrI0wSN6MvtdPsxy1nmjij7CWiPcJFmTRspA9chs=
X-Received: by 2002:a05:6102:364:: with SMTP id f4mr1972935vsa.15.1643297628112;
 Thu, 27 Jan 2022 07:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20220127081237.13903-1-Tsung-Hua.Lin@amd.com>
In-Reply-To: <20220127081237.13903-1-Tsung-Hua.Lin@amd.com>
From:   Mark Yacoub <markyacoub@google.com>
Date:   Thu, 27 Jan 2022 10:33:37 -0500
Message-ID: <CAC0gqY7T=_F=fGRDBEZOhu7thLP_hkWE50w94hC5oahNxNg6ng@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix that issue that the number of the crtc of
 the 3250c is not correct
To:     RyanLin <tsung-hua.lin@amd.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        seanpaul@chromium.org, bas@basnieuwenhuizen.nl,
        nicholas.kazlauskas@amd.com, sashal@kernel.org,
        VictorChengChi.Lu@amd.com,
        ching-shih.li@amd.corp-partner.google.com,
        Rodrigo.Siqueira@amd.com, ddavenport@chromium.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 3:12 AM RyanLin <Tsung-Hua.Lin@amd.com> wrote:
>
> [Why]
> External displays take priority over internal display when there are fewer
> display controllers than displays.
>
> [How]
> The root cause is because of that number of the crtc is not correct.
> The number of the crtc on the 3250c is 3, but on the 3500c is 4.
> On the source code, we can see that number of the crtc has been fixed at 4.
> Needs to set the num_crtc to 3 for 3250c platform.
>
> Signed-off-by: RyanLin <Tsung-Hua.Lin@amd.com>
> Change-Id: I837df7101cc4849d2c3021fd529b4061edab4bb1
Please drop the gerrit ID.
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 40c91b448f7d..dbeef7b57a9b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2738,9 +2738,15 @@ static int dm_early_init(void *handle)
>                 break;
>  #if defined(CONFIG_DRM_AMD_DC_DCN1_0)
>         case CHIP_RAVEN:
> -               adev->mode_info.num_crtc = 4;
> -               adev->mode_info.num_hpd = 4;
> -               adev->mode_info.num_dig = 4;
> +               if (adev->rev_id >= 8) { //chip_name = "raven2";
> +                       adev->mode_info.num_crtc = 3;
> +                       adev->mode_info.num_hpd = 3;
> +                       adev->mode_info.num_dig = 3;
> +               } else {
> +                       adev->mode_info.num_crtc = 4;
> +                       adev->mode_info.num_hpd = 4;
> +                       adev->mode_info.num_dig = 4;
> +               }
>                 break;
>  #endif
>  #if defined(CONFIG_DRM_AMD_DC_DCN2_0)
> --
> 2.25.1
>
