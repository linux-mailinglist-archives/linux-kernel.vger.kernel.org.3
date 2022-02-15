Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA2F4B7838
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbiBOTQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:16:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243482AbiBOTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:16:27 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D60E10A7C2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:16:16 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FJGAbF001349;
        Tue, 15 Feb 2022 13:16:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644952570;
        bh=N7QUpF2nmxv/WQFThtwxd7D74QoOdQ5Va2kIaM7t/vQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xl4ad6Qb1hdffz2grbH6fqI2f8JVDGwjHfV7XtuM1wCZjk234KT8NkFwbJLzAXkfG
         3a/WNPpzYHWzowlWKcd5ffvmVCI1YfAHC8EV6gcgeRdLsfa8dQDZvFg0mjM501LwY3
         +yBAKcLgcqLUNVoGKeFWKy3w9WNKVpmkGLfKjS+A=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FJGAbD045258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 13:16:10 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 13:16:10 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 13:16:10 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FJG9nn023071;
        Tue, 15 Feb 2022 13:16:10 -0600
Date:   Wed, 16 Feb 2022 00:46:09 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH v1 08/14] mtd: spi-nor: micron-st: convert USE_FSR to a
 manufacturer flag
Message-ID: <20220215191609.tyudvewu4vu6o7td@ti.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-9-michael@walle.cc>
 <0eee21f3-8c03-3d82-dc5f-6d9d6fc7fc45@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0eee21f3-8c03-3d82-dc5f-6d9d6fc7fc45@microchip.com>
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

On 10/02/22 03:37AM, Tudor.Ambarus@microchip.com wrote:
> On 2/2/22 16:58, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Now that all functions using that flag are local to the micron module,
> > we can convert the flag to a manufacturer one.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> >  drivers/mtd/spi-nor/core.c      |  3 --
> >  drivers/mtd/spi-nor/core.h      |  3 --
> >  drivers/mtd/spi-nor/micron-st.c | 92 +++++++++++++++++++++------------
> >  3 files changed, 59 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index e9d9880149d2..be65aaa954ca 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2499,9 +2499,6 @@ static void spi_nor_init_flags(struct spi_nor *nor)
> > 
> >         if (flags & USE_CLSR)
> >                 nor->flags |= SNOR_F_USE_CLSR;
> > -
> > -       if (flags & USE_FSR)
> > -               nor->flags |= SNOR_F_USE_FSR;
> >  }
> > 
> >  /**
> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index fabc01ae9a81..a02bf54289fb 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -12,7 +12,6 @@
> >  #define SPI_NOR_MAX_ID_LEN     6
> > 
> >  enum spi_nor_option_flags {
> > -       SNOR_F_USE_FSR          = BIT(0),
> >         SNOR_F_HAS_SR_TB        = BIT(1),
> >         SNOR_F_NO_OP_CHIP_ERASE = BIT(2),
> >         SNOR_F_USE_CLSR         = BIT(4),
> > @@ -349,7 +348,6 @@ struct spi_nor_fixups {
> >   *   NO_CHIP_ERASE:           chip does not support chip erase.
> >   *   SPI_NOR_NO_FR:           can't do fastread.
> >   *   USE_CLSR:                use CLSR command.
> > - *   USE_FSR:                 use flag status register
> >   *
> >   * @no_sfdp_flags:  flags that indicate support that can be discovered via SFDP.
> >   *                  Used when SFDP tables are not defined in the flash. These
> > @@ -401,7 +399,6 @@ struct flash_info {
> >  #define NO_CHIP_ERASE                  BIT(7)
> >  #define SPI_NOR_NO_FR                  BIT(8)
> >  #define USE_CLSR                       BIT(9)
> > -#define USE_FSR                                BIT(10)
> > 
> >         u8 no_sfdp_flags;
> >  #define SPI_NOR_SKIP_SFDP              BIT(0)
> > diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> > index c66580e8aa00..33531c101ccb 100644
> > --- a/drivers/mtd/spi-nor/micron-st.c
> > +++ b/drivers/mtd/spi-nor/micron-st.c
> > @@ -8,6 +8,8 @@
> > 
> >  #include "core.h"
> > 
> > +#define USE_FSR                BIT(0)
> 
> please add a description and inform the reader that this is a manufacturer specific
> flash_info flag.

+1

> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>


-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
