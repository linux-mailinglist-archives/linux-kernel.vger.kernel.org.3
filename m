Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E3552E14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346775AbiFUJRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347043AbiFUJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:16:58 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763E4183A0;
        Tue, 21 Jun 2022 02:16:57 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25L9Gp8G027934;
        Tue, 21 Jun 2022 04:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655803011;
        bh=x45K8QRhdDZpInTZbM50crglxTjTFX4dHZmKUcemAro=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bXSH4Ln4pvotdNxL1IoWmWgAFtxtQO64EbJBF1w+hnk+4EEDG4KN9eIsNltEcdFAZ
         SI3fqlyGP+PuroWBMBi+kiG/kCJulzxBQQ/o2Ken5crzuNY2XQW87/t4qp7q6Pp102
         jNUpKCHwLOeHiTTNoylLbioun+wmhX63BKPmdOmA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25L9GpfG081351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jun 2022 04:16:51 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Jun 2022 04:16:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Jun 2022 04:16:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25L9GoOW128720;
        Tue, 21 Jun 2022 04:16:51 -0500
Date:   Tue, 21 Jun 2022 14:46:50 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Sai Krishna Potthuri <lakshmis@xilinx.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>
Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device
 reset
Message-ID: <20220621091650.ktuluymgpdgxghd7@ti.com>
References: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1649156437-15609-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <20220405191757.3rzc6q477reusywp@ti.com>
 <PH0PR02MB7189C07E60A93426764C688EBDDC9@PH0PR02MB7189.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH0PR02MB7189C07E60A93426764C688EBDDC9@PH0PR02MB7189.namprd02.prod.outlook.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/22 08:12AM, Sai Krishna Potthuri wrote:
> Hi Pratyush,
> 
> > -----Original Message-----
> > From: Pratyush Yadav <p.yadav@ti.com>
> > Sent: Wednesday, April 6, 2022 12:48 AM
> > To: Sai Krishna Potthuri <lakshmis@xilinx.com>
> > Cc: Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > spi@vger.kernel.org; Michal Simek <michals@xilinx.com>; git
> > <git@xilinx.com>; saikrishna12468@gmail.com; Srinivas Goud
> > <sgoud@xilinx.com>
> > Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device
> > reset
> > 
> > On 05/04/22 04:30PM, Sai Krishna Potthuri wrote:
> > > Cadence OSPI controller always start in SDR mode and it doesn't know
> > > the current mode of the flash device (SDR or DDR). This creates issue
> > > during Cadence OSPI driver probe if OSPI flash device is in DDR mode.
> > > This patch add OSPI flash device reset using HW reset pin for Xilinx
> > > Versal platform, this will make sure both Controller and Flash device
> > > are in same mode (SDR).
> > 
> > Is this supposed to reset the OSPI flash or the controller? If you are resetting
> > it in the flash then you should handle this from the flash driver, not from
> > here.
> I am handling OSPI flash reset here. Agree, controlling or issuing the flash reset 
> should be from the flash driver and not from the controller driver but handling
> the reset might depends on the platform and should be in the controller driver. 
> One platform might be handling the reset through GPIO and others might handle 
> it differently via some system level control registers or even controller registers.
> To support this platform specific implementation i am thinking to provide a
> "hw_reset" hook in the spi_controller_mem_ops structure and this will be
> accessed or called from spi-nor if  "broken-flash-reset" property is not set.
> Whichever controller driver registers for hw_reset hook, they can have their own
> implementation to reset the flash device based on the platform.
> Do you think this approach works? Please suggest.
> 
> Code snippet like below.
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 2ba044d0d5e5..b8240dfb246d 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -285,6 +285,7 @@ struct spi_controller_mem_ops {
>                            unsigned long initial_delay_us,
>                            unsigned long polling_rate_us,
>                            unsigned long timeout_ms);
> +       int (*hw_reset)(struct spi_mem *mem);
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index e8de4f5017cd..9ac2c2c30443 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -598,6 +598,27 @@ static void devm_spi_mem_dirmap_release(struct device *dev, void *res)
>         spi_mem_dirmap_destroy(desc);
>  }
> +int spi_mem_hw_reset(struct spi_mem *mem)
> +{
> +       struct spi_controller *ctlr = mem->spi->controller;
> +
> +       if (ctlr->mem_ops && ctlr->mem_ops->hw_reset)
> +               return ctlr->mem_ops->hw_reset(mem);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_hw_reset);

Hmm, wouldn't it be better to register the controller as a reset 
provider and then teach SPI NOR to call reset_control_assert()? This way 
you can cleanly handle GPIO based resets as well as MMIO register based 
reset using the CQSPI_REG_CONFIG bit 5.

How I am thinking it should work in your case is you can create a GPIO 
based reset controller driver (I wonder why this hasn't been done yet) 
that toggles a given GPIO line based on reset_control_assert() or 
reset_control_deassert() calls [0]. Then in the SPI NOR DT node you just 
do resets = <&your_reset device>. On a platform which supports reset via 
bit 5 of CQSPI_REG_CONFIG, they can do resets = <&cqspi_controller>.

I am not particularly familiar with the details of the reset framework 
so I would like to hear what others think, but I think it is a good 
proposal to start with.

[0] Or, you could register the GPIO driver itself as a reset controller. 
    I am not sure which works better.

> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index b4f141ad9c9c..2c09c733bb8b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2966,6 +2962,7 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
>  int spi_nor_scan(struct spi_nor *nor, const char *name,
>                  const struct spi_nor_hwcaps *hwcaps)
>  {
> +       struct device_node *np = spi_nor_get_flash_node(nor);
>         const struct flash_info *info;
>         struct device *dev = nor->dev;
>         struct mtd_info *mtd = &nor->mtd;
> @@ -2995,6 +2992,14 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>         if (!nor->bouncebuf)
>                 return -ENOMEM;
>  
> +       if (of_property_read_bool(np, "broken-flash-reset")) {
> +               nor->flags |= SNOR_F_BROKEN_RESET;
> +       } else {
> +               ret = spi_mem_hw_reset(nor->spimem);
> +               if (ret)
> +                       return ret;
> +       }
> 
> Regards
> Sai Krishna
> > 
> > Also, as of now at least, SPI NOR only works when the flash is in SDR mode.
> > For TI platforms, we reset the flash in the bootloader (U-Boot), before
> > handing control off to the kernel. If you do want to properly handle flashes
> > that are handed to the kernel in DDR mode, I would suggest you update SPI
> > NOR instead to detect the flash mode and work from there. This would also
> > allow us to support flashes that boot in DDR mode, so would still be in DDR
> > mode even after a reset.
> > 
> > > Xilinx Versal platform has a dedicated pin used for OSPI device reset.
> > > As part of the reset sequence, configure the pin to enable hysteresis
> > > and set the direction of the pin to output before toggling the pin.
> > > Provided the required delay ranges while toggling the pin to meet the
> > > most of the OSPI flash devices reset pulse width, reset recovery and
> > > CS high to reset high timings.
> > >
> > > Signed-off-by: Sai Krishna Potthuri
> > > <lakshmi.sai.krishna.potthuri@xilinx.com>
> > [...]
> > 
> > --
> > Regards,
> > Pratyush Yadav
> > Texas Instruments Inc.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
