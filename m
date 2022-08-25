Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10495A0FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbiHYMD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbiHYMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:03:22 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D1109F8E1;
        Thu, 25 Aug 2022 05:03:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id 2343410880C;
        Thu, 25 Aug 2022 14:02:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QeA1dTuyiUkp; Thu, 25 Aug 2022 14:02:20 +0200 (CEST)
Received: from localhost (softwrestling.org [95.216.36.37])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 49FBF1086FC;
        Thu, 25 Aug 2022 14:02:20 +0200 (CEST)
Date:   Thu, 25 Aug 2022 14:02:06 +0200
From:   simon.guinot@sequanux.org
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Subject: Re: [PATCH v6 1/7] gpio-f7188x: switch over to using pr_fmt
Message-ID: <Ywdkvu0VNWti1WTe@76cbfcf04d45>
References: <20220825104422.14156-1-henning.schild@siemens.com>
 <20220825104422.14156-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8eVkuOeCNQZeK+6U"
Content-Disposition: inline
In-Reply-To: <20220825104422.14156-2-henning.schild@siemens.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8eVkuOeCNQZeK+6U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2022 at 12:44:16PM +0200, Henning Schild wrote:
> Subsequent patches will touch that file, apply some nice to have style
> changes before actually adding functional changes.
>=20
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Acked-by: Simon Guinot <simon.guinot@sequanux.org>

> ---
>  drivers/gpio/gpio-f7188x.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index 18a3147f5a42..fef539bbc03a 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -7,6 +7,9 @@
>   * Author: Simon Guinot <simon.guinot@sequanux.org>
>   */
> =20
> +#define DRVNAME "gpio-f7188x"
> +#define pr_fmt(fmt) DRVNAME ": " fmt
> +
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> @@ -14,8 +17,6 @@
>  #include <linux/gpio/driver.h>
>  #include <linux/bitops.h>
> =20
> -#define DRVNAME "gpio-f7188x"
> -
>  /*
>   * Super-I/O registers
>   */
> @@ -110,7 +111,7 @@ static inline int superio_enter(int base)
>  {
>  	/* Don't step on other drivers' I/O space by accident. */
>  	if (!request_muxed_region(base, 2, DRVNAME)) {
> -		pr_err(DRVNAME "I/O address 0x%04x already in use\n", base);
> +		pr_err("I/O address 0x%04x already in use\n", base);
>  		return -EBUSY;
>  	}
> =20
> @@ -487,7 +488,7 @@ static int __init f7188x_find(int addr, struct f7188x=
_sio *sio)
>  	err =3D -ENODEV;
>  	devid =3D superio_inw(addr, SIO_MANID);
>  	if (devid !=3D SIO_FINTEK_ID) {
> -		pr_debug(DRVNAME ": Not a Fintek device at 0x%08x\n", addr);
> +		pr_debug("Not a Fintek device at 0x%08x\n", addr);
>  		goto err;
>  	}
> =20
> @@ -518,13 +519,13 @@ static int __init f7188x_find(int addr, struct f718=
8x_sio *sio)
>  		sio->type =3D f81865;
>  		break;
>  	default:
> -		pr_info(DRVNAME ": Unsupported Fintek device 0x%04x\n", devid);
> +		pr_info("Unsupported Fintek device 0x%04x\n", devid);
>  		goto err;
>  	}
>  	sio->addr =3D addr;
>  	err =3D 0;
> =20
> -	pr_info(DRVNAME ": Found %s at %#x, revision %d\n",
> +	pr_info("Found %s at %#x, revision %d\n",
>  		f7188x_names[sio->type],
>  		(unsigned int) addr,
>  		(int) superio_inb(addr, SIO_DEVREV));
> @@ -548,13 +549,13 @@ f7188x_gpio_device_add(const struct f7188x_sio *sio)
>  	err =3D platform_device_add_data(f7188x_gpio_pdev,
>  				       sio, sizeof(*sio));
>  	if (err) {
> -		pr_err(DRVNAME "Platform data allocation failed\n");
> +		pr_err("Platform data allocation failed\n");
>  		goto err;
>  	}
> =20
>  	err =3D platform_device_add(f7188x_gpio_pdev);
>  	if (err) {
> -		pr_err(DRVNAME "Device addition failed\n");
> +		pr_err("Device addition failed\n");
>  		goto err;
>  	}
> =20
> --=20
> 2.35.1

--8eVkuOeCNQZeK+6U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmMHZLoACgkQzyg/RDPm
szpxxBAAmtKLLqa5vkTy0Ur+b3aTcHHH0Mb/j+RbTY1y+onlBpjc5i//1MCNBDiU
w0AMTQFUBuvlGW/kvs8JoZTsnU2kMGjxwBCL+KbQVvNCmHb2A6J/+ccmJ5WAuNxx
LKkwj3tjnsUxH34brPOp6CVJJkSJUhlwL/7AocQfC4KjvZ48FYjvp+ZQZIzrOLGc
9YZpHD5ByjvRAoaDNqGpzPvCP+rUgA/OUF8UaTjv9ReV4wJqlpd1T0mQgocAcAx9
wgibepOyck1koj5aW66uYYg+8EZ648yW8MV4mNdS5pBaRyOOZoln+LfSIlmPClbF
sHULNz0tF6zOzULRbMDAG8J4X0hjzyeQSm7V6ieJ8HrfSrCM9yEoJELo1qezN8YK
+dS/ayy2mRCzbynr4/PorSAJbC7a0kZZ8teLLmbg6L40NFu3KbdRpLDUwh4cfntK
1jBy+v2UMueJ7MhxhgRm6mi4RmS8OL0qt+1WivkSVtIFPM6UlsnEKanpxgoMg18m
cgmX5XOnu8Ejx0KVNIAi8Rx0XmwsxIxx54M4C2jCXOqSAiashUKQfSoSqpLt1xfe
NSgI9W/Q0hpAQZQw3KqA8mJfHJw19i2DF9vRq/4LX8smoNlnQwvQwo/xAljwwg2i
QzL0SgK3MoykWb7vHZtWgF8+zSC5t+21POY57CleZsJYvV8ZggI=
=6jNd
-----END PGP SIGNATURE-----

--8eVkuOeCNQZeK+6U--
