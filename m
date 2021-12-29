Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3634810DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbhL2IN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbhL2IN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:13:56 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F72C061574;
        Wed, 29 Dec 2021 00:13:55 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h1so12140808pls.11;
        Wed, 29 Dec 2021 00:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yGJ3O71LENUOMwQEYz5IKGKFEXlWRMZ+WBWHqHmXGj8=;
        b=P9m9O0z50Jnk2WOC+SxuvYyiYm10PgYpB4vih3EroMVPKNwlLXJgk6OgEn4FEFcy0M
         9JOegxxFyM6dUh5fyNLnafig7UMBsmjtgEfXuQm3q5fVJ7zrct3iqJXUbXu57QPb2CkF
         PLCh2wxCoszSP1e9ZUaZvIHT+L+O0CrWEDeQvVyDhjpvXNTXKekKrvXtRj6ezqJpFuIF
         J7vjwB/+IvLiCMJZJVmUKqB7ICGNlz0zthNLLoanzE67z4wJ7pNTYknX6NxahT1THHWV
         LKZppzCyp2oxy0d++8MGnfC8TE4ElMK/zpa1O8jCBJvRojRVKzE3vf5UsYy/WaDaWkc1
         uCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yGJ3O71LENUOMwQEYz5IKGKFEXlWRMZ+WBWHqHmXGj8=;
        b=r2O35brjxuVxccqb8wuv7wKyxy/4alMv+jhEImJsrN0Jk7gHUZUA6N5eHDNbnwpkZ1
         3m3+nVGdLUfQqjC4YGqbXMCTZ2mbvdE9lTdKbvi4gUGAs3qIkeaVUMTFXav+2HU4rHr5
         QMso9KwjsBABA9Kz6Gj999sgnwv/54WYQhawlerH9KrviPsKySAe7RRSe0fGY08Yp1zm
         3toA7RV8alXGGnwFMfEnNeQi3somVLMsDe8V+W7lwvmpFD+lkAPFKYhmCTi3WHJe6YDn
         T3aK/q6PnS7LEqhFjsgjoXvnhDstAet27M6nc0J0nTlBTYOdgxM2ExqRf5LtYnPA7AKS
         O6Mw==
X-Gm-Message-State: AOAM530iq2POAOacTQXSypvYtgpfjZuhlZ+OzmxiIQKV+hB/CVMc73Wo
        kJBXhX5kbVEyYYnQE1CUDyQ=
X-Google-Smtp-Source: ABdhPJxbWF8H3PicsdIBuEdYKsL2ZtXQF4nF3CDXucnw2BiVoZbTTq8G4c4B8pvpff0dj0PuNk4TGA==
X-Received: by 2002:a17:90a:5781:: with SMTP id g1mr30872517pji.236.1640765635369;
        Wed, 29 Dec 2021 00:13:55 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id s12sm25325757pfg.148.2021.12.29.00.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:13:54 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:13:48 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <YcwYvGtZmjizmEuZ@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gR/93N8d2rVLQZxp"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gR/93N8d2rVLQZxp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:16AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The current implementation gets device lifetime tracking wrong. The
> problem is that allocation of struct counter_device is controlled by the
> individual drivers but this structure contains a struct device that
> might have to live longer than a driver is bound. As a result a command
> sequence like:
>=20
> 	{ sleep 5; echo bang; } > /dev/counter0 &
> 	sleep 1;
> 	echo 40000000.timer:counter > /sys/bus/platform/drivers/stm32-timer-coun=
ter/unbind
>=20
> can keep a reference to the struct device and unbinding results in
> freeing the memory occupied by this device resulting in an oops.
>=20
> This commit provides two new functions (plus some helpers):
>  - counter_alloc() to allocate a struct counter_device that is
>    automatically freed once the embedded struct device is released
>  - counter_add() to register such a device.
>=20
> Note that this commit doesn't fix any issues, all drivers have to be
> converted to these new functions to correct the lifetime problems.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

I agree with the approach taken in this patch, and I don't have much to
add after the suggestions Lars-Peter and Jonathan have already given. So
assuming those are addressed in the next version I expect to Ack this
patch as well.

