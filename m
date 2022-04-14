Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EB750198A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbiDNRGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbiDNRFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:05:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F63BBED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:47:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bj36so901517ljb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/81+PkkPmPe/TTQwrTB+sxyYxn9iTbpRvnVkvTg+pC8=;
        b=B9wDWH42g9YW9AI0Nss9bPg2ke9AcgJPM27MaTf5FcLd2cYA8sez9IWCsZ1KH5qcqa
         Lu+dH/ZYnrkVAhHHkskGQMRfl28OXKQ8/hvdgxC+Gd1N0dqNrZq14l0edVEEzLsBFvGP
         IU9Ox5r96ULPR95h7HSZz6dMttqUaACHn8hkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/81+PkkPmPe/TTQwrTB+sxyYxn9iTbpRvnVkvTg+pC8=;
        b=QauKxiT80RS7ILj63nyTWD/7Zj0lrcW7FJDDeXys2maKwI2QN93/4fECsAqQMokxB7
         0wXE1hCjFJRnjrB2PxGQ5jJVbnjSSVDO4TQ8qEcpy6ddlyDAquRuLUozbJusRolHi4HV
         r2wwb1ukS0FIDBUZQgNqYtwbGSNLzU84692FABmm30bP/NH6RzjggMCkZApmBgth4S+1
         d0fiTYoMbjo9jOITdgqHl4GUH8nj/g0GOw7DOcvicnJnlgRujC6pWhAsKbkETqQGdrhv
         qyCx88LjZUBmmHAIGJAboPGNHfr3g1ZfEh+q0r3BEF5ECEvx1NnT2JEfjJ+OuZww8w4e
         LQmQ==
X-Gm-Message-State: AOAM530WttkQa1UesKNegDHYYx21XIDGQLdQerkKUFJEzXQefuYO43Mi
        iepFJlDY3AYtWGlZuTuAfMne5Zabx2BUyoEds+s=
X-Google-Smtp-Source: ABdhPJyX1/xgcmXdpzdtsJVtk74bhwzcSa9bR4LUVKHXX+QxGuPvS89nbK7a5YenSZnPZ3z8jrTYwg==
X-Received: by 2002:a05:651c:1a0e:b0:24c:83e3:14f3 with SMTP id by14-20020a05651c1a0e00b0024c83e314f3mr2070810ljb.376.1649954837606;
        Thu, 14 Apr 2022 09:47:17 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id n9-20020a196f49000000b0046bbeb8c242sm46751lfk.171.2022.04.14.09.47.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 09:47:17 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 17so6801420lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:47:17 -0700 (PDT)
X-Received: by 2002:a05:6000:1c15:b0:207:849a:648b with SMTP id
 ba21-20020a0560001c1500b00207849a648bmr2610564wrb.513.1649954370738; Thu, 14
 Apr 2022 09:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <1649938766-6768-1-git-send-email-quic_sbillaka@quicinc.com> <1649938766-6768-2-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1649938766-6768-2-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Apr 2022 09:39:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wmiv2WGhFCLYmXbWESNOh5FfobjNme85aU6YtN1SLVDA@mail.gmail.com>
Message-ID: <CAD=FV=Wmiv2WGhFCLYmXbWESNOh5FfobjNme85aU6YtN1SLVDA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] drm/msm/dp: Add eDP support via aux_bus
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>
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

Hi,

