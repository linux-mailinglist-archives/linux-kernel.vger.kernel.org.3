Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44E481103
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhL2IjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhL2IjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:39:17 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AFCC061574;
        Wed, 29 Dec 2021 00:39:17 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id l15so611306pls.7;
        Wed, 29 Dec 2021 00:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rwgpylQD3xznv5252WPOffHp4v+CVHiecDhyYcwBvBY=;
        b=CxWQKROGnH1pN+FtbS5nC3oOtnNbM3Jp5XCd6IidWWpmkZ/Q4zw0teBk4mx4OVqwdo
         mTKz4IFcsZp0zzawC1K0x87djgfkSaZ49T1Y6uKJeVVN7M7IGdxATcsbUb8Rz6yJpZTY
         K9jUsqPVJM2h2cfjkpO2RXvufrCcxx0Fr3jnE5KX4xxXrjNBWh3jhsUzCjpyTRV2nBwy
         4fgICgB6VBCZMIdGsLcf4Wa8/MiRi1leXCNCblDL08JlZHE4A2T4RiPTdKwxPYVzEZKT
         XlDvdZusy9Xidy3NCDOkQauuUQW18z8AOOH9ocPrWUU9SGUoHphlndXMKlu6tcVdzzIy
         a2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rwgpylQD3xznv5252WPOffHp4v+CVHiecDhyYcwBvBY=;
        b=A7DyKFtxEKh7wcoIC7uiEg2X57BT/+8KL77FxI6OuPgT1/XZ+Mty2QcwB0CFd4zNzm
         Np83ft3UICZ1R3qMRQ/CHOhXCdmFF/GbcrWGvtgtCMnsr9XB0dtndvIL0E5dEL6x/elz
         JUhn9gCRnwNafUbu2+wQ5s1XNLhfG/ejdrXO9dUwc0i4uiyyuKid+/ssZfl1ZIETBIjk
         VJ3SalbTFLyFkuFxjwq1RUfd6xccN+dcUuF6n/r/YWUwc/5eC1AwZJOSrPiVZzJTXpfA
         peKJalHnn+Khak0gu6qMdTH80f737GdahQpN48BQVvPxZ9GUqKfBahUheEjFot1PTXFq
         NNZw==
X-Gm-Message-State: AOAM5312ps6oq8G8eyrlgT1HD4VIRQKwx7PaBF7cPoiIeST570nIQP8S
        hvSlO/czhQ/hRz/EhpecDN0=
X-Google-Smtp-Source: ABdhPJxDBM9mQ+RTBEe/p5HOZeRRYy1+MxqZqQwYwJknCx6F9s85lSIUqiOI9b91jK4Q3aDIDocBag==
X-Received: by 2002:a17:90b:3a86:: with SMTP id om6mr31267026pjb.16.1640767156669;
        Wed, 29 Dec 2021 00:39:16 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id ng7sm23152762pjb.41.2021.12.29.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:39:16 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:39:07 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 21/23] counter: stm32-lptimer-cnt: Convert to new
 counter registration
