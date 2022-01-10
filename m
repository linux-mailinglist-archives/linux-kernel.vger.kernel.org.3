Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB0C489F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbiAJSoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:44:21 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56948 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbiAJSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:44:20 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7D4E61C0B76; Mon, 10 Jan 2022 19:44:19 +0100 (CET)
Date:   Mon, 10 Jan 2022 19:44:19 +0100
From:   Pavel Machek <pavel@denx.de>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv()
 recursively
Message-ID: <20220110184418.GE3396@duo.ucw.cz>
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110094711.8574-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2f338a37-f2ca-33e4-284e-5d263f7b93da@intel.com>
 <CA+V-a8vz25B=cw_C4YMBRdDxeq7mi8Zc+noqpdHqfMP8eNHYFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <CA+V-a8vz25B=cw_C4YMBRdDxeq7mi8Zc+noqpdHqfMP8eNHYFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On 2022-01-10 10:47 AM, Lad Prabhakar wrote:
> > > Instead of recursively calling rz_ssi_pio_recv() use a while loop
> > > to read the samples from RX fifo.
> >
> > Recursion and loops are means for doing something repeatedly. Could you
> > specify _why_ such change was made i.e. the conversion from one method
> > into the other? I bet the code is not being changed for the sake of
> > changing it, the reason is simply missing in the commit message.
> >
> I had feedback from Pavel "recursion is unwelcome in kernel due to
> limited stack use." which I did agree with as a result I have come up
> with this patch. Also to add this driver will later be used on Renesas
> RZ/A2 SoC's which runs with limited memory.
>=20
> > Please note that refactoring below function into while-loop has a side
> > effect: everything had to be indented by additional tab. Generally,
> > readability increases if function is shaped 'linearly'.
> >
> I do agree, my initial patch just added a jump back to the start of
> the function if there are more samples, but Biju suggested to use a
> while loop instead.

Yes, loop is better.

I'd actually do while(true) and avoid using the done variable.

    if (!(!frames_left && fifo_samples >=3D runtime->channels))
              break;

will do the trick. Better yet, do

    if (frames_left || fifo_samples < runtime->channels)
              break;

because double negation is quite confusing and looks like typo.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYdx+ggAKCRAw5/Bqldv6
8iWeAJwMFgmovkkcykQkiCov9xgLKwcKjACfRihbqO9B2VDa06HpO5bEfLl222U=
=AYcv
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
