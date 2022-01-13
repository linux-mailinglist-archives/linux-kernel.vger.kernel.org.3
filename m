Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF048DD45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiAMR43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiAMR42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:56:28 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D394C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:56:27 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id n68so17267982ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=basnieuwenhuizen.nl; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdER3tWel4lE2/IoeEHZfK62RzxAAdC/S8e3rQxeHZA=;
        b=QqKneNMQj4ZBTtbPRfxOzT7S0JJTSi1VXQyb1h0OwmrazhZmAY9eGs8Jdl48biORhS
         khpRxv8ZdQQXcw/97mnlQ5sYhTq0Z6rXlw8DolwUXAvENLMJOQPhKu457fArQpLQ6FSY
         lVpbLszp8ZE7myFULL7HPZYWWalDnTFXsObJdmXxt8f7C5GWond7c/SODUIIw8su+C2A
         e/sT9FfwJu37VzhLSbhFnfH7fS41HLQ0IdR1bhXhdReexQK0214ADbSSA/htnuG1ImE2
         d1AEtMD0JGVtz34tpAJRc3rHDWemUsqXa/g6qy8YNa6WMaaeaiaqpS2D23UAkINVsAyZ
         7lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdER3tWel4lE2/IoeEHZfK62RzxAAdC/S8e3rQxeHZA=;
        b=PyJBSw1gHe0fvK8PTIh6GKISeUFKSReUhzuKLDZqrvn91wsyHTyFjICTzWkRvAG1p2
         JozoOErY2+EmvILFvLxVP2A2qfLL6z3B36P7XOIRsTsPGZ7my0LAI8iOpRf713Nn7BZa
         ITF+eBzD0mfq3apBeSLO2xKATdofLiD8JWcHVYmzyZYCsEIfSYcguKir/O3rwMoCZINu
         cTyowqUFcIwRpN6vJUBzEGGyCVP8Amd1ZGEwn3wqF/u9ns0QL9zGu7PK6ls33mICSkWW
         hkNu9fHraQEz4UAxCicKfCZEUO/n9ugmAmCP1tPNoA9WHubAUbbOJ+GnEAJxPyyTF3RZ
         FDjg==
X-Gm-Message-State: AOAM5337eXNdgWOQ+ehbrnh/SKPBTCuAV8zqc8zITgwefFoEiRPY+1pN
        2fYWiyH8z3lke8fjPqO/eQqUL6h2+/Eu0ADX9QQdFA==
X-Google-Smtp-Source: ABdhPJz0n/brLEOsHB+4ty1kzSaUXFZiYF0zQd6450hq8J/b6AU/fn8nOe1GrP4fr+eT/3DR8+r7QcZLTYifVj2lHPg=
X-Received: by 2002:a25:50d8:: with SMTP id e207mr7592797ybb.150.1642096586381;
 Thu, 13 Jan 2022 09:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20220113094419.12433-1-etom@igel.co.jp> <20220113094419.12433-3-etom@igel.co.jp>
In-Reply-To: <20220113094419.12433-3-etom@igel.co.jp>
From:   Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date:   Thu, 13 Jan 2022 18:56:18 +0100
Message-ID: <CAP+8YyF60rXVacY3-ZKieYjxRzseb_SGJbNnXaUzUyUUS-n42Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] drm: set fb_modifiers_not_supported flag in
 legacy drivers
To:     Tomohito Esaki <etom@igel.co.jp>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nouveau@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we'll also want to do a conditional disable for DC
(drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c) since it only
enables modifiers on newer HW.  Something like "if (modifiers == NULL)
fb_modifiers_not_supported = true;" in amdgpu_dm_plane_init.

