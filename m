Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73114BC524
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 04:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbiBSDCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 22:02:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbiBSDCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 22:02:32 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096E9606FA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 19:02:15 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id p15so5121250oip.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 19:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/aL39Z+/g+dDunOKEkaaG/tOKqWyPS3k7avsFh9Lne4=;
        b=flpsNJFtWTy2yRtjs2ojwi77DizDk9HOYIt6foK4Q7ndEtm6poQ1iskpuPaG2xOxy2
         cKXdZHfmbw9BxA7ZHFeCycVv0NXHeDbY2DeuNFxMCmc3luBSdvoQPqErDxqH9jQYcSCt
         scvso1n2GPqzKjcKfb1I0gnt1GAEyX/9tdepI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/aL39Z+/g+dDunOKEkaaG/tOKqWyPS3k7avsFh9Lne4=;
        b=NowFVd9GrJ0jmINH3YOdxGD3qWbVY/O3VDKqd/y0Tqm54toshfyB32/s9Zr3D6VKeU
         eWfMrroFAr8f7tp/N/qVr32y0Hjn3vCJmLRhKYdjSo11f4ZZxJZh+ATnj5wt1zjS21Is
         KB7SR6tQafFyg8Cqes00kHmbZg5/hgV2OepzHsn7Uv62uIRTo6isRVIfRQCZy6N9uh4Z
         Hqye2VDHUIB8ghkIT59kZ7hKV9hkXamK6OrGjb7KwLNe67eKBZpLVEVgpxzFr7F0x5/p
         /zbzItVUgnTQrYTOC9ZGLKnpnYtBbYny9kBYDH1zZ0My/qR3VtyXj4mvln1qJgFd1+J4
         eK5A==
X-Gm-Message-State: AOAM533bp3oBfI1Xq7h78MoS/NS+vsMhMRFY0iEN1nwqzQYZh971mqiO
        RT9dohUOy7F/GKdgqwlqJkbkiuYRsdWlWhZ2rRkgpA==
X-Google-Smtp-Source: ABdhPJyTrVif3DX8Xtnalz1sr5dnWdhvQiHw4aCJ/Me1nIAlSUMyfKMCXaya8cz45jki7GYCtRslmo+guYGfBJ1+0Tc=
X-Received: by 2002:aca:df44:0:b0:2ce:285f:cb99 with SMTP id
 w65-20020acadf44000000b002ce285fcb99mr6329158oig.40.1645239734376; Fri, 18
 Feb 2022 19:02:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Feb 2022 19:02:13 -0800
MIME-Version: 1.0
In-Reply-To: <1645133788-5057-5-git-send-email-quic_khsieh@quicinc.com>
References: <1645133788-5057-1-git-send-email-quic_khsieh@quicinc.com> <1645133788-5057-5-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Feb 2022 19:02:13 -0800
Message-ID: <CAE-0n51v_2V4CnLzciagKYxtzALcyL5e1PgTDw28Aq7iFGNt_A@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] drm/msm/dp: enable widebus feature for display port
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-02-17 13:36:28)
> Widebus feature will transmit two pixel data per pixel clock to interface.
> This feature now is required to be enabled to easy migrant to higher

s/migrant/migrate/?

> resolution applications in future. However since some legacy chipsets

s/in/in the/

> does not support this feature, this feature is enabled base on chip's

s/does not/don't/

> hardware revision.
>
> changes in v2:
> -- remove compression related code from timing
> -- remove op_info from  struct msm_drm_private
> -- remove unnecessary wide_bus_en variables
> -- pass wide_bus_en into timing configuration by struct msm_dp
>
> Changes in v3:
> -- split patch into 3 patches
> -- enable widebus feature base on chip hardware revision
>
> Changes in v5:
> -- DP_INTF_CONFIG_DATABUS_WIDEN
>
> Changes in v6:
> -- static inline bool msm_dp_wide_bus_enable() in msm_drv.h
>
> Changes in v7:
> -- add Tested-by
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  4 +++-
>  drivers/gpu/drm/msm/dp/dp_catalog.c         | 34 +++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_catalog.h         |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_ctrl.c            | 13 +++++++----
>  drivers/gpu/drm/msm/dp/dp_ctrl.h            |  1 +
>  drivers/gpu/drm/msm/dp/dp_display.c         | 30 +++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_display.h         |  2 ++
>  drivers/gpu/drm/msm/dp/dp_panel.c           |  4 ++--
>  drivers/gpu/drm/msm/dp/dp_panel.h           |  2 +-
>  drivers/gpu/drm/msm/msm_drv.h               |  6 +++++
>  10 files changed, 88 insertions(+), 11 deletions(-)

My mind is blown by the amount of lines that have to change to plumb
through wide_bus_en bool argument. This driver has too many layers.

>
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index 64f0b26..5c809c6f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -1796,6 +1796,7 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>         int ret = 0;
>         bool mainlink_ready = false;
>         struct dp_ctrl_private *ctrl;
> +       u32 pixel_rate_orig;

Why u32? Just unsigned long pixel_rate?

>
>         if (!dp_ctrl)
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e89556ad..bc86c03 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -979,6 +983,7 @@ int dp_display_get_modes(struct msm_dp *dp,
>                 dp->connector, dp_mode);
>         if (dp_mode->drm_mode.clock)
>                 dp->max_pclk_khz = dp_mode->drm_mode.clock;
> +
>         return ret;
>  }
>

This hunk is useless.

> @@ -1451,6 +1456,28 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display)
>         }
>  }
>
> +bool msm_dp_wide_bus_enable(struct msm_dp *dp_display)
> +{
> +       struct dp_display_private *dp;
> +       u32 revision, major, minor;
> +
> +       dp = container_of(dp_display, struct dp_display_private, dp_display);
> +
> +       /* for the time being widebus only support on DP */

/* TODO: For the time being only support widebus on DP */

> +       if (dp_display->connector_type  == DRM_MODE_CONNECTOR_DisplayPort) {
> +               revision = dp_catalog_hw_revision(dp->catalog);
> +               major = ((revision >> 28) & 0x0ff);
> +               minor = ((revision >> 16) & 0x0fff);

Use GENMASK() and FIELD_GET()?

> +
> +               DRM_DEBUG_DP("id=%d major=%d minor=%d\n", dp->id, major, minor);
> +
> +               if (major >= 1 && minor >= 2)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
>  {
>         struct dp_display_private *dp;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 07f6c41..d11bf5c 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -398,6 +398,7 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display);
>  void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display);
>
>  void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor);
> +bool msm_dp_wide_bus_enable(struct msm_dp *dp_display);

A better name would be msm_dp_wide_bus_available()
