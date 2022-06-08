Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E43543250
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbiFHORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiFHORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:17:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EAB46140
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:17:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v1so31082532ejg.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ti6IeHQCkW2VZvsUlMpmfFeGTqLu7AoUIKp3i+tZpfU=;
        b=iNJSJJdZJoaqK2qzj3sUCTe0mKNihcp3o9hP2pFFod/rUsNYwQ/w/do3amq6b5sAq+
         dol1KCe5NlSkaIKIsCKaF5yh7Nhkczu+8d4VRNEik1NsTIo9BN8nXbYwGnnw/83+hR8P
         /3EbeWILvG+CLjIYq1VN0UPXcf77NKvjVgVHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ti6IeHQCkW2VZvsUlMpmfFeGTqLu7AoUIKp3i+tZpfU=;
        b=23vf/vQtgGfcRzu9ZAnTT462nn7ppdu9P6+H5r4qQAwNu7uiqBiXrvL+9bAfutmtva
         7VO4yH8D4raLcawBepQayu0hu2Y3dZPuZp5HWKpPMF4O57f1IxZrOj1tIeyhmyl/A8WW
         RtPmTggfUqcQtsHs1JiUtOWNaZAbgUZ30eVimdnDdF0Mo5FLh4xACxAgC/4wkvYZ1nPe
         +6Ra5O9IgviFZu288ZQ8y/47RKqnjQFuHOw52iqN1ol9D6ys7UeGi2m3PfIr1IXk/qJA
         CEo4B3wU5d/Ebs5f00GWFDEswMbVIaKaYWfg0/VfEcXHWSDgDhorlS9GcWXR+6roYWCO
         MN/Q==
X-Gm-Message-State: AOAM530SPYJM0WF8GqBeoscfNT3zdgUWu8NeJeof1Z1Np/qg9jf19Lqy
        +KpcrQH06dj7LUyxpQtEoHND0BRg8fA0La+PRDc=
X-Google-Smtp-Source: ABdhPJweP3ORXD2gHVj1W7jkUCNilLrwSgre2GfHqRkrIGeg58davc5Hc5qWC0EkiEQxSoqvOrYs+w==
X-Received: by 2002:a17:907:2ce2:b0:6ff:30e2:25c3 with SMTP id hz2-20020a1709072ce200b006ff30e225c3mr31338024ejc.494.1654697827071;
        Wed, 08 Jun 2022 07:17:07 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906068400b00706242d297fsm9210703ejb.212.2022.06.08.07.17.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 07:17:05 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso11158850wmn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:17:05 -0700 (PDT)
X-Received: by 2002:a05:600c:591:b0:39c:4544:b814 with SMTP id
 o17-20020a05600c059100b0039c4544b814mr24306287wmd.118.1654697824712; Wed, 08
 Jun 2022 07:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220608094816.2898692-1-hsinyi@chromium.org> <20220608094816.2898692-9-hsinyi@chromium.org>
In-Reply-To: <20220608094816.2898692-9-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jun 2022 07:16:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VShXpy+6ESXGKhw5Z9o3hfXNV2_HvdOAPM3YN2qSA9Sg@mail.gmail.com>
Message-ID: <CAD=FV=VShXpy+6ESXGKhw5Z9o3hfXNV2_HvdOAPM3YN2qSA9Sg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] drm: Config orientation property if panel provides it
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi,

On Wed, Jun 8, 2022 at 2:48 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> @@ -269,6 +280,31 @@ void drm_panel_bridge_remove(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_panel_bridge_remove);
>
> +/**
> + * drm_panel_bridge_set_orientation - Set the connector's panel orientation
> + * if the bridge is a panel bridge.
> + *
> + * @connector: The connector to be set panel orientation.
> + * @bridge: The drm_bridge to be transformed to panel bridge.

Ideally you should have a kernel doc to describe what you're returning.


> + */
> +int drm_panel_bridge_set_orientation(struct drm_connector *connector,
> +                                    struct drm_bridge *bridge)
> +{
> +       struct panel_bridge *panel_bridge;
> +
> +       if (!bridge)
> +               return 0;
> +
> +       if (bridge->funcs != &panel_bridge_bridge_funcs)
> +               return 0;

nit: Why do you need to handle NULL bridge and the case that someone
calls you with something other than a panel-bridge? I'm not convinced
that's useful. In general kernel style doesn't do massive validation
of parameters unless there's a reason for it. ...if we do need to
handle them then it feels like they should be returning -EINVAL or
something, not 0.


> @@ -917,10 +917,13 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
>                            enum drm_connector_status status);
>
>  #ifdef CONFIG_DRM_PANEL_BRIDGE
> +bool drm_bridge_is_panel(const struct drm_bridge *bridge);
>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
>  struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
>                                               u32 connector_type);
>  void drm_panel_bridge_remove(struct drm_bridge *bridge);
> +int drm_panel_bridge_set_orientation(struct drm_connector *connector,
> +                                     struct drm_bridge *bridge);

I suspect that you need some dummy versions of your new functions
defined if "CONFIG_DRM_PANEL_BRIDGE" is not defined. Otherwise we're
going to be yelled at by the kernel robot eventually.

-Doug
