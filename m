Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE01949B163
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbiAYKLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:11:07 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34778 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiAYKBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:01:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20PA1EMo109847;
        Tue, 25 Jan 2022 04:01:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643104874;
        bh=c0J7TKjHWfZrKCmOVPBiKFm+qVkhcj0TJ8/2B5dklU0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BkYBpo2PKEqb6rUbS42OJ2zEUPs5WBcWshSAs+SBBzjgmNRvLA4SDM+YmVb0RoijL
         XXihRz94R8SLwBF97R/ThV/8WO7qPUcSXc6Y1IhMDKB0fghVkCkUN/qPqjOTlwiF7A
         omyzyyDatkM/xxvQTx6hbzB43j0sCZ+0d6ce6vP8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20PA1DkI071265
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jan 2022 04:01:14 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 25
 Jan 2022 04:01:13 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 25 Jan 2022 04:01:13 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20PA1CZw011949;
        Tue, 25 Jan 2022 04:01:13 -0600
Date:   Tue, 25 Jan 2022 15:31:12 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Ley Foon Tan <leyfoon.tan@linux.starfivetech.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: macronix: Add support for mx66u1g45g
Message-ID: <20220125100112.jevrd4knhxytmry2@ti.com>
References: <20220124060225.149007-1-leyfoon.tan@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220124060225.149007-1-leyfoon.tan@linux.starfivetech.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/01/22 02:02PM, Ley Foon Tan wrote:
> The Macronix mx66u1g45g [1] is a 1.8V, 1Gbit (128MB) flash device that
> supports x1, x2, or x4 operation.
> 
> The mx66u1g45g is the smaller sibling of the mx66u2g45g that is
> already supported.
> 
> Tested on StarFive Dubhe hardware on FPGA.
> Validated by erase and read back, write and read back.
> 
> [1] https://www.macronix.com/Lists/Datasheet/Attachments/7877/MX66U1G45G,%201.8V,%201Gb,%20v1.4.pdf
> 
> Signed-off-by: Ley Foon Tan <leyfoon.tan@linux.starfivetech.com>
> ---
>  drivers/mtd/spi-nor/macronix.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 97dba1ae7fb1..79ee808c5442 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -97,6 +97,9 @@ static const struct flash_info macronix_parts[] = {
>  			      SPI_NOR_QUAD_READ) },
>  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
>  		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
> +	{ "mx66u1g45g",  INFO(0xc2253b, 0, 64 * 1024, 2048)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> +		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },

This is the "legacy" way of defining flags. I see from the datasheet 
that SFDP is supported. Please use PARSE_SFDP to allow these parameters 
to be discovered via SFDP. If one of the SFDP table has wrong data then 
please use fixup hooks to correct it.

You also need to dump the SFDP table and some other flash parameters in 
the patch comments. See [0] for an example.

[0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20211209190436.401946-2-tudor.ambarus@microchip.com/

>  	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
> -- 
> 2.25.1
> 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
