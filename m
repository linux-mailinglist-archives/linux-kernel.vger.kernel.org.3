Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF43C481105
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbhL2Ilj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhL2Ili (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:41:38 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50329C061574;
        Wed, 29 Dec 2021 00:41:38 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q3so13925662pfs.7;
        Wed, 29 Dec 2021 00:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kWkEt/sJvHvZzNhu5oBFurjTCqwzIr+reoFm65dU++w=;
        b=RspshJfFybjmZmR0T3QmHWGoc3BabIVVt2XMs61RvZU9Z6/jLNmRDlT5p3YedQmwkm
         nPsNf7RvAUkFmrCm74gHAk7FIq+vQocm3/M4WYfZahoktcQwKOSgwV8yN+2E9nDcT0fw
         HtArTEGap3higKT1Nx7Fhby4p5ZUzww2lFCeFQoLfg4eZdT8ZRTyuJ+Yd6zmxGLTN9Xb
         +5c/c5IRBpzrexEKay94QuoBmIp1w/nund9WfC3z2IQ3ZQcxPSKAw3tCHwcvhJFaQq75
         PH1hjkg/AAKlETkf+s1xmFIw58H5Cjv73G/AsTbt4LoFXgtcHW8J6qXuXjMnKR5uKcNA
         swew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kWkEt/sJvHvZzNhu5oBFurjTCqwzIr+reoFm65dU++w=;
        b=k4olh85DKG7DS1HMOd64x03hP+5PCmTrgb9zslXlMU7zEWkZoua/XIbpwoDd5RIf/t
         MW4Hgu0XD+WPpRHtOH39KyRMH9B3vCBShz2uHoF/L+XK0kyWtWLNNBh/lsyQtLt3q6X2
         gAMciRXhcZJtO09lyrKjCf0faHc+osjw2mXeEKVtxBoZe1mBLM1n9uetoR6Izcer/ROC
         WFz+6Y8oCiDkkxLInk/iOfI2nLstWmhwWYkYNVmZiIIccIHnj4lih3LWorK2Wet+90OY
         INwkgY4jbHPPvte9aeJdrbZtpmXr/rNZ/La5AUg7XYtqNJ+aLJpnZInggb9AdaUmq/ch
         XHRQ==
X-Gm-Message-State: AOAM531UH5Fp+1n1nOj7777YoPsX5EiTfVAse+A/CImt6CYiN08eC46y
        8VUIEN0KzqBynmvjxY8jArI=
X-Google-Smtp-Source: ABdhPJwHdVjtyj1o9HOfanGsep7vWQF0SNckI2pTPpjMDwtgTpI0mzB2QB3na7KOzADblZl0N8m3hQ==
X-Received: by 2002:a63:596:: with SMTP id 144mr22276121pgf.456.1640767297941;
        Wed, 29 Dec 2021 00:41:37 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id z2sm24128099pfe.93.2021.12.29.00.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:41:37 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:41:30 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 22/23] counter: ti-eqep: Convert to new counter
 registration
