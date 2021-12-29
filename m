Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0704810C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbhL2HsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhL2HsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:48:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633BCC061574;
        Tue, 28 Dec 2021 23:48:21 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z3so15322779plg.8;
        Tue, 28 Dec 2021 23:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=60Mrnhs4zKvfi4PhPJEk/cjsSt90DKSAIOfk3k8YD0U=;
        b=DkLkCvyQg2u5LtzafnSnzOfTLv+TQzPw3s8NcChuYtXcAlrbzemm+WbSwVG2a2L2WJ
         HHxYv8YHHvDdZWUO1lYmkDY1oWmsKCOdJHybGBvApIx9Korscbk64xF6F47+WRSTY5oN
         NFy/zgvJg6bsAwH8npnsQM2nqYQMcoCuqBqFR1htpb3mqr0VjIv59vgtovde36bHO3FL
         XzEySZ7YIKW3LL9m9bOVWKlCQHK4vI18LJqbEGLLhqAFlDvdHNIecijoEqA1HVd05xhd
         UJGxXe8ZJ7V3usrq2TLbcGXck4bZK3qnNUt12cuDXsCjyx9kAXLOgkZrHg5gDrAVRhUV
         qucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=60Mrnhs4zKvfi4PhPJEk/cjsSt90DKSAIOfk3k8YD0U=;
        b=b8Ms/572tuXVrCETnfTGk+Rjqb/1erVlYpxIlb8LQzwmNx+7qU+v02sTVrw4Noei9D
         q49dcbyf5jmDzRS915HlSJ/+jDCYcqDj39k1p/2XaCif3knKHXbUusja+B7CVknPVcHP
         EHq8yt5XJYHUZuBhpLzG9n7Huo39Er0QTvf84bTmRIIM8366pjVJe9K5KsqKWozOnUZZ
         4g21ylCA8w1L6zsQfaV1pvfs1gi9hDuMat8iXQ7vGuCVuf03A6FVwB6QTl2Z77+rgIGI
         iQz32sFWvSAhQ5xXXu9+ZEL/jiB1iE7k16Zkn2PvFrXvlxqMxYgDD3/mPMs2jpfDWslk
         AG1g==
X-Gm-Message-State: AOAM532rVISemFghcItWlqU7bor4kD00xHaSTVvZh8p/gTsti/+KVHv6
        VwxDKOWN7QKD3E2VydctjoU=
X-Google-Smtp-Source: ABdhPJwWlIdad0WemQFI47UK8W9kIA4f0axYeH0wlyePkZlpkjkkX+vSsgWz3WV6B8DTHcWQnKxUrg==
X-Received: by 2002:a17:90b:314e:: with SMTP id ip14mr11961363pjb.171.1640764100805;
        Tue, 28 Dec 2021 23:48:20 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id q16sm19111257pfu.31.2021.12.28.23.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:48:20 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:48:07 +0900
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
Subject: Re: [PATCH v2 11/23] counter: stm32-lptimer-cnt: Convert to
 counter_priv() wrapper
