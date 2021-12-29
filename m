Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A14810EF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbhL2I16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbhL2I16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:27:58 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0FFC061574;
        Wed, 29 Dec 2021 00:27:57 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u16so15380278plg.9;
        Wed, 29 Dec 2021 00:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+8C1GU84TDl6ORwgS/V5ZpMNMQj/nCZJT8zkT7dQ4gI=;
        b=H4VnVQenjBnmrI0yxneT63Tf9K8F1Om3xon9Ih5Q5rym2mgkLNhhLUVyEZcanqxDrb
         +w10vpte+o9VuM4fWvY0DfSD2Kqo5cKuuzqlllEWFEwYzLKPnebhfXk/jcXaaVRQjxfW
         GLTNav/8WJrrVnlT6dwl2feRPz2gqkigOnRFYsQtYwP2qXvw6Sz2wHdY04k7NOo6sQ/i
         VC1Qhz9LjaqqALodqr7hsKDYbXbA3hV6MIFfTeow9u28rn9KIbj55FoOa310IOZV504H
         rP7glBERfvV3Yu+e+OszwSQNJo1JpQgNVSUhngufBhYNKxb68f08D5FRo6X/wxkK84+D
         vACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+8C1GU84TDl6ORwgS/V5ZpMNMQj/nCZJT8zkT7dQ4gI=;
        b=ZkYRn02nIV5PRA56B4lOVpr4jMGtAJ6cCUZX8GpYVi8VmJ6riLg+37/5PhOxg1njRf
         Sk3i60RM6rIa6zg1AnO2qqFwoxrqpQJ+IUY9kKAty/cCzU9fcJHCsbJg0HAxFZ1Df0zk
         8eJyGsa2YiLwXapiZVTYFaTb0FMLqh0LB997UNYnZaScq1guRMmGwAuyIjhpei1oOR/g
         XnYThY7E7wead01P10kGZuxZkkBn23XPnCaLJ6mEDvI+LQz/HVqeWJFt8W7WrpFesib6
         72LxUs29BadiCU0a46ZFrIzBzTuFeKFsX7JvHa1IYC5wUCMtrfsuFmDoJp5dHUepJOZL
         hIAg==
X-Gm-Message-State: AOAM533KogCnRYhPZCa+WyomX/5PsapIYBrFeENKo1h1hWNGp2p9zaI+
        3Tsoqaw143Sj5brmXUubAhY=
X-Google-Smtp-Source: ABdhPJxDprPVuZBtmOGAGsyhIilvyJSKXNz3f9l/O5qIz8y5x1faD1+17Jfy7YtUORwsgLD5wcTfVw==
X-Received: by 2002:a17:90a:628c:: with SMTP id d12mr31383951pjj.75.1640766477412;
        Wed, 29 Dec 2021 00:27:57 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id o11sm23893526pfu.150.2021.12.29.00.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:27:56 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:27:45 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH v2 16/23] counter: interrupt-cnt: Convert to new counter
 registration
