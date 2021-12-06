Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF3546A3D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbhLFSV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:21:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55242 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhLFSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:21:25 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B6IHnAo090891;
        Mon, 6 Dec 2021 12:17:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638814669;
        bh=mTMJwe0tDsfW2xllsLH81/Xe/KQyO5THAtqhZ+17910=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DJDfhl0KIF0JwZZlwB7htFyHC7hQbLQd3mq1g3LgCpQpZxfL/5pZUMvyvJ6h3pvd3
         eDqyZocL6C257NpDPbPgxWiUb6XAyJmcP79XTfc61Cc90/xTUalNA8rXn7WA5cjEmI
         t9es9R41GAvV4FvG2nkH/Qb4DefFU0NP07B+5NeQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B6IHnWP011493
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 12:17:49 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Dec 2021 12:17:49 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Dec 2021 12:17:49 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B6IHmZN105718;
        Mon, 6 Dec 2021 12:17:48 -0600
Date:   Mon, 6 Dec 2021 23:47:47 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <Alexander.Stein@tq-group.com>, <michael@walle.cc>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: Skip erase logic when SPI_NOR_NO_ERASE
 is set
Message-ID: <20211206181745.kcro3sgwacrh22iw@ti.com>
References: <20211106075616.95401-1-tudor.ambarus@microchip.com>
 <20211106075616.95401-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211106075616.95401-3-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/21 09:56AM, Tudor Ambarus wrote:
> SPI_NOR_NO_ERASE is used either by F-RAMs, or MRAMs, or EEPROMs,
> neither of which supports SFDP, so once SPI_NOR_NO_ERASE is set,
> SFDP can not undo it. These type of flashes should be moved out of
> the SPI NOR core anyway, so don't complicate things and just skip
> the erase logic when SPI_NOR_NO_ERASE is set. Normally SPI NOR core
> should operate just on SNOR_F flags, but since SPI_NOR_NO_ERASE
> should be removed, don't bother with extra code.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index a1b5d5432f41..52c82d943499 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2680,6 +2680,9 @@ static void spi_nor_skip_sfdp_init_params(struct spi_nor *nor)
>  					SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
>  	}
>  
> +	if (info_flags & SPI_NOR_NO_ERASE)
> +		return;
> +
>  	/*
>  	 * Sector Erase settings. Sort Erase Types in ascending order, with the
>  	 * smallest erase size starting at BIT(0).
> @@ -3195,12 +3198,13 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
>  		mtd->name = dev_name(dev);
>  	mtd->type = MTD_NORFLASH;
>  	mtd->flags = MTD_CAP_NORFLASH;
> -	if (nor->info->flags & SPI_NOR_NO_ERASE)
> +	if (nor->info->flags & SPI_NOR_NO_ERASE) {
> +		mtd->_erase = spi_nor_erase;

You only set mtd->_erase when SPI_NOR_NO_ERASE is set? That does not 
make any sense to me. It should be the opposite.

>  		mtd->flags |= MTD_NO_ERASE;
> +	}
>  	mtd->writesize = nor->params->writesize;
>  	mtd->writebufsize = nor->params->page_size;
>  	mtd->size = nor->params->size;
> -	mtd->_erase = spi_nor_erase;
>  	mtd->_read = spi_nor_read;
>  	/* Might be already set by some SST flashes. */
>  	if (!mtd->_write)
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
