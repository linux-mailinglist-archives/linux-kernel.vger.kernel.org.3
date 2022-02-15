Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2EC4B7970
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbiBOVbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:31:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243476AbiBOVbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:31:34 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F373EB4F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:31:23 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w7so50473ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fele8naCnj1tSHRyG9Ogo68xWxTgJNE5hEc6t985U/Y=;
        b=LZbo2DiOH2tF8Tl/t20r4OjE/KvnsUs22LNv7+pZLZ5HIaTwZBqaF3RtAUUkAPDCOZ
         GumOIavgQoROuq7iGLNguigwifsX10SlH0/8Rh9RwLTK2Tp2DNoNJkJcc2FBrePaIk6L
         lbGzzlgNgGf7bUUma7sCUxDF7/TpqLm2sRqnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fele8naCnj1tSHRyG9Ogo68xWxTgJNE5hEc6t985U/Y=;
        b=Kj1Cj60O59kA6boxd/E+ouLDcLatBDfUdXp5ZR9D5hSifzfJ77pcNLg7sFV3rPcGkQ
         9MGIQLmY/1RntYLaZVYDVEhoBz97ek8EvRuUED0tcHN9dBWEtiSo2Zl/uFMy6B/NeGQR
         42XBt83fnGwtdDOIZByMFR3vlTGBboQ1q+QuAHLXgaqoJqbNjPdZbPJdIANrDUaxHonr
         JP03fTNYsYfxGmX5d+z+FxoTscuZKEvHbHY//ttDPqQ5PFnngULqMjG24SIy0hI9jFSD
         lnkynEx/ZTekO4FXGrI4CcviyU34ya/wwF0UVb5DxhxC8fw3WwKhRXxfimFl/UFPJzy1
         oEwA==
X-Gm-Message-State: AOAM532W7kODJuKW1cO9vDR+ohzPY/EoC8v1i0ZDfEQTltNPR0WBHX0t
        G/zNGx3xBZsqVdaBYkvqcIgdUZ+siqIEDg==
X-Google-Smtp-Source: ABdhPJxWnvg5vUmoT+BDQa1Y66G5ENMlxYWiaKd+hWOTrvZCK6jmdc5YrTrifGrfN22UJXCz4SCruQ==
X-Received: by 2002:a05:6602:2d0a:: with SMTP id c10mr537604iow.80.1644960682961;
        Tue, 15 Feb 2022 13:31:22 -0800 (PST)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id h13sm6706230ili.28.2022.02.15.13.31.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 13:31:21 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id c14so24210ilm.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:31:21 -0800 (PST)
X-Received: by 2002:a05:6e02:1bef:: with SMTP id y15mr639379ilv.120.1644960680707;
 Tue, 15 Feb 2022 13:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20211001144212.v2.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
In-Reply-To: <20211001144212.v2.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Feb 2022 13:31:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XU0bYVZk+-jPWZVoODW79QXOJ=NQy+RH=fYyX+LCZb2Q@mail.gmail.com>
Message-ID: <CAD=FV=XU0bYVZk+-jPWZVoODW79QXOJ=NQy+RH=fYyX+LCZb2Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Grab runtime PM reference for DP-AUX
To:     Brian Norris <briannorris@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sean Paul <sean@poorly.run>, Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 1, 2021 at 2:50 PM Brian Norris <briannorris@chromium.org> wrote:
>
> If the display is not enable()d, then we aren't holding a runtime PM
> reference here. Thus, it's easy to accidentally cause a hang, if user
> space is poking around at /dev/drm_dp_aux0 at the "wrong" time.
>
> Let's get the panel and PM state right before trying to talk AUX.
>
> Fixes: 0d97ad03f422 ("drm/bridge: analogix_dp: Remove duplicated code")
> Cc: <stable@vger.kernel.org>
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v2:
> - Fix spelling in Subject
> - DRM_DEV_ERROR() -> drm_err()
> - Propagate errors from un-analogix_dp_prepare_panel()
>
>  .../drm/bridge/analogix/analogix_dp_core.c    | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index b7d2e4449cfa..6fc46ac93ef8 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1632,8 +1632,27 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
>                                        struct drm_dp_aux_msg *msg)
>  {
>         struct analogix_dp_device *dp = to_dp(aux);
> +       int ret, ret2;
>
> -       return analogix_dp_transfer(dp, msg);
> +       ret = analogix_dp_prepare_panel(dp, true, false);
> +       if (ret) {
> +               drm_err(dp->drm_dev, "Failed to prepare panel (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       pm_runtime_get_sync(dp->dev);
> +       ret = analogix_dp_transfer(dp, msg);
> +       pm_runtime_put(dp->dev);

I've spent an unfortunate amount of time digging around the DP AUX bus
recently, so I can at least say that I have some experience and some
opinions here.

IMO:

1. Don't power the panel on. If the panel isn't powered on then the DP
AUX transfer will timeout. Tough nuggies. Think of yourself more like
an i2c controller and of this as an i2c transfer implementation. The
i2c controller isn't in charge of powering up the i2c devices on the
bus. If userspace does an "i2c detect" on an i2c bus and some of the
devices aren't powered then they won't be found. If you try to
read/write from a powered off device that won't work either.

2. In theory if the DP driver can read HPD (I haven't looked through
the analogix code to see how it handles it) then you can fail an AUX
transfer right away if HPD isn't asserted instead of timing out. If
this is hard, it's probably fine to just time out though.

3. Do the "pm_runtime" calls, but enable "autosuspend" with something
~1 second autosuspend delay. When using the AUX bus to read an EDID
the underlying code will call your function 16 times in quick
succession. If you're powering up and down constantly that'll be a bit
of a waste.


The above will help set us up for when someone goes through and
enables the "new" DP AUX bus and generic eDP panels on for
analogix-edp. See commit aeb33699fc2c ("drm: Introduce the DP AUX
bus"). In that case panels will actually be instantiated DP AUX
Endpoints instead of platform devices. They'll be given the DP AUX bus
and they'll be able to read the EDID over that. In this case, the
panel code turns itself on (it knows how to turn itself on enough to
read the EDID) and then calls the DP AUX transfer code. :-)


For a reference, you could look at
`drivers/gpu/drm/bridge/ti-sn65dsi86.c`. Also
`drivers/gpu/drm/bridge/parade-ps8640.c`

-Doug
