Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D154B740
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiFNRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350611AbiFNQ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:59:37 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744CC2A417
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:59:11 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-30fa61b1a83so36916277b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frgH5D5aZ/QCMYdKBtSKwr1Fa+OKDcjZdtrUi/1lSyM=;
        b=Iy68FsENZikMJA1KZJTjwX1XEHgmkOCOlDXlEOiHXuGDZYlBW487hnOFgqOIKzqbGZ
         fFRO0wPZaY/vxvv7gpbvanDkzTqsbr/Bs2SWkf8stYs73nG19v6Hs00zCU3D/wRsf9G3
         uRqg0grrqVyVw5C8ve+NeyA1pqaYQZsBLGy4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frgH5D5aZ/QCMYdKBtSKwr1Fa+OKDcjZdtrUi/1lSyM=;
        b=iXRTvgmg2N3KH81hO+3HFEt/2eUFMJsUNnBYSvZCbNxeSCJrUfWPbC8eWrdEZEvB3u
         b56cWm5eRgBNY6ZSl2sb7uWHWm0xdtFqfkjkG+yjeqFAzsn4AqtIaDXpAIexSf2FC9dz
         j3TQ7xe0aK+0pe2kfwDhw98LqEST2+I/x5e7KNfaDdzndJRucyUqV5gJSKiyB3zcaK5Q
         r0+yG6fhgZ9+chokpWftTvAOMsoGw6KxRFuf0xGPk866kVXNYFGGoufTdKhhfQXAcaAC
         a/jxIR1kOxp//5/CcFadfSxnO6g5noVE+VTNtNn+RQ/X5pJWL6XqaO6DjlYnGjWa9E7w
         KcKg==
X-Gm-Message-State: AJIora+qeoJKAmAaQHCFgUebddDzhF+8QmqAzW5ybCe0AQJcG0L6s57f
        UeaJXTnre2HonBU7BW9nsYnJVgs5t86NZy7Jafl+nA==
X-Google-Smtp-Source: AGRyM1tylgW3wSGschehZtJMDRjLFEU3xZbVs+AtL1Cy4Vu0B5yrroRvR3b8lL2U6xMNqB5j2IC6JxMRpK98NWwIU4k=
X-Received: by 2002:a81:fd1:0:b0:30f:f98b:4957 with SMTP id
 200-20020a810fd1000000b0030ff98b4957mr6952329ywp.350.1655225950624; Tue, 14
 Jun 2022 09:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220609181106.3695103-1-pmalani@chromium.org>
 <20220609181106.3695103-8-pmalani@chromium.org> <1191703c-efa5-7fe6-7dd0-e3e786b58411@collabora.com>
 <CAEXTbpfh3aKS8DZ9T0KPNLfWJ4EsLxcJpP8aLYU-iQYC1N4sRQ@mail.gmail.com>
In-Reply-To: <CAEXTbpfh3aKS8DZ9T0KPNLfWJ4EsLxcJpP8aLYU-iQYC1N4sRQ@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 14 Jun 2022 09:58:59 -0700
Message-ID: <CACeCKafeJ40y2LYsEm4Z2pRMxzM6W+VcC1F95oFqNq+xokPWUQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] drm/bridge: anx7625: Add typec_mux_set callback function
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Jonas Karlman <jonas@kwiboo.se>,
        swboyd@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Xin Ji <xji@analogixsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Foss <robert.foss@linaro.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 2:08 AM Pin-yen Lin <treapking@chromium.org> wrote:
