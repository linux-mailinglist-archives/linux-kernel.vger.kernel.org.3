Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967E75092F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382897AbiDTWlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382879AbiDTWlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:41:16 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8481140E60
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:28 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e2a00f2cc8so3570345fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/rRRLR9kE0UsT6jhXgLECvjHWzInHv7i/Qn/WtRO8eU=;
        b=hK1r1BG7T0Nz6Vn2cw68wwOg6ikctBqlfOV9F+gJDmElgDZ4iZRG77Cw6YUCiRWwQA
         rs0ORNthVZDv3S/J3z0jPlLXrzuo+N7qnkTw8R3X8NWBtp7eK1MqfkT+UQkvhhnYY7I1
         bK2SUIwL2ZtsM8r02D9x+n4vIf25M2gYYqhaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/rRRLR9kE0UsT6jhXgLECvjHWzInHv7i/Qn/WtRO8eU=;
        b=a5/+KxGbDGfAAEkWnfYQu258Sp4+RTF99wWo6OFCBCWG32iOrFJxwv8+ac6I5+hIXC
         ezMY34zDKoooCFxsdDXi5+sSAYk+qi/oP0j/+EGifDd2qcj9NMLrcMPxt1AaVsXSTbEt
         toOAdtImRLFc8LWSU1mNg44q42VVR6VdXBRBskhahe5xmNr213WTuYhb86eMGPfCH4fM
         gs5Bfo6SzyF9vTSubOrekJAiI6h/kWKckb3dRK106H+lr++DMmGfHze1cLpp+yXtPxO3
         ygAeVaY4pTuP0WVbrgUNKPVNBSNDPVWRFyQwwS0X2RWufJrbwqB74d8Z28vTA+1w7lOH
         NZjg==
X-Gm-Message-State: AOAM533ZbUtO4+SqJNhLmMiXj6T+yhkox1u03HnH6l+q3838LxD5rhzO
        DQKbHOc8aoV7vkeV8aQUp/V1wzBDeyKyaTp1dyjEoA==
X-Google-Smtp-Source: ABdhPJwc+/m0+yq1Mgm3+YSVCSpplRV3ESAb28i5fAuMo4awoMqGV1hwY1Twa5AGi1Daxfb7lgwYR29LBqcIdF28l3Y=
X-Received: by 2002:a05:6870:d7a2:b0:de:a29c:2aa with SMTP id
 bd34-20020a056870d7a200b000dea29c02aamr2649398oab.121.1650494307865; Wed, 20
 Apr 2022 15:38:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Apr 2022 15:38:27 -0700
MIME-Version: 1.0
In-Reply-To: <1649970223-9522-1-git-send-email-quic_khsieh@quicinc.com>
References: <1649970223-9522-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 20 Apr 2022 15:38:27 -0700
Message-ID: <CAE-0n51rp73v6tod98TX3Y_q8TuOppJVdm9Te_9kSNyqyFuoog@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: tear down main link at unplug handle immediately
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-04-14 14:03:43)
> Two stages are required to setup up main link to be ready to transmit
> video stream.
> Stage 1: dp_hpd_plug_handle() perform link training to set up main link
> stage 2: user space framework (msm_dp_display_enable()) to enable pixel
> clock and transfer main link to video ready state.
>
> At current implementation, when dongle unplugged dp_hdp_unplug_handle()
> has to wait until stage 2 completed before it can send link down uevent
> to user space framework to disable pixel clock followed by tearing down
> main link.  This introduce unnecessary latency if dongle unplugged happen
> after stage 1 and before stage 2. It also has possibility leave main link
> stay at ready state after dongle unplugged if framework does not response
> to link down uevent notification. This will prevent next dongle plug in
> from working. This scenario could possibly happen when dongle unplug while
> system in the middle of suspending.
>
> This patch allow unplug handle to tear down main link and notify
> framework link down immediately if dongle unplugged happen after
> stage 1 and before stage 2. With this approach, dp driver is much
> more resilient to any different scenarios. Also redundant both
> dp_connect_pending_timeout() and dp_disconnect_pending_timeout()
> are removed to reduce logic complexity.
>
> Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Some questions below but doesn't seem like it will hold up this patch.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 01453db..f5bd8f5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -615,24 +598,21 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>                 if (dp->link->sink_count == 0) {
>                         dp_display_host_phy_exit(dp);
>                 }
> +               dp_display_notify_disconnect(&dp->pdev->dev);
>                 mutex_unlock(&dp->event_mutex);
>                 return 0;
> -       }
> -
> -       if (state == ST_DISCONNECT_PENDING) {
> +       } else if (state == ST_DISCONNECT_PENDING) {
>                 mutex_unlock(&dp->event_mutex);
>                 return 0;
> -       }
> -
> -       if (state == ST_CONNECT_PENDING) {
> -               /* wait until CONNECTED */
> -               dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 1); /* delay = 1 */
> +       } else if (state == ST_CONNECT_PENDING) {

I take it that ST_CONNECT_PENDING is sort of like "userspace hasn't
handled the uevent yet and modeset hasn't been called but the link is
setup and now we want to tear it down". The state name may want to be
changed to something else.

> +               dp_ctrl_off_link(dp->ctrl);
> +               dp_display_host_phy_exit(dp);
> +               dp->hpd_state = ST_DISCONNECTED;
> +               dp_display_notify_disconnect(&dp->pdev->dev);
>                 mutex_unlock(&dp->event_mutex);
>                 return 0;
>         }
>
> -       dp->hpd_state = ST_DISCONNECT_PENDING;
> -
>         /* disable HPD plug interrupts */
>         dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, false);
>
> @@ -640,10 +620,13 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>          * We don't need separate work for disconnect as
>          * connect/attention interrupts are disabled
>          */
> -       dp_display_usbpd_disconnect_cb(&dp->pdev->dev);
> +       dp_display_notify_disconnect(&dp->pdev->dev);
>
> -       /* start sentinel checking in case of missing uevent */
> -       dp_add_event(dp, EV_DISCONNECT_PENDING_TIMEOUT, 0, DP_TIMEOUT_5_SECOND);
> +       if (state == ST_DISPLAY_OFF) {
> +               dp->hpd_state = ST_DISCONNECTED;
> +       } else {
> +               dp->hpd_state = ST_DISCONNECT_PENDING;
> +       }

Nitpick: No braces needed for single line if clauses.

>
>         DRM_DEBUG_DP("hpd_state=%d\n", state);
>         /* signal the disconnect event early to ensure proper teardown */
> @@ -1529,8 +1480,11 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
>
>         mutex_lock(&dp_display->event_mutex);
>
> -       /* stop sentinel checking */
> -       dp_del_event(dp_display, EV_CONNECT_PENDING_TIMEOUT);
> +       state = dp_display->hpd_state;
> +       if (state != ST_DISPLAY_OFF && state != ST_CONNECT_PENDING) {

Is this to guard against userspace doing an atomic commit when the
display isn't connected? Is that even possible?

> +               mutex_unlock(&dp_display->event_mutex);
> +               return rc;
> +       }
>
>         rc = dp_display_set_mode(dp, &dp_display->dp_mode);
>         if (rc) {
