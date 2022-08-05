Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB858AC28
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbiHEOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiHEOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:10:35 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E53558E8;
        Fri,  5 Aug 2022 07:10:32 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C1C2BE000C;
        Fri,  5 Aug 2022 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1659708631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwkQ0qv8d11cIg/eLHddZY+Oe9mA1gFNjKFinhC1Y8M=;
        b=Y1gyFXYgDm/ZkaFa+HUYy1liTzoVSUHLysu92DcYh1vFOetVC5OCigjwOg1EJ601fO8iHZ
        mwz27HvzOeoLBrFX1bv/bOd5HIIUlkzrhie3LRcoErS94ZhGHUBsEYkhq8l/fzH/ST3dtb
        3uNjPFxSo1WyCtvHdhitFluYFvCtRWJcJ9QQALKn1RCjAGggmQEwgNLC+kkS5xLBVrFuJc
        fECGlIB4YnmVUmqS1r5zxgDqRBhPr0Zb8/rhUYREU5KZad1vAgqBMYTGEFbUFsQxQFunyI
        leci3TREwFuoLw+BCmfXHLpZ9U4SKNvo0FgL7NectIbI5moe970rgDny7E0Dsw==
Date:   Fri, 5 Aug 2022 16:10:28 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] media: sunxi: Fix some error handling path of
 sun8i_a83t_mipi_csi2_probe()
Message-ID: <Yu0k1ER3jVhGx92u@aptenodytes>
References: <62c0aef8d3b86d8f290bf6787f1b2b41efbb0b55.1659295329.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hqu9GGmQSmzk8QQV"
Content-Disposition: inline
In-Reply-To: <62c0aef8d3b86d8f290bf6787f1b2b41efbb0b55.1659295329.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hqu9GGmQSmzk8QQV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Sun 31 Jul 22, 21:22, Christophe JAILLET wrote:
> Release some resources in the error handling path of the probe and of
> sun8i_a83t_mipi_csi2_resources_setup(), as already done in the remove
> function.

Great finds, thanks! Just some nitpick about the label names to make them
consistent with other labels (also from the sun6i-csi rework).
=20
> Fixes: 576d196c522b ("media: sunxi: Add support for the A83T MIPI CSI-2 c=
ontroller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I'm unsure about the phy_exit() call in
> sun8i_a83t_mipi_csi2_resources_cleanup() because no explicit phy_init()
> call is performed.
>=20
> The same code is in sun6i-mipi-csi2/sun6i_mipi_csi2.c, but in this driver
> phy_init() IS called.
>=20
> I leave it as-is because I don't if it is an issue or not.
> My feeling is that it is a copy'n'paste error and that it should be
> removed.
> ---
>  .../sun8i_a83t_mipi_csi2.c                    | 21 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t=
_mipi_csi2.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t=
_mipi_csi2.c
> index d052ee77ef0a..67c7475d5d10 100644
> --- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_c=
si2.c
> +++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_c=
si2.c
> @@ -719,13 +719,15 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a=
83t_mipi_csi2_device *csi2_de
>  	csi2_dev->clock_mipi =3D devm_clk_get(dev, "mipi");
>  	if (IS_ERR(csi2_dev->clock_mipi)) {
>  		dev_err(dev, "failed to acquire mipi clock\n");
> -		return PTR_ERR(csi2_dev->clock_mipi);
> +		ret =3D PTR_ERR(csi2_dev->clock_mipi);
> +		goto err_put_clk_rate;
>  	}
> =20
>  	csi2_dev->clock_misc =3D devm_clk_get(dev, "misc");
>  	if (IS_ERR(csi2_dev->clock_misc)) {
>  		dev_err(dev, "failed to acquire misc clock\n");
> -		return PTR_ERR(csi2_dev->clock_misc);
> +		ret =3D PTR_ERR(csi2_dev->clock_misc);
> +		goto err_put_clk_rate;
>  	}
> =20
>  	/* Reset */
> @@ -733,7 +735,8 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a83=
t_mipi_csi2_device *csi2_de
>  	csi2_dev->reset =3D devm_reset_control_get_shared(dev, NULL);
>  	if (IS_ERR(csi2_dev->reset)) {
>  		dev_err(dev, "failed to get reset controller\n");
> -		return PTR_ERR(csi2_dev->reset);
> +		ret =3D PTR_ERR(csi2_dev->reset);
> +		goto err_put_clk_rate;
>  	}
> =20
>  	/* D-PHY */
> @@ -741,7 +744,7 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a83=
t_mipi_csi2_device *csi2_de
>  	ret =3D sun8i_a83t_dphy_register(csi2_dev);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize MIPI D-PHY\n");
> -		return ret;
> +		goto err_put_clk_rate;
>  	}
> =20
>  	/* Runtime PM */
> @@ -749,6 +752,10 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a8=
3t_mipi_csi2_device *csi2_de
>  	pm_runtime_enable(dev);
> =20
>  	return 0;
> +
> +err_put_clk_rate:

Please call this "error_clock_rate_exclusive",

> +	clk_rate_exclusive_put(csi2_dev->clock_mod);

and add a blank line here.

> +	return ret;
>  }
> =20
>  static void
> @@ -778,9 +785,13 @@ static int sun8i_a83t_mipi_csi2_probe(struct platfor=
m_device *platform_dev)
> =20
>  	ret =3D sun8i_a83t_mipi_csi2_bridge_setup(csi2_dev);
>  	if (ret)
> -		return ret;
> +		goto err_cleanup_resources;
> =20
>  	return 0;
> +
> +err_cleanup_resources:

Please call this "error_resources",

> +	sun8i_a83t_mipi_csi2_resources_cleanup(csi2_dev);

and add a blank line here.

Thanks!

Paul

> +	return ret;
>  }
> =20
>  static int sun8i_a83t_mipi_csi2_remove(struct platform_device *platform_=
dev)
> --=20
> 2.34.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--hqu9GGmQSmzk8QQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmLtJNQACgkQ3cLmz3+f
v9EKVgf/eJBH4biR6Ppa4WNEg0C3+uaXI4M06qGKmX8fWvyljWZ6L9Q7WoDOt0+P
lM5SJdnMNd/dDUzm2JZ/U6R+ojz6tmWM4VhEAFQG/VfiTIh0nqFkuqRXcOBL9MSG
S8ekLSy0MpnVwxP4kWRu6VLAjemciTixmBPLSpxT87+a2kWxRd5AsU7e02y1MkhZ
eRK1BzErjvpkC2YpoQs+GPWf83Fblns9iDu12Rm4VH8q56WOJ7Rcg6CqIoskQDU7
ia2fR8anMC0vkA1YCvI4L6MsJhgVWm7hLR1iZN8xGzyUEEwPPPrKmKAWppdQZvCV
b5c3wioSX4p/hpZ5Ppb+MLZnfQmjwA==
=dnOM
-----END PGP SIGNATURE-----

--hqu9GGmQSmzk8QQV--
