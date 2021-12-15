Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9124476024
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbhLOSCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:02:20 -0500
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:58944 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245460AbhLOSCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:02:15 -0500
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 19581F40E9E; Wed, 15 Dec 2021 18:52:15 +0100 (CET)
Date:   Wed, 15 Dec 2021 18:52:14 +0100
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Alessandro Zummo <a.zummo@towertech.it>,
        rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>,
        Ash Logan <ash@heyquark.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] rtc: gamecube: Report low battery as invalid data
Message-ID: <20211215175214.qweez756f4azvbqf@luna>
Jabber-ID: linkmauve@linkmauve.fr
References: <20211014220524.9988-1-linkmauve@linkmauve.fr>
 <20211027223516.2031-1-linkmauve@linkmauve.fr>
 <20211027223516.2031-3-linkmauve@linkmauve.fr>
 <YaapfmykL0BOHHhF@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7h6m7t7coehjzvvj"
Content-Disposition: inline
In-Reply-To: <YaapfmykL0BOHHhF@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7h6m7t7coehjzvvj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2021 at 11:45:18PM +0100, Alexandre Belloni wrote:
> Hello,

Hi,

>=20
> On 28/10/2021 00:35:12+0200, Emmanuel Gil Peyrot wrote:
> > I haven=E2=80=99t been able to test this patch as all of my consoles ha=
ve a
> > working RTC battery, but according to the documentation it should work
> > like that.
> >=20
> > Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> > ---
> >  drivers/rtc/rtc-gamecube.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >=20
> > diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
> > index e8260c82c07d..1932c6fe1301 100644
> > --- a/drivers/rtc/rtc-gamecube.c
> > +++ b/drivers/rtc/rtc-gamecube.c
> > @@ -83,6 +83,10 @@
> >  #define RTC_CONTROL0	0x21000c
> >  #define RTC_CONTROL1	0x21000d
> > =20
> > +/* RTC flags */
> > +#define RTC_CONTROL0_UNSTABLE_POWER	0x00000800
> > +#define RTC_CONTROL0_LOW_BATTERY	0x00000200
> > +
> >  struct priv {
> >  	struct regmap *regmap;
> >  	void __iomem *iob;
> > @@ -182,9 +186,35 @@ static int gamecube_rtc_set_time(struct device *de=
v, struct rtc_time *t)
> >  	return regmap_write(d->regmap, RTC_COUNTER, timestamp - d->rtc_bias);
> >  }
> > =20
> > +static int gamecube_rtc_ioctl(struct device *dev, unsigned int cmd, un=
signed long arg)
> > +{
> > +	struct priv *d =3D dev_get_drvdata(dev);
> > +	int value;
> > +	int control0;
> > +	int ret;
> > +
> > +	switch (cmd) {
> > +	case RTC_VL_READ:
> > +		ret =3D regmap_read(d->regmap, RTC_CONTROL0, &control0);
> > +		if (ret)
> > +			return ret;
> > +
> > +		value =3D 0;
> > +		if (control0 & RTC_CONTROL0_UNSTABLE_POWER)
> > +			value |=3D RTC_VL_DATA_INVALID;
> > +		if (control0 & RTC_CONTROL0_LOW_BATTERY)
> > +			value |=3D RTC_VL_DATA_INVALID;
>=20
> Shouldn't that one be RTC_VL_BACKUP_LOW?

Oops indeed, that seems like a better report, I=E2=80=99ll send a v3 with t=
his
change only.

>=20
> Else, the driver is great, I'm ready to apply it.

Perfect!

>=20
> > +		return put_user(value, (unsigned int __user *)arg);
> > +
> > +	default:
> > +		return -ENOIOCTLCMD;
> > +	}
> > +}
> > +
> >  static const struct rtc_class_ops gamecube_rtc_ops =3D {
> >  	.read_time	=3D gamecube_rtc_read_time,
> >  	.set_time	=3D gamecube_rtc_set_time,
> > +	.ioctl		=3D gamecube_rtc_ioctl,
> >  };
> > =20
> >  static int gamecube_rtc_read_offset_from_sram(struct priv *d)
> > --=20
> > 2.33.1
> >=20
>=20
> --=20
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

--=20
Emmanuel Gil Peyrot

--7h6m7t7coehjzvvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEjrVT1SzTln43kCLJOWgfYkb2LpAFAmG6K0wACgkQOWgfYkb2
LpByuwf6AmzisFE5NJCTlMwGpzbt+Njy0Plxkb470ybfau8cNV+FBat3k8NNhl5r
5tPVNTIE2RijxchlUt+83ooVrRYhkXmw6x3vne1mFnEuUd1NBa4Yf5wSx//fRMNd
19T7U6rYN2b9BZIFhsdmYjBsYuCqeimyuHNV5i9GKDwKy/dmgGPfJlLwb2f11GoB
nMWfjKhbsckPXK7fIfa2chUQG8W37nMjiWqVQDVYBk4qvsr1BBH4DR4QzpbmFBq8
E6aD6K9F/JjxEHL7qkHC7sL10TlPLDmzgdWiLRvqLtTJ7wjvA0t2aoywSZystzwe
QDRAB2BWJEAKkFWxd8h6I4/BQccTDg==
=9yH/
-----END PGP SIGNATURE-----

--7h6m7t7coehjzvvj--
