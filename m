Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6944BAC06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbiBQVps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:45:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343724AbiBQVpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:45:45 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37367F47F0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:45:30 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id e22so10965139qvf.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WV8Qt1Z4OiXTx+NeaiZSwAmJ4f/Xh3LzwCOHclNaMo=;
        b=p/cMOP840GSH689+mVTiHBIwXkM+CRPh5pX+gI3Xgh70MSxIdseKRltjAEcZ0HUdki
         TGCUKztD3SdtfR7AScRrgLhK+8/pwQO/DNgMc7J+K0Fcd1DM+bukBCGFXZ17kFaQxv7L
         wCO12yeT+2gCksh4pIls8/NAnKOglsXSbtWTwYiX+ZZH7lH+KCTaEB8Ae+HhP2mxXHD+
         +NFZ0uS7ZIxpYRUxn7MOf0jK5TMaZ2rzN1Fb2gYnOaumsKAnPfosK4/PWLTaj8OCg0BZ
         B2O7z8nT1Mhjc+Q7qWheTi6ocdiaagQY94seW42kY91C+DlljWt+WfjXj5J7vEaWPpuk
         4i9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WV8Qt1Z4OiXTx+NeaiZSwAmJ4f/Xh3LzwCOHclNaMo=;
        b=o4eDuQJn0uyO3DKFjUAtIcCR3sK0RMez0GgenNgQo2os/C6yOUcTvIhXCXkNSBIZmZ
         f7WO824J+vhne24rF8crsCS3q2wltY2Q5D4EaHb92wDFmFnX6Cq4KRWAGz5yNtXNxpiV
         zGNopwXZ84pnfmciJzfiXvTLUN2jxuhcT8grYYUquVIEdlXnF8x7Af9a2XgkJ4eDRDZN
         q1f9HgDOMpChT4vlZVhuURyIrzVg3vesvDCSSKGDoIXRLfC2u0yQOfTZ+3jFmNZFap8a
         IcV2pjXZ7tzlk59i78o0w1uP302l1sLGILZfuGpgYO1O+g60BWprQqSfATQ3oumpFlKS
         KBDg==
X-Gm-Message-State: AOAM532xfZ95ISbJESl3cZq/nkbZd9g6XVk41hmj0oDYK+dzZsLhNTg2
        bZw84KgBwa+rcMpNeaJYK6scz4XYlmJiYXEwz7je3w==
X-Google-Smtp-Source: ABdhPJy+nrsifImm7i7xJtHk4Zqn+QiqKOJn1cmvwXTRoLiwJINA6NPsYS76xWtrsAfTBHNQi5N91XTsHG2hJIdwzjI=
X-Received: by 2002:ac8:58cb:0:b0:2d2:966f:34fe with SMTP id
 u11-20020ac858cb000000b002d2966f34femr4082921qta.295.1645134329047; Thu, 17
 Feb 2022 13:45:29 -0800 (PST)
MIME-Version: 1.0
References: <1645133788-5057-1-git-send-email-quic_khsieh@quicinc.com> <1645133788-5057-4-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1645133788-5057-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 18 Feb 2022 00:45:18 +0300
Message-ID: <CAA8EJpqXQj_Qe_2mDf5XTZY5inWPApgrAHj3PhSB-+FSxD3R8w@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] drm/msm/dpu: revise timing engine programming to
 support widebus feature
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        bjorn.andersson@linaro.org, quic_abhinavk@quicinc.com,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
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

