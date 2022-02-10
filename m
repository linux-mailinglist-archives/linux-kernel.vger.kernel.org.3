Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814DF4B01FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiBJBWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:22:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiBJBW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:22:27 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742511EC42
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:22:28 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y23so4389779oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JX86RhdwH+HLeTAGV/cCxr8AGeUCEvZg7XB+IyNN+Wk=;
        b=EJF5FTN2Wdt2IF113jUflgIzZd+oNnhqt2OOA9FEiEaXCtPLc51Gs4gSDh5YXi1Nl6
         C9WGK3xhauPZdoWjmTqvkqrnVx1xrOQZAowXp+Uor0EvuPuYrXMvWbT0NoutuPcWSFrl
         jlfUf29FdhVJYEXekEvF2Bh2y+xC7bG/lHR+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JX86RhdwH+HLeTAGV/cCxr8AGeUCEvZg7XB+IyNN+Wk=;
        b=IwdYgV+3ec40Hf2W2wlH6XYG/lJpAxHJbzk2ODBt3djcHpus1kqHO/+pzu3EueGn6a
         pRoo9yRhMb9KTR7BQaYmviJGnfJ1uzWdI2q2I26qmLT83I6V3mVyK355vaLwewObT2ic
         q8zIpOCeUyn7GB5+se6CzJOZlFADDSs2+Ox8HOVns6p/CVDxRHk7txOxhjGhYXGEFDs4
         jlcv0swlkkXYm31N+vBM5qn/ehEW9iKPkbsMNIwUvRVCbysrzsRorbGHDtChEEtu2Rfv
         eL7P6pPDVp7y2ypGcBOaKZH6MrioQFbSo1IjzdWzCMw95nngTpY9q+K3EZpjUfUEytvV
         Sb4Q==
X-Gm-Message-State: AOAM532RJdJ6gKbO+p6IW4xxg0S2o15BkWJKTXGitlw8oEhxEhAXrEfS
        OkcEm0N0q0yKrvZguHFaE7aptGK4FZ+ae2YnnKMZLw==
X-Google-Smtp-Source: ABdhPJwIYJ3qnYUXQyFs3QSrJgHo6iuLeKq4ZRLVZ7VptIB57ekiTaeA9YPWqwH2NLVPlj9TKL1me+nBEG8AZuOe5ik=
X-Received: by 2002:a05:6808:190f:: with SMTP id bf15mr68505oib.40.1644456147764;
 Wed, 09 Feb 2022 17:22:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Feb 2022 17:22:27 -0800
MIME-Version: 1.0
In-Reply-To: <1644396932-17932-5-git-send-email-quic_sbillaka@quicinc.com>
References: <1644396932-17932-1-git-send-email-quic_sbillaka@quicinc.com> <1644396932-17932-5-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 9 Feb 2022 17:22:27 -0800
Message-ID: <CAE-0n53vzv+NFWfkFktAJFEpo0Ss1=OpNn1saXXx5A5xAJZ3xA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/msm/dp: Add driver support to utilize drm panel
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        agross@kernel.org, airlied@linux.ie, bjorn.andersson@linaro.org,
        daniel@ffwll.ch, devicetree@vger.kernel.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        krzysztof.kozlowski@canonical.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        robh+dt@kernel.org, sam@ravnborg.org, seanpaul@chromium.org,
        thierry.reding@gmail.com
Cc:     quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        quic_khsieh@quicinc.com, quic_mkrishn@quicinc.com,
        quic_vproddut@quicinc.com,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2022-02-09 00:55:32)
> Add support in the DP driver to utilize the custom eDP panels
> from drm/panels.
>
> An eDP panel is always connected to the platform. So, the eDP
> connector can be reported as always connected. The display mode
> will be sourced from the panel. The panel mode will be set after
> the link training is completed.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>
> Changes in v3:
>   None
>
>  drivers/gpu/drm/msm/dp/dp_display.c |  8 ++++++
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 54 +++++++++++++++++++++++++++++++++----
>  drivers/gpu/drm/msm/dp/dp_parser.h  |  3 +++
>  3 files changed, 60 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 7cc4d21..410fda4 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1513,6 +1513,10 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
>                 return -EINVAL;
>         }
>
> +       /* handle eDP on */

