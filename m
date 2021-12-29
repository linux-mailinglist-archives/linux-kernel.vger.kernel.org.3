Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F330C4810B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbhL2Hen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhL2Hel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:34:41 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D28CC061574;
        Tue, 28 Dec 2021 23:34:40 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id a23so17877682pgm.4;
        Tue, 28 Dec 2021 23:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=68RvNb1tApDf1C2ho2mosouwlMJ1fEXlmW9sPJhGLoM=;
        b=SjcaA/dQMd3wOOBtcoC9LntyVWAq0wLeeKZd/2xnh7/q0Y+6CmS47dEtpZ0isse4tw
         xoNSS0XIrH0C6IJBJ3NKH49bTNmyns/O4nJUtaMX9ENUkiU1wyioeaKypBw3RONQSADV
         QQQh70ItN5/iTENM8m8Mjhmu+zbSXOXw5SGjVJOKfHySglYxmoCG5pMN0SeEvjDkjETd
         e+JQ5H15HM1II3pvBWa9AIq12GTIAflSF62+pSTOv+v06ZBGjh3kolt/qR5BpsGKT8Jr
         wfBv1+K0jav+57D//bwz7j38axKewaHtRuTKdeD1GgZ1OkNkgrc6jvRUfUw3Q0AxVW+E
         yKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=68RvNb1tApDf1C2ho2mosouwlMJ1fEXlmW9sPJhGLoM=;
        b=eYQUOAUMvKUQ+zDuLZ+QVytuuZJPEYLzznhg4T/ISiNk+TYgFxN9kp+Ki7l1EUM4gW
         S2U7R16n+M3bJt+jCHHSqUfYFh3ORLmHHGs1KcdIqeru75Th32cn8R0co67m4hObX/Ad
         VtSp+8rIPJ/r/QEkuZH6vvzYD9ToT29mI5DMf/8Vd3IRYs7E/5MrUM4TDrt+B0/E5/l9
         eHLzn/lLmri7VkyEm0lz10wBB2NVauPiVXcquoW9hhEKi1RF0nrJHAAMclHXL+j3xmgS
         GCj52V9GblZLhjKqRAZ5kTRyLlKSoegdj3NhdmRph3R7yCosv+81cnop4iPuAwpnDevb
         oH4w==
X-Gm-Message-State: AOAM533XBDYsqXqBBtgLWRye3FrrxYYYVqz7EofMxzS81poccswaMaeV
        ruPqlGp6hcie8YghqPe++n8=
X-Google-Smtp-Source: ABdhPJxpxs8B9ihQnwp/B1h36KtbVTV71JsymzroYDuqMGISUOYR21kY2vjfmpZTeKLbVptlbgSAHA==
X-Received: by 2002:a63:d6:: with SMTP id 205mr3482848pga.516.1640763280135;
        Tue, 28 Dec 2021 23:34:40 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id ev3sm23932818pjb.48.2021.12.28.23.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:34:39 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:34:22 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v2 06/23] counter: interrupt-cnt: Convert to
 counter_priv() wrapper
Message-ID: <YcwPfuM+Uv2/z9cp@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7FtwvdsWJlTSGidV"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-7-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7FtwvdsWJlTSGidV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:09AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/interrupt-cnt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-=
cnt.c
> index 8514a87fcbee..4bf706ef46e2 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -37,7 +37,7 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev=
_id)
>  static int interrupt_cnt_enable_read(struct counter_device *counter,
>  				     struct counter_count *count, u8 *enable)
>  {
> -	struct interrupt_cnt_priv *priv =3D counter->priv;
> +	struct interrupt_cnt_priv *priv =3D counter_priv(counter);
> =20
>  	*enable =3D priv->enabled;
> =20
> @@ -47,7 +47,7 @@ static int interrupt_cnt_enable_read(struct counter_dev=
ice *counter,
>  static int interrupt_cnt_enable_write(struct counter_device *counter,
>  				      struct counter_count *count, u8 enable)
>  {
> -	struct interrupt_cnt_priv *priv =3D counter->priv;
> +	struct interrupt_cnt_priv *priv =3D counter_priv(counter);
> =20
>  	if (priv->enabled =3D=3D enable)
>  		return 0;
> @@ -85,7 +85,7 @@ static int interrupt_cnt_action_read(struct counter_dev=
ice *counter,
>  static int interrupt_cnt_read(struct counter_device *counter,
>  			      struct counter_count *count, u64 *val)
>  {
> -	struct interrupt_cnt_priv *priv =3D counter->priv;
> +	struct interrupt_cnt_priv *priv =3D counter_priv(counter);
> =20
>  	*val =3D atomic_read(&priv->count);
> =20
> @@ -95,7 +95,7 @@ static int interrupt_cnt_read(struct counter_device *co=
unter,
>  static int interrupt_cnt_write(struct counter_device *counter,
>  			       struct counter_count *count, const u64 val)
>  {
> -	struct interrupt_cnt_priv *priv =3D counter->priv;
> +	struct interrupt_cnt_priv *priv =3D counter_priv(counter);
> =20
>  	if (val !=3D (typeof(priv->count.counter))val)
>  		return -ERANGE;
> @@ -122,7 +122,7 @@ static int interrupt_cnt_signal_read(struct counter_d=
evice *counter,
>  				     struct counter_signal *signal,
>  				     enum counter_signal_level *level)
>  {
> -	struct interrupt_cnt_priv *priv =3D counter->priv;
> +	struct interrupt_cnt_priv *priv =3D counter_priv(counter);
>  	int ret;
> =20
>  	if (!priv->gpio)
> --=20
> 2.33.0
>=20

--7FtwvdsWJlTSGidV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMD34ACgkQhvpINdm7
VJLxIRAAkO2xsvPBCG6P16hAV2I0cXpet2bFbbGP9byViFgp4Tut6geRqPvf8JmI
OblZg/YHtFUZgdRG2epijU0oWMQByCY9jPX2H0pZkWbV+no7FFaSxFTskZ5lOEQ+
HGT7NKm53L9c0VG8zpN+xuwJVqUdCKJY4mmlcC6svFSRbzS2H0gARiA3n6LlQP46
+Ife+tI0xlvKvjPhshRYPxBhuf5BqvS8P5CZO4/FZnGdIHyDvx09N15i262/a7co
WP/3hfQb+dgkQGBge1PJGVQYXHgGapHasC6FicsYJ9lFBHNB15kwk68g9vHS+kXA
mFQCL1kqF5kOKzsZs4zDAtjp6wmZxowGvpJBs6QL+quewy0F+yRREhPwyBe9Yx3z
3I9bsRP7+JYPzCKQUOnLQKLznhANyhaF9i0O1/9fe8YkB2oaTyxJVO9A0byIQ5CL
IABCofSpeO/pl94yHY1Q2tH5TltfUKLdJEbC8ZFJzc2EmszpVgXIJAmIIRxaoiN1
yy1FC1zmvWMG6FJO7qNnVy/jNvl76WQCCmVLkVPL0BUQVWCAxOxAWI89u/RFECOP
a/5EBSP1CaV6vhOR7DIhcrOWDusjy9jGVhSYa4dPJSCUNRuKgst528dU/TDuqSYa
rvXDoiX64gsfLby/edH+BXyh+NetZnI63yiVj7l01SB/7UvPBq8=
=pxsM
-----END PGP SIGNATURE-----

--7FtwvdsWJlTSGidV--
