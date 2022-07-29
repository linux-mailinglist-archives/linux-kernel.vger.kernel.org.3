Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237155848F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiG2ASa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG2AS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:18:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D778200
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:18:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bp15so5783606ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o9Qlz38dt4Pm7UqIGc26yx76w2m2409/U8B2FImofJI=;
        b=Z/qA05wUv45cjgiTkkEsLFsOLVvS74jX49Pi+dafJVf9QFL1AXDBE+Fa6t0VX5sn7d
         T90z2o94rEC2Givhz3yrcuCFjuIS1OU94Hk2IJ3TIVZTHUz6FmOMqcqosPuzeFXE6eEz
         1HyqTz/fE9h79uoQq5YBbiWekMUdv5SUyrcfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o9Qlz38dt4Pm7UqIGc26yx76w2m2409/U8B2FImofJI=;
        b=LDMm4NqUSY2oXC5nC4tGll5e+vuR4Sh6TNh0qaWkE40knN6YtkcLAZtbx4S7phJTeF
         +NjTYYs7/LPcYHRcdRjSttww1okdnT8+8vWemkThgTOqTZHcpNGlYQe2bEvWm+WjM/Ym
         vT5ID0fQVHapuarMKCWZe0Mliv+pmjGwc5tHAqN/AWcxDmuzcMYGtKtCtrHkw6sXZxzQ
         4kUwuyqrka2K+zg9tKpl1345FPRThyC8Il0xjQHN583ink1ASKlpMP2GCznVnDmXjcAn
         EdBzX7EOIdKaUwRgIoIw/x8OgUvSq7knCMBLltd8vBGqs2nlDJ1RZMvbE0zfDSZpQhHz
         0QUw==
X-Gm-Message-State: AJIora+rusHRnLZ+DPiR2NMZnMXwZVtWtG+czUGr9hPEYZWA+QRi5arn
        cKuSBeVUPzD76oG3U7MRJjKIdW7/Bn+IfLvF
X-Google-Smtp-Source: AGRyM1sWjuO6iX9/U2GF3Raps0XNGyFHKMWHkmZvqIuO/EMjseloKJd7BHFLpGLVerMP0NQ5OucMuw==
X-Received: by 2002:a17:906:8454:b0:730:254f:cdcb with SMTP id e20-20020a170906845400b00730254fcdcbmr624457ejy.142.1659053903073;
        Thu, 28 Jul 2022 17:18:23 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402078400b00435651c4a01sm1517938edy.56.2022.07.28.17.18.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 17:18:22 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id i8so4146723wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:18:20 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr737214wrr.617.1659053899738; Thu, 28
 Jul 2022 17:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <1657544224-10680-1-git-send-email-quic_vpolimer@quicinc.com> <1657544224-10680-2-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1657544224-10680-2-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 17:18:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WW1BxjW9B9Vg99UOeTBePE32J++O24unnddecXXcaZ+Q@mail.gmail.com>
Message-ID: <CAD=FV=WW1BxjW9B9Vg99UOeTBePE32J++O24unnddecXXcaZ+Q@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] drm/msm/disp/dpu: clear dpu_assign_crtc and get
 crtc from connector state instead of dpu_enc
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 5:57 AM Vinod Polimera
<quic_vpolimer@quicinc.com> wrote:
>
> Update crtc retrieval from dpu_enc to dpu_enc connector state,
> since new links get set as part of the dpu enc virt mode set.
> The dpu_enc->crtc cache is no more needed, hence cleaning it as
> part of this change.

I don't know this driver terribly well, but _why_ is it no longer
needed? According to the kernel-doc for the "crtc" variable you're
removing it was because we used to need it after the disable()
callback. Maybe that's no longer the case after commit a796ba2cb3dd
("drm/msm: dpu: Separate crtc assignment from vblank enable")?


> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 ----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 30 ++++++++++++++---------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  8 --------
>  3 files changed, 14 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index b56f777..f91e3d1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -972,7 +972,6 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>                  */
>                 if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
>                         release_bandwidth = true;
> -               dpu_encoder_assign_crtc(encoder, NULL);
>         }
>
>         /* wait for frame_event_done completion */
> @@ -1042,9 +1041,6 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>         trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
>         dpu_crtc->enabled = true;
>
> -       drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
> -               dpu_encoder_assign_crtc(encoder, crtc);
> -
>         /* Enable/restore vblank irq handling */
>         drm_crtc_vblank_on(crtc);
>  }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 52516eb..0fddc9d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -181,7 +181,6 @@ struct dpu_encoder_virt {
>
>         bool intfs_swapped;
>
> -       struct drm_crtc *crtc;

This structure is documented by kernel-doc. That means you need to
remove the documentation for "crtc".


>         struct drm_connector *connector;
>
>         struct dentry *debugfs_root;
> @@ -1245,6 +1244,7 @@ static void dpu_encoder_vblank_callback(struct drm_encoder *drm_enc,
>                 struct dpu_encoder_phys *phy_enc)
>  {
>         struct dpu_encoder_virt *dpu_enc = NULL;
> +       struct drm_crtc *crtc;
>         unsigned long lock_flags;
>
>         if (!drm_enc || !phy_enc)
> @@ -1253,9 +1253,14 @@ static void dpu_encoder_vblank_callback(struct drm_encoder *drm_enc,
>         DPU_ATRACE_BEGIN("encoder_vblank_callback");
>         dpu_enc = to_dpu_encoder_virt(drm_enc);
>
> +       if (!dpu_enc->connector || !dpu_enc->connector->state)
> +               return;

FWIW: your patch doesn't apply cleanly to msm-next. It conflicts with
commit c28d76d360f9 ("drm/msm/dpu: Increment vsync_cnt before waking
up userspace").

I suspect that you'll want your changes to come _after_ the increment
(AKA you want to increment even if the connector is NULL), but dunno
for sure.


> +
> +       crtc = dpu_enc->connector->state->crtc;
> +
>         spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
> -       if (dpu_enc->crtc)
> -               dpu_crtc_vblank_callback(dpu_enc->crtc);
> +       if (crtc)
> +               dpu_crtc_vblank_callback(crtc);

Effectively you are checking for NULLness at 3 levels:

1. dpu_enc->connector
2. dpu_enc->connector->state
3. dpu_enc->connector->state->crtc

You check two of those things outside of the spinlock and one of those
things inside the spinlock. Why? Should they all be inside the
spinlock, or can they all be outside of the spinlock, or is there some
reason it is the way it is?


>  void dpu_encoder_toggle_vblank_for_crtc(struct drm_encoder *drm_enc,
>                                         struct drm_crtc *crtc, bool enable)
>  {
>         struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
> +       struct drm_crtc *new_crtc;
>         unsigned long lock_flags;
>         int i;
>
>         trace_dpu_enc_vblank_cb(DRMID(drm_enc), enable);
>
> +       if (!dpu_enc->connector || !dpu_enc->connector->state)
> +               return;
> +
> +       new_crtc = dpu_enc->connector->state->crtc;
>         spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
> -       if (dpu_enc->crtc != crtc) {
> +       if (!new_crtc || new_crtc != crtc) {
>                 spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);

Even if there was some reason for your choice of where you did the
spinlock in the previous case, I'm 95% sure that this one is absurd.
You're locking a spinlock around a test of local variables? I'm pretty
sure nobody else could be messing with your local variables...


-Doug
