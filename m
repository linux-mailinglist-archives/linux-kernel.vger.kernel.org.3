Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3EA4810FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhL2Igf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhL2Ige (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:36:34 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AC1C061574;
        Wed, 29 Dec 2021 00:36:33 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id s15so18228083pfk.6;
        Wed, 29 Dec 2021 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/nHngCKdSFl2L8mKWYR4qf7O+mCJxAs1zOQccFzVbo=;
        b=XnypK7+J436OupgLiJaptzQtAXlscTzPvuij7TBq9gWA+BXqbo+D3o2mv1YvL+YY7I
         uHSJTPj0Wm6wq4V9M5D7eema4oolQv75wiO3ZqaPxK4LeYaPPe3UN4ZdpFglcwu+Ts8B
         RYbQWpsZHPgWN4o2E5SibvYFKUej+zvnLKVVFw9ZbfQOe4EDjU8atJZsfnIUO7TgdgK1
         Z3I3ksQbFA4LV75lErzkv8w8kXLAvHB3mtMvfo+a14ttzx8eM/imFYJc3EbKRF2wuU8z
         mCD68lfsOZXYOfejFXMkn+eahhFKn67Mim3xv0KBQ4Wc4WjbnRXC/gtbI9fdrTp/rixA
         2H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/nHngCKdSFl2L8mKWYR4qf7O+mCJxAs1zOQccFzVbo=;
        b=a0eBkMjBmn2vTfZDEBfA4VmEaUmn6lO95bd91YAFjGoi/LtOhQPl/98ERRcvkOOsCt
         Gx8542hK/HayzHTp6h/qOS3aD8XSB1NNoEHP0b/Gxo64Md2a41Rwdm19RwBr4WvGCdc+
         nnVyCHiuAgAi1EdjjQQz6Ll5lFuiHPMhjXjC1vIzVGYGcuSuaSy8fA1RaJZDA2AX0nS6
         WVGwtPetbsLHWRuzL7oEKYbJgFN4AwsRFrvuDd6mWJYVYfyZzYpJRaDK0rl/nAUMv2v8
         e/i76I+Hfx5yasjCIDjZ2ymSxS8P7bcWZ/SAhVvhl1qanmXsFad/sjwY45LTlOO70DGG
         X08Q==
X-Gm-Message-State: AOAM5303Xz5o6gjM3k9nheH9h+z55tvuZlILrcEdqiquOvD7i53lRy3J
        4oKnGeCG+62PkG4q5Z+eFbjOntqsNYRk7A==
X-Google-Smtp-Source: ABdhPJx2Ik2AX+zj1kru7NrgF84lq+nR5ikzsBsuJjB5vu/brk8XOTkpuc3vE1DcNde//q6S4ao3OQ==
X-Received: by 2002:a63:8c5a:: with SMTP id q26mr20013812pgn.17.1640766993309;
        Wed, 29 Dec 2021 00:36:33 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id l2sm21099803pfu.13.2021.12.29.00.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:36:32 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:36:26 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v2 19/23] counter: microchip-tcb-capture: Convert to new
 counter registration
