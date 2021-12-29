Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D384810C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhL2Hpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhL2Hp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:45:29 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98146C061574;
        Tue, 28 Dec 2021 23:45:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so23853515pjo.5;
        Tue, 28 Dec 2021 23:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=42Kv+Bzed5CaN4x/c6tV1/LRES8R5aRZPqIXaAJaFhs=;
        b=Ag2HwnfsJzNCIhp8k8VCbTKw8fn2M6PQcb7VSSN46oZ2KJhcV8d8rwXZJs7SJ2jCi0
         KHnf3/Nwwos6yVdzuqSTMQVcHJ7gJxpA0hM5jE76cDSV53Hc74V1AdXfM+rsxFJtkx9m
         mHeNxGSSk61lTNRDXcJucrN2Hhot9vlRzrvZ8+Ta8u+RMbPB9X+0rWQTPUoYdH1IknUd
         k/jZUXRkRbRpUuW0fldutjcz85zpXWqzJFvQWGSetRxVLt75FeLVcMh6XefMfw/gCtvF
         gylnz7HaOpu3cura9m1sNLkPrKfNYGkbUcUu3LF/xu3w0gUrf6rry0zpDXYf/NnTfHhK
         E+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=42Kv+Bzed5CaN4x/c6tV1/LRES8R5aRZPqIXaAJaFhs=;
        b=59YuP0HsQVHbGuaIikgmFmbhmStCQCbKiddmzdbq8WWljrEpIJPm3zGnzbfQhpR+U1
         UB2ZauM4WU35WNEikAEqS7IW5M7kAS3NW5Qz/qzEBtdgJVuO6TyX2FpK8DRi4hW2Vz1S
         gtV3BB1W6NsjeQQPra6gmGzhc6PTJ6LixR5NxLT1NQgjh4fCBl9csrU/bzOoxLLLkFlp
         BNceFAUN7KQiB7c9xnq1lM3N8zGNcIdDycQli/B9H88ig77jVNox4NQe5RSreX6h/gnN
         ELwVtNWiLb89lGkykB0DK6JXSDXuqXffin2ce8DuFnzQj8w3+cjm2JFqoe4i8SP8b+SU
         40wA==
X-Gm-Message-State: AOAM531Mi6yT4NQKhFZwUScJ/A+uUFw3mYmgP1h7mjORxbnZByk+jwp2
        jr79wvCRgEjY4o5HHDEFmZU=
X-Google-Smtp-Source: ABdhPJy4Q8xbThVnUY1DjEvLvUJVc+uD/GYJd4z6YvuDf08vohSIM5mW4Dk6L8hn7JwxdC2tZoUV4Q==
X-Received: by 2002:a17:902:c443:b0:148:f689:d924 with SMTP id m3-20020a170902c44300b00148f689d924mr25326029plm.78.1640763929114;
        Tue, 28 Dec 2021 23:45:29 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id 27sm16830990pgx.81.2021.12.28.23.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:45:28 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:45:21 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 10/23] counter: ti-eqep: Convert to counter_priv()
 wrapper
Message-ID: <YcwSEX//xHtIUnU1@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3DkZ4PDPCsPbRfDX"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-11-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3DkZ4PDPCsPbRfDX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:13AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

