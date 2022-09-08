Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145DE5B1E84
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiIHNTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiIHNSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:18:40 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C1DF56E1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:18:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 3FFCB2B05BBA;
        Thu,  8 Sep 2022 09:18:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 08 Sep 2022 09:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1662643109; x=1662650309; bh=peZAPoe3RK
        R6LaA58j2Tow8y68g/d3BSYQ3Pc87XUGY=; b=HqeaMgrK3xJVh8ppUvrDkhcU1g
        lTVZG4zsSYvHWV7l0tEzslAnqCrVydvWGWhl2Crw/3itbwiFPLkJvkVYASYEZ4ym
        DWqrY7+YD7G1iFbpMjNbsXLoEbp8NSZyi42R4+9GdgIvwBUjFtzrXf+aAiY6CXpv
        NvSF7bYFOhu27KXlYOOf9vZ9K1RDfBw5HVV1gMD7FmUxA30svYp/XSrDwZtfq/q+
        Yn2Y3ywNcBO7zVvq5wNRN/Qy25584MRc8Mf8k8ArYBhYlNGMemIFE7j3u7hQ9ikn
        o9a3EGvyt3jSChl44qwm9IbkkthHKIY48L8H1/nSCBvoa7q6d1Sp9ykKIGvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662643109; x=1662650309; bh=peZAPoe3RKR6LaA58j2Tow8y68g/
        d3BSYQ3Pc87XUGY=; b=TdtDcZ7aisUC788WDuwkYn8KgU9dtcIC8lnHZ+ill3kl
        MQQydSx0N7PadO5GA0H6p3cEIICW/uDgUCIxzt+BiFwybjl4dPhcdqnKwG7Er4wD
        S6NtPDC7xt4qTX/+HQCLj7CpFeh9rDbNc7wPUsQ0d3fuOYqOuI9k6OVJANDz0GLf
        hsldkfyH9Jm9EhRGPXvDK6vvhAAvTPz5yiATXuU72kO9bfhhK/OBN18YWp9WVf14
        go/4SIqEfwPTSnaEvT1GYoqJnYKMd1REBRpog6EaQ/P3Br2w4NxEpXRkRMixEcHa
        CrAPIH9ZWiWEhSJb2kvjggQm86GiTAVKzHw31lKH3A==
X-ME-Sender: <xms:pOsZYwNWrPj2mLeJObYMt6YSnGkcD8Xe8wrtrhS8Gumrb9XsTF6TQg>
    <xme:pOsZY29tYePljP6cmi0tgOUXt3zN1GBt6_BhWrkxnk6SE-xGtyY21M3eEPJ_FO79C
    C1V4biIp_EluQWmcn0>
X-ME-Received: <xmr:pOsZY3SqgXSYaY3LP-7droYRi5CoXBVWSSh4FTHwyFqM1HGFGTXA3RTN4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtfedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeflefgheeuheelueegveefkedtgefgfeevkefggeevteefgefhkeetgeeg
    hfdtgeenucffohhmrghinhepghhithhhuhgsuhhsvghrtghonhhtvghnthdrtghomhdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:pesZY4s3LRqSUcrFAmNQ1HgBQvX5sgpPjGON7SC8Mvc_3wFIv5sXHA>
    <xmx:pesZY4dMj78RnwKJdrCTlc6wYbs5qWt_INAFQrmEk9-BTaCeK90svQ>
    <xmx:pesZY817H27Fc7Zo_5vHAauR5wo8vXoNImMTM-OT6pM9Z3UGl0A3nw>
    <xmx:pesZYxOTFCWxesckTdcpa5a3R7c8JvOdfP-Kw6T-XEt0C3Ix8KyAFQxacZ8>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Sep 2022 09:18:28 -0400 (EDT)
Date:   Thu, 8 Sep 2022 15:18:24 +0200
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
Subject: Re: [PATCH v2 32/41] drm/vc4: vec: Convert to the new TV mode
 property
Message-ID: <20220908131824.jjbnh2wzhj3gkutz@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-32-459522d653a7@cerno.tech>
 <c8f8015a-75da-afa8-ca7f-b2b134cacd16@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oe4rmkonoj7og4p4"
Content-Disposition: inline
In-Reply-To: <c8f8015a-75da-afa8-ca7f-b2b134cacd16@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oe4rmkonoj7og4p4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 31, 2022 at 04:23:21AM +0200, Mateusz Kwiatkowski wrote:
> I tested your patchset on my Pi and it mostly works. Good work! However,
> I noticed a couple of issues.
>=20
> > -static int vc4_vec_encoder_atomic_check(struct drm_encoder *encoder,
> > -=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0struct drm_crtc_stat=
e *crtc_state,
> > -=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0struct drm_connector=
_state *conn_state)
> > -{
> > -=A0=A0 =A0const struct vc4_vec_tv_mode *vec_mode;
> > -
> > -=A0=A0 =A0vec_mode =3D &vc4_vec_tv_modes[conn_state->tv.mode];
> > -
> > -=A0=A0 =A0if (conn_state->crtc &&
> > -=A0=A0 =A0=A0=A0=A0 !drm_mode_equal(vec_mode->mode, &crtc_state->adjus=
ted_mode))
> > -=A0=A0 =A0=A0=A0 =A0return -EINVAL;
> > -
> > -=A0=A0 =A0return 0;
> > -}
>=20
> I may have said it myself that we should allow custom modelines without t=
oo
> much validation. The VC4 and VEC, however, have some considerable limitat=
ions
> when it comes to the modelines that they can reliably output.
>=20
> In particular, attempting to use "50 Hz" timings in NTSC/PAL-M modes (or
> "60 Hz" in PAL/SECAM modes) results in a weirdly skewed image. Here's how=
 it
