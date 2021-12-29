Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6014748110A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbhL2InP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbhL2InO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:43:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8045C061574;
        Wed, 29 Dec 2021 00:43:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so2037860pji.3;
        Wed, 29 Dec 2021 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PK+gcuBagFuhT73ElWOA8lcNyjgycdgAcp9loEQ9J6g=;
        b=SqVyHBTXXcOm3snUDbVMxSBSfeq+3V3PnlyieY7FylghceQahRpr73f2Cs4K/p+7TN
         E3s3KM0RhkgGenziDKsgt44niypXPYWgQ2ennSgQq9o31p+gxHEPMQXkkoaJmtgoEDsx
         JazqN20xrplfUHkdVK5CM8QFxcPzRpIuEE0Hx2CwPCpVsELu94kvK49XrN5uBMWFj638
         jxFER6hMBm5SCOgRJjaN61UU1HlCVZrvUG4EDnVqz2lrS1g58TXQWyPSk4KV/NhW6CjT
         E3Yyfh7tX4Xie/Zx4/mymDDdA1nL4+ARjyCI6bIRedXz85gUz3icqm8EoeD1rWjfryPE
         2O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PK+gcuBagFuhT73ElWOA8lcNyjgycdgAcp9loEQ9J6g=;
        b=6Rri7KnIDKRijY7K1sauZQUB1wGs4UBRe95UDD4JVqlYidI1XHp8vGx5W7wGHl8Ji9
         42V+lW0DpAcQdbcpbOZLcG2B8BvQ/5fHljaVQZfAnvrQQ64EIfRfRksJR7pPA3a9uXI8
         M53AKaPnB32XbNh5uhHFt+GscRw7omMwxphJfDyWdICIvCd51QVx+zO9IGON+WAJNrG9
         n9+z80aP03pr6ICIl0We+FEsHAknQeEBMz5JmsI4bTy5ifyGSvKNQXpIhF/TmIv+wzUG
         DFfLLiMoswb99X3lzl+0q+bieCjk3uzBpTyT8eNe68Zbxrdx+BOuHYr/jkBaslfMJrZc
         gM6g==
X-Gm-Message-State: AOAM530Uq6uVwOttaH3aWuhA16YE/lbvO2I+mrEuW9qn8jvSri5EFXVj
        Vf2TtOM1XPwrk02d8xr2KjNwrDRgOsAwrw==
X-Google-Smtp-Source: ABdhPJyb4p3Pf04TEg0jk37Xsk0lfPUqtu3gAunUm9YpqVR+ym+Da1HIWEdLZZ8hfF45ktgzwidVOg==
X-Received: by 2002:a17:902:8f8a:b0:149:8d21:9f44 with SMTP id z10-20020a1709028f8a00b001498d219f44mr8603023plo.15.1640767394273;
        Wed, 29 Dec 2021 00:43:14 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id l6sm18604005pjt.54.2021.12.29.00.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:43:13 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:43:02 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 23/23] counter: remove old and now unused registration
 API
