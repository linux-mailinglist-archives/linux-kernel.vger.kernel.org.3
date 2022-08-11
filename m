Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9858FD89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiHKNkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiHKNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:40:01 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8D888B980;
        Thu, 11 Aug 2022 06:39:59 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id 8A7711085A5;
        Thu, 11 Aug 2022 15:32:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2HP3EqOom_St; Thu, 11 Aug 2022 15:31:53 +0200 (CEST)
Received: from localhost (softwrestling.org [95.216.36.37])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 7C0FC1086FD;
        Thu, 11 Aug 2022 15:31:53 +0200 (CEST)
Date:   Thu, 11 Aug 2022 15:31:39 +0200
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
Subject: Re: [PATCH v2 1/4] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Message-ID: <YvUEu8bUc2RgtRpi@76cbfcf04d45>
References: <20220809150442.3525-1-henning.schild@siemens.com>
 <20220809150442.3525-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u8GkZxC+9/sjoLN4"
Content-Disposition: inline
In-Reply-To: <20220809150442.3525-2-henning.schild@siemens.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u8GkZxC+9/sjoLN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2022 at 05:04:39PM +0200, Henning Schild wrote:
> Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> very similar to the ones from Fintek. In other subsystems they also
> share drivers and are called a family of drivers.
>=20
> For the GPIO subsystem the only difference is that the direction bit is
> reversed and that there is only one data bit per pin. On the SuperIO
> level the logical device is another one.
>=20
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Hi Henning,

This patch is looking good to me. I only have a couple of minor
comments. Please see them below.

> ---
>  drivers/gpio/gpio-f7188x.c | 70 +++++++++++++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index 18a3147f5a42..4d8f38bc3b45 100644
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
> @@ -22,13 +23,11 @@
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
>  #define SIO_F71869_ID		0x0814	/* F71869 chipset ID */
>  #define SIO_F71869A_ID		0x1007	/* F71869A chipset ID */
>  #define SIO_F71882_ID		0x0541	/* F71882 chipset ID */
> @@ -38,6 +37,8 @@
>  #define SIO_F81804_ID		0x1502  /* F81804 chipset ID, same for f81966 */
>  #define SIO_F81865_ID		0x0704	/* F81865 chipset ID */
> =20
> +#define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
> +#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */

Can we do better to make the definitions above more readable ? With the
new additions I find it a little bit unclear.

Maybe we could add a comment on the top of the Fintek and Nuvoton
specific sections ? Or maybe we could group the LD_GPIO_ definitions
in a dedicated section ? Or something else :)

> =20
>  enum chips {
>  	f71869,
> @@ -48,6 +49,7 @@ enum chips {
>  	f81866,
>  	f81804,
>  	f81865,
> +	nct6116d,
>  };
> =20
>  static const char * const f7188x_names[] =3D {
> @@ -59,10 +61,12 @@ static const char * const f7188x_names[] =3D {
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
> @@ -170,6 +174,9 @@ static int f7188x_gpio_set_config(struct gpio_chip *c=
hip, unsigned offset,
>  /* Output mode register (0:open drain 1:push-pull). */
>  #define gpio_out_mode(base) (base + 3)
> =20
> +#define gpio_needs_invert(device)	((device) !=3D SIO_LD_GPIO_FINTEK)
> +#define gpio_single_data(device)	((device) !=3D SIO_LD_GPIO_FINTEK)

Since this macros are only used to get/set GPIO direction, then I think
we should use the "gpio_dir_" prefix.

Also is there any reason to match the LD GPIO value rather than the
chipset type ?

I think we should enable this specific path only for a Nuvoton NCT6116
device for now (by matching the NCT6116 chipset type). So if more
devices are added later then we are sure they still go on the original
path.

--u8GkZxC+9/sjoLN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmL1BLcACgkQzyg/RDPm
szpkKA//UQnR2WkJ/05sTGuUUABp8ZNqdzlUn4UEVH1axTVZlodh01QYnDXNl8uL
CqVbUeLGRCaDGXrK+3VKJaHKX/xqRcahcvQczi/3PqinKqJy3/drKje4swJE8YnF
9Y9gaS7LHg6N2c6bdhOhDfX3mV+vHPAWQZ+9k9gMRcTxcSi0YuIlYxDQSn0bU2nf
fV5syydD4fvNz97rPAdNqKf/URaVcuXzsuT8mBso5sTn7AWh3JGJV5qOZwFL6GmE
2Ykt0e4vEseGjFl+2NdefLQsL0IZJ90TrT7LBXWSVsPSKFxXB0yLRFyGz4S30hB3
43/mDZOYwzFR/2FA1gj4kA6mYLZv7+WB/vQ8WYZkO/RHaMZ5166dbEhWGRw+2W7t
nerAGCz22aTIVHdaSBp5ZFUrQA0mFfDs0KwkdhJR3QWe1jvf6P7bY77EBBsLaP5k
unsj7YSJe2VaDtdRJ/TzC+rFf2Hr1QViguh8Rgnci8GoP9nuj1xRd92f3CWy8mEy
s8w4fyMrRrlUPeoZRhkLxXOAK0UONDOTIT8n8HSNTNHPOipsE/yIExXudltyZRd6
/iwjksBJwWo/cSpCK35Kbim2iOgqsDJiB5bakhrQtoUevyRalcySrx4ZY2D9PvKt
Oj+h+M67ThdzVcx2irks2z8DiOU3aWExTgNnakkbNHjCSWj2xWw=
=Xin6
-----END PGP SIGNATURE-----

--u8GkZxC+9/sjoLN4--
