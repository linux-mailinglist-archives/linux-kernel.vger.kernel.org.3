Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874795002E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 02:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiDNAFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 20:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiDNAFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:05:18 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB4438185
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 17:02:55 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id b188so3735294oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 17:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=C7D4i18WnxrgBXf4shxFqYln81+Lfr4ATkdTNtqU2ck=;
        b=W/ZABInJ4czkJM0vDyGAwz3yEFAMCEvHtVtCMDXOfyAgDwS2wBCaP2hw7blb+saGYC
         k2L9RxkO1rbutRE9dOvAdtQOz46YmvYGCkUHPJp2yfGN9HPkVKSrcMZpIFFhahvFsC0j
         1g9Ny3Ibq+nxS9D+C4zgzsbe4tqNZ8PgNwzUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=C7D4i18WnxrgBXf4shxFqYln81+Lfr4ATkdTNtqU2ck=;
        b=VGZM/d2lVp3I1g5E4wRLu8IDw29zDRs25ByFXc1O6z67OQ6z2WF1dZ4YfUh9fYYHsO
         2ROAFGKqRxg66SESNFRkJqMtou/QKtNPDuMi5uIkCfEEVd4dNEs41XfuZPgtNuOaTnTH
         iWYfuMERZUV9LNedp7MXX+WVxSStvY8in9K1VQcr+pEChKDaE2mfvAj49fn9/V5Gn++n
         gNbdqXVuOiCGmr95SG6FyPaY1I7jq1A4fUxnTDvJk2yark7xkcE+6O65jLTixMJw/ckC
         J/tZ0Pvs70fOrctX7B6LC9X6EO4hY8S0Cu5CqAsRweIfUicLun38DSD0b6/2A6KV/a82
         V+ow==
X-Gm-Message-State: AOAM531o7dPUM2tFoSPna04+6I+7iom+EwUEvTobsDo+4zG3eSkzApHZ
        YYaNkTMrEDF4s2tuS3v/2YzsaCKqJrs9fycHQP2o5A==
X-Google-Smtp-Source: ABdhPJzp2cTMSMi7Tz42NyDd50anioDt8Jea6q6Rz9Ad1fmvO4ymY/ZP6diGOQmXMoE+vv2JGFKQrFhNXF1AbVQ6YkY=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr265612oif.63.1649894574930; Wed, 13 Apr
 2022 17:02:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Apr 2022 17:02:54 -0700
MIME-Version: 1.0
In-Reply-To: <1649280493-4393-1-git-send-email-quic_khsieh@quicinc.com>
References: <1649280493-4393-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 13 Apr 2022 17:02:54 -0700
Message-ID: <CAE-0n511nbPrRCMx3E2De-htmR79vZr4ezSj13Gm1PbTGasC4A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: enhance both connect and disconnect
 pending_timeout handle
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

The subject is still misleading. It is fixing something. It may be
enhancing it as well but it is clearly fixing it first.

Quoting Kuogee Hsieh (2022-04-06 14:28:13)
> dp_hpd_plug_handle() is responsible for setting up main link and send
> uevent to notify user space framework to start video stream. Similarly,
> dp_hdp_unplug_handle is responsible to send uevent to notify user space
> framework to stop video stream and then tear down main link.
> However there are rare cases, such as in the middle of system suspending,
> that uevent could not be delivered to user space framework. Therefore
> some kind of recover mechanism armed by timer need to be in place in the
> case of user space framework does not respond to uevent.
>
> This patch have both dp_conenct_pending_timeout and
> dp_disconnect_pending_timeout are used to stop video stream and tear down
> main link and eventually restore DP driver state to known default
> DISCONNECTED state in the case of timer fired due to framework does not
> respond to uevent so that DP driver can recover itself gracefully at next
> dongle unplug followed by plugin event.
>
> Changes in v2:
> -- replace dp_display_usbpd_disconnect_cb with dp_display_notify_disconnect

I'd prefer this part to be a different patch. It can come after the fix
to ease backporting.

