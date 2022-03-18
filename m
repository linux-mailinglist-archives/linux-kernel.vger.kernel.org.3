Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2B4DDE26
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiCRQR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbiCRQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:17:24 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A641D78BA;
        Fri, 18 Mar 2022 09:16:00 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2A464240005;
        Fri, 18 Mar 2022 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647620159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FXSqpef77HUERWOVCcYwkbaMTy0zpi5sfmvLF2hmexg=;
        b=bB+RAgxsE7MZ9tw5p9vxxgeLU5/I0+d3Rj41bd4imlfBGvaJhC/p7tJsnAdb9CsNSUalFS
        pNeJX4baWgIG06ySy6AC/ID+xsE0VcZ0nifK/sJnKxls6dYN3rlcrCIlKCznGu7kEKDlda
        pF5D/tlaPTdm0SmomEqX6u5qMWZXx35s98F0e8fpqUfaLjCItuDNHZ2jbBHX8KIKI4LnXb
        3OABMe43K3lHabnpOSN8kkC39XjSL/7rne+U+tbze8VvMsJ6KpDnz2Mew5t8SUeQb3LFgJ
        jDJKmsGRZi5byIbetl22JFAax1STBMMyavhtmkortyYeyBhsgGxyv8ap0XidrQ==
Date:   Fri, 18 Mar 2022 17:15:56 +0100
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
Subject: Re: [PATCH v3 07/46] media: sun6i-csi: Use runtime pm for clocks and
 reset
Message-ID: <YjSwPOUxQ4KwPfUe@aptenodytes>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
 <20220311143532.265091-8-paul.kocialkowski@bootlin.com>
 <14579642.tv2OnDr8pf@kista>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UWT2FLc5RubuMPHI"