On Fri, 18 Feb 2022 at 00:36, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Widebus feature will transmit two pixel data per pixel clock to interface.
> Timing engine provides driving force for this purpose. This patch base
> on HPG (Hardware Programming Guide) to revise timing engine register
> setting to accommodate both widebus and non widebus application. Also
> horizontal width parameters need to be reduced by half since two pixel
> data are clocked out per pixel clock when widebus feature enabled.
>
> Widebus can be enabled individually at DP. However at DSI, widebus have
> to be enabled along with DSC to achieve pixel clock rate be scaled down
> with same ratio as compression ratio when 10 bits per source component.
> Therefore this patch add no supports of DSI related widebus and compression.
>
> Changes in v2:
> -- remove compression related code from timing
> -- remove op_info from  struct msm_drm_private
> -- remove unnecessary wide_bus_en variables
> -- pass wide_bus_en into timing configuration by struct msm_dp
>
> Changes in v3:
> -- split patch into 3 patches
>
> Changes in v4:
> -- rework timing engine to not interfere with dsi/hdmi
> -- cover both widebus and compression
>
> Changes in v5:
> -- remove supports of DSI widebus and compression
>
> Changes in v7:
> -- split this patch into 3 patches
> -- add Tested-by
>
> Changes in v8:
> -- move new registers writes under DATA_HCTL_EN features check.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 10 ++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |  2 +
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   | 14 ++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 54 ++++++++++++++++------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  2 +
>  5 files changed, 68 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 0d315b4..0c22839 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -208,6 +208,8 @@ struct dpu_encoder_virt {
>
>         u32 idle_timeout;
>
> +       bool wide_bus_en;
> +
>         struct msm_dp *dp;
>  };
>
> @@ -217,6 +219,14 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
>         15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
>  };
>
> +
> +bool dpu_encoder_is_widebus_enabled(struct drm_encoder *drm_enc)
> +{
> +       struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
> +
> +       return dpu_enc->wide_bus_en;
> +}
> +
>  static void _dpu_encoder_setup_dither(struct dpu_hw_pingpong *hw_pp, unsigned bpc)
>  {
>         struct dpu_hw_dither_cfg dither_cfg = { 0 };
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 99a5d73..893d74d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -168,4 +168,6 @@ int dpu_encoder_get_linecount(struct drm_encoder *drm_enc);
>   */
>  int dpu_encoder_get_frame_count(struct drm_encoder *drm_enc);
>
> +bool dpu_encoder_is_widebus_enabled(struct drm_encoder *drm_enc);
> +
>  #endif /* __DPU_ENCODER_H__ */
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index 185379b..2af2bb7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -110,6 +110,20 @@ static void drm_mode_to_intf_timing_params(
>                 timing->v_back_porch += timing->v_front_porch;
>                 timing->v_front_porch = 0;
>         }
> +
> +       timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
> +
> +       /*
> +        * for DP, divide the horizonal parameters by 2 when
> +        * widebus is enabled
> +        */
> +       if (phys_enc->hw_intf->cap->type == INTF_DP && timing->wide_bus_en) {
> +               timing->width = timing->width >> 1;
> +               timing->xres = timing->xres >> 1;
> +               timing->h_back_porch = timing->h_back_porch >> 1;
> +               timing->h_front_porch = timing->h_front_porch >> 1;
> +               timing->hsync_pulse_width = timing->hsync_pulse_width >> 1;
> +       }
>  }
>
>  static u32 get_horizontal_total(const struct intf_timing_params *timing)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index c2cd185..4e4fa56 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -33,6 +33,7 @@
>  #define INTF_TP_COLOR1                  0x05C
>  #define INTF_CONFIG2                    0x060
>  #define INTF_DISPLAY_DATA_HCTL          0x064
> +#define INTF_ACTIVE_DATA_HCTL           0x068
>  #define INTF_FRAME_LINE_COUNT_EN        0x0A8
>  #define INTF_FRAME_COUNT                0x0AC
>  #define   INTF_LINE_COUNT               0x0B0
> @@ -96,15 +97,23 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>         u32 hsync_period, vsync_period;
>         u32 display_v_start, display_v_end;
>         u32 hsync_start_x, hsync_end_x;
> +       u32 hsync_data_start_x, hsync_data_end_x;
>         u32 active_h_start, active_h_end;
>         u32 active_v_start, active_v_end;
>         u32 active_hctl, display_hctl, hsync_ctl;
>         u32 polarity_ctl, den_polarity, hsync_polarity, vsync_polarity;
>         u32 panel_format;
> -       u32 intf_cfg, intf_cfg2 = 0, display_data_hctl = 0;
> +       u32 intf_cfg, intf_cfg2 = 0;
> +       u32 display_data_hctl = 0, active_data_hctl = 0;
> +       u32 data_width;
> +       bool dp_intf = false;
>
>         /* read interface_cfg */
>         intf_cfg = DPU_REG_READ(c, INTF_CONFIG);
> +
> +       if (ctx->cap->type == INTF_EDP || ctx->cap->type == INTF_DP)
> +               dp_intf = true;
> +
>         hsync_period = p->hsync_pulse_width + p->h_back_porch + p->width +
>         p->h_front_porch;
>         vsync_period = p->vsync_pulse_width + p->v_back_porch + p->height +
> @@ -118,7 +127,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>         hsync_start_x = p->h_back_porch + p->hsync_pulse_width;
>         hsync_end_x = hsync_period - p->h_front_porch - 1;
>
> -       if (p->width != p->xres) {
> +       if (p->width != p->xres) { /* border fill added */
>                 active_h_start = hsync_start_x;
>                 active_h_end = active_h_start + p->xres - 1;
>         } else {
> @@ -126,7 +135,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>                 active_h_end = 0;
>         }
>
> -       if (p->height != p->yres) {
> +       if (p->height != p->yres) { /* border fill added */
>                 active_v_start = display_v_start;
>                 active_v_end = active_v_start + (p->yres * hsync_period) - 1;
>         } else {
> @@ -147,17 +156,36 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>         hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
>         display_hctl = (hsync_end_x << 16) | hsync_start_x;
>
> -       if (ctx->cap->type == INTF_EDP || ctx->cap->type == INTF_DP) {
> +       /*
> +        * DATA_HCTL_EN controls data timing which can be different from
> +        * video timing. It is recommended to enable it for all cases, except
> +        * if compression is enabled in 1 pixel per clock mode
> +        */
> +       if (p->wide_bus_en)
> +               intf_cfg2 |= (INTF_CFG2_DATABUS_WIDEN | INTF_CFG2_DATA_HCTL_EN);
> +
> +       data_width = p->width;
> +
> +       hsync_data_start_x = hsync_start_x;
> +       hsync_data_end_x =  hsync_start_x + data_width - 1;
> +
> +       display_data_hctl = (hsync_data_end_x << 16) | hsync_data_start_x;
> +
> +       if (dp_intf) {
> +               /* DP timing adjustment */
> +               display_v_start += p->hsync_pulse_width + p->h_back_porch;
> +               display_v_end   -= p->h_front_porch;
> +
>                 active_h_start = hsync_start_x;
>                 active_h_end = active_h_start + p->xres - 1;
>                 active_v_start = display_v_start;
>                 active_v_end = active_v_start + (p->yres * hsync_period) - 1;
>
> -               display_v_start += p->hsync_pulse_width + p->h_back_porch;
> -               display_v_end   -= p->h_front_porch;
> -
>                 active_hctl = (active_h_end << 16) | active_h_start;
>                 display_hctl = active_hctl;
> +
> +               intf_cfg |= INTF_CFG_ACTIVE_H_EN;
> +               intf_cfg |= INTF_CFG_ACTIVE_V_EN;
>         }
>
>         den_polarity = 0;
> @@ -187,13 +215,6 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>                                 (COLOR_8BIT << 4) |
>                                 (0x21 << 8));
>
> -       if (ctx->cap->features & BIT(DPU_DATA_HCTL_EN)) {
> -               intf_cfg2 |= INTF_CFG2_DATA_HCTL_EN;
> -               display_data_hctl = display_hctl;
> -               DPU_REG_WRITE(c, INTF_CONFIG2, intf_cfg2);
> -               DPU_REG_WRITE(c, INTF_DISPLAY_DATA_HCTL, display_data_hctl);
> -       }
> -
>         DPU_REG_WRITE(c, INTF_HSYNC_CTL, hsync_ctl);
>         DPU_REG_WRITE(c, INTF_VSYNC_PERIOD_F0, vsync_period * hsync_period);
>         DPU_REG_WRITE(c, INTF_VSYNC_PULSE_WIDTH_F0,
> @@ -211,6 +232,11 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>         DPU_REG_WRITE(c, INTF_FRAME_LINE_COUNT_EN, 0x3);
>         DPU_REG_WRITE(c, INTF_CONFIG, intf_cfg);
>         DPU_REG_WRITE(c, INTF_PANEL_FORMAT, panel_format);
> +       if (ctx->cap->features & BIT(DPU_DATA_HCTL_EN)) {
> +               DPU_REG_WRITE(c, INTF_CONFIG2, intf_cfg2);
> +               DPU_REG_WRITE(c, INTF_DISPLAY_DATA_HCTL, display_data_hctl);
> +               DPU_REG_WRITE(c, INTF_ACTIVE_DATA_HCTL, active_data_hctl);
> +       }
>  }
>
>  static void dpu_hw_intf_enable_timing_engine(
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index 3568be8..e4a518a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> @@ -30,6 +30,8 @@ struct intf_timing_params {
>         u32 border_clr;
>         u32 underflow_clr;
>         u32 hsync_skew;
> +
> +       bool wide_bus_en;
>  };
>
>  struct intf_prog_fetch {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
