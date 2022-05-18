Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6052252B21D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiERGHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiERGHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:07:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EBF638B;
        Tue, 17 May 2022 23:07:41 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24I6785D076515;
        Wed, 18 May 2022 01:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652854028;
        bh=1WvPsAXVU3I6iEL/xPevGeWMt1iF1upV77sTqtkqg3M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=PBlRtz944rabxC7wXOMP+75qAwspwKCxkKtEw4wH1/5Lr89in7qR4Vqme76ONJSal
         CsxKP6r3DxXeYwP48fn93OLJxjE3EtpTENRGAw6E0HDWY+/RMnbZ/7zulkZfDpM3jY
         LwUaQS+sd7x6wHzctCtanYqmQqBtxMouSuAUyPXo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24I6772H124779
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 May 2022 01:07:07 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 18
 May 2022 01:07:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 18 May 2022 01:07:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24I675ou003134;
        Wed, 18 May 2022 01:07:06 -0500
Date:   Wed, 18 May 2022 11:37:05 +0530
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
Message-ID: <20220518060640.os5fp5rez4ie7qc4@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-4-p.yadav@ti.com>
 <20220517160226.4107f282@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517160226.4107f282@xps-13>
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

+Cedric

On 17/05/22 04:02PM, Miquel Raynal wrote:
> Hi Pratyush,
> 
> p.yadav@ti.com wrote on Fri, 12 Mar 2021 00:42:13 +0530:
> 
> > Once the flash is initialized tell the controller it can run
> > calibration procedures if needed. This can be useful when calibration is
> > needed to run at higher clock speeds.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 88888df009f0..e0cbcaf1be89 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3650,6 +3650,7 @@ static int spi_nor_probe(struct spi_mem *spimem)
> >  	 * checking what's really supported using spi_mem_supports_op().
> >  	 */
> >  	const struct spi_nor_hwcaps hwcaps = { .mask = SNOR_HWCAPS_ALL };
> > +	struct spi_mem_op op;
> >  	char *flash_name;
> >  	int ret;
> >  
> > @@ -3709,8 +3710,15 @@ static int spi_nor_probe(struct spi_mem *spimem)
> >  	if (ret)
> >  		return ret;
> >  
> > -	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
> > -				   data ? data->nr_parts : 0);
> > +	ret = mtd_device_register(&nor->mtd, data ? data->parts : NULL,
> > +				  data ? data->nr_parts : 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	op = spi_nor_spimem_get_read_op(nor);
> 
> Isn't this too specific? I really don't know much about spi-nors, but I
> find odd to have this op being created here, why not moving this into
> the _do_calibration() helper?

Maybe the naming confused you but this is a function in the SPI NOR 
core, not in SPI MEM. SPI NOR supports both SPI MEM based controllers 
and "legacy" controllers, so the convention is to add the "spimem" 
prefix before SPI MEM specific functions. So I don't get the comment 
about it being too specific. It is too specific to what?

And how can spi_mem_do_calibration() know what op the flash uses to read 
data? SPI NOR or SPI NAND would know it, but not SPI MEM. That is why we 
pass in that information to spi_mem_do_calibration().

> 
> > +	spi_mem_do_calibration(nor->spimem, &op);
> 
> A warning/info upon calibration error (not on the absence of the hook)
> would be nice?

Yes, agreed.

> 
> > +
> > +	return 0;
> >  }
> >  
> >  static int spi_nor_remove(struct spi_mem *spimem)
> 
> Otherwise I like the overall idea.

Thanks for reviewing.

> 
> Thanks,
> Miquèl

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
