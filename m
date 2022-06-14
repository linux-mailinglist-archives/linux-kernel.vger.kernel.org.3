Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2575354BD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358534AbiFNV7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358527AbiFNV7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:59:19 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D4527E0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:59:08 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bd16so5233564oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=5yJj86hSPwBzwhbQhqdV1Hn3ZaFbVir/hOB/SXTT3bI=;
        b=ZdGEZsOt+TRm+aYxq42AYd4MLTcEpKed0OVtU15Eb9mKcEjoxGxefcc8Hou/DOFmCp
         ki0mc220xUAOCHMnS/OCVj7tuFFIQ/OhnyOzgqy38WOee9k8w1eGsxVOtxPZOic5yyPU
         8l81rocDbnMve9NNM0Jcnj6qmGymABDBeO0dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=5yJj86hSPwBzwhbQhqdV1Hn3ZaFbVir/hOB/SXTT3bI=;
        b=ILOpbbApBom9RP60SaqlhGhsoMbJNFQSoUp9yTAuGYWc5McIF+F2Oia7Qdq32lBo+K
         A86urXW5doX3DrRZrP0sFUTmTRQcewiCdM9gWdNSFu54xccChmOvVyGj+mhRYWTucNHs
         LxArIIgtcUdDDC82U3apxcDtydbatTkxaaCqX830qzFsoNbIWwXc1R07hj2AdOt/ibd3
         4RhlIiAzlYY0ozNNPfMNdNS3jnRU+FdT7drXdqv3/7Mv8ExBM4L9Cbd7ncf51qmIbf95
         z2U7TYnwff7mkGQld3qPsSm1ve5UFfTjaCcYCMk81KIYSSSclvjeUtWrYwHZo1eP+lXB
         I+Ng==
X-Gm-Message-State: AOAM532o01dROqfgqg4wc+EV5JiHOqswDw48g0nAk0b/bkViZIWLUx+T
        ZoVVxiWoat+/xXW4ysrj943U3w/4c22ecKWPn/dJxg==
X-Google-Smtp-Source: ABdhPJxDYah7bUTWBiwxr/l4NWNy6VphDHyLT3XGi+NAYbfMAhtii820vbsYtQ0n/RqMQE67M2fjkNbG1wG1z9Wq3cE=
X-Received: by 2002:a05:6808:1703:b0:32e:851e:7f81 with SMTP id
 bc3-20020a056808170300b0032e851e7f81mr3333511oib.63.1655243947436; Tue, 14
 Jun 2022 14:59:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jun 2022 14:59:06 -0700
MIME-Version: 1.0
In-Reply-To: <1655240702-12230-1-git-send-email-quic_khsieh@quicinc.com>
References: <1655240702-12230-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 14 Jun 2022 14:59:06 -0700
Message-ID: <CAE-0n52EAyTcQd6CiwXT1T658C-b+2r14BK_3-tf-ZiJdzqaAw@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/dp: force link training for display resolution change
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-06-14 14:05:02)
> Display resolution change is implemented through drm modeset. Older
> modeset (resolution) has to be disabled first before newer modeset
> (resolution) can be enabled. Display disable will turn off both
> pixel clock and main link clock so that main link have to be
> re-trained during display enable to have new video stream flow
> again. At current implementation, display enable function manually
> kicks up irq_hpd_handle which will read panel link status and start
> link training if link status is not in sync state.
>
> However, there is rare case that a particular panel links status keep
> staying in sync for some period of time after main link had been shut
> down previously at display disabled. In this case, main link retraining
> will not be executed by irq_hdp_handle(). Hence video stream of newer
> display resolution will fail to be transmitted to panel due to main
> link is not in sync between host and panel.
>
> This patch will bypass irq_hpd_hanle() in favor of directly call

s/hanle/handle/

> dp_ctrl_on_stream() to always perform link training in regardless of
> main link status. So that no unexpected exception resolution change
> failure cases will happen. Also this implementation are more efficient
> than manual kicking off irq_hpd_handle function.
>
> Changes in v2:
> -- set force_link_train flag on DP only (is_edp == false)
>
> Changes in v3:
> -- revise commit  text
> -- add Fixes tag
>
> Changes in v4:
> -- revise commit  text
>
> Changes in v5:
> -- fix spelling at commit text
>
> Changes in v6:
> -- split dp_ctrl_on_stream() for phy test case
> -- revise commit text for modeset
>
> Fixes: 62671d2ef24b ("drm/msm/dp: fixes wrong connection state caused by failure of link train")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 31 +++++++++++++++++++++++--------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.c | 13 ++++++-------
>  3 files changed, 31 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index af7a80c..cb9c7af 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1807,7 +1807,27 @@ static int dp_ctrl_link_retrain(struct dp_ctrl_private *ctrl)
>         return dp_ctrl_setup_main_link(ctrl, &training_step);
>  }
>
> -int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
> +int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
> +{
> +       int ret = 0;

Drop assignment please.

> +       struct dp_ctrl_private *ctrl;
> +
> +       ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> +
> +       ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
> +
> +       ret = dp_ctrl_enable_stream_clocks(ctrl);
> +       if (ret) {
> +               DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> +               return ret;
> +       }
> +
> +       dp_ctrl_send_phy_test_pattern(ctrl);

None of this code needs to be run in the normal display on case?

> +
> +       return 0;
> +}
> +
> +int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
>  {
>         int ret = 0;
>         bool mainlink_ready = false;
> @@ -1843,12 +1863,7 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>                 goto end;
>         }
>
> -       if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {
> -               dp_ctrl_send_phy_test_pattern(ctrl);
> -               return 0;
> -       }
> -
> -       if (!dp_ctrl_channel_eq_ok(ctrl))
> +       if (force_link_train || !dp_ctrl_channel_eq_ok(ctrl))
>                 dp_ctrl_link_retrain(ctrl);
>
>         /* stop txing train pattern to end link training */
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c388323..b6d25ab 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1688,10 +1689,12 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>
>         state =  dp_display->hpd_state;
>
> -       if (state == ST_DISPLAY_OFF)
> +       if (state == ST_DISPLAY_OFF) {
>                 dp_display_host_phy_init(dp_display);
> +               force_link_train = true;
> +       }
>
> -       dp_display_enable(dp_display, 0);
> +       dp_display_enable(dp_display, force_link_train);

Do we need to pass it from here? Why can't dp_display_enable() simply
check for 'state == ST_DISPLAY_OFF' and then force retrain the link?
