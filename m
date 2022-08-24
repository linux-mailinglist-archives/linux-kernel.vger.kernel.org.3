Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBF59FF32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiHXQN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbiHXQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:13:23 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1951E8A6D4;
        Wed, 24 Aug 2022 09:13:17 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id D33D21086F5;
        Wed, 24 Aug 2022 18:12:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BFcNPxeV8lOl; Wed, 24 Aug 2022 18:12:30 +0200 (CEST)
Received: from localhost (softwrestling.org [95.216.36.37])
        by vm3.sequanux.org (Postfix) with ESMTPSA id EECBD1086F3;
        Wed, 24 Aug 2022 18:12:29 +0200 (CEST)
Date:   Wed, 24 Aug 2022 18:12:12 +0200
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
Subject: Re: [PATCH v5 1/5] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Message-ID: <YwZN3DU0UA6ge65N@76cbfcf04d45>
References: <20220824140347.1842-1-henning.schild@siemens.com>
 <20220824140347.1842-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fqaR/Dl4hXLpjxXB"
Content-Disposition: inline
In-Reply-To: <20220824140347.1842-2-henning.schild@siemens.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fqaR/Dl4hXLpjxXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 04:03:43PM +0200, Henning Schild wrote:
> Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> very similar to the ones from Fintek. In other subsystems they also
> share drivers and are called a family of drivers.
>=20
> For the GPIO subsystem the only difference is that the direction bit is
> reversed and that there is only one data bit per pin. On the SuperIO
> level the logical device is another one.
>=20
> On a chip level we do not have a manufacturer ID to check and also no
> revision.
>=20
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Acked-by: Simon Guinot <simon.guinot@sequanux.org>