Content-Disposition: inline
In-Reply-To: <14579642.tv2OnDr8pf@kista>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UWT2FLc5RubuMPHI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Tue 15 Mar 22, 20:46, Jernej =C5=A0krabec wrote:
> Dne petek, 11. marec 2022 ob 15:34:53 CET je Paul Kocialkowski napisal(a):
> > Wrap the clock and reset preparation into runtime pm functions
> > for better organization of the code. Also fix the clock and
> > reset enable order to first deassert reset, as recommended in
> > Allwinner litterature.
> >=20
> > Make the driver depend on PM while at it since runtime pm is
> > mandatory for the driver to work.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../media/platform/sunxi/sun6i-csi/Kconfig    |  2 +-
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 94 ++++++++++++++-----
> >  2 files changed, 70 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/m=
edia/
> platform/sunxi/sun6i-csi/Kconfig
> > index 586e3fb3a80d..fd03e48f0c8a 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config VIDEO_SUN6I_CSI
> >  	tristate "Allwinner V3s Camera Sensor Interface driver"
> > -	depends on VIDEO_V4L2 && COMMON_CLK  && HAS_DMA
> > +	depends on PM && VIDEO_V4L2 && COMMON_CLK  && HAS_DMA
> >  	depends on ARCH_SUNXI || COMPILE_TEST
> >  	select MEDIA_CONTROLLER
> >  	select VIDEO_V4L2_SUBDEV_API
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drive=
rs/
> media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index 4a0d08e0ac25..7f045a9551a7 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -152,40 +152,18 @@ int sun6i_csi_set_power(struct sun6i_csi_device=
=20
> *csi_dev, bool enable)
> > =20
> >  	if (!enable) {
> >  		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN,=20
> 0);
> > +		pm_runtime_put(dev);
> > =20
> > -		clk_disable_unprepare(csi_dev->clk_ram);
> > -		clk_disable_unprepare(csi_dev->clk_mod);
> > -		reset_control_assert(csi_dev->reset);
> >  		return 0;
> >  	}
> > =20
> > -	ret =3D clk_prepare_enable(csi_dev->clk_mod);
> > -	if (ret) {
> > -		dev_err(csi_dev->dev, "Enable csi clk err %d\n", ret);
> > +	ret =3D pm_runtime_resume_and_get(dev);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> > -
> > -	ret =3D clk_prepare_enable(csi_dev->clk_ram);
> > -	if (ret) {
> > -		dev_err(csi_dev->dev, "Enable clk_dram_csi clk err=20
> %d\n", ret);
> > -		goto clk_mod_disable;
> > -	}
> > -
> > -	ret =3D reset_control_deassert(csi_dev->reset);
> > -	if (ret) {
> > -		dev_err(csi_dev->dev, "reset err %d\n", ret);
> > -		goto clk_ram_disable;
> > -	}
> > =20
> >  	regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN,=20
> CSI_EN_CSI_EN);
> > =20
> >  	return 0;
> > -
> > -clk_ram_disable:
> > -	clk_disable_unprepare(csi_dev->clk_ram);
> > -clk_mod_disable:
> > -	clk_disable_unprepare(csi_dev->clk_mod);
> > -	return ret;
> >  }
> > =20
> >  static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device=
=20
> *csi_dev,
> > @@ -800,6 +778,65 @@ static irqreturn_t sun6i_csi_isr(int irq, void=20
> *private)
> >  	return IRQ_HANDLED;
> >  }
> > =20
> > +static int sun6i_csi_suspend(struct device *dev)
> > +{
> > +	struct sun6i_csi_device *csi_dev =3D dev_get_drvdata(dev);
> > +
> > +	reset_control_assert(csi_dev->reset);
> > +	clk_disable_unprepare(csi_dev->clk_ram);
> > +	clk_disable_unprepare(csi_dev->clk_mod);
> > +	clk_disable_unprepare(csi_dev->clk_bus);
> > +
> > +	return 0;
> > +}
> > +
> > +static int sun6i_csi_resume(struct device *dev)
> > +{
> > +	struct sun6i_csi_device *csi_dev =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret =3D reset_control_deassert(csi_dev->reset);
> > +	if (ret) {
> > +		dev_err(dev, "failed to deassert reset\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(csi_dev->clk_bus);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable bus clock\n");
> > +		goto error_reset;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(csi_dev->clk_mod);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable module clock\n");
> > +		goto error_clk_bus;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(csi_dev->clk_ram);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable ram clock\n");
> > +		goto error_clk_mod;
> > +	}
> > +
> > +	return 0;
> > +
> > +error_clk_mod:
> > +	clk_disable_unprepare(csi_dev->clk_mod);
> > +
> > +error_clk_bus:
> > +	clk_disable_unprepare(csi_dev->clk_bus);
> > +
> > +error_reset:
> > +	reset_control_assert(csi_dev->reset);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct dev_pm_ops sun6i_csi_pm_ops =3D {
> > +	SET_RUNTIME_PM_OPS(sun6i_csi_suspend, sun6i_csi_resume, NULL)
>=20
> Since driver depends on PM, using SET_RUNTIME_PM_OPS macro doesn't make s=
ense.

Can you ellaborate why? It's really not obvious why the macro should only be
used when PM is optional. I see that it facilitates that, but I really don't
see any issue using it with PM required too. Is it a common practice?

> > +};
> > +
> >  static const struct regmap_config sun6i_csi_regmap_config =3D {
> >  	.reg_bits       =3D 32,
> >  	.reg_stride     =3D 4,
> > @@ -886,6 +923,11 @@ static int sun6i_csi_resources_setup(struct=20
> sun6i_csi_device *csi_dev,
> >  		goto error_clk_rate_exclusive;
> >  	}
> > =20
> > +	/* Runtime PM */
> > +
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_set_suspended(dev);
>=20
> pm_runtime_set_suspended() description says: "It is not valid to call thi=
s=20
> function for devices with runtime PM enabled."

Okay I need to revisit this, I think I misunderstood a bunch of things here.

Thanks,

Paul

> Best regards,
> Jernej
>=20
> > +
> >  	return 0;
> > =20
> >  error_clk_rate_exclusive:
> > @@ -896,6 +938,7 @@ static int sun6i_csi_resources_setup(struct=20
> sun6i_csi_device *csi_dev,
> > =20
> >  static void sun6i_csi_resources_cleanup(struct sun6i_csi_device *csi_d=
ev)
> >  {
> > +	pm_runtime_disable(csi_dev->dev);
> >  	clk_rate_exclusive_put(csi_dev->clk_mod);
> >  }
> > =20
> > @@ -978,6 +1021,7 @@ static struct platform_driver sun6i_csi_platform_d=
river=20
> =3D {
> >  	.driver	=3D {
> >  		.name		=3D SUN6I_CSI_NAME,
> >  		.of_match_table	=3D=20
> of_match_ptr(sun6i_csi_of_match),
> > +		.pm		=3D &sun6i_csi_pm_ops,
> >  	},
> >  };
> > =20
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

--UWT2FLc5RubuMPHI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmI0sDwACgkQ3cLmz3+f
v9HpJgf9Gjba+M2/GQt8sesqSzzJJNQ6FvuPQqSztzoKxup0ram3CyaEDHOklnmS
EOnTH2XMYjQTqN0uyrGYTRLGuRKgtJyjOhoO5ehM/EX0DsT063Ja6WpfQt1pzPTE
VMG6CadAdPwwVoIr559/tIYnGY4TZRikHfEzLOLczuYZL9yOHzgutZs5Zd1fV63+
Z07YBrYKHzBsIM/TPaOfjYP24Cr1p/bf7ISTLlfbbLeQexKkrA7G30XwFw/RH2le
RttJlpU6mnt068MRXncmR42LuoXuLB98A4puT5XLWBBfh/FK23DFxUXy1aiTlrr4
rUbvi7oqf2QfHca292ZkXfEuLTJvHQ==
=c9x9
-----END PGP SIGNATURE-----

--UWT2FLc5RubuMPHI--
