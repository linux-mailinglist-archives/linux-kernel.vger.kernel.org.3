Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD34B75EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbiBOTZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:25:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbiBOTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:25:41 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43A789CE4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:25:28 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FJPLrU003705;
        Tue, 15 Feb 2022 13:25:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644953121;
        bh=1NuIuit/4zuRZb3BIfE4uUvyfzH1uAzthPeCBGr5OYA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=nJe4JaG/wuollj5gn70+8qsJ80HDumGvNIACssSnBV/YeKLxBZArVN64E8C7H8HuE
         o44Yepq/23H2Etik70Yxri7xs96beyST/lvj/tccrJJDtH8YDhkxg2yXOm0lRrNyF/
         LFjXWwnjN+h7kgS5lZB1I7TEJxKzw2YxwfCvRkxk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FJPLKJ113261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 13:25:21 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 13:25:20 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 13:25:20 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FJPJC3112735;
        Tue, 15 Feb 2022 13:25:20 -0600
Date:   Wed, 16 Feb 2022 00:55:19 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH v1 13/14] mtd: spi-nor: spansion: convert USE_CLSR to a
 manufacturer flag
Message-ID: <20220215192519.xff2wx33aee75fsl@ti.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-14-michael@walle.cc>
 <b02814f4-bfad-6b80-e849-1bb57b74702d@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b02814f4-bfad-6b80-e849-1bb57b74702d@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/22 03:34AM, Tudor.Ambarus@microchip.com wrote:
> On 2/2/22 16:58, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Now that all functions using that flag are local to the spanion module,

s/spanion/spansion/

