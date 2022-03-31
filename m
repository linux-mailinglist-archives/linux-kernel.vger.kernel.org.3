Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3915F4EDF02
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbiCaQoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiCaQoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:44:02 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E0420E947;
        Thu, 31 Mar 2022 09:42:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22VGfHbT077632;
        Thu, 31 Mar 2022 11:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648744877;
        bh=q4I8OmbE9lpXlZiTsZ65bC0HGywDTKwPLArPoG/uE2k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=q0Xzj8+bwKSW6n1SqCu0ajMaUE0JPYpjhHRhw91vS23GJPbmNB2y4KvnSyMwK4b0G
         tICwB/nlIKOZogc7v+AgBb7Nkgi4L+dNaEnoD/OTRXYvqtb41WlnIaWJh/1ja6UlnB
         Z/18XT7txfkmCyGW5GBJXH9G+eMWUZRcGGK66ZrM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22VGfHo6024529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 11:41:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 11:41:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 11:41:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22VGfG1R087297;
        Thu, 31 Mar 2022 11:41:16 -0500
Date:   Thu, 31 Mar 2022 22:11:15 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tao Ren <rentao.bupt@gmail.com>
Subject: Re: [PATCH v4 08/11] spi: aspeed: Calibrate read timings
Message-ID: <20220331164115.w5q3wxlmwcg3w4ns@ti.com>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220325100849.2019209-9-clg@kaod.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/03/22 11:08AM, Cédric Le Goater wrote:
> To accommodate the different response time of SPI transfers on different
> boards and different SPI NOR devices, the Aspeed controllers provide a
> set of Read Timing Compensation registers to tune the timing delays
> depending on the frequency being used. The AST2600 SoC has one of these
> registers per device. On the AST2500 and AST2400 SoCs, the timing
> register is shared by all devices which is problematic to get good
> results other than for one device.
> 
> The algorithm first reads a golden buffer at low speed and then performs
> reads with different clocks and delay cycle settings to find a breaking
> point. This selects a default good frequency for the CEx control register.
> The current settings are a bit optimistic as we pick the first delay giving
> good results. A safer approach would be to determine an interval and
> choose the middle value.
> 
> Calibration is performed when the direct mapping for reads is created.
> Since the underlying spi-nor object needs to be initialized to create
> the spi_mem operation for direct mapping, we should be fine. Having a
> specific API would clarify the requirements though.
> 
> Cc: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Tao Ren <rentao.bupt@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  drivers/spi/spi-aspeed-smc.c | 281 +++++++++++++++++++++++++++++++++++
>  1 file changed, 281 insertions(+)
> 
[...]
> @@ -517,6 +527,8 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
>  	return 0;
>  }
>  
> +static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip);
> +
>  static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  {
>  	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
> @@ -565,6 +577,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
>  	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
>  
> +	ret = aspeed_spi_do_calibration(chip);
> +

I am still not convinced this is a good idea. The API does not say 
anywhere what dirmap_create must be called after the flash is completely 
initialized, though that is what is done currently in practice. I think 
an explicit API to mark flash as "ready for calibration" would be a 
better idea.

Tudor/Mark/Miquel, what do you think?

>  	dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
>  		 chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_READ]);
>  
[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
