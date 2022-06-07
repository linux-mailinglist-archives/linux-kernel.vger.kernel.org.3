Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509AF53F4C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbiFGDzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiFGDzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:55:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E536C8BE0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:55:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b8so4588834edj.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 20:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rF3WnKoDiq9d0J5JTo2dbHB29qndpGa9NLM7gHMjks=;
        b=dOTd7bOssfnug98baEiau/IHu9iQgmO17eKfDY/Bah2lZ9CfdHsZQVDOuAxtfFOjt6
         OfMgThkcO291HJnaSUEMg8Th8FQnPhCGiKp27GaI/cmwZ2T3IA2Pv/VH1MCx4C5srtdM
         KSQa6JTtjCr3JKGym2k92cRDgRRlctuhUe8L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rF3WnKoDiq9d0J5JTo2dbHB29qndpGa9NLM7gHMjks=;
        b=dg43O4x0+GqaUDqopQpVD3KBNwy1lhMqJVB3KvLkm5bp5goHu+2byhEr5ZoENWjYUs
         5rZCHS30lUG+Rk1+XzR5/+71EZiKOhAXM7bkvBUhVROSREuFsE6tnA1hV2ivBrylROo5
         MMcYjTj3UnDkR3D0gRvkxrzEKkI2vvL6Ld3huqnBEpFwMSX0x0Oju5jmOlvyXVPAqbjP
         8BPAg4ROpVrM33twtkgKDg21U6Nkpu0im/WQCFW5WxGuYNZePvwJC0s1SkSopXc5yxuA
         XxffUHZStOqNXyDuslZkBC0hwCa3kOeFui7ue/8rPCfW53dv50ADMxuIDATPFRhSx+PP
         KQLA==
X-Gm-Message-State: AOAM53114qoe3SsPFgFLc0uaChwAs3P9jP7391bQNh/RGiCcKP3EcgL5
        w12lgL6/ttzLzzzga1UMYWxYaPeJ6jJzIkCpFV3Czg==
X-Google-Smtp-Source: ABdhPJxseST/bQW8I4wOtFU0k3sfPx8cJKe63oJ9hcqGlssDuTJQdN8hOFSR1H0gQ/VzLuzmJyaFXgWaoQDXWguxXK8=
X-Received: by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id
 b10-20020a056402084a00b00423fe998c53mr30452834edz.195.1654574109792; Mon, 06
 Jun 2022 20:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220606152431.1889185-1-hsinyi@chromium.org> <20220606152431.1889185-6-hsinyi@chromium.org>
 <Yp5Ul/ODUB/sQ0Jf@ravnborg.org>
In-Reply-To: <Yp5Ul/ODUB/sQ0Jf@ravnborg.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 Jun 2022 11:54:43 +0800
Message-ID: <CAJMQK-huAnvamC318FhHoBSTTnMB489PWsH6tZu3r9Ah990Gzw@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] drm/panel: panel-simple: Implement
 .get_orientation callback
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
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

On Tue, Jun 7, 2022 at 3:25 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Hsin-Yi,
>
> On Mon, Jun 06, 2022 at 11:24:28PM +0800, Hsin-Yi Wang wrote:
> > To return the orientation property to drm/kms driver.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 4a2e580a2f7b..f232b8cf4075 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -411,7 +411,12 @@ static int panel_simple_get_modes(struct drm_panel *panel,
> >       /* add hard-coded panel modes */
> >       num += panel_simple_get_non_edid_modes(p, connector);
> >
> > -     /* set up connector's "panel orientation" property */
> > +     /*
> > +      * drm drivers are expected to call drm_panel_get_orientation() to get
> > +      * panel's orientation then drm_connector_set_panel_orientation() to
> > +      * set the property before drm_dev_register(). Otherwise there will be
> > +      * a WARN_ON if orientation is set after drm is registered.
> > +      */
>
> This comment is not really relevant here. If we need to explain this
> then put it in drm_panel.c/h - as this applies for all panels and not
> just the panel_simple.
> Keep in mind, this is the source new panels often use a inspiration and
> no need to have this copied around.
>
Will update this.

> >       drm_connector_set_panel_orientation(connector, p->orientation);
> >
> >       return num;
> > @@ -434,6 +439,14 @@ static int panel_simple_get_timings(struct drm_panel *panel,
> >       return p->desc->num_timings;
> >  }
> >
> > +static enum drm_panel_orientation panel_simple_get_orientation(struct drm_panel *panel)
> > +{
> > +       struct panel_simple *p = to_panel_simple(panel);
> > +
> > +       return p->orientation;
> > +}
> > +
> > +
> >  static const struct drm_panel_funcs panel_simple_funcs = {
> >       .disable = panel_simple_disable,
> >       .unprepare = panel_simple_unprepare,
> > @@ -441,6 +454,7 @@ static const struct drm_panel_funcs panel_simple_funcs = {
> >       .enable = panel_simple_enable,
> >       .get_modes = panel_simple_get_modes,
> >       .get_timings = panel_simple_get_timings,
> > +     .get_orientation = panel_simple_get_orientation,
>
> I like the order in this list to match the order in the .h file.
> So my OCD would like you to move it up right after get_modes,
> but feel free to ignore this.
>
Sure.

> With the suggested changes:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
> >  };
> >
> >  static struct panel_desc panel_dpi;
> > --
> > 2.36.1.255.ge46751e96f-goog
