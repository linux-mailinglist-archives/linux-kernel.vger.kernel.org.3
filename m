Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C654C03AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiBVVUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbiBVVUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:20:18 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925E124C10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:19:51 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso19498833ooi.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PZXGdH7QOkFGdyZL9vslSSuJH2T6cBvsFBVFd42Xdko=;
        b=RwQ1qfHBX5YIxEy+KPyWxkJlAkJ/VTS081sLpYhZ0tAeKOngBOgBWhMOaTMHHoekQ5
         seKF/z0Zlz2Lmun8lOKI8aBPHiQZHtZ9LDVAQTPhoRLdCa/L+35K1WP4BjQa1fRMMs0l
         CQ8EwktT9W/rqR0ixUMXRnp8SEpUEob+vtQLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PZXGdH7QOkFGdyZL9vslSSuJH2T6cBvsFBVFd42Xdko=;
        b=aiNi3z0e5x2MH2htMoy3fZ6+d5Ip9uhc8tYZiPJqhCRrbO87KBN7Sycucog9B9QLe8
         pDc0upa7sgPJ/o/8G5/Bbve7boK7TXtoRFxu/WKI/qBsEMIHkDH5r1Cqlf65Kt2RwG4F
         nrNAOXtzFpe+7H4yYxvOkUID3lU0L5qPtzvOmR0WMVL/Su+veDqM6MfSoC+QQfJY9eu6
         oBatyv4YyOL7FFbt1LTLCyMRRYIWKT2wnrBBdhYjoZqfdyWUIbe8tHwDyNMGBGq7FXsW
         W3KFASsyYMonASy1P0cMF+EboPFQMkNZlSY5JOtz/po+Gm2mQSsUg6eVy7ZESlK5XwRk
         DzLg==
X-Gm-Message-State: AOAM532ruZkScswTwqyFYxBxjq4OZi7hK+YkhzLdoLKS0H3/mSF5pWZh
        s9nOK4K0U+exeVaIQ3zUbXTKnQ0ohR3Serq5qpD/7g==
X-Google-Smtp-Source: ABdhPJy7r6Dp6z5t3lrBYpzhD+7i1xvLB2uoHm7Qkx145lEhXBxvO1W68wKoliw01/Yq59Ok3PUuUtXn3CmG57UGp7U=
X-Received: by 2002:a05:6870:5829:b0:c8:9f42:f919 with SMTP id
 r41-20020a056870582900b000c89f42f919mr2737701oap.54.1645564791160; Tue, 22
 Feb 2022 13:19:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Feb 2022 21:19:50 +0000
MIME-Version: 1.0
In-Reply-To: <1645455086-9359-3-git-send-email-quic_vpolimer@quicinc.com>
References: <1645455086-9359-1-git-send-email-quic_vpolimer@quicinc.com> <1645455086-9359-3-git-send-email-quic_vpolimer@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Feb 2022 21:19:50 +0000
Message-ID: <CAE-0n53a5akPXSJjkD4SvnparcxBpN2LaGt_7J=6petTPukHeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/bridge: use atomic enable/disable for bridge callbacks
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

Quoting Vinod Polimera (2022-02-21 06:51:24)
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index b32295a..5c7dc82 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -102,30 +136,82 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
>                 drm_connector_cleanup(connector);
>  }
>
> -static void panel_bridge_pre_enable(struct drm_bridge *bridge)
> +static void panel_bridge_pre_enable(struct drm_bridge *bridge,
> +               struct drm_bridge_state *old_bridge_state)
>  {
>         struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> +       struct drm_atomic_state *old_state = old_bridge_state->base.state;
> +       struct drm_encoder *encoder = bridge->encoder;
> +       struct drm_crtc *crtc;
> +       struct drm_crtc_state *old_crtc_state;
> +
> +       crtc = bridge_drm_get_new_connector_crtc(encoder, old_state);
> +       if (!crtc)
> +               return;
> +
> +       old_crtc_state = drm_atomic_get_old_crtc_state(old_state, crtc);
> +       if (old_crtc_state && old_crtc_state->self_refresh_active)

Can you please add some comment about why self_refresh_active means we
should bail out from this function? Such a comment would be helpful to
understand the code quickly vs. having to figure out what the intention
of the logic is. The analogix driver has

/* Don't touch the panel if we're coming back from PSR */

so even mentioning PSR here would be helpful.
