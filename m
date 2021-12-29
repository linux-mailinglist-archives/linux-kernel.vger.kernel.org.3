Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84B34810FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbhL2Iht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhL2Ihs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:37:48 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CBBC061574;
        Wed, 29 Dec 2021 00:37:47 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b22so18218547pfb.5;
        Wed, 29 Dec 2021 00:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tp9+ts4r4iSaag9XVPpRfX+PmWxIsRRvBCN5AJ9Jbp0=;
        b=E71yWLJgveFDrNB/h4TyPaq9V4bEQa34H7CfZUPtrmDsh0w4MGmJ0xk380p8y9xM4l
         8dkVp530toEoSSN/+qj8ECEQwx9b9+tU7ppcG8INT2ZS1brMpyLlIGV/ZBWfOEEMJdtx
         tz+o79TLsm/6JcbN0xMLnf/AaSp8+BSV6bJVjAt5bUTyzRVpuElHJX3UjNa9kKSdGs3e
         6KTMW+pdJ7ld126fgRIFUmLDYDOQInUnBYBh73HfDGxYhf6iaIK9w3jd3L7VgGjdPmrr
         FjMabUZ3UHOJfv0FnaodRvjxcXOuXQQbo6nLeDp3Wa4QJJFMAhSz7WGLIcym25pfYnVO
         R69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tp9+ts4r4iSaag9XVPpRfX+PmWxIsRRvBCN5AJ9Jbp0=;
        b=se6Uixkh8jsKZ1/w+GuC7VqXuOVDEtrGsLoYG+2Ix92SGzDf2GMEV7UZTdCXGm23mD
         Eud1eL1KJVJl8R9ncH+X1glm/LmO42O7vVz9eOeTw8B/KzUNjywqQULqpOovRVRoVJSt
         +6OpMDWWldDMWAG/qz8MmCHpPIoaVUsodC8YB62WWTdfdWIT131vQ4jcM+7XHEr22Q9b
         ONH0UBnNOxh4Xbhak5pcJseHFGPxfaOo6t6hyjvdkC04ONAdffWqo8nO0sjJO9bUb9ZP
         tOxjZRORG+oE2urz1Zi1cNJkEFxL6wxd9twuSBuzqAQ3ZdPeaVZESCrFJ/cwo9ca8LrD
         fymQ==
X-Gm-Message-State: AOAM532YZ8w7yJqCql0iPYAJy4kcY7Tyifm4a8eooFB2uer2htJ4lK9B
        YnZLw0TYj/Gc8T+qzOasCjRznMSX1Pm/Zg==
X-Google-Smtp-Source: ABdhPJxbpL2ZJYwix7EvOYhO3g/40cJ/p+DflzW/feyAqcRbJgnZl2H7HlSKIjGvIf3RbxQvtgHGUw==
X-Received: by 2002:a63:f5e:: with SMTP id 30mr22764170pgp.487.1640767067433;
        Wed, 29 Dec 2021 00:37:47 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id e12sm15562128pjs.35.2021.12.29.00.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:37:46 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:37:34 +0900
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
Subject: Re: [PATCH v2 20/23] counter: stm32-timer-cnt: Convert to new
 counter registration
