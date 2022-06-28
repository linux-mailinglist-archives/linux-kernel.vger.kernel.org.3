Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554DB55EFB7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiF1Ukx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiF1Ukv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:40:51 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC982248D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:40:45 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so10632059otk.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=g7DzDcGO0C//Tm2mK6aKPbRwKZWmv3UtbhY+R8SWnp0=;
        b=KWNEvpPfmo2SmKf5bhaztGdiQA6tvFbLTUxtrhK6rIjkzfNXr0keJwbndIKL9tV+kc
         GJvLAH4zZhqCxZY5XcSqSB007mXJECoqbN7dcQdel3VfCXDBC+smGP7zRPJ+jnJwH0lC
         EKUm1ID9cMqQTYUrXSF130ZWwW3VemS6uvCCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=g7DzDcGO0C//Tm2mK6aKPbRwKZWmv3UtbhY+R8SWnp0=;
        b=VSCAM8kohrkk9Gjn+kuBnL7eP1IpEE/cHMmPx0euhcKX8HWibh0qGtVb1BjIve7NJ9
         I6gMIf9TitTnj6rUli9OnAvrFeE16fsFDFa8nVtWLeNn7vmMUpVdJwBrz++J8WFA72V1
         9+nCS7HiLUm2JLqFM8VeuattzRqXIgrNe26Rktzmc2X4mUEhMpYF73ehdsEPqnUi8oqd
         DOPH6efM3oAolum3kE70aXKpTLNj7hatF4kj91kJ78yxFyUm2mPzURCHZcMMkty3xPP8
         H30gIGME2KVP5GuUM2AZUKNqatvKCAbN/1yk67dYpwZ6gxKUUUxpcU3d8RwyanupqDF5
         V8eg==
X-Gm-Message-State: AJIora/fHQjkNkxdYHo4eWqgm70gza30h8kwKaB8qU9Fbj4xRoUiRNLY
        WaJfeYjfqDfn4LfBDKqHKoAqrODRwzxmsJGkSE1D5xgjwKU=
X-Google-Smtp-Source: AGRyM1tGIqN+N5fxU26uQPwuhb/+Q+PPDxiV9zB3lkXobvidTtjy4ULjamLp4gDIpHvSTR5pfmD19QEOr8obxLOLWwA=
X-Received: by 2002:a9d:6484:0:b0:60b:eb0b:4054 with SMTP id
 g4-20020a9d6484000000b0060beb0b4054mr9324278otl.159.1656448844842; Tue, 28
 Jun 2022 13:40:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jun 2022 15:40:44 -0500
MIME-Version: 1.0
In-Reply-To: <CACeCKafR8hFke_tc2=1VGDNF-CFrZoAG1aUKuxGJG-6pd37hbg@mail.gmail.com>
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-6-pmalani@chromium.org> <CAE-0n517BB8YbN5AZG6M3ZrZGOJDV=+t0R9d8wD+gVqO1aD1Xg@mail.gmail.com>
 <CACeCKafR8hFke_tc2=1VGDNF-CFrZoAG1aUKuxGJG-6pd37hbg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 28 Jun 2022 15:40:44 -0500
Message-ID: <CAE-0n50XbO5Wu4-429Ao05A4QrbSXoi1wBjTpGFjKm3pZj1Ybg@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] drm/bridge: anx7625: Add typec_mux_set callback function
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Pin-Yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prashant Malani (2022-06-28 12:48:11)
> On Tue, Jun 28, 2022 at 12:25 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Prashant Malani (2022-06-22 10:34:34)
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index bd21f159b973..5992fc8beeeb 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
[..]
> > > +
> > > +       if (ctx->num_typec_switches == 1)
> >
> > How do we handle the case where the usb-c-connector is directly
> > connected to the RX1/TX1 and RX2/TX2 pins? This device would be an
> > orientation (normal/reverse) and mode switch (usb/dp) in that scenario,
> > but this code is written in a way that the orientation switch isn't
> > going to flip the crosspoint switch for the different pin assignments.
>
> If all 4 SS lanes are connected to 1 usb-c-connector; there would be
> just 1 "typec-switch" node.
> In that case, the DT would only specify it as an "orientation-switch"
> and register
> an orientation-switch with the Type-C framework. The orientation switch would
> pretty much do what the mode-switch callback does here (configuring
> the crosspoint
> switch).
> One could also register a "mode-switch" there but it wouldn't do
> anything (all 4 lanes are already
> connected so there is nothing to re-route in the crosspoint switch).
> Hence the above "if" check.

Would we still want to route the DP traffic out if the pin assignment
didn't have DP? Does the hardware support some mode where the DP traffic
is shutdown? Or maybe the HPD pin needs to be quieted unless DP is
assigned?

I suppose none of those things matter though as long as there is some
typec switch registered here so that the driver can be informed of the
pin assignment. Is it right that the "mode-switch" property is only
required in DT if this device is going to control the mode of the
connector, i.e. USB+DP, or just DP? Where this device can't do that
because it doesn't support only DP.

>
> Unfortunately, I don't have hardware which connects all 4 SS lanes
> from 1 Type-C port
> to the anx7625, so I didn't add the orientation switch handling to the
> driver (since I have no way of verifying it).

Alright. Maybe add a TODO then so it's more obvious that orientation
isn't handled.

>
> Regarding DP alt-mode pin assignments : I think anx7625 will only support Pin D
> (only 2 lane DP, no 4 lane DP).
>

Makes sense. Thanks!
