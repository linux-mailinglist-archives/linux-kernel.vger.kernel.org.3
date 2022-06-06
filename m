Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227A353E747
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbiFFP2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240571AbiFFP0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:26:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D4127EBF2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:26:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 25so19039287edw.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyxL+BH8EJsxCMAAiGGCnlS8DDdn5hMkob0TGGobKOQ=;
        b=MuDldpm1cvqxr24yvJdNMyzrGSjeMSKf+Bab5l69mqs7HvGPDxQ8Q1fe4WoY0H+G5r
         l9Bm1R3E5SCPxyYhhjozppQo48CSVDtR6gCNdS9FHy3q0sm0D6jQAvjcaS3bpbJGbp/P
         r1P/JbiX/z/W9OLBkbGU6jO4HkqX8KRdb+wms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyxL+BH8EJsxCMAAiGGCnlS8DDdn5hMkob0TGGobKOQ=;
        b=Ek+c9yFsmChNj9w6x7Rx/BdClwCrifXrATihUoXmyFybjiRB65g9IhSm98GuNYi1eJ
         +sm/UFQzUk3MkCjl6booh0DzhdVDUqZ5+p4ZGGvH9Nq4jXkTQfhmeTeYQUgZy8RwB/0t
         Rhb2Bb1wY8WY0tlp3PGeSHrtXMR3elIzZqncdaeK0vRGUltkEGcGUwGdV4ElsWxjmWII
         sZ5ETOTTR6e9sK+VOlO01tyKPQHEsYjiwxE3MoXEjqqpwv+xlpTFbl5FMZdkvOa33XZ5
         JyNRwyGKI9+REAe4Huak6FZlfVpZOMqWXG3ecRxDPJAfliFfw3C60/Au/BXb/5k2oc1w
         DO1g==
X-Gm-Message-State: AOAM530D3GevDSm+d74TFRPRa8hCge/6Ds5a1nEfBlnTXqSe1zxQvPoK
        rew7dTb1htZjlwcS6ghDVum0r2nCQZc5BGQd/Zxq5fCrpeQ=
X-Google-Smtp-Source: ABdhPJxhQN3Xu1w0I4dYqU9lpzE49XRnQMcVNRaxVrPyusT/cmzzOtLDPj++i33HivGz/uQU6S5aCoH0N0W9ykdflaU=
X-Received: by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id
 b10-20020a056402084a00b00423fe998c53mr27231732edz.195.1654529164971; Mon, 06
 Jun 2022 08:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220606044720.945964-1-hsinyi@chromium.org> <20220606044720.945964-5-hsinyi@chromium.org>
 <CAD=FV=XQbXK13M_X_AsqSPS+D_zQqLtAGFGz=YbHoPu3bcvhZQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XQbXK13M_X_AsqSPS+D_zQqLtAGFGz=YbHoPu3bcvhZQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 6 Jun 2022 23:25:39 +0800
Message-ID: <CAJMQK-gWsMp24O2doGJtvgNCWQvjsx-6N5S9dx+PdTO1_H7Yyw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] drm/panel: lvds: Implement .get_orientation callback
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

On Mon, Jun 6, 2022 at 10:27 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sun, Jun 5, 2022 at 9:47 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > To return the orientation property to drm/kms driver.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > v2->v3: add comments for notice.
> > ---
> >  drivers/gpu/drm/panel/panel-lvds.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
> > index 27a1c9923b09..239527409b00 100644
> > --- a/drivers/gpu/drm/panel/panel-lvds.c
> > +++ b/drivers/gpu/drm/panel/panel-lvds.c
> > @@ -102,15 +102,29 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
> >         connector->display_info.bus_flags = lvds->data_mirror
> >                                           ? DRM_BUS_FLAG_DATA_LSB_TO_MSB
> >                                           : DRM_BUS_FLAG_DATA_MSB_TO_LSB;
>
> Can you rebase your patch and send again? There's a context conflict
> with the above line because your tree is lacking commit 83c784e70036
> ("drm/panel: lvds: Use bus_flags from DT panel-timing property")
>
Rebased in v4.

> In any case:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
