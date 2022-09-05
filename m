Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3F15AD4CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiIEO3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiIEO25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:28:57 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869CB5AA06
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:28:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BD5585801E7;
        Mon,  5 Sep 2022 10:28:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 05 Sep 2022 10:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1662388128; x=1662395328; bh=vefUy4dRsZ
        VWF0YIrw3msOYzL5sGqxLnWRwOjKgBDrQ=; b=K2XS8PGlr2rLCbhGAhNKVV1mKa
        oE5a/DxS0PxYT09GHAoeKfQb2EbQCJ9mu4w58MqnAKA1v9KKxxsiYAxH7YOsy1BN
        33JRgsa8h4OHegIECgAC9cSpyUMc/Lo2C5mNrEChFfPna0d7iS4gIrwUted9CHx7
        qbnimRJOdwi2we5OgCLd/60A+k3wyzn4j3TdiHlGFcBFcI08cKnqIx93lEL+bLCT
        CqAKbzWub2maQ+RaEAZeMK1h2/Od9syCt1Oc4Z5nD1+HayHeRoUYskPKsrsmSzCh
        e3N7WD2rFsuM/GYBLynULlDETMkMlutJu524iww9KxGAYCF5MtrBhwWigXQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662388128; x=1662395328; bh=vefUy4dRsZVWF0YIrw3msOYzL5sG
        qxLnWRwOjKgBDrQ=; b=YSGrRmXY76fbUtPERuSV+9e6lsEx56hA5vrGlNt2Qpgs
        zOPKczGZQJsxK88Md2RogOECuW5zwHOeJnPTijXakF/dmAlb5LGVud5m+mQe5Sl7
        Nx+dNIsVXROz/pUj6cCxv3K2uWryMWKWKGA87vjkcV2kZd3PrAyjrivRHG//4Cy0
        8npyhIOZIK0GH7J2zQzX6NbvhdhETzfHNoxutJTlJzbT/hn62C0tzHeBHUXEmf+L
        nIWXmDFc1kwRBghV8udUcYftvhHn+v2vzmUQ7nlzQb7ok4/4d57hANxyRbucnqdL
        hJAerM1Ql35aS0OaCNwHAOYgRUdk2HE+fkLZivJ7tw==
X-ME-Sender: <xms:nwcWY7093cdWfRq1oL7PNGQ3QbK4j2DgD8slA2vtr3StBwgGGw142A>
    <xme:nwcWY6Ez3fbf7mpeixDFWX2eEq9xironQYCF1CjLV_Vykb9d2mW3Nq5tK_mX90nBc
    ToYcAdDkoXzgclW77E>
X-ME-Received: <xmr:nwcWY775XQbKfjcX_e98PD2zWRbESjZF_sRzppZfjrunik7KbWARapTpHMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeliedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:nwcWYw12b2jj41_bSVOi0TppjyxIf8LchC1b24hD7MOItMAE-N9bDQ>
    <xmx:nwcWY-G1xPGMeuA36sQ6S2FIufVxVxSWprdiwbTGxYuMmpu4v35syw>
    <xmx:nwcWYx8zfPZgx1nEtBKLuqnYkkH7Y6J0qlXcYHDdVgjRUegS2oJLNw>
    <xmx:oAcWY2VbCYUlEte486NIa6WhcoO6WH8JGlPVm3Js638-GMARhcFlug>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Sep 2022 10:28:46 -0400 (EDT)
Date:   Mon, 5 Sep 2022 16:28:42 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mateusz Kwiatkowski <kfyatek@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 19/41] drm/modes: Introduce the tv_mode property as a
 command-line option
Message-ID: <20220905142842.c3rvtupggdmavq7z@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-19-459522d653a7@cerno.tech>
 <2f607c7d-6da1-c8df-1c02-8dd344a92343@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a666jub4kxs6fn4h"
Content-Disposition: inline
In-Reply-To: <2f607c7d-6da1-c8df-1c02-8dd344a92343@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a666jub4kxs6fn4h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 02, 2022 at 12:46:29AM +0200, Mateusz Kwiatkowski wrote:
> > @@ -2212,20 +2239,22 @@ struct drm_named_mode {
> > =A0=A0=A0 =A0unsigned int xres;
> > =A0=A0=A0 =A0unsigned int yres;
> > =A0=A0=A0 =A0unsigned int flags;
> > +=A0=A0 =A0unsigned int tv_mode;
> >=A0 };
>=20
> Are _all_ named modes supposed to be about analog TV?
>
> If so, then probably this structure should be renamed drm_named_analog_tv=
_mode
> or something.

I don't think they need to, but it's the only use case we've had so far.
We could also imagine using UHD for 3840x2160 for example, so I wouldn't
say it's limited to analog tv.

> If not, then including tv_mode in all of them sounds almost dangrous. 0 i=
s a
> valid value for enum drm_connector_tv_mode, corresponding to
> DRM_MODE_TV_MODE_NTSC_443. This is a very weird default (maybe it shouldn=
't be
> the one that has a numeric value of 0?) and if there ever is a named mode=
 that
> is not related to analog TV, it looks that it will refer to NTSC-443.
>=20
> Not sure where could that actually propagate, and maybe what I'm saying c=
an't
> happen, but I'm imagining weird scenarios where a GPU that has both a
> VGA/HDMI/whatever output, and a composite output, switches to NTSC-443 on=
 the
> composite output by default because a named mode for the modern output is
> selected.

So, named modes are per-connector so the fact that there's another
output doesn't really matter. Then, the answer is quite simple actually,
the HDMI driver wouldn't register and use the TV mode property at all,
so it would completely ignore it, no matter what value it has.

So it's not really a concern.

> Maybe something like DRM_MODE_TV_MODE_NONE =3D 0 would make sense?

But I guess we can add it still.

Maxime

--a666jub4kxs6fn4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYxYHmgAKCRDj7w1vZxhR
xTGUAP9bRX6FEHBUM7XR2y0SEv7Im5MOyJ9Xu+nxahCL5Zr27gEAtUuO35mNsB/a
iZZfvcVDyPB/1iJJ1p/8F2uKg1G0pQI=
=y2zk
-----END PGP SIGNATURE-----

--a666jub4kxs6fn4h--
