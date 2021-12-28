Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7B480D99
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 23:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhL1WHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 17:07:31 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:57778 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhL1WHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 17:07:30 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5B10C1C0B77; Tue, 28 Dec 2021 23:07:28 +0100 (CET)
Date:   Tue, 28 Dec 2021 23:07:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2] leds: add NCT6795D driver
Message-ID: <20211228220727.GA17003@duo.ucw.cz>
References: <20211212054706.80343-1-gnurou@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20211212054706.80343-1-gnurou@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add support for the LED feature of the NCT6795D chip found on some
> motherboards, notably MSI ones. The LEDs are typically used using a
> RGB connector so this driver takes advantage of the multicolor
> framework.

Ok.

> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> ---
> Changes since v1 [1]:
> - Use the multicolor framework
>=20
> [1] https://lkml.org/lkml/2020/7/13/674 (sorry, took me some time to
>     come back to this patch)
>=20
>  drivers/leds/Kconfig         |  10 +
>  drivers/leds/Makefile        |   1 +
>  drivers/leds/leds-nct6795d.c | 442 +++++++++++++++++++++++++++++++++++
>  3 files changed, 453 insertions(+)
>  create mode 100644 drivers/leds/leds-nct6795d.c
>=20
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index ed800f5da7d8..0db5986ca967 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -871,6 +871,16 @@ config LEDS_ACER_A500
>  	  This option enables support for the Power Button LED of
>  	  Acer Iconia Tab A500.

Can we put it into drivers/leds/multi/? Lets group multicolor stuff there.

> +config LEDS_NCT6795D
> +	tristate "LED support for NCT6795D chipsets"
> +	depends on LEDS_CLASS_MULTICOLOR
> +	help
> +	  Enables support for the RGB LED feature of the NCT6795D chips found
> +	  on some MSI motherboards.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called leds-nct6795d.

=2Eko?

> diff --git a/drivers/leds/leds-nct6795d.c b/drivers/leds/leds-nct6795d.c
> new file mode 100644
> index 000000000000..90d5d2a67cfa
> --- /dev/null
> +++ b/drivers/leds/leds-nct6795d.c
> @@ -0,0 +1,442 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * NCT6795D/NCT6797D LED driver
> + *
> + * Copyright (c) 2021 Alexandre Courbot <gnurou@gmail.com>
> + *
> + * Driver to control the RGB interfaces found on some MSI motherboards.
> + * This is for the most part a port of the MSI-RGB user-space program
> + * by Simonas Kazlauskas (https://github.com/nagisa/msi-rgb.git) to the =
Linux
> + * kernel LED interface.
> + *
> + * It is more limited than the original program due to limitations in th=
e LED
> + * interface. For now, only static colors are supported.

Ok. We do have pattern trigger and hardware-accelerated blinking, if
it helps. But that may be a lot of fun with multicolor.

> +static inline int superio_enter(int ioreg)
> +{
> +	if (!request_muxed_region(ioreg, 2, "NCT6795D LED"))
> +		return -EBUSY;
> +
> +	outb(0x87, ioreg);
> +	outb(0x87, ioreg);
> +
> +	return 0;
> +}
> +
> +static inline void superio_exit(int ioreg)
> +{
> +	outb(0xaa, ioreg);
> +	outb(0x02, ioreg);
> +	outb(0x02, ioreg + 1);
> +	release_region(ioreg, 2);
> +}

Are these two too big for inline?

> +static u8 init_vals[NUM_COLORS];
> +module_param_named(r, init_vals[RED], byte, 0);
> +MODULE_PARM_DESC(r, "Initial red intensity (default 0)");
> +module_param_named(g, init_vals[GREEN], byte, 0);
> +MODULE_PARM_DESC(g, "Initial green intensity (default 0)");
> +module_param_named(b, init_vals[BLUE], byte, 0);
> +MODULE_PARM_DESC(b, "Initial blue intensity (default 0)");

Lets... not add parameters for this.

> +/*
> + * Return the detected chip or an error code. If no chip was detected, -=
ENXIO
> + * is returned.
> + */
> +static enum nct679x_chip nct6795d_led_detect(u16 base_port)
> +{

"enum" return type is confusing here, as you also return errors.

> +	val =3D superio_inb(led->base_port, 0x2c);
> +	if ((val & 0x10) !=3D 0x10)
> +		superio_outb(led->base_port, 0x2c, val | 0x10);
> +
> +	superio_select(led->base_port, NCT6795D_RGB_BANK);
> +
> +	/* Check if RGB control enabled */
> +	val =3D superio_inb(led->base_port, 0xe0);
> +	if ((val & 0xe0) !=3D 0xe0)
> +		superio_outb(led->base_port, 0xe0, val | 0xe0);

I'd simply do outbs unconditionally...

> +/*
> + * Commit all colors to the hardware.
> + */
> +static int nct6795d_led_commit(const struct nct6795d_led *led)
> +{
> +	const struct mc_subled *subled =3D led->subled;
> +	int ret;
> +
> +	dev_dbg(led->dev, "setting values: R=3D%d G=3D%d B=3D%d\n",
> +		subled[RED].brightness, subled[GREEN].brightness,
> +		subled[BLUE].brightness);
> +
> +	ret =3D superio_enter(led->base_port);
> +	if (ret)
> +		return ret;

Are you sure you want to do superio_enter() each time LED values are
updated? That sounds... expensive, wrong. You have
request_muxed_region() call in there.

> +static int __init nct6795d_led_init(void)
> +{
> +	static const u16 io_bases[] =3D { 0x4e, 0x2e };
> +	struct resource io_res =3D {
> +		.name =3D "io_base",
> +		.flags =3D IORESOURCE_REG,
> +	};
> +	enum nct679x_chip detected_chip;
> +	int ret;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(io_bases); i++) {
> +		detected_chip =3D nct6795d_led_detect(io_bases[i]);
> +		if (detected_chip >=3D 0)
> +			break;
> +	}

Are you sure this won't cause problems somewhere? Could compatible
mainboards be detected using DMI or something like that?


> +	if (i =3D=3D ARRAY_SIZE(io_bases)) {
> +		pr_err(KBUILD_MODNAME ": no supported chip detected\n");
> +		return -ENXIO;
> +	}

I don't think ENXIO is normally used like this. -ENODEV? You have this
elsewhere, too.

> +
> +	pr_info(KBUILD_MODNAME ": found %s chip at address 0x%x\n",
> +		chip_names[detected_chip], io_bases[i]);
> +
> +	ret =3D platform_driver_register(&nct6795d_led_driver);
> +	if (ret)
> +		return ret;
> +
> +	nct6795d_led_pdev =3D
> +		platform_device_alloc(NCT6795D_DEVICE_NAME "_led", 0);
> +	if (!nct6795d_led_pdev) {
> +		ret =3D -ENOMEM;
> +		goto error_pdev_alloc;
> +	}

Are you sure you are using platform devices in reasonable way? You
probe, first, then register. That's highly unusual.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYcuKnwAKCRAw5/Bqldv6
8mXfAJ9aFEPpX76mJwzVQM6FN8IzJkaQOQCbBAGS5JiF7Jl6XaQvOSekf4sLpko=
=0J7T
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
