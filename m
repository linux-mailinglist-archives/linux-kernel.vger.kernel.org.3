Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8499748E295
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiANCm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbiANCm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:42:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF27BC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 18:42:57 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s30so25981117lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 18:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=cjt46o0H8juJwTkg9g5qXZAEFKZ9jhldP8/d/bKEtbM=;
        b=AItf8MjIcqDlBKVoN8mbcCw6jsfY0mqaz1EXRhYSnnNPSTl7YFt4JhwnG7D8pjbp0y
         vbWB8MzPP0ldlt5ziFTnCx0tDWQkNu4PH6M96dl48CFRQjym0geyTThU4RzEB4wZKIPt
         eXhyLFqzG2XwOgCyBlLGAjJd4SVtVwppTz4r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=cjt46o0H8juJwTkg9g5qXZAEFKZ9jhldP8/d/bKEtbM=;
        b=poc+lAm0RLFmWAk6w0aF3UNzeYEoyDzgo0VF68BDI9RgIIZYrWVrDGk4Iu9wf8JqCq
         o7nwIW5PgkSz+EtTvMblS5+ZLTEkCEjg1DA6SjcXCC9PAS8YiwSRFbrFhlvKB6tryS/6
         JsMDsxoACspGcP3CWGSOoFnK9v0r6yGgN2aAW3VJEc+OuiakLdwmVxZj9fLw1Fzsu1hQ
         hIo9cid6+TnidRMiZo6YJbwhojXZEaTZNDgQOo6zhN4nmJfOsKTUyhjV3kyQNutR9qE2
         JngvhRPUbVFNcSiDgev9FKv/Wf1xweYgJWT9sTIY7zW+SJIkz/brXQBBZ08HfR4dvwan
         w6gw==
X-Gm-Message-State: AOAM531GEekxwA/dwGOAWA7rcyIqeCftcffW3C2ZKl9lYC4n8uRSNnDY
        HGeE/z1sB7yuChR3eIf8FRm103PtRLWcdih8oYwv/Q==
X-Google-Smtp-Source: ABdhPJwW2WTcDmQiD0n1+kqJjG6r7Sb7wz9pL0WUIMko1hXyZSHNYJlaQOXrDZKTuBGY9YLHSZk9DcRejNde+phVHXg=
X-Received: by 2002:a19:2d0c:: with SMTP id k12mr5322641lfj.224.1642128175854;
 Thu, 13 Jan 2022 18:42:55 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Jan 2022 18:42:54 -0800