This patch conflicts with commit 60f07e74f86b ("counter: ti-eqep: Use
container_of instead of struct counter_device::priv"). Because that
commit has a similar purpose as this patchset, I'm going to skip this
patch for now and continue looking over the rest of the patches in this
series.

> ---
>  drivers/counter/ti-eqep.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 09817c953f9a..abeda966e7be 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -90,7 +90,7 @@ struct ti_eqep_cnt {
>  static int ti_eqep_count_read(struct counter_device *counter,
>  			      struct counter_count *count, u64 *val)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D counter_priv(counter);
>  	u32 cnt;
> =20
>  	regmap_read(priv->regmap32, QPOSCNT, &cnt);
> @@ -102,7 +102,7 @@ static int ti_eqep_count_read(struct counter_device *=
counter,
>  static int ti_eqep_count_write(struct counter_device *counter,
>  			       struct counter_count *count, u64 val)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D counter_priv(counter);
>  	u32 max;
> =20
>  	regmap_read(priv->regmap32, QPOSMAX, &max);
> @@ -116,7 +116,7 @@ static int ti_eqep_function_read(struct counter_devic=
e *counter,
>  				 struct counter_count *count,
>  				 enum counter_function *function)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D counter_priv(counter);
>  	u32 qdecctl;
> =20
>  	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> @@ -143,7 +143,7 @@ static int ti_eqep_function_write(struct counter_devi=
ce *counter,
>  				  struct counter_count *count,
>  				  enum counter_function function)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D counter_priv(counter);
>  	enum ti_eqep_count_func qsrc;
> =20
>  	switch (function) {
> @@ -173,7 +173,7 @@ static int ti_eqep_action_read(struct counter_device =
*counter,
>  			       struct counter_synapse *synapse,
>  			       enum counter_synapse_action *action)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D counter_priv(counter);
>  	enum counter_function function;
>  	u32 qdecctl;
>  	int err;
> @@ -245,7 +245,7 @@ static int ti_eqep_position_ceiling_read(struct count=
er_device *counter,
>  					 struct counter_count *count,
>  					 u64 *ceiling)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D counter_priv(counter);
>  	u32 qposmax;
> =20
>  	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
> @@ -259,7 +259,7 @@ static int ti_eqep_position_ceiling_write(struct coun=
ter_device *counter,
>  					  struct counter_count *count,
>  					  u64 ceiling)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D counter_priv(counter);
> =20
>  	if (ceiling !=3D (u32)ceiling)
>  		return -ERANGE;
> @@ -272,7 +272,7 @@ static int ti_eqep_position_ceiling_write(struct coun=
ter_device *counter,
>  static int ti_eqep_position_enable_read(struct counter_device *counter,
>  					struct counter_count *count, u8 *enable)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D counter_priv(counter);
>  	u32 qepctl;
> =20
>  	regmap_read(priv->regmap16, QEPCTL, &qepctl);
> @@ -285,7 +285,7 @@ static int ti_eqep_position_enable_read(struct counte=
r_device *counter,
>  static int ti_eqep_position_enable_write(struct counter_device *counter,
>  					 struct counter_count *count, u8 enable)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D counter_priv(counter);
> =20
>  	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : 0);
> =20
> --=20
> 2.33.0
>=20

--3DkZ4PDPCsPbRfDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMEhEACgkQhvpINdm7
VJKN+xAAqirlPQ3PvHwIbksDaZe0l3qyzSFnWLeE2ZT1SkagwOPWkU4mGGUdch/K
U8TSgWdKuczSgL0Zm874HvgWKaseyssqBXcNQOhlW8Ly7CS3M41kl1Okw6e/WAcQ
TrGMT7UMvGwMeMkpeoZlDaur/x48g+oNJp9PSbCHbyfJZTgZ/M9R/6ONa4B5lc1G
XwIWH+WbpjImF1LaTHgXfAWsW+ingC+RHy7RxCejRkBjKtTw5sGcrSYa8dHAjkb9
3q/wG1c1naTIYftV4JweizqYDuI10C0OYMRiTRHLeK2O5O7RTHMIA6+VB/a3JVSd
iBOSS2RcwfC/V9lZXTosWUXSGnJfqh/V0UI8mxe90RoZnsI5wFolZviP6E0pdI9P
kg/S10DzQ+5tL/DyVZuJ4nbyKX0Ivmchxd9tOI854pzC61Vr0nOSkA77ysJyRRYB
sJ7cWgfgQiNQcOssyfrSibYRr6KL/7TylcFJyQH4PXCKY3qHfnH3Q2CmWUCeYnzH
1W3SBW1xd1eAXUBtApp04WekkfZ35f2ZUBGNoEGvOA45Y8gQqCmaBVzvbPRscx4z
gRJHdZQ2FRcatiLepyXMeLNi65+lo9t969YN+Ftdelist4gZVscIP3R+Em9DrEQG
1Thy1YKuYIZ/9ZP2kpw35hPqR6Hg756gW6Nz5pNqEuZoccHAy1k=
=Bshq
-----END PGP SIGNATURE-----

--3DkZ4PDPCsPbRfDX--