Message-ID: <YcwSt4GVHcKML403@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-12-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3sjde2VhNWvPWw0E"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-12-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3sjde2VhNWvPWw0E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:14AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/stm32-lptimer-cnt.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-=
lptimer-cnt.c
> index 5168833b1fdf..9cf00e929cc0 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -141,7 +141,7 @@ static const enum counter_synapse_action stm32_lptim_=
cnt_synapse_actions[] =3D {
>  static int stm32_lptim_cnt_read(struct counter_device *counter,
>  				struct counter_count *count, u64 *val)
>  {
> -	struct stm32_lptim_cnt *const priv =3D counter->priv;
> +	struct stm32_lptim_cnt *const priv =3D counter_priv(counter);
>  	u32 cnt;
>  	int ret;
> =20
> @@ -158,7 +158,7 @@ static int stm32_lptim_cnt_function_read(struct count=
er_device *counter,
>  					 struct counter_count *count,
>  					 enum counter_function *function)
>  {
> -	struct stm32_lptim_cnt *const priv =3D counter->priv;
> +	struct stm32_lptim_cnt *const priv =3D counter_priv(counter);
> =20
>  	if (!priv->quadrature_mode) {
>  		*function =3D COUNTER_FUNCTION_INCREASE;
> @@ -177,7 +177,7 @@ static int stm32_lptim_cnt_function_write(struct coun=
ter_device *counter,
>  					  struct counter_count *count,
>  					  enum counter_function function)
>  {
> -	struct stm32_lptim_cnt *const priv =3D counter->priv;
> +	struct stm32_lptim_cnt *const priv =3D counter_priv(counter);
> =20
>  	if (stm32_lptim_is_enabled(priv))
>  		return -EBUSY;
> @@ -200,7 +200,7 @@ static int stm32_lptim_cnt_enable_read(struct counter=
_device *counter,
>  				       struct counter_count *count,
>  				       u8 *enable)
>  {
> -	struct stm32_lptim_cnt *const priv =3D counter->priv;
> +	struct stm32_lptim_cnt *const priv =3D counter_priv(counter);
>  	int ret;
> =20
>  	ret =3D stm32_lptim_is_enabled(priv);
> @@ -216,7 +216,7 @@ static int stm32_lptim_cnt_enable_write(struct counte=
r_device *counter,
>  					struct counter_count *count,
>  					u8 enable)
>  {
> -	struct stm32_lptim_cnt *const priv =3D counter->priv;
> +	struct stm32_lptim_cnt *const priv =3D counter_priv(counter);
>  	int ret;
> =20
>  	/* Check nobody uses the timer, or already disabled/enabled */
> @@ -241,7 +241,7 @@ static int stm32_lptim_cnt_ceiling_read(struct counte=
r_device *counter,
>  					struct counter_count *count,
>  					u64 *ceiling)
>  {
> -	struct stm32_lptim_cnt *const priv =3D counter->priv;
> +	struct stm32_lptim_cnt *const priv =3D counter_priv(counter);
> =20
>  	*ceiling =3D priv->ceiling;
> =20
> @@ -252,7 +252,7 @@ static int stm32_lptim_cnt_ceiling_write(struct count=
er_device *counter,
>  					 struct counter_count *count,
>  					 u64 ceiling)
>  {
> -	struct stm32_lptim_cnt *const priv =3D counter->priv;
> +	struct stm32_lptim_cnt *const priv =3D counter_priv(counter);
> =20
>  	if (stm32_lptim_is_enabled(priv))
>  		return -EBUSY;
> @@ -277,7 +277,7 @@ static int stm32_lptim_cnt_action_read(struct counter=
_device *counter,
>  				       struct counter_synapse *synapse,
>  				       enum counter_synapse_action *action)
>  {
> -	struct stm32_lptim_cnt *const priv =3D counter->priv;
> +	struct stm32_lptim_cnt *const priv =3D counter_priv(counter);
>  	enum counter_function function;
>  	int err;
> =20
> @@ -321,7 +321,7 @@ static int stm32_lptim_cnt_action_write(struct counte=
r_device *counter,
>  					struct counter_synapse *synapse,
>  					enum counter_synapse_action action)
>  {
> -	struct stm32_lptim_cnt *const priv =3D counter->priv;
> +	struct stm32_lptim_cnt *const priv =3D counter_priv(counter);
>  	enum counter_function function;
>  	int err;
> =20
> --=20
> 2.33.0
>=20

--3sjde2VhNWvPWw0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMErcACgkQhvpINdm7
VJJPShAAnSc7Y6Dl+F+1U3J9qVAIBj7yeJ1+M0pNs9JPybcNGXfVUDMbLGDaW4b6
bEht207yT7lx+V0MmQG3ITMLOFAK9Ozjn0Ky00vGxJFDDATwe4nzUUtmXfNU2iOG
7i93C/FfJcDb0z0rIUYRbI3g/S1c8BwrTm9FoB/waLGJxnr9oRk/e1HO31mMxzp5
UVY6fyR2RIfHfm0/cZrLDNCMy+WuWyOhbELzGIPkYL94fb1j0Y77Pqae5RWRane7
LnGefg/FWSsnbS51IgR7dH3Fxnw2hl9X9GH2QtD5PgWyzoNKLWgsRqEr6ag6rmrf
4expPSyM3j+CwgEKm5bBiW8Y46FGDmk0eRWXdW0xT4VbCzVdsWaBqUQVqB+KUqwh
10jT4TAnwMPI9FI5+mFvbg5tlUbRAi8WIvu89i8TLyKD9x7Za9fsgdhkV8LBcX2Z
P23Zx89AAAZEAxAEx83/5IxSVwQLW8gejLYkEQ7AX1nxVxRRh5mRGeQY5Ntynqbm
92LbkQ0DT5RhSq/pKpHS+1Kd7EVRKbIG5utx6W82h8dkHbWTtEK9C9NcZVo8VJk2
ofk9PDtdEng6DSvtX/GaCvWazK18OUjwa6LxMQw/lOl0zWWvCcsxkx3a9vx7r+7P
xpuR6Jt9zI+RlxNIO12QwjMvF7DQK5s5mOP9AWpA8eFf7G/P03M=
=EB2O
-----END PGP SIGNATURE-----

--3sjde2VhNWvPWw0E--
