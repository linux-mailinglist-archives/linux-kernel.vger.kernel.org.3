Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2B85441CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbiFIDNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFIDNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:13:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CEA1BC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 20:13:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q15so22523790wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 20:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAB02C3ZkH9VbHetvGWn5Py2rhK3DERsYsHyjK16wTE=;
        b=XbRWmIGGGenwao2Tk7wJ1Mr9i3hHZQHKx9STxE+UuTq7k04t4aXKpWuKhPOVswBUD9
         pEO8M6LEtGpJhPGuBYJYojpVZpAFGHKwRBoxKbKnWUiFKJmi1gd9o0k/2AjheVs6HNgB
         3035f8G9eiId/7FVig6JqCQvOd+JSX9dxM+eE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAB02C3ZkH9VbHetvGWn5Py2rhK3DERsYsHyjK16wTE=;
        b=T7UriT7Tinmk/eX/6uc+BsIFV2m5VJVmBVvrrqY78v+qB3CniaoAXs3RKBBJ74x0BS
         VeVULKv4XcbiT46VY30g55koEKGe16GAUNRUj9vrNxs+xlBdAJX3tdJTpbDTrzjpFAvb
         GB1m63SUReWauXmn47b7Yr0aVu7A6fbQaKp7aamhpYkCrvlqc4/YIYV81qom4ObYVLAv
         7jkfHpIYDJi1jiTw3YYUzgagpO8ORpO/OY3TaRC+hO9P0IDKoJ4dyXXHpXtJyMFsQH6o
         DCVAJhKj5QmssxHwMB1b+XPYiITtc8dNiX1uKVQ2jLZ1PcBP3fAFlJvMa4KQRlIZTzAh
         mJrQ==
X-Gm-Message-State: AOAM530ETu6yC+MxUVEI4otTkls23Yh/zpEOBas/VQJzZkRvxZfEJYgt
        kKiU2nPuP/n+YyARnJ7e/o7ATf8nro+qC+A9vqEc/NMvW3M=
X-Google-Smtp-Source: ABdhPJyVjcaUH2c41gSc30QMinoAfJYAtQr3o/n0OUHhR0BwgrviMwb7SQgNmDG5Qp0lzNm1q2HT77RONbvJMun3cA4=
X-Received: by 2002:a05:6402:149:b0:431:7dde:9b59 with SMTP id
 s9-20020a056402014900b004317dde9b59mr15089962edu.339.1654744414987; Wed, 08
 Jun 2022 20:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220608094816.2898692-1-hsinyi@chromium.org> <20220608094816.2898692-9-hsinyi@chromium.org>
 <CAD=FV=VShXpy+6ESXGKhw5Z9o3hfXNV2_HvdOAPM3YN2qSA9Sg@mail.gmail.com>
In-Reply-To: <CAD=FV=VShXpy+6ESXGKhw5Z9o3hfXNV2_HvdOAPM3YN2qSA9Sg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 9 Jun 2022 11:13:09 +0800
Message-ID: <CAJMQK-hoecGwz3AmN7qdRhYCOzDXbaHZ2Fa2UCmWMFO7ouFGUg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] drm: Config orientation property if panel provides it
To:     Doug Anderson <dianders@chromium.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 10:17 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jun 8, 2022 at 2:48 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > @@ -269,6 +280,31 @@ void drm_panel_bridge_remove(struct drm_bridge *bridge)
> >  }
> >  EXPORT_SYMBOL(drm_panel_bridge_remove);
> >
> > +/**
> > + * drm_panel_bridge_set_orientation - Set the connector's panel orientation
> > + * if the bridge is a panel bridge.
> > + *
> > + * @connector: The connector to be set panel orientation.
> > + * @bridge: The drm_bridge to be transformed to panel bridge.
>
> Ideally you should have a kernel doc to describe what you're returning.
>
>
> > + */
> > +int drm_panel_bridge_set_orientation(struct drm_connector *connector,
> > +                                    struct drm_bridge *bridge)
> > +{
> > +       struct panel_bridge *panel_bridge;
> > +
> > +       if (!bridge)
> > +               return 0;
> > +
> > +       if (bridge->funcs != &panel_bridge_bridge_funcs)
> > +               return 0;
>
> nit: Why do you need to handle NULL bridge and the case that someone
> calls you with something other than a panel-bridge? I'm not convinced
> that's useful. In general kernel style doesn't do massive validation
> of parameters unless there's a reason for it. ...if we do need to
> handle them then it feels like they should be returning -EINVAL or
> something, not 0.

The only caller had checked it. I can remove the check here.

>
>
> > @@ -917,10 +917,13 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
> >                            enum drm_connector_status status);
> >
> >  #ifdef CONFIG_DRM_PANEL_BRIDGE
> > +bool drm_bridge_is_panel(const struct drm_bridge *bridge);
> >  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
> >  struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
> >                                               u32 connector_type);
> >  void drm_panel_bridge_remove(struct drm_bridge *bridge);
> > +int drm_panel_bridge_set_orientation(struct drm_connector *connector,
> > +                                     struct drm_bridge *bridge);
>
> I suspect that you need some dummy versions of your new functions
> defined if "CONFIG_DRM_PANEL_BRIDGE" is not defined. Otherwise we're
> going to be yelled at by the kernel robot eventually.
>
> -Doug
