Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8C1503346
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356508AbiDOXaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 19:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356483AbiDOXaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:30:18 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C60156434
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:27:48 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ec05db3dfbso95194157b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lw2ingGGS+gGAKFN9ab4kSIE68KwTs47CB5NmRh5IDI=;
        b=H160swL5Hq1YmXeDhx04qtBeyRhdvbytbtb0COmyZnBSiMX7T9dIZg/9BIM9Q+Mu7P
         vRwzQVxkSdj1fWHrJzqSNFBhylDSN+PIPrOcivA8Rs44M1JZiDffXTFefOHzlU19AoBC
         yelGEDFnLfMWJ2y0A1Msfsv6sanPxUdpnaSf6LW+MNqKFyHVPST2JfAoViyQNKIgmzrr
         VD5i0LD5UN9lBOz7M49OhW3VjTHWHYQOsZyFMITduTRX1vlF5W5mkBcBO+nyqF3Y3nn4
         ruyPow/CDxcyvIeDc1fxgSrHdAgChh48JmQS4SEdqTgfEMeH+4YTnEPNi7RQbwfjIrDC
         4BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lw2ingGGS+gGAKFN9ab4kSIE68KwTs47CB5NmRh5IDI=;
        b=4p0/5Ic8jU5qbHpmPc7bLqsmIWf9/Z5S10fux0ed9OuHKvcVbZovGZImfG5uZnM5dI
         dtNboaV2dYWUd4qulKQjHfa4OBZ/bs7yis7vQgM8SL6IKLj8lXO67jep+VLXSynOuVAW
         oArTp2etxS7+LdYw3yvdIajhJGgefmwj8/xw17UQFkhtRyP4aDzHySDxo2ljSjy/1iBB
         QT2qwPD9h1Alz3Cx3gJpnz9GK7TWvRbSqlBGCev13U1442UlcxmygKn81+jy2BsDOTRY
         83EfY/ADZa4LDz7Zg3yetBMJlnjwtLRH+YS/7DvZVXuOe2dt+izbjKBtEDDLThOiySIK
         ixIw==
X-Gm-Message-State: AOAM531bLkLpTj3SJKWG3Sq/iqv6eCe0UoA7MVEKgtqY30kqWKgUBaaW
        ZTxAff7WRyRGTlgGloYARXiBklZa7zSkUAjXmmla7g==
X-Google-Smtp-Source: ABdhPJzgzZ+XLhcQBARtnDhsTaiU5NK/RDuIMe92k46YauSu6gt0ItlJUF4iIxOSzz3MagzklP74jI67icxw9csvDh8=
X-Received: by 2002:a81:753:0:b0:2eb:ebe9:ff4f with SMTP id
 80-20020a810753000000b002ebebe9ff4fmr1082658ywh.255.1650065267380; Fri, 15
 Apr 2022 16:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <1650062064-11838-1-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJpopw4rh0ZkFd5F4zHVJQw6GUNq=+HKVycOx0bXd5OWizQ@mail.gmail.com> <f4bc072f-9ec6-d57e-28de-e3f7aba21cd7@quicinc.com>