> ---
>  drivers/counter/counter-core.c | 149 ++++++++++++++++++++++++++++++++-
>  include/linux/counter.h        |  15 ++++
>  2 files changed, 163 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index 00c41f28c101..8261567b6272 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -15,6 +15,7 @@
>  #include <linux/kdev_t.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/wait.h>
> =20
> @@ -24,6 +25,11 @@
>  /* Provides a unique ID for each counter device */
>  static DEFINE_IDA(counter_ida);
> =20
> +struct counter_device_allochelper {
> +	struct counter_device counter;
> +	unsigned long privdata[];
> +};
> +
>  static void counter_device_release(struct device *dev)
>  {
>  	struct counter_device *const counter =3D
> @@ -31,6 +37,9 @@ static void counter_device_release(struct device *dev)
> =20
>  	counter_chrdev_remove(counter);
>  	ida_free(&counter_ida, dev->id);
> +
> +	if (!counter->legacy_device)
> +		kfree(container_of(counter, struct counter_device_allochelper, counter=
));
>  }
> =20
>  static struct device_type counter_device_type =3D {
> @@ -53,7 +62,14 @@ static dev_t counter_devt;
>   */
>  void *counter_priv(const struct counter_device *const counter)
>  {
> -	return counter->priv;
> +	if (counter->legacy_device) {
> +		return counter->priv;
> +	} else {
> +		struct counter_device_allochelper *ch =3D
> +			container_of(counter, struct counter_device_allochelper, counter);
> +
> +		return &ch->privdata;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(counter_priv);
> =20
> @@ -74,6 +90,8 @@ int counter_register(struct counter_device *const count=
er)
>  	int id;
>  	int err;
> =20
> +	counter->legacy_device =3D true;
> +
>  	/* Acquire unique ID */
>  	id =3D ida_alloc(&counter_ida, GFP_KERNEL);
>  	if (id < 0)
> @@ -114,6 +132,100 @@ int counter_register(struct counter_device *const c=
ounter)
>  }
>  EXPORT_SYMBOL_GPL(counter_register);
> =20
> +/**
> + * counter_alloc - allocate a counter_device
> + * @sizeof_priv: size of the driver private data
> + *
> + * This is part one of counter registration. The structure is allocated
> + * dynamically to ensure the right lifetime for the embedded struct devi=
ce.
> + *
> + * If this succeeds, call counter_put() to get rid of the counter_device=
 again.
> + */
> +struct counter_device *counter_alloc(size_t sizeof_priv)
> +{
> +	struct counter_device_allochelper *ch;
> +	struct counter_device *counter;
> +	struct device *dev;
> +	int id, err;
> +
> +	ch =3D kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
> +	if (!ch) {
> +		err =3D -ENOMEM;
> +		goto err_alloc_ch;
> +	}
> +
> +	counter =3D &ch->counter;
> +	dev =3D &counter->dev;
> +
> +	/* Acquire unique ID */
> +	err =3D ida_alloc(&counter_ida, GFP_KERNEL);
> +	if (err < 0) {
> +		goto err_ida_alloc;
> +	}
> +	dev->id =3D err;
> +
> +	err =3D counter_chrdev_add(counter);
> +	if (err < 0)
> +		goto err_chrdev_add;
> +
> +	device_initialize(dev);
> +	/* Configure device structure for Counter */
> +	dev->type =3D &counter_device_type;
> +	dev->bus =3D &counter_bus_type;
> +	dev->devt =3D MKDEV(MAJOR(counter_devt), id);
> +
> +	mutex_init(&counter->ops_exist_lock);
> +
> +	return counter;
> +
> +err_chrdev_add:
> +
> +	ida_free(&counter_ida, dev->id);
> +err_ida_alloc:
> +
> +	kfree(ch);
> +err_alloc_ch:
> +
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(counter_alloc);
> +
> +void counter_put(struct counter_device *counter)
> +{
> +	put_device(&counter->dev);
> +}
> +
> +/**
> + * counter_add - complete registration of a counter
> + * @counter: the counter to add
> + *
> + * This is part two of counter registration.
> + *
> + * If this succeeds, call counter_unregister() to get rid of the counter=
_device again.
> + */
> +int counter_add(struct counter_device *counter)
> +{
> +	int err;
> +	struct device *dev =3D &counter->dev;
> +
> +	get_device(&counter->dev);
> +
> +	if (counter->parent) {
> +		dev->parent =3D counter->parent;
> +		dev->of_node =3D counter->parent->of_node;
> +	}
> +
> +	err =3D counter_sysfs_add(counter);
> +	if (err < 0)
> +		return err;
> +
> +	/* implies device_add(dev) */
> +	err =3D cdev_device_add(&counter->chrdev, dev);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(counter_add);
> +
>  /**
>   * counter_unregister - unregister Counter from the system
>   * @counter:	pointer to Counter to unregister
> @@ -168,6 +280,41 @@ int devm_counter_register(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_counter_register);
> =20
> +static void devm_counter_put(void *counter)
> +{
> +	counter_put(counter);
> +}
> +
> +struct counter_device *devm_counter_alloc(struct device *dev, size_t siz=
eof_priv)
> +{
> +	struct counter_device *counter;
> +	int err;
> +
> +	counter =3D counter_alloc(sizeof_priv);
> +	if (IS_ERR(counter))
> +		return counter;
> +
> +	err =3D devm_add_action_or_reset(dev, devm_counter_put, counter);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	return counter;
> +}
> +EXPORT_SYMBOL_GPL(devm_counter_alloc);
> +
> +int devm_counter_add(struct device *dev,
> +		     struct counter_device *const counter)
> +{
> +	int err;
> +
> +	err =3D counter_add(counter);
> +	if (err < 0)
> +		return err;
> +
> +	return devm_add_action_or_reset(dev, devm_counter_release, counter);
> +}
> +EXPORT_SYMBOL_GPL(devm_counter_add);
> +
>  #define COUNTER_DEV_MAX 256
> =20
>  static int __init counter_init(void)
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 8daaa38c71d8..f1350a43cd48 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -327,14 +327,29 @@ struct counter_device {
>  	spinlock_t events_in_lock;
>  	struct mutex events_out_lock;
>  	struct mutex ops_exist_lock;
> +
> +	/*
> +	 * This can go away once all drivers are converted to
> +	 * counter_alloc()/counter_add().
> +	 */
> +	bool legacy_device;
>  };
> =20
>  void *counter_priv(const struct counter_device *const counter);
> =20
>  int counter_register(struct counter_device *const counter);
> +
> +struct counter_device *counter_alloc(size_t sizeof_priv);
> +void counter_put(struct counter_device *const counter);
> +int counter_add(struct counter_device *const counter);
> +
>  void counter_unregister(struct counter_device *const counter);
>  int devm_counter_register(struct device *dev,
>  			  struct counter_device *const counter);
> +struct counter_device *devm_counter_alloc(struct device *dev,
> +					  size_t sizeof_priv);
> +int devm_counter_add(struct device *dev,
> +		     struct counter_device *const counter);
>  void counter_push_event(struct counter_device *const counter, const u8 e=
vent,
>  			const u8 channel);
> =20
> --=20
> 2.33.0
>=20

--gR/93N8d2rVLQZxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMGLwACgkQhvpINdm7
VJItTBAAn9r8ZjYDLu1PfeD0mLM2NCiDP+SMwyfOBT4nxGNOLE6v0bs2jaKgGAlA
v+vaA2+/rKznzt3Aw6BfQKCuB+uJoJ4WIRV2OUqM/ziEE3JQqKXSPEnE2Iv3YION
cZF1E3hrL87Mz6YzUu6lDFxTjGU6wK7wZggoScHiPNk+BnldKbilvj+9gNmwoZu+
UAkWOQoyNujycG7WCtOQ72HE3sDrH0VacPaocgXrJ+YBzP9DQj/PwR9V0KwxIOOA
lmjpSLLZB/01XZe/FSk57KWnI3MAXWmjqGhaXR7eQ3wVwzV5WATJtBnP4TXiQ1Qs
Y4yIkjb9/w3fD6dFV266Im5nTLSfIFrQzVpYUtIxsP8tQ+2vG5jC6baoSHSlMIuv
D+cR1DMjNi5ppoa5iZ68fENdEJm9em9I/KUAN1faRyCGsx202Bj9Dol86qAjxKVh
6k4/mErP1YNN/xf9nKR01XeGs++OVAVF/riWj45mChl7TdzfoUr4j/DBgFTw2bVb
BSNkJEXQcV4JD6wDdmxGhXQFfaWoc54+HzwP7I4zL3QY1Abt4iYqLsu+lb7PzeOR
2w8FLhuxveu0dVXCiWRYqc/3s05Sw+7bNE741tU9XwYbepOd78d97Byfcvr0kAOr
qZuKXp6AqOFk6kV2YOciMjiLcrED0iZAPAXrfektZyGUP3DnvkA=
=TA0s
-----END PGP SIGNATURE-----

--gR/93N8d2rVLQZxp--
