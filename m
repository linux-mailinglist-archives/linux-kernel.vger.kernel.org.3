Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95034B2A58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351520AbiBKQ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:29:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiBKQ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:29:43 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600FDCC9;
        Fri, 11 Feb 2022 08:29:41 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7AAA9240009;
        Fri, 11 Feb 2022 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644596980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4kVSfBMlOpLVxwAYqmjgdSsjcSKy3f9ulmjYySBtivY=;
        b=T4TSHYvfEdtrIdt54FMQc8fkxl6Sb+6Fb/eoGRfWYgAdoQJkHicqhpsEGSiJd0cHoyQsF0
        Vfva/O33f9O65QrX1haPnlzjQ2sIPixy0kxvHp+MbuQfN91FPpawkqwPurQIRekmoMFTg5
        qgKvKxWeNpHSODYhBMZuYE2WpvWAEd3JOjoRKSVqgBQcVuJ4n24mz4t3hrZpjVZ4hHSCFQ
        bW4jOJBvKyEPdisxxKSIzqqzIB3HyKBI4ApuvsfblSRxCFUi3AWIy4ujaGUzzOyqQFbkTY
        Lmw/3Fq/7PX7QEpH+8uAap60ARcPDWvaATeXcm8/9Fpz2Nh+MEA1tsWW9xauGA==
Date:   Fri, 11 Feb 2022 17:29:37 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 21/66] media: sun6i-csi: Always set exclusive module
 clock rate
Message-ID: <YgaO8bfP4gKW8BM0@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-22-paul.kocialkowski@bootlin.com>
 <20220207091443.cr5udv7fxx65ptty@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Tv5rA21o/SqhzaB6"
Content-Disposition: inline
In-Reply-To: <20220207091443.cr5udv7fxx65ptty@houat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tv5rA21o/SqhzaB6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the review,

