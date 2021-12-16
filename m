Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667BF477D01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbhLPUF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:05:57 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47496 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhLPUF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:05:56 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BGK5dVK057700;
        Thu, 16 Dec 2021 14:05:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639685139;
        bh=wrQp1fnJ6mOn8LdRMHRJtFOxR0DVxqVmRrbvc0vm4Is=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZYSxDOmA/sNo2/rutgMHvwkpgpu9M+mOGYySXrBZVXtqakaeKsedI+vFRPCmE/djC
         /YUpVYNBN2BvkWOldNXeYJvxDEuu54yAD/6Sy18rf1sbLzT5H3UE6kPDWZaFsD3Pzy
         IXLu5w3n6IZRe3exH6LaUrQPliV5P5gjqjPb4cgU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BGK5dZv113468
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Dec 2021 14:05:39 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 16
 Dec 2021 14:05:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 16 Dec 2021 14:05:38 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BGK5cml118318;
        Thu, 16 Dec 2021 14:05:38 -0600
Date:   Fri, 17 Dec 2021 01:35:37 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
CC:     <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Introduce erase_proto
Message-ID: <20211216200535.jikqd42nohr4477n@ti.com>
References: <20211209100813.61713-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211209100813.61713-1-alexander.sverdlin@nokia.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 09/12/21 11:08AM, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> I've been looking into non-working erase on mt25qu256a and pinpointed it to
> be write_proto 1-4-4 selected from SFDP while the chip only supports 1-1-0
> erase.
> 
> For now just introduce the separate protocol without functional change and
> leave the real fix for the following patch.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  drivers/mtd/spi-nor/core.c  | 9 ++++++---
>  include/linux/mtd/spi-nor.h | 4 +++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 2e21d5a..dcd02ea 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -177,7 +177,7 @@ static int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
>  
>  static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
>  {
> -	if (spi_nor_protocol_is_dtr(nor->write_proto))
> +	if (spi_nor_protocol_is_dtr(nor->erase_proto))
>  		return -EOPNOTSUPP;
>  
>  	return nor->controller_ops->erase(nor, offs);
> @@ -1186,7 +1186,7 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_NO_DATA);
>  
> -		spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
> +		spi_nor_spimem_setup_op(nor, &op, nor->erase_proto);
>  
>  		ret = spi_mem_exec_op(nor->spimem, &op);
>  	} else {
> @@ -1331,7 +1331,7 @@ int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
>  				   SPI_MEM_OP_NO_DUMMY,
>  				   SPI_MEM_OP_NO_DATA);
>  
> -		spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
> +		spi_nor_spimem_setup_op(nor, &op, nor->erase_proto);
>  
>  		return spi_mem_exec_op(nor->spimem, &op);
>  	} else if (nor->controller_ops->erase) {
> @@ -2727,6 +2727,9 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
>  	 */
>  	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
>  		spi_nor_init_default_locking_ops(nor);
> +
> +	if (!nor->erase_proto)
> +		nor->erase_proto = nor->write_proto;

I get that you are trying to not break any existing flashes with this, 
but I don't quite like it. We should keep the same initialization flow 
with erase_proto as with write_proto, read_proto, etc. That is, 
initialize it to SNOR_PROTO_1_1_1 in spi_nor_scan() and then let the 
initialization procedure change it as needed.

The problem with this is of course that it could break some flashes by 
selecting the wrong erase. I would expect _most_ flashes to use 
erase_proto as 1-1-1 but I of course haven't went and looked at every 
single flash to point out the exceptions.

I would like to hear from others if they think it is okay to do this.

>  }
>  
>  /**

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