> may look like:
> https://user-images.githubusercontent.com/4499762/187575940-736e7262-c82d=
-42f3-a2d8-f309cbd51139.png
>=20
> This is because if the CRTC does not trigger the sync pulses within an
> acceptable time window, the VEC apparently generates them itself. This ca=
uses
> the VEC sync pulses (which go onto the wire) not quite line up with the o=
nes
> from the modeline, which results in what you see on the screenshot.
>=20
> I once wrote a validation function based on extensive testing of what
> produces a sensible output and what doesn't. You can find it here:
> https://github.com/raspberrypi/linux/pull/4406/commits/15c0c51. I think it
> might be a good idea to include something like that - even though I know =
it's
> somewhat ugly.

I've reworked that code a bit, and it will be part of my next version.

> (BTW, those %2 checks on vertical timings in that linked commit can be ig=
nored;
> those values are divided by 2 for interlaced modes anyway. Those checks w=
ere
> intended to ensure proper odd-first or even-first timings; I'm not sure i=
f your
> code calculates those in the same way)

Ack, I've removed them.

> >=A0 static int vc4_vec_connector_get_modes(struct drm_connector *connect=
or)
> >=A0 {
> > -=A0=A0 =A0struct drm_connector_state *state =3D connector->state;
> > =A0=A0=A0 =A0struct drm_display_mode *mode;
> > +=A0=A0 =A0int count =3D 0;
> > =A0
> > -=A0=A0 =A0mode =3D drm_mode_duplicate(connector->dev,
> > -=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 vc4_vec_tv_modes[state->tv=
=2Emode].mode);
> > +=A0=A0 =A0mode =3D drm_mode_analog_ntsc_480i(connector->dev);
> > =A0=A0=A0 =A0if (!mode) {
> > =A0=A0=A0 =A0=A0=A0 =A0DRM_ERROR("Failed to create a new display mode\n=
");
> > =A0=A0=A0 =A0=A0=A0 =A0return -ENOMEM;
> > =A0=A0=A0 =A0}
> > =A0
> > =A0=A0=A0 =A0drm_mode_probed_add(connector, mode);
> > +=A0=A0 =A0count +=3D 1;
> > =A0
> > -=A0=A0 =A0return 1;
> > +=A0=A0 =A0mode =3D drm_mode_analog_pal_576i(connector->dev);
> > +=A0=A0 =A0if (!mode) {
> > +=A0=A0 =A0=A0=A0 =A0DRM_ERROR("Failed to create a new display mode\n");
> > +=A0=A0 =A0=A0=A0 =A0return -ENOMEM;
> > +=A0=A0 =A0}
> > +
> > +=A0=A0 =A0drm_mode_probed_add(connector, mode);
> > +=A0=A0 =A0count +=3D 1;
> > +
> > +=A0=A0 =A0return count;
> > +}
>=20
> Xorg is pretty confused by these modes being reported like that. The 576i=
 mode
> is *always* preferred, presumably because of the higher resolution. If th=
e NTSC
> mode is set (via the kernel cmdline or just due to it being the default),=
 this
> results in a mess on the screen - exactly the same thing as on the screen=
shot
> linked above.
>=20
> Note that drm_helper_probe_add_cmdline_mode() *does* add the
> DRM_MODE_TYPE_USERDEF flag to the 480i mode, having detected it as prefer=
red
> on the command line - but Xorg does not seem to care about that.

I'm not quite sure why that would be the case. The usual logic to pick
the preferred mode is to use either the mode with the flag or the first
one.

> I remember Noralf suggesting setting DRM_MODE_TYPE_PREFERRED for the mode=
 that
> corresponds to the currently chosen tv_mode - that would fix the problem.
> An alternative would be to _not_ add the "opposite" mode at all, like the
> current default Raspberry Pi OS kernel behaves.

I'll add it the PREFERRED flag then, switching the modes have other
challenges.

Maxime

--oe4rmkonoj7og4p4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYxnroAAKCRDj7w1vZxhR
xdi7AQCzv8VgoLgusukooavi5uzzw2ozZ+Tftp0NswFipI6XtAEAxsDX9XhrvZAd
1mdv6bmwrkQ6l0bFk912Wm89BuSHnAc=
=vZff
-----END PGP SIGNATURE-----

--oe4rmkonoj7og4p4--
