Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1D8488F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 06:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiAJFHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 00:07:55 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38488 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiAJFHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 00:07:54 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20A57YP1070432;
        Sun, 9 Jan 2022 23:07:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641791254;
        bh=SINVtEXoW1UxY2lLaP88MbTLRi1LPbuXnc7mbNpv21M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=l1XLrCu8BQJECBy9wsqRM6hqhCH2t9KfQagrxEio9IPP60TcAnY8KulySIXL1rqUF
         ok+O2oh1KGtbgJyhQeY9WLQlsGxK23Thg4+lEUKma9zPysWD484J95KEEPtuE2zphy
         Tz2cX5WpFps+a/zAeGsnLrKLwLgE4f6t4oImRIeI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20A57Ytb006515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Jan 2022 23:07:34 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 9
 Jan 2022 23:07:33 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 9 Jan 2022 23:07:34 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20A57W95001634;
        Sun, 9 Jan 2022 23:07:33 -0600
Date:   Mon, 10 Jan 2022 10:37:32 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25q512jvm
Message-ID: <20220110050730.ga34eztvhs4bd3sb@ti.com>
References: <20220109044418.4657-1-dphadke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220109044418.4657-1-dphadke@linux.microsoft.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dhananjay,

On 08/01/22 08:44PM, Dhananjay Phadke wrote:
> Add support for Winbond 64MB W25Q512JV-DTR NOR flash.
> Use PARSE_SFDP flag to init parameters during SFDP parsing.
> 
> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> ---

You need to show the dumps of the SFDP and other flash parameters. See 
[0] for an example.

The patch looks fine to me otherwise.

[0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20211209190436.401946-2-tudor.ambarus@microchip.com/

>  drivers/mtd/spi-nor/winbond.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 675f32c136b3..ebc826e21f76 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -118,6 +118,8 @@ static const struct flash_info winbond_parts[] = {
>  		.fixups = &w25q256_fixups },
>  	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512)
>  		PARSE_SFDP },
> +	{ "w25q512jvm", INFO(0xef7020, 0, 64 * 1024, 1024),
> +		PARSE_SFDP },
>  	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