In-Reply-To: <f4bc072f-9ec6-d57e-28de-e3f7aba21cd7@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Apr 2022 02:27:36 +0300
Message-ID: <CAA8EJpr54Wrjv9+7H97n9i+2zPX6qNH3Vqf-92CRtayhQexhYQ@mail.gmail.com>
Subject: Re: [PATCH v7] drm/msm/dp: stop event kernel thread when DP unbind
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Apr 2022 at 02:10, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 4/15/2022 3:48 PM, Dmitry Baryshkov wrote:
> > On Sat, 16 Apr 2022 at 01:34, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >> Current DP driver implementation, event thread is kept running
> >> after DP display is unbind. This patch fix this problem by disabling
> >> DP irq and stop event thread to exit gracefully at dp_display_unbind().
> >>
> >> Changes in v2:
> >> -- start event thread at dp_display_bind()
> >>
> >> Changes in v3:
> >> -- disable all HDP interrupts at unbind
> >> -- replace dp_hpd_event_setup() with dp_hpd_event_thread_start()
> >> -- replace dp_hpd_event_stop() with dp_hpd_event_thread_stop()
> >> -- move init_waitqueue_head(&dp->event_q) to probe()
> >> -- move spin_lock_init(&dp->event_lock) to probe()
> >>
> >> Changes in v4:
> >> -- relocate both dp_display_bind() and dp_display_unbind() to bottom of file
> >>
> >> Changes in v5:
> >> -- cancel relocation of both dp_display_bind() and dp_display_unbind()
> >>
> >> Changes in v6:
> >> -- move empty event q to dp_event_thread_start()
> >>
> >> Changes in v7:
> >> -- call ktheread_stop() directly instead of dp_hpd_event_thread_stop() function
> >>
> >> Fixes: e91e3065a806 ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> >> ---
> >>   drivers/gpu/drm/msm/dp/dp_display.c | 31 ++++++++++++++++++++++++-------
> >>   1 file changed, 24 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> >> index 01453db..680e500 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >> @@ -113,6 +113,7 @@ struct dp_display_private {
> >>          u32 hpd_state;
> >>          u32 event_pndx;
> >>          u32 event_gndx;
> >> +       struct task_struct *ev_tsk;
> >>          struct dp_event event_list[DP_EVENT_Q_MAX];
> >>          spinlock_t event_lock;
> >>
> >> @@ -230,6 +231,8 @@ void dp_display_signal_audio_complete(struct msm_dp *dp_display)
> >>          complete_all(&dp->audio_comp);
> >>   }
> >>
> >> +static int dp_hpd_event_thread_start(struct dp_display_private *dp_priv);
> >> +
> >>   static int dp_display_bind(struct device *dev, struct device *master,
> >>                             void *data)
> >>   {
> >> @@ -269,6 +272,7 @@ static int dp_display_bind(struct device *dev, struct device *master,
> >>          if (rc)
> >>                  DRM_ERROR("Audio registration Dp failed\n");
> > I think I asked it in v3 and didn't get an answer:
> > Isn't 'goto end' missing here?
> I did follow you suggestion at v3 and made changes at
> dp_hpd_event_thread_start()

I'm asking about this place. Should we return an immediate error if
audio registration has failed or not?

> >> +       rc = dp_hpd_event_thread_start(dp);
> > if (rc) { DRM_ERROR(....); goto end; }
> > return 0;
> >
> > Please.
> This is at dp_display_bind(),  "end" is the next statement why goto needed?

To be explicit that this is a fatal error. Compare this to my question
regarding the audio registration failure.

> >>   end:
> >>          return rc;
> >>   }
> >> @@ -280,6 +284,11 @@ static void dp_display_unbind(struct device *dev, struct device *master,
> >>          struct drm_device *drm = dev_get_drvdata(master);
> >>          struct msm_drm_private *priv = drm->dev_private;
> >>
> >> +       /* disable all HPD interrupts */
> >> +       dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, false);
> >> +
> >> +       kthread_stop(dp->ev_tsk);
> >> +
> >>          dp_power_client_deinit(dp->power);
> >>          dp_aux_unregister(dp->aux);
> >>          priv->dp[dp->id] = NULL;
> >> @@ -1054,7 +1063,7 @@ static int hpd_event_thread(void *data)
> >>
> >>          dp_priv = (struct dp_display_private *)data;
> >>
> >> -       while (1) {
> >> +       while (!kthread_should_stop()) {
> >>                  if (timeout_mode) {
> >>                          wait_event_timeout(dp_priv->event_q,
> >>                                  (dp_priv->event_pndx == dp_priv->event_gndx),
> >> @@ -1132,12 +1141,19 @@ static int hpd_event_thread(void *data)
> >>          return 0;
> >>   }
> >>
> >> -static void dp_hpd_event_setup(struct dp_display_private *dp_priv)
> >> +static int dp_hpd_event_thread_start(struct dp_display_private *dp_priv)
> >>   {
> >> -       init_waitqueue_head(&dp_priv->event_q);
> >> -       spin_lock_init(&dp_priv->event_lock);
> >> +       /* set event q to empty */
> >> +       dp_priv->event_gndx = 0;
> >> +       dp_priv->event_pndx = 0;
> >> +
> >> +       dp_priv->ev_tsk = kthread_run(hpd_event_thread, dp_priv, "dp_hpd_handler");
> >> +       if (IS_ERR(dp_priv->ev_tsk)) {
> >> +               DRM_ERROR("failed to create DP event thread\n");
> >> +               return PTR_ERR(dp_priv->ev_tsk);
> >> +       }
> >>
> >> -       kthread_run(hpd_event_thread, dp_priv, "dp_hpd_handler");
> >> +       return 0;
> >>   }
> >>
> >>   static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
> >> @@ -1266,7 +1282,10 @@ static int dp_display_probe(struct platform_device *pdev)
> >>                  return -EPROBE_DEFER;
> >>          }
> >>
> >> +       /* setup event q */
> >>          mutex_init(&dp->event_mutex);
> >> +       init_waitqueue_head(&dp->event_q);
> >> +       spin_lock_init(&dp->event_lock);
> >>
> >>          /* Store DP audio handle inside DP display */
> >>          dp->dp_display.dp_audio = dp->audio;
> >> @@ -1441,8 +1460,6 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display)
> >>
> >>          dp = container_of(dp_display, struct dp_display_private, dp_display);
> >>
> >> -       dp_hpd_event_setup(dp);
> >> -
> >>          dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
> >>   }
> >>
> >> --
> >> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> >> a Linux Foundation Collaborative Project
> >>
> >



-- 
With best wishes
Dmitry