Message-ID: <YcwflinO09mcEVxi@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-24-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="of2z9Lt2LD3Qm7UO"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-24-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--of2z9Lt2LD3Qm7UO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:26AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Usage of counter_register() yields issues in device lifetime tracking. All
> drivers were converted to the new API, so the old one can go away.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/counter-core.c | 97 ++--------------------------------
>  include/linux/counter.h        | 12 -----
>  2 files changed, 4 insertions(+), 105 deletions(-)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index 8261567b6272..3f7dc5718423 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -38,8 +38,7 @@ static void counter_device_release(struct device *dev)
>  	counter_chrdev_remove(counter);
>  	ida_free(&counter_ida, dev->id);
> =20
> -	if (!counter->legacy_device)
> -		kfree(container_of(counter, struct counter_device_allochelper, counter=
));
> +	kfree(container_of(counter, struct counter_device_allochelper, counter)=
);
>  }
> =20
>  static struct device_type counter_device_type =3D {
> @@ -62,76 +61,13 @@ static dev_t counter_devt;
>   */
>  void *counter_priv(const struct counter_device *const counter)
>  {
> -	if (counter->legacy_device) {
> -		return counter->priv;
> -	} else {
> -		struct counter_device_allochelper *ch =3D
> -			container_of(counter, struct counter_device_allochelper, counter);
> +	struct counter_device_allochelper *ch =3D
> +		container_of(counter, struct counter_device_allochelper, counter);
> =20
> -		return &ch->privdata;
> -	}
> +	return &ch->privdata;
>  }
>  EXPORT_SYMBOL_GPL(counter_priv);
> =20
> -/**
> - * counter_register - register Counter to the system
> - * @counter:	pointer to Counter to register
> - *
> - * This function registers a Counter to the system. A sysfs "counter" di=
rectory
> - * will be created and populated with sysfs attributes correlating with =
the
> - * Counter Signals, Synapses, and Counts respectively.
> - *
> - * RETURNS:
> - * 0 on success, negative error number on failure.
> - */
> -int counter_register(struct counter_device *const counter)
> -{
> -	struct device *const dev =3D &counter->dev;
> -	int id;
> -	int err;
> -
> -	counter->legacy_device =3D true;
> -
> -	/* Acquire unique ID */
> -	id =3D ida_alloc(&counter_ida, GFP_KERNEL);
> -	if (id < 0)
> -		return id;
> -
> -	mutex_init(&counter->ops_exist_lock);
> -
> -	/* Configure device structure for Counter */
> -	dev->id =3D id;
> -	dev->type =3D &counter_device_type;
> -	dev->bus =3D &counter_bus_type;
> -	dev->devt =3D MKDEV(MAJOR(counter_devt), id);
> -	if (counter->parent) {
> -		dev->parent =3D counter->parent;
> -		dev->of_node =3D counter->parent->of_node;
> -	}
> -	device_initialize(dev);
> -
> -	err =3D counter_sysfs_add(counter);
> -	if (err < 0)
> -		goto err_free_id;
> -
> -	err =3D counter_chrdev_add(counter);
> -	if (err < 0)
> -		goto err_free_id;
> -
> -	err =3D cdev_device_add(&counter->chrdev, dev);
> -	if (err < 0)
> -		goto err_remove_chrdev;
> -
> -	return 0;
> -
> -err_remove_chrdev:
> -	counter_chrdev_remove(counter);
> -err_free_id:
> -	put_device(dev);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(counter_register);
> -
>  /**
>   * counter_alloc - allocate a counter_device
>   * @sizeof_priv: size of the driver private data
> @@ -255,31 +191,6 @@ static void devm_counter_release(void *counter)
>  	counter_unregister(counter);
>  }
> =20
> -/**
> - * devm_counter_register - Resource-managed counter_register
> - * @dev:	device to allocate counter_device for
> - * @counter:	pointer to Counter to register
> - *
> - * Managed counter_register. The Counter registered with this function is
> - * automatically unregistered on driver detach. This function calls
> - * counter_register internally. Refer to that function for more informat=
ion.
> - *
> - * RETURNS:
> - * 0 on success, negative error number on failure.
> - */
> -int devm_counter_register(struct device *dev,
> -			  struct counter_device *const counter)
> -{
> -	int err;
> -
> -	err =3D counter_register(counter);
> -	if (err < 0)
> -		return err;
> -
> -	return devm_add_action_or_reset(dev, devm_counter_release, counter);
> -}
> -EXPORT_SYMBOL_GPL(devm_counter_register);
> -
>  static void devm_counter_put(void *counter)
>  {
>  	counter_put(counter);
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index f1350a43cd48..9afa0f1e9cea 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -314,8 +314,6 @@ struct counter_device {
>  	struct counter_comp *ext;
>  	size_t num_ext;
> =20
> -	void *priv;
> -
>  	struct device dev;
>  	struct cdev chrdev;
>  	struct list_head events_list;
> @@ -327,25 +325,15 @@ struct counter_device {
>  	spinlock_t events_in_lock;
>  	struct mutex events_out_lock;
>  	struct mutex ops_exist_lock;
> -
> -	/*
> -	 * This can go away once all drivers are converted to
> -	 * counter_alloc()/counter_add().
> -	 */
> -	bool legacy_device;
>  };
> =20
>  void *counter_priv(const struct counter_device *const counter);
> =20
> -int counter_register(struct counter_device *const counter);
> -
>  struct counter_device *counter_alloc(size_t sizeof_priv);
>  void counter_put(struct counter_device *const counter);
>  int counter_add(struct counter_device *const counter);
> =20
>  void counter_unregister(struct counter_device *const counter);
> -int devm_counter_register(struct device *dev,
> -			  struct counter_device *const counter);
>  struct counter_device *devm_counter_alloc(struct device *dev,
>  					  size_t sizeof_priv);
>  int devm_counter_add(struct device *dev,
> --=20
> 2.33.0
>=20

--of2z9Lt2LD3Qm7UO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMH5YACgkQhvpINdm7
VJIK5xAAhMIaY5l72GoWObyJmXCbrJqZYKB+EYNQzob1sGC3+i2D/iQ+1w9u+i01
GS3Y4sGMtQQ4qF12yxPVDDqhl5gNBNw8Z5TgXjC0iNn9lEETxH11q/1ImScdq6W5
wfMmyt3FLwMEAoEuFd2NKjq9Mcw/e7XXSKuDpxDmPXlNgF6FXK02Y328IYfqvgYr
6/Y6t1nHdzcKAyTW20g/B7Ikyv2lcNHkhhjIwz4GsvTp4u78cEPqz7XAnmZ9uhNH
eRTWf6nCqlytH8jrfKhXLMe7N7wuGADqb+yhuqRFU4SQogON60LJ5Sm+gmkDawFy
QAputOGz4qzAk42agkz5W0DVaveiOFCYIkFBn+exdrNb7yNKHoMMm/Sc5vPcj62E
EWS6gAyuvhyJeHaTGU9XQAUhxY4YzwK+h5goRiCXThTaQUrocC/IH5veTMyW0VWS
yHqZcJCooySjJUODzgqoqS4MQcQMBxeK0w3pLII1nqBCxMcdp7adrpMIl/2h256e
7OU65I+DnE9lonIXm42QGZBmwi/cjZDYzMuvhwb1mqikuIFve73MUySkkTQKWdi4
/b+qzCYPelTC1H0IBInO4dRxRoPDcyntWsKF3JKqOqUgAq1hDeGkMBH1/nJeCiwL
e75AqA486RR3U+HwcaUVF/BCJBy9JI0pyuzuSnSRh6rf9RkoAKo=
=xqU4
-----END PGP SIGNATURE-----

--of2z9Lt2LD3Qm7UO--
