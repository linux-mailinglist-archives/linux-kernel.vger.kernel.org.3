Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F445454FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiFITan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFITak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:30:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6925F10C323;
        Thu,  9 Jun 2022 12:30:39 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E5D776601607;
        Thu,  9 Jun 2022 20:30:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654803038;
        bh=4kRx5Zh3QILVMnAx/gm6vJa7wG2mpVykj/WUemRln/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cni9Gu0sCW8uW2pXmjQ0PmoaPxt2nI8TWGrOcdH4YbJb8p3a8N4FbHcL7bX3FzGYn
         rNqoNjUeyzb79FbAP82eeDE0S6a/yDNomuzQSwkBMNl6m/TjyIX6MSndYaUMiEpeq2
         E0xpgPq8YEmPX/JuvTrXRGz7UZmHosCQmBd9zxRR3bniISKrDXBngZB02azfodJnt5
         HLFkFw1qhSCeKDsN3TNfJsaCT8aBWTehEWW7/Uj+KxtxtO9jPxqqgRjlHUTkBZpHD2
         VR0m0eCA6rFJUYnsPpYOzN0to8+glovlIXdDXm7b2ywFasE0IvkOhjCXjhAQ6Cf9bD
         bWSUfCA/9gTeg==
Received: by mercury (Postfix, from userid 1000)
        id D8C9610605B9; Thu,  9 Jun 2022 21:30:35 +0200 (CEST)
Date:   Thu, 9 Jun 2022 21:30:35 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] power: supply: Remove unnecessary print function
 dev_err()
Message-ID: <20220609193035.ojzsan6baoqmlaep@mercury.elektranox.org>
References: <20220504135214.28901-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iej2of25yg6hskqe"
Content-Disposition: inline
In-Reply-To: <20220504135214.28901-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iej2of25yg6hskqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 04, 2022 at 09:52:14PM +0800, Yang Li wrote:
> The print function dev_err() is redundant because
> platform_get_irq() already prints an error.
>=20
> Eliminate the follow coccicheck warning:
> ./drivers/power/supply/goldfish_battery.c:225:2-9: line 225 is
> redundant because platform_get_irq() already prints an error
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/goldfish_battery.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/goldfish_battery.c b/drivers/power/supp=
ly/goldfish_battery.c
> index bf1754355c9f..a58d713d75ce 100644
> --- a/drivers/power/supply/goldfish_battery.c
> +++ b/drivers/power/supply/goldfish_battery.c
> @@ -221,10 +221,8 @@ static int goldfish_battery_probe(struct platform_de=
vice *pdev)
>  	}
> =20
>  	data->irq =3D platform_get_irq(pdev, 0);
> -	if (data->irq < 0) {
> -		dev_err(&pdev->dev, "platform_get_irq failed\n");
> +	if (data->irq < 0)
>  		return -ENODEV;
> -	}
> =20
>  	ret =3D devm_request_irq(&pdev->dev, data->irq,
>  			       goldfish_battery_interrupt,
> --=20
> 2.20.1.7.g153144c
>=20

--iej2of25yg6hskqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiSlsACgkQ2O7X88g7
+poP4g/+IBTPFMPxsgqiE8ymMfqh70gGwXufuI8Dz3MEpNSCgZZ1ZE7mEjaHiPiY
FqMuMDF170op04EUU68iOOhAm4Lhrzgen+2u8/oTpKFy4AFrGWwnRoMVwlRkwz9j
/3AYuKIu3XOTv83xijOZapgbvg9nNXnEOm8Vky2k48ZKnjM7XpoVN6eLbU7ld5I1
LUu5EIu7F4cMT7d8bT5ZgTkJtxjoHGEFNOlLMkCW6gEY1yspS20Ngri2U/tzWpG0
ZqYsbr8UZPVTX6MgKmr/YWCkU0FvM5kLJIdrZ667o7pP7DTjK1TQNAujAxZXomkH
b514/ZTkIBHTlLmSTbOt+PXYHiO+b0zUUEAE2gwR+hMmQZWj/Q+44ugIVuKl8JM7
mmLH3YIgtdyUzCZu7OxDcqtd+Q+JouzQANh8wj/CGXzUwcHBuSdwBovWIsJ6AC6e
Nq3vjBO86d0+cLHM/gVKruSaW1rUwEsCe1yWXSvXPZu9HSak/KWIuhCOYoHEe+CB
OFt6IwhPyZdvomqSM1xol4KzZn1LfT2Jz12W7fRG+r/utEjtYx3sdHfsVOpZ46q6
i9V4qq8FEdbBr/0ALv6LvEjnBjRFiGtiIQx4vFkdGcYwhKQihNuaX1sxM0AoEllo
um6PvdGToDppnA3V89JCQB0csNZdFHqxJIjUqBsBiW+JxmOaFiA=
=/SEh
-----END PGP SIGNATURE-----

--iej2of25yg6hskqe--
