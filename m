Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEFB5356F3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbiE0AHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiE0AHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:07:32 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10317B7F6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:07:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id v9so3984336oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=I66x+7FpMQ/wBtLlc2u/z/82uGTtjgXiPMDrr2g920w=;
        b=PEvXg6NYoCwjK0NGXEZ2hn2vo+3B/Iahr3MjJG7m9Lf7xgfuRhHAj+UrQovQr5sK1t
         gorhAQE1rQLxZ6nVbXMmJGjUltvLcpfyXBgXnVM0ireoLAn1UaONFEdaPTXymdMKKf/j
         u7VJQMV8yRLsrhgiGczb31887VRMFWv3hRigw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=I66x+7FpMQ/wBtLlc2u/z/82uGTtjgXiPMDrr2g920w=;
        b=6iF+lJLk2MFGUzGyEVB4UqxsNcZzMNoQfhU1MqgnLVPO761vmakEL6jg84itGJ9pEL
         kH1CXDyEN4dZGlS1aypapx+ckJozPaYyJivFHZK/uyJ0qriieNmnI1hWbUxLACQeahkR
         8bdihZaloBfMEeL+0CV82XbWQ8MnaxWKsSZsIeY85s1UOY+ejRVbqAIRpYsp8LoPSl0j
         y1+TU7l5yGfVbVXiIaVkUY799NwPZGGBuUSIFLyAU1Qf3A2+ywVMMRSwzJVFMbU3m97R
         hlexUNfQCkPkdnglirY2DRICDDMHBFImrW8swSyVqkz/VmbMixMSsKUGr6rhn+KPvIsm
         QmQg==
X-Gm-Message-State: AOAM530DmjXebueME1J6Pgqac4JnbGT8fBbBnj2ZX0wpJYxgouV8vQLK
        9VQdUoNZzmO6P0f/gNb64NxS/n/x6hjV3C6FKmVDcA==
X-Google-Smtp-Source: ABdhPJwYTes7uRHQVicLRnu5H56KAA0qsmT7hOagsKyS83huZcCEZx7oNWPzI5ODbVQ9XXwsM/9tTYx4y7do1puc7Pc=
X-Received: by 2002:a05:6808:2025:b0:32b:7da5:a598 with SMTP id
 q37-20020a056808202500b0032b7da5a598mr2622131oiw.63.1653610050356; Thu, 26
 May 2022 17:07:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 May 2022 20:07:29 -0400
MIME-Version: 1.0
In-Reply-To: <1653585978-30090-1-git-send-email-quic_khsieh@quicinc.com>
References: <1653585978-30090-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 26 May 2022 20:07:29 -0400
Message-ID: <CAE-0n53Nr7o=ZmSsBWOjUxCKxMYNrVwuVdbdL0wG7WZyrPo4Yw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: force link training for display resolution change
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-05-26 10:26:18)
> During display resolution changes display have to be disabled first
> followed by display enable with new resolution. This patch force
> main link always be retrained during display enable procedure to
> simplify implementation instead of manually kicking of irq_hpd
> handle.

How is that better? Can you please describe how it improves things? I
suppose it avoids some round trips through the event queue just to turn
on the display?

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Any Fixes tag? Or it's not fixing anything, just making things simpler?

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 5ddb4e8..8b71013 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index 2433edb..dcc7af21 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -20,7 +20,7 @@ struct dp_ctrl {
>  };
>
>  int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl);
> -int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl);
> +int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train);

Can we have another API like dp_ctrl_on_stream_retrain()? Or name
'force_link_train' to 'retrain'?

>  int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_off(struct dp_ctrl *dp_ctrl);
>  void dp_ctrl_push_idle(struct dp_ctrl *dp_ctrl);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bfc6581..9246421 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -892,7 +892,7 @@ static int dp_display_enable(struct dp_display_private *dp, u32 data)

Any reason why dp_display_enable() is forward declared and why it takes
a u32 data argument? It's not part of the eventqueue calling code from
what I can tell so we should be able to rename 'data' to 'retrain_link'?

>                 return 0;
>         }
>
> -       rc = dp_ctrl_on_stream(dp->ctrl);
> +       rc = dp_ctrl_on_stream(dp->ctrl, data);
>         if (!rc)
>                 dp_display->power_on = true;
>
> @@ -1594,6 +1594,7 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
>         int rc = 0;
>         struct dp_display_private *dp_display;
>         u32 state;
> +       bool force_link_train = false;
>
>         dp_display = container_of(dp, struct dp_display_private, dp_display);
>         if (!dp_display->dp_mode.drm_mode.clock) {
> @@ -1622,10 +1623,12 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
>
>         state =  dp_display->hpd_state;
>
> -       if (state == ST_DISPLAY_OFF)
> +       if (state == ST_DISPLAY_OFF) {
>                 dp_display_host_phy_init(dp_display);
> +               force_link_train = 1;

Use true instead of 1 if the type is a bool please.

> +       }
>
> -       dp_display_enable(dp_display, 0);
> +       dp_display_enable(dp_display, force_link_train);
>
>         rc = dp_display_post_enable(dp);
>         if (rc) {
