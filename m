Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D287C53666F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354245AbiE0RNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354218AbiE0RNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:13:13 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C1514085D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:13:09 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id f11so4426034qvs.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=He5Z880deQ+rHC3rXPdLq3UZsPKkMx+IDLVC2xRb+9A=;
        b=H6BoZqF8zOP1lGYOICiczwty00BoXs6H9LvhkAQXnymNrIqvHV4oIBeBfom5GiX9Rv
         3RSN+TWL/l4khVIft7Q08umuFCAjNlRpK4DbEDUkAuX3UOaz/ApduURIZ4m19qrJHx8k
         qeyQqUQyzPx+CDIrRJvJvJGSOPxbmbr2TyiQUpRMjN6J78024w/Pq6sLYDR4fJfMCn7m
         cqvGTRqwfK3bFbDVDiczLUNyflSZHpDMpyL4BISqqk7x75SmIAV8XXkQIT4nXUnAsYC3
         EaPiWdR3o3pSVm61Uwa37UalFONIvf6jes3Pkgu4vgEfPlcpeVrT3BE0m3tRa92jBSC9
         qFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=He5Z880deQ+rHC3rXPdLq3UZsPKkMx+IDLVC2xRb+9A=;
        b=qf7oIP8v2Gt6ErT9uYg6yRfavxwIQIb3hac7BrRjSYcBzoLGUrx6WJ/JFVf88wur8G
         I3lO9T5CVa5KnwfFwcT+/eIv9WZmLH0zQsq9RRCXIpRHqs8arSROkUTF2uRBdBQBRXMo
         INHynhO+x/X9cqgs8ID2D5PaaeBU8tI+qt4P2b95a0B/5CurV2DLOY3m7CxnKUSGiEa7
         qC5nEqxnrEqMzXDQUcooBBUnIFiL/Yqv7LgCWrYBE9CPqTCvUkW+t9tsCWmXMQ9ab1od
         6Rm00nV82hk2lRQJHqMsrXeUAUwOKvH4vwUQC7ebtzvtmZcghgf8yGF8A+gkc8KspiaM
         NnAg==
X-Gm-Message-State: AOAM531kDDHUVcY/1/f35Spj6G+qjJf9KXAHOSMNr36aJ+6dT6zESWlV
        QiDFDu9v0UHbCrQeX9EOsp/0jg07SR0Tt+73tVldRQ==
X-Google-Smtp-Source: ABdhPJyLajCwh6cHWo6kFY1LM0+Ej77aFJuT7mI9x+wbmFIz6e2Ibbsd2IkwMQLCuiaNBnR1eO27NL0RthmorHIrX9U=
X-Received: by 2002:ad4:5dc6:0:b0:461:e12e:932f with SMTP id
 m6-20020ad45dc6000000b00461e12e932fmr35835497qvh.115.1653671588577; Fri, 27
 May 2022 10:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <1653667696-25560-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1653667696-25560-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 27 May 2022 20:12:57 +0300
Message-ID: <CAA8EJpqpc-GZYUp53zC_tbq+i6r77fZXbBrBiKLqakybH8k7jw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: force link training for display resolution change
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 at 19:08, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> During display resolution changes display have to be disabled first
> followed by display enabling with new resolution. At current
> implementation, display enable function manually kicks up
> irq_hpd_handle which will read panel link status and start link
> training if link status is not in sync state. However, there is rare
> case that panel links status stay in synch which cause link training
> be skipped. Hence display resolution change failed.

This doesn't describe why resolution change fails if link training is skipped.

> This patch force
> main link always be retrained during display enable procedure to
> prevent rare failed case from happening. Also this implementation
> are more efficient than manual kicking off irq_hpd_handle function.
>
> Changes in v2:
> -- set force_link_train flag on DP only (is_edp == false)
>
> Changes in v3:
> -- revise commit  text
> -- add Fixes tag
>
> Fixes: 62671d2ef24b ("drm/msm/dp: fixes wrong connection state caused by failure of link train")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  6 +++---
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++-------
>  3 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index af7a80c..bea93eb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1551,7 +1551,7 @@ static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
>
>         ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
>         if (!ret)
> -               ret = dp_ctrl_on_stream(&ctrl->dp_ctrl);
> +               ret = dp_ctrl_on_stream(&ctrl->dp_ctrl, false);
>         else
>                 DRM_ERROR("failed to enable DP link controller\n");
>
> @@ -1807,7 +1807,7 @@ static int dp_ctrl_link_retrain(struct dp_ctrl_private *ctrl)
>         return dp_ctrl_setup_main_link(ctrl, &training_step);
>  }
>
> -int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
> +int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
>  {
>         int ret = 0;
>         bool mainlink_ready = false;
> @@ -1848,7 +1848,7 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>                 return 0;
>         }
>
> -       if (!dp_ctrl_channel_eq_ok(ctrl))
> +       if (force_link_train || !dp_ctrl_channel_eq_ok(ctrl))
>                 dp_ctrl_link_retrain(ctrl);
>
>         /* stop txing train pattern to end link training */
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index 0745fde..b563e2e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -21,7 +21,7 @@ struct dp_ctrl {
>  };
>
>  int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl);
> -int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl);
> +int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train);
>  int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_off_link(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_off(struct dp_ctrl *dp_ctrl);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c388323..370348d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -872,7 +872,7 @@ static int dp_display_enable(struct dp_display_private *dp, u32 data)
>                 return 0;
>         }
>
> -       rc = dp_ctrl_on_stream(dp->ctrl);
> +       rc = dp_ctrl_on_stream(dp->ctrl, data);
>         if (!rc)
>                 dp_display->power_on = true;
>
> @@ -1654,6 +1654,7 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>         int rc = 0;
>         struct dp_display_private *dp_display;
>         u32 state;
> +       bool force_link_train = false;
>
>         dp_display = container_of(dp, struct dp_display_private, dp_display);
>         if (!dp_display->dp_mode.drm_mode.clock) {
> @@ -1688,10 +1689,14 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>
>         state =  dp_display->hpd_state;
>
> -       if (state == ST_DISPLAY_OFF)
> +       if (state == ST_DISPLAY_OFF) {
>                 dp_display_host_phy_init(dp_display);
>
> -       dp_display_enable(dp_display, 0);
> +               if (!dp->is_edp)
> +                       force_link_train = true;
> +       }
> +
> +       dp_display_enable(dp_display, force_link_train);
>
>         rc = dp_display_post_enable(dp);
>         if (rc) {
> @@ -1700,10 +1705,6 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>                 dp_display_unprepare(dp);
>         }
>
> -       /* manual kick off plug event to train link */
> -       if (state == ST_DISPLAY_OFF)
> -               dp_add_event(dp_display, EV_IRQ_HPD_INT, 0, 0);
> -
>         /* completed connection */
>         dp_display->hpd_state = ST_CONNECTED;
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
