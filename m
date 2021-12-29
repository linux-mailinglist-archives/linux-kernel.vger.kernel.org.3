Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1804810CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbhL2HtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhL2HtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:49:06 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9DBC061574;
        Tue, 28 Dec 2021 23:49:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g2so17860809pgo.9;
        Tue, 28 Dec 2021 23:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ySGrDwcfAoHKrcHz2RP9d9116MO2XUcrj9F6W+JdmuE=;
        b=PYDlKAMHbsleZ0YFDTS2lp2dhKUeMEYeP8mIK34yNzzt3jVqpkwZpisA6RJI6X+L2U
         hx2PhLmZ34nFoN3DuWoSRBLC9HEO3aATDHFtZA4b366eAJ+PUctjhapKmlEVduchQ0z4
         GKlOQhh3d6ju+9uamcmyYA1OkayTXPst4o6e9TXsdxd9VoCyohhNO+JJfjIVObzXSR+G
         RRTtO2npg/QY9mRc4z8a6D1EhCLtSI6Mp0LLdjafRTmkesxuGAluBQA4RGxoPkOOyUz4
         6vnpeZauNDe7yn7QXjxpd52oDxDyVocoKIgG6BcLNG5TR++A7MwAPaYD+HklPiM/KiLT
         9VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ySGrDwcfAoHKrcHz2RP9d9116MO2XUcrj9F6W+JdmuE=;
        b=d+mQa50vtCWDpvHOCtBRfcE6Wib1yxY4giXpFwvt3Jb5VgeX1zmwm/Di18QS3AelrB
         AxomAS4Nkq0Tr9KvYqIxEoL4JXZNKCGGB+NqfgzmxtL3B7cZOTpEaO4lgYX6Abi1l+xF
         K5LWu6Bfvm/cBUbkXwGUMv7BNwkg4cbXftzluesz5na/trx7MYWsVlryBALLqhbOCQYq
         4DQweGASfEAZVcP9PaCN3UXZUotLgWCUcb0DMQRgBb8X3FnhLjwP20EK47GP3wVpv7nK
         wTcNbX42QDIo0ADULgjWv+2cc8cE1J2zmXfLMH2JtlxXdLsxgoNJLmHPxE3E8qZ94RzO
         E3Kw==
X-Gm-Message-State: AOAM531/IHWFW8W3MRZstibzG6z54wXnqryi8fgL7IrwLYKbS2rBFgDR
        4d9MJkbv+Iqhlvbca/3rQqk=
X-Google-Smtp-Source: ABdhPJw/iUNmBjKeK0BjIZk/GpK3pd7105QLEssYSNrZYbk2YemKxVHsOMRZs/XRLRhE1d7u+fSVeA==
X-Received: by 2002:a63:8a4b:: with SMTP id y72mr22500409pgd.1.1640764145507;
        Tue, 28 Dec 2021 23:49:05 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id e16sm21802560pfd.38.2021.12.28.23.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:49:04 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:48:47 +0900
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
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/23] counter: stm32-timer-cnt: Convert to
 counter_priv() wrapper
