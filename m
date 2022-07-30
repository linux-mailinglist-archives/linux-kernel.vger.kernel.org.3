Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB085585C4A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiG3V1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiG3V1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 17:27:12 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB490B86A;
        Sat, 30 Jul 2022 14:27:11 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 664351C0001; Sat, 30 Jul 2022 23:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659216430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nKzx4XE0Q9S7E6JpTq1PRNBeJ81XkxtnknzZLZjc4s4=;
        b=Ui1eURtnS7ETP7PeofLxoNRfhDizr9x8Av02juZL26RzGX/IQKlDLcqXc2zxPRMLBFCwra
        PGKjfE9W/+6bLukTPJOVEutb/D7u1Qy3NXMwgS39h0FwQTV+j+Ah2ygXJGYR3zpWoXQfbB
        kJUW2tf80M+Aw2xt0CtGmDFfU2QsVWg=
Date:   Sat, 30 Jul 2022 23:27:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andy.shevchenko@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v6 2/3] leds: Add driver for the TLC5925 LED
 controller
Message-ID: <20220730212709.GH23307@duo.ucw.cz>
References: <20220722081146.47262-1-jjhiblot@traphandler.com>
 <20220722081146.47262-3-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline
In-Reply-To: <20220722081146.47262-3-jjhiblot@traphandler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The TLC5925 is a 16-channels constant-current LED sink driver.
> It is controlled via SPI but doesn't offer a register-based interface.
> Instead it contains a shift register and latches that convert the
> serial input into a parallel output.
>=20
> Datasheet: https://www.ti.com/lit/ds/symlink/tlc5925.pdf
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/leds/Kconfig        |   6 ++
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-tlc5925.c | 148 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 155 insertions(+)

Lets make this go to drivers/leds/simple/ ?


> +	gpios =3D devm_gpiod_get_array(dev, "output-enable-b", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpios))
> +		return dev_err_probe(dev, PTR_ERR(gpios),
> +			      "Unable to get the 'output-enable-b' gpios\n");
> +
> +	count =3D device_get_child_node_count(dev);
> +	if (!count)
> +		return dev_err_probe(dev, -ENODEV, "no led defined.\n");

"No LED..."

> +	device_property_read_u32(dev, "ti,shift-register-length",
> +				 &max_num_leds);
> +
> +	if (max_num_leds % 8)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "'ti,shift-register-length' must be a multiple of 8\n");
> +	if (max_num_leds =3D=3D 0)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "'ti,shift-register-length' must be greater than 0\n");
> +

I thought you had #define for leds number before?

Otherwise looks good, thank you.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuWiLQAKCRAw5/Bqldv6
8iv8AJ9Rz7FsC0XYkyCNVAcvxkRCU9lSVACgleAZqysiiyhZiJi4cGzKfZ/BVuE=
=IAlE
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--