On Thu, Jan 13, 2022 at 10:44 AM Tomohito Esaki <etom@igel.co.jp> wrote:
>
> Set fb_modifiers_not_supported flag in legacy drivers whose planes
> support non-linear layouts but does not support modifiers, and replace
> allow_fb_modifiers with fb_modifiers_not_supported.
>
> Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      | 2 ++
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      | 2 ++
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       | 1 +
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       | 2 ++
>  drivers/gpu/drm/nouveau/nouveau_display.c   | 6 ++++--
>  drivers/gpu/drm/radeon/radeon_display.c     | 2 ++
>  7 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index dc50c05f23fc..cbaea9c6cfda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -958,7 +958,7 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
>         int ret;
>         unsigned int i, block_width, block_height, block_size_log2;
>
> -       if (!rfb->base.dev->mode_config.allow_fb_modifiers)
> +       if (rfb->base.dev->mode_config.fb_modifiers_not_supported)
>                 return 0;
>
>         for (i = 0; i < format_info->num_planes; ++i) {
> @@ -1145,7 +1145,7 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
>         if (ret)
>                 return ret;
>
> -       if (!dev->mode_config.allow_fb_modifiers) {
> +       if (dev->mode_config.fb_modifiers_not_supported) {
>                 drm_WARN_ONCE(dev, adev->family >= AMDGPU_FAMILY_AI,
>                               "GFX9+ requires FB check based on format modifier\n");
>                 ret = check_tiling_flags_gfx6(rfb);
> @@ -1153,7 +1153,7 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
>                         return ret;
>         }
>
> -       if (dev->mode_config.allow_fb_modifiers &&
> +       if (!dev->mode_config.fb_modifiers_not_supported &&
>             !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
>                 ret = convert_tiling_flags_to_modifier(rfb);
>                 if (ret) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index d1570a462a51..fb61c0814115 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -2798,6 +2798,8 @@ static int dce_v10_0_sw_init(void *handle)
>         adev_to_drm(adev)->mode_config.preferred_depth = 24;
>         adev_to_drm(adev)->mode_config.prefer_shadow = 1;
>
> +       adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
> +
>         adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
>
>         r = amdgpu_display_modeset_create_props(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> index 18a7b3bd633b..17942a11366d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -2916,6 +2916,8 @@ static int dce_v11_0_sw_init(void *handle)
>         adev_to_drm(adev)->mode_config.preferred_depth = 24;
>         adev_to_drm(adev)->mode_config.prefer_shadow = 1;
>
> +       adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
> +
>         adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
>
>         r = amdgpu_display_modeset_create_props(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index c7803dc2b2d5..2ec99ec8e1a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -2674,6 +2674,7 @@ static int dce_v6_0_sw_init(void *handle)
>         adev_to_drm(adev)->mode_config.max_height = 16384;
>         adev_to_drm(adev)->mode_config.preferred_depth = 24;
>         adev_to_drm(adev)->mode_config.prefer_shadow = 1;
> +       adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
>         adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
>
>         r = amdgpu_display_modeset_create_props(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index b200b9e722d9..8369336cec90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -2699,6 +2699,8 @@ static int dce_v8_0_sw_init(void *handle)
>         adev_to_drm(adev)->mode_config.preferred_depth = 24;
>         adev_to_drm(adev)->mode_config.prefer_shadow = 1;
>
> +       adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
> +
>         adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
>
>         r = amdgpu_display_modeset_create_props(adev);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
> index 929de41c281f..1ecad7fa3e8a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -711,10 +711,12 @@ nouveau_display_create(struct drm_device *dev)
>                                      &disp->disp);
>                 if (ret == 0) {
>                         nouveau_display_create_properties(dev);
> -                       if (disp->disp.object.oclass < NV50_DISP)
> +                       if (disp->disp.object.oclass < NV50_DISP) {
> +                               dev->mode_config.fb_modifiers_not_supported = true;
>                                 ret = nv04_display_create(dev);
> -                       else
> +                       } else {
>                                 ret = nv50_display_create(dev);
> +                       }
>                 }
>         } else {
>                 ret = 0;
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
> index 573154268d43..b9a07677a71e 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -1596,6 +1596,8 @@ int radeon_modeset_init(struct radeon_device *rdev)
>         rdev->ddev->mode_config.preferred_depth = 24;
>         rdev->ddev->mode_config.prefer_shadow = 1;
>
> +       rdev->ddev->mode_config.fb_modifiers_not_supported = true;
> +
>         rdev->ddev->mode_config.fb_base = rdev->mc.aper_base;
>
>         ret = radeon_modeset_create_props(rdev);
> --
> 2.25.1
>
