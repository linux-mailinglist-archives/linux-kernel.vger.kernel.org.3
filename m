Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949F461B88
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbhK2QLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:11:23 -0500
Received: from comms.puri.sm ([159.203.221.185]:54158 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242882AbhK2QJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:09:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id AB8EEE10FA;
        Mon, 29 Nov 2021 08:05:33 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hc2wmh2ZhkyO; Mon, 29 Nov 2021 08:05:32 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:05:23 +0100
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Andrey Konovalov <andrey.konovalov@linaro.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: Add 16-bit Bayer formats
Message-ID: <20211129170356.7258d6db.dorota.czaplejewicz@puri.sm>
In-Reply-To: <163820077159.3059017.10242072140890692995@Monstersaurus>
References: <20211019114718.827400-1-dorota.czaplejewicz@puri.sm>
        <163820077159.3059017.10242072140890692995@Monstersaurus>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rSs3Ei2YPG=sIYsrxFriVYL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rSs3Ei2YPG=sIYsrxFriVYL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Nov 2021 15:46:11 +0000
Kieran Bingham <kieran.bingham@ideasonboard.com> wrote:

> Hi Dorota,
>=20
> Quoting Dorota Czaplejewicz (2021-10-19 12:59:29)
> > 16-bit bayer formats are used by the i.MX driver. =20
>=20
> Can we expand upon this at all?
>=20
> The Subject says "Add 16-bit Bayer formats" but this isn't adding the
> format, it's purely extending the v4l2_format_info table with the
> information for that format which is otherwise missing.
>=20
What do you suggest for a better commit message? My reasoning was that I'm =
adding entries to a table.

> I wonder what other formats are missing from that table too?
>=20
>=20
> > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > ---
> > Hello,
> >=20
> > While working on the i.MX8 video driver, I discovered that `v4l2_fill_p=
ixfmt` will fail when using 10-bit sensor formats. (For background, see the=
 conversation at https://lkml.org/lkml/2021/10/17/93 .)
> >=20
> > It appears that the video hardware will fill a 16-bit-per-pixel buffer =
when fed 10-bit-per-pixel Bayer data, making `v4l2_fill_pixfmt` effectively=
 broken for this case. =20
>=20
> This statement is confusing to me. Are you saying you're programming the
> hardware with 10 bit, and it's using 16 bits per pixel to store that
> data? (Which is simply 'unpacked' I think ?)
>=20
I know the sensor I'm dealing with sends 10-bit data. I'm observing that th=
e data arriving at this stage of the pipeline is encoded with 16 bits per p=
ixel. As far as I understand, that's what i.MX8 does at some stage of the M=
IPI/CSI2 pipeline by design, but I can't elaborate at the moment, and I don=
't think it affects the validity of the addition.
>=20
> >=20
> > This change adds the relevant entries to the format info structure.
> >=20
> > Difference in behaviour observed using the i846 driver on the Librem 5.
> >=20
> > Regards,
> > Dorota Czaplejewicz
> >=20
> >  drivers/media/v4l2-core/v4l2-common.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2=
-core/v4l2-common.c
> > index 04af03285a20..d2e61538e979 100644
> > --- a/drivers/media/v4l2-core/v4l2-common.c
> > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > @@ -309,6 +309,10 @@ const struct v4l2_format_info *v4l2_format_info(u3=
2 format)
> >                 { .format =3D V4L2_PIX_FMT_SGBRG12,       .pixel_enc =
=3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D {=
 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> >                 { .format =3D V4L2_PIX_FMT_SGRBG12,       .pixel_enc =
=3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D {=
 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> >                 { .format =3D V4L2_PIX_FMT_SRGGB12,       .pixel_enc =
=3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D {=
 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > +               { .format =3D V4L2_PIX_FMT_SBGGR16,       .pixel_enc =
=3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D {=
 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > +               { .format =3D V4L2_PIX_FMT_SGBRG16,       .pixel_enc =
=3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D {=
 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > +               { .format =3D V4L2_PIX_FMT_SGRBG16,       .pixel_enc =
=3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D {=
 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > +               { .format =3D V4L2_PIX_FMT_SRGGB16,       .pixel_enc =
=3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D {=
 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 }, =20
>=20
> This looks right as far as I can see though, so for the change, and
> ideally with the commit message improved to be clearer about the
> content and reasoning for the change:
>=20
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>=20

Thanks!

--Dorota
> >         };
> >         unsigned int i;
> > =20
> > --=20
> > 2.31.1
> > =20


--Sig_/rSs3Ei2YPG=sIYsrxFriVYL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmGk+kMACgkQADBpX4S8
ZnchgQ/8CaLnHdVuBu+Yo4JH/2CpmOZd8OUy5640QkYM4QJxiV+JNlR1EyAiJgLO
uErbLZdqyCrnhnGzNm/SElcJcyBmNh6e8P1zWtTFbAr62GKvBqW8Ah3BfbkDgfT8
QRmH32WaA85SjUEeex1Y0O8XTZVzOtclBNaOGpFI6hccvPFNBp1kIMOJSYrnGoOR
JYoaQAVQ+arB8NlGBJ5tfp1rUiE/Q5NC8jLugzUxojcy+3VbyWZ0JU+ZHOmjYfGw
zpYG8fMt7do3NqU8eTM8qrpQkaXvA33yODAutrC2t6i3zP1S5aa9o/2GvUASc5dM
L0qCYU1qxPmiI81y51I7QRmTqwA5MJliCH2D+NkALCz6+aYTulvF2WLqtvJrU4zQ
3/Oc8JO/WeM/0u2lH0c8FjxhbDS5saID7b6/Maq5HLpyU3S6qrhG07FAkZuNnjwi
Q5XAIuvcO7gcRwJBaB/8wBDSL9jSU6I3UypWeZQXuxNuUBQyAMS3MEDBv7Ma1Ai7
zQSWCARuO77CgICVOeI7FDaCixVM/oM4wP9cyvQ+0o7XgElRuonttzTekZqLtm5s
cad5Ho13BwhNCP3EhjTW7Id0s1lcf13Ei4a6YhR5jIn7hpQkU8jehv9peXtk15Jx
26x/mg2SlN6wEpsvw9vV0C4mIXvoxZ8JoV5pSeDEh6jMnBUTqyo=
=38EQ
-----END PGP SIGNATURE-----

--Sig_/rSs3Ei2YPG=sIYsrxFriVYL--
