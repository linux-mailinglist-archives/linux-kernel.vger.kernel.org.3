Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3376D49EC59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbiA0URE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbiA0URC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:17:02 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FECC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:17:02 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so3678445otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9nhsDmOcZy3e7k+eV9ednENX32ChQNKTBKlc41Zhe0=;
        b=kr8dlhmEUis7JV/3W40XxogMFWgURfYVZ6PtKuEt2bVDe2fhzo+IfZ4GdfCh2QnGpH
         EUqVMSUZvSt62ur0geqwsV0HRP05IHSXBYIUc1WgIZBILDDyTWi1AyL81wxhXw8icPj1
         ucILHCEkJe8eUpT172hiytFZabGRgvpDTWaRYdj+YlG4wpGufvcY2Cy1DpO4qrSbJDIV
         sxWSxHOxjtVmXsgWBesCgx+I12NVQ0NuZEdwDUCawmumUQL+q9MMh0kwiQeWB2aPH1eX
         dqpzldsOWYQPQv9QS2YsajUKVm2yLj2dMOU8sFzvdfhsEZeigpuzxXl6HtLcgZQzr7nu
         IB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9nhsDmOcZy3e7k+eV9ednENX32ChQNKTBKlc41Zhe0=;
        b=Hf9MgZnFlvk2UaLzRWUWBgeOJGeF38LnsZ6ZensfeQyMJzsvvUhQ4ldCh94ISvyfGO
         C5fIHSqt+RNUyyG1wPnyufCZ7bGWTDl305xDNgIzRMpFy9/A9muFWuL/VrJvC4VWmLqF
         vjs30gQrbZZgQZduJmPrZXG/luZ5gBq8AkB4SMT98cXv2Kw19jNSek1137DAHcoeF63S
         +CtmafXe+UHYsrDtBfdWjMpH989M7EG8IY+4TvRT1LiAPChmxGjmfd5R+1wtT96bV/xX
         Xbf1YlRkEa21xKLKpHDTRvJgatpM8SKZCFywxtuQnNS2CFKqtLnxlZ/0sItq3yrsnk3G
         Ywuw==
X-Gm-Message-State: AOAM532q0CZ0HFGfYr0b99vaan4F5hKgWOqsEY1v4xGH/OvcbyLSU59q
        WMwr1QYbvYEyhlofMQBKzDE0YwqcRZOzKcXqfqY=
X-Google-Smtp-Source: ABdhPJynZsd7uV+C04xwLfNo9ix6iZk4Ifaq05n6r9hKhHX/upZlFUtrfygJJ0gV6h1fLwgfTX38sR9ST76NHj8Ijyc=
X-Received: by 2002:a9d:e94:: with SMTP id 20mr3015234otj.200.1643314621797;
 Thu, 27 Jan 2022 12:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20220126091602.1647-1-jinsdb@126.com>
In-Reply-To: <20220126091602.1647-1-jinsdb@126.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Jan 2022 15:16:50 -0500
Message-ID: <CADnq5_PUmz=G2LbCQEF9==K4GLRNbRWAMp+4V3N_ZpgV1DCB3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Wrong order for config and counter_id parameters
To:     Qu Huang <jinsdb@126.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Jan 26, 2022 at 4:48 AM <jinsdb@126.com> wrote:
>
> From: huangqu <jinsdb@126.com>
>
> Wrong order for config and counter_id parameters was passed, when calling df_v3_6_pmc_set_deferred and df_v3_6_pmc_is_deferred functions.
>
> Signed-off-by: huangqu <jinsdb@126.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 43c5e3ec9..f4dfca013 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -458,7 +458,7 @@ static int df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,
>
>  #define DEFERRED_ARM_MASK      (1 << 31)
>  static int df_v3_6_pmc_set_deferred(struct amdgpu_device *adev,
> -                                   int counter_idx, uint64_t config,
> +                                   uint64_t config, int counter_idx,
>                                     bool is_deferred)
>  {
>
> @@ -476,8 +476,8 @@ static int df_v3_6_pmc_set_deferred(struct amdgpu_device *adev,
>  }
>
>  static bool df_v3_6_pmc_is_deferred(struct amdgpu_device *adev,
> -                                   int counter_idx,
> -                                   uint64_t config)
> +                                   uint64_t config,
> +                                   int counter_idx)
>  {
>         return  (df_v3_6_pmc_has_counter(adev, config, counter_idx) &&
>                         (adev->df_perfmon_config_assign_mask[counter_idx]
> --
> 2.31.1
>
