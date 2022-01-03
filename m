Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA3A483647
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiACRkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:40:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49434 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiACRji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:39:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DB79B1F42227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641231576;
        bh=9l1MBhj87w2oaRpGKQi8FSzTUXDs8AF6OfoemMGXZdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdsEPLQaOg45KDfNYyUnd6+5KuBv5StpMedj71QXzFjpLn955GNf5/hrFGmx5jXDM
         h1Dwa0w08dxdqKd4GAzY0V+j7d4PfG5pKyz+dKSUyl2Un1xwj4aoH7o7Lrvxt1e8Z4
         i7Da4PK23/TRZOlzwCGX+U8Y3ivPX9MteR70Dqz42sIXwnW8jHr7oF/g9JbZGsqeJu
         iPgFugQjNgi5qccrKEhJ0acE/3QOu8ZF/LlBGoetG+wkVGjXQBRK4EMS14YKOZP0WZ
         LBRycLLQ2It3YParZ4Y3WyoJIREK6MPhXm5WcncA8Dkpr5w+wkJVxtSh44zaG4ONUl
         /E8iCHWHqAPcQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 7A7363C0CB7; Mon,  3 Jan 2022 18:39:34 +0100 (CET)
Date:   Mon, 3 Jan 2022 18:39:34 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mt6397: Check for null res pointer
Message-ID: <20220103173934.qupnu5gne2v2tpig@earth.universe>
References: <20211220083811.907261-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibsvhphyobg6wdwd"
Content-Disposition: inline
In-Reply-To: <20211220083811.907261-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibsvhphyobg6wdwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 20, 2021 at 04:38:11PM +0800, Jiasheng Jiang wrote:
> The return value of platform_get_resource() needs to be checked.
> To avoid use of error pointer in case that there is no suitable
> resource.
>=20
> Fixes: d28c74c10751 ("power: reset: add driver for mt6323 poweroff")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Thanks, I fixed the subject and queued the patch.

-- Sebastian

>  drivers/power/reset/mt6323-poweroff.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/=
mt6323-poweroff.c
> index 0532803e6cbc..d90e76fcb938 100644
> --- a/drivers/power/reset/mt6323-poweroff.c
> +++ b/drivers/power/reset/mt6323-poweroff.c
> @@ -57,6 +57,9 @@ static int mt6323_pwrc_probe(struct platform_device *pd=
ev)
>  		return -ENOMEM;
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
>  	pwrc->base =3D res->start;
>  	pwrc->regmap =3D mt6397_chip->regmap;
>  	pwrc->dev =3D &pdev->dev;
> --=20
> 2.25.1
>=20

--ibsvhphyobg6wdwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmHTNM8ACgkQ2O7X88g7
+pqX7Q//a7FhbfUdQUBPoNx8GliifDl9XPDkJE3hN4sm0flN5mrgDJ0to9G5CHIg
NiV0VHUIug7TKyXT1aJOMZkW0JFDQ0FK7PuBB/oWDl8VG1cFYtKJ2o/q//xyP6Bj
c83UUCQa2B2jwfVq+zlPmPbVMjXl796q74JL7tfcQQSzM8+CKCdxP/cCGYJctwfK
NhwPPnM0m9ho5VKobOkeHRvGkjAHSgI3EOcAWwOKcCvMaBqJzlhqbwuMf6nEARwt
Jr8L7+5EbPRCCzJPPshNB96AT15UayZHkkhCF8v/xWY+2T+EjjOh2Cdaz2uNc3jY
N8umF2drhl0lPHZotF3/cSJcHivedvl9a8XdFAVkwmWiOCzjDqxErpgJPayFpsHV
3saj0u4wEkFUssfnZqLvXnme9IHiBaH7+Jc5Ejbg85z8J4ejME6M1xllCe/718/n
Cv50/1j9FfFZKVl1G8cEzYu9GNddlMZejZaZVgHRYjrKuWE/j9dvpPQpVbOvZ3H+
e+d9Tz7P3iOGWzo7wrQuSp7f9H9HkM1D1T4lf502BJMcft9v6n5JYzcYcZsOmtzo
tx65r1KHiosLF/bj2W7SX4xU1Z1yjEmCPSlxFj3SlCEWwogc2qcOC3Fc4g/RDXWl
5iPY2cwVbwBBr6q32CdCoS4Rd7KLVH+9bgl0Cfoi5porimkZdlA=
=12QQ
-----END PGP SIGNATURE-----

--ibsvhphyobg6wdwd--
