Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1D4B8FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiBPRs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:48:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiBPRs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:48:56 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95959254A55
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:48:38 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id g24so2351080qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3/V1tqyyw2qN2BN/SlEqeGIYSiVydb4ENC5TIRKR/c=;
        b=ylLv/U6jeM1NwEfuKa+04x8d0W48Qzt2OhgVzz33y57HHA3tLlBlnCBlDEYTuB9Scz
         E8+Rsd5EmXQgDau+DgalgvZWZks6EMZujR3vjKjZlyqTO+gsSmrYGSZh2V6W15+Vu+jw
         BoCnkMiUAt23eQBNL/z3yERvU0ktxK+mSBLBTv4M3HyU0VOox9uyrxngjft53vWgQl+8
         c3JuZHpDR3FdecRsZ+Lms/T6AIMwIslpX7eQC8c9SuimwJrSHHBorrQ4HSxeTtFYwjLk
         9tCSRbxCxdEmTv6bjsbIGqNugs3MegfYklXf9yjDDIuIClhjKXwdJBB9HNPOsyyUgf+5
         Q0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3/V1tqyyw2qN2BN/SlEqeGIYSiVydb4ENC5TIRKR/c=;
        b=c2ZKRbTUE7sr8J1TMdE01hzGy+vuqYPiBVS5+bBp3XVjPIb9mZh2D72zC3BFBurCyu
         9YnGvMb1M5VWkAs5Slt0FSukCaOKhh0Pj3zCjWr+41rBQ8i58KTqfQiPbyJ1zb3yfguy
         rqd9uqo65FttFKAT3EhTuaifX7zify5HWRTIQB9jFECF2qbuVK3YN3aM9Dl2zwBMA0ze
         NDV3e1WqhvW+RQAVF7ecR48J7uNFRO/oxdxHlo1C59ZLFwV7Ghn/LNIfXBL84rrkNn1/
         sP23uUOIvoKThcvG8RJB80y/nCvksb4hAxNVLO0SeYw1a8Mnfc5yh1/D5Dbvc50FKJgG
         NODg==
X-Gm-Message-State: AOAM531nPGbTDvLBRQJF193JQV0oR6LXLu8vZKMRg6KIjBF8FZp7dn/2
        cifxYA5NHuYHni4U78mGf2uH6+3H6icU7Fo+FZCr1Q==
X-Google-Smtp-Source: ABdhPJy9pR0q8RXQZy3r5LdSUhTsfFWmWwkbMopxN56obW7iT7DUuONLCCbb/LFn49oyME45PuYrZeAnuQQAs8GJqzk=
X-Received: by 2002:a37:9146:0:b0:507:d59c:6059 with SMTP id
 t67-20020a379146000000b00507d59c6059mr1866395qkd.593.1645033717619; Wed, 16
 Feb 2022 09:48:37 -0800 (PST)
