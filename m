Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A267476303
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhLOUSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:18:04 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:44876 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhLOUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:18:04 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1873F1C0B98; Wed, 15 Dec 2021 21:18:02 +0100 (CET)
Date:   Wed, 15 Dec 2021 21:18:00 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
Subject: Re: [PATCH v5 2/4] leds: simatic-ipc-leds: add new driver for
 Siemens Industial PCs
Message-ID: <20211215201800.GA28336@duo.ucw.cz>
References: <20211213120502.20661-1-henning.schild@siemens.com>
 <20211213120502.20661-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20211213120502.20661-3-henning.schild@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2021-12-13 13:05:00, Henning Schild wrote:
> This driver adds initial support for several devices from Siemens. It is
> based on a platform driver introduced in an earlier commit.
>=20
> One of the supported machines has GPIO connected LEDs, here we poke GPIO
> memory directly because pinctrl does not come up.
>=20
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> index c636ec069612..1a719caf14c0 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -105,3 +105,6 @@ obj-$(CONFIG_LEDS_TRIGGERS)		+=3D trigger/
> =20
>  # LED Blink
>  obj-y					+=3D blink/
> +
> +# Simple LED drivers
> +obj-y					+=3D simple/
> diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
> new file mode 100644
> index 000000000000..9f6a68336659
> --- /dev/null
> +++ b/drivers/leds/simple/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config LEDS_SIEMENS_SIMATIC_IPC
> +	tristate "LED driver for Siemens Simatic IPCs"
> +	depends on LEDS_CLASS
> +	depends on SIEMENS_SIMATIC_IPC
> +	help
> +	  This option enables support for the LEDs of several Industrial PCs
> +	  from Siemens.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called simatic-ipc-leds.
> diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
> new file mode 100644
> index 000000000000..8481f1e9e360
> --- /dev/null
> +++ b/drivers/leds/simple/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+=3D simatic-ipc-leds.o
> diff --git a/drivers/leds/simple/simatic-ipc-leds.c b/drivers/leds/simple=
/simatic-ipc-leds.c
> new file mode 100644
> index 000000000000..ff2c96e73241
> --- /dev/null
> +++ b/drivers/leds/simple/simatic-ipc-leds.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Siemens SIMATIC IPC driver for LEDs
> + *
> + * Copyright (c) Siemens AG, 2018-2021
> + *
> + * Authors:
> + *  Henning Schild <henning.schild@siemens.com>
> + *  Jan Kiszka <jan.kiszka@siemens.com>
> + *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
> + */
> +
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_data/x86/simatic-ipc-base.h>
> +#include <linux/platform_device.h>
> +#include <linux/sizes.h>
> +#include <linux/spinlock.h>
> +
> +#define SIMATIC_IPC_LED_PORT_BASE	0x404E
> +
> +struct simatic_ipc_led {
> +	unsigned int value; /* mask for io and offset for mem */
> +	char *name;
> +	struct led_classdev cdev;
> +};
> +
> +static struct simatic_ipc_led simatic_ipc_leds_io[] =3D {
> +	{1 << 15, "green:" LED_FUNCTION_STATUS "-1" },
> +	{1 << 7,  "yellow:" LED_FUNCTION_STATUS "-1" },
> +	{1 << 14, "red:" LED_FUNCTION_STATUS "-2" },
> +	{1 << 6,  "yellow:" LED_FUNCTION_STATUS "-2" },
> +	{1 << 13, "red:" LED_FUNCTION_STATUS "-3" },
> +	{1 << 5,  "yellow:" LED_FUNCTION_STATUS "-3" },
> +	{ }
> +};
> +
> +/* the actual start will be discovered with PCI, 0 is a placeholder */
> +struct resource simatic_ipc_led_mem_res =3D DEFINE_RES_MEM_NAMED(0, SZ_4=
K, KBUILD_MODNAME);
> +
> +static void *simatic_ipc_led_memory;
> +
> +static struct simatic_ipc_led simatic_ipc_leds_mem[] =3D {
> +	{0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
> +	{0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
> +	{0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
> +	{0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
> +	{0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
> +	{0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
> +	{ }
> +};

Would it be possible to get some better naming for leds? status-1 to
status-3 is not quite useful.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbpNeAAKCRAw5/Bqldv6
8uoeAJ4sl3uW+00Q8GOt0tXn49BH4Z1o1wCgvOZQDi8nnAbyEUDsGST+vgva3F4=
=0S8D
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
