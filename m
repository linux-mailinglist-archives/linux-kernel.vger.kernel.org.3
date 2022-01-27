Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89B249E459
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiA0OPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiA0OPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:15:11 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7027AC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:15:11 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s127so6132087oig.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2IQ6NQsUfe5CNns9AuCfdtqPvRk7lNSsS0rQJLHnfo=;
        b=MZUnqcDw2Gu5Sjn3lzgqQANinKVWZsKEpaptmcYh61RdGKo5YcTSTygh+Aw+jEkF9c
         3NBp6ewcXqqy9UEL1uQ2ncb7gUcZfIp00jPqmHtXxq07/x/gdVA9IMoW5rJ8yXZ2CG0j
         4QAWdHpINqJUM11UKYSIGKNAkZsITixdg1Sdr0FINi2+nmrdJR8SnZd3fR/wLf8aJcWl
         lru50KKMY5SjBx+yHJCv4811O9APQmAud2rBtAg3cwf8I46QaKAEPI2hZut4KISsglPa
         qiGzEE8VkkqqCzrm77Y3fxF7pNw0XGqQ6/g4Kfd/T/BpvBt85lZBF5gT5Y2QbCCE7JxE
         UqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2IQ6NQsUfe5CNns9AuCfdtqPvRk7lNSsS0rQJLHnfo=;
        b=xovThY3sDeE0PhZPXhhgjHwuJAv8p5ySGL91mhX1X+ydSsKNWp4bmAannLTocVhPKx
         YE2pDdTslv+yOauelkoU8TdmmcNwm6RHhNhNcW38lNOb4XS1SHChYRKSAivituIIAkG6
         rFrraIIY4FZFYtvfbCXXYs/Nnb5WSZm1Yh1Yr47LFHHHPYjnEgfxe+qwx1OA9AaAvi84
         MSx4zO/lbA78+Vi1WQGoH18+ZadQC5PO7wIqXhkupzVlCpv40c+auYZT2VY/Kpay+p8K
         KDrDyP9nd09SIegAgY+muHRJeXFBUv4/Q0Hvu6zdsU1OSCEXI70ZXr2ecSwcmENBObkv
         vqtA==
X-Gm-Message-State: AOAM530szNtfSsM47GuS2uFQc6EBtfXDZVRBgS9kQ4n15k26y3wMX8vm
        2y9GLYWyU0qaRIYkoBf5sJljuUTiktxP9WoGHopJpRUJ
X-Google-Smtp-Source: ABdhPJzZs64txo95vMncm1sqGMDOThy11IJwBJJ3+jNFTbv9/cYJuLHtC9a47jnKrT3N3esM1WQA0FfskJhgGzWI3zA=
X-Received: by 2002:a05:6808:2011:: with SMTP id q17mr7097575oiw.199.1643292910841;
 Thu, 27 Jan 2022 06:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20220127081237.13903-1-Tsung-Hua.Lin@amd.com>
In-Reply-To: <20220127081237.13903-1-Tsung-Hua.Lin@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Jan 2022 09:14:59 -0500
Message-ID: <CADnq5_N9p45tJm-sqb+NWbzNU7_rpE0b4YSJ8dcjp+4JJu1wug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix that issue that the number of the crtc of
 the 3250c is not correct
To:     RyanLin <Tsung-Hua.Lin@amd.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        Mark Yacoub <markyacoub@google.com>,
        Victor Lu <victorchengchi.lu@amd.com>,
        ching-shih.li@amd.corp-partner.google.com,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        ddavenport@chromium.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use C style comments /* */.  WIth that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


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
