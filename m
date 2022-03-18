Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C064DD673
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiCRIua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiCRIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:50:28 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC899D0C4;
        Fri, 18 Mar 2022 01:49:08 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BEAB7E000F;
        Fri, 18 Mar 2022 08:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647593347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bAdKA3T8fJldt3bCutW94XcxG9KeQUgHALYsG5O6TU=;
        b=J2tzoyCplqZnwfh5iT0yGbxyzZ4hKWazmRtP0vBd5WrBzslQy+Dz8PTvY5rkJeAhvZFtkx
        zqjqeqWA/gq+LKAJTIetLiGCTVURg29P1UqocB+FR4DgXcYZZJXGRnGAq/wB2EMb1CA363
        8Jaij9mhCFhI+LIszpmzbhRXPuFvBXPdPSZSOs6pUik4gopQBdyZI51TdhbCa96sKfrwAo
        1Ndv/NaU+1Mlq3IB9G+v3ohL9DemGHyhBedEXyhcxROhGSwpx2z2v6MdgbPo2qc1/DGEsN
        BIa+nP7a/rJFf2E/Ms+cU5Zn+KQk4ff4Ybfc7L0E6YBs+gI3VrhAG/LdqrYyQA==
Date:   Fri, 18 Mar 2022 09:49:04 +0100
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
Subject: Re: [PATCH v3 03/46] media: sun6i-csi: Grab bus clock instead of
 passing it to regmap
Message-ID: <YjRHgGgYfYODAmoi@aptenodytes>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
 <20220311143532.265091-4-paul.kocialkowski@bootlin.com>
 <2361247.jE0xQCEvom@kista>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gHLgdwLJSCzaTAAW"
Content-Disposition: inline
In-Reply-To: <2361247.jE0xQCEvom@kista>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gHLgdwLJSCzaTAAW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Tue 15 Mar 22, 20:22, Jernej =C5=A0krabec wrote:
> Hi Paul!
>=20
> Dne petek, 11. marec 2022 ob 15:34:49 CET je Paul Kocialkowski napisal(a):
> > Since the bus clock alone is not enough to get access to the registers,
> > don't pass it to regmap and manage it instead just like the other
> > clocks.
> >=20
>=20
> Let me ask it in another way, is bus clock needed only for register acces=
s? If=20
> yes, it makes sense to keep it enabled only during register access.

Ah right, I lost sight that what regmap will do is to enable/disable the
clock around register access. I understand there might be an advantage
in terms of power consumption here.

I haven't checked specifically, but since it was used like that before
it's probably fine.

Out of curiosity: is there any noticeable latency added by the process?

Cheers,

Paul

> Best regards,
> Jernej
>=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 10 ++++++++--
> >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h |  1 +
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drive=
rs/
> media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index 5fbaa1e99412..dc79f3c14336 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -827,13 +827,19 @@ static int sun6i_csi_resource_request(struct=20
> sun6i_csi_device *csi_dev,
> >  	if (IS_ERR(io_base))
> >  		return PTR_ERR(io_base);
> > =20
> > -	csi_dev->regmap =3D devm_regmap_init_mmio_clk(&pdev->dev, "bus",=20
> io_base,
> > -						   =20
> &sun6i_csi_regmap_config);
> > +	csi_dev->regmap =3D devm_regmap_init_mmio(&pdev->dev, io_base,
> > +					=09
> &sun6i_csi_regmap_config);
> >  	if (IS_ERR(csi_dev->regmap)) {
> >  		dev_err(&pdev->dev, "Failed to init register map\n");
> >  		return PTR_ERR(csi_dev->regmap);
> >  	}
> > =20
> > +	csi_dev->clk_bus =3D devm_clk_get(&pdev->dev, "bus");
> > +	if (IS_ERR(csi_dev->clk_bus)) {
> > +		dev_err(&pdev->dev, "Unable to acquire bus clock\n");
> > +		return PTR_ERR(csi_dev->clk_bus);
> > +	}
> > +
> >  	csi_dev->clk_mod =3D devm_clk_get(&pdev->dev, "mod");
> >  	if (IS_ERR(csi_dev->clk_mod)) {
> >  		dev_err(&pdev->dev, "Unable to acquire csi clock\n");
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drive=
rs/
> media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > index e4e7ac6c869f..356661b413f8 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > @@ -51,6 +51,7 @@ struct sun6i_csi_device {
> >  	struct sun6i_video		video;
> > =20
> >  	struct regmap			*regmap;
> > +	struct clk			*clk_bus;
> >  	struct clk			*clk_mod;
> >  	struct clk			*clk_ram;
> >  	struct reset_control		*reset;
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

--gHLgdwLJSCzaTAAW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmI0R4AACgkQ3cLmz3+f
v9HeVQf8CKT1qm0Afb3D5ftaWSjBnvSaPjI1zrK0d267DdUOAMWvOOJp+8dLNx+b
7y2dlj+4zVD8nIcixvmVJ5hR2APgzgz/lgiUnYBQa9EmU2fFufSbEx3ugT2+rkGr
fOVtDhbGob1l3Es0HNTYFWOSTOu9uUsudlEGr+WazSJzTy6KD4wkc+osin8uGfMs
7FVkADgg0MQn4svLRLpnL6/GJtFSh2jkiaHquket6AwoztJgOOMmETmUDq+Y1dWc
rDOSI9emIa3I5lmO2/vkFOS/rTR1G4J2gkPqw3jOyW0lV+GrJ9O0cOQRQoRBwcjF
9r3tjFy6ReRRxfFVHKFe9Jko7mftCg==
=txhr
-----END PGP SIGNATURE-----

--gHLgdwLJSCzaTAAW--