> > we can convert the flag to a manufacturer one.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> >  drivers/mtd/spi-nor/core.c     |  3 --
> >  drivers/mtd/spi-nor/core.h     |  3 --
> >  drivers/mtd/spi-nor/spansion.c | 54 +++++++++++++++++++++-------------
> >  3 files changed, 33 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 5b00dfab77a6..2d5517b3db96 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2448,9 +2448,6 @@ static void spi_nor_init_flags(struct spi_nor *nor)
> > 
> >         if (flags & NO_CHIP_ERASE)
> >                 nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
> > -
> > -       if (flags & USE_CLSR)
> > -               nor->flags |= SNOR_F_USE_CLSR;
> >  }
> > 
> >  /**
> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index a02bf54289fb..2130a96e2044 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -14,7 +14,6 @@
> >  enum spi_nor_option_flags {
> >         SNOR_F_HAS_SR_TB        = BIT(1),
> >         SNOR_F_NO_OP_CHIP_ERASE = BIT(2),
> > -       SNOR_F_USE_CLSR         = BIT(4),
> >         SNOR_F_BROKEN_RESET     = BIT(5),
> >         SNOR_F_4B_OPCODES       = BIT(6),
> >         SNOR_F_HAS_4BAIT        = BIT(7),
> > @@ -347,7 +346,6 @@ struct spi_nor_fixups {
> >   *   SPI_NOR_NO_ERASE:        no erase command needed.
> >   *   NO_CHIP_ERASE:           chip does not support chip erase.
> >   *   SPI_NOR_NO_FR:           can't do fastread.
> > - *   USE_CLSR:                use CLSR command.
> >   *
> >   * @no_sfdp_flags:  flags that indicate support that can be discovered via SFDP.
> >   *                  Used when SFDP tables are not defined in the flash. These
> > @@ -398,7 +396,6 @@ struct flash_info {
> >  #define SPI_NOR_NO_ERASE               BIT(6)
> >  #define NO_CHIP_ERASE                  BIT(7)
> >  #define SPI_NOR_NO_FR                  BIT(8)
> > -#define USE_CLSR                       BIT(9)
> > 
> >         u8 no_sfdp_flags;
> >  #define SPI_NOR_SKIP_SFDP              BIT(0)
> > diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> > index 4756fb88eab2..c31ea11f71f2 100644
> > --- a/drivers/mtd/spi-nor/spansion.c
> > +++ b/drivers/mtd/spi-nor/spansion.c
> > @@ -8,6 +8,8 @@
> > 
> >  #include "core.h"
> > 
> > +#define USE_CLSR       BIT(0)
> 
> add a description, tell the reader this is a manufacturer specific flag.

+1

> excellent work:

+1

> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> 
> > +
> >  #define SPINOR_OP_CLSR         0x30    /* Clear status register 1 */
> >  #define SPINOR_OP_RD_ANY_REG                   0x65    /* Read any register */
> >  #define SPINOR_OP_WR_ANY_REG                   0x71    /* Write any register */
> > @@ -212,43 +214,53 @@ static const struct flash_info spansion_parts[] = {
> >         { "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128)
> >                 NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >         { "s25fl128s0", INFO6(0x012018, 0x4d0080, 256 * 1024, 64)
> > -               FLAGS(USE_CLSR)
> > -               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> > +       },
> >         { "s25fl128s1", INFO6(0x012018, 0x4d0180, 64 * 1024, 256)
> > -               FLAGS(USE_CLSR)
> > -               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> > +       },
> >         { "s25fl256s0", INFO6(0x010219, 0x4d0080, 256 * 1024, 128)
> > -               FLAGS(USE_CLSR)
> >                 NO_SFDP_FLAGS(SPI_NOR_SKIP_SFDP | SPI_NOR_DUAL_READ |
> > -                             SPI_NOR_QUAD_READ) },
> > +                             SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> > +       },
> >         { "s25fl256s1", INFO6(0x010219, 0x4d0180, 64 * 1024, 512)
> > -               FLAGS(USE_CLSR)
> > -               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> > +       },
> >         { "s25fl512s",  INFO6(0x010220, 0x4d0080, 256 * 1024, 256)
> > -               FLAGS(SPI_NOR_HAS_LOCK | USE_CLSR)
> > -               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +               FLAGS(SPI_NOR_HAS_LOCK)
> > +               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> > +       },
> >         { "s25fs128s1", INFO6(0x012018, 0x4d0181, 64 * 1024, 256)
> > -               FLAGS(USE_CLSR)
> >                 NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> >                 .fixups = &s25fs_s_fixups, },
> >         { "s25fs256s0", INFO6(0x010219, 0x4d0081, 256 * 1024, 128)
> > -               FLAGS(USE_CLSR)
> > -               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> > +       },
> >         { "s25fs256s1", INFO6(0x010219, 0x4d0181, 64 * 1024, 512)
> > -               FLAGS(USE_CLSR)
> > -               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> > +       },
> >         { "s25fs512s",  INFO6(0x010220, 0x4d0081, 256 * 1024, 256)
> > -               FLAGS(USE_CLSR)
> >                 NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> >                 .fixups = &s25fs_s_fixups, },
> >         { "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64) },
> >         { "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256) },
> >         { "s25fl129p0", INFO(0x012018, 0x4d00, 256 * 1024,  64)
> > -               FLAGS(USE_CLSR)
> > -               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> > +       },
> >         { "s25fl129p1", INFO(0x012018, 0x4d01,  64 * 1024, 256)
> > -               FLAGS(USE_CLSR)
> > -               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +               NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               MFR_FLAGS(USE_CLSR)
> > +       },
> >         { "s25sl004a",  INFO(0x010212,      0,  64 * 1024,   8) },
> >         { "s25sl008a",  INFO(0x010213,      0,  64 * 1024,  16) },
> >         { "s25sl016a",  INFO(0x010214,      0,  64 * 1024,  32) },
> > @@ -370,7 +382,7 @@ static void spansion_late_init(struct spi_nor *nor)
> >                 nor->mtd.erasesize = nor->info->sector_size;
> >         }
> > 
> > -       if (nor->flags & SNOR_F_USE_CLSR)
> > +       if (nor->info->mfr_flags & USE_CLSR)
> >                 nor->params->ready = spi_nor_sr_ready_and_clear;
> >  }
> > 
> > --
> > 2.30.2
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
