Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76EA5848FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiG2AUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG2AUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:20:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271D18B24
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:20:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id va17so5907935ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tGjb0yv2qHz2eed9IZ1i5rTk8Eynn94CI4Wx2sUGweo=;
        b=W9UAjOx5uPpd1JmlPNKp+NtqaVYeLK4GU1GwKzuPItS0Z1ouoQaVMhWQsrgrYFQOp0
         aUa26Wr96X2xIdpAxHirM+flYD2rApHRg6w2J8IJPrwyPRbaLlUmbV9Ybol+YsHq94gB
         8CpnLiwr6jQWt/Q3/NbCJzjMzVDbbpAazFGn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tGjb0yv2qHz2eed9IZ1i5rTk8Eynn94CI4Wx2sUGweo=;
        b=hdhk5uKqr086VRBAtyJgDvxtL5/q/iLEG3i6t3GEG0775eDd0lyFCHQ3NleaE7mHsI
         0eExhXUJ5YUvQDBVK2tCVXvLookuhwmnoHZFRIBlSkuEDHXt7hzmC7vtmaz2973SpOCm
         p/crXV/ej43HyNEHw2z/A7n+ogtbeHwNpHMygNZu0EM7P7ylGn2NrMEyb9iCMaUk41Nx
         zfgNkMZlFfEhjIPCM3KCtojWq4YstXg3oFd91UXJuBDFgxCgJ065OQVNAMtEBHg/A5S4
         df6rE0jgdTe2e/S7ZI4VGkWOCUwBW80UutSWLjQrPuo+RiHMWltAS7OTokWW5cjKRh8V
         dJ+w==
X-Gm-Message-State: AJIora8KFdQLMM4yqDe89MdGoGbB1PxWoY+N4qeg52tLgNwSo0LdFXZy
        d3d1LC9ditx/vdRTig5XM74L0Fhx0ntOm8IW
X-Google-Smtp-Source: AGRyM1vd7yYUtpZm89N/PU/bqH7I3f6RMxfY9Ep6WLeRIQvtJvfs7D7bBXKb1yZmSXDQPEj/emyJww==
X-Received: by 2002:a17:907:2d86:b0:72b:4aee:7729 with SMTP id gt6-20020a1709072d8600b0072b4aee7729mr948693ejc.143.1659054019082;
        Thu, 28 Jul 2022 17:20:19 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090632d500b0072af102e65csm946471ejk.152.2022.07.28.17.20.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 17:20:18 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id l22so4162931wrz.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:20:18 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id
 n9-20020a5d5889000000b0021dbccd38e3mr698162wrf.659.1659054018014; Thu, 28 Jul
 2022 17:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <1657544224-10680-1-git-send-email-quic_vpolimer@quicinc.com> <1657544224-10680-5-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1657544224-10680-5-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 17:20:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UN2tFNL=T+eXE4j7bnp6zWgCN4Nz8Q=qgu7y67yRPpdA@mail.gmail.com>
Message-ID: <CAD=FV=UN2tFNL=T+eXE4j7bnp6zWgCN4Nz8Q=qgu7y67yRPpdA@mail.gmail.com>
Subject: Re: [PATCH v6 04/10] drm/msm/dp: Add basic PSR support for eDP
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
> @@ -359,6 +367,24 @@ void dp_catalog_ctrl_lane_mapping(struct dp_catalog *dp_catalog)
>                         ln_mapping);
>  }
>
> +void dp_catalog_ctrl_psr_mainlink_enable(struct dp_catalog *dp_catalog,
> +                                               bool enable)
> +{
> +       u32 val;
> +       struct dp_catalog_private *catalog = container_of(dp_catalog,
> +                               struct dp_catalog_private, dp_catalog);
> +
> +       val = dp_read_link(catalog, REG_DP_MAINLINK_CTRL);
> +       val &= ~DP_MAINLINK_CTRL_ENABLE;

nit: the line above is useless. Remove. In the case that you're
enabling you're just adding the bit back in. In the case that you're
disabling you're doing the exact same operation below.


> @@ -610,6 +636,47 @@ void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog)
>         dp_write_aux(catalog, REG_DP_DP_HPD_CTRL, DP_DP_HPD_CTRL_HPD_EN);
>  }
>
> +static void dp_catalog_enable_sdp(struct dp_catalog_private *catalog)
> +{
> +       /* trigger sdp */
> +       dp_write_link(catalog, MMSS_DP_SDP_CFG3, UPDATE_SDP);
> +       dp_write_link(catalog, MMSS_DP_SDP_CFG3, !UPDATE_SDP);

!UPDATE_SDP is a really counter-intuitive way to say 0x0.


> @@ -645,6 +712,20 @@ u32 dp_catalog_hpd_get_intr_status(struct dp_catalog *dp_catalog)
>         return isr & (mask | ~DP_DP_HPD_INT_MASK);
>  }
>
> +int dp_catalog_ctrl_read_psr_interrupt_status(struct dp_catalog *dp_catalog)

