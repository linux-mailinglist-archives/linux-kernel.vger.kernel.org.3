Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE746537C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351660AbhLARGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbhLARGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:06:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB314C061574;
        Wed,  1 Dec 2021 09:02:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B01CAB82047;
        Wed,  1 Dec 2021 17:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84061C53FCC;
        Wed,  1 Dec 2021 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638378168;
        bh=CvHtrXfgBU4nCjU0B0+DUSu63UaEebLTtzXAzA4qmq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSi8vBwTLTb2mtXwaqcm1aN8fQhZZXHxwRfVIv3Ph+E+KA80w09id79HSoWdMxh52
         Le083FK28TbGxOEYGbMSHTxk2sjdp40ebUWMOBZZ4McGEDNBV0CCawssYOcsYaM0qG
         cTyMKkw9UX17F3DG7cc5qHLBbPXtGm4oa2q3ex6HUWHd7IP/yRFypKJQfxTKkhsl4M
         O5Nz/iDP0+6EUK2mnTmAOoIKBKACBTUooxsJX8TzlAVxgS4aBBCnd4a33nF+5H8fGS
         mTG5ucT7w1HynJIwfHZhg7pk9b2haywLl+H4vMJGZaJfHZ4Wnou80e1ZWGDkUEVAh4
         0fjdkTRY9HnNQ==
Date:   Wed, 1 Dec 2021 17:02:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Boddie <paul@boddie.org.uk>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v10 4/8] drm/ingenic: Add dw-hdmi driver for jz4780
Message-ID: <YaeqrhJg4664Tr/y@sirena.org.uk>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Boddie <paul@boddie.org.uk>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <cover.1638307601.git.hns@goldelico.com>
 <4daf0c5dbed2c47c97003ab8de0a7dbd2a335dc3.1638307601.git.hns@goldelico.com>
 <LKTF3R.YREPOCHOSMQN2@crapouillou.net>
 <Yad69aTXcGixXvy3@sirena.org.uk>
 <46070A95-0FA9-43F9-A9A9-52A7B58B88F5@goldelico.com>
 <EDWF3R.CMVWMJL42OH9@crapouillou.net>
 <58C550A4-A21E-47BA-8BAE-00B927DC7A2E@goldelico.com>
 <YaeQW/akoLE6SpEi@sirena.org.uk>
 <3174DA41-EB38-4C30-8752-0D9C894C74A7@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="06/7sdeAneQqaZKj"
Content-Disposition: inline
In-Reply-To: <3174DA41-EB38-4C30-8752-0D9C894C74A7@goldelico.com>
X-Cookie: All true wisdom is found on T-shirts.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--06/7sdeAneQqaZKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 01, 2021 at 05:53:03PM +0100, H. Nikolaus Schaller wrote:
> > Am 01.12.2021 um 16:10 schrieb Mark Brown <broonie@kernel.org>:

> > Again, if the supply can be physically absent that is a sensible use
> > case but that means completely absent, not just not software
> > controllable.  We can represent fixed voltage regulators just fine.

> The question may be how we can know for a more generic driver that there is always a regulator.
> In the present case we know the schematics but it is just one example.

The datasheet will generally explicitly call out if a supply can be
disconnected.  In general it is astonishingly rare for this to be the
case, supporting that case will tend to make designing the chip harder
(you have to cope with what happens where the power domains meet) and
results in whatever functionality the supplies power not working.  If
not otherwise specified it's safer to assume that the supplies must be
connected.

--06/7sdeAneQqaZKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGnqq0ACgkQJNaLcl1U
h9AiKgf6A1p3c1dtOyuPYAkfziLEMTL656L/Ng0sT/e9yjZ9D6KPZxQqSYqZJI2F
AxQcNhi9BBM7R94mawqJ6jekuZZ0RJoVo2iPJYWJ/vM36tq01U1SeojIamTmD1LN
IF4vSf9paAEB6kQGTW1WB9onUyNpaIyz358HSRZ6FzxP/9W1qVhuCgw2M16JPM5G
wFd64VVU8pyBLxa8glflmm8MGFaeKBqkNFJBSnRG2kX79RRtaVeX8wN6niXIsGQp
T7Uv+fFGAT+w315hhRUx10oTaZNghDPE6dYLm6SaV4fqYqhIFspHZ9GsOLPvDDvC
E4+8AFtE7h0IearW001RSgvJHmQFiw==
=8Z88
-----END PGP SIGNATURE-----

--06/7sdeAneQqaZKj--
