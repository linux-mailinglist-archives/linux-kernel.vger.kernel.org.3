Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A7B53F7B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbiFGHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiFGHyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:54:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C93C9676
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:53:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 25so21576795edw.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTcKUvKBFqx0lJtGawmW30NCfuDMQMt7XlkJoMiwP40=;
        b=BRcrqvdcJ8xhPPgG0bBbVBAiVx5+b1kxVRYTF+auAqOwaNxiSEJIGoWo2Vw1NSQv+g
         m+QFnkk9OCc0qPYzLEDDAl6JIeZKI2nmJ3WKE52P77RWJopLhG0nlii3OGBErGC4aljv
         V5z+8qwkVzCJGQbsGoFZmWoLE7owrtk67FYI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTcKUvKBFqx0lJtGawmW30NCfuDMQMt7XlkJoMiwP40=;
        b=29joBEGgK+Z44EsQvkN8nvSkyKVqHSHNTpSrtCo9ryF7pwhETEMbVbOJxe/4dps7ka
         QvWwKw4Ec+HZZdvOY9zS995KK+A4lkz6ApAhL/Qz/UuQ9S6YnAkSNP3wuOrk03GyJ8mW
         kx21v49V4cb61JsAJrRuf1uhSqjHkcEo+0PSDSntN4qTind+vtpeEGPzYbEYFoJyE4KU
         B9G5776s9JNvK6ODim8aWWcuTCEt3K8XoJMSPJtDjA3S7DXBlUxZ9R0qR6qDx9zxyJe8
         +pZXPyDC9hQl56Z1cPV+PSdJE6fzKTwg40p3Lk5zc3tBTup5PHFHgtceJYlM/QMCBmZ0
         qR/w==
X-Gm-Message-State: AOAM532Rd5yP6Qnxie8VghJjmB8Mm/v5ZAUlOM0yHeg0UIKOQ9RH1TaC
        Wkwa792+FMxFkYh5EDu1oV/R435emk1k07Wvz5PwSg==
X-Google-Smtp-Source: ABdhPJxwDZlNTB+YxaMW6ZNNbb9evKtxWWCIjvCP63mUZOd90Ckf8Jn8me1MaQylI36w6ArAMzXiudnaT/5dtDqKCfQ=
X-Received: by 2002:a05:6402:1941:b0:413:2b5f:9074 with SMTP id
 f1-20020a056402194100b004132b5f9074mr32019311edz.414.1654588437586; Tue, 07
 Jun 2022 00:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220606152431.1889185-1-hsinyi@chromium.org> <20220606152431.1889185-2-hsinyi@chromium.org>
 <CAE-0n52mzczUdtwUgfdNOC_V7kBGhzFWHRT=QHDoH4kN+yCMGA@mail.gmail.com>
In-Reply-To: <CAE-0n52mzczUdtwUgfdNOC_V7kBGhzFWHRT=QHDoH4kN+yCMGA@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 Jun 2022 15:53:31 +0800
Message-ID: <CAJMQK-joqHaJeTNurzecmXcZ_eiK+24Tc0ok2zcFdUNXz3TQmQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] drm/panel: Add an API drm_panel_get_orientation()
 to return panel orientation
To:     Stephen Boyd <swboyd@chromium.org>
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
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
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

On Tue, Jun 7, 2022 at 3:06 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Hsin-Yi Wang (2022-06-06 08:24:24)
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index f634371c717a..e12056cfeca8 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -223,6 +223,15 @@ int drm_panel_get_modes(struct drm_panel *panel,
> >  }
> >  EXPORT_SYMBOL(drm_panel_get_modes);
> >
> > +enum drm_panel_orientation drm_panel_get_orientation(struct drm_panel *panel)
>
> Should 'panel' be marked const to indicate that it can't be modified?
>

But .get_orientation() will need to call to_XXX_panel, eg.
static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)

==> .get_modes(panel) <-- can't be const.
==> drm_panel_get_orientation(panel) <-- can't be const.

We can definitely cast it in the functions, or make to_XXX_panel()
accept const, but I think this will lose the meaning of using const
anyway.

> > +{
> > +       if (panel && panel->funcs && panel->funcs->get_orientation)
> > +               return panel->funcs->get_orientation(panel);
