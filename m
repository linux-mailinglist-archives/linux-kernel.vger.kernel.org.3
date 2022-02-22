Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4834C03DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiBVV3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiBVV3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:29:44 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C4D4CA2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:29:17 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so19545362ooi.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+DdLQYhSVowvrvUvwIQHQ/jS7fQBlZEdC1qdY+ozB14=;
        b=Rsk1TlpY40oUYm8qLz6rSs4XgoVG1cDlLPSjZeqiErRUwqIsKAEgvWhgJYlUmS8r4j
         DjiVcbfh+svMwjhb3wL0JouOTW6bqgZa/kAhgPYAn6Dh9SYQGBWMXuycEGaHAY6+3gA8
         FOW3og2f8W0/duBSTidtHZlk49iwwwQQn5u2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+DdLQYhSVowvrvUvwIQHQ/jS7fQBlZEdC1qdY+ozB14=;
        b=4Yt8U1jBSWWWGMTnDayr/t6swAKDi3FWodUGNpFd1R7fLR4DY1lhJcNitYiCIwdUo9
         3xRhpn6DiEX1DZgU39jCNAsAcztT+HHFSolnREs7ui1oyMxvnFthwXoV6uOjTc5ZIFRx
         moWuwz8iS+J/jZP3wnXJax05MHwnl27JYMhSDdjX5zm76sNmYZ8tq4aRnioxMcXtWaXR
         VQL6ad88rvaiDHnF6sFZzbmi5QOCNnPk/Fg+XJmJEEnWzf0OwiorWYujjRRUVIS6q19s
         Z5MkWJS1MwBvLzFKKKF55zErObQhSmDjX0Z6GMkbCNTHrmPsZNcDHd42IuW11QR1zX2k
         hqMg==
X-Gm-Message-State: AOAM533YamscrUqjdZD+4hBrsJaggEdIFLoqG/9feBPt3Qnikml3bvqJ
        y+hVMbUslh7Mj/e/vrbGneRSD3IGXqrkArj3c3qhLw==
X-Google-Smtp-Source: ABdhPJwO0OjVyqoI0wHs16t1k/y/Gcj/QLmaofaVi0N6xYQGEKIvtIgjAOzkMZeCBU2B35BgAheofP2PYe1GQzcZFU0=
X-Received: by 2002:a05:6870:5829:b0:c8:9f42:f919 with SMTP id
 r41-20020a056870582900b000c89f42f919mr2755947oap.54.1645565356781; Tue, 22
 Feb 2022 13:29:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Feb 2022 21:29:16 +0000
MIME-Version: 1.0
In-Reply-To: <1645455086-9359-5-git-send-email-quic_vpolimer@quicinc.com>
References: <1645455086-9359-1-git-send-email-quic_vpolimer@quicinc.com> <1645455086-9359-5-git-send-email-quic_vpolimer@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Feb 2022 21:29:16 +0000
Message-ID: <CAE-0n523rt_ThJSr=NTrjb2ASpb_4nnwNo9bTw8fZcz-yH9opQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/msm/disp/dpu1: add PSR support for eDP
 interface in dpu driver
To:     Vinod Polimera <quic_vpolimer@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        krzysztof.kozlowski@canonical.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        robh+dt@kernel.org, sam@ravnborg.org, seanpaul@chromium.org,
        thierry.reding@gmail.com
Cc:     quic_kalyant@quicinc.com, quic_sbillaka@quicinc.com,
        quic_vproddut@quicinc.com
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

Quoting Vinod Polimera (2022-02-21 06:51:26)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index e7c9fe1..ba3240c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -951,6 +952,14 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>
>         DRM_DEBUG_KMS("crtc%d\n", crtc->base.id);
>
> +       if (old_crtc_state->self_refresh_active) {
> +               drm_for_each_encoder_mask(encoder, crtc->dev,
> +                                old_crtc_state->encoder_mask) {
> +                       dpu_encoder_assign_crtc(encoder, NULL);
> +               }
> +               return;
> +       }
> +
>         /* Disable/save vblank irq handling */
>         drm_crtc_vblank_off(crtc);
>
> @@ -962,7 +971,12 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>                  */
>                 if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
>                         release_bandwidth = true;
> -               dpu_encoder_assign_crtc(encoder, NULL);
> +               /* If disable is triggered during psr active(e.g: screen dim in PSR),

Multiline comments start with /* on a line by itself

		/*
		 * If disable is triggered ...

> +                * we will need encoder->crtc connection to process the device sleep &
> +                * preserve it during psr sequence.
> +                */
> +               if (!crtc->state->self_refresh_active)
> +                       dpu_encoder_assign_crtc(encoder, NULL);
>         }
>
>         /* wait for frame_event_done completion */
> @@ -1010,6 +1024,8 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>         struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
>         struct drm_encoder *encoder;
>         bool request_bandwidth = false;
> +       struct drm_crtc_state *old_crtc_state =
> +               drm_atomic_get_old_crtc_state(state, crtc);