This comment is obvious. Please remove.

> +       if (dp->connector_type == DRM_MODE_CONNECTOR_eDP)
> +               dp_hpd_plug_handle(dp_display, 0);
> +
>         mutex_lock(&dp_display->event_mutex);
>
>         /* stop sentinel checking */
> @@ -1577,6 +1581,10 @@ int msm_dp_display_disable(struct msm_dp *dp, struct drm_encoder *encoder)
>
>         dp_display = container_of(dp, struct dp_display_private, dp_display);
>
> +       /* handle edp off */

This comment is obvious. Please remove.

> +       if (dp->connector_type == DRM_MODE_CONNECTOR_eDP)
> +               dp_hpd_unplug_handle(dp_display, 0);
> +
>         mutex_lock(&dp_display->event_mutex);
>
>         /* stop sentinel checking */
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index d4d360d..12fa8c1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -39,6 +39,10 @@ static enum drm_connector_status dp_connector_detect(struct drm_connector *conn,
>
>         dp = to_dp_connector(conn)->dp_display;
>
> +       /* eDP is always  connected */
> +       if (dp->connector_type == DRM_MODE_CONNECTOR_eDP)
> +               return connector_status_connected;

Why not implement different connector ops for eDP and then not implement
this function at all in that case?

> +
>         DRM_DEBUG_DP("is_connected = %s\n",
>                 (dp->is_connected) ? "true" : "false");
>
> @@ -123,6 +127,35 @@ static enum drm_mode_status dp_connector_mode_valid(
>         return dp_display_validate_mode(dp_disp, mode->clock);
>  }
>
> +static int edp_connector_get_modes(struct drm_connector *connector)
> +{
> +       struct msm_dp *dp;
> +
> +       if (!connector)

Is this check really necessary? Why doesn't drm do it in higher layers?

> +               return 0;
> +
> +       dp = to_dp_connector(connector)->dp_display;
> +
> +       return drm_bridge_get_modes(dp->panel_bridge, connector);
> +}
> +
> +static enum drm_mode_status edp_connector_mode_valid(
> +               struct drm_connector *connector,
> +               struct drm_display_mode *mode)
> +{
> +       struct msm_dp *dp;
> +
> +       if (!connector)

Is this check really necessary? Why doesn't drm do it in higher layers?

> +               return 0;
> +
> +       dp = to_dp_connector(connector)->dp_display;
> +
> +       if (mode->clock > EDP_MAX_PIXEL_CLK_KHZ)
> +               return MODE_BAD;

Why not return MODE_CLOCK_HIGH?

> +
> +       return MODE_OK;
> +}
> +
>  static const struct drm_connector_funcs dp_connector_funcs = {
>         .detect = dp_connector_detect,
>         .fill_modes = drm_helper_probe_single_connector_modes,
> @@ -137,6 +170,12 @@ static const struct drm_connector_helper_funcs dp_connector_helper_funcs = {
>         .mode_valid = dp_connector_mode_valid,
>  };
>
> +static const struct drm_connector_helper_funcs edp_connector_helper_funcs = {
> +       .get_modes = edp_connector_get_modes,
> +       .mode_valid = edp_connector_mode_valid,
> +

Why the extra newline?

> +};
> +
>  /* connector initialization */
>  struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display)
>  {
> @@ -160,12 +199,17 @@ struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display)
>         if (ret)
>                 return ERR_PTR(ret);
>
> -       drm_connector_helper_add(connector, &dp_connector_helper_funcs);
> +       if (dp_display->connector_type == DRM_MODE_CONNECTOR_eDP) {
> +               drm_connector_helper_add(connector,
> +                               &edp_connector_helper_funcs);
> +       } else {
> +               drm_connector_helper_add(connector, &dp_connector_helper_funcs);
>
> -       /*
> -        * Enable HPD to let hpd event is handled when cable is connected.
> -        */
> -       connector->polled = DRM_CONNECTOR_POLL_HPD;
> +               /*
> +                * Enable HPD to let hpd event is handled when cable is connected.
> +                */
> +               connector->polled = DRM_CONNECTOR_POLL_HPD;
> +       }
>
>         drm_connector_attach_encoder(connector, dp_display->encoder);
>
