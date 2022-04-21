Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E7D5098D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385646AbiDUHP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiDUHP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:15:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C517A9E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:13:06 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 70E8CE0015;
        Thu, 21 Apr 2022 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650525185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+JgFQ/ghz1TKZ1w7NZeEv/Dwh5WxIT/MjgY8evlIpp0=;
        b=g9nPdTKaH2a9QWcFiNyvmqVbdY/7Y1I66letN16pG1lS8EX6ptDvfWRqZPry4WTNGsX+Bi
        1MBpHQwWxLPq3tnXpy2YpdxP0+NBFz6Pe9OEAjbZdQrYB66I4dGXxkHAJifiLeExKCWHiR
        XVaIUZAIFhe7TxeBegxu5rhZk4ao1sI0UNjgwIYDfD5yyyoY97j8qeJWXZBSwWGgWVFKPv
        /jyUz0GvOafVOZpLXly8yI83mYwSTy/uY+NHnsQKAtoi+scTAG30BphcLnHaMNGk31WO1p
        TgG5KTyjvPYaXV1FyLulHNDS/DS3oq6Y9hTfpJInoZFxVV2Xc+D4qRo1iGqcxg==
Date:   Thu, 21 Apr 2022 09:13:02 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "drm: of: Properly try all possible cases for
 bridge/panel detection"
Message-ID: <YmED/vYsrjoc4OjC@aptenodytes>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <YmCU7YLx/+ILPptK@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rQJlfPZo3TRAh/MC"
Content-Disposition: inline
In-Reply-To: <YmCU7YLx/+ILPptK@ripper>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rQJlfPZo3TRAh/MC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed 20 Apr 22, 16:19, Bjorn Andersson wrote:
> On Wed 20 Apr 16:12 PDT 2022, Bjorn Andersson wrote:
>=20
> Sorry, I missed Jagan and Linus, author and reviewer of the reverted
> patch 2, among the recipients.

I'd be curious to have Jagan's feedback on why the change was needed in the
first place and whether an accepted dt binding relies on it.

We might be able to just keep the whole thing reverted (forever).

Paul

