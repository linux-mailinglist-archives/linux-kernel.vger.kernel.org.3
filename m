Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63664577639
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiGQMnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 08:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiGQMnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 08:43:22 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D82715A37
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 05:43:21 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CA6D61C000A; Sun, 17 Jul 2022 14:43:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1658061799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6nAc1aFFhkz47oNgJfNOrXqA9oVIZphMzGakCfBhsM=;
        b=jp3Da2F2wyC+zC1k8X8I98wL7KyF38OcYsT/drhbToXG4LFyUJejx3qUl2dkxiAn+sYxUX
        eXamu/mNjw9civ2QqRAARP2v9koimg45HLbg2mAAj6yyxhdS6CrhYK9QWprtzoxrXrpbwQ
        lAIfbPUnanl/N245VJ3qFLYCFYQsSSs=
Date:   Sun, 17 Jul 2022 14:43:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH 5/5] leds: max597x: Add support for max597x
Message-ID: <20220717124319.GK14285@duo.ucw.cz>
References: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
 <20220705122244.472894-6-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iSeZnk6FyAS3EJ1y"
Content-Disposition: inline
In-Reply-To: <20220705122244.472894-6-Naresh.Solanki@9elements.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iSeZnk6FyAS3EJ1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a49979f41eee..682748097276 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -598,6 +598,16 @@ config LEDS_ADP5520
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called leds-adp5520.
> =20
> +config LEDS_MAX597X
> +	tristate "Maxim 597x leds"
> +	depends on I2C
> +	depends on OF
> +	depends on LEDS_CLASS
> +	select MFD_MAX597X
> +	help
> +	  This driver controls a Maxim 5970/5978 indication led via I2C bus.
> +	  The MAX5970/5978 is a smart switch with 4 indication leds

led->LED.

Add "to compile this driver as a module, choose M here: the module will
be called ..".

Add "." at end of sentence.

> +++ b/drivers/leds/leds-max597x.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for regulators in MAX5970 and MAX5978 IC

?

> +static int max597x_led_set_brightness(struct led_classdev *cdev,
> +				      enum led_brightness brightness)
> +{
> +	struct max597x_led *led =3D cdev->driver_data;
> +	int ret;
> +
> +	if (!led || !led->regmap)
> +		return -1;

-ERRNO.

> +static int max597x_led_probe(struct platform_device *pdev)
> +{
> +
> +
> +	struct max597x_data *max597x =3D dev_get_drvdata(pdev->dev.parent);
> +	struct device_node *np =3D dev_of_node(pdev->dev.parent);

Delete empty lines.

> +	struct device_node *led_node;
> +	struct device_node *child;
> +	int ret =3D 0;
> +
> +

One empty line would be enough.

> +module_platform_driver(max597x_led_driver);
> +
> +
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");

One empty line would be enough.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--iSeZnk6FyAS3EJ1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtQD5wAKCRAw5/Bqldv6
8iukAKC6i4x6xTqhiPFDDmaurBP8cJPungCfYHpHAGZD40duQYsZB3oSNH8JPlg=
=S/0y
-----END PGP SIGNATURE-----

--iSeZnk6FyAS3EJ1y--
