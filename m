Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E6D53B4C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiFBIHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiFBIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:07:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6740285EE1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:07:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er5so5215796edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vMm0s7j0BfbtfCeMoENN6g/p67B/T0t3t4wSxuqZsM=;
        b=DI8Qpx5MUleXyJ2zO6eq3/ipbnYwVyicYJxvtCHB4bW/NNet9TE+jNgXo7Te/Aq2I2
         c22ngnKAO/z05MJNo7ip81+yZNAoAljWGXdJ/0HnFmQKM8d79/N/jHiXev8FO/bOcD2s
         I+T6C2nlL6+p975fZBs+A8JYFVY5lgarzQQr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vMm0s7j0BfbtfCeMoENN6g/p67B/T0t3t4wSxuqZsM=;
        b=b8wENJtIREWED5lj20yI22XxeSERhrz1i38Qayb5ctwOtpz1tSOYVkcXZzfaYXH0fZ
         6YbNGQl99YuCkirDnu6oFMk92FTg7WkX6ECfOynMp0zt1zS1LkwHqx8lv4HZIO9WhE9E
         fvwqUJ4VBXaf+k92exgbIG3ka1PA76wspbOCrRjyd3tPIKdUTkGI6r68vBNs6F2Orbk0
         mMgLQb1U/P7oj3MYgHpudZ+Aibg5VjD6AIBFCnBkTYU+7NJsdUAlb+HHQ7HoMOaj88A1
         bPkwoykDcCA7ef9MXKwWnMXG2Ce7448k4fA+M8Jb/bdgcwuLJlRFAjKBcmdQY6fqVFAP
         bFeA==
X-Gm-Message-State: AOAM532zl77wkQyIzSDq0t8oCPRFgL6wNItmv8aFoSIKLbe7C6maIKdw
        My/W1p8yvBHhzMg/7F8D6o1XYoAdCONs8Meg3QMf6A==
X-Google-Smtp-Source: ABdhPJwYzmq6Zn5Gn969SIbPrVPQEWs30Q+k4IKGlmSfcZd8DLQuZbom06x50wb0uWfPTopTH5Z9bOVJGvu44uXetIM=
X-Received: by 2002:a05:6402:1d50:b0:42b:6da9:ed34 with SMTP id
 dz16-20020a0564021d5000b0042b6da9ed34mr3934330edb.333.1654157260875; Thu, 02
 Jun 2022 01:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220601094637.1200634-1-hsinyi@chromium.org> <044158674aab0b40d8edcac920855a37fca58cf0.camel@mediatek.com>
In-Reply-To: <044158674aab0b40d8edcac920855a37fca58cf0.camel@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 2 Jun 2022 16:07:14 +0800
Message-ID: <CAJMQK-gyJbNBgot3NqSQP5xEb5LtFrk5A9mPQOcntEvxncsmRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add a panel API to return panel orientation
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 4:03 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Hsin-Yi:
>
> I'm curious that panel driver setting orientation in get_modes() would
> work or not. It it works, why not just set orientation in get_modes()?
> I find that exynos dsi driver has implement the get_modes() [1] but
> Mediatek dsi does not implement. Would you try this?

It's explained in the cover letter:
```
Panels usually call drm_connector_set_panel_orientation(), which is
later than drm/kms driver calling drm_dev_register(). This leads to a
WARN()[1].
```
If the get_modes() in dsi is still being called later than bind(),
then the same issue still appears.
The purpose is to set the property before drm_dev_register().



>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/exynos/exynos_drm_dsi.c?h=v5.18#n1483
>
> Regards,
> CK
>
> On Wed, 2022-06-01 at 17:46 +0800, Hsin-Yi Wang wrote:
> > Panels usually call drm_connector_set_panel_orientation(), which is
> > later than drm/kms driver calling drm_dev_register(). This leads to a
> > WARN()[1].
> >
> > The orientation property is known earlier. For example, some panels
> > parse the property through device tree during probe.
> >
> > The series add a panel API drm_panel_get_orientation() for drm/kms
> > drivers. The drivers can use the API to get panel's orientation, so
> > they
> > can call drm_connector_set_panel_orientation() before
> > drm_dev_register().
> >
> > Panel needs to implement .get_orientation callback to return the
> > property.
> >
> > [1]
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/__;!!CTRNKA9wMg0ARbw!0ytf4wPxKANnYbw_fgq-eqQARnAXIHv4jwu04ZW6X6dAxZDFsJ0CltY_PvCBAQ$
> >
> >
> > Hsin-Yi Wang (8):
> >   drm/panel: Add an API drm_panel_get_orientation() to return panel
> >     orientation
> >   drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
> >   drm/panel: panel-edp: Implement .get_orientation callback
> >   drm/panel: lvds: Implement .get_orientation callback
> >   drm/panel: panel-simple: Implement .get_orientation callback
> >   drm/panel: ili9881c: Implement .get_orientation callback
> >   drm/panel: elida-kd35t133: Implement .get_orientation callback
> >   drm/mediatek: Config orientation property if panel provides it
> >
> >  drivers/gpu/drm/drm_panel.c                    |  8 ++++++++
> >  drivers/gpu/drm/mediatek/mtk_dsi.c             | 10 ++++++++++
> >  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c |  8 ++++++++
> >  drivers/gpu/drm/panel/panel-edp.c              |  8 ++++++++
> >  drivers/gpu/drm/panel/panel-elida-kd35t133.c   |  8 ++++++++
> >  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c  |  8 ++++++++
> >  drivers/gpu/drm/panel/panel-lvds.c             |  8 ++++++++
> >  drivers/gpu/drm/panel/panel-simple.c           |  9 +++++++++
> >  include/drm/drm_panel.h                        | 10 ++++++++++
> >  9 files changed, 77 insertions(+)
> >
>
