Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA54C4D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiBYSSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiBYSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:18:24 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C7DE2C7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:17:51 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so7345661oot.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=wxzgaXVTKy5EES1TRJ7ejkTF/2tYnEDDcA0Li/fS4aE=;
        b=mYVpuGrtEWbchzTcq8SzisB3Dmr81a3xOW3aHe6d4yX24JJ3Vr+Th2CqS0G1Je67B1
         Iu19HV1xT6cHIE8Z0VjU74wriirnietFRbihvYJrPGUzbgXHhiHBz+A9qP0pELuWp5RB
         bRnr+UhecER3aTJWhtvbTKocdkStd3ogbRpzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=wxzgaXVTKy5EES1TRJ7ejkTF/2tYnEDDcA0Li/fS4aE=;
        b=k4zWx1uZETgJSOOkdWUD9uJbMugs7KhIzraz0ykRxd0JkevTZeCB2q3qDrZAQu0pTV
         CVf3ZzGSqtr4yx1DKREdNouZpRmnkOdgxhCS54gWEC4NB18YCiHOtrVc/GIB2K2krV3T
         kAUjiw0Op8V0HnH4lXbR9/5bauIKEbkHniW7sgK1iEgCHGa7p45Klx+DjpYYp83TSzPi
         RctadWpxLgwCoIp3YM4EQvdSdTeXeS73MkztyIIPqUjOcG3j2SS8IYOejUjpHyfc79p+
         vGGIjHv5pdq+V2H0zczYv4+xUyAL2x/CEJD2yck4QMNs76zorjkcHsiVdsSMf4xX2cgs
         APSA==
X-Gm-Message-State: AOAM5321ix9Huz/Gdx/kERWFRnMBDHgB/tU6SRDmZAZnbHitasjYuBXw
        shB7ek3Bo95JRZxlVKWoin5bDVEVHvbWGDz2ybEKgQ==
X-Google-Smtp-Source: ABdhPJwfMBN5RkiK03guTIfAYSQ9o6xUbKeaGtFGCKz0ZfpXn/qVV5a+Aj+7sZkaSz+fl2A+/TOH2UtDw3hJRPtW/Dw=
X-Received: by 2002:a05:6870:631a:b0:d1:7d97:806 with SMTP id
 s26-20020a056870631a00b000d17d970806mr1859018oao.8.1645813070807; Fri, 25 Feb
 2022 10:17:50 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Feb 2022 10:17:50 -0800
MIME-Version: 1.0
In-Reply-To: <1645576060-3046-5-git-send-email-quic_khsieh@quicinc.com>
References: <1645576060-3046-1-git-send-email-quic_khsieh@quicinc.com> <1645576060-3046-5-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Feb 2022 10:17:50 -0800
Message-ID: <CAE-0n53Vcvw+mjbKByWE2PqRAiqHuJWVngiH-8AbJAVrc3Ph4w@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] drm/msm/dp: enable widebus feature for display port
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Quoting Kuogee Hsieh (2022-02-22 16:27:40)
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index 6ae9b29..c789f4e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -483,6 +485,22 @@ int dp_catalog_ctrl_set_pattern(struct dp_catalog *dp_catalog,
>  }
>
>  /**
> + * dp_catalog_hw_revision() - retrieve DP hw revision
> + *
> + * @dp_catalog: DP catalog structure
> + *
> + * Return: DP controller hw revision
> + *
> + */
> +u32 dp_catalog_hw_revision(struct dp_catalog *dp_catalog)

Could be const

> +{
> +       struct dp_catalog_private *catalog = container_of(dp_catalog,
> +                               struct dp_catalog_private, dp_catalog);
> +
> +       return dp_read_ahb(catalog, REG_DP_HW_VERSION);

If dp_read_ahb() took a const catalog, which it could.

> +}
> +
> +/**
>   * dp_catalog_ctrl_reset() - reset DP controller
>   *
>   * @dp_catalog: DP catalog structure
> @@ -743,6 +761,7 @@ int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog)
>  {
>         struct dp_catalog_private *catalog = container_of(dp_catalog,
>                                 struct dp_catalog_private, dp_catalog);
> +       u32 reg;
>
>         dp_write_link(catalog, REG_DP_TOTAL_HOR_VER,
>                                 dp_catalog->total);
> @@ -751,7 +770,18 @@ int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog)
>         dp_write_link(catalog, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY,
>                                 dp_catalog->width_blanking);
>         dp_write_link(catalog, REG_DP_ACTIVE_HOR_VER, dp_catalog->dp_active);
> -       dp_write_p0(catalog, MMSS_DP_INTF_CONFIG, 0);
> +
> +       reg = dp_read_p0(catalog, MMSS_DP_INTF_CONFIG);
> +
> +       if (dp_catalog->wide_bus_en)
> +               reg |= DP_INTF_CONFIG_DATABUS_WIDEN;
> +       else
> +               reg &= ~DP_INTF_CONFIG_DATABUS_WIDEN;
> +
> +
> +       DRM_DEBUG_DP("wide_bus_en=%d reg=%x\n", dp_catalog->wide_bus_en, reg);

Use %#x to get 0x prefix on the hex please.

> +
> +       dp_write_p0(catalog, MMSS_DP_INTF_CONFIG, reg);
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index 2363a2d..a0a5fbb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -17,6 +17,7 @@ struct dp_ctrl {
>         bool orientation;
>         atomic_t aborted;
>         u32 pixel_rate;
> +       bool wide_bus_en;
>  };
>
>  int dp_ctrl_host_init(struct dp_ctrl *dp_ctrl, bool flip, bool reset);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 7cc4d21..ba76358 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1437,6 +1445,15 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display)
>         dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
>  }
>
> +bool msm_dp_wide_bus_available(struct msm_dp *dp_display)

const?

> +{
> +       struct dp_display_private *dp;
> +
> +       dp = container_of(dp_display, struct dp_display_private, dp_display);
> +
> +       return dp->wide_bus_en;
> +}
> +
>  void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
>  {
>         struct dp_display_private *dp;
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index e3adcd5..b718cc9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -24,6 +24,8 @@ struct msm_dp {
>
>         hdmi_codec_plugged_cb plugged_cb;
>
> +       bool wide_bus_en;
> +
>         u32 max_pclk_khz;
>
>         u32 max_dp_lanes;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index d7574e6..d413deb 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -399,6 +399,7 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display);
>  void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display);
>
>  void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor);
> +bool msm_dp_wide_bus_available(struct msm_dp *dp_display);
>
>  #else
>  static inline int __init msm_dp_register(void)
> @@ -449,6 +450,11 @@ static inline void msm_dp_debugfs_init(struct msm_dp *dp_display,
>  {
>  }
>
> +static inline bool msm_dp_wide_bus_available(struct msm_dp *dp_display)

const?

> +{
> +       return false;
> +}
> +
>  #endif
>
>  void __init msm_mdp_register(void);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
