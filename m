Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD8A48107D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 07:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbhL2Goh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 01:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhL2Gog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 01:44:36 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C25C061574;
        Tue, 28 Dec 2021 22:44:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x15so15240996plg.1;
        Tue, 28 Dec 2021 22:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HNKTzp6V0CQ424xY5DM1k/OaPe8zHUasLFfJtR/1mKM=;
        b=VwAcosB3t42Dhle38WtF3myh1FxBMLp7/DeQ/+6UiwMegqYyeSzfHeey8y6pKoa2X+
         Qp9aTcymE3tTMsxCYNBUa2cseAIqxdAHu7MCsuzK7RMROz/jPwgRtonZnVbo3sjww0iy
         HisLMn9E2YVDXsvoqgs5Z1f7Z422PJqe17pgfD8sMLfWEJZcPZe8PqO7JWzKRkVCMSHD
         DD2I9xJ1lG054Md6PO9RCdQ+LKpJ838EJbdUPEHx01ZjjcMF79lbaD83PB7IRv3oxLCu
         z9ZZamXTtD6tvdKEBJnt0K0trHJEC7Z40xv8RrI6LPvM9LX/O5K/TS7T4UR0bO6ZQwMI
         27yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HNKTzp6V0CQ424xY5DM1k/OaPe8zHUasLFfJtR/1mKM=;
        b=7qgmWW5QBJVVZ1Fh2qQyV1UnlrefvgV4YdbROiqL0U/ZPMexUBgWxH65HQJ0RDXEii
         bSkN6F5Aat48dyKlbGRt3bB+sIxAYE2Ov/8/ysDa+Nh+SjKwFaChllF4oWLpAJAnFLNH
         R1BqGzxlhdDU8Tfw9WCPjamAiFgHDIFvPUO1bnrl1mMarZD1ac5hmFxBRYMTCMaAZBLC
         u358HwP6XRzetfe08ZwfzsnurPli9jxmL25sqf4dmv6zZs/3WswNbZnOZfeaNxWTFZnw
         rSMsF6e7Sx/MRvepzWaCTL4JPHkhInlFKR3leTC8i2w88iDlRFkQosS2eLk49Aio3cZ4
         t2zw==
X-Gm-Message-State: AOAM5332N9AHtIFZ4lKmmz5Wa1rRN0mgsZL3QgqGmXvgEQbFuQE9hbq8
        iMUY05G/RvibnvfyUj0JC+U=
X-Google-Smtp-Source: ABdhPJz7pXAM3MFXWTld+cFAVQxL6VFvHQSAW4LakDOtkFjRwL066zz2FUNkpizEaaq8zXIn2949vA==
X-Received: by 2002:a17:902:db07:b0:149:a80:1070 with SMTP id m7-20020a170902db0700b001490a801070mr25245321plx.27.1640760275943;
        Tue, 28 Dec 2021 22:44:35 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id l6sm21797342pfu.63.2021.12.28.22.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 22:44:35 -0800 (PST)
Date:   Wed, 29 Dec 2021 15:44:28 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 03/23] counter: microchip-tcb-capture: Drop unused
 platform_set_drvdata()
Message-ID: <YcwDzMNOsrpoZ0EK@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2xo5uYaXWcrZrhNe"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-4-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2xo5uYaXWcrZrhNe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:06AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The driver doesn't ever use platform_get_drvdata, so drop this unused
> call.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/microchip-tcb-capture.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index 0ab1b2716784..bb69f2e0ba93 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -307,8 +307,6 @@ static int mchp_tc_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> -	platform_set_drvdata(pdev, priv);
> -
>  	match =3D of_match_node(atmel_tc_of_match, np->parent);
>  	tcb_config =3D match->data;
>  	if (!tcb_config) {
> --=20
> 2.33.0
>=20

--2xo5uYaXWcrZrhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMA8wACgkQhvpINdm7
VJJCWg/9HAu9f/eH6X6jExo/yJI2+JBM8RrNFjdm5d9aSvrRmZMc9gpZ/A7QreOa
pIfvmohNTJUb4wyJa/oFe3dhW7C12cCCwTZ4nU5TncxIK7iKRPVO2Mkn2Be5t4Q2
E6c9ORgtfJquRfcC20cJu17K2BYqatUZHUUDpKsDjSb6KdnuXkGtzYuwWuFJU+SI
gSUF1fUqOqK/N3awBBTot4viz/vllV5hY3l015c+bz38JaOsT+o0TezYkO3vqlCr
Mlm4cm3EiEePkeIzqZe2bClReR+AovK3VLcx/++Lhj30KgZZ4u0pX0KiYR446Ql+
3auFhfxg4RvuUB3imotpCNMc+l3mJUeYKtlvQtJZVGEBn3/UeN3g6PqQBR6EpfxT
9tmAT5lVYRoPWuTjQmvxKFhkTfJSax7iS6hh6nH8HY+yVUrcPl/7KSeOOkGbk4lG
hEwBzwA2UUCbYtlnbCNFqbeOCyzN51OWrlXcnptKTX/3sUqam7iR4/PWJvOto1g3
ABdz0obgV2Yku0A+l8cH9uumG37fvvIrt/pE4yUbBbbOcRxa3dMo6aCB2j7BIqt4
v8TxzvX4e0zNLV3rBUtkRmYbLrd2w6/RIM6disDs+xdrIOKdCCieeYGQ8V2/8hVC
FDfklDbmZUWSXwcPUAq6R/MbrArfyucQDfpbF4q5SAe1sqgMqNM=
=Df1I
-----END PGP SIGNATURE-----

--2xo5uYaXWcrZrhNe--