Message-ID: <YcwfOigZjk+bxp+B@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-23-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cVUPyjwYrZ0sb7K1"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-23-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cVUPyjwYrZ0sb7K1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:25AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
>=20
> Fixes: f213729f6796 ("counter: new TI eQEP driver")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/ti-eqep.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index abeda966e7be..3b49b492d182 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -368,13 +368,15 @@ static const struct regmap_config ti_eqep_regmap16_=
config =3D {
>  static int ti_eqep_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> +	struct counter_device *counter;
>  	struct ti_eqep_cnt *priv;
>  	void __iomem *base;
>  	int err;
> =20
> -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter =3D devm_counter_alloc(dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> +	priv =3D counter_priv(counter);
> =20
>  	base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
> @@ -390,16 +392,15 @@ static int ti_eqep_probe(struct platform_device *pd=
ev)
>  	if (IS_ERR(priv->regmap16))
>  		return PTR_ERR(priv->regmap16);
> =20
> -	priv->counter.name =3D dev_name(dev);
> -	priv->counter.parent =3D dev;
> -	priv->counter.ops =3D &ti_eqep_counter_ops;
> -	priv->counter.counts =3D ti_eqep_counts;
> -	priv->counter.num_counts =3D ARRAY_SIZE(ti_eqep_counts);
> -	priv->counter.signals =3D ti_eqep_signals;
> -	priv->counter.num_signals =3D ARRAY_SIZE(ti_eqep_signals);
> -	priv->counter.priv =3D priv;
> +	counter->name =3D dev_name(dev);
> +	counter->parent =3D dev;
> +	counter->ops =3D &ti_eqep_counter_ops;
> +	counter->counts =3D ti_eqep_counts;
> +	counter->num_counts =3D ARRAY_SIZE(ti_eqep_counts);
> +	counter->signals =3D ti_eqep_signals;
> +	counter->num_signals =3D ARRAY_SIZE(ti_eqep_signals);
> =20
> -	platform_set_drvdata(pdev, priv);
> +	platform_set_drvdata(pdev, counter);
> =20
>  	/*
>  	 * Need to make sure power is turned on. On AM33xx, this comes from the
> @@ -409,7 +410,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
> =20
> -	err =3D counter_register(&priv->counter);
> +	err =3D counter_add(counter);
>  	if (err < 0) {
>  		pm_runtime_put_sync(dev);
>  		pm_runtime_disable(dev);
> @@ -421,10 +422,10 @@ static int ti_eqep_probe(struct platform_device *pd=
ev)
> =20
>  static int ti_eqep_remove(struct platform_device *pdev)
>  {
> -	struct ti_eqep_cnt *priv =3D platform_get_drvdata(pdev);
> +	struct counter_device *counter =3D platform_get_drvdata(pdev);
>  	struct device *dev =3D &pdev->dev;
> =20
> -	counter_unregister(&priv->counter);
> +	counter_unregister(counter);
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
> =20
> --=20
> 2.33.0
>=20

--cVUPyjwYrZ0sb7K1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMHzoACgkQhvpINdm7
VJIq5xAA7BrquYss5E9pB9vfkwvN/eLqHE/gKo0iYQnICyNY5vRdz6Y+z+O7+tY7
KBI9YvPqfGOoPoLhHpe1fZzXjoMzbYMhu/a2+xH3g8sqHAeC/KsXKaPFQh+WXPpL
dZfMGbbxlVHld8b/rDEAqqUMo/HeUYqIBVPCooQCWrMg8gRcTcMUtA9xyM5QVFMY
MNpiT6w4kAgU48HIf9Fv5vLDLnKBDnq/vqGpu5C3/wAAmxWljqh7O0LZ8Fcup8Cg
ZeHlxalZe2sEGEvDyltJ0mFK0lNTFc120D8pQsUeddBKnJ9l/nw4qClJrF5nFcl4
fLm8pn9jHTBW7lexsfW3pmQlZ8CawfI8sQnVo4ZkEZaaEki2ZL+61qAdrxpimRDo
jjf2CxjJn2ikg31Uz4cdhcAuZTPUKa0Urn76OdbWYauTKdwGF7mtu9Ov44ZG2bgG
yN9km25/BpGtRPtPG7jojsYpBs1L+bcbIYclKQ4sWPON4IOMqVu7hK6xjGCIifZM
8Po8Wj8XO/0X26ZC6lyM0GqUOoJzo6mhAMs5HJ+8kZ6bdz2Tt75uKfJ1LGkX+4C8
OQmXTg1jAm6rvp2LwYnysm1m2dWmWJB4WsFBAHznuXJVYGXuJrbwfLKIRrhVBAQJ
RoJXwTIBoClOIwR7p00tToZHkvPkxgYh94e7J+lNzmPIdPjqa7U=
=lQ42
-----END PGP SIGNATURE-----

--cVUPyjwYrZ0sb7K1--
