Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE79152B35B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiERHTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiERHTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:19:43 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4F8E1B6;
        Wed, 18 May 2022 00:19:39 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6451EE0012;
        Wed, 18 May 2022 07:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652858378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrV4EE5DZngLdpWzfnsjRVj4sFbo3FeybVGcaLDnamw=;
        b=R51haHGNtqEyGZqQurIqU9U9tAyVLT/rwEMi6j7UDk1/sBtUAfRQNH3lwwR2L9YzdlqNgj
        rrk/kaGh2pGDOdR5WxTF4B5HO3zQmTIS9Z4Ht8fgGIz3jQVplHxryyvYEa1d8HDRXTq4tR
        7lwdKxzWExAr4HDakWNHP2K7+cCSvriuKrPX1PGpwEFf5lzKEUB5yZNxiSskFPcNAshi/t
        OflFVWulaf+lZ2SAMm4IsRfwLcBmXb9oKkHFogwQ8PRxoR1z2H6GmaVOZlEPjUdopONeCH
        lG8o8WmCGPWhjlsF5xL4jPrLYH/NMz8U79+TUzDcS1tqrCoUVPkaASIv+hjYzw==
Date:   Wed, 18 May 2022 09:19:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [RFC PATCH 3/6] mtd: spi-nor: core: run calibration when
 initialization is done
Message-ID: <20220518091931.279c5398@xps-13>
In-Reply-To: <20220518060640.os5fp5rez4ie7qc4@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
        <20210311191216.7363-4-p.yadav@ti.com>
        <20220517160226.4107f282@xps-13>
        <20220518060640.os5fp5rez4ie7qc4@ti.com>
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

Hi Pratyush,

p.yadav@ti.com wrote on Wed, 18 May 2022 11:37:05 +0530:

> +Cedric
>=20
> On 17/05/22 04:02PM, Miquel Raynal wrote:
> > Hi Pratyush,
> >=20
> > p.yadav@ti.com wrote on Fri, 12 Mar 2021 00:42:13 +0530:
> >  =20
> > > Once the flash is initialized tell the controller it can run
> > > calibration procedures if needed. This can be useful when calibration=
 is
> > > needed to run at higher clock speeds.
> > >=20
> > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > ---
> > >  drivers/mtd/spi-nor/core.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > > index 88888df009f0..e0cbcaf1be89 100644
> > > --- a/drivers/mtd/spi-nor/core.c
> > > +++ b/drivers/mtd/spi-nor/core.c
> > > @@ -3650,6 +3650,7 @@ static int spi_nor_probe(struct spi_mem *spimem)
> > >  	 * checking what's really supported using spi_mem_supports_op().
> > >  	 */
> > >  	const struct spi_nor_hwcaps hwcaps =3D { .mask =3D SNOR_HWCAPS_ALL =
};
> > > +	struct spi_mem_op op;
> > >  	char *flash_name;
> > >  	int ret;
> > > =20
> > > @@ -3709,8 +3710,15 @@ static int spi_nor_probe(struct spi_mem *spime=
m)
> > >  	if (ret)
> > >  		return ret;
> > > =20
> > > -	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
> > > -				   data ? data->nr_parts : 0);
> > > +	ret =3D mtd_device_register(&nor->mtd, data ? data->parts : NULL,
> > > +				  data ? data->nr_parts : 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	op =3D spi_nor_spimem_get_read_op(nor); =20
> >=20
> > Isn't this too specific? I really don't know much about spi-nors, but I
> > find odd to have this op being created here, why not moving this into
> > the _do_calibration() helper? =20
>=20
> Maybe the naming confused you but this is a function in the SPI NOR=20
> core, not in SPI MEM. SPI NOR supports both SPI MEM based controllers=20
> and "legacy" controllers, so the convention is to add the "spimem"=20
> prefix before SPI MEM specific functions. So I don't get the comment=20
> about it being too specific. It is too specific to what?

Mmh right, it's fine then.

>=20
> And how can spi_mem_do_calibration() know what op the flash uses to read=
=20
> data? SPI NOR or SPI NAND would know it, but not SPI MEM. That is why we=
=20
> pass in that information to spi_mem_do_calibration().

But here the op is "spi-nor wide", I would have expected a
per-device op. But that is not a big deal, that is something that can
also be updated later if needed I guess.

One last question, is there something that mtd_device_register() does
that is really needed for the calibration to work? Otherwise I would
rather prefer to have that calibration happening before the user gets
access to the device.

>=20
> >  =20
> > > +	spi_mem_do_calibration(nor->spimem, &op); =20
> >=20
> > A warning/info upon calibration error (not on the absence of the hook)
> > would be nice? =20
>=20
> Yes, agreed.
>=20
> >  =20
> > > +
> > > +	return 0;
> > >  }
> > > =20
> > >  static int spi_nor_remove(struct spi_mem *spimem) =20
> >=20
> > Otherwise I like the overall idea. =20
>=20
> Thanks for reviewing.
>=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20


Thanks,
Miqu=C3=A8l
