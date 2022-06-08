Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB14543E44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiFHVJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiFHVJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:09:31 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECBD22BE59
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:09:29 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2e0a41009so28813770fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=uhJJ7vGk8+Id10EIAj/9LMT1XbZWpMVxVhaQKdTBSfI=;
        b=V020tV+I/mDPHoYM1HEFkw22NgeFtDVa6EthaBqZoe+LpxeJCsQ8cSsZ2s4++JFQq3
         SJEv7RTD3tYo2Av+75eI5RN4f54ceE0ALuZzobRmNLAlLJ7IhBWlSsOi+h/ARFzyNS45
         Mgt1wgcm/9Q57wlH4EIX5rwi4ivD+8FPlSin8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=uhJJ7vGk8+Id10EIAj/9LMT1XbZWpMVxVhaQKdTBSfI=;
        b=gLFFOEMrXwV29dWD6W6HOnYrr4gvvvVhpaBREW6ci+La2x4Xg7ptx+CcM5O5jw7BEb
         JdNwGuDhOWFMdNLhuQxDODeHd08HJ1x328RsI0t00pxl4FhlxxTkK30z08sdzmotg1F3
         TMTdLcbUxdt8asP8m+KjhFRJql0L1xXkZE+CwiAvq28CfGgsCeV6WPwg3Y0WnRW+ChwY
         FuEyjy0iKT4klkNClvWWZcLot0C1s7D2LKtZ4slhIZJB6d0pHt6bECsb61/PK5egWWez
         uQ1KPY6Jt2+zWRGMK4VssbTVE57s4o6PKKmDG58hmlQCWujDXPIRgkXOCPzEBCdEJlnT
         Rx2g==
X-Gm-Message-State: AOAM532GzwMDQ4jweSoiqjGugWsByY6ZaIjCtSg6JkaqDEjfrFaDrDOi
        Z8/JKYCvWNTlDVsTIooKUQ2+dVvhW7ePd/DfA3/6TQ==
X-Google-Smtp-Source: ABdhPJzmx5Jd5m5hQL9PhU8wNcpObqIaY2q01hyfKAhi3HtRM5VXK73tcALRVlIHY0kXpNrHVdt1VibRfTVZboooaCo=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr1782835oap.63.1654722568598; Wed, 08 Jun
 2022 14:09:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 14:09:28 -0700
MIME-Version: 1.0
In-Reply-To: <20220608094816.2898692-2-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org> <20220608094816.2898692-2-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 14:09:28 -0700
Message-ID: <CAE-0n51CMu3LxSewwxN64LwbMoARq54TPdpODpz-Bp5uUi_QZg@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm/panel: Add an API to allow drm to set
 orientation from panel
To:     Douglas Anderson <dianders@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2022-06-08 02:48:09)
> index 1c48d162c77e..859165a1c8f1 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2389,6 +2393,34 @@ int drm_connector_set_panel_orientation_with_quirk(
>  }
>  EXPORT_SYMBOL(drm_connector_set_panel_orientation_with_quirk);
>
> +/**
> + * drm_connector_set_orientation_from_panel -
> + *     set the connector's panel_orientation from panel's callback.
> + * @connector: connector for which to init the panel-orientation property.
> + * @panel: panel that can provide orientation information.
> + *
> + * Drm drivers should call this function before drm_dev_register().
> + * Orientation is obtained from panel's .get_orientation() callback.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_set_orientation_from_panel(
> +       struct drm_connector *connector,
> +       struct drm_panel *panel)
> +{
> +       enum drm_panel_orientation panel_orientation;

s/panel_orientation/orientation/

> +
> +       if (panel && panel->funcs && panel->funcs->get_orientation)
> +               panel_orientation = panel->funcs->get_orientation(panel);
> +       else
> +               panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +
> +       return drm_connector_set_panel_orientation(connector,
> +                                                  panel_orientation);

Then this fits on one line:

	return drm_connector_set_panel_orientation(connector, orientation);

> +}
> +EXPORT_SYMBOL(drm_connector_set_orientation_from_panel);
> +

Otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
