Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934C558FD79
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiHKNhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiHKNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:37:33 -0400
X-Greylist: delayed 291 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 Aug 2022 06:37:32 PDT
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F42C6FA0A;
        Thu, 11 Aug 2022 06:37:32 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id 4B5A71087EA;
        Thu, 11 Aug 2022 15:37:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6IrJoOqWwxPG; Thu, 11 Aug 2022 15:36:29 +0200 (CEST)
Received: from localhost (softwrestling.org [95.216.36.37])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 69D6F108702;
        Thu, 11 Aug 2022 15:36:29 +0200 (CEST)
Date:   Thu, 11 Aug 2022 15:36:15 +0200
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
Subject: Re: [PATCH v2 2/4] gpio-f7188x: use unique labels for banks/chips
Message-ID: <YvUFz0SmzCk8cRrK@76cbfcf04d45>
References: <20220809150442.3525-1-henning.schild@siemens.com>
 <20220809150442.3525-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SzzCHqagaYVjy5mk"
Content-Disposition: inline
In-Reply-To: <20220809150442.3525-3-henning.schild@siemens.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SzzCHqagaYVjy5mk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2022 at 05:04:40PM +0200, Henning Schild wrote:
> So that drivers building on top can find those pins with GPIO_LOOKUP
> helpers.
>=20
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Acked-by: Simon Guinot <simon.guinot@sequanux.org>

> ---
>  drivers/gpio/gpio-f7188x.c | 138 ++++++++++++++++++-------------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index 4d8f38bc3b45..9c91832b8c71 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -150,10 +150,10 @@ static void f7188x_gpio_set(struct gpio_chip *chip,=
 unsigned offset, int value);
>  static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offse=
t,
>  				  unsigned long config);
> =20
> -#define F7188X_GPIO_BANK(_base, _ngpio, _regbase)			\
> +#define F7188X_GPIO_BANK(_base, _ngpio, _regbase, _label)			\
>  	{								\
>  		.chip =3D {						\
> -			.label            =3D DRVNAME,			\
> +			.label            =3D _label,			\
>  			.owner            =3D THIS_MODULE,		\
>  			.get_direction    =3D f7188x_gpio_get_direction,	\
>  			.direction_input  =3D f7188x_gpio_direction_in,	\
> @@ -178,98 +178,98 @@ static int f7188x_gpio_set_config(struct gpio_chip =
*chip, unsigned offset,
>  #define gpio_single_data(device)	((device) !=3D SIO_LD_GPIO_FINTEK)
> =20
>  static struct f7188x_gpio_bank f71869_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 6, 0xF0),
> -	F7188X_GPIO_BANK(10, 8, 0xE0),
> -	F7188X_GPIO_BANK(20, 8, 0xD0),
> -	F7188X_GPIO_BANK(30, 8, 0xC0),
> -	F7188X_GPIO_BANK(40, 8, 0xB0),
> -	F7188X_GPIO_BANK(50, 5, 0xA0),
> -	F7188X_GPIO_BANK(60, 6, 0x90),
> +	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(60, 6, 0x90, DRVNAME "-6"),
>  };
> =20
>  static struct f7188x_gpio_bank f71869a_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 6, 0xF0),
> -	F7188X_GPIO_BANK(10, 8, 0xE0),
> -	F7188X_GPIO_BANK(20, 8, 0xD0),
> -	F7188X_GPIO_BANK(30, 8, 0xC0),
> -	F7188X_GPIO_BANK(40, 8, 0xB0),
> -	F7188X_GPIO_BANK(50, 5, 0xA0),
> -	F7188X_GPIO_BANK(60, 8, 0x90),
> -	F7188X_GPIO_BANK(70, 8, 0x80),
> +	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
>  };
> =20
>  static struct f7188x_gpio_bank f71882_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 8, 0xF0),
> -	F7188X_GPIO_BANK(10, 8, 0xE0),
> -	F7188X_GPIO_BANK(20, 8, 0xD0),
> -	F7188X_GPIO_BANK(30, 4, 0xC0),
> -	F7188X_GPIO_BANK(40, 4, 0xB0),
> +	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(30, 4, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(40, 4, 0xB0, DRVNAME "-4"),
>  };
> =20
>  static struct f7188x_gpio_bank f71889a_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 7, 0xF0),
> -	F7188X_GPIO_BANK(10, 7, 0xE0),
> -	F7188X_GPIO_BANK(20, 8, 0xD0),
> -	F7188X_GPIO_BANK(30, 8, 0xC0),
> -	F7188X_GPIO_BANK(40, 8, 0xB0),
> -	F7188X_GPIO_BANK(50, 5, 0xA0),
> -	F7188X_GPIO_BANK(60, 8, 0x90),
> -	F7188X_GPIO_BANK(70, 8, 0x80),
> +	F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
>  };
> =20
>  static struct f7188x_gpio_bank f71889_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 7, 0xF0),
> -	F7188X_GPIO_BANK(10, 7, 0xE0),
> -	F7188X_GPIO_BANK(20, 8, 0xD0),
> -	F7188X_GPIO_BANK(30, 8, 0xC0),
> -	F7188X_GPIO_BANK(40, 8, 0xB0),
> -	F7188X_GPIO_BANK(50, 5, 0xA0),
> -	F7188X_GPIO_BANK(60, 8, 0x90),
> -	F7188X_GPIO_BANK(70, 8, 0x80),
> +	F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
>  };
> =20
>  static struct f7188x_gpio_bank f81866_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 8, 0xF0),
> -	F7188X_GPIO_BANK(10, 8, 0xE0),
> -	F7188X_GPIO_BANK(20, 8, 0xD0),
> -	F7188X_GPIO_BANK(30, 8, 0xC0),
> -	F7188X_GPIO_BANK(40, 8, 0xB0),
> -	F7188X_GPIO_BANK(50, 8, 0xA0),
> -	F7188X_GPIO_BANK(60, 8, 0x90),
> -	F7188X_GPIO_BANK(70, 8, 0x80),
> -	F7188X_GPIO_BANK(80, 8, 0x88),
> +	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
> +	F7188X_GPIO_BANK(80, 8, 0x88, DRVNAME "-8"),
>  };
> =20
> =20
>  static struct f7188x_gpio_bank f81804_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 8, 0xF0),
> -	F7188X_GPIO_BANK(10, 8, 0xE0),
> -	F7188X_GPIO_BANK(20, 8, 0xD0),
> -	F7188X_GPIO_BANK(50, 8, 0xA0),
> -	F7188X_GPIO_BANK(60, 8, 0x90),
> -	F7188X_GPIO_BANK(70, 8, 0x80),
> -	F7188X_GPIO_BANK(90, 8, 0x98),
> +	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(90, 8, 0x98, DRVNAME "-6"),
>  };
> =20
>  static struct f7188x_gpio_bank f81865_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 8, 0xF0),
> -	F7188X_GPIO_BANK(10, 8, 0xE0),
> -	F7188X_GPIO_BANK(20, 8, 0xD0),
> -	F7188X_GPIO_BANK(30, 8, 0xC0),
> -	F7188X_GPIO_BANK(40, 8, 0xB0),
> -	F7188X_GPIO_BANK(50, 8, 0xA0),
> -	F7188X_GPIO_BANK(60, 5, 0x90),
> +	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),
>  };
> =20
>  static struct f7188x_gpio_bank nct6116d_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 8, 0xE0),
> -	F7188X_GPIO_BANK(10, 8, 0xE4),
> -	F7188X_GPIO_BANK(20, 8, 0xE8),
> -	F7188X_GPIO_BANK(30, 8, 0xEC),
> -	F7188X_GPIO_BANK(40, 8, 0xF0),
> -	F7188X_GPIO_BANK(50, 8, 0xF4),
> -	F7188X_GPIO_BANK(60, 8, 0xF8),
> -	F7188X_GPIO_BANK(70, 1, 0xFC),
> +	F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(30, 8, 0xEC, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
>  };
> =20
>  static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned of=
fset)
> --=20
> 2.35.1