Use two lines

	struct drm_crtc_state *old_crtc_state;

	old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);

>
>         pm_runtime_get_sync(crtc->dev->dev);
>
> @@ -1032,8 +1048,10 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>         trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
>         dpu_crtc->enabled = true;
>
> -       drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
> -               dpu_encoder_assign_crtc(encoder, crtc);
> +       if (!old_crtc_state->self_refresh_active) {
> +               drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
> +                       dpu_encoder_assign_crtc(encoder, crtc);

Make these two lines above into a function with a meaningful name?
dpu_encoder_assign_crtcs()? And then push the encoder mask iteration
into the loop by passing the mask as a function argument. I see
dpu_encoder_assign_crtc() takes a spinlock, so we could probably take
that lock out too and push it into this new function to avoid grabbing
and dropping the spinlock multiple times.

> +       }
>
>         /* Enable/restore vblank irq handling */
>         drm_crtc_vblank_on(crtc);
> @@ -1497,7 +1515,7 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
>  {
>         struct drm_crtc *crtc = NULL;
>         struct dpu_crtc *dpu_crtc = NULL;
> -       int i;
> +       int i, ret;
>
>         dpu_crtc = kzalloc(sizeof(*dpu_crtc), GFP_KERNEL);
>         if (!dpu_crtc)
> @@ -1534,6 +1552,11 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
>         /* initialize event handling */
>         spin_lock_init(&dpu_crtc->event_lock);
>
> +       ret = drm_self_refresh_helper_init(crtc);
> +       if (ret)
> +               DPU_ERROR("Failed to initialize %s with SR helpers %d\n",

What is SR? Write self-refresh?

> +                       crtc->name, ret);
> +
>         DRM_DEBUG_KMS("%s: successfully initialized crtc\n", dpu_crtc->name);
>         return crtc;
>  }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 6eac417..ba9d8ea 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -217,6 +217,14 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
>         15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
>  };
>
> +static inline bool is_self_refresh_active(struct drm_crtc_state *state)

const drm_crtc_state?

> +{
> +       if (state && state->self_refresh_active)
> +               return true;
> +
> +       return false;

	return state && state->self_refresh_active;

> +}
> +
>  static void _dpu_encoder_setup_dither(struct dpu_hw_pingpong *hw_pp, unsigned bpc)
>  {
>         struct dpu_hw_dither_cfg dither_cfg = { 0 };
> @@ -629,7 +637,8 @@ static int dpu_encoder_virt_atomic_check(
>                 if (drm_atomic_crtc_needs_modeset(crtc_state)) {
>                         dpu_rm_release(global_state, drm_enc);
>
> -                       if (!crtc_state->active_changed || crtc_state->active)
> +                       if (!crtc_state->active_changed || crtc_state->active ||
> +                                       crtc_state->self_refresh_active)
>                                 ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
>                                                 drm_enc, crtc_state, topology);
>                 }
> @@ -1182,11 +1191,30 @@ static void dpu_encoder_virt_disable(struct drm_encoder *drm_enc,
>  {
>         struct dpu_encoder_virt *dpu_enc = NULL;
>         struct msm_drm_private *priv;
> +       struct drm_crtc *crtc;
> +       struct drm_crtc_state *old_state;
>         int i = 0;
>
>         dpu_enc = to_dpu_encoder_virt(drm_enc);
>         DPU_DEBUG_ENC(dpu_enc, "\n");

Presumably this print wants a valid 'dpu_enc' pointer.

>
> +       if (!drm_enc) {

So this check for !drm_enc is impossible? Please remove it.

> +               DPU_ERROR("invalid encoder\n");
> +               return;
> +       }
> +       dpu_enc = to_dpu_encoder_virt(drm_enc);

We got it again?

> +
> +       crtc = dpu_enc->crtc;
> +
> +       old_state = drm_atomic_get_old_crtc_state(state, crtc);
> +
> +       /*
> +        * The encoder turn off already occurred when self refresh mode

s/turn off/disable/

> +        * was set earlier, in the old_state for the corresponding crtc.
> +        */
> +       if (drm_enc->encoder_type == DRM_MODE_ENCODER_TMDS && is_self_refresh_active(old_state))
> +               return;
> +
>         mutex_lock(&dpu_enc->enc_lock);
>         dpu_enc->enabled = false;
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 47fe11a..d550f90 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -495,7 +495,7 @@ static void dpu_kms_wait_for_commit_done(struct msm_kms *kms,
>                 return;
>         }
>
> -       if (!crtc->state->active) {
> +       if (!drm_atomic_crtc_effectively_active(crtc->state)) {
>                 DPU_DEBUG("[crtc:%d] not active\n", crtc->base.id);
>                 return;
>         }
> --
> 2.7.4
>