MIME-Version: 1.0
References: <1645032840-17178-1-git-send-email-quic_khsieh@quicinc.com> <1645032840-17178-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1645032840-17178-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 16 Feb 2022 20:48:26 +0300
Message-ID: <CAA8EJprnUuO2yd4FcPtmfcMwAmZqR3GyFJ+Cz-KV8E4O6c8R6w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] drm/msm/dpu: revise timing engine programming to
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 20:34, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
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
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 10 ++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |  2 +
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   | 14 +++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 63 ++++++++++++++++------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  2 +
>  5 files changed, 76 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 1e648db..2b2dbb7 100644
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
> index e241914..0d73550 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -168,4 +168,6 @@ int dpu_encoder_get_linecount(struct drm_encoder *drm_enc);
>   */
>  int dpu_encoder_get_vsync_count(struct drm_encoder *drm_enc);
>
> +bool dpu_encoder_is_widebus_enabled(struct drm_encoder *drm_enc);
> +
>  #endif /* __DPU_ENCODER_H__ */
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index ddd9d89..04ac2dc 100644
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
> index 116e2b5..303bd03 100644
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
> @@ -60,6 +61,14 @@
>
>  #define   INTF_MUX                      0x25C
>
> +#define INTF_CFG_ACTIVE_H_EN   BIT(29)
> +#define INTF_CFG_ACTIVE_V_EN   BIT(30)
> +
> +#define INTF_CFG2_DATABUS_WIDEN        BIT(0)
> +#define INTF_CFG2_DATA_HCTL_EN BIT(4)
> +#define INTF_CFG2_DCE_DATA_COMPRESS    BIT(12)
> +
> +
>  static const struct dpu_intf_cfg *_intf_offset(enum dpu_intf intf,
>                 const struct dpu_mdss_cfg *m,
>                 void __iomem *addr,
> @@ -90,15 +99,23 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
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
> @@ -112,7 +129,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>         hsync_start_x = p->h_back_porch + p->hsync_pulse_width;
>         hsync_end_x = hsync_period - p->h_front_porch - 1;
>
> -       if (p->width != p->xres) {
> +       if (p->width != p->xres) { /* border fill added */
>                 active_h_start = hsync_start_x;
>                 active_h_end = active_h_start + p->xres - 1;
>         } else {
> @@ -120,7 +137,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>                 active_h_end = 0;
>         }
>
> -       if (p->height != p->yres) {
> +       if (p->height != p->yres) { /* border fill added */
>                 active_v_start = display_v_start;
>                 active_v_end = active_v_start + (p->yres * hsync_period) - 1;
>         } else {
> @@ -130,27 +147,47 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>
>         if (active_h_end) {
>                 active_hctl = (active_h_end << 16) | active_h_start;
> -               intf_cfg |= BIT(29);    /* ACTIVE_H_ENABLE */
> +               intf_cfg |= INTF_CFG_ACTIVE_H_EN;
>         } else {
>                 active_hctl = 0;
>         }
>
>         if (active_v_end)
> -               intf_cfg |= BIT(30); /* ACTIVE_V_ENABLE */
> +               intf_cfg |= INTF_CFG_ACTIVE_V_EN;

Quoting v4:
Such changes can go to a separate patch. You don't have to squash
everything in a single patch. Quite the opposite. If each of the
patches is atomic, it's easier to review and accept them.

>
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
> +               intf_cfg2 |=  (INTF_CFG2_DATABUS_WIDEN | INTF_CFG2_DATA_HCTL_EN);
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

Quoting a question to v4:
So, this changes the display_v_end. Is there a mistake currently (and
so this change should be backported to stable kernels) or is it just
unoptimal?

> +
>                 active_h_start = hsync_start_x;
>                 active_h_end = active_h_start + p->xres - 1;
>                 active_v_start = display_v_start;
>                 active_v_end = active_v_start + (p->yres * hsync_period) - 1;
>
> -               display_v_start += p->hsync_pulse_width + p->h_back_porch;
> -
>                 active_hctl = (active_h_end << 16) | active_h_start;
>                 display_hctl = active_hctl;
> +
> +               intf_cfg |= INTF_CFG_ACTIVE_H_EN;
> +               intf_cfg |= INTF_CFG_ACTIVE_V_EN;
>         }
>
>         den_polarity = 0;
> @@ -180,13 +217,6 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>                                 (COLOR_8BIT << 4) |
>                                 (0x21 << 8));
>
> -       if (ctx->cap->features & BIT(DPU_DATA_HCTL_EN)) {

Quoting a quesiton to v4:
So, we are enabling it uncoditionally even for older platforms, which
do not support this bit/register. I'm not a fan of writing to
registers which are not supported by the hardware.

Another:
If you insist on always programming these registers, the
DPU_DATA_HCTL_EN becomes useless and should be removed from the
dpu_hw_catalog. As usual, in a separate patch.

> -               intf_cfg2 |= BIT(4);
> -               display_data_hctl = display_hctl;
> -               DPU_REG_WRITE(c, INTF_CONFIG2, intf_cfg2);
> -               DPU_REG_WRITE(c, INTF_DISPLAY_DATA_HCTL, display_data_hctl);
> -       }
> -
>         DPU_REG_WRITE(c, INTF_HSYNC_CTL, hsync_ctl);
>         DPU_REG_WRITE(c, INTF_VSYNC_PERIOD_F0, vsync_period * hsync_period);
>         DPU_REG_WRITE(c, INTF_VSYNC_PULSE_WIDTH_F0,
> @@ -204,6 +234,9 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>         DPU_REG_WRITE(c, INTF_FRAME_LINE_COUNT_EN, 0x3);
>         DPU_REG_WRITE(c, INTF_CONFIG, intf_cfg);
>         DPU_REG_WRITE(c, INTF_PANEL_FORMAT, panel_format);
> +       DPU_REG_WRITE(c, INTF_CONFIG2, intf_cfg2);
> +       DPU_REG_WRITE(c, INTF_DISPLAY_DATA_HCTL, display_data_hctl);
> +       DPU_REG_WRITE(c, INTF_ACTIVE_DATA_HCTL, active_data_hctl);
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
