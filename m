Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A650D4B757A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbiBOTYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:24:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBOTYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:24:05 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACAB85656
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:23:55 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FJNlHZ059882;
        Tue, 15 Feb 2022 13:23:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644953027;
        bh=rr1Zodq/FlvEdUsZUpJ8FeMZ8Ymp8twhy6LQt3KrRRQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=C2fE0fAyYyiJk4eDrOpc0WrARKLjIQqNIxzhAugHyKQPQ8MedUYNYQlTRQ8bMxdH4
         tHyFJfX7WkR333grEmFdNUkvRDS1chycw3Xi/Yhr7T57cexcmjP6bNZ1zVRdQ4JpH3
         rU2S0/TcY/40v+QdaWajZOxo1BMCreUc1HH/nUeg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FJNlLJ008985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 13:23:47 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 13:23:47 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 13:23:47 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FJNkoD109511;
        Tue, 15 Feb 2022 13:23:46 -0600
Date:   Wed, 16 Feb 2022 00:53:45 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH v1 12/14] mtd: spi-nor: move all spansion specifics into
 spansion.c
Message-ID: <20220215192345.3pv4soo3grjsr7op@ti.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-13-michael@walle.cc>
 <ceef013d-a337-0059-6207-b30d2274d5cb@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ceef013d-a337-0059-6207-b30d2274d5cb@microchip.com>
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

On 10/02/22 03:32AM, Tudor.Ambarus@microchip.com wrote:
> On 2/2/22 16:58, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > The clear status register flags is only available on spansion flashes.
> > Move all the functions around that into the spanion module.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> >  drivers/mtd/spi-nor/core.c     | 52 +------------------------
> >  drivers/mtd/spi-nor/spansion.c | 70 ++++++++++++++++++++++++++++++++++
> >  include/linux/mtd/spi-nor.h    |  1 -
> >  3 files changed, 72 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index be65aaa954ca..5b00dfab77a6 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -554,33 +554,6 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
> >         return ret;
> >  }
> > 
> > -/**
> > - * spi_nor_clear_sr() - Clear the Status Register.
> > - * @nor:       pointer to 'struct spi_nor'.
> > - */
> > -static void spi_nor_clear_sr(struct spi_nor *nor)
> > -{
> > -       int ret;
> > -
> > -       if (nor->spimem) {
> > -               struct spi_mem_op op =
> > -                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 0),
> > -                                  SPI_MEM_OP_NO_ADDR,
> > -                                  SPI_MEM_OP_NO_DUMMY,
> > -                                  SPI_MEM_OP_NO_DATA);
> > -
> > -               spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> > -
> > -               ret = spi_mem_exec_op(nor->spimem, &op);
> > -       } else {
> > -               ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLSR,
> > -                                                      NULL, 0);
> > -       }
> > -
> > -       if (ret)
> > -               dev_dbg(nor->dev, "error %d clearing SR\n", ret);
> > -}
> > -
> >  /**
> >   * spi_nor_sr_ready() - Query the Status Register to see if the flash is ready
> >   * for new commands.
> > @@ -590,33 +563,12 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
> >   */
> >  int spi_nor_sr_ready(struct spi_nor *nor)
> >  {
> > -       int ret = spi_nor_read_sr(nor, nor->bouncebuf);
> > +       int ret;
> > 
> > +       ret = spi_nor_read_sr(nor, nor->bouncebuf);
> >         if (ret)
> >                 return ret;
> 
> :) don't change style for no reason. What's wrong with the previous version?

FWIW, I like the newer style better. But that should come in a separate 
patch in either case.

> 
> Anyway, with the reports fixed and no hidden style changes, it looks good to me.
> 
> > 
> > -       if (nor->flags & SNOR_F_USE_CLSR &&
> > -           nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
> > -               if (nor->bouncebuf[0] & SR_E_ERR)
> > -                       dev_err(nor->dev, "Erase Error occurred\n");
> > -               else
> > -                       dev_err(nor->dev, "Programming Error occurred\n");
> > -
> > -               spi_nor_clear_sr(nor);
> > -
> > -               /*
> > -                * WEL bit remains set to one when an erase or page program
> > -                * error occurs. Issue a Write Disable command to protect
> > -                * against inadvertent writes that can possibly corrupt the
> > -                * contents of the memory.
> > -                */
> > -               ret = spi_nor_write_disable(nor);
> > -               if (ret)
> > -                       return ret;
> > -
> > -               return -EIO;
> > -       }
> > -
> >         return !(nor->bouncebuf[0] & SR_WIP);
> >  }
> > 
> > diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> > index dedc2de90cb8..4756fb88eab2 100644
> > --- a/drivers/mtd/spi-nor/spansion.c
> > +++ b/drivers/mtd/spi-nor/spansion.c
> > @@ -8,6 +8,7 @@
> > 
> >  #include "core.h"
> > 
> > +#define SPINOR_OP_CLSR         0x30    /* Clear status register 1 */
> >  #define SPINOR_OP_RD_ANY_REG                   0x65    /* Read any register */
> >  #define SPINOR_OP_WR_ANY_REG                   0x71    /* Write any register */
> >  #define SPINOR_REG_CYPRESS_CFR2V               0x00800003
> > @@ -294,6 +295,72 @@ static const struct flash_info spansion_parts[] = {
> >         },
> >  };
> > 
> > +/**
> > + * spi_nor_clear_sr() - Clear the Status Register.
> > + * @nor:       pointer to 'struct spi_nor'.
> > + */
> > +static void spi_nor_clear_sr(struct spi_nor *nor)
> > +{
> > +       int ret;
> > +
> > +       if (nor->spimem) {
> > +               struct spi_mem_op op =
> > +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 0),
> > +                                  SPI_MEM_OP_NO_ADDR,
> > +                                  SPI_MEM_OP_NO_DUMMY,
> > +                                  SPI_MEM_OP_NO_DATA);
> > +
> > +               spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> > +
> > +               ret = spi_mem_exec_op(nor->spimem, &op);
> > +       } else {
> > +               ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLSR,
> > +                                                      NULL, 0);
> > +       }
> > +
> > +       if (ret)
> > +               dev_dbg(nor->dev, "error %d clearing SR\n", ret);
> > +}
> > +
> > +/**
> > + * spi_nor_sr_ready_and_clear() - Query the Status Register to see if the flash
> > + * is ready for new commands and clear it.
> > + * @nor:       pointer to 'struct spi_nor'.
> > + *
> > + * Return: 1 if ready, 0 if not ready, -errno on errors.
> > + */
> > +int spi_nor_sr_ready_and_clear(struct spi_nor *nor)

Make it static.

[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
