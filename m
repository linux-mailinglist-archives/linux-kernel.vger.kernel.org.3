Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD94AA77B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 08:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379603AbiBEHwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 02:52:17 -0500
Received: from comms.puri.sm ([159.203.221.185]:54694 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbiBEHwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 02:52:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 55096DF537;
        Fri,  4 Feb 2022 23:52:15 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tlEkKNwbwbK6; Fri,  4 Feb 2022 23:52:14 -0800 (PST)
Date:   Sat, 5 Feb 2022 08:51:51 +0100
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] media: imx: Fail conversion if pixel format not
 supported
Message-ID: <20220205085151.61088d8e.dorota.czaplejewicz@puri.sm>
In-Reply-To: <Yf34CXvZQPQPAxma@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
        <20220204121514.2762676-5-alexander.stein@ew.tq-group.com>
        <Yf34CXvZQPQPAxma@pendragon.ideasonboard.com>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GkcT.DU6W1y2u=sTikbv/br";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GkcT.DU6W1y2u=sTikbv/br
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Sat, 5 Feb 2022 06:07:37 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Alexander and Dorota,
>=20
> Thank you for the patch.
>=20
> On Fri, Feb 04, 2022 at 01:15:10PM +0100, Alexander Stein wrote:
> > From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> >=20
> > imx_media_find_mbus_format has NULL as a valid return value,
> > therefore the caller should take it into account.
> >=20
> > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  drivers/staging/media/imx/imx-media-utils.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/stag=
ing/media/imx/imx-media-utils.c
> > index 32aaa2e81bea..e0a256a08c3b 100644
> > --- a/drivers/staging/media/imx/imx-media-utils.c
> > +++ b/drivers/staging/media/imx/imx-media-utils.c
> > @@ -544,6 +544,9 @@ static int imx56_media_mbus_fmt_to_pix_fmt(struct v=
4l2_pix_format *pix,
> >  		cc =3D imx_media_find_mbus_format(code, PIXFMT_SEL_YUV); =20
>=20
> The code passed to the function comes from the previous line:
>=20
> 	imx_media_enum_mbus_formats(&code, 0, PIXFMT_SEL_YUV);
>=20
> As far as I can tell, this is guaranteed to return a code that will
> result in imx_media_find_mbus_format() returning a non-NULL pointer.
>=20
While I am not well-versed in the implicit code style of the kernel, I deci=
ded to leave it in because it makes the code more locally legible. With a c=
heck here, even a non-functional one, there's no need to understand the int=
ernals of `imx_media_find_mbus_format` that are only implicit. That makes t=
he code less surprising when interested only in the outer function.

The other advantage of a check is becoming robust against future changes to=
 `imx_media_find_mbus_format` itself.

I don't have a strong preference about keeping or leaving this patch, but i=
f this check was there in the first place, I wouldn't have spent time tryin=
g to figure out whether there's a bug here.

Cheers,
Dorota

> >  	}
> > =20
> > +	if (!cc)
> > +		return -EINVAL;
> > +
> >  	/* Round up width for minimum burst size */
> >  	width =3D round_up(mbus->width, 8);
> >   =20
>=20


--Sig_/GkcT.DU6W1y2u=sTikbv/br
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmH+LJcACgkQADBpX4S8
ZneVXA/8DT1/SWdTKX0nPQztfkSCXSKeoUukY7pJTyrUtwwlGHpsm80yXzEKUIp1
5UpRjrLjStkvHVaP0ZN4FD3pp4k1F2jo/90J1BJuAyfyvwaEdd6rDe5xwnHGyO4M
EOidAwrOJMqSwB1z4SGvdG75T/RhDaG8YsS4kXXjkdKqZH8HjySD/t4Eqp1PLlUR
XnZDgzWGIOpXXQ1/46S1Pa4DnL2wmC/ZthojOta28k7myyfG40/p0hXPCDaf0DCF
j6i3woxvGWf6dBR1txjWnFs8xDhuostpcwvDoEILE9Q97xsApFilVVbWPjZ/9Of4
yOo1zUkbCPx8vqeA+1RLnUj+5xqmeAaF7Xyu2WQdCDCwXzr03gRUWPn9ualPBQlu
O8ZI0e+AcM6OIduBF1266sKZoQNy4I68zdDkzO0+ON7qw2uHidGgxH5fjIPXtmwm
S+jMZn0Kxse/hrQHLXUyFvJdCPNg2u4xDPELbN69oTql8M9HIF0dfe9oafpQb2/0
XNMEQyeADvxUnf7bSRz6UDGBtmTzygkW2yXoi63EBkGakM6Ry4Ogr8scNes3vFeA
Nw0vf8FL3i9TKjpKZimy+LwqzwJSYyAJ06dv6ugVSS7m8hRS3WyAYOH6+BF4Vizq
Ptnp9ouFuj2rlb9l4ZCng+mErM95SdciJfZ9CnUJddBQyAyg5mc=
=ygHY
-----END PGP SIGNATURE-----

--Sig_/GkcT.DU6W1y2u=sTikbv/br--
