Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434784DD25D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiCRBUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiCRBUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:20:30 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3309210285
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:19:12 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso8614513ooi.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+aYzTZ6WAo0uIN7qC1lsIM5UM8Nxh5c84eblIjBJ+PM=;
        b=bczh01O2CC33q/AG/o/43ApRFfd4e4j4VIYqbiyofSkyxVYoVTD72mbz+fAEyCLzHq
         m2lluHFRqW7J8jBQtlhr/uZLfMrDBfaCzvna1yDwP0na6W0Er4h5YktOVc/ZA0kUX4jb
         dZw33YXaHXP1fRAAMtYpG7BdH1AUcCMlm3F7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+aYzTZ6WAo0uIN7qC1lsIM5UM8Nxh5c84eblIjBJ+PM=;
        b=Ag9BdSHQB+v9EnV0Jla4KzcyhuEYzESSUTUICbw1Y4nOddeE0wq8GzeqJ6Oo2FsYrD
         XUhFxEdJ3BbqkMIzP8CMDrqqU2MQ0Stvn/KnJwJrJfgR4SJqBhn3v3Cdf4utOudKAtXL
         o0CL8XPj4G9IfTpxOT4uoVTFTSzdEcFCKQjtiixRh8l+B+SRXsLW5IA6alg71xFXUHGA
         9dNU8F4Y7vmgtHcX5eLQUYtBOxhsVOsSO5iFSOBwpiSNYrD6l11Vyj5oLFFFj+BNF6QI
         gxcl0UfQbuXU9Bib74jZlfZHRZfBdxgkINWNkta2sM6aKEbGnj2pUyzYC40OZCFm4ARU
         XBfQ==
X-Gm-Message-State: AOAM533/bBoTlLa+6JP8Kp7b4SBousH1dcqjAjBndAoBHEZqiaNdD9j9
        4pzyeE0B5ZsDag6gmu3q0FK1aCHsGOpuNERn8pYGcw==
X-Google-Smtp-Source: ABdhPJyev93lfQNXewX0cW1jpZhZZGFfBD8h+TbrQQYUluQ1UzvRN2/C0vA6X7mwIWKcUwX+Buif4Dm0wIsWNJtenrc=
X-Received: by 2002:a05:6870:b69c:b0:dd:b74b:4099 with SMTP id
 cy28-20020a056870b69c00b000ddb74b4099mr2384205oab.193.1647566352072; Thu, 17
 Mar 2022 18:19:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 21:19:11 -0400
MIME-Version: 1.0
In-Reply-To: <1647452154-16361-7-git-send-email-quic_sbillaka@quicinc.com>
References: <1647452154-16361-1-git-send-email-quic_sbillaka@quicinc.com> <1647452154-16361-7-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Mar 2022 21:19:11 -0400
Message-ID: <CAE-0n520pQKM7mFSE_00ER+F9RKUPrN+y4U8fmsxi7FoFMyOrA@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] drm/msm/dp: wait for hpd high before any sink interaction
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        dianders@chromium.org, quic_khsieh@quicinc.com, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, sam@ravnborg.org,
        dmitry.baryshkov@linaro.org, quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2022-03-16 10:35:51)
>         The source device should ensure the sink is ready before
> proceeding to read the sink capability or performing any aux transactions.
> The sink will indicate its readiness by asserting the HPD line.
>
>         The eDP sink requires power from the source and its HPD line will
> be asserted only after the panel is powered on. The panel power will be
> enabled from the panel-edp driver.
>
>         The controller driver needs to wait for the hpd line to be asserted
> by the sink.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c     |  6 ++++++
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_catalog.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_reg.h     |  7 ++++++-
>  4 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 6d36f63..2ddc303 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -337,6 +337,12 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>                 goto exit;
>         }
>
> +       ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog);

Why are we making aux transactions when hpd isn't asserted? Can we only
register the aux device once we know that state is "connected"? I'm
concerned that we're going to be possibly polling the connected bit up
to some amount of time (0x0003FFFF usecs?) for each aux transfer when
that doesn't make any sense to keep checking. We should be able to check
it once, register aux, and then when disconnect happens we can
unregister aux.

> +       if (ret) {
> +               DRM_DEBUG_DP("DP sink not ready for aux transactions\n");
> +               goto exit;
> +       }
> +
>         dp_aux_update_offset_and_segment(aux, msg);
>         dp_aux_transfer_helper(aux, msg, true);
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index fac815f..2c3b0f7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -242,6 +242,29 @@ void dp_catalog_aux_update_cfg(struct dp_catalog *dp_catalog)
>         phy_calibrate(phy);
>  }
>
> +int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog *dp_catalog)
> +{
> +       u32 state, hpd_en, timeout;
> +       struct dp_catalog_private *catalog = container_of(dp_catalog,
> +                               struct dp_catalog_private, dp_catalog);
> +
> +       hpd_en = dp_read_aux(catalog, REG_DP_DP_HPD_CTRL) &
> +                                       DP_DP_HPD_CTRL_HPD_EN;

Use two lines

	hpd_en = dp_read_aux();
	hpd_en &= DP_DP_HPD_CTRL_HPD_EN;

> +
> +       /* no-hpd case */
> +       if (!hpd_en)
> +               return 0;
> +
> +       /* Poll for HPD connected status */
> +       timeout = dp_read_aux(catalog, REG_DP_DP_HPD_EVENT_TIME_0) &
> +                                       DP_HPD_CONNECT_TIME_MASK;
> +
> +       return readl_poll_timeout(catalog->io->dp_controller.aux.base +
> +                               REG_DP_DP_HPD_INT_STATUS,
> +                               state, state & DP_DP_HPD_STATE_STATUS_CONNECTED,
> +                               2000, timeout);
> +}
> +
>  static void dump_regs(void __iomem *base, int len)
>  {
>         int i;
