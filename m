Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3069C4DD68C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiCRIz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiCRIzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:55:51 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5034B1EB835;
        Fri, 18 Mar 2022 01:54:32 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C34CE1C000C;
        Fri, 18 Mar 2022 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647593670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pT+oSbSVAYKO0LoWynWo0gJMaQ1k3j6MYNtjFVs3Qf4=;
        b=VWyQTt/7aftQxhKsTQxlBYPnCOEpX4NrL57t15NDiy615UM4EAzwzcLNO2hHNbH9ogU5lE
        646hE1cm05KsBiQ0fgWO/CVdBdW1BuW8F9K511heJWJpJHYWB+IK4qdDfspIlHp5rbJHAy
        dGiJWYo2629sL1QOdqyDZjTAyOjSQOZWgtwfQq9YYjlcclmiH4CbTlXo5Cj3UNuSRWYin5
        csGZ++6Xpb8ae3f8EKpdsP8n2lfNscq2TGZQd7KnKuCvyhmHH07+G0OO6S93xFKWewqX+H
        EBOTJSpr7HzU88lTtKVOcxAvTSa8nu/BEbL1P4y52h3ZmsQRFnQ7bnf3bBPtkg==
Date:   Fri, 18 Mar 2022 09:54:28 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 06/46] media: sun6i-csi: Define and use variant to get
 module clock rate
Message-ID: <YjRIxGb0MAJ0f6WT@aptenodytes>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
 <20220311143532.265091-7-paul.kocialkowski@bootlin.com>
 <2060330.OBFZWjSADL@kista>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QxR7joyd66HZ+5rA"
Content-Disposition: inline
In-Reply-To: <2060330.OBFZWjSADL@kista>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QxR7joyd66HZ+5rA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Tue 15 Mar 22, 20:31, Jernej =C5=A0krabec wrote:
> Dne petek, 11. marec 2022 ob 15:34:52 CET je Paul Kocialkowski napisal(a):
> > Introduce a proper variant structure with the module clock rate
> > instead of hardcoding it with a manual check on the compatible.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 48 ++++++++++++++-----
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  4 ++
> >  2 files changed, 40 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drive=
rs/
> media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index 2355088fdc37..4a0d08e0ac25 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -811,11 +811,17 @@ static int sun6i_csi_resources_setup(struct=20
> sun6i_csi_device *csi_dev,
> >  				     struct platform_device=20
> *platform_dev)
> >  {
> >  	struct device *dev =3D csi_dev->dev;
> > -	unsigned long clk_mod_rate;
> > +	const struct sun6i_csi_variant *variant;
>=20
> Ideally, this should be sorted from longest to shortest.

I typically try to have definitions with affectations first and then
just definitions, sorted longest to shortest unless there is some dependency
between definitions.

> >  	void __iomem *io_base;
> >  	int ret;
> >  	int irq;
> > =20
> > +	/* Variant */
>=20
> I don't think this comment is very useful (nor one below for that matter.=
)=20
> Please remove it.

It's not really a comment per-se, but rather a section header.
I have similar ones for Clocks / Reset / Interrupt / Runtime PM so
that's why it felt consistent to add one for Variant too.

The point is to keep related topics grouped together and I'd rather keep it.

Cheers,

Paul

