Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1486A53D68A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiFDL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 07:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiFDL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 07:28:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C712431DD3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 04:28:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k19so13403913wrd.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 04:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-transfer-encoding;
        bh=3uG8xyMjnXx7c6ijyi/jcLDfsclMzUeircX6QJbta/8=;
        b=m3q/TDCe4KEr/Dcx3rCB6H/JPC/jABlp0co9FPBCnoTd9ukVp13ue0JJ0Z+1LWKRr2
         qQd09wlQu34iE3GlCFFAbl1Cm2OnrMKV5m8jLe7q5sMOvd2Z8nQ7HSeKFzcwvOm3jRZI
         hSyLvBDNrE3JWff4zTjo1uY1yCoqZsoza3c+PT5MdbenHjOewpKEb8uL6hfnZAC1O9m3
         YqEybPrN+wUUN/KBL5O7X/MPJa+oKtjxz5eF1AL8DSXWgTTt7RnDbQ+GEHTq3IpmhmZ4
         hQETfZDyIeCHnJcrOGReO5nDwc7zTQp/ELb4T6s7xxz5zHo6I0J2vNKBnlWGvXCvnSk0
         GitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3uG8xyMjnXx7c6ijyi/jcLDfsclMzUeircX6QJbta/8=;
        b=ErXIRD2Ude5WvJ+24D/LyJFyk0rcT3NOrPYx6l0nUNtdOa0XwjRYbjxP1njdlSw/qY
         Worv8jNOduV4A17AQUpwPqIi0bRB9BsLHJzbQ0c60z6XyWcxY4mmFKgrFfTdp9SLHISn
         duXs6LFTPxSNeYEgAKcQSHoOyucgWU/V3Kky2wxidBICEnbnP6OKgvJamf31ZGPaoa3T
         fIKgdvpC20pgyCcUt005euJ4oTPFawk5A27UhBaanECupKrdMuqg6GeNpCRadi0bWzRZ
         jdhvOmS3PLuoQGVxQswEfOPiJugQVbudwoopXkvefDaBWWjLNadm3nN8wG1YxLYSjdMp
         o32w==
X-Gm-Message-State: AOAM531l16HWmGspbiiQPJ9qj0+W90hoV4OzPKfVTqtGxq6VPpg67K7V
        lbarxVHzj+2431COE4xIwmdMGPh3E21UZg==
X-Google-Smtp-Source: ABdhPJxTtXBhVP7HJ0sDgN5YLAKTZXPZIcQ8MoPwQcPB5Rx9H6+6Jrh/oxVu0meN56FeDIQaYYN0UA==
X-Received: by 2002:adf:fb0d:0:b0:20d:97e:17ce with SMTP id c13-20020adffb0d000000b0020d097e17cemr12586543wrr.585.1654342118252;
        Sat, 04 Jun 2022 04:28:38 -0700 (PDT)
Received: from localhost (92.40.202.89.threembb.co.uk. [92.40.202.89])
        by smtp.gmail.com with ESMTPSA id x14-20020adff0ce000000b00210396b2eaesm12229149wro.45.2022.06.04.04.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 04:28:37 -0700 (PDT)
References: <20220603135149.11570-1-aidanmacdonald.0x0@gmail.com>
 <20220603155600.3eab9890@xps-13>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: Add support for ATO25D1GA
Date:   Sat, 04 Jun 2022 12:26:57 +0100
In-reply-to: <20220603155600.3eab9890@xps-13>
Message-ID: <KsriIipAd1t8rfznYrBvTQbGe3yoRXOX@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miquel Raynal <miquel.raynal@bootlin.com> writes:

> Hi Aidan,
>
> aidanmacdonald.0x0@gmail.com wrote on Fri,  3 Jun 2022 14:51:49 +0100:
>
>> Add support for the ATO25D1GA SPI NAND flash.
>>=20
>> Datasheet:
>> - https://atta.szlcsc.com/upload/public/pdf/source/20191212/C469320_0459=
9D67B03B078044EB65FF5AEDDDE9.pdf
>>=20
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  drivers/mtd/nand/spi/Makefile |  2 +-
>>  drivers/mtd/nand/spi/ato.c    | 86 +++++++++++++++++++++++++++++++++++
>>  drivers/mtd/nand/spi/core.c   |  1 +
>>  include/linux/mtd/spinand.h   |  1 +
>>  4 files changed, 89 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/mtd/nand/spi/ato.c
>>=20
>> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefi=
le
>> index 80dabe6ff0f3..ae17c13d1abe 100644
>> --- a/drivers/mtd/nand/spi/Makefile
>> +++ b/drivers/mtd/nand/spi/Makefile
>> @@ -1,3 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -spinand-objs :=3D core.o gigadevice.o macronix.o micron.o paragon.o tos=
hiba.o winbond.o xtx.o
>> +spinand-objs :=3D ato.o core.o gigadevice.o macronix.o micron.o paragon=
.o toshiba.o winbond.o xtx.o
>
> I would keep core.o first in that list, even if it breaks alphabetical
> ordering slightly :)
>
> Otherwise the patch looks good to me.
>