On Thu, Apr 14, 2022 at 5:20 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> @@ -1530,6 +1532,60 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
>         }
>  }
>
> +static int dp_display_get_next_bridge(struct msm_dp *dp)
> +{
> +       int rc;
> +       struct dp_display_private *dp_priv;
> +       struct device_node *aux_bus;
> +       struct device *dev;
> +
> +       dp_priv = container_of(dp, struct dp_display_private, dp_display);
> +       dev = &dp_priv->pdev->dev;
> +       aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
> +
> +       if (aux_bus && dp->is_edp) {
> +               dp_display_host_init(dp_priv);
> +               dp_catalog_ctrl_hpd_config(dp_priv->catalog);
> +               dp_display_host_phy_init(dp_priv);
> +               enable_irq(dp_priv->irq);
> +
> +               rc = devm_of_dp_aux_populate_ep_devices(dp_priv->aux);
> +               of_node_put(aux_bus);
> +               if (rc) {
> +                       disable_irq(dp_priv->irq);
> +                       dp_display_host_phy_exit(dp_priv);
> +                       dp_display_host_deinit(dp_priv);
> +                       return rc;
> +               }
> +       } else if (dp->is_edp) {
> +               DRM_ERROR("eDP aux_bus not found\n");
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * External bridges are mandatory for eDP interfaces: one has to
> +        * provide at least an eDP panel (which gets wrapped into panel-bridge).
> +        *
> +        * For DisplayPort interfaces external bridges are optional, so
> +        * silently ignore an error if one is not present (-ENODEV).
> +        */
> +       rc = dp_parser_find_next_bridge(dp_priv->parser);

This gets into the same problem that Dmitry pointed out that ps8640
has that's addressed by my recent series [1].  Namely it's not
guaranteed that the panel will have finished probing by the time
devm_of_dp_aux_populate_ep_devices() finishes probing. I don't think
it's going to be really solvable without the bigger rewrite that we've
been discussing, though. ...it's probably OK to land something like
what you have here, but it might at least deserve a comment in the
code?

[1] https://lore.kernel.org/r/20220409023628.2104952-1-dianders@chromium.org


> +       if (rc == -ENODEV) {
> +               if (dp->is_edp) {
> +                       DRM_ERROR("eDP: next bridge is not present\n");
> +                       return rc;
> +               }
> +       } else if (rc) {
> +               if (rc != -EPROBE_DEFER)
> +                       DRM_ERROR("DP: error parsing next bridge: %d\n", rc);
> +               return rc;

In both of your two error returns here isn't it a problem that you don't do:

  disable_irq(dp_priv->irq);
  dp_display_host_phy_exit(dp_priv);
  dp_display_host_deinit(dp_priv);

Should probably at least fix that clear error before landing, unless
I'm misunderstanding and there's some reason not to do that?


As discussed previously, I'm not convinced that we've covered every
corner case for properly doing and undoing the above things. I'm
hoping that once we do the cleanup and move to pm_runtime() management
that it will be cleaned up?


> @@ -114,10 +114,12 @@ struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *
>         bridge->funcs = &dp_bridge_ops;
>         bridge->type = dp_display->connector_type;
>
> -       bridge->ops =
> -               DRM_BRIDGE_OP_DETECT |
> -               DRM_BRIDGE_OP_HPD |
> -               DRM_BRIDGE_OP_MODES;
> +       if (!dp_display->is_edp) {
> +               bridge->ops =
> +                       DRM_BRIDGE_OP_DETECT |
> +                       DRM_BRIDGE_OP_HPD |
> +                       DRM_BRIDGE_OP_MODES;

Given that Dmitry had questions about why eDP has different ops in his
previous review of this code, the above probably deserves an inline
code comment. If you want to use my wording, you could paste this into
your code:

  /*
   * Many ops only make sense for DP. Why?
   * - Detect/HPD are used by DRM to know if a display is _physically_
   *   there, not whether the display is powered on / finished initting.
   *   On eDP we assume the display is always there because you can't
   *   know until power is applied. If we don't implement the ops DRM will
   *   assume our display is always there.
   * - Currently eDP mode reading is driven by the panel driver. This
   *   allows the panel driver to properly power itself on to read the
   *   modes.
   */


Overall: as discussed, I think that the current implementation is a
bit fragile and might have some wrong corner cases since it's hard for
me to reason about exactly when we init/de-init things. Even if it
works great, the fact that it's hard to reason about isn't wonderful.
That being said, I honestly believe that would benefit upstream to get
this landed and iterate on it. I don't think this should be causing
any existing behavior to be _worse_ and getting it landed upstream
will keep more people focused on the same codebase.


-Doug
