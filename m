Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B3F54C157
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345820AbiFOFuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245020AbiFOFud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:50:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6955B33EB3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:50:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x5so14540232edi.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1Vf5ybmWHMCCare0qDg8SwPPoQD0QhbtYBYyxeUrq8=;
        b=Ag1aXw2jvTVA7zj000m0mm7g4v9LClriU8HKZSHDqkV7VWJ6TW0872btwmRL8YOhHv
         /h0UTPqYTWMypwvjlp7HFBfG74+NiYztO1x+sVfz4FEI6DuU4uxDrtoNMI9vIL7+pkLT
         KBJyXI31qr4bl59ihqAqPeS5UGX2uWtkyAwyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1Vf5ybmWHMCCare0qDg8SwPPoQD0QhbtYBYyxeUrq8=;
        b=dCSRFD4LJB7HoHQeXxTOq4wGhoQDjXxVQg6rzi8tmsvMY1xt3ghjP7ncq9FNSWv/p6
         wYHjVgXbrRv+9aWVwp5wG4JqP27zJoieYnPQGUgCaS3cQNy6qkcZa7dAdM/BurFNckvO
         Y+WZraN10lWwFvmMClsYIeu7s1kZY3+Z2WfOORBgZVkDkkshz9n52foDg5Ddh9YIrt/q
         pNfxRsuFM6Uw/QGtAobi8XwZUr9jO2qkP/9SyrkGs7OuPd98ReRLzjh8jPg9pPQszB37
         Wceu9dwAzngLfIZa7eDeZ14LzMLzLs8hLowt+pEPvXc41YnIlRzsr9zxlqArs/rn6pEW
         jI8Q==
X-Gm-Message-State: AOAM532fQTXrnB8TKd+84mL/JoFzBzN35+cwDDLLESdq0c6Ubr2uWgQX
        oCO2SQjdCM0YcMRJI1kME1JX2MuXjxFtgkF1npv/Ug==
X-Google-Smtp-Source: AGRyM1vjB0FC5P09G+rt/YLiB6xz66BihK6l+v4rWnGykvM7armSUF85EPc5KFmSMQB81oPGgjsG4xLYDPyyYAO/lq8=
X-Received: by 2002:a05:6402:1941:b0:413:2b5f:9074 with SMTP id
 f1-20020a056402194100b004132b5f9074mr10516814edz.414.1655272229642; Tue, 14
 Jun 2022 22:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220609072722.3488207-1-hsinyi@chromium.org>
In-Reply-To: <20220609072722.3488207-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 15 Jun 2022 13:50:03 +0800
Message-ID: <CAJMQK-hg5kLUV=ZgVN5=qX=bRiBWx3O-4X9wPF6CwxpQVSuinA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add a panel API to set orientation properly
To:     Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
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

On Thu, Jun 9, 2022 at 3:27 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Panels usually call drm_connector_set_panel_orientation(), which is
> later than drm/kms driver calling drm_dev_register(). This leads to a
> WARN()[1].
>
> The orientation property is known earlier. For example, some panels
> parse the property through device tree during probe.
>
> The series add a panel API drm_connector_set_orientation_from_panel()
> for drm/kms drivers. The drivers can call the API to set panel's
> orientation before drm_dev_register().
>
> Panel needs to implement .get_orientation callback to return the property.
>
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/
>
> Hsin-Yi Wang (8):
>   drm/panel: Add an API to allow drm to set orientation from panel
>   drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
>   drm/panel: panel-edp: Implement .get_orientation callback
>   drm/panel: lvds: Implement .get_orientation callback
>   drm/panel: panel-simple: Implement .get_orientation callback
>   drm/panel: ili9881c: Implement .get_orientation callback
>   drm/panel: elida-kd35t133: Implement .get_orientation callback
>   drm: Config orientation property if panel provides it
>
hi Maintainers,

All the patches are reviewed. If there's no other comments, will this
series be picked? Thanks.

>  drivers/gpu/drm/bridge/panel.c                | 34 +++++++++++++++++++
>  drivers/gpu/drm/drm_bridge_connector.c        |  8 ++++-
>  drivers/gpu/drm/drm_connector.c               | 31 +++++++++++++++++
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 12 +++++++
>  drivers/gpu/drm/panel/panel-edp.c             | 13 ++++++-
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c  | 12 +++++++
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 12 +++++++
>  drivers/gpu/drm/panel/panel-lvds.c            | 13 +++++++
>  drivers/gpu/drm/panel/panel-simple.c          | 14 +++++++-
>  include/drm/drm_bridge.h                      | 14 ++++++++
>  include/drm/drm_connector.h                   |  4 +++
>  include/drm/drm_panel.h                       |  9 +++++
>  12 files changed, 173 insertions(+), 3 deletions(-)
>
> --
> 2.36.1.255.ge46751e96f-goog
>