On Mon 07 Feb 22, 10:14, Maxime Ripard wrote:
> On Sat, Feb 05, 2022 at 07:53:44PM +0100, Paul Kocialkowski wrote:
> > In some situations the default rate of the module clock is not the
> > required one for operation (for example when reconfiguring the clock
> > tree to use a different parent). As a result, always set the correct
> > rate for the clock (and take care of cleanup).
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 54 ++++++++++++++-----
> >  1 file changed, 41 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drive=
rs/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index 8155e9560164..2355088fdc37 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -154,9 +154,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *cs=
i_dev, bool enable)
> >  		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
> > =20
> >  		clk_disable_unprepare(csi_dev->clk_ram);
> > -		if (of_device_is_compatible(dev->of_node,
> > -					    "allwinner,sun50i-a64-csi"))
> > -			clk_rate_exclusive_put(csi_dev->clk_mod);
> >  		clk_disable_unprepare(csi_dev->clk_mod);
> >  		reset_control_assert(csi_dev->reset);
> >  		return 0;
> > @@ -168,9 +165,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *cs=
i_dev, bool enable)
> >  		return ret;
> >  	}
> > =20
> > -	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> > -		clk_set_rate_exclusive(csi_dev->clk_mod, 300000000);
> > -
> >  	ret =3D clk_prepare_enable(csi_dev->clk_ram);
> >  	if (ret) {
> >  		dev_err(csi_dev->dev, "Enable clk_dram_csi clk err %d\n", ret);
> > @@ -190,8 +184,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *cs=
i_dev, bool enable)
> >  clk_ram_disable:
> >  	clk_disable_unprepare(csi_dev->clk_ram);
> >  clk_mod_disable:
> > -	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> > -		clk_rate_exclusive_put(csi_dev->clk_mod);
> >  	clk_disable_unprepare(csi_dev->clk_mod);
> >  	return ret;
> >  }
> > @@ -819,6 +811,7 @@ static int sun6i_csi_resources_setup(struct sun6i_c=
si_device *csi_dev,
> >  				     struct platform_device *platform_dev)
> >  {
> >  	struct device *dev =3D csi_dev->dev;
> > +	unsigned long clk_mod_rate;
> >  	void __iomem *io_base;
> >  	int ret;
> >  	int irq;
> > @@ -856,28 +849,53 @@ static int sun6i_csi_resources_setup(struct sun6i=
_csi_device *csi_dev,
> >  		return PTR_ERR(csi_dev->clk_ram);
> >  	}
> > =20
> > +	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> > +		clk_mod_rate =3D 300000000;
> > +	else
> > +		clk_mod_rate =3D 297000000;
> > +
> > +	ret =3D clk_set_rate_exclusive(csi_dev->clk_mod, clk_mod_rate);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set mod clock rate\n");
> > +		return ret;
> > +	}
> > +
> >  	/* Reset */
> > =20
> >  	csi_dev->reset =3D devm_reset_control_get_shared(dev, NULL);
> >  	if (IS_ERR(csi_dev->reset)) {
> >  		dev_err(dev, "failed to acquire reset\n");
> > -		return PTR_ERR(csi_dev->reset);
> > +		ret =3D PTR_ERR(csi_dev->reset);
> > +		goto error_clk_rate_exclusive;
> >  	}
> > =20
> >  	/* Interrupt */
> > =20
> >  	irq =3D platform_get_irq(platform_dev, 0);
> > -	if (irq < 0)
> > -		return -ENXIO;
> > +	if (irq < 0) {
> > +		dev_err(dev, "failed to get interrupt\n");
> > +		ret =3D -ENXIO;
> > +		goto error_clk_rate_exclusive;
> > +	}
> > =20
> >  	ret =3D devm_request_irq(dev, irq, sun6i_csi_isr, 0, SUN6I_CSI_NAME,
> >  			       csi_dev);
> >  	if (ret) {
> >  		dev_err(dev, "failed to request interrupt\n");
> > -		return ret;
> > +		goto error_clk_rate_exclusive;
> >  	}
> > =20
> >  	return 0;
> > +
> > +error_clk_rate_exclusive:
> > +	clk_rate_exclusive_put(csi_dev->clk_mod);
> > +
> > +	return ret;
> > +}
> > +
> > +static void sun6i_csi_resources_cleanup(struct sun6i_csi_device *csi_d=
ev)
> > +{
> > +	clk_rate_exclusive_put(csi_dev->clk_mod);
> >  }
>=20
> If you're going to have that function anyway, let's use
> devm_add_action_or_reset, it'll simplify the rest of the patch.

Well, this will cause issues later on when adding runtime pm support to
sun6i_csi_resources_cleanup: then it will no longer be equivalent
to the error case label.

Also I feel like making the resources_cleanup call a devm action would not
help clarify the general flow of the driver, where the matching setup/clean=
up
calls are ordered in probe/remove. The driver is quite big with various par=
ts
and I'd rather have them behave in a coherent and similar way.

What do you think?

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Tv5rA21o/SqhzaB6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIGjvEACgkQ3cLmz3+f
v9Eq7wf/aVHx73dljDp0YxBy+q2PMLd3CTowE7OvhhXXMz24VfzET01MwXfyxeo0
IpqwMV0dz5U1iy/ofxtZPJW832v08EZXXCod4h3E+L0lRi/HSkJlW67Gt5z4uZmu
4tWN4NXJ2hXJlUT717HxRvTD7sl3oGOODuemqyPwmVLp/FJ/8dZZcwz38cyHXdL7
v1nT9o/Cdpz5Mj1IECQaqEovJ3zU6sTFfd3YAYc4qPYYXmok4mq4GoqChSlB2y4y
9DxH3t/4vciCVCon1d4Z7gOZML2IdzZBx3NwV+TKVUOBNCsVqz/pl4XVG+ZJ+Lvs
bQio4a8S1+h+txomzaXIBPr1XlOENg==
=d+6J
-----END PGP SIGNATURE-----

--Tv5rA21o/SqhzaB6--