Message-ID: <YcwcAaAnxHF02bzf@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-17-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eWPHf4Ld+wG5Q4gS"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-17-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eWPHf4Ld+wG5Q4gS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:19AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
>=20
> Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/interrupt-cnt.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-=
cnt.c
> index 4bf706ef46e2..9e99702470c2 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -16,7 +16,6 @@
> =20
>  struct interrupt_cnt_priv {
>  	atomic_t count;
> -	struct counter_device counter;
>  	struct gpio_desc *gpio;
>  	int irq;
>  	bool enabled;
> @@ -148,12 +147,14 @@ static const struct counter_ops interrupt_cnt_ops =
=3D {
>  static int interrupt_cnt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> +	struct counter_device *counter;
>  	struct interrupt_cnt_priv *priv;
>  	int ret;
> =20
> -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter =3D devm_counter_alloc(dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> +	priv =3D counter_priv(counter);
> =20
>  	priv->irq =3D platform_get_irq_optional(pdev,  0);
>  	if (priv->irq =3D=3D -ENXIO)
> @@ -184,8 +185,8 @@ static int interrupt_cnt_probe(struct platform_device=
 *pdev)
>  	if (!priv->signals.name)
>  		return -ENOMEM;
> =20
> -	priv->counter.signals =3D &priv->signals;
> -	priv->counter.num_signals =3D 1;
> +	counter->signals =3D &priv->signals;
> +	counter->num_signals =3D 1;
> =20
>  	priv->synapses.actions_list =3D interrupt_cnt_synapse_actions;
>  	priv->synapses.num_actions =3D ARRAY_SIZE(interrupt_cnt_synapse_actions=
);
> @@ -199,12 +200,11 @@ static int interrupt_cnt_probe(struct platform_devi=
ce *pdev)
>  	priv->cnts.ext =3D interrupt_cnt_ext;
>  	priv->cnts.num_ext =3D ARRAY_SIZE(interrupt_cnt_ext);
> =20
> -	priv->counter.priv =3D priv;
> -	priv->counter.name =3D dev_name(dev);
> -	priv->counter.parent =3D dev;
> -	priv->counter.ops =3D &interrupt_cnt_ops;
> -	priv->counter.counts =3D &priv->cnts;
> -	priv->counter.num_counts =3D 1;
> +	counter->name =3D dev_name(dev);
> +	counter->parent =3D dev;
> +	counter->ops =3D &interrupt_cnt_ops;
> +	counter->counts =3D &priv->cnts;
> +	counter->num_counts =3D 1;
> =20
>  	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
>  	ret =3D devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
> @@ -213,7 +213,11 @@ static int interrupt_cnt_probe(struct platform_devic=
e *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	return devm_counter_register(dev, &priv->counter);
> +	ret =3D devm_counter_add(dev, counter);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add counter\n");
> +
> +	return 0;
>  }
> =20
>  static const struct of_device_id interrupt_cnt_of_match[] =3D {
> --=20
> 2.33.0
>=20

--eWPHf4Ld+wG5Q4gS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMHAEACgkQhvpINdm7
VJJotBAAwp/Mq2GkFaK6GjeBujDhlm5xzLgw+hBIy609y2+Rl6/5ol0tptM9NPWP
mzWI0hS4L/pIWGnz7PHYGgT7c682Mv/GecUgTYVRDSLEIn8oPJEAsywdLt2MrBdi
0JmxL7YBcJN3ZDGDDqffk6sJ1P4789wFHGzEsRwTgtUYhHuIZf2B+yqhVj7sDagT
FlFJq3c/P9zzKTuBV5mbkCQaaJ921TGcoYtVhuFNIqgRHPOQEvoNBuJHhpEciDF2
UjcsH5PgPETlUHg7cmvNVcgMc/sit3jHRfptDyIn3p5KP6CMaq1JWSGB7/Z8HJg8
Bp+4JmtBv3i1QSQ/T7pcTxdFlw08X2iNx37NH07TFbk37f7JRmj1K/movPZawZkb
chblp2c5vwabw1FLwzW6q2/bxqYi9jRE/X2oSCXIXnRnhIwJf8wlTI3+RjI4wWu3
1/wKu2C65Cv6dbSsabCNUk1nHqFT7tmRr65gjWG9S0y3SYJ76ZZkqwSLgTNUQ5td
91TMevOxweHHADlCD7LZpSGhtL0ZCtcrsDtofzhfNUNZSqkDTGeKfCESIbYa/CS4
EEks7xMz5yotdXhfA/ckrkmtX31rIaq/D4eDtKh82eDDN/GWPeNQ1xWGCTUtH7PA
XVxdl4W2ZJUPGTuHHLKVj7WwQWpeotwbYhT+x/zPvy2m6QafCqs=
=lvRq
-----END PGP SIGNATURE-----

--eWPHf4Ld+wG5Q4gS--
