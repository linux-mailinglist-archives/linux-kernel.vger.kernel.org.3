Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6679852B43C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiERH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiERH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:57:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92DBE64DB;
        Wed, 18 May 2022 00:57:16 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24I7urPV024570;
        Wed, 18 May 2022 02:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652860613;
        bh=P4F7f/HFsSYJM14QiiyJ/DYiatoS1hZl6AKwPrhOcoc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Q7f2wKZ5U0/Xc6zelmerAA6VpUUqLbj76051mZjFB2TT3LcpYikXiGvDEdUZ7BRRD
         lbEGeaWr0KOTwQ3nsrHlGWziA7EgBLTIx1V07RZUjqKuGXK0Iwun2ehqI496imAjrB
         gUIJQVdfBH/QtjxcK2EWSBek7kN3UQBu9StDXTI8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24I7urAZ109191
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 May 2022 02:56:53 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 18
 May 2022 02:56:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 18 May 2022 02:56:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24I7uq2S005572;
        Wed, 18 May 2022 02:56:52 -0500
Date:   Wed, 18 May 2022 13:26:51 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [RFC PATCH 3/6] mtd: spi-nor: core: run calibration when
 initialization is done
Message-ID: <20220518075651.mvdhfnfbgutecgyq@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-4-p.yadav@ti.com>
 <20220517160226.4107f282@xps-13>
 <20220518060640.os5fp5rez4ie7qc4@ti.com>
 <20220518091931.279c5398@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220518091931.279c5398@xps-13>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/22 09:19AM, Miquel Raynal wrote:
> Hi Pratyush,
> 
> p.yadav@ti.com wrote on Wed, 18 May 2022 11:37:05 +0530:
> 
> > +Cedric
> > 
> > On 17/05/22 04:02PM, Miquel Raynal wrote:
> > > Hi Pratyush,
> > > 
> > > p.yadav@ti.com wrote on Fri, 12 Mar 2021 00:42:13 +0530:
> > >   
> > > > Once the flash is initialized tell the controller it can run
> > > > calibration procedures if needed. This can be useful when calibration is
> > > > needed to run at higher clock speeds.
> > > > 
> > > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > > ---
> > > >  drivers/mtd/spi-nor/core.c | 12 ++++++++++--
> > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > > > index 88888df009f0..e0cbcaf1be89 100644
> > > > --- a/drivers/mtd/spi-nor/core.c
> > > > +++ b/drivers/mtd/spi-nor/core.c
> > > > @@ -3650,6 +3650,7 @@ static int spi_nor_probe(struct spi_mem *spimem)
> > > >  	 * checking what's really supported using spi_mem_supports_op().
> > > >  	 */
> > > >  	const struct spi_nor_hwcaps hwcaps = { .mask = SNOR_HWCAPS_ALL };
> > > > +	struct spi_mem_op op;
> > > >  	char *flash_name;
> > > >  	int ret;
> > > >  
> > > > @@ -3709,8 +3710,15 @@ static int spi_nor_probe(struct spi_mem *spimem)
> > > >  	if (ret)
> > > >  		return ret;
> > > >  
> > > > -	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
> > > > -				   data ? data->nr_parts : 0);
> > > > +	ret = mtd_device_register(&nor->mtd, data ? data->parts : NULL,
> > > > +				  data ? data->nr_parts : 0);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	op = spi_nor_spimem_get_read_op(nor);  
> > > 
> > > Isn't this too specific? I really don't know much about spi-nors, but I
> > > find odd to have this op being created here, why not moving this into
> > > the _do_calibration() helper?  
> > 
> > Maybe the naming confused you but this is a function in the SPI NOR 
> > core, not in SPI MEM. SPI NOR supports both SPI MEM based controllers 
> > and "legacy" controllers, so the convention is to add the "spimem" 
> > prefix before SPI MEM specific functions. So I don't get the comment 
> > about it being too specific. It is too specific to what?
> 
> Mmh right, it's fine then.
> 
> > 
> > And how can spi_mem_do_calibration() know what op the flash uses to read 
> > data? SPI NOR or SPI NAND would know it, but not SPI MEM. That is why we 
> > pass in that information to spi_mem_do_calibration().
> 
> But here the op is "spi-nor wide", I would have expected a
> per-device op. But that is not a big deal, that is something that can
> also be updated later if needed I guess.

It is per-device. The op is generated using nor->read_opcode, 
nor->addr_width, nor->read_dummy, etc. So if you have 2 NOR flashes on 
your system with different opcodes, it would work for both.

> 
> One last question, is there something that mtd_device_register() does
> that is really needed for the calibration to work? Otherwise I would
> rather prefer to have that calibration happening before the user gets
> access to the device.

The calibration works by reading a known pattern that is already written 
to the flash again and again and seeing what delays work and what don't. 
For that to happen, the controller driver needs to know where the 
pattern is stored. This series does that by looking at the MTD 
partitions. For that to happen, we need to create those partitions 
first, which happens after mtd_device_register().

But I am planning to use device tree to get that information now so this 
should no longer be needed and we can do calibration before registering 
the device with MTD.

> 
> > 
> > >   
> > > > +	spi_mem_do_calibration(nor->spimem, &op);  
> > > 
> > > A warning/info upon calibration error (not on the absence of the hook)
> > > would be nice?  
> > 
> > Yes, agreed.
> > 
> > >   
> > > > +
> > > > +	return 0;
> > > >  }
> > > >  
> > > >  static int spi_nor_remove(struct spi_mem *spimem)  
> > > 
> > > Otherwise I like the overall idea.  
> > 
> > Thanks for reviewing.
> > 
> > > 
> > > Thanks,
> > > Miquèl  
> > 
> 
> 
> Thanks,
> Miquèl

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
