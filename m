Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10C7494B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359769AbiATKMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:12:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49116 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiATKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:12:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20KACNJc044524;
        Thu, 20 Jan 2022 04:12:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1642673543;
        bh=sTm9Bn4sy6Bs//IDGPOdP1kqR36tKRbjiXGLPR+6GYU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BcAqqd7m6b6rnMYbzZtx7tk28krzg+FwUxtBuvn7PLOXga4FQHbIlLskP1wuXADRS
         Ayr5c9Vzzs6E30t8j4Q6abwoRqYa8HklId03W1k0vzkPlaIMu4yLvtQ/3l0YsMcLZ/
         GEwtqyQii03YXkrFz4+/CQoAsC6phKL9OESsNAY8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20KACNjO112372
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jan 2022 04:12:23 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 20
 Jan 2022 04:12:22 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 20 Jan 2022 04:12:22 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20KACL6E083517;
        Thu, 20 Jan 2022 04:12:22 -0600
Date:   Thu, 20 Jan 2022 15:42:21 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
CC:     <dianders@chromium.org>, <tudor.ambarus@microchip.com>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stummala@codeaurora.org>,
        <vbadigan@codeaurora.org>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <sartgarg@codeaurora.org>
Subject: Re: [PATCH V4] mtd: spi-nor: winbond: Add support for winbond chip
Message-ID: <20220120101221.oqtfa6vosnweqsoq@ti.com>
References: <1642672491-30067-1-git-send-email-quic_c_sbhanu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1642672491-30067-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/01/22 03:24PM, Shaik Sajida Bhanu wrote:
> Add support for winbond W25Q512NW-IM chip.
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
> 
> Changes since V1:
> 	- Added space before name of the flash part as suggested by Doug.
> 
> Changes since V2:
> 	- Updated chip name as w25q512nwm as suggested by Doug.
> 
> Changes since V3:
> 	- Updated flash_info flags passing according to below patch
> 	 https://lore.kernel.org/all/20211207140254.87681-7-tudor.ambarus@microchip.com/
> 	 As suggested by Tudor Ambarus.
> ---
>  drivers/mtd/spi-nor/winbond.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 675f32c..c4be225 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -124,6 +124,10 @@ static const struct flash_info winbond_parts[] = {
>  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_DUAL_READ) },
> +	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },

This way is for "legacy" flash code and is not recommended anymore. Does 
the flash support SFDP? In that case just add PARSE_SFDP and let the 
SFDP parser discover these capabilities. You can keep the "FLAGS" part 
since those are not discoverable via SFDP.

>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