Why is the return type "int" and not "u32". It's a hardware register.
It's u32 here. The caller assigns it to a u32.


> +void dp_ctrl_set_psr(struct dp_ctrl *dp_ctrl, bool enter)
> +{
> +       struct dp_ctrl_private *ctrl = container_of(dp_ctrl,
> +                       struct dp_ctrl_private, dp_ctrl);
> +
> +       if (!ctrl->panel->psr_cap.version)
> +               return;
> +
> +       /*
> +        * When entering PSR,
> +        * 1. Send PSR enter SDP and wait for the PSR_UPDATE_INT
> +        * 2. Turn off video
> +        * 3. Disable the mainlink
> +        *
> +        * When exiting PSR,
> +        * 1. Enable the mainlink
> +        * 2. Send the PSR exit SDP
> +        */
> +       if (enter) {
> +               reinit_completion(&ctrl->psr_op_comp);
> +               dp_catalog_ctrl_set_psr(ctrl->catalog, true);
> +
> +               if (!wait_for_completion_timeout(&ctrl->psr_op_comp,
> +                       PSR_OPERATION_COMPLETION_TIMEOUT_JIFFIES)) {
> +                       DRM_ERROR("PSR_ENTRY timedout\n");
> +                       dp_catalog_ctrl_set_psr(ctrl->catalog, false);
> +                       return;
> +               }
> +
> +               dp_catalog_ctrl_state_ctrl(ctrl->catalog, 0);
> +
> +               dp_catalog_ctrl_psr_mainlink_enable(ctrl->catalog, false);
> +       } else {
> +               dp_catalog_ctrl_psr_mainlink_enable(ctrl->catalog, true);
> +
> +               dp_catalog_ctrl_set_psr(ctrl->catalog, false);

My PSR knowledge is not very strong, but I do remember a recent commit
from Brian Norris fly by for the Analogix controller. See commit
c4c6ef229593 ("drm/bridge: analogix_dp: Make PSR-exit block less").

In that commit it sounds as if we need to wait for _something_ (resync
I guess?) here and not just return instantly.


> @@ -388,6 +388,8 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
>
>         edid = dp->panel->edid;
>
> +       dp->dp_display.psr_supported = !!dp->panel->psr_cap.version;
> +

nit: remove the "!!". You're already storing this in a "bool" which
will handle this for you.


> +static const struct drm_bridge_funcs edp_bridge_ops = {
> +       .atomic_enable = edp_bridge_atomic_enable,
> +       .atomic_disable = edp_bridge_atomic_disable,
> +       .atomic_post_disable = edp_bridge_atomic_post_disable,
> +       .mode_set = dp_bridge_mode_set,
> +       .mode_valid = dp_bridge_mode_valid,
> +       .atomic_reset = drm_atomic_helper_bridge_reset,
> +       .atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +       .atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +       .atomic_check = edp_bridge_atomic_check,
> +};

nit: the location of your new functions is a little weird. You've got:

1. DP functions
2. eDP functions
3. eDP structure
4. DP structure

I'd expect:

1. DP functions
2. DP structure
3. eDP functions
4. eDP structure

-Doug
