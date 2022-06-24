Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C95558C20
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiFXAJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiFXAJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:09:49 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC25D105
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:09:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h15-20020a9d600f000000b0060c02d737ecso725287otj.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=tNICjC0mqZ74g4NWx01ZNVZ2tkGnF23qOG9pMURoZhI=;
        b=keigWUEC4et/ph4vYev3R+C43rBbm6avYfx1ICG8YUlMjI17zFbQ2NqdKaLjP20MgD
         03TUpRIu3LgOXZ1LnijQy9VU1OpjjuxDho5zFrbATU/RB9F/5S2AJ9Z0bf26Xo+1ooT0
         XGnZvujpKw3kMWwkNxBRfcYiO47Af/Ydzdzyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=tNICjC0mqZ74g4NWx01ZNVZ2tkGnF23qOG9pMURoZhI=;
        b=MhZdElpQMFnmPTQb3H6f1iGbzA2lsHHM2Fi96+sNTc8+oLD4AMfvYsZTm3BC9qY3vC
         g8sIz+H0J/0yvxGFjHkt/wAcjiLaDLP282I4YR5xxg4UcNzrtzjIMKdXAHLbOYwhUlsF
         UvMaG/V4thjBGX52VmPEyAwaK9else9jCezdCJBhnEw/F1WpIpHhMyNp2mvP3lOMOrAs
         hYCBY4UpuWC80RLsyH23BIhwJsKiWwdFzeHQqEAGEC8zdXRr3APVcoY33MQVnVSHp+o1
         4UfGDlV7GCqm529TNEHrxf9Sw7SUG8m2hgDjCzli+8B9CXDjiCgy8ugSGTlHjpWFJLOH
         4eXQ==
X-Gm-Message-State: AJIora++7yJ12pICJGqBv5Hh6zPlkCw5zn1+oHp6wncohlO/Blp1cd6o
        l5ZtAd64jtmo9ppkbhdBELBrTKc4otnlom7kGSrKXg==
X-Google-Smtp-Source: AGRyM1toYtnlSvt/KriWql1qkmbYZ0fd3ZbL7W+3GyjF+TFTpfJIy6lNOXNS1wd+UjrciaaVGHz2lZIw6TxPwoIv6+Y=
X-Received: by 2002:a9d:729b:0:b0:60c:21bd:97c0 with SMTP id
 t27-20020a9d729b000000b0060c21bd97c0mr4954986otj.77.1656029388070; Thu, 23
 Jun 2022 17:09:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jun 2022 17:09:47 -0700
MIME-Version: 1.0
In-Reply-To: <1656027256-6552-1-git-send-email-quic_khsieh@quicinc.com>
References: <1656027256-6552-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 23 Jun 2022 17:09:47 -0700
Message-ID: <CAE-0n534jvnjX5TShZw7CB9Cu9F7yowhwUosNkJE8t_R4xHYOw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: no dp_hpd_unplug_handle() required for eDP
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-06-23 16:34:16)
> eDP implementation does not reuried to support hpd signal. Therefore

s/reuried/require/

> it only has either ST_DISPLAY_OFF or ST_CONNECTED state during normal
> operation. This patch remove unnecessary dp_hpd_unplug_handle() for
> eDP but still keep dp_hpd_plug_handle() to support eDP to either
> booting up or resume from ST_DISCONNECTED state.

I take it that making this change also fixes a glitch seen on the eDP
panel when a second modeset happens? Can you add that detail to the
commit text? The way it reads makes it sound like this is purely a
cleanup patch, but then there's a Fixes tag so it must be a bug fix or
worthy optimization, neither of which is described.

>
> Fixes: 391c96ff0555 ("drm/msm/dp: Support only IRQ_HPD and REPLUG interrupts for eDP")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index da5c03a..ef9794e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1666,7 +1666,7 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>                 return;
>         }
>
> -       if (dp->is_edp)
> +       if (dp->is_edp && dp_display->hpd_state == ST_DISCONNECTED)
>                 dp_hpd_plug_handle(dp_display, 0);
>
>         mutex_lock(&dp_display->event_mutex);
> @@ -1737,9 +1737,6 @@ void dp_bridge_post_disable(struct drm_bridge *drm_bridge)
>
>         dp_display = container_of(dp, struct dp_display_private, dp_display);
>
> -       if (dp->is_edp)
> -               dp_hpd_unplug_handle(dp_display, 0);

dp_hpd_unplug_handle() has a !edp check, and from what I can tell after
this patch that condition will always trigger? But then I wonder why we
aren't masking the irqs for hpd when the eDP display is disabled.
Shouldn't we at least be doing that so that we don't get spurious hpd
irqs when the eDP display is off or on the path to suspend where I
suspect the power may be removed from the panel?
