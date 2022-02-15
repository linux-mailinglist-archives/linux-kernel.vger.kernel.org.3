Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ECC4B774A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbiBOShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:37:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiBOShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:37:13 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5105DFB6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:37:02 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FIasTA043555;
        Tue, 15 Feb 2022 12:36:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644950214;
        bh=ggLkBTTh/QZcYMoHa0drQ3r4e8GOr8CoOpONQ+shgLw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gZTGlcnLguKrMjtHXc/nY+/OsusMQMjZUxdmjtyXen9NU9HZFDF0y3E5Hi8dTpljE
         EObwKtPmQZlVJro0BY1Wc3eE+/X/fFrdA+/13fy7NVQ8QKD4yRWF+VNk53dHNzycsa
         8r9Kag1OZeljtXLM9wRgCKjn6164Z7L0mmIYvVyA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FIasXX095019
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 12:36:54 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 12:36:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 12:36:54 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FIarsU026597;
        Tue, 15 Feb 2022 12:36:54 -0600
Date:   Wed, 16 Feb 2022 00:06:53 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH v1 03/14] mtd: spi-nor: allow a flash to define its own
 ready() function
Message-ID: <20220215183653.6dt3hvvdajp2gld3@ti.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-4-michael@walle.cc>
 <399c8ea5-e534-9da4-43c0-199e1b88bfae@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <399c8ea5-e534-9da4-43c0-199e1b88bfae@microchip.com>
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

On 10/02/22 03:05AM, Tudor.Ambarus@microchip.com wrote:
> On 2/2/22 16:58, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Xilinx and Micron flashes have their own implementation of the
> > spi_nor_ready() function. At the moment, the core will figure out
> > which one to call according to some flags. Lay the foundation to
> > make it possible that a flash can register its own ready()
> > function.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> >  drivers/mtd/spi-nor/core.c | 4 ++++
> >  drivers/mtd/spi-nor/core.h | 4 ++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index c8cc906cf771..c181f2680df2 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -794,6 +794,10 @@ static int spi_nor_ready(struct spi_nor *nor)
> >  {
> >         int sr, fsr;
> > 
> > +       /* flashes might override our standard routine */
> 
> let's start comments with capital letter and put a dot at the end of
> the sentence. s/our/the

+1

> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

With that fixed,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> > +       if (nor->params->ready)
> > +               return nor->params->ready(nor);
> > +
> >         if (nor->flags & SNOR_F_READY_XSR_RDY)
> >                 sr = spi_nor_xsr_ready(nor);
> >         else
> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index 10f478547dc2..446218b0e017 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -261,6 +261,9 @@ struct spi_nor_otp {
> >   *                     SPI NOR flashes that have peculiarities to the SPI NOR
> >   *                     standard e.g. different opcodes, specific address
> >   *                     calculation, page size, etc.
> > + * @ready:             (optional) flashes might use a different mechanism
> > + *                     than reading the status register to indicate they
> > + *                     are ready for a new command
> >   * @locking_ops:       SPI NOR locking methods.
> >   */
> >  struct spi_nor_flash_parameter {
> > @@ -282,6 +285,7 @@ struct spi_nor_flash_parameter {
> >         int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
> >         u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
> >         int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
> > +       int (*ready)(struct spi_nor *nor);
> > 
> >         const struct spi_nor_locking_ops *locking_ops;
> >  };
> > --
> > 2.30.2
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