Okay, I'll send a v2 to fix that.

>>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
>> diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
>> new file mode 100644
>> index 000000000000..82b377c06812
>> --- /dev/null
>> +++ b/drivers/mtd/nand/spi/ato.c
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2022 Aidan MacDonald
>> + *
>> + * Author: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mtd/spinand.h>
>> +
>> +
>> +#define SPINAND_MFR_ATO		0x9b
>> +
>> +
>> +static SPINAND_OP_VARIANTS(read_cache_variants,
>> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
>> +
>> +static SPINAND_OP_VARIANTS(write_cache_variants,
>> +		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
>> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
>> +
>> +static SPINAND_OP_VARIANTS(update_cache_variants,
>> +		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>> +
>> +
>> +static int ato25d1ga_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +				   struct mtd_oob_region *region)
>> +{
>> +	if (section > 3)
>> +		return -ERANGE;
>> +
>> +	region->offset =3D (16 * section) + 8;
>> +	region->length =3D 8;
>> +	return 0;
>> +}
>> +
>> +static int ato25d1ga_ooblayout_free(struct mtd_info *mtd, int section,
>> +				   struct mtd_oob_region *region)
>> +{
>> +	if (section > 3)
>> +		return -ERANGE;
>> +
>> +	if (section) {
>> +		region->offset =3D (16 * section);
>> +		region->length =3D 8;
>> +	} else {
>> +		/* first byte of section 0 is reserved for the BBM */
>> +		region->offset =3D 1;
>> +		region->length =3D 7;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mtd_ooblayout_ops ato25d1ga_ooblayout =3D {
>> +	.ecc =3D ato25d1ga_ooblayout_ecc,
>> +	.free =3D ato25d1ga_ooblayout_free,
>> +};
>> +
>> +
>> +static const struct spinand_info ato_spinand_table[] =3D {
>> +	SPINAND_INFO("ATO25D1GA",
>> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x12),
>> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>> +		     NAND_ECCREQ(1, 512),
>> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +					      &write_cache_variants,
>> +					      &update_cache_variants),
>> +		     SPINAND_HAS_QE_BIT,
>> +		     SPINAND_ECCINFO(&ato25d1ga_ooblayout, NULL)),
>> +};
>> +
>> +static const struct spinand_manufacturer_ops ato_spinand_manuf_ops =3D {
>> +};
>> +
>> +const struct spinand_manufacturer ato_spinand_manufacturer =3D {
>> +	.id =3D SPINAND_MFR_ATO,
>> +	.name =3D "ATO",
>> +	.chips =3D ato_spinand_table,
>> +	.nchips =3D ARRAY_SIZE(ato_spinand_table),
>> +	.ops =3D &ato_spinand_manuf_ops,
>> +};
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index d5b685d1605e..9d73910a7ae8 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -927,6 +927,7 @@ static const struct nand_ops spinand_ops =3D {
>>  };
>>=20=20
>>  static const struct spinand_manufacturer *spinand_manufacturers[] =3D {
>> +	&ato_spinand_manufacturer,
>>  	&gigadevice_spinand_manufacturer,
>>  	&macronix_spinand_manufacturer,
>>  	&micron_spinand_manufacturer,
>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>> index 5584d3bb6556..6d3392a7edc6 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -260,6 +260,7 @@ struct spinand_manufacturer {
>>  };
>>=20=20
>>  /* SPI NAND manufacturers */
>> +extern const struct spinand_manufacturer ato_spinand_manufacturer;
>>  extern const struct spinand_manufacturer gigadevice_spinand_manufacture=
r;
>>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
>
>
> Thanks,
> Miqu=C3=A8l

Regards,
Aidan
