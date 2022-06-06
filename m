Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B751653EA9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbiFFP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbiFFP03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:26:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60EB1AADA6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:26:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so18566364ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0CfqZDZnQGiX6/HBvu3FZf3i9OJ+2C0+13cUpQYRZM=;
        b=fLRQ3/QA1wNcb4MXDUqS4aU+HWo7LVK33bo5FNY/J5Vg95iJWBLdAyFukFxriEzpwA
         jjcSJ6rwdgTWTIyuUdKJrao/n19sdCT5gry7LauyyQwURqAJr2MEeE+aJDVRB1g8mNuJ
         gLH9M5JMHkqEzr4X3juuMpuGvpbhqKX7daMNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0CfqZDZnQGiX6/HBvu3FZf3i9OJ+2C0+13cUpQYRZM=;
        b=c0Ky7JzfFkqKRSlF1Qdi6aHP8/Hg668hhSEZGl1gNGxzLhbGMJR7R7UcgoIN6cEW1E
         xOsQ9fzn2jb3sEkkDhjBff9xXKLVD7QJsBrBBZpauqDgpkG81OBKjg52KbfIG9b/KvtY
         /3MY14oZnjqr5qpnaqUIGcSA9kh+LHPKRH7MJVQgD8wV9T5DA/l7Bj1RQYbl2JhrCjS4
         Vjr1thG6Hd1So7huzzVCpL6eHT/8Gtn83qGIwymGmWEqZkvoXoChJnjzf2FMS1aPBtTY
         +xRP06/ZcX6OeW8gIwBrc+xZtKEr7J0bT5RUWRS5235NEzjg3+AUzOqnXn+1/fwynWig
         jHew==
X-Gm-Message-State: AOAM5338/2WiI0Nd1FVYV7c+QRRedR68wP3k6VhnDA7OCBElQ3niH8fx
        ciq7rpmYNau3KJWv7QWnMsPpaRQbLjQB61I08gLEUQ==
X-Google-Smtp-Source: ABdhPJwoDpT6S3WSY8htZrD/zFlYO0O4+g2JDXZf4OQeXUukmweb7201Svj1Dc8HJysdoeWK939TEdsLvzykBknOAiY=
X-Received: by 2002:a17:906:9b46:b0:711:1f7e:36f8 with SMTP id
 ep6-20020a1709069b4600b007111f7e36f8mr10222093ejc.746.1654529183491; Mon, 06
 Jun 2022 08:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220606044720.945964-1-hsinyi@chromium.org> <20220606044720.945964-2-hsinyi@chromium.org>
 <CAD=FV=V7FmkJyyXr4C6jy9-hOhnzgoo=g5tx_3z3rnCCC40Exg@mail.gmail.com>
In-Reply-To: <CAD=FV=V7FmkJyyXr4C6jy9-hOhnzgoo=g5tx_3z3rnCCC40Exg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 6 Jun 2022 23:25:57 +0800
Message-ID: <CAJMQK-ic2fGfyEaJp5By1dNRJYy7Qwes4gQWADD5Sf=Z5zgafg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] drm/panel: Add an API drm_panel_get_orientation()
 to return panel orientation
To:     Doug Anderson <dianders@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
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

On Mon, Jun 6, 2022 at 10:21 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sun, Jun 5, 2022 at 9:47 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Panels usually call drm_connector_set_panel_orientation(), which is
> > later than drm/kms driver calling drm_dev_register(). This leads to a
> > WARN().
> >
> > The orientation property is known earlier. For example, some panels
> > parse the property through device tree during probe.
> >
> > Add an API to return the property from panel to drm/kms driver, so the
> > drivers are able to call drm_connector_set_panel_orientation() before
> > drm_dev_register().
> >
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > v2->v3: no change
> > ---
> >  drivers/gpu/drm/drm_panel.c |  8 ++++++++
> >  include/drm/drm_panel.h     | 10 ++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index f634371c717a..4a512ca80673 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -223,6 +223,14 @@ int drm_panel_get_modes(struct drm_panel *panel,
> >  }
> >  EXPORT_SYMBOL(drm_panel_get_modes);
> >
> > +enum drm_panel_orientation drm_panel_get_orientation(struct drm_panel *panel)
> > +{
> > +       if (panel && panel->funcs && panel->funcs->get_orientation)
> > +               return panel->funcs->get_orientation(panel);
> > +
> > +       return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> > +}
> > +EXPORT_SYMBOL(drm_panel_get_orientation);
> >  #ifdef CONFIG_OF
>
> nit: there used to be a blank line before the #ifdef but there no
> longer is after your patch.
>
Added in v4.
> Other than that...
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
