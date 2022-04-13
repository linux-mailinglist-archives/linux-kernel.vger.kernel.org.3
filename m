Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E438550027A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbiDMXWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbiDMXWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:22 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8BF23BDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:19:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so2208409otj.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=A76+qe6l2R4PjtaHOG75B4+IXG7YG12PDKm5b7n2jWs=;
        b=SHoATc0eEmqjjIwRKvexraebmX2kGeRzptDhV06lGjHycAYMT+TOpWHUuC00JxUOTj
         RHHtsMgFG+ZIU6axzwN0FQc7X9fdSEWHjTK8L/jGvPcI/8iNhZQrE7OwFAp/5b5lWymZ
         ZpFMog5M4McPKnPsUbvdTa8nAmF0nFb1cEDYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=A76+qe6l2R4PjtaHOG75B4+IXG7YG12PDKm5b7n2jWs=;
        b=THbdngb143iXs/KSmRfcaiVvcLx/whEr+rA6nXKAQcUsWukU3jlF9nfvc1Ec8F4E+O
         S1M2GBpq1OEEGYJMvHERYHjhD1sn8kVetZGIS6OpWjBBjTlQeIKTReq+KWFa+OJuc4Bb
         FUIDvpDGLtSFHBwbr8PvFenWF7s17oXqkaElz9/2LwFFHcw4FrYEVIeqZSR9APH2gNjO
         H/TVO9I3sPRb0GdJpXZVDCej1huEoO0/8lfBGELLtPRgZYsEIAmrJwWbN6ZViObZSI5x
         hcLUZrdg3e8yCN7jL0oPZJTx10NQW9D26n5sjkGj/9fMCK2gcJ1lUtG2obecwCw0L3yj
         RQvA==
X-Gm-Message-State: AOAM532/F6QcoVie+DjTGR4l4g9Eu7FFVvIo2BUovZlT+15A/hNz5wUW
        WeEM9wtZBbFnNPuieoaJT9ubxjAuOtoTDHADhwglCA==
X-Google-Smtp-Source: ABdhPJz4zQOvWO+Ka65MElptgAevAeXuKyDHAfQnJYr8K685AAWqQ2cIPgcN1VMnmhtkiEpddCxTwpmuwEtmVKjoZ5o=
X-Received: by 2002:a9d:b85:0:b0:5cb:3eeb:d188 with SMTP id
 5-20020a9d0b85000000b005cb3eebd188mr10346oth.77.1649891999102; Wed, 13 Apr
 2022 16:19:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Apr 2022 16:19:58 -0700
MIME-Version: 1.0
In-Reply-To: <1649883865-9012-1-git-send-email-quic_khsieh@quicinc.com>
References: <1649883865-9012-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 13 Apr 2022 16:19:58 -0700
Message-ID: <CAE-0n5259qjMj12LXRp=7kQ7zT3bRMaHpSpwKMwZ8HL6rq7fbw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: stop event kernel thread when DP unbind
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-04-13 14:04:25)
> Current DP driver implementation, event thread is kept running
> after DP display is unbind. This patch fix this problem by disabling
> DP irq and stop event thread to exit gracefully at dp_display_unbind().
>
> Changes in v2:
> -- start event thread at dp_display_bind()
>
> Fixes: e91e3065a806 ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 40 +++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 01453db..943e4f1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -113,6 +113,7 @@ struct dp_display_private {
>         u32 hpd_state;
>         u32 event_pndx;
>         u32 event_gndx;
> +       struct task_struct *ev_tsk;
>         struct dp_event event_list[DP_EVENT_Q_MAX];
>         spinlock_t event_lock;
>
> @@ -230,6 +231,31 @@ void dp_display_signal_audio_complete(struct msm_dp *dp_display)
>         complete_all(&dp->audio_comp);
>  }
>
> +static int hpd_event_thread(void *data);

Is there a reason why this is needed vs. defining the kthread start
function after hpd_event_thread()?

> +
> +static void dp_hpd_event_setup(struct dp_display_private *dp_priv)

Maybe dp_hpd_event_thread_start()?

> +{
> +       init_waitqueue_head(&dp_priv->event_q);
> +       spin_lock_init(&dp_priv->event_lock);
> +
> +       dp_priv->ev_tsk = kthread_run(hpd_event_thread, dp_priv, "dp_hpd_handler");
> +
> +       if (IS_ERR(dp_priv->ev_tsk))
> +               DRM_ERROR("failed to create DP event thread\n");

Can we return an error from this function?

> +}
> +
> +static void dp_hpd_event_stop(struct dp_display_private *dp_priv)

Maybe dp_hpd_event_thread_stop()?

> +{
> +       if (IS_ERR(dp_priv->ev_tsk))
> +               return;

If we handled the error then this check becomes impossible.

> +
> +       kthread_stop(dp_priv->ev_tsk);
> +
> +       /* reset event q to empty */
> +       dp_priv->event_gndx = 0;
> +       dp_priv->event_pndx = 0;
> +}
> +
>  static int dp_display_bind(struct device *dev, struct device *master,
>                            void *data)
>  {
> @@ -269,6 +295,7 @@ static int dp_display_bind(struct device *dev, struct device *master,
>         if (rc)
>                 DRM_ERROR("Audio registration Dp failed\n");
>
> +       dp_hpd_event_setup(dp); /* start event thread */

The comment is useless, please remove.

>  end:
>         return rc;
>  }
> @@ -280,6 +307,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>         struct drm_device *drm = dev_get_drvdata(master);
>         struct msm_drm_private *priv = drm->dev_private;
>
> +       disable_irq(dp->irq);

Is the disable_irq() necessary? It would be nicer to silence the
hardware and remove the disable_irq() so that we can reason about the
code assuming the irq is always enabled after it is requested.

> +       dp_hpd_event_stop(dp); /* stop event thread */
>         dp_power_client_deinit(dp->power);
>         dp_aux_unregister(dp->aux);
>         priv->dp[dp->id] = NULL;
