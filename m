Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39767590D99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbiHLIoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbiHLIoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:44:14 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D126CA8965;
        Fri, 12 Aug 2022 01:44:12 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id EBDD2108095;
        Fri, 12 Aug 2022 10:43:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ryt02m_ZlS5e; Fri, 12 Aug 2022 10:43:14 +0200 (CEST)
Received: from localhost (softwrestling.org [95.216.36.37])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 06647108752;
        Fri, 12 Aug 2022 10:43:13 +0200 (CEST)
Date:   Fri, 12 Aug 2022 10:43:03 +0200
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
Subject: Re: [PATCH v3 1/4] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Message-ID: <YvYSl2FpOGnqZfTZ@76cbfcf04d45>
References: <20220811153908.31283-1-henning.schild@siemens.com>
 <20220811153908.31283-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ouneLSNkbbKTFRML"
Content-Disposition: inline
In-Reply-To: <20220811153908.31283-2-henning.schild@siemens.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ouneLSNkbbKTFRML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 11, 2022 at 05:39:05PM +0200, Henning Schild wrote:
> Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> very similar to the ones from Fintek. In other subsystems they also
> share drivers and are called a family of drivers.
>=20
> For the GPIO subsystem the only difference is that the direction bit is
> reversed and that there is only one data bit per pin. On the SuperIO
> level the logical device is another one.
>=20
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/gpio/gpio-f7188x.c | 71 +++++++++++++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index 18a3147f5a42..7b05ecc611e9 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882, F71889 and =
F81866
> + * and Nuvoton Super-I/O NCT6116D
>   *
>   * Copyright (C) 2010-2013 LaCie
>   *
> @@ -22,13 +23,12 @@
>  #define SIO_LDSEL		0x07	/* Logical device select */
>  #define SIO_DEVID		0x20	/* Device ID (2 bytes) */
>  #define SIO_DEVREV		0x22	/* Device revision */
> -#define SIO_MANID		0x23	/* Fintek ID (2 bytes) */
> =20
> -#define SIO_LD_GPIO		0x06	/* GPIO logical device */
>  #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
>  #define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
> =20
> -#define SIO_FINTEK_ID		0x1934	/* Manufacturer ID */
> +#define SIO_LD_GPIO_FINTEK	0x06	/* GPIO logical device */
> +#define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */

Please indulge me and add a new line here.

>  #define SIO_F71869_ID		0x0814	/* F71869 chipset ID */
>  #define SIO_F71869A_ID		0x1007	/* F71869A chipset ID */
>  #define SIO_F71882_ID		0x0541	/* F71882 chipset ID */
> @@ -37,7 +37,7 @@
>  #define SIO_F81866_ID		0x1010	/* F81866 chipset ID */
>  #define SIO_F81804_ID		0x1502  /* F81804 chipset ID, same for f81966 */
>  #define SIO_F81865_ID		0x0704	/* F81865 chipset ID */
> -
> +#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
> =20

=2E.. snip ...

> @@ -485,12 +516,8 @@ static int __init f7188x_find(int addr, struct f7188=
x_sio *sio)
>  		return err;
> =20
>  	err =3D -ENODEV;
> -	devid =3D superio_inw(addr, SIO_MANID);
> -	if (devid !=3D SIO_FINTEK_ID) {
> -		pr_debug(DRVNAME ": Not a Fintek device at 0x%08x\n", addr);
> -		goto err;
> -	}

Sorry for missing that at my first review. You can't remove this block
of code. This driver is poking around on the I2C bus, which is not
great. So we want to make sure as much as possible that we are speaking
to the right device.

Simon

--ouneLSNkbbKTFRML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmL2EpMACgkQzyg/RDPm
szouqQ//Xm9sagJ+5NtJYyyq5s/U5oK5vxLAExQHpoto22qUjrB2E/30aiJt5v4N
XzoV9Iqya8fOGFJeIwXwhKmoKdX/LW3XyOGK5Wp3jlBVsOw+551T6A6PxW2hH6SZ
5+2CkgOw3+PoCs5XAN4eU33k4uii31D8vtR0fGtQ0HvrtuPWjtNTawaXH2JFVC5h
kBZF+o7vUYIv6RJJf1O3zQL9uWPtJl6QuHmLVw9+AfW0ndQjFWzpgxCcvb29VS9g
sjGlgqyDLeoDODxP+0plqFa/Pb4n74Mi/Xlv9ygRT7xtc2Cz4U4VFaZqvo31yQ83
ogbwvsR+SW3KaB/GS4wPVg5ogYUmVLo+46HIvaiMxW61/GWYDUH5EE5T62EWOdMw
B4+/FwUiZ6DMOvsSgHkkIztNswBMjZrOPPoYkrqs1thV0rXDQUzPXhJGTFGY8glw
iDlF+FcQzBsxKQ3AAtLFAs4gNaPa1tNYcNhgneXpA2pv5c57GSmkJ15hEkwWO0qs
p+shGzwecgkE3g1pKz+QoxGNtZBte4K+d2HpI67XxPi9W4/Fh8T3u3TeKVazXDN/
uudFsjYx31Njb/mDe6AbAgfo1TZF0xajk8PTjR+gMq94Y78cK2nxwKa486OqHVRw
IEosfhp62UPWz6faNf1r/mkbC78NdVm5xFHkamv2PprSVGI6Dw0=
=gt73
-----END PGP SIGNATURE-----

--ouneLSNkbbKTFRML--