MIME-Version: 1.0
In-Reply-To: <1642118019-18673-2-git-send-email-quic_khsieh@quicinc.com>
References: <1642118019-18673-1-git-send-email-quic_khsieh@quicinc.com> <1642118019-18673-2-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 13 Jan 2022 18:42:54 -0800
Message-ID: <CAE-0n52OETzrO-XxuOQLp=fM17X3SGdD6zARtF85znmTqdvVRg@mail.gmail.com>
Subject: Re: [PATCH v13 1/4] drm/msm/dp: do not initialize phy until plugin
 interrupt received
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-13 15:53:36)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 7cc4d21..b3c5404 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -83,6 +83,7 @@ struct dp_display_private {
>
>         /* state variables */
>         bool core_initialized;
> +       bool phy_initialized;
>         bool hpd_irq_on;
>         bool audio_supported;
>
> @@ -372,21 +373,38 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
>         return rc;
>  }
>
> -static void dp_display_host_init(struct dp_display_private *dp, int reset)
> +static void dp_display_host_phy_init(struct dp_display_private *dp)
>  {
> -       bool flip = false;
> +       DRM_DEBUG_DP("core_init=%d phy_init=%d\n",
> +                       dp->core_initialized, dp->phy_initialized);
>
> +       if (!dp->phy_initialized) {
> +               dp_ctrl_phy_init(dp->ctrl);
> +               dp->phy_initialized = true;
> +       }
> +}
> +
> +static void dp_display_host_phy_exit(struct dp_display_private *dp)
> +{
> +       DRM_DEBUG_DP("core_init=%d phy_init=%d\n",
> +                       dp->core_initialized, dp->phy_initialized);
> +
> +       if (dp->phy_initialized) {
> +               dp_ctrl_phy_exit(dp->ctrl);
> +               dp->phy_initialized = false;
> +       }
> +}
> +
> +static void dp_display_host_init(struct dp_display_private *dp)
> +{
>         DRM_DEBUG_DP("core_initialized=%d\n", dp->core_initialized);
>         if (dp->core_initialized) {

When is this true? From what I see dp_display_host_init() is only called
from two places: resume where core_initialized has been set to false
during suspend or from dp_display_config_hpd() kicked by the kthread
where core_initialized is also false.

Also, I see that dp_display_host_deinit() is only called from suspend
now, so 'core_initialized' is almost always true, except for on the
resume path and before the kthread is started and in the case that the
driver probes but can't start the kthread for some reason (is that
real?).

>                 DRM_DEBUG_DP("DP core already initialized\n");
>                 return;
>         }
>
> -       if (dp->usbpd->orientation == ORIENTATION_CC2)
> -               flip = true;
> -
> -       dp_power_init(dp->power, flip);
> -       dp_ctrl_host_init(dp->ctrl, flip, reset);
> +       dp_power_init(dp->power, false);
> +       dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
>         dp_aux_init(dp->aux);
>         dp->core_initialized = true;
>  }
> @@ -892,12 +901,19 @@ static int dp_display_disable(struct dp_display_private *dp, u32 data)
>
>         dp_display->audio_enabled = false;
>
> -       /* triggered by irq_hpd with sink_count = 0 */
>         if (dp->link->sink_count == 0) {
> +               /*
> +                * irq_hpd with sink_count = 0
> +                * hdmi unplugged out of dongle
> +                */
>                 dp_ctrl_off_link_stream(dp->ctrl);
>         } else {
> +               /*
> +                * unplugged interrupt
> +                * dongle unplugged out of DUT
> +                */
>                 dp_ctrl_off(dp->ctrl);
> -               dp->core_initialized = false;
> +               dp_display_host_phy_exit(dp);
>         }
>
>         dp_display->power_on = false;
> @@ -1027,7 +1043,7 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>  static void dp_display_config_hpd(struct dp_display_private *dp)
>  {
>
> -       dp_display_host_init(dp, true);
> +       dp_display_host_init(dp);
>         dp_catalog_ctrl_hpd_config(dp->catalog);
>
>         /* Enable interrupt first time
> @@ -1306,20 +1322,23 @@ static int dp_pm_resume(struct device *dev)
>         dp->hpd_state = ST_DISCONNECTED;
>
>         /* turn on dp ctrl/phy */
> -       dp_display_host_init(dp, true);
> +       dp_display_host_init(dp);
>
>         dp_catalog_ctrl_hpd_config(dp->catalog);
>
> -       /*
> -        * set sink to normal operation mode -- D0
> -        * before dpcd read
> -        */
> -       dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>
>         if (dp_catalog_link_is_connected(dp->catalog)) {
> +               /*
> +                * set sink to normal operation mode -- D0
> +                * before dpcd read
> +                */
> +               dp_display_host_phy_init(dp);
> +               dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>                 sink_count = drm_dp_read_sink_count(dp->aux);
>                 if (sink_count < 0)
>                         sink_count = 0;
> +
> +               dp_display_host_phy_exit(dp);
>         }
>
>         dp->link->sink_count = sink_count;
> @@ -1363,7 +1382,11 @@ static int dp_pm_suspend(struct device *dev)
>                 if (dp_power_clk_status(dp->power, DP_CTRL_PM))
>                         dp_ctrl_off_link_stream(dp->ctrl);
>
> +               dp_display_host_phy_exit(dp);
> +

Why is there a newline here?

>                 dp_display_host_deinit(dp);
> +       } else {
> +               dp_display_host_phy_exit(dp);
>         }
>
>         dp->hpd_state = ST_SUSPENDED;

There's a dp->core_initialized = false right here but it's not in the
diff window. It's redundant now because the hunk above is basically

	if (dp->core_initialized == true) {
		...
		dp_display_host_phy_exit(dp);
		dp_display_host_deinit(dp);
	} else {
		dp_display_host_phy_exit(dp);
	}

	dp->hpd_state = ST_SUSPENDED;

and dp_display_host_deinit() sets core_initialized to false, thus
core_initialized will be false here already. Can you remove the
duplicate assignment?

> @@ -1535,7 +1558,7 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
>         state =  dp_display->hpd_state;
>
>         if (state == ST_DISPLAY_OFF)
> -               dp_display_host_init(dp_display, true);
> +               dp_display_host_phy_init(dp_display);
>
>         dp_display_enable(dp_display, 0);
>
