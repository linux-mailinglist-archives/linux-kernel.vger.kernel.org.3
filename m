Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A388D4FF745
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiDMNBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiDMNBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:01:12 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064AC5B3D3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:58:47 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 79759200012;
        Wed, 13 Apr 2022 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649854726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lt5mlGJZcuBVHxRss/04dHWoVmPgHYi8/JWSHvb6Dk=;
        b=Px+SIUNwXGbqpReLs2RRDVD+hDL8TDHEUwFW5MVebHhxM4E5YWiVny3r5i81UC3drFpHmX
        E07RVeqIKlSfYAABvYULm/UftBS1eaVN6Slwg8G8HDnarnpiBp2y8f3I8yJM1ByfVo2Dw5
        eo4HIQB1iIeH7Qds3q0jVTCPjXy9TPoxOHxf5y5dd4MMvtDIjZ/FrTal95izOwP4lnMJ2u
        jXPBv0yDW+KReaDFOSUlFmoRnnJOSsW92/WxheuyGc8nFDRJwPZqTjDtFmCIlDNnzYBjro
        Df10JWWGIWKqLNhUFdVS9U0oaRWZAhBBB8bReMNjZLUSF/XuNsG4Nt2VM1vH8A==
Date:   Wed, 13 Apr 2022 14:58:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] mtd: spinand: add support for ESMT F50x1G41LB
Message-ID: <20220413145843.46a3d9b5@xps13>
In-Reply-To: <20220413083824.247136-1-gch981213@gmail.com>
References: <20220413083824.247136-1-gch981213@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

gch981213@gmail.com wrote on Wed, 13 Apr 2022 16:38:19 +0800:

> This patch adds support for ESMT F50L1G41LB and F50D1G41LB.
> It seems that ESMT likes to use random JEDEC ID from other vendors.
> Their 1G chips uses 0xc8 from GigaDevice and 2G/4G chips uses 0x2c from
> Micron. For this reason, the ESMT entry is named esmt_c8 with explicit
> JEDEC ID in variable name.
>=20
> Datasheets:
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50L1G41LB(2M).pdf
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50D1G41LB(2M).pdf
>=20
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> This patch is made purely based on datasheet info without testing
> on any actual chips.

Do you plan to get one of these any time soon?

I am not really confident merging a 100% non-tested driver :)

> Change since v1: drop 0x7f padding from SPINAND_ID.
>=20
>  drivers/mtd/nand/spi/Makefile |  2 +-
>  drivers/mtd/nand/spi/core.c   |  1 +
>  drivers/mtd/nand/spi/esmt.c   | 94 +++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |  1 +
>  4 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/esmt.c
>=20
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 9662b9c1d5a9..7e3ab8a9aec7 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs :=3D core.o gigadevice.o macronix.o micron.o paragon.o tosh=
iba.o winbond.o
> +spinand-objs :=3D core.o esmt.o gigadevice.o macronix.o micron.o paragon=
.o toshiba.o winbond.o
>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index ff8336870bc0..6c5d79ec3501 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -927,6 +927,7 @@ static const struct nand_ops spinand_ops =3D {
>  };
> =20
>  static const struct spinand_manufacturer *spinand_manufacturers[] =3D {
> +	&esmt_c8_spinand_manufacturer,
>  	&gigadevice_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
> new file mode 100644
> index 000000000000..f86716332893
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/esmt.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author:
> + *	Chuanhong Guo <gch981213@gmail.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +/* ESMT uses GigaDevice 0xc8 JECDEC ID on some SPI NANDs */
> +#define SPINAND_MFR_ESMT_C8			0xc8

What happens if the gigadevice driver probes first?

> +
> +#define F50L2G41XA_ECC_STATUS_MASK		GENMASK(6, 4)
> +#define F50L2G41XA_STATUS_ECC_1_3_BITFLIPS	(1 << 4)
> +#define F50L2G41XA_STATUS_ECC_4_6_BITFLIPS	(3 << 4)
> +#define F50L2G41XA_STATUS_ECC_7_8_BITFLIPS	(5 << 4)
> +


Thanks,
Miqu=C3=A8l
