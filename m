Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E036759FE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiHXP1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiHXP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:27:03 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C7F9A684
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:27:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 9567D2B05F68;
        Wed, 24 Aug 2022 11:26:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Aug 2022 11:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1661354784; x=1661361984; bh=uVniGVlvs8
        /VCkoClJeb3GLOoc5DfbVlVeAGhJHYCzs=; b=ZohUdrdOe6oHquhp58vsz1bBKW
        7PpFcRZvPL5/30O13xXZ48fKIdvUtvG1UHo0EH0udeCa46ANWX4agHz7Hlw2ABGT
        +y6ATFBQDrmjhbqhDXs1KzWTURdH+I+3335K1QvFAEqphvIn7LfEMwRq5JZzfRrx
        7HbXlTKMvyZWvBYXr4Rj9wse/5oVSKL8xLfYnulgrEyyoJqRa9QkdgI12kTmoPz5
        +2qmb9ao+VNVrwDGxjkPNigJ6InaXp2U/CMi/D6/Kh6JcQncYn/upOydSlOr6Rn3
        ps5WU3KRW1mK7R6a91x9uZqjx8564kP6YWr6+pazwtun/+n3xPuKAJkP5eFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661354784; x=1661361984; bh=uVniGVlvs8/VCkoClJeb3GLOoc5D
        fbVlVeAGhJHYCzs=; b=CRNsZc8gHQ+ZxkLfpS8/NSRYjUVZVWKX2CXvZ4lWxP2+
        1We9Nm3TLIk9jbAQi/o4euGDgaGFMI07Hym7GVkcxJ86s916UPcq5uvETrct85lD
        eclNGZwxOIwiaRaSPagxYjSgqJPVuhjTBOKQDyCFDpkO/r50+ZbcayVbZnf/o2i4
        TQ+SS7HtgbmZmLKcIRhuX0SaVtQKOmUw0D8DoB+abdUttrA3khr/NFqaL2uRTeWW
        k4FjjhLkPEEOXDL0FVTfVi2/vtw5O/8zLmTx5otNnOdWO7yuyY9cwFHrIuObc9Na
        NY+ceIMklapWHCgXIbrqkETFeFowp0eyRomr3lnjPQ==
X-ME-Sender: <xms:HkMGY8agO_-jhd4QU6iPe3aZHqTr6emyQdqVIRQy90KXIFbqP7BJrw>
    <xme:HkMGY3Z0U3GE7huOj7noW7F0UAJeFHLV6_OouX2UTRaWQDvwwWnVSxsj59xsqDD4w
    ZYa-W3438YmSKov2yo>
X-ME-Received: <xmr:HkMGY2_yUuOCnekxGXtiJPXMeTKHxRqIaSfdRTw0OggrGbTaY13siGk56EOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:HkMGY2pfWFVL7uoXenkx6Oc-CrvJOOHFiapBidIWT-bFPSNV3adPMA>
    <xmx:HkMGY3qgVdqGXAr4tQgVDuDcQC9KWpZ90-1INqNikiUnT-3Var2vqQ>
    <xmx:HkMGY0SMASJWYckG-Hnzj7JtOEAsG4lZVKe4bP7RyOTALmO0WM6R7g>
    <xmx:IEMGYwaW3uSisxgPNxzG9eOSephDxqJrulTyfenRj7pLUPrvVsK3UHzwRQ8>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Aug 2022 11:26:21 -0400 (EDT)
Date:   Wed, 24 Aug 2022 17:26:19 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH v1 23/35] drm/vc4: vec: Convert to the new TV mode
 property
Message-ID: <20220824152619.5def5b2puj5b2a3o@houat>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-23-3d53ae722097@cerno.tech>
 <0255f7c6-0484-6456-350d-cf24f3fee5d6@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="36wi22d63kleuedj"
Content-Disposition: inline
In-Reply-To: <0255f7c6-0484-6456-350d-cf24f3fee5d6@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--36wi22d63kleuedj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 20, 2022 at 07:22:48PM +0200, Noralf Tr=F8nnes wrote:
> Den 29.07.2022 18.35, skrev Maxime Ripard:
> > Now that the core can deal fine with analog TV modes, let's convert the=
 vc4
> > VEC driver to leverage those new features.
> >=20
> > We've added some backward compatibility to support the old TV mode prop=
erty
> > and translate it into the new TV norm property.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >=20
> > diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_ve=
c.c
>=20
> >  static int vc4_vec_connector_get_modes(struct drm_connector *connector)
> >  {
> > -	struct drm_connector_state *state =3D connector->state;
> >  	struct drm_display_mode *mode;
> > =20
> > -	mode =3D drm_mode_duplicate(connector->dev,
> > -				  vc4_vec_tv_modes[state->tv.mode].mode);
> > +	mode =3D drm_mode_duplicate(connector->dev, &drm_mode_480i);
> > +	if (!mode) {
> > +		DRM_ERROR("Failed to create a new display mode\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	drm_mode_probed_add(connector, mode);
> > +
> > +	mode =3D drm_mode_duplicate(connector->dev, &drm_mode_576i);
>=20
> Maybe the mode that matches tv.norm should be marked as preferred so
> userspace knows which one to pick?

I'm not sure how realistic that would be. Doing this based on the driver
/ cmdline preference is going to be fairly easy, but then it's a
property, it's going to be updated, and we probably don't want to mess
around the mode flags based on new property values?

Maxime

--36wi22d63kleuedj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYwZDGwAKCRDj7w1vZxhR
xe5DAP9Z+ZFY+aCR73/Vff7dgZ2qWrSVvFjPY8E7F+CacQmV8wEA7ngIetY5PT9h
6Cpd1zevB5ugZR1rHGjakT3tMaM5Vgo=
=YI0f
-----END PGP SIGNATURE-----

--36wi22d63kleuedj--
