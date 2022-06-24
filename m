Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD55455A4F4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiFXXly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiFXXls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:41:48 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560F18AC20
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:41:47 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id t16so6855563qvh.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0P6eQAm8yfbzGQOwbFOIP8sRyPpctTkgP3jLRNGa25g=;
        b=Hkv0SMFjsq6iqjyvogfBVeGzcKQJFhXGWKDHqeQ8TXbEP4f9U5WnCV+XvNnxNFVDcU
         /c0nfyFdyxhdLP1R1L90HSH1xglpr5+vQHG8KuDT4JnsHM+TtGdB4RUx5MitinRRuyn9
         4ohFAZAEl5dpcDH4mQY959YF+SFT44xm/lCvma+KV2XLG+Z7EuSk5qTQBQlXkDVPk1yE
         o5YjzzRJyvyYwPJhV2n2vIC+ew5q6mmUbvSEsycehwO7Y8yhchCbGlXGDdNusL7CbA7U
         iQIz9VZmxBKDQRwR4EJhjd7b3MGtcGdDO2JpB6ElmrJPgwNJGUPIKjmDIgmSfg/tYq0N
         eXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0P6eQAm8yfbzGQOwbFOIP8sRyPpctTkgP3jLRNGa25g=;
        b=01j7sa74Q7WDEOgv+ky+b5LKMMwpWFSxfOPkJ2jQKGLIfTtBL2L4Q/wQ8LRJjyD3FE
         EHa7DxqjNYmdK+Sq5n3KrNpjLqX9851frUD2wXoXaXVymbdRzl+/Z7oyByzdJIx/Z0WS
         x5M+O0ooLTZvI7RqKSjLfO9HD8KmBBB9zm8sHLVLBPx6khaFRIDC9vcHKYcw05yawwi6
         iLBvCBZgGUL+pQP0KEyHirra+XxP6x+FgW3pN9w2AG67gKpBToR+JaiMNqLDkJvOtpFC
         KZKJkY551ClU9mVbf9d01B6F0bNfma296POm3jtpZ4UU1QApqh/HK2ufhXNqD3SGTDCe
         VMew==
X-Gm-Message-State: AJIora9fQNVMEHKj9j1c44NYu4h7MfOmRxMl3qFQLivRnSx84siJpGw+
        L5qgkMXOdgiy2gY1xMMfVS8LzNLrzk5qkaTrP3+/3A==
X-Google-Smtp-Source: AGRyM1vIglVtJt/Bk+NfkHI9IxCiD2EvLAJs/nbFNBpSC5OtT3KgUzbGGMH4eYyOqKu5mAR7rSSM0JvayilwIHFzS58=
X-Received: by 2002:ad4:596d:0:b0:470:7f34:fa13 with SMTP id
 eq13-20020ad4596d000000b004707f34fa13mr1362927qvb.55.1656114106473; Fri, 24
 Jun 2022 16:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com> <1656090912-18074-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1656090912-18074-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Jun 2022 02:41:35 +0300
Message-ID: <CAA8EJpozw5r657SaohnFzNzg59sO41+Q2qJkcjxDmCNCPnVe0w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/msm/dp: move struc of msm_display_info to msm_drv.h
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 24 Jun 2022 at 20:15, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> With current implementation, communication between interface driver and
> upper mdss encoder layer are implemented through function calls. This
> increase code complexity. Since struct msm_display_info contains msm
> generic display information, it can be expended to contains more useful
> information, such as widebus and dcs, in future to serve as communication
> channel purpose between interface driver and upper mdss encoder layer so
> that existing function calls can be eliminated.
> This patch more struct msm_display_info to msm_drv.h to be visible by
> whole msm scope.

NAK.

The msm_display_info contains information used by (and useful to) DPU
only, it is not 'msm generic' info. For this reason it has been moved
from msm_drv.h to dpu_encoder.h inIn commit b7420739f112 ("drm/msm:
move struct msm_display_info to dpu driver") . Neither mdp5 nor mdp4
are going to use this structure.

At some point I thought too that we might be able to create a set of
data and functions to describe encoder backends (dsi, hdmi, dp). This
has failed for me. After musing over the msm_drv.h part containing
functions published by the backends, I could not end up with a set of
them being good enough. The only common part seems to be the
modeset_init, snapshot and (once DP gets the DSC interface)
get_dsc_config. The rest is backend-specific.

I would suggest returning to this topic if/once DSI gets wide bus
support or DP starts using bonded interfaces. Before that I don't
foresee that common data structure would simplify things rather than
complicating them.

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h | 20 --------------------
>  drivers/gpu/drm/msm/msm_drv.h               | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 781d41c..6b604c5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -19,26 +19,6 @@
>  #define IDLE_TIMEOUT   (66 - 16/2)
>
>  /**
> - * struct msm_display_info - defines display properties
> - * @intf_type:          DRM_MODE_ENCODER_ type
> - * @capabilities:       Bitmask of display flags
> - * @num_of_h_tiles:     Number of horizontal tiles in case of split interface
> - * @h_tile_instance:    Controller instance used per tile. Number of elements is
> - *                      based on num_of_h_tiles
> - * @is_te_using_watchdog_timer:  Boolean to indicate watchdog TE is
> - *                              used instead of panel TE in cmd mode panels
> - * @dsc:               DSC configuration data for DSC-enabled displays
> - */
> -struct msm_display_info {
> -       int intf_type;
> -       uint32_t capabilities;
> -       uint32_t num_of_h_tiles;
> -       uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
> -       bool is_te_using_watchdog_timer;
> -       struct msm_display_dsc_config *dsc;
> -};
> -
> -/**
>   * dpu_encoder_assign_crtc - Link the encoder to the crtc it's assigned to
>   * @encoder:   encoder pointer
>   * @crtc:      crtc pointer
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index fdbaad5..f9c263b 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -106,11 +106,30 @@ struct msm_drm_thread {
>         struct kthread_worker *worker;
>  };
>
> +<<<<<<< HEAD

Not to mention that this patch is broken per se.

>  /* DSC config */
>  struct msm_display_dsc_config {
>         struct drm_dsc_config *drm;
>  };
>
> +/**
> + * struct msm_display_info - defines display properties
> + * @intf_type:          DRM_MODE_ENCODER_ type
> + * @capabilities:       Bitmask of display flags
> + * @num_of_h_tiles:     Number of horizontal tiles in case of split interface
> + * @h_tile_instance:    Controller instance used per tile. Number of elements is
> + *                      based on num_of_h_tiles
> + * @is_te_using_watchdog_timer:  Boolean to indicate watchdog TE is
> + *                              used instead of panel TE in cmd mode panels
> + */
> +struct msm_display_info {
> +       int intf_type;
> +       uint32_t capabilities;
> +       uint32_t num_of_h_tiles;
> +       uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
> +       bool is_te_using_watchdog_timer;
> +};
> +
>  struct msm_drm_private {
>
>         struct drm_device *dev;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
--
With best wishes
Dmitry
