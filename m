Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AF147509B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbhLOBuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhLOBuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:50:52 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:50:52 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso23071187ota.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=X8BNLsBux2AXya8Toe9pz3z2hfhJJ8ODRuIPLURO8n4=;
        b=hxOuAmS0GH3gTmzxlY2ckaN2Zd1HLGwM5os8kOAmtBFXwBpB0KORzQTVfduGvFW2M6
         R7Tmh4lmfXbJdpFEoW5Yt1rlLuMK6Z7/DlcgVNZ8EWUbyQxwMcVAhsz5c0nZtXtjSNXh
         V0jc3gzeOuIUg8h1NLBAb12d2BQqYXVg7o35s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=X8BNLsBux2AXya8Toe9pz3z2hfhJJ8ODRuIPLURO8n4=;
        b=H6KrlXnN+gijt7vo2Cs0muKrCIZxkc+T5dS19JMePKjp9/OABeTL+iEUg2DdJODJb9
         VDohOwv4P28OuQMnBVFn76uQdrmax4ygzcF68YxzdYxIXZ3/IMMQVToL7tQdhwRTEqwr
         BwjpR9Bfsey+V2oy3Ju/n8yOzGcDqp5Ivl/lAxAjKaDWFfd2nj02OgOWm9WZNSIJwri1
         tU9BtoKqM6sFz2d0PBpg9sL1TtlYPBoKGaK/ppxI7mOGRALAiQI6Oq67UNRI0xSODaWA
         ZTLezXQATvJtVIysuZgOmFNBwCQzYKXmuV64zgf87/zxYcJycHGW1PX6JltHhoPykZKr
         NiMQ==
X-Gm-Message-State: AOAM530XsY9NfE4ndTIstMdAdAS/mlqNclbccZNhMx75UQcTvNfZEyaz
        FdB2lGZnXo0OkGyRccUxQMVpQ9a3yO+nnKqZg37zSg==
X-Google-Smtp-Source: ABdhPJyXpuhWZ5m+m/2N9Y1iXuZP8AcuSjzJuNVAOm4SuBQtVSqPmW2e+rAaYwOg+X0ba7Sj5Ceq5UPVHtUml/aSv3c=
X-Received: by 2002:a9d:70ce:: with SMTP id w14mr6924071otj.77.1639533051758;
 Tue, 14 Dec 2021 17:50:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 02:50:51 +0100
MIME-Version: 1.0
In-Reply-To: <1639085707-27845-1-git-send-email-quic_khsieh@quicinc.com>
References: <1639085707-27845-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 15 Dec 2021 02:50:51 +0100
Message-ID: <CAE-0n51pbf3GqwA-wtTe5+rRvA_KMmb8kd6fqqDtZRX+X_3qiA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/msm/dp: do not initialize phy until plugin
 interrupt received
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-12-09 13:35:07)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 0766752..cfbc5e4 100644
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
> @@ -371,21 +372,46 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
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

Is this check only here because we don't know when this function is
getting called? I see in the DP case we get here from
dp_display_usbpd_configure_cb() but in the eDP case we get here from
dp_display_host_init() and presumably again from
dp_display_usbpd_configure_cb() called by dp_hpd_plug_handle().

If at all possible, I'd prefer to not have another tracking variable and
call dp_display_host_phy_init() from the same place regardless of DP or
eDP. Doing that would make it symmetric, per the commit text.

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
>                 DRM_DEBUG_DP("DP core already initialized\n");
>                 return;
>         }
>
> -       if (dp->usbpd->orientation == ORIENTATION_CC2)
> -               flip = true;
> +       dp_power_init(dp->power, false);
> +       dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
> +
> +       /*
> +        * eDP is the embedded primary display and has its own phy
> +        * initialize phy immediately

Can we get some more details here? Why is it better to initialize the
phy here vs. when HPD goes high on the panel? The comment says what the
code is doing but it isn't telling us why that's OK.

> +        */
> +       if (dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP)
> +               dp_display_host_phy_init(dp);
>
> -       dp_power_init(dp->power, flip);
> -       dp_ctrl_host_init(dp->ctrl, flip, reset);
>         dp_aux_init(dp->aux);
>         dp->core_initialized = true;
>  }