Message-ID: <YcwS3yszjEd9KhdW@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0hvMYwsk329X9REM"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-13-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0hvMYwsk329X9REM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:15AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/stm32-timer-cnt.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-ti=
mer-cnt.c
> index 0546e932db0c..4b05b198a8d8 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -47,7 +47,7 @@ static const enum counter_function stm32_count_function=
s[] =3D {
>  static int stm32_count_read(struct counter_device *counter,
>  			    struct counter_count *count, u64 *val)
>  {
> -	struct stm32_timer_cnt *const priv =3D counter->priv;
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
>  	u32 cnt;
> =20
>  	regmap_read(priv->regmap, TIM_CNT, &cnt);
> @@ -59,7 +59,7 @@ static int stm32_count_read(struct counter_device *coun=
ter,
>  static int stm32_count_write(struct counter_device *counter,
>  			     struct counter_count *count, const u64 val)
>  {
> -	struct stm32_timer_cnt *const priv =3D counter->priv;
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
>  	u32 ceiling;
> =20
>  	regmap_read(priv->regmap, TIM_ARR, &ceiling);
> @@ -73,7 +73,7 @@ static int stm32_count_function_read(struct counter_dev=
ice *counter,
>  				     struct counter_count *count,
>  				     enum counter_function *function)
>  {
> -	struct stm32_timer_cnt *const priv =3D counter->priv;
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
>  	u32 smcr;
> =20
>  	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> @@ -100,7 +100,7 @@ static int stm32_count_function_write(struct counter_=
device *counter,
>  				      struct counter_count *count,
>  				      enum counter_function function)
>  {
> -	struct stm32_timer_cnt *const priv =3D counter->priv;
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
>  	u32 cr1, sms;
> =20
>  	switch (function) {
> @@ -140,7 +140,7 @@ static int stm32_count_direction_read(struct counter_=
device *counter,
>  				      struct counter_count *count,
>  				      enum counter_count_direction *direction)
>  {
> -	struct stm32_timer_cnt *const priv =3D counter->priv;
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
>  	u32 cr1;
> =20
>  	regmap_read(priv->regmap, TIM_CR1, &cr1);
> @@ -153,7 +153,7 @@ static int stm32_count_direction_read(struct counter_=
device *counter,
>  static int stm32_count_ceiling_read(struct counter_device *counter,
>  				    struct counter_count *count, u64 *ceiling)
>  {
> -	struct stm32_timer_cnt *const priv =3D counter->priv;
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
>  	u32 arr;
> =20
>  	regmap_read(priv->regmap, TIM_ARR, &arr);
> @@ -166,7 +166,7 @@ static int stm32_count_ceiling_read(struct counter_de=
vice *counter,
>  static int stm32_count_ceiling_write(struct counter_device *counter,
>  				     struct counter_count *count, u64 ceiling)
>  {
> -	struct stm32_timer_cnt *const priv =3D counter->priv;
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
> =20
>  	if (ceiling > priv->max_arr)
>  		return -ERANGE;
> @@ -181,7 +181,7 @@ static int stm32_count_ceiling_write(struct counter_d=
evice *counter,
>  static int stm32_count_enable_read(struct counter_device *counter,
>  				   struct counter_count *count, u8 *enable)
>  {
> -	struct stm32_timer_cnt *const priv =3D counter->priv;
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
>  	u32 cr1;
> =20
>  	regmap_read(priv->regmap, TIM_CR1, &cr1);
> @@ -194,7 +194,7 @@ static int stm32_count_enable_read(struct counter_dev=
ice *counter,
>  static int stm32_count_enable_write(struct counter_device *counter,
>  				    struct counter_count *count, u8 enable)
>  {
> -	struct stm32_timer_cnt *const priv =3D counter->priv;
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
>  	u32 cr1;
> =20
>  	if (enable) {
> --=20
> 2.33.0
>=20

--0hvMYwsk329X9REM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMEt8ACgkQhvpINdm7
VJKc3Q//e00ottRDe0JDSIqYtZ73xj5VtyGoSP4JIX1AegUNR3k1Vr6E4GXAm1M1
0JV8JmTevetmeFosjXYI1tI2ojZjAh+TNfpdw+o661KMqxqJ25jcWPHNmCgi3W8K
yGSxf49EQf5oIpoUJlAPM1Ged4s4ZgGd3UiaGrdJrAlA/Hyb2tCCrbMJ1ESOy2wt
vgXvgN4YOWyptlo6zkvsQLLit1Ydh+862idWGnFOxxBsouXR07iN166VTv9P8oxb
NMGIbKlFuKliFzHnJkhqJDY3iIdomyrYMvQz/sVPk8f1ApkcSXW6rH5k7S8Yf8db
Y94F4g7Elg5UiwPcGd5feobaZ5gRO09XhQ+gOXDw+E4WKRR0dX+Z6SprA8xupRoB
C1wDsLP9m6uH4VxSB1uhd3PubPYO+TAH3eR1pI/gUivWhSA19fttH+q2XyBQUbOt
sj3saJeE9JtWJ4k+arXozFA9CTVF7WtD1ilvrefQgDl64kSSMxwMVQflD/xtPWV8
Wbl2oXjeGTilK8EKAWJ2NXPF614i4Z08dkhOgfigk3yh7UasKSCHpvgNDkbSplYp
3AMbhi5lIWqqKRibDVh2RAgyjKHRk6+pf7mQo2FzeFRIrn2JzcLvtp2nL1430A6V
sbrmf1bCVGCGHqZZWdMjpsn93GmZ6vobDqZbsp2pjJGuDlce4BU=
=LvJT
-----END PGP SIGNATURE-----

--0hvMYwsk329X9REM--
