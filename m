Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850BE481079
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 07:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbhL2Git (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 01:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhL2Gis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 01:38:48 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F837C061574;
        Tue, 28 Dec 2021 22:38:48 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s1so16250675pga.5;
        Tue, 28 Dec 2021 22:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/+dmvARaO0wX79dFiLV+nr8xNseqJI8BiPl8kOY5rlo=;
        b=ZyuD1RTGlNAJyTqHzXmJg0Fx4jBDo96BKExgRcY16G9oUrkHhTUo2vR8EEL2uMylwu
         19nUkPPN1Tql/v5S7r7CbA6QexX0DHhV87rUQ24kMZuo36YSLu8uqztsb84DH1Z/Pbgy
         IZ578+Us8E9xcdAB7bd8nq0qPLAcMJQmD6VXvVtcYXGjut3tMakZuwjP98zulLsLofec
         A7wUDW0xckU5ThkHp5h7vPX02ANNCtainIEOPvsoT3czBYKUi41zUH29moCJuJb7jD5W
         tLv/fZN1b+YMX0owg+rMWB4rdIOFV3aHN+7iQ7VOTuDa2O0N6pdaE/LbJcurJXYLmPAT
         P4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/+dmvARaO0wX79dFiLV+nr8xNseqJI8BiPl8kOY5rlo=;
        b=4/P91pMNUxawJoyW3aPkieu+QwXgAKNFCHHuL32qV/r1PJoe5IrN389kyjKCuYp+Eb
         gmv5d3jhOYfz2ugHLE7/1mIG5ICboO/DauHVThtRyLyJyU9JBf3yboIRjkT2lldZ2+1n
         WWwYwnZ2EifkAU8rRmncMw+gwYbL+AnQSqtvO5zR23zrZZutCdNfPocM5AOpH3n/g2/a
         V1kqPBErIxi7ul5yps3Wj15t7S3ka+8u5IZQL+VGjkT7y8dW1L5FJlcn4FE/MVnc6k8W
         93igYgdKeYBXwrDAj95TY7jI4A6VNHzUFYFC4eTlPmU0yYOVSRxyaeuScnoAKHG1msaK
         adww==
X-Gm-Message-State: AOAM5329paGhBAQ9sUQ6oG8MCAwFxzsWMWiQ134EQAOgMuGfxSWeVaPl
        bVHhwlVikIOEWxZjcv1ruOA=
X-Google-Smtp-Source: ABdhPJwJHz7Xb+VlJFRu6ejPTC7t9pQ9Aa5D16gWyW1uScjSTKNgmdoqEfaXBAz8L3/PrwkpZ+Cw3A==
X-Received: by 2002:a05:6a00:992:b0:4ba:ca25:ca0f with SMTP id u18-20020a056a00099200b004baca25ca0fmr25486819pfg.44.1640759927896;
        Tue, 28 Dec 2021 22:38:47 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id n71sm22652267pfd.50.2021.12.28.22.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 22:38:47 -0800 (PST)
Date:   Wed, 29 Dec 2021 15:38:40 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/23] counter: Use container_of instead of drvdata to
 track counter_device
Message-ID: <YcwCcBtdMKAvnCwM@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WTvz+wxjL/4uBLQm"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WTvz+wxjL/4uBLQm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:04AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The counter core uses drvdata to find a struct counter_device from a
> struct device. However as the device is a member of struct counter_device,
> the lookup can be done faster (and a bit type safe) using container_of.
>=20
> There are no other users of drvdata, so the call to dev_set_drvdata can
> go away, too.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/counter-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index 5acc54539623..f053a43c6c04 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -26,7 +26,8 @@ static DEFINE_IDA(counter_ida);
> =20
>  static void counter_device_release(struct device *dev)
>  {
> -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> +	struct counter_device *const counter =3D
> +		container_of(dev, struct counter_device, dev);
> =20
>  	counter_chrdev_remove(counter);
>  	ida_free(&counter_ida, dev->id);
> @@ -78,7 +79,6 @@ int counter_register(struct counter_device *const count=
er)
>  		dev->of_node =3D counter->parent->of_node;
>  	}
>  	device_initialize(dev);
> -	dev_set_drvdata(dev, counter);
> =20
>  	err =3D counter_sysfs_add(counter);
>  	if (err < 0)
> --=20
> 2.33.0
>=20

--WTvz+wxjL/4uBLQm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMAmQACgkQhvpINdm7
VJLhoRAA1awIOpM+/ZjFSO9uo2UlhAAS47AmLL8iQsMS3jmHgxts0wXc7lpmEn+G
vm9OziM32ZjLPkuvAX4oXG8TMLn2tWv1Rzx7JPiPgwL+qZI4QCwkZMQEqNEegaFh
LabmP/dl0EwjR30qSIbAyCKdMNoPtmk8xwJmMuZ/Fu2xxIGsiekDsOhdK6dSZCkb
E3youbzkRizKcTGG+udXgDsu8i6G6CsCB7hjgpmRcaKboVPRyxet2PA3XVyElycN
wsG1FtlpOd4rebqInjqTMB3mnRslr1qAWvfzEA3eW+/KLNHWWcKnrpMb88OWwzWx
8L92mcQKrGaTYPr778+YkbrSPWFa8Noecn72JfH3E9WMC9XOqgGL6FRAmv5RVDmE
SPdt7jJ6mQ6X/JWWGKqD0RqhIjj0C2AzxFj5K3uGyvgnf/V8Qt1Fq2E6t6uFKqRI
1tJ9mxkEu6libBF6hDQrYAG25+neIxHZtYgwwgY/ytAs3Dex8DZm2CYyeavMRPzZ
Kcog+jmVZd69nweHRdUSsVRFBGJD0s5kfsOsAopT6PmCaZbDqIfLTUZdUxzyDrrJ
DH9opqkyZZyWPX5S+82u4OICg9j9AcswrZmcEW4Yx8irfyVmZRWTgQdCxRsAzj9f
4mNnOe05yVi45qCEK7sr6skxU/hsDNE9IhD8CW2Arh57yJrwvs4=
=7A2O
-----END PGP SIGNATURE-----

--WTvz+wxjL/4uBLQm--