> Regards,
> Bjorn
>=20
> > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > bridge")' introduced the ability to describe a panel under a display
> > controller without having to use a graph to connect the controller to
> > its single child panel (or bridge).
> >=20
> > The implementation of this would find the first non-graph node and
> > attempt to acquire the related panel or bridge. This prevents cases
> > where any other child node, such as a aux bus for a DisplayPort
> > controller, or an opp-table to find the referenced panel.
> >=20
> > Commit '67bae5f28c89 ("drm: of: Properly try all possible cases for
> > bridge/panel detection")' attempted to solve this problem by not
> > bypassing the graph reference lookup before attempting to find the panel
> > or bridge.
> >=20
> > While this does solve the case where a proper graph reference is
> > present, it does not allow the caller to distinguish between a
> > yet-to-be-probed panel or bridge and the absence of a reference to a
> > panel.
> >=20
> > One such case is a DisplayPort controller that on some boards have an
> > explicitly described reference to a panel, but on others have a
> > discoverable DisplayPort display attached (which doesn't need to be
> > expressed in DeviceTree).
> >=20
> > This reverts commit '67bae5f28c89 ("drm: of: Properly try all possible
> > cases for bridge/panel detection")', as a step towards reverting commit
> > '80253168dbfd ("drm: of: Lookup if child node has panel or bridge")'.
> >=20
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/gpu/drm/drm_of.c | 99 ++++++++++++++++++++--------------------
> >  1 file changed, 49 insertions(+), 50 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > index f4df344509a8..026e4e29a0f3 100644
> > --- a/drivers/gpu/drm/drm_of.c
> > +++ b/drivers/gpu/drm/drm_of.c
> > @@ -214,29 +214,6 @@ int drm_of_encoder_active_endpoint(struct device_n=
ode *node,
> >  }
> >  EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
> > =20
> > -static int find_panel_or_bridge(struct device_node *node,
> > -				struct drm_panel **panel,
> > -				struct drm_bridge **bridge)
> > -{
> > -	if (panel) {
> > -		*panel =3D of_drm_find_panel(node);
> > -		if (!IS_ERR(*panel))
> > -			return 0;
> > -
> > -		/* Clear the panel pointer in case of error. */
> > -		*panel =3D NULL;
> > -	}
> > -
> > -	/* No panel found yet, check for a bridge next. */
> > -	if (bridge) {
> > -		*bridge =3D of_drm_find_bridge(node);
> > -		if (*bridge)
> > -			return 0;
> > -	}
> > -
> > -	return -EPROBE_DEFER;
> > -}
> > -
> >  /**
> >   * drm_of_find_panel_or_bridge - return connected panel or bridge devi=
ce
> >   * @np: device tree node containing encoder output ports
> > @@ -259,44 +236,66 @@ int drm_of_find_panel_or_bridge(const struct devi=
ce_node *np,
> >  				struct drm_panel **panel,
> >  				struct drm_bridge **bridge)
> >  {
> > -	struct device_node *node;
> > -	int ret;
> > +	int ret =3D -EPROBE_DEFER;
> > +	struct device_node *remote;
> > =20
> >  	if (!panel && !bridge)
> >  		return -EINVAL;
> > -
> >  	if (panel)
> >  		*panel =3D NULL;
> > -	if (bridge)
> > -		*bridge =3D NULL;
> > -
> > -	/* Check for a graph on the device node first. */
> > -	if (of_graph_is_present(np)) {
> > -		node =3D of_graph_get_remote_node(np, port, endpoint);
> > -		if (node) {
> > -			ret =3D find_panel_or_bridge(node, panel, bridge);
> > -			of_node_put(node);
> > -
> > -			if (!ret)
> > -				return 0;
> > -		}
> > -	}
> > =20
> > -	/* Otherwise check for any child node other than port/ports. */
> > -	for_each_available_child_of_node(np, node) {
> > -		if (of_node_name_eq(node, "port") ||
> > -		    of_node_name_eq(node, "ports"))
> > +	/**
> > +	 * Devices can also be child nodes when we also control that device
> > +	 * through the upstream device (ie, MIPI-DCS for a MIPI-DSI device).
> > +	 *
> > +	 * Lookup for a child node of the given parent that isn't either port
> > +	 * or ports.
> > +	 */
> > +	for_each_available_child_of_node(np, remote) {
> > +		if (of_node_name_eq(remote, "port") ||
> > +		    of_node_name_eq(remote, "ports"))
> >  			continue;
> > =20
> > -		ret =3D find_panel_or_bridge(node, panel, bridge);
> > -		of_node_put(node);
> > +		goto of_find_panel_or_bridge;
> > +	}
> > +
> > +	/*
> > +	 * of_graph_get_remote_node() produces a noisy error message if port
> > +	 * node isn't found and the absence of the port is a legit case here,
> > +	 * so at first we silently check whether graph presents in the
> > +	 * device-tree node.
> > +	 */
> > +	if (!of_graph_is_present(np))
> > +		return -ENODEV;
> > +
> > +	remote =3D of_graph_get_remote_node(np, port, endpoint);
> > +
> > +of_find_panel_or_bridge:
> > +	if (!remote)
> > +		return -ENODEV;
> > +
> > +	if (panel) {
> > +		*panel =3D of_drm_find_panel(remote);
> > +		if (!IS_ERR(*panel))
> > +			ret =3D 0;
> > +		else
> > +			*panel =3D NULL;
> > +	}
> > +
> > +	/* No panel found yet, check for a bridge next. */
> > +	if (bridge) {
> > +		if (ret) {
> > +			*bridge =3D of_drm_find_bridge(remote);
> > +			if (*bridge)
> > +				ret =3D 0;
> > +		} else {
> > +			*bridge =3D NULL;
> > +		}
> > =20
> > -		/* Stop at the first found occurrence. */
> > -		if (!ret)
> > -			return 0;
> >  	}
> > =20
> > -	return -EPROBE_DEFER;
> > +	of_node_put(remote);
> > +	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
> > =20
> > --=20
> > 2.35.1
> >=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--rQJlfPZo3TRAh/MC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJhA/4ACgkQ3cLmz3+f
v9Fb4ggAoQHofTAqH10pIlWgzYQipKbh4LenR5tOYkDXVrT3LCNyd3aUH4+2hhpK
eR/ALGdTtLMA9K37kzXHbCWBs9u00RFN+qpdK5jvz/v7igM0SF1pzu9Rh/nmYEPl
qmFQ0M2EOGVmQoWEqIPqUzLiBgYJ6Eun5zQBo+S8+V8egMGcyppee1yKgemRwJbW
9IihDebBMQUsdQD2A0GjkJuseGfZ8Qr9OVQ6X99yXKQrYOA6Nc7K/CLGapE8+T78
9X5QkncE4g9hYaP13SL6pgJ/JBD5wqld1PVwHQAQ+UFlWLgJqC7aibW857KCgpE3
3Hgw6spyBe1pOq/+VtNcOiL5bzOeDw==
=tRVX
-----END PGP SIGNATURE-----

--rQJlfPZo3TRAh/MC--