Message-ID: <YcweCjIQhdnluRdt@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-20-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OOlutl4g9gQmOBVS"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-20-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OOlutl4g9gQmOBVS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:22AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
>=20
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/microchip-tcb-capture.c | 30 ++++++++++++++-----------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index 1b56b7444668..70c1d28546be 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -24,7 +24,6 @@
> =20
>  struct mchp_tc_data {
>  	const struct atmel_tcb_config *tc_cfg;
> -	struct counter_device counter;
>  	struct regmap *regmap;
>  	int qdec_mode;
>  	int num_channels;
> @@ -296,6 +295,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
>  	struct device_node *np =3D pdev->dev.of_node;
>  	const struct atmel_tcb_config *tcb_config;
>  	const struct of_device_id *match;
> +	struct counter_device *counter;
>  	struct mchp_tc_data *priv;
>  	char clk_name[7];
>  	struct regmap *regmap;
> @@ -303,9 +303,10 @@ static int mchp_tc_probe(struct platform_device *pde=
v)
>  	int channel;
>  	int ret, i;
> =20
> -	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter =3D devm_counter_alloc(&pdev->dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> +	priv =3D counter_priv(counter);
> =20
>  	match =3D of_match_node(atmel_tc_of_match, np->parent);
>  	tcb_config =3D match->data;
> @@ -360,16 +361,19 @@ static int mchp_tc_probe(struct platform_device *pd=
ev)
> =20
>  	priv->tc_cfg =3D tcb_config;
>  	priv->regmap =3D regmap;
> -	priv->counter.name =3D dev_name(&pdev->dev);
> -	priv->counter.parent =3D &pdev->dev;
> -	priv->counter.ops =3D &mchp_tc_ops;
> -	priv->counter.num_counts =3D ARRAY_SIZE(mchp_tc_counts);
> -	priv->counter.counts =3D mchp_tc_counts;
> -	priv->counter.num_signals =3D ARRAY_SIZE(mchp_tc_count_signals);
> -	priv->counter.signals =3D mchp_tc_count_signals;
> -	priv->counter.priv =3D priv;
> -
> -	return devm_counter_register(&pdev->dev, &priv->counter);
> +	counter->name =3D dev_name(&pdev->dev);
> +	counter->parent =3D &pdev->dev;
> +	counter->ops =3D &mchp_tc_ops;
> +	counter->num_counts =3D ARRAY_SIZE(mchp_tc_counts);
> +	counter->counts =3D mchp_tc_counts;
> +	counter->num_signals =3D ARRAY_SIZE(mchp_tc_count_signals);
> +	counter->signals =3D mchp_tc_count_signals;
> +
> +	ret =3D devm_counter_add(&pdev->dev, counter);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
> +=20
> +	return 0;
>  }
> =20
>  static const struct of_device_id mchp_tc_dt_ids[] =3D {
> --=20
> 2.33.0
>=20

--OOlutl4g9gQmOBVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMHgoACgkQhvpINdm7
VJIiyxAArtKxtZAAQL57orswFFIAnOIHT5PbN9yZAx5aE4K5vtwzQJwNAX+N88nk
Y7qZDoB+i2Z4tOw845zW0gBbu/yKE+flkySVSPAug4DoaAr3rTLCjlku2yW3ckch
V4A93SKlxRfb42tSesmV0ZGv184GGSBwsQC4KmwL91tUMYmIQym+XNyuSWsYZoM8
svDeaXxxa6VEl0bqpZv51wpfpucFsWu3ACIg5I6g2ZVER8LcvFAQDGPiq216kELY
6tPtxSzzXygB1Gm6DlFe7WqTHeB9hr/BVb46rHg0K50tbtgLeJkKCfEoMJYTy95Q
BYYszs9tmI8u5haBR7YkwM/jbDN4Ft7vP4+ayiTPyZwdlCk99Ml/T/lQgV6muqxB
7yfeTFtdjvGWNaU1pTaWjI/pe7sM4YRYmm+DkIFp+76dOHCCc/5JyIsKg+zSMnzl
UJHeDwC8YhThKMNXlijHT96vGmvF/XjhIMw5+TibBhV2USd2ZPyeBp7UvZMUvTB2
N43OogqJt/q+7ig/pkkWZt72GNHiWb6Zp0vrIE7zfCSh9CZXboXvcmH3b+q3TNhn
X85DA+edUAyiBA9cuh5v5KVZDJWqP32tNEXGJERWUN+6LuYoZuJjTXmfPjKEwC/p
Cy62fpP0Rrgtb8J72KItNxWJQ3xaR0LQDpa1Viht2uj9a64RQAU=
=gwtd
-----END PGP SIGNATURE-----

--OOlutl4g9gQmOBVS--
