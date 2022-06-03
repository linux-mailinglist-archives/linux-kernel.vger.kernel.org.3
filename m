Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8053CAF7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244874AbiFCN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244863AbiFCN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:56:09 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B4E393F4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:56:05 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DA49F1BF206;
        Fri,  3 Jun 2022 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654264563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiwH0hvs5Ie9tHnRP/S+sMx19tdadmBe9hY2JmXi0ps=;
        b=FHNYJVXCx0BN1YP0CK/i+WpkuldlwrKR/7EWovJl9ozjABZFP/sTPa6bpvD941ducnu3t4
        8uIBKbQpadb4MaZ7Orb5gwAVjjrLid0sVbYY0ysZfklPz93EhhGfnXGH8q1YU6z0gKn6Pw
        3fHM0vlSshRLYIkuPLH3rD8p/B93+UffQCtvt5DXjWtWTPodsWx+7//t5uy+uYsWqBotoA
        MPFA3TYHzIwo0Qof8GPTwnNdo+i37jQKfisy6lDc/lnnTGozWSUlH6pN4OOQBFj3MF5bDT
        6quGniNFT5+uGb4/1jio1iSLzLfJbkkFCoFU9LSqB49Az30CUxZuwiR/s+kxCQ==
Date:   Fri, 3 Jun 2022 15:56:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: Add support for ATO25D1GA
Message-ID: <20220603155600.3eab9890@xps-13>
In-Reply-To: <20220603135149.11570-1-aidanmacdonald.0x0@gmail.com>
References: <20220603135149.11570-1-aidanmacdonald.0x0@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

aidanmacdonald.0x0@gmail.com wrote on Fri,  3 Jun 2022 14:51:49 +0100:

> Add support for the ATO25D1GA SPI NAND flash.
>=20
> Datasheet:
> - https://atta.szlcsc.com/upload/public/pdf/source/20191212/C469320_04599=
D67B03B078044EB65FF5AEDDDE9.pdf
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mtd/nand/spi/Makefile |  2 +-
>  drivers/mtd/nand/spi/ato.c    | 86 +++++++++++++++++++++++++++++++++++
>  drivers/mtd/nand/spi/core.c   |  1 +
>  include/linux/mtd/spinand.h   |  1 +
>  4 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/ato.c
>=20
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 80dabe6ff0f3..ae17c13d1abe 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs :=3D core.o gigadevice.o macronix.o micron.o paragon.o tosh=
iba.o winbond.o xtx.o
> +spinand-objs :=3D ato.o core.o gigadevice.o macronix.o micron.o paragon.=
o toshiba.o winbond.o xtx.o

I would keep core.o first in that list, even if it breaks alphabetical
ordering slightly :)

Otherwise the patch looks good to me.

>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
> new file mode 100644
> index 000000000000..82b377c06812
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/ato.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Aidan MacDonald
> + *
> + * Author: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +
> +#define SPINAND_MFR_ATO		0x9b
> +
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +
> +static int ato25d1ga_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	region->offset =3D (16 * section) + 8;
> +	region->length =3D 8;
> +	return 0;
> +}
> +
> +static int ato25d1ga_ooblayout_free(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	if (section) {
> +		region->offset =3D (16 * section);
> +		region->length =3D 8;
> +	} else {
> +		/* first byte of section 0 is reserved for the BBM */
> +		region->offset =3D 1;
> +		region->length =3D 7;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops ato25d1ga_ooblayout =3D {
> +	.ecc =3D ato25d1ga_ooblayout_ecc,
> +	.free =3D ato25d1ga_ooblayout_free,
> +};
> +
> +
> +static const struct spinand_info ato_spinand_table[] =3D {
> +	SPINAND_INFO("ATO25D1GA",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x12),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&ato25d1ga_ooblayout, NULL)),
> +};
> +
> +static const struct spinand_manufacturer_ops ato_spinand_manuf_ops =3D {
> +};
> +
> +const struct spinand_manufacturer ato_spinand_manufacturer =3D {
> +	.id =3D SPINAND_MFR_ATO,
> +	.name =3D "ATO",
> +	.chips =3D ato_spinand_table,
> +	.nchips =3D ARRAY_SIZE(ato_spinand_table),
> +	.ops =3D &ato_spinand_manuf_ops,
> +};
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index d5b685d1605e..9d73910a7ae8 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -927,6 +927,7 @@ static const struct nand_ops spinand_ops =3D {
>  };
> =20
>  static const struct spinand_manufacturer *spinand_manufacturers[] =3D {
> +	&ato_spinand_manufacturer,
>  	&gigadevice_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 5584d3bb6556..6d3392a7edc6 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -260,6 +260,7 @@ struct spinand_manufacturer {
>  };
> =20
>  /* SPI NAND manufacturers */
> +extern const struct spinand_manufacturer ato_spinand_manufacturer;
>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;


Thanks,
Miqu=C3=A8l
