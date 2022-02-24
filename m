Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F794C2AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiBXLYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBXLYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:24:06 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A420194AAB;
        Thu, 24 Feb 2022 03:23:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C89181F44FB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645701814;
        bh=Sz74MS1qEWhBzP2aGriahjmRUJEbF8iq7f0IdOnm1YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6SDBca+nsbJkEF4C5FNEq2t1hfUFEMWg7wihh9BPfPW85UcDEFR5fVeA+vtu7CcN
         Dnl3D9rZ/v9sofFsOaN61y/3sqWHDpE8x2W655lr5eMH1dHwuTJFWz6yF7F1JuiF55
         pPEK30mlP7Hu9/RB9zPvkE2BmUep5SJXyWQOn7buba8KmF85KsR+fP6rqrT8X2+aW7
         +mUfcgSy1pUL3ZK36ya9B30RW3qbaIFQV7dC7pM/QhxJmYPtoVf8QUtlAVc5JNw1pV
         PhJbS2eDA2sdiNytaCKBDeX40H6Q5XVrxol7UOrFdyHiHRgY31Xa/V8M593vmoOqTB
         CKwFLVP4rkL0g==
Received: by mercury (Postfix, from userid 1000)
        id BEA26106049B; Thu, 24 Feb 2022 12:23:32 +0100 (CET)
Date:   Thu, 24 Feb 2022 12:23:32 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: max14656: Use devm_work_autocancel()
Message-ID: <20220224112332.2ex4jah4javrufgh@mercury.elektranox.org>
References: <e73d025d989444354d3e9a4c44feb806653424dd.1644753283.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qapdd6ctl2uex5lv"
Content-Disposition: inline
In-Reply-To: <e73d025d989444354d3e9a4c44feb806653424dd.1644753283.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qapdd6ctl2uex5lv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 13, 2022 at 12:54:56PM +0100, Christophe JAILLET wrote:
> Use devm_delayed_work_autocancel() instead of hand writing it.
> It saves a few lines of code.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max14656_charger_detector.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/p=
ower/supply/max14656_charger_detector.c
> index 3f49b29f3c88..fc36828895bf 100644
> --- a/drivers/power/supply/max14656_charger_detector.c
> +++ b/drivers/power/supply/max14656_charger_detector.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_device.h>
>  #include <linux/workqueue.h>
>  #include <linux/power_supply.h>
> +#include <linux/devm-helpers.h>
> =20
>  #define MAX14656_MANUFACTURER	"Maxim Integrated"
>  #define MAX14656_NAME		"max14656"
> @@ -233,14 +234,6 @@ static enum power_supply_property max14656_battery_p=
rops[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static void stop_irq_work(void *data)
> -{
> -	struct max14656_chip *chip =3D data;
> -
> -	cancel_delayed_work_sync(&chip->irq_work);
> -}
> -
> -
>  static int max14656_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -286,10 +279,10 @@ static int max14656_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
> =20
> -	INIT_DELAYED_WORK(&chip->irq_work, max14656_irq_worker);
> -	ret =3D devm_add_action(dev, stop_irq_work, chip);
> +	ret =3D devm_delayed_work_autocancel(dev, &chip->irq_work,
> +					   max14656_irq_worker);
>  	if (ret) {
> -		dev_err(dev, "devm_add_action %d failed\n", ret);
> +		dev_err(dev, "devm_delayed_work_autocancel %d failed\n", ret);
>  		return ret;
>  	}
> =20
> --=20
> 2.32.0
>=20

--qapdd6ctl2uex5lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIXarQACgkQ2O7X88g7
+pp3sBAAmV+qpqv9OhtkqIG/Vqpf67JQMfg+bE9HJ9l0I8i6eqmClt4mwoDMnjdV
pMFsOMiopkXv6MRr13LFp5Os75j6eLuZREaJzIceqPq2N7QzolLoS5yiOIObW3WH
4CPHxpyUnTCvMGMh7Oc+iUO2cmxnb3BeDlZZHxPldEn02PXZGZwHXQLv5Df6syq0
PmgH9AjXwHAJi4m1va3Qm5Bt6XoTeL6bT0Cs1n2CcddmNFArDncfDC3Jt1UE190I
VQFXcNct4GQWQC1yym/ss7tW2TacSkO7vxP0gergiTvnFQelXatORGVLEHzVuL3I
5IwZX3RonEdpn9tvyfIQy3Hzpi3FhIxhIW/lU+9olhWm9+jU+uC6kVaIvlc+6rV3
sJ2D5QQpoAJqP3Z5mtKey9JlPBIL7vqIaLz3uQf9+x4FH9V4ecI8Q373J964Ix1O
LKqqulzLDy5hQ8oKN6Zys9laTmma0I8LSNlWDUBU6clf35euU1KDA7QIy+MMS88s
SA3JLZKcAPPNNX25t26FxaifjMOAiVZPawogSaro65ZVQMijvtXPPEXG8GVxWslc
B9EuL+gKluKaMQe2b3zFOFghZ7U9SUrCRf2eDTECXl2mw4SBUeESME60rhUizYai
fB70XCZrKKOxkdC7TY6xmofBCl32otIwE28ewTxYx55u4ijvyoQ=
=NVmH
-----END PGP SIGNATURE-----

--qapdd6ctl2uex5lv--