Message-ID: <YcweqxWiXX/wN4g+@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-22-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jINEkwZdUatBrt71"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-22-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jINEkwZdUatBrt71
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:24AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
>=20
> Fixes: 597f55e3f36c ("counter: stm32-lptimer: add counter device")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/stm32-lptimer-cnt.c | 33 +++++++++++++++++------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-=
lptimer-cnt.c
> index 9cf00e929cc0..68031d93ce89 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -20,7 +20,6 @@
>  #include <linux/types.h>
> =20
>  struct stm32_lptim_cnt {
> -	struct counter_device counter;
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct clk *clk;
> @@ -411,14 +410,17 @@ static struct counter_count stm32_lptim_in1_counts =
=3D {
>  static int stm32_lptim_cnt_probe(struct platform_device *pdev)
>  {
>  	struct stm32_lptimer *ddata =3D dev_get_drvdata(pdev->dev.parent);
> +	struct counter_device *counter;
>  	struct stm32_lptim_cnt *priv;
> +	int ret;
> =20
>  	if (IS_ERR_OR_NULL(ddata))
>  		return -EINVAL;
> =20
> -	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter =3D devm_counter_alloc(&pdev->dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> +	priv =3D counter_priv(counter);
> =20
>  	priv->dev =3D &pdev->dev;
>  	priv->regmap =3D ddata->regmap;
> @@ -426,23 +428,26 @@ static int stm32_lptim_cnt_probe(struct platform_de=
vice *pdev)
>  	priv->ceiling =3D STM32_LPTIM_MAX_ARR;
> =20
>  	/* Initialize Counter device */
> -	priv->counter.name =3D dev_name(&pdev->dev);
> -	priv->counter.parent =3D &pdev->dev;
> -	priv->counter.ops =3D &stm32_lptim_cnt_ops;
> +	counter->name =3D dev_name(&pdev->dev);
> +	counter->parent =3D &pdev->dev;
> +	counter->ops =3D &stm32_lptim_cnt_ops;
>  	if (ddata->has_encoder) {
> -		priv->counter.counts =3D &stm32_lptim_enc_counts;
> -		priv->counter.num_signals =3D ARRAY_SIZE(stm32_lptim_cnt_signals);
> +		counter->counts =3D &stm32_lptim_enc_counts;
> +		counter->num_signals =3D ARRAY_SIZE(stm32_lptim_cnt_signals);
>  	} else {
> -		priv->counter.counts =3D &stm32_lptim_in1_counts;
> -		priv->counter.num_signals =3D 1;
> +		counter->counts =3D &stm32_lptim_in1_counts;
> +		counter->num_signals =3D 1;
>  	}
> -	priv->counter.num_counts =3D 1;
> -	priv->counter.signals =3D stm32_lptim_cnt_signals;
> -	priv->counter.priv =3D priv;
> +	counter->num_counts =3D 1;
> +	counter->signals =3D stm32_lptim_cnt_signals;
> =20
>  	platform_set_drvdata(pdev, priv);
> =20
> -	return devm_counter_register(&pdev->dev, &priv->counter);
> +	ret =3D devm_counter_add(&pdev->dev, counter);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
> +
> +	return 0;
>  }
> =20
>  #ifdef CONFIG_PM_SLEEP
> --=20
> 2.33.0
>=20

--jINEkwZdUatBrt71
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMHqsACgkQhvpINdm7
VJJj0w/+MtS4fndaOqmAscESS+cLhT0mRxGJAiaqWZgpzsnyW8wM/LvD99sK1hB3
XCFexXaQ6EzBEmoLF3T4vf1FUHxFrS0wpNGAxgnSOb0ASSlzRYQ7reUMYzUkeuBO
BWdt4ONDa5n0QGxMmmHmiyiD6Z6puC6l5/0g4Ly5ZXVBrFxoNMXnAuIBW++S2JJ/
5mftVDjY3tkZPRpjZuUJtRyNtoJmrOgG5eJ3Oae+L7ssGTlH+a526j6oxKP/9lKg
XZoo3RwnrfoilBSJepEGLftO1g/iW4SnE7CoHS/CbXJmg5FKqejsza9o6mCfueji
1E/EwxpnJMdKBaH7i1j7pnKEfLGxdvkE4SRNsJxmN7f9MT20j0BGGvfSzBgig8M+
sAuk6nHh/dv3AhPxUwlx8MCX1GyXSRVLWnkgH1DfCf3xbMpppznIzdkLBaOf2B3e
VzFrwmfpS/781qkoiyygPXwqqJiGYG8ks1CYExY73tLwJq0goowKn3V6kvh98xEq
6SgGNgVB+3nx6QFt8RDBz8UrzCMk31o+9WrHGT2WLWkezzeocDoyajqrYEDthL2D
QLxAwYGnzyzVuNnjPDuZYQjUmDtW7r0ljdzcxYkT5jw8uvabltlC7VeyUzS0Bv/p
ZajhNytqNye6er4H5UDyVudh6GoOgXL6D6zcbIO0twbAjXPZ7wc=
=xYTw
-----END PGP SIGNATURE-----

--jINEkwZdUatBrt71--