> With that:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> Best regards,
> Jernej
>=20
> > +
> > +	variant =3D of_device_get_match_data(dev);
> > +	if (!variant)
> > +		return -EINVAL;
> > +
> >  	/* Registers */
> > =20
> >  	io_base =3D devm_platform_ioremap_resource(platform_dev, 0);
> > @@ -849,12 +855,7 @@ static int sun6i_csi_resources_setup(struct=20
> sun6i_csi_device *csi_dev,
> >  		return PTR_ERR(csi_dev->clk_ram);
> >  	}
> > =20
> > -	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-
> csi"))
> > -		clk_mod_rate =3D 300000000;
> > -	else
> > -		clk_mod_rate =3D 297000000;
> > -
> > -	ret =3D clk_set_rate_exclusive(csi_dev->clk_mod, clk_mod_rate);
> > +	ret =3D clk_set_rate_exclusive(csi_dev->clk_mod, variant-
> >clk_mod_rate);
> >  	if (ret) {
> >  		dev_err(dev, "failed to set mod clock rate\n");
> >  		return ret;
> > @@ -937,12 +938,35 @@ static int sun6i_csi_remove(struct platform_devic=
e=20
> *pdev)
> >  	return 0;
> >  }
> > =20
> > +static const struct sun6i_csi_variant sun6i_a31_csi_variant =3D {
> > +	.clk_mod_rate	=3D 297000000,
> > +};
> > +
> > +static const struct sun6i_csi_variant sun50i_a64_csi_variant =3D {
> > +	.clk_mod_rate	=3D 300000000,
> > +};
> > +
> >  static const struct of_device_id sun6i_csi_of_match[] =3D {
> > -	{ .compatible =3D "allwinner,sun6i-a31-csi", },
> > -	{ .compatible =3D "allwinner,sun8i-a83t-csi", },
> > -	{ .compatible =3D "allwinner,sun8i-h3-csi", },
> > -	{ .compatible =3D "allwinner,sun8i-v3s-csi", },
> > -	{ .compatible =3D "allwinner,sun50i-a64-csi", },
> > +	{
> > +		.compatible	=3D "allwinner,sun6i-a31-csi",
> > +		.data		=3D &sun6i_a31_csi_variant,
> > +	},
> > +	{
> > +		.compatible	=3D "allwinner,sun8i-a83t-csi",
> > +		.data		=3D &sun6i_a31_csi_variant,
> > +	},
> > +	{
> > +		.compatible	=3D "allwinner,sun8i-h3-csi",
> > +		.data		=3D &sun6i_a31_csi_variant,
> > +	},
> > +	{
> > +		.compatible	=3D "allwinner,sun8i-v3s-csi",
> > +		.data		=3D &sun6i_a31_csi_variant,
> > +	},
> > +	{
> > +		.compatible	=3D "allwinner,sun50i-a64-csi",
> > +		.data		=3D &sun50i_a64_csi_variant,
> > +	},
> >  	{},
> >  };
> > =20
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drive=
rs/
> media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > index 356661b413f8..3c4a3af6b897 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > @@ -59,6 +59,10 @@ struct sun6i_csi_device {
> >  	int				planar_offset[3];
> >  };
> > =20
> > +struct sun6i_csi_variant {
> > +	unsigned long	clk_mod_rate;
> > +};
> > +
> >  /**
> >   * sun6i_csi_is_format_supported() - check if the format supported by =
csi
> >   * @csi:	pointer to the csi
> > --=20
> > 2.35.1
> >=20
> >=20
>=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--QxR7joyd66HZ+5rA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmI0SMQACgkQ3cLmz3+f
v9HS0gf/TR9sni8XrcOWDHi7UkVmO2+KvCZ9Eyh4h5wbp7wKDBAmSdW3f6AaK27f
I1WbaYh+IfOZ27jE+CwJFfjca6MXANBSwQNnFXBHjdJAJFpLRkFomg6Ap5Kkij3l
OFAMwxOkTWvXj5gj/VkQkUb6n9e6FemkmvsuBIz1fFcpiJXbjRS0vxd/5z+ucj/F
C4WTeroIB+CnXP0NFe4iHpFhZY6eI9LhaX5fxe2gx8QhZ5hCIvhWoV0ozOZ+JYJu
s7kZt0Di/ZGar7zd+7gUjKOiobIMsbuV47ME+/BPqSSJcJERCAtspHTSSBPXBlZd
GQPQnE2oCgtbOEHBfIxNbNUDK+sibA==
=bjDU
-----END PGP SIGNATURE-----

--QxR7joyd66HZ+5rA--
