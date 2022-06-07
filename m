Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EAB53F49B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiFGDif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiFGDic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:38:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A551535DE5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:38:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fu3so31088955ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 20:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJ9t0JsMzf9+b8G+NsrCGuGZ2WHm7yJdraWRSfiKGkA=;
        b=luqlEGHcZ3EsuUaCVY6GMNpFf/WWxyuViWZVeRqUEErf9I9VtVM1lds0X9kadOzOJN
         cszTD9YoVUoRI7Y7blXJ11oo9McRcIKLzrEKA7N554p76iZLgY8Rd3ITfDBweQcSXSEp
         ZvIHkSGHIxEHuVqKNxRubd5d5H8shRx58lWHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJ9t0JsMzf9+b8G+NsrCGuGZ2WHm7yJdraWRSfiKGkA=;
        b=7ox13zhroVbkdSeXr+LN9jzawv7DxpYgfEinAdmqUvVoQpDVUKCrW2ZeUOEBK654+l
         avUf3soxl18Kldsv84eMbpPamBkjZMW0LJlx6TFo9II/wOLgyVWjynqj70I7h0cGfDiD
         1xO1THX68ehUz/YRENlJJWpA44AjPcS1buQLe594vpRvB9feMPcLzI137xFLtwQ73KEn
         u1pEzYaZfFdaivX5nZhJ6kl5AsAEUXpB2poBQw/j3rpKbE6N7xG24T2FiwDRvvwODo3R
         a4jAw9+FTq1tpKlUCM/YhPfzMMU5ooKBvdHlXydUVi2LjAE/27DLeSOgHpqOiGGskhda
         0YXg==
X-Gm-Message-State: AOAM5301RBEIcLwIp1WniwqYa2kXlrnvTwPNLyeCWoJKD5/2oH8FhWuD
        uWPT7KJWvEc6LpwCbSEz+iKDgnokBn5b9ydl8iK4/A==
X-Google-Smtp-Source: ABdhPJxvmyTN4ySZ5rqR9pOFJ1zEcnVcYm+SktOdEe+JR5rDOKDREJpcaAfPg15x/AOi9cNPiXshMUiWFFvhktMChtw=
X-Received: by 2002:a17:907:868f:b0:702:f865:55de with SMTP id
 qa15-20020a170907868f00b00702f86555demr24650686ejc.24.1654573109183; Mon, 06
 Jun 2022 20:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220606152431.1889185-1-hsinyi@chromium.org> <20220606152431.1889185-9-hsinyi@chromium.org>
 <CAE-0n51Lq381dQW6zw3D0fibdj=Jm4r3uAYG59ySo4CXbx+EpA@mail.gmail.com>
In-Reply-To: <CAE-0n51Lq381dQW6zw3D0fibdj=Jm4r3uAYG59ySo4CXbx+EpA@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 Jun 2022 11:46:24 +0800
Message-ID: <CAJMQK-hoKB+W4AY8trW-ni145oxde4ot1_z+d6sbxGrbQ6aMig@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] drm/mediatek: Config orientation property if panel
 provides it
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

On Tue, Jun 7, 2022 at 3:16 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Hsin-Yi Wang (2022-06-06 08:24:31)
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index d9f10a33e6fa..c56282412bfa 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -822,6 +823,12 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
> >                 ret = PTR_ERR(dsi->connector);
> >                 goto err_cleanup_encoder;
> >         }
> > +
> > +       /* Read panel orientation */
> > +       if (dsi->panel)
> > +               drm_connector_set_panel_orientation(dsi->connector,
> > +                               drm_panel_get_orientation(dsi->panel));
> > +
>
> It could be simplified like so?
>
>         drm_connector_set_orientation_from_panel(dsi->connector, dsi->panel);
>
> Then the API could get the orientation if the panel pointer is valid.
> Does any code need to use/modify the orientation value besides
> drm_connector_set_panel_orientation()?
>

We can add another function to call
drm_connector_set_orientation_from_panel(), which will be like

void drm_connector_set_orientation_from_panel(connector, panel)
{
     if (panel)
          drm_connector_set_panel_orientation(connector,drm_panel_get_orientation(panel));
}

Though it's very should but I can add this if this can make the caller
more convenient.

> >         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> >
> >         return 0;