>
> Hi AngeloGioacchino,
>
>
> On Tue, Jun 14, 2022 at 4:15 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 09/06/22 20:09, Prashant Malani ha scritto:
> > > From: Pin-Yen Lin <treapking@chromium.org>
> > >
> > > Add the callback function when the driver receives state
> > > changes of the Type-C port. The callback function configures the
> > > crosspoint switch of the anx7625 bridge chip, which can change the
> > > output pins of the signals according to the port state.
> > >
> > > Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >
> > > Changes since v2:
> > > - No changes.
> > >
> > >   drivers/gpu/drm/bridge/analogix/anx7625.c | 58 +++++++++++++++++++++++
> > >   drivers/gpu/drm/bridge/analogix/anx7625.h | 13 +++++
> > >   2 files changed, 71 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index d41a21103bd3..2c308d12fab2 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > @@ -15,6 +15,7 @@
> > >   #include <linux/regulator/consumer.h>
> > >   #include <linux/slab.h>
> > >   #include <linux/types.h>
> > > +#include <linux/usb/typec_dp.h>
> > >   #include <linux/usb/typec_mux.h>
> > >   #include <linux/workqueue.h>
> > >
> > > @@ -2582,9 +2583,66 @@ static void anx7625_runtime_disable(void *data)
> > >       pm_runtime_disable(data);
> > >   }
> > >
> > > +static void anx7625_set_crosspoint_switch(struct anx7625_data *ctx,
> > > +                                       enum typec_orientation orientation)
> > > +{
> > > +     if (orientation == TYPEC_ORIENTATION_NORMAL) {
> > > +             anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
> > > +                               SW_SEL1_SSRX_RX1 | SW_SEL1_DPTX0_RX2);
> > > +             anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
> > > +                               SW_SEL2_SSTX_TX1 | SW_SEL2_DPTX1_TX2);
> > > +     } else if (orientation == TYPEC_ORIENTATION_REVERSE) {
> > > +             anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
> > > +                               SW_SEL1_SSRX_RX2 | SW_SEL1_DPTX0_RX1);
> > > +             anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
> > > +                               SW_SEL2_SSTX_TX2 | SW_SEL2_DPTX1_TX1);
> > > +     }
> > > +}
> > > +
> > > +static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
> > > +{
> > > +     if (ctx->typec_ports[0].dp_connected && ctx->typec_ports[1].dp_connected)
> > > +             /* Both ports available, do nothing to retain the current one. */
> > > +             return;
> > > +     else if (ctx->typec_ports[0].dp_connected)
> > > +             anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_NORMAL);
> > > +     else if (ctx->typec_ports[1].dp_connected)
> > > +             anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_REVERSE);
> > > +}
> > > +
> > >   static int anx7625_typec_mux_set(struct typec_mux_dev *mux,
> > >                                struct typec_mux_state *state)
> > >   {
> > > +     struct anx7625_port_data *data = typec_mux_get_drvdata(mux);
> > > +     struct anx7625_data *ctx = data->ctx;
> > > +     struct device *dev = &ctx->client->dev;
> > > +
> > > +     bool old_dp_connected = (ctx->typec_ports[0].dp_connected ||
> > > +                              ctx->typec_ports[1].dp_connected);
> >
> > So the old connection state is "either port0 or port1 are currently connected"...
> >
> > > +     bool new_dp_connected;
> > > +
> > > +     if (ctx->num_typec_switches == 1)
> > > +             return 0;
> > > +
> > > +     dev_dbg(dev, "mux_set dp_connected: c0=%d, c1=%d\n",
> > > +             ctx->typec_ports[0].dp_connected, ctx->typec_ports[1].dp_connected);
> > > +
> > > +     data->dp_connected = (state->alt && state->alt->svid == USB_TYPEC_DP_SID &&
> > > +                           state->alt->mode == USB_TYPEC_DP_MODE);
> > > + > + new_dp_connected = (ctx->typec_ports[0].dp_connected ||
> > > +                         ctx->typec_ports[1].dp_connected);
> >
> > ...and the new connection state is the same as the old one, because I don't see
> > anything that could ever modify it in this function's flow, until reaching this
> > assignment.
>
> The typec mux driver data (`struct anx7625_port_data *data =
> typec_mux_get_drvdata(mux)`) is set to one of the
> `ctx->typec_ports[*]` in `anx7625_register_mode_switch` (see patch 6
> of this series).
>
> So, the `data->dp_connected = ...` assignment may change the new
> connection state.

Angelo, I think your interpretation of this logic is not accurate..
|old_dp_connected| represents *whether* port1 or port0 has a DP
partner connected, not that *either* of them has it.

So, this logic looks OK to me.


>
> Best regards,
> Pin-yen
>
> >
> > > +
> > > +     /* dp on, power on first */
> > > +     if (!old_dp_connected && new_dp_connected)
> > > +             pm_runtime_get_sync(dev);
> >
> > ...so that will never happen...
> >
> > > +
> > > +     anx7625_typec_two_ports_update(ctx);
> > > +
> > > +     /* dp off, power off last */
> > > +     if (old_dp_connected && !new_dp_connected)
> > > +             pm_runtime_put_sync(dev);
> >
> > ...and same here.
> >
> > Regards,
> > Angelo
