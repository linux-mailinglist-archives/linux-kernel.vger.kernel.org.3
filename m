Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7714ACE60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbiBHBua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344883AbiBHBm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:42:27 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE64C061A73;
        Mon,  7 Feb 2022 17:42:25 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g8so6299030pfq.9;
        Mon, 07 Feb 2022 17:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ERgffSEEPMLOF4G7ZYojvcW38QDY6fucM35wyOznqkc=;
        b=K/Ew1OAJMRm0RkQoio72L75verKVe0mAGhqnut8B94/tnHyzTlON8O9FmqZODYWXrM
         F7ncbAMwYF1FfB0kRTROHnTt1yhnmnpNknHY1xzds9BujqRfHhBhVWg2QFsd+bOKkfP+
         v3mYVJA5QZuW5Ka6+fEr14Alf7luEKUMG6zXov4NB00gU9++bqRn/hKCnLzRMonOxsl+
         iF0HepvNE0ND/hHDUpkm8RqkhepeSnHCLkigmDExeAWE14vidYkca4n1C5UPswi1xHvj
         zZ3pW1Gso7mLzV9nKBDnXAVBb5Sa4ziPbJO4cea+sabcCh2fOOrySTInoaFItHqxjO1p
         9Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ERgffSEEPMLOF4G7ZYojvcW38QDY6fucM35wyOznqkc=;
        b=NgdVYbnTbA86tgG+hKOyRRTgFDlInuxSwOiOMygXipID9qzV7Tmd1ZnD38rW6GwfE3
         DWj6woy9vgOnEx2EJ8F4J9lWQKwEtMgtuZI0ntC1ZXHOgkHCHr7WoxeR8rVprMkLhkjY
         ax22IyfMmUeUjSb2Avac2LDnW0Hipiei4122anOylYpZeo8qb1xpQAzZs5QkWRvu+9Jr
         elcArbS0ETGc3IWvGv42mSPdmgYbGNYePIZIFXY6s27ZVRvij2YHrEChLNnyJNTzIoJB
         RA76jpH3ABEetj5pYcEIyr1CZ/Np3Ls6VozIlXojXqVxqiRGeN7V0RSKgFoMx55mgRaL
         wUfg==
X-Gm-Message-State: AOAM531s/WzhciyR/eupRpOe82ODy34ArxpFcuHZLmBJmQm2l2BG6hgG
        nGXlHvggqU4ormNZBr5gLqjCfO9VyQY=
X-Google-Smtp-Source: ABdhPJzBMUGlrinPYhS7qO91vdKuoMmKA6EhpqQRC/TwKj+cCfAyp2TrpLsIw6K7g/m3ifpWX1USpg==
X-Received: by 2002:a05:6a00:158c:: with SMTP id u12mr2152508pfk.18.1644284544759;
        Mon, 07 Feb 2022 17:42:24 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id d20sm13411388pfu.9.2022.02.07.17.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 17:42:24 -0800 (PST)
Date:   Tue, 8 Feb 2022 10:42:18 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] counter: Stop using dev_get_drvdata() to get the counter
 device
Message-ID: <YgHKekl9rJ2jH5j4@shinobu>
References: <YfzPcyusGwAOkys6@shinobu>
 <20220204082556.370348-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3c1sPSk/V9KyhHkf"
