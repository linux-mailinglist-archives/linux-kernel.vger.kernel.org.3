Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C325455B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiFIUeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiFIUeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:34:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488FB9E9ED;
        Thu,  9 Jun 2022 13:34:00 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 057316601752;
        Thu,  9 Jun 2022 21:33:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654806839;
        bh=VNekLhmfPjsUN9yizbSGziR2L3VN05ZPmSRaQ6aqrU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1Q4M3aNHFlWYJQ7bRaYmOi4AR26Z7YrA4ye4kJgw5VrkzBid7LMfmYrDiq4evp0I
         GOa4yUqsSGbzVBybkOqQ8HudjO7Uvt2XVM1eZUqGy2naC008eWbj+zH07CBB3YhEHe
         ahCcbtflljV9YdQUYquIZ0MMFAR1vcoAXgLOdwAZ4mME0zVRgxA0J9bMecIzKJ87Zd
         WWIc5wFhWerUYCwkvBmiG1AXlzm/Eu1eiSywYCL0H7R/PP9xXsy0Tdiu5vRm4xP6Xj
         HFEhJkXYNog486WMIqnl01EARkxErJeTEqkVty91eQTzLkGgA0ebQ/0Tuo5xhLRnHS
         bNHPHow56bNow==
Received: by mercury (Postfix, from userid 1000)
        id 25E6410605B9; Thu,  9 Jun 2022 22:33:56 +0200 (CEST)
Date:   Thu, 9 Jun 2022 22:33:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] power: reset: at91-reset: add at91_reset_data
Message-ID: <20220609203356.75oamac2sjqli4op@mercury.elektranox.org>
References: <20220608083942.1584087-1-claudiu.beznea@microchip.com>
 <20220608083942.1584087-7-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3iabka34udetqlt"
Content-Disposition: inline
In-Reply-To: <20220608083942.1584087-7-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e3iabka34udetqlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 08, 2022 at 11:39:39AM +0300, Claudiu Beznea wrote:
> Add struct at91_reset_data to keep per platform related information.
> This is a prerequisite for adding reset_controller_dev support.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/power/reset/at91-reset.c | 38 ++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index e62798750b6b..1b2aca3f490d 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -79,6 +79,16 @@ struct at91_reset {
>  	u32 ramc_lpr;
>  };
> =20
> +/**
> + * struct at91_reset_data - AT91 reset data
> + * @reset_args:		SoC specific system reset arguments
> + * @n_device_reset:	number of device resets
> + */
> +struct at91_reset_data {
> +	u32 reset_args;
> +	u32 n_device_reset;
> +};
> +
>  /*
>  * unless the SDRAM is cleanly shutdown before we hit the
>  * reset register it can be left driving the data bus and
> @@ -173,29 +183,34 @@ static const struct of_device_id at91_ramc_of_match=
[] =3D {
>  	{ /* sentinel */ }
>  };
> =20
> +static const struct at91_reset_data sam9260 =3D {
> +	.reset_args =3D AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST,
> +};
> +
> +static const struct at91_reset_data samx7 =3D {
> +	.reset_args =3D AT91_RSTC_KEY | AT91_RSTC_PROCRST,
> +};
> +
>  static const struct of_device_id at91_reset_of_match[] =3D {
>  	{
>  		.compatible =3D "atmel,at91sam9260-rstc",
> -		.data =3D (void *)(AT91_RSTC_KEY | AT91_RSTC_PERRST |
> -				 AT91_RSTC_PROCRST),
> +		.data =3D &sam9260,
>  	},
>  	{
>  		.compatible =3D "atmel,at91sam9g45-rstc",
> -		.data =3D (void *)(AT91_RSTC_KEY | AT91_RSTC_PERRST |
> -				 AT91_RSTC_PROCRST)
> +		.data =3D &sam9260,
>  	},
>  	{
>  		.compatible =3D "atmel,sama5d3-rstc",
> -		.data =3D (void *)(AT91_RSTC_KEY | AT91_RSTC_PERRST |
> -				 AT91_RSTC_PROCRST)
> +		.data =3D &sam9260,
>  	},
>  	{
>  		.compatible =3D "atmel,samx7-rstc",
> -		.data =3D (void *)(AT91_RSTC_KEY | AT91_RSTC_PROCRST)
> +		.data =3D &samx7,
>  	},
>  	{
>  		.compatible =3D "microchip,sam9x60-rstc",
> -		.data =3D (void *)(AT91_RSTC_KEY | AT91_RSTC_PROCRST)
> +		.data =3D &samx7,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -204,6 +219,7 @@ MODULE_DEVICE_TABLE(of, at91_reset_of_match);
>  static int __init at91_reset_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
> +	const struct at91_reset_data *data;
>  	struct at91_reset *reset;
>  	struct device_node *np;
>  	int ret, idx =3D 0;
> @@ -233,9 +249,13 @@ static int __init at91_reset_probe(struct platform_d=
evice *pdev)
>  	}
> =20
>  	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
> +	if (!match || !match->data)
> +		return -ENODEV;
> +
> +	data =3D match->data;

data =3D device_get_match_data(&pdev->dev);
if (!data)
		return -ENODEV;

Otherwise LGTM.

-- Sebastian

>  	reset->nb.notifier_call =3D at91_reset;
>  	reset->nb.priority =3D 192;
> -	reset->args =3D (u32)match->data;
> +	reset->args =3D data->reset_args;
> =20
>  	reset->sclk =3D devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(reset->sclk))
> --=20
> 2.33.0
>=20

--e3iabka34udetqlt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiWTMACgkQ2O7X88g7
+pqFEBAAhZVanjy/8HLzpTLEX5MMG0hTMRcG+h/W2PQHRJqV8memujSFsmxGhwFC
FW6HE6dtpzmtxq+Pf4JdljCt76Pu3Pb0Ggb+HONtPPisaJgsck958RWVmjALrAFE
efgGd6KdxkyJc31YqDnOwSNoV+sFmbjz9luHeGZfEifp233OAOULc4+0db5cElM/
np9YbF2M72T/8kseQJZTeYdhFti9VHHhO/lDDA7z56XS1ZBTem7Z0Fcuh1hyNRZ3
teil1ydJyY8MAZ2/4GgTVzC9UklK4KwpTjJDbc0TdMUGfOqbhXhjCWocOjqhMgsk
5mygLnug/rKdgdJY+SwSGMImRdYv4yTJrtGg1nIiptEX23Z7VA6RZ0BagWufmF2W
dbOBxq7LWO78FouwtZbBirQ8gHd8nZv56Q7lfnQYjxi40KNW+U0Fcu498wHev4gw
w3nzye72NAH+xnEUUMmivXR7QQOnXd5hXnyXI5/Ucj9UOmbg2r6Nv6HDgnhZgYqJ
eJoiJonnTN67N8ja+4zqaBTKQ4UH+E+sEExxuST1g/Fne0RptB2XqLLUOv/i7JVe
1ee4AvdA6nOF+xYb8MWB06V2zgSonuT7Sni7YvRSA5JU1uehfhcHgZONSRLQa73w
FF164Pm9LcJOLyzkZeD0cLvu2xbtd3twMp+o108izbY+yDR3XII=
=P0Hb
-----END PGP SIGNATURE-----

--e3iabka34udetqlt--
