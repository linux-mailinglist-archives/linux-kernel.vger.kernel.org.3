Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4FA463ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbhK3QE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbhK3QE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:04:58 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F047DC061574;
        Tue, 30 Nov 2021 08:01:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C395B2FD;
        Tue, 30 Nov 2021 17:01:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638288096;
        bh=POUwBtwosKCmIuxwL/N5NWOX8eiFjMZqcdm5W7Euacc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Emr9lYRHm93b77sOv0iiFrbyIboO+Z+H2a7H7yY9UZmJ760Xt2oIZo/iCaQfSF7nX
         vzN9rC1jegnUKyPR97Ryq99Uq6HhUMK8w7JuTTBtJiq+23+AtI6uJ8nny2d5tM8x7Y
         TomXjVZfue2UCDPqSL6qn1A231dLjRn3S/S+dqbI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMty3ZA3rTqkPtmC2yBq8zSExGd9jRjOPR06tpt2fB_AXHRxdQ@mail.gmail.com>
References: <20211126101518.938783-1-kieran.bingham+renesas@ideasonboard.com> <20211126101518.938783-5-kieran.bingham+renesas@ideasonboard.com> <CAMty3ZA3rTqkPtmC2yBq8zSExGd9jRjOPR06tpt2fB_AXHRxdQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm: rcar-du: mipi-dsi: Support bridge probe ordering
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
To:     Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 30 Nov 2021 16:01:33 +0000
Message-ID: <163828809390.3059017.11403962735628365262@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Quoting Jagan Teki (2021-11-30 07:38:57)
> Hi Kieran,
>=20
> On Fri, Nov 26, 2021 at 3:45 PM Kieran Bingham
> <kieran.bingham+renesas@ideasonboard.com> wrote:
> >
> > The bridge probe ordering for DSI devices has been clarified and further
> > documented in
> >
> > To support connecting with the SN65DSI86 device after commit c3b75d4734=
cb
> > ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe"),
> > update to the new probe ordering to remove a perpetual -EPROBE_DEFER
> > loop between the two devices.
> >
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > ---
> >  drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c | 48 +++++++++++++------------
> >  1 file changed, 26 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/=
rcar-du/rcar_mipi_dsi.c
> > index 833f4480bdf3..f783bacee8da 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> > @@ -639,6 +639,8 @@ static int rcar_mipi_dsi_host_attach(struct mipi_ds=
i_host *host,
> >                                         struct mipi_dsi_device *device)
> >  {
> >         struct rcar_mipi_dsi *dsi =3D host_to_rcar_mipi_dsi(host);
> > +       struct drm_panel *panel;
> > +       int ret;
> >
> >         if (device->lanes > dsi->num_data_lanes)
> >                 return -EINVAL;
> > @@ -646,12 +648,36 @@ static int rcar_mipi_dsi_host_attach(struct mipi_=
dsi_host *host,
> >         dsi->lanes =3D device->lanes;
> >         dsi->format =3D device->format;
> >
> > +       ret =3D drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &p=
anel,
> > +                                         &dsi->next_bridge);
> > +       if (ret) {
> > +               dev_err_probe(dsi->dev, ret, "could not find next bridg=
e\n");
> > +               return ret;
> > +       }
> > +
> > +       if (!dsi->next_bridge) {
> > +               dsi->next_bridge =3D devm_drm_panel_bridge_add(dsi->dev=
, panel);
> > +               if (IS_ERR(dsi->next_bridge)) {
> > +                       dev_err(dsi->dev, "failed to create panel bridg=
e\n");
> > +                       return PTR_ERR(dsi->next_bridge);
> > +               }
> > +       }
>=20
> Can we use the new function devm_drm_of_get_bridge instead of the entire =
code?

I've just tried this, and it works, so yes we can.
I'll update the branch and re-send it for Laurent to collect and
apply/squash whichever works best.

Thanks.

Kieran



>=20
> Jagan.
