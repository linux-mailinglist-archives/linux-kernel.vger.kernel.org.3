Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95544DDED6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbiCRQ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiCRQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:26:16 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D409930A8A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:22:49 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 007A81BF210;
        Fri, 18 Mar 2022 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647620567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uq2Qb6X27nCUYPdksuv5fbn1CZt7KpmCpCYAg/lInrg=;
        b=LbSnPI7pRGqTUSOKD0jO6k4zWroEBNFLISuo6CaFiwsyBVk9IplOhpe4ouPIBiI4wTMXKz
        Hnu/jlaDys4kDh7J0qEhMNmDsAs6B7WHgFkwTwyNnl4npUOaeW9PEwqwNIGBES34t4qR89
        XR2xNA/aZTMLrWt1PMQqyrbS9zULl6faeFeccl2KhwYrApmN/CfkHYrNgiETK4XvDeEYUE
        apBkdNAn8miJsHlhHrme6dhQVibvnfbCTwYoMJgMWzgLEweHdkpTbBDJV2fReJIJGjwsns
        tyhl9839J7f9W28U3qz1jIq8tWIVeqWY6sk9BhXpM4onJ63efi7SNs25jtTh6Q==
Date:   Fri, 18 Mar 2022 17:22:46 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] drm: of: Properly try all possible cases for
 bridge/panel detection
Message-ID: <YjSx1rNLTh/L3MQQ@aptenodytes>
References: <20220318160249.126431-1-paul.kocialkowski@bootlin.com>
 <20220318161847.ezi6yat4on7rvfdf@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qzk6y2i25Ocz8kr4"
Content-Disposition: inline
In-Reply-To: <20220318161847.ezi6yat4on7rvfdf@houat>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qzk6y2i25Ocz8kr4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Fri 18 Mar 22, 17:18, Maxime Ripard wrote:
> On Fri, Mar 18, 2022 at 05:02:49PM +0100, Paul Kocialkowski wrote:
> > While bridge/panel detection was initially relying on the usual
> > port/ports-based of graph detection, it was recently changed to
> > perform the lookup on any child node that is not port/ports
> > instead when such a node is available, with no fallback on the
> > usual way.
> >=20
> > This results in breaking detection when a child node is present
> > but does not contain any panel or bridge node, even when the
> > usual port/ports-based of graph is there.
> >=20
> > In order to support both situations properly, this commit reworks
> > the logic to try both options and not just one of the two: it will
> > only return -EPROBE_DEFER when both have failed.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Fixes: 80253168dbfd ("drm: of: Lookup if child node has panel or bridge=
")
> > ---
> >=20
> > Changes since v1:
> > - Renamed remote to node;
> > - Renamed helper to find_panel_or_bridge;
> > - Cleared bridge pointer early;
> > - Returned early to make the code more concise;
> >=20
> > ---
> >  drivers/gpu/drm/drm_of.c | 98 ++++++++++++++++++++--------------------
> >  1 file changed, 49 insertions(+), 49 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > index 9d90cd75c457..63137c833b7a 100644
> > --- a/drivers/gpu/drm/drm_of.c
> > +++ b/drivers/gpu/drm/drm_of.c
> > @@ -219,6 +219,28 @@ int drm_of_encoder_active_endpoint(struct device_n=
ode *node,
> >  }
> >  EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
> > =20
> > +static int find_panel_or_bridge(struct device_node *node,
> > +				struct drm_panel **panel,
> > +				struct drm_bridge **bridge)
> > +{
> > +	if (panel) {
> > +		*panel =3D of_drm_find_panel(node);
> > +		if (!IS_ERR(*panel))
> > +			return 0;
> > +		else
> > +			*panel =3D NULL;
>=20
> You don't need the else branch here, we already cleared panel in
> drm_of_find_panel_or_bridge

I think we do, because of_drm_find_panel doesn't return NULL when an error
happens but PTR_ERR(), so we need to clear it to keep up with previous
expectations.

> Looks good otherwise, thanks!

Great, thanks for the review!

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--qzk6y2i25Ocz8kr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmI0sdYACgkQ3cLmz3+f
v9FYhwf/WQ8GZXg5/AGKF3+gIauL7GFsdyj5L+GYaSZd0t+RoKtv2Voi3YZay6Yy
XoL2HpQvmcx5/iWvD3PvwzRZpy3K2fYxKAXL/sLXcvQiF+Y7veWCACaWp+KuJnVI
oq718NfVZcD5zb5vfmClMQfxhZ3TIpQULENBRpA/Cf8ybJncRSxkQ7U2MMNcw0Ds
uAr/f00z8vnI6TYhqX5ZPZY93qZoxQ5ts6WsSwv3WKK6Uiu5GI5X9VEaP+4cA8Ls
1xeuJge+qsvCtsCmxaSABAB29+uLsp0CsjI3YxdITxWk3ym1BrxnH+7fZdpLE/68
LwT429yuLMGoWVmN7nCKZufrN76bVA==
=cWfF
-----END PGP SIGNATURE-----

--qzk6y2i25Ocz8kr4--
