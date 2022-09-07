Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30245B070A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIGOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiIGOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:34:38 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8753DF10
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:34:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1F2A25804F0;
        Wed,  7 Sep 2022 10:34:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Sep 2022 10:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1662561267; x=1662568467; bh=JgmI+KGSUN
        45Wie/3+bjGkbyz5oOCqNiJe6kdug5myc=; b=fEOSeRjgEOD6B/j91iz7LAm2nV
        zm9is7Er/ViHIxBpgpZb6lwibFClewD+iIDcvBDRp+1lmhPCyaLqGg7IA7cP8Xoc
        wuPl4RWLG7DFN/l8Ef3DsxfT1cd2zQLRfIYCirzpNWoWvJn1u1DHeJKGdSUDI28z
        1jY0sVontbTSiey/BmEiACSSDUwkweDEP8Y88zWm/rexWHXi4G8cMuE0k+2Ubav8
        yVcnkHbvjTtEanw7DdeSQbMbBEQZUlGAaHFddXqW8+k9yjnOhCF7l9h878Ua8DYW
        sgayo4HxqN7j7DCzmcPR4NNETP7WQrV7L9DlqdV2OvKcqO+2mZ+6pYjLKaNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662561267; x=1662568467; bh=JgmI+KGSUN45Wie/3+bjGkbyz5oO
        CqNiJe6kdug5myc=; b=QZsve74EP24R9KWs9WZsCIVkxBNujxPG60TN9puqze3c
        o6aNhrxKdPVbGh09EQgmTIu30mCjSkY9oBqwNWg3cRbVT9CSGDTSlxglGLwGruZV
        vARWixq4SBADNaeBNbJTGCIG9odD6/9WAWxTk4aOKFPICop9IO3pcwWu9wND5de0
        WZ78qWyg0sbruHsLAn0/vTLXw7MuMI08liDizfiz6oJ2b/8T5ZAp2EpYm9J/sOJe
        0O49dbliLK8gjn2pXV+ferzud7lC4N6BLE7ZvbYFTFT4O8aQGL1u1rHr3lvb7iPF
        JbqQ9W8hlaP3qBDs1foUJk1yTi+UzY3FpobNfifkdg==
X-ME-Sender: <xms:8asYY4UgApzFGk9lMU7_nB2tWkGa-AKoUUX0oWcDTS3CdqsvjWxehQ>
    <xme:8asYY8lyse5NlxOdtYZKWaUhjBYfIlgc_PNXrFKciTAfjC7Qq3BrGgdaXexQF6IP4
    _6htb6-rtuvaukNo78>
X-ME-Received: <xmr:8asYY8bNWiVMW6b0ICPcNAd1PBwNiJxeN_uWlug667bo_bseyV1obT25lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:8asYY3Xt9CeqTnWDGGVrJ5rcfLCxdynDN_Tuorur4XGq8TurhI9oRQ>
    <xmx:8asYYyn9v6pcPCPNk57ZF5sdNBvLCg3Mk5yuVjBTh0eo0nyrpqcTzA>
    <xmx:8asYY8c85KGolaoPe5xQ-55tOyvH3qzMK8bWQUHa7IIVjNag736Oyg>
    <xmx:86sYYw1Zv4Xn3p-SugSX5mxaWqbdQ2rTIZf99SeXJOpnlS5zi1wgMQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 10:34:24 -0400 (EDT)
Date:   Wed, 7 Sep 2022 16:34:21 +0200
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
Subject: Re: [PATCH v2 10/41] drm/modes: Add a function to generate analog
 display modes
Message-ID: <20220907143421.4iopqwhp3yfircsh@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-459522d653a7@cerno.tech>
 <242d272b-5b79-986c-9aaf-64e62f6b37ff@gmail.com>
 <20220905133755.gcmmntg3wnecyqjq@houat>
 <10ce686a-d7c8-9ce4-3979-735ad8eab3b5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xs3njf2uogpsrjq3"
Content-Disposition: inline
In-Reply-To: <10ce686a-d7c8-9ce4-3979-735ad8eab3b5@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xs3njf2uogpsrjq3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2022 at 06:44:42PM +0200, Mateusz Kwiatkowski wrote:
> Hi Maxime,
>=20
> W dniu 5.09.2022 o 15:37, Maxime Ripard pisze:
> >>> +=A0=A0=A0 vfp =3D vfp_min + (porches_rem / 2);
> >>> +=A0=A0=A0 vbp =3D porches - vfp;
> >>
> >> Relative position of the vertical sync within the VBI effectively move=
s the
> >> image up and down. Adding that (porches_rem / 2) moves the image up of=
f center
> >> by that many pixels. I'd keep the VFP always at minimum to keep the im=
age
> >> centered.
> >
> > And you would increase the back porch only then?
>=20
> Well, increasing vbp only gives a centered image with the default 480i/57=
6i
> resolutions. However, only ever changing vbp will cause the image to be a=
lways
> at the bottom of the screen when the active line count is decreased (e.g.
> setting the resolution to 720x480 but for 50Hz "PAL" - like many game con=
soles
> did back in the day).
>=20
> I believe that the perfect solution would:
>=20
> - Use the canonical / standard-defined blanking line counts for the stand=
ard
> =A0 vertical resolutions (480/486/576)
> - Increase vfp and vbp from there by the same number if a smaller number =
of
> =A0 active lines is specified, so that the resulting image is centered
> - Likewise, decrease vfp and vbp by the same number if the active line nu=
mber
> =A0 is larger and there is still leeway (this should allow for seamless h=
andling
> =A0 of 480i vs. 486i for 60 Hz "NTSC")

I'm not sure I understand how that's any different than the code you
initially commented on.

I would start by taking the entire blanking area, remove the sync
period. We only have the two porches now, and I'm starting from the
minimum, adding as many pixels in both (unless it's not an even number,
in which case the backporch will have the extra pixel).

Isn't it the same thing?

> - If even more active lines are specified, once the limit for vfp is hit,=
 then
> =A0 decrease vbp only - the resulting image will definitely be off-center=
, but
> =A0 there's no other way

Unless you only want me to consider the front porch maximum?

Maxime

--xs3njf2uogpsrjq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYxir7QAKCRDj7w1vZxhR
xYnUAQDKFDkrZV/fLpjtD+btaCpKvPKkEUm37bnBk3TyD3SBTAD+I0kVAytjVinQ
y5KTIrc3dKg0llXX1SWgrvw0OE2vMAI=
=QW9g
-----END PGP SIGNATURE-----

--xs3njf2uogpsrjq3--
