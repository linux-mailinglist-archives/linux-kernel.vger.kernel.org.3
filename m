Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180CC4EB8A2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbiC3DEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242170AbiC3DDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:03:49 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E27318178C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:02:04 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q129so20902247oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ur1fEP3S2LvaWAlvGKw+OsWwCUfBsA0hA7I29tDVbH0=;
        b=XEJLTGvbNYlW1w/0qqsdA8xWWbqsGgetz7yWkk8Xfqn+0r56mCFq3cY/t1djsGQEjd
         u11tsX1TImjiuFekbn50D+H5/67OefnF02KpgnfsVZEQJvQGqX57NKMkG9iuEjLfy9pk
         QSsXGbYN+IpicA0ENNQFRH3uc1rVNVen5KSkt0Ig6P1y7fVo547VwIHeHHU3HoVOxxLy
         O6Q/kPuzvjeK2pynlMHaLz+uBxhfjqvQeEMpnTKnldPPaLisMTu3+zp3+ER6T8/dnbVk
         owcW+Egr0yV+wxcbkf7B3WdJSrUVY842OyU4WS98pFjbZYR4IuSrjsk1RO2wfk/i2hri
         pL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ur1fEP3S2LvaWAlvGKw+OsWwCUfBsA0hA7I29tDVbH0=;
        b=eQg3fLs0/IlXG/HVxnbCJ4JsXBosQuPzRxgxX0fw204DHN5ri3fEe4tgVmO+B288LQ
         rVE0CObtFPnm9+EOrVQog8lpc/1uvufoS4bpscc3GTbbcXV1bN+UDgDPkUpIGoLhdADp
         ebKCFwuGY/8MyUi86wrEJd+BApSrkfFUk3i5YGk2BRxhLi4RbmlwgIYgR1yPvyrCnAUh
         5zGSgakOjOnONnb804ZQ4dHdykg4IYgwWphfuSTBDDjKhFuIcvP2T0tNl4EonJRE3V0y
         quih3BDfb6xYqyDWrUXmOIce6P7uYusfRZR6suFnbTwk2snI64GOp97JxEcfcpP/Y2hE
         S1lw==
X-Gm-Message-State: AOAM5315YW88I6vPOCz16JiyYrF496pnhYf9GBUh/QQmsfgusrv/tgBp
        Api2dnxeNj8Lp4INGmlJV8Ic28MghbKGFSP938ZLuWNu
X-Google-Smtp-Source: ABdhPJzkB9w/7Dh3ntidVedaTQyZjbL6+tpV1HB5APfyAdQjTC4sUhKGfrB7FhdaIO3zE63Y7Hl0XGb4Kt8995j2G3k=
X-Received: by 2002:aca:d04:0:b0:2ef:8b45:d235 with SMTP id
 4-20020aca0d04000000b002ef8b45d235mr956733oin.253.1648609323691; Tue, 29 Mar
 2022 20:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220127081237.13903-1-Tsung-Hua.Lin@amd.com> <20220330024643.162230-1-tsung-hua.lin@amd.com>
In-Reply-To: <20220330024643.162230-1-tsung-hua.lin@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Mar 2022 23:01:52 -0400
Message-ID: <CADnq5_O6S+7Kk34fGCjqmmJAf5JtZP35+MBpCDQnH5Sh6ZosFA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix that issue that the number of the crtc
 of the 3250c is not correct
To:     Ryan Lin <tsung-hua.lin@amd.com>
Cc:     "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Drew Davenport <ddavenport@chromium.org>,
        Leo Li <sunpeng.li@amd.com>, leon.li@amd.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Louis Li <ching-shih.li@amd.corp-partner.google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Mark Yacoub <markyacoub@google.com>
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

On Tue, Mar 29, 2022 at 10:57 PM Ryan Lin <tsung-hua.lin@amd.com> wrote:
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
> v2:
>    - remove unnecessary comments and Id
>
> Signed-off-by: Ryan Lin <tsung-hua.lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 40c91b448f7da..455a2c45e8cda 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2738,9 +2738,15 @@ static int dm_early_init(void *handle)
>                 break;
>  #if defined(CONFIG_DRM_AMD_DC_DCN1_0)
>         case CHIP_RAVEN:
> -               adev->mode_info.num_crtc = 4;
> -               adev->mode_info.num_hpd = 4;
> -               adev->mode_info.num_dig = 4;
> +               if (adev->rev_id >= 8) {
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
