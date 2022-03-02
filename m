Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A414CA4CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiCBMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiCBMaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:30:05 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8955F60057;
        Wed,  2 Mar 2022 04:29:21 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 222CSp9w008259;
        Wed, 2 Mar 2022 06:28:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646224131;
        bh=Bdd647K0ux5fTDFXZZlqZcIilgzfVjUNpmykTMnnPF0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OwgKaxrqtjU56pmIsNKLYfToXQdM3fm4o3dSAckhnIKodKcxDcCOJoqw5PPy3wiYe
         mDT5qe88Y0WLmqkhc6FwGEuzbHIGoFZKdsTuv0KPFJnQJVdkBllUFa21DhYFDk4Djg
         6esHpfXj6kKyGWivOooajB9K0VtVJD9/xEaFIIj0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 222CSpKp030541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Mar 2022 06:28:51 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Mar 2022 06:28:51 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Mar 2022 06:28:50 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 222CSome103846;
        Wed, 2 Mar 2022 06:28:50 -0600
Date:   Wed, 2 Mar 2022 17:58:49 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 3/4] mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from
 BFPT
Message-ID: <20220302122849.2vo5nnbnxpfenwci@ti.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <20220218145900.1440045-4-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220218145900.1440045-4-tudor.ambarus@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/22 04:58PM, Tudor Ambarus wrote:
> Parse BFPT in order to retrieve the byte order in 8D-8D-8D mode.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> ---
>  drivers/mtd/spi-nor/sfdp.c | 3 +++
>  drivers/mtd/spi-nor/sfdp.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index a5211543d30d..551edbb039f0 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -633,6 +633,9 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (bfpt.dwords[BFPT_DWORD(18)] & BFPT_DWORD18_BYTE_ORDER_SWAPPED)
> +		nor->flags |= SNOR_F_DTR_BSWAP16;
> +
>  	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
>  }
>  
> diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
> index bbf80d2990ab..9a834ea31c16 100644
> --- a/drivers/mtd/spi-nor/sfdp.h
> +++ b/drivers/mtd/spi-nor/sfdp.h
> @@ -97,6 +97,7 @@ struct sfdp_bfpt {
>  #define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
>  #define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
>  #define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
> +#define BFPT_DWORD18_BYTE_ORDER_SWAPPED		BIT(31)
>  
>  struct sfdp_parameter_header {
>  	u8		id_lsb;
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