--SzzCHqagaYVjy5mk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmL1Bc8ACgkQzyg/RDPm
szp4iw//Zb3bF0W59U4UP3UOh2jPvUvX+tEhu3tdv5S0UWtgNhEuzjrRAvGW1tQo
P8YuvwWPstfGdrkHoLVkFje1nGPTnpE1sovaIzVxsXuCrGC5TAFqjaZLwYwCsH6j
aBCZhuQT0cBrRaOydPHXse+AYiA8BPQ/uNrRdT+aVvFJwRBAzgsnXTG/BitV+3Tr
f0Ew0vgpdTOQ5bj/AAyN/cNav2xukzCQrkqRzAHtXHOU4tZKg2as2UUIODYziMY2
KJP7Bhyi0NgdjzMdZsxcC8RnMleSl2LSCb/jw0kGOuZ+lNO/FNUvFyde46SVvtxx
+Yq9xqK1Nvu1SOLhf8TpIAphfpZuT9viXY3Eg9D6N3tppCJvgEojdHZxoMhvewH+
l60W6WuQgtzDP63bZbuZ4b7czBk1xJROjBwtcGv8YwMOdWT0rqERVLIfA0vRL8w4
p3eWTG49l+Zd2eEO/GuDq6Yc7pSMhHogXER//zbWRE1wE2x9s+oRXejbjawLv7z7
c5tEgQDJM1V4YNqcH4YkqHQot/c3xEALkT6T2V3Mf8Bt8csFXEtxSaS2vBitBEup
nDFA0oJ4k1Ygo9JjQoVyx53JSofWdccBbFzqSFrKyceVmbGEMRmgzDGspSLUTEXL
WAXL6a8gL2+STB/tW9tr93yhPKBkfoxRLFKh0yEDDGIQoGjcIbs=
=RX9P
-----END PGP SIGNATURE-----

--SzzCHqagaYVjy5mk--
