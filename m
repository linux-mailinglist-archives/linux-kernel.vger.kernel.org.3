Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D434BC51A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 03:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbiBSCyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 21:54:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiBSCyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 21:54:04 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F15369CB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:53:45 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso2902224ooc.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=f5vEdCUlfGdIQtRWRsGoWXSeUt1R4/WNoy8oLgpJuys=;
        b=RidN6xLUFjRyZ+Ah0PNlUoPWg+enFvbTkoryQfuJAcs7GwdFLzNPUOAWNzeSKxDTcB
         yAWeU8y/LwBZAUwmeAgHYWPF6WQdpsc/NJWl9Q3AvI+eFoUmYxJpzSfJCZ8MFgH+4PiS
         r2yW2IQyoUOYpa32jKeQl9xpvZ7jGQ+CfC/Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=f5vEdCUlfGdIQtRWRsGoWXSeUt1R4/WNoy8oLgpJuys=;
        b=2K/wDitsZNGT37sqHHU8dmuT87i1ee6zEwMQ6e3iMG37tqDfYkn1edHz4Jl26W+xZt
         O+/lMbV93P0w9l9ugDtSw6QUPZkdT0ZCWkCaMMlps/9NJZQBEFRc8ButmbYavLSvx4l6
         KoBDmw+cZh9hskA6GZMA3OS2fxTmOo9S82fN0ECz4IIH4FPcfm//yOo+XZLTv18POT+P
         +CtlNemS24Kang6U9G5npCMNh8deXv3R2Ka19Iykf9X0ZT5MGtia4v5xZjY3KYVtjqZd
         C3pkn0vsQG8zZvAVzyIllGMgFM3KS94VbuW+pMTjU8mdCMs9Uip24OxTqgQumLuK6AHU
         9Xdg==
X-Gm-Message-State: AOAM532UX4PRMEUNIi6FJId2FKcRB+lxom3vLLwyQcUNhZLOlKAqWXiG
        yXs/+AbEYjjNbilErTPFId6vyRIQkGvNs7r5zItJuw==
X-Google-Smtp-Source: ABdhPJyBlc86HejjCoLhE/76E81JC3NnHA3Yc+WN4totHtXcpBMqvJ+K7mcqSTwlvteOVgopTott8oar138D5sbwF0U=
X-Received: by 2002:a05:6870:631a:b0:d1:7d97:806 with SMTP id
 s26-20020a056870631a00b000d17d970806mr3847366oao.8.1645239224666; Fri, 18 Feb
 2022 18:53:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Feb 2022 18:53:44 -0800
MIME-Version: 1.0
In-Reply-To: <1645133788-5057-4-git-send-email-quic_khsieh@quicinc.com>
References: <1645133788-5057-1-git-send-email-quic_khsieh@quicinc.com> <1645133788-5057-4-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Feb 2022 18:53:44 -0800
Message-ID: <CAE-0n51Rewcp7uefTBJ2HwJN7gp-aTxrWe71XQ-RKosqw8uq8Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] drm/msm/dpu: revise timing engine programming to
 support widebus feature
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-02-17 13:36:27)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 0d315b4..0c22839 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -217,6 +219,14 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
>         15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
>  };
>
> +
> +bool dpu_encoder_is_widebus_enabled(struct drm_encoder *drm_enc)

const?

> +{
> +       struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);

const?

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

const drm_enc?

> +
>  #endif /* __DPU_ENCODER_H__ */
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index c2cd185..4e4fa56 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
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

Drop useless parenthesis please.

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

Is this code movement intentional?

> +
>                 active_h_start = hsync_start_x;
>                 active_h_end = active_h_start + p->xres - 1;
>                 active_v_start = display_v_start;

display_v_start is different now.

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

		  intf_cfg |= INTF_CFG_ACTIVE_H_EN | INTF_CFG_ACTIVE_V_EN;

would be one less line.