Also, is there any response to Dmitry's question yet? I haven't seen
anything.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index 2433edb..ffafe17 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -22,6 +22,7 @@ struct dp_ctrl {
>  int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl);
> +int dp_ctrl_off_link(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_off(struct dp_ctrl *dp_ctrl);
>  void dp_ctrl_push_idle(struct dp_ctrl *dp_ctrl);
>  void dp_ctrl_isr(struct dp_ctrl *dp_ctrl);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 178b774..a6200a5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -451,11 +451,14 @@ static int dp_display_usbpd_configure_cb(struct device *dev)
>
>  static int dp_display_usbpd_disconnect_cb(struct device *dev)

We shouldn't need to keep around an empty function.

>  {
> +       return 0;
> +}
> +
> +static void dp_display_notify_disconnect(struct device *dev)
> +{
>         struct dp_display_private *dp = dev_get_dp_display_private(dev);
>
>         dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
> -
> -       return 0;
>  }
>
>  static void dp_display_handle_video_request(struct dp_display_private *dp)
> @@ -593,10 +596,16 @@ static int dp_connect_pending_timeout(struct dp_display_private *dp, u32 data)
>
>         mutex_lock(&dp->event_mutex);
>
> +       /*
> +        * main link had been setup but video is not ready yet
> +        * only tear down main link
> +        */
>         state = dp->hpd_state;
>         if (state == ST_CONNECT_PENDING) {
> -               dp->hpd_state = ST_CONNECTED;
>                 DRM_DEBUG_DP("type=%d\n", dp->dp_display.connector_type);
> +               dp_ctrl_off_link(dp->ctrl);
> +               dp_display_host_phy_exit(dp);
> +               dp->hpd_state = ST_DISCONNECTED;
>         }
>
>         mutex_unlock(&dp->event_mutex);
> @@ -645,6 +654,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>                 if (dp->link->sink_count == 0) {
>                         dp_display_host_phy_exit(dp);
>                 }
> +               dp_display_notify_disconnect(&dp->pdev->dev);
>                 mutex_unlock(&dp->event_mutex);
>                 return 0;
>         }
> @@ -661,19 +671,22 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>                 return 0;
>         }
>
> -       dp->hpd_state = ST_DISCONNECT_PENDING;
> -
>         /* disable HPD plug interrupts */
>         dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, false);
>
>         /*
>          * We don't need separate work for disconnect as
>          * connect/attention interrupts are disabled
> -        */
> -       dp_display_usbpd_disconnect_cb(&dp->pdev->dev);
> +       */

This comment end is wrong. It should be unchanged.

> +       dp_display_notify_disconnect(&dp->pdev->dev);
>
> -       /* start sentinel checking in case of missing uevent */
> -       dp_add_event(dp, EV_DISCONNECT_PENDING_TIMEOUT, 0, DP_TIMEOUT_5_SECOND);
> +       if (state == ST_DISPLAY_OFF) {
> +               dp->hpd_state = ST_DISCONNECTED;
> +       } else {
> +               /* start sentinel checking in case of missing uevent */
> +               dp_add_event(dp, EV_DISCONNECT_PENDING_TIMEOUT, 0, DP_TIMEOUT_5_SECOND);
> +               dp->hpd_state = ST_DISCONNECT_PENDING;
> +       }
>
>         /* signal the disconnect event early to ensure proper teardown */
>         dp_display_handle_plugged_change(&dp->dp_display, false);
> @@ -695,10 +708,16 @@ static int dp_disconnect_pending_timeout(struct dp_display_private *dp, u32 data
>
>         mutex_lock(&dp->event_mutex);
>
> +       /*
> +        * main link had been set up and video is ready
> +        * tear down main link, video stream and phy
> +        */
>         state =  dp->hpd_state;
>         if (state == ST_DISCONNECT_PENDING) {
> -               dp->hpd_state = ST_DISCONNECTED;
>                 DRM_DEBUG_DP("type=%d\n", dp->dp_display.connector_type);
> +               dp_ctrl_off(dp->ctrl);
> +               dp_display_host_phy_exit(dp);
> +               dp->hpd_state = ST_DISCONNECTED;
>         }
>
>         mutex_unlock(&dp->event_mutex);
