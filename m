Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AEF48F216
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiANVlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiANVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:41:46 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:41:45 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id t9so13996811oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=EiF4kxaLYYslVsSU2sOxDU0qaE58YW7xc6wp1g7lJQQ=;
        b=aJyozUrkyudyCMwztwokNGSEAVnw6wQjjRztzVHW4JAvcr8WI07NRwpnWsK0diRUPt
         Fg6IeQRZP9g8Ds56ymeldBaTBbQqvfd81JsjFfxduSl/Fq9np23NPioUWZ99mkBngw4z
         XrI1d2GSV/i8mv1RJQoL4rGUg51B6kowqwvtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=EiF4kxaLYYslVsSU2sOxDU0qaE58YW7xc6wp1g7lJQQ=;
        b=lUQellET0vGgG7FNAIJr5MLhA+mGGuWzy6niGEViU4O7Ng04dxBbVcERD9Cae/A3MG
         e7p7jCxeT3IUUfOzubDWBSzflb9VuKMNIF+BZe/NgireVxIUOMpfgRmhduzUIC8Vx6Wx
         /5GT/p2st2a9S28l9v34SsHmouiY2LNbUp2ALxeWV3JcNRPTdvq7r7Py1N0URMtJNkxb
         P4m4fnl/baey1019EeF2OdfMvS3PGO0C57eBfCkO1KJYHkoPVC/5XfkjfOdUHTds5RCZ
         vM2qwSo7igm5UWvah4PnJo73JxvBWGMAunu9Q/0HC9ALEv3eja2sKeZVdnMamF/s8o2w
         hfsA==
X-Gm-Message-State: AOAM533D24YBaTums1PnV5FNgkllRlhBPH3g2GCypGaE4FrvsSU2iHnA
        /zG0nrg5cnwAxEQrVHTuZVhekCeM1DW/1vKUlrILvw==
X-Google-Smtp-Source: ABdhPJxqXjmHGTouafQMbaFEPOTUQrNELWzSofFuBmD0rN8FxXai9W9dtNego1w9Wr2rWHHHSY+XGSIvw1IVJXLBDn4=
X-Received: by 2002:aca:4382:: with SMTP id q124mr9068196oia.64.1642196504991;
 Fri, 14 Jan 2022 13:41:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Jan 2022 15:41:44 -0600
MIME-Version: 1.0
In-Reply-To: <1642194710-2512-2-git-send-email-quic_khsieh@quicinc.com>
References: <1642194710-2512-1-git-send-email-quic_khsieh@quicinc.com> <1642194710-2512-2-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 14 Jan 2022 15:41:44 -0600
Message-ID: <CAE-0n52UYBajrqGFqppun5oK82V3ppjvQxANU27kL95gCZtURg@mail.gmail.com>
Subject: Re: [PATCH v15 1/4] drm/msm/dp: do not initialize phy until plugin
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

Quoting Kuogee Hsieh (2022-01-14 13:11:47)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 7cc4d21..7cd6222 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -696,12 +699,9 @@ static int dp_irq_hpd_handle(struct dp_display_private *dp, u32 data)
>          * dp core (ahb/aux clks) must be initialized before
>          * irq_hpd be handled
>          */
> -       if (dp->core_initialized) {
> -               ret = dp_display_usbpd_attention_cb(&dp->pdev->dev);
> -               if (ret == -ECONNRESET) { /* cable unplugged */
> -                       dp->core_initialized = false;
> -               }
> -       }
> +       if (dp->core_initialized)

When is this condition false? The irq isn't unmasked until the core has
been initialized. On the resume path I suppose the irq is enabled in
dp_display_host_init() calling dp_ctrl_reset_irq_ctrl(), and then we
could immediately get the interrupt but it will block on the event_mutex
lock.

> +               dp_display_usbpd_attention_cb(&dp->pdev->dev);
> +
>         DRM_DEBUG_DP("hpd_state=%d\n", state);
>
>         mutex_unlock(&dp->event_mutex);
> @@ -1363,14 +1373,16 @@ static int dp_pm_suspend(struct device *dev)
>                 if (dp_power_clk_status(dp->power, DP_CTRL_PM))
>                         dp_ctrl_off_link_stream(dp->ctrl);
>
> +               dp_display_host_phy_exit(dp);
> +
> +               /* host_init will be called at pm_resume */
>                 dp_display_host_deinit(dp);
> +       } else {
> +               dp_display_host_phy_exit(dp);

I fail to see where this condition happens. Can we suspend the device
without the irq being installed?

>         }
>
>         dp->hpd_state = ST_SUSPENDED;
>
> -       /* host_init will be called at pm_resume */
> -       dp->core_initialized = false;
> -
>         DRM_DEBUG_DP("After, core_inited=%d power_on=%d\n",
>                         dp->core_initialized, dp_display->power_on);
>