Content-Disposition: inline
In-Reply-To: <20220204082556.370348-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3c1sPSk/V9KyhHkf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 04, 2022 at 09:25:56AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> dev_get_drvdata() returns NULL since commit b56346ddbd82 ("counter: Use
> container_of instead of drvdata to track counter_device") which wrongly
> claimed there were no users of drvdata. Convert to container_of() to
> fix a null pointer dereference.
>=20
> Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Fixes: b56346ddbd82 ("counter: Use container_of instead of drvdata to tra=
ck counter_device")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

I'll pick this up and apply it to my tree.

Thanks,

William Breathitt Gray

> ---
>  drivers/counter/counter-sysfs.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sy=
sfs.c
> index 7cc4d1d523ea..04eac41dad33 100644
> --- a/drivers/counter/counter-sysfs.c
> +++ b/drivers/counter/counter-sysfs.c
> @@ -19,6 +19,11 @@
> =20
>  #include "counter-sysfs.h"
> =20
> +static inline struct counter_device *counter_from_dev(struct device *dev)
> +{
> +	return container_of(dev, struct counter_device, dev);
> +}
> +
>  /**
>   * struct counter_attribute - Counter sysfs attribute
>   * @dev_attr:	device attribute for sysfs
> @@ -90,7 +95,7 @@ static ssize_t counter_comp_u8_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	const struct counter_attribute *const a =3D to_counter_attribute(attr);
> -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> +	struct counter_device *const counter =3D counter_from_dev(dev);
>  	int err;
>  	u8 data =3D 0;
> =20
> @@ -122,7 +127,7 @@ static ssize_t counter_comp_u8_store(struct device *d=
ev,
>  				     const char *buf, size_t len)
>  {
>  	const struct counter_attribute *const a =3D to_counter_attribute(attr);
> -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> +	struct counter_device *const counter =3D counter_from_dev(dev);
>  	int err;
>  	bool bool_data =3D 0;
>  	u8 data =3D 0;
> @@ -158,7 +163,7 @@ static ssize_t counter_comp_u32_show(struct device *d=
ev,
>  				     struct device_attribute *attr, char *buf)
>  {
>  	const struct counter_attribute *const a =3D to_counter_attribute(attr);
> -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> +	struct counter_device *const counter =3D counter_from_dev(dev);
>  	const struct counter_available *const avail =3D a->comp.priv;
>  	int err;
>  	u32 data =3D 0;
> @@ -221,7 +226,7 @@ static ssize_t counter_comp_u32_store(struct device *=
dev,
>  				      const char *buf, size_t len)
>  {
>  	const struct counter_attribute *const a =3D to_counter_attribute(attr);
> -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> +	struct counter_device *const counter =3D counter_from_dev(dev);
>  	struct counter_count *const count =3D a->parent;
>  	struct counter_synapse *const synapse =3D a->comp.priv;
>  	const struct counter_available *const avail =3D a->comp.priv;
> @@ -281,7 +286,7 @@ static ssize_t counter_comp_u64_show(struct device *d=
ev,
>  				     struct device_attribute *attr, char *buf)
>  {
>  	const struct counter_attribute *const a =3D to_counter_attribute(attr);
> -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> +	struct counter_device *const counter =3D counter_from_dev(dev);
>  	int err;
>  	u64 data =3D 0;
> =20
> @@ -309,7 +314,7 @@ static ssize_t counter_comp_u64_store(struct device *=
dev,
>  				      const char *buf, size_t len)
>  {
>  	const struct counter_attribute *const a =3D to_counter_attribute(attr);
> -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> +	struct counter_device *const counter =3D counter_from_dev(dev);
>  	int err;
>  	u64 data =3D 0;
> =20
>=20
> base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
> --=20
> 2.34.1
>=20

--3c1sPSk/V9KyhHkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmIBynoACgkQhvpINdm7
VJLqTBAA3J43JaLbnlYQQ3Mn19/LJiIcHZtxbbHnK8eoOuTLJdALEfHllZD95xe1
liOz7WRh9fSKcMNna392DMKGLUrofvoi+RIxFNePDCpQfEPj9+1W2veb9SL+4kz9
v3wI/3o1iFKn+U2ZUXh3egGyCoOLtDa0r4a6Jr7IRNBe2whvnWJrLwaP9DYuH28D
SnkLNYENIjarUmlr61ybKRAYQjVUTM2okKLMIRaNsA6A24UdzmvgSV4Wu7SD8Jm/
G52W6ceQy9JK9k7NHGmSD1AJTHf9fkhrYXkmawJrbrOdJgn77Wckr6HjS2j/wQmF
Czg59/n8fgDB3V/agHolLKkk9G9naO46HbXUOVOnePVCpvh8NGz9GwuDDg+EjsaG
netNzXiqSZb7qeGhDDr/d1fO52GfZrsX4jOJWjbhHLNlogDwhCnNSEBT2GbzguEA
Wxr+r52WXoQ9fE/AW2ScC8eFEreZy1PFfXPAzFwGeIAllhJArPkQE3oIkGOdgaB6
vCDFrTB7NL9mW09Uc7jR+1aQ7MrOEw82ymiXgAeRsqd9ActLYmvjMs1C8MsuJDcl
aMkgqrJcGnrAUfvu8jJYvfKHsYuuJhvEFpmHMl17aWFVPYDoTfGFWfFb/7JKE/8o
xLjJjr/ulxr4S5p5AQ6HxmgQQsRiptAtWdc4TDcAu8ZNiG3Vv6E=
=wD26
-----END PGP SIGNATURE-----

--3c1sPSk/V9KyhHkf--