> ---
>  drivers/gpio/Kconfig       |   3 +-
>  drivers/gpio/gpio-f7188x.c | 106 ++++++++++++++++++++++++++++---------
>  2 files changed, 83 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 0642f579196f..3f64345fe40b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -874,10 +874,11 @@ config GPIO_104_IDI_48
>  	  module parameter.
> =20
>  config GPIO_F7188X
> -	tristate "F71869, F71869A, F71882FG, F71889F and F81866 GPIO support"
> +	tristate "Fintek and Nuvoton Super-I/O GPIO support"
>  	help
>  	  This option enables support for GPIOs found on Fintek Super-I/O
>  	  chips F71869, F71869A, F71882FG, F71889F and F81866.
> +	  As well as Nuvoton Super-I/O chip NCT6116D.
> =20
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called f7188x-gpio.
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index 18a3147f5a42..b73bf28bf347 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882, F71889 and =
F81866
> + * GPIO driver for Fintek and Nuvoton Super-I/O chips
>   *
>   * Copyright (C) 2010-2013 LaCie
>   *
> @@ -21,23 +21,36 @@
>   */
>  #define SIO_LDSEL		0x07	/* Logical device select */
>  #define SIO_DEVID		0x20	/* Device ID (2 bytes) */
> -#define SIO_DEVREV		0x22	/* Device revision */
> -#define SIO_MANID		0x23	/* Fintek ID (2 bytes) */
> =20
> -#define SIO_LD_GPIO		0x06	/* GPIO logical device */
>  #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
>  #define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
> =20
> -#define SIO_FINTEK_ID		0x1934	/* Manufacturer ID */
> +/*
> + * Fintek devices.
> + */
> +#define SIO_FINTEK_DEVREV	0x22	/* Fintek Device revision */
> +#define SIO_FINTEK_MANID	0x23    /* Fintek ID (2 bytes) */
> +
> +#define SIO_FINTEK_ID		0x1934  /* Manufacturer ID */
> +
>  #define SIO_F71869_ID		0x0814	/* F71869 chipset ID */
>  #define SIO_F71869A_ID		0x1007	/* F71869A chipset ID */
>  #define SIO_F71882_ID		0x0541	/* F71882 chipset ID */
>  #define SIO_F71889_ID		0x0909	/* F71889 chipset ID */
>  #define SIO_F71889A_ID		0x1005	/* F71889A chipset ID */
>  #define SIO_F81866_ID		0x1010	/* F81866 chipset ID */
> -#define SIO_F81804_ID		0x1502  /* F81804 chipset ID, same for f81966 */
> +#define SIO_F81804_ID		0x1502  /* F81804 chipset ID, same for F81966 */
>  #define SIO_F81865_ID		0x0704	/* F81865 chipset ID */
> =20
> +#define SIO_LD_GPIO_FINTEK	0x06	/* GPIO logical device */
> +
> +/*
> + * Nuvoton devices.
> + */
> +#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
> +
> +#define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
> +
> =20
>  enum chips {
>  	f71869,
> @@ -48,6 +61,7 @@ enum chips {
>  	f81866,
>  	f81804,
>  	f81865,
> +	nct6116d,
>  };
> =20
>  static const char * const f7188x_names[] =3D {
> @@ -59,10 +73,12 @@ static const char * const f7188x_names[] =3D {
>  	"f81866",
>  	"f81804",
>  	"f81865",
> +	"nct6116d",
>  };
> =20
>  struct f7188x_sio {
>  	int addr;
> +	int device;
>  	enum chips type;
>  };
> =20
> @@ -170,6 +186,9 @@ static int f7188x_gpio_set_config(struct gpio_chip *c=
hip, unsigned offset,
>  /* Output mode register (0:open drain 1:push-pull). */
>  #define gpio_out_mode(base) (base + 3)
> =20
> +#define gpio_dir_invert(type)	((type) =3D=3D nct6116d)
> +#define gpio_data_single(type)	((type) =3D=3D nct6116d)
> +
>  static struct f7188x_gpio_bank f71869_gpio_bank[] =3D {
>  	F7188X_GPIO_BANK(0, 6, 0xF0),
>  	F7188X_GPIO_BANK(10, 8, 0xE0),
> @@ -254,6 +273,17 @@ static struct f7188x_gpio_bank f81865_gpio_bank[] =
=3D {
>  	F7188X_GPIO_BANK(60, 5, 0x90),
>  };
> =20
> +static struct f7188x_gpio_bank nct6116d_gpio_bank[] =3D {
> +	F7188X_GPIO_BANK(0, 8, 0xE0),
> +	F7188X_GPIO_BANK(10, 8, 0xE4),
> +	F7188X_GPIO_BANK(20, 8, 0xE8),
> +	F7188X_GPIO_BANK(30, 8, 0xEC),
> +	F7188X_GPIO_BANK(40, 8, 0xF0),
> +	F7188X_GPIO_BANK(50, 8, 0xF4),
> +	F7188X_GPIO_BANK(60, 8, 0xF8),
> +	F7188X_GPIO_BANK(70, 1, 0xFC),
> +};
> +
>  static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned of=
fset)
>  {
>  	int err;
> @@ -264,13 +294,16 @@ static int f7188x_gpio_get_direction(struct gpio_ch=
ip *chip, unsigned offset)
>  	err =3D superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
> =20
>  	dir =3D superio_inb(sio->addr, gpio_dir(bank->regbase));
> =20
>  	superio_exit(sio->addr);
> =20
> -	if (dir & 1 << offset)
> +	if (gpio_dir_invert(sio->type))
> +		dir =3D ~dir;
> +
> +	if (dir & BIT(offset))
>  		return GPIO_LINE_DIRECTION_OUT;
> =20
>  	return GPIO_LINE_DIRECTION_IN;
> @@ -286,10 +319,14 @@ static int f7188x_gpio_direction_in(struct gpio_chi=
p *chip, unsigned offset)
>  	err =3D superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
> =20
>  	dir =3D superio_inb(sio->addr, gpio_dir(bank->regbase));
> -	dir &=3D ~BIT(offset);
> +
> +	if (gpio_dir_invert(sio->type))
> +		dir |=3D BIT(offset);
> +	else
> +		dir &=3D ~BIT(offset);
>  	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> =20
>  	superio_exit(sio->addr);
> @@ -307,11 +344,11 @@ static int f7188x_gpio_get(struct gpio_chip *chip, =
unsigned offset)
>  	err =3D superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
> =20
>  	dir =3D superio_inb(sio->addr, gpio_dir(bank->regbase));
>  	dir =3D !!(dir & BIT(offset));
> -	if (dir)
> +	if (gpio_data_single(sio->type) || dir)
>  		data =3D superio_inb(sio->addr, gpio_data_out(bank->regbase));
>  	else
>  		data =3D superio_inb(sio->addr, gpio_data_in(bank->regbase));
> @@ -332,7 +369,7 @@ static int f7188x_gpio_direction_out(struct gpio_chip=
 *chip,
>  	err =3D superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
> =20
>  	data_out =3D superio_inb(sio->addr, gpio_data_out(bank->regbase));
>  	if (value)
> @@ -342,7 +379,10 @@ static int f7188x_gpio_direction_out(struct gpio_chi=
p *chip,
>  	superio_outb(sio->addr, gpio_data_out(bank->regbase), data_out);
> =20
>  	dir =3D superio_inb(sio->addr, gpio_dir(bank->regbase));
> -	dir |=3D BIT(offset);
> +	if (gpio_dir_invert(sio->type))
> +		dir &=3D ~BIT(offset);
> +	else
> +		dir |=3D BIT(offset);
>  	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> =20
>  	superio_exit(sio->addr);
> @@ -360,7 +400,7 @@ static void f7188x_gpio_set(struct gpio_chip *chip, u=
nsigned offset, int value)
>  	err =3D superio_enter(sio->addr);
>  	if (err)
>  		return;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
> =20
>  	data_out =3D superio_inb(sio->addr, gpio_data_out(bank->regbase));
>  	if (value)
> @@ -388,7 +428,7 @@ static int f7188x_gpio_set_config(struct gpio_chip *c=
hip, unsigned offset,
>  	err =3D superio_enter(sio->addr);
>  	if (err)
>  		return err;
> -	superio_select(sio->addr, SIO_LD_GPIO);
> +	superio_select(sio->addr, sio->device);
> =20
>  	data =3D superio_inb(sio->addr, gpio_out_mode(bank->regbase));
>  	if (param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN)
> @@ -449,6 +489,10 @@ static int f7188x_gpio_probe(struct platform_device =
*pdev)
>  		data->nr_bank =3D ARRAY_SIZE(f81865_gpio_bank);
>  		data->bank =3D f81865_gpio_bank;
>  		break;
> +	case nct6116d:
> +		data->nr_bank =3D ARRAY_SIZE(nct6116d_gpio_bank);
> +		data->bank =3D nct6116d_gpio_bank;
> +		break;
>  	default:
>  		return -ENODEV;
>  	}
> @@ -479,18 +523,15 @@ static int __init f7188x_find(int addr, struct f718=
8x_sio *sio)
>  {
>  	int err;
>  	u16 devid;
> +	u16 manid;
> =20
>  	err =3D superio_enter(addr);
>  	if (err)
>  		return err;
> =20
>  	err =3D -ENODEV;
> -	devid =3D superio_inw(addr, SIO_MANID);
> -	if (devid !=3D SIO_FINTEK_ID) {
> -		pr_debug(DRVNAME ": Not a Fintek device at 0x%08x\n", addr);
> -		goto err;
> -	}
> =20
> +	sio->device =3D SIO_LD_GPIO_FINTEK;
>  	devid =3D superio_inw(addr, SIO_DEVID);
>  	switch (devid) {
>  	case SIO_F71869_ID:
> @@ -517,17 +558,32 @@ static int __init f7188x_find(int addr, struct f718=
8x_sio *sio)
>  	case SIO_F81865_ID:
>  		sio->type =3D f81865;
>  		break;
> +	case SIO_NCT6116D_ID:
> +		sio->device =3D SIO_LD_GPIO_NUVOTON;
> +		sio->type =3D nct6116d;
> +		break;
>  	default:
> -		pr_info(DRVNAME ": Unsupported Fintek device 0x%04x\n", devid);
> +		pr_info(DRVNAME ": Unsupported device 0x%04x\n", devid);
>  		goto err;
>  	}
> +
> +	/* double check manufacturer where possible */
> +	if (sio->type !=3D nct6116d) {
> +		manid =3D superio_inw(addr, SIO_FINTEK_MANID);
> +		if (manid !=3D SIO_FINTEK_ID) {
> +			pr_debug(DRVNAME ": Not a Fintek device at 0x%08x\n", addr);
> +			goto err;
> +		}
> +	}
> +
>  	sio->addr =3D addr;
>  	err =3D 0;
> =20
> -	pr_info(DRVNAME ": Found %s at %#x, revision %d\n",
> +	pr_info(DRVNAME ": Found %s at %#x\n",
>  		f7188x_names[sio->type],
> -		(unsigned int) addr,
> -		(int) superio_inb(addr, SIO_DEVREV));
> +		(unsigned int)addr);
> +	if (sio->type !=3D nct6116d)
> +		pr_info(DRVNAME ":   revision %d\n", superio_inb(addr, SIO_FINTEK_DEVR=
EV));
> =20
>  err:
>  	superio_exit(addr);
> --=20
> 2.35.1

--fqaR/Dl4hXLpjxXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmMGTdwACgkQzyg/RDPm
szpKpA//a9v99W2L7MC/aITtZdclGrVPzBWjc+M6Jc+rLepT+huZNkzy5gHYFbFC
S8V5Qi52t5lCmxwOUbkk+AbFD2YZybFyLKWwI9ESPhckmHsp7mdf+y3Cw+cQ4eLE
tRD2eivZbjJjhZuwm/8sQnkO4P1c+a71efl0bMqaJn8qUSXco3PRy/I8GM1c4BWU
3bbQMyRApo45Gq5yY52UbDTjdsHDd1GrvVaIIpkdltBf7EjXKbcW+IRbC94ApXJ0
CdRP9KOO9037syuU+JYKFvl2W8IAwDBWc0b0I/vlz/O1H4Uf3OvZRWYTaE0JOdYo
feB1061fP8MbwcN+8ReiNIN/AknGaPdugpusVjRBtGWiWMltpXVxMOB+w4uht1ea
psj5slId7c1XhDYtU79WemCQD8CLq4H/gAGXntI1jqItzgptF6eBOvoF6EyaqoFe
+FE9Tp/L/gDnLV3+PhWEgKi+U2f2PXYxPgG5dANVO0c3cvBlL8aN5hoR9IIOIUj1
+Fca/nqIy0laiBNsyW3HraN3Yv+aHcNL9wWkr9unzP8MNPSxK3JCJ06+Je5+jf6+
GOneE9NsH7wGtIxEk3wtCdVQ4Vi78rD0mZ84fmz7jyPeAfq08kJ1fwO2IyvEZ0Js
tQ2wKOtUE0ERtuoDwWGLMKa+4ods1BQtEpNsq3saZ9D+FOIagnI=
=cJ5I
-----END PGP SIGNATURE-----

--fqaR/Dl4hXLpjxXB--