Message-ID: <YcweTgHPyTa8ARF5@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-21-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M61Nh2MdAynJs2z/"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-21-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M61Nh2MdAynJs2z/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:23AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
>=20
> Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/stm32-timer-cnt.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-ti=
mer-cnt.c
> index 4b05b198a8d8..5779ae7c73cf 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -29,7 +29,6 @@ struct stm32_timer_regs {
>  };
> =20
>  struct stm32_timer_cnt {
> -	struct counter_device counter;
>  	struct regmap *regmap;
>  	struct clk *clk;
>  	u32 max_arr;
> @@ -317,31 +316,38 @@ static int stm32_timer_cnt_probe(struct platform_de=
vice *pdev)
>  	struct stm32_timers *ddata =3D dev_get_drvdata(pdev->dev.parent);
>  	struct device *dev =3D &pdev->dev;
>  	struct stm32_timer_cnt *priv;
> +	struct counter_device *counter;
> +	int ret;
> =20
>  	if (IS_ERR_OR_NULL(ddata))
>  		return -EINVAL;
> =20
> -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter =3D devm_counter_alloc(dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> =20
> +	priv =3D counter_priv(counter);
> +
>  	priv->regmap =3D ddata->regmap;
>  	priv->clk =3D ddata->clk;
>  	priv->max_arr =3D ddata->max_arr;
> =20
> -	priv->counter.name =3D dev_name(dev);
> -	priv->counter.parent =3D dev;
> -	priv->counter.ops =3D &stm32_timer_cnt_ops;
> -	priv->counter.counts =3D &stm32_counts;
> -	priv->counter.num_counts =3D 1;
> -	priv->counter.signals =3D stm32_signals;
> -	priv->counter.num_signals =3D ARRAY_SIZE(stm32_signals);
> -	priv->counter.priv =3D priv;
> +	counter->name =3D dev_name(dev);
> +	counter->parent =3D dev;
> +	counter->ops =3D &stm32_timer_cnt_ops;
> +	counter->counts =3D &stm32_counts;
> +	counter->num_counts =3D 1;
> +	counter->signals =3D stm32_signals;
> +	counter->num_signals =3D ARRAY_SIZE(stm32_signals);
> =20
>  	platform_set_drvdata(pdev, priv);
> =20
>  	/* Register Counter device */
> -	return devm_counter_register(dev, &priv->counter);
> +	ret =3D devm_counter_add(dev, counter);
> +	if (ret < 0)
> +		dev_err_probe(dev, ret, "Failed to add counter\n");
> +
> +	return ret;
>  }
> =20
>  static int __maybe_unused stm32_timer_cnt_suspend(struct device *dev)
> --=20
> 2.33.0
>=20

--M61Nh2MdAynJs2z/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMHk0ACgkQhvpINdm7
VJKtvA//eCpZQDQfpyoCqlfr7K3oDTL+eoMaDC4q3bECuJzsTfXVq6QfyyOaKWW0
Wqp/zk0lBu2DWC7nK7Fk9S03F4Eu0VEpEd02RPIstYt9vuIq/NBCbp4BkePREEox
G24XpTA3rC7I5KKua8OTPmiSxF1OZF72L8ah0wTi8TzB4ovB0Uq9WGoghr2CpJ66
4yWZh5F1NJ3hw8lmjnw+PV/rwrWYntZonuc5OcLIPquB7Zze+8THrE548AgWynaK
NVXLpYnjI7UqwwRjj+wV5mX/KqPZdXi5ForsNcHNo0St74t/af3hiIJPDXAH/mwq
8WDoSEZQHY822BdS7dc1umkQhucNZLnhLm6hXFWywC9JjgplWvKT8U81G2nFKyy3
lcDDNuXMPfG6u0h11wvQi5zRAveGxWeXZkysC7NiBXP75pvjq2Be19wPg2UoqlJj
XQzmdJuvlwWcj/hl8iw5/FMxfbE6VAjCVOcE4n7vJ9fWEsoR/F1mX/BqbYV4Umwa
jdCNVde4m6eca6/YR0178IR+wBUCfBBARpzN+iB06ZEDcVpsTtCB3Yy3U9S5QSem
KgGJmUWSaEKxnW8Ox9WOBtbBSRdiCpuFn7xtz/QOUSUDYSwH1XGb325/SsNzD7bv
1EJJNcNwR5B8XVX/8EKrJIInhMQBZFnXHzSGzn8VbMKX2LmSpm8=
=3OIs
-----END PGP SIGNATURE-----

--M61Nh2MdAynJs2z/--
