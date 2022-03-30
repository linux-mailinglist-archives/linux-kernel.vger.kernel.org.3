Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED514ECD89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbiC3Tvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiC3Tvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:51:36 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E12CE2B;
        Wed, 30 Mar 2022 12:49:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22UJnIgw086057;
        Wed, 30 Mar 2022 14:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648669758;
        bh=Wxy1IwTpIUIfVJGOAq2NOfEI+2cbw3VlSeZRH56rW8M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UoJPVuBNI8m/ixKDfQugawBpaOyrVQYZLFWOFD03gjpDJlBPH8cKwO37t+M19l5Yl
         Gmw6vNhEwLZqW4oe0dd9YnxdBahdOAzLBgLXZP/Xak8DUjosIBS0Nskfe3kmxhzSgx
         E7banJMetcx2zpdREZKEf30l5/Vzffhy9CIelmNE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22UJnIw9062750
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Mar 2022 14:49:18 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 30
 Mar 2022 14:49:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 30 Mar 2022 14:49:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22UJnHrB010599;
        Wed, 30 Mar 2022 14:49:17 -0500
Date:   Thu, 31 Mar 2022 01:19:16 +0530
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
        <linux-kernel@vger.kernel.org>, Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH v4 11/11] mtd: spi-nor: aspeed: set the decoding size to
 at least 2MB for AST2600
Message-ID: <20220330194916.olffkctxjhfqksvf@ti.com>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220325100849.2019209-12-clg@kaod.org>
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


> Subject: [PATCH v4 11/11] mtd: spi-nor: aspeed: set the decoding size to at least 2MB for AST2600

Nitpick: s/mtd: spi-nor: aspeed:/spi: aspeed:/

On 25/03/22 11:08AM, Cédric Le Goater wrote:
> From: Potin Lai <potin.lai@quantatw.com>
> 
> In AST2600, the unit of SPI CEx decoding range register is 1MB, and end
> address offset is set to the acctual offset - 1MB. If the flash only has
> 1MB, the end address will has same value as start address, which will
> causing unexpected errors.
> 
> This patch set the decoding size to at least 2MB to avoid decoding errors.
> 
> Tested:
> root@bletchley:~# dmesg | grep "aspeed-smc 1e631000.spi: CE0 window"
> [   59.328134] aspeed-smc 1e631000.spi: CE0 window resized to 2MB (AST2600 Decoding)
> [   59.343001] aspeed-smc 1e631000.spi: CE0 window [ 0x50000000 - 0x50200000 ] 2MB
> root@bletchley:~# devmem 0x1e631030
> 0x00100000
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> [ clg : Ported on new spi-mem driver ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  drivers/spi/spi-aspeed-smc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 660451667a39..227797e13997 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -466,6 +466,8 @@ static int aspeed_spi_set_window(struct aspeed_spi *aspi,
>   *   is correct.
>   */
>  static const struct aspeed_spi_data ast2500_spi_data;
> +static const struct aspeed_spi_data ast2600_spi_data;
> +static const struct aspeed_spi_data ast2600_fmc_data;
>  
>  static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
>  					 u32 local_offset, u32 size)
> @@ -489,6 +491,17 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
>  			 chip->cs, size >> 20);
>  	}
>  
> +	/*
> +	 * The decoding size of AST2600 SPI controller should set at
> +	 * least 2MB.
> +	 */
> +	if ((aspi->data == &ast2600_spi_data || aspi->data == &ast2600_fmc_data) &&
> +	    size < SZ_2M) {
> +		size = SZ_2M;
> +		dev_info(aspi->dev, "CE%d window resized to %dMB (AST2600 Decoding)",
> +			 chip->cs, size >> 20);
> +	}
> +
>  	aspeed_spi_get_windows(aspi, windows);
>  
>  	/* Adjust this chip window */
> -- 
> 2.34.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
