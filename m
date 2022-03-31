Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9884EE14C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiCaTGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiCaTGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:06:19 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885D91903C5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:04:29 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22VJ43vQ052621;
        Thu, 31 Mar 2022 14:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648753443;
        bh=+hpF99iyhgx9s0BuD1Wq5B4/4uDMpeBTQsdIdUEE4kw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=k1J6EQ50PcU6vL9yQfcQhkBZdSo4gVUwsNjxnmjDNfJWsQjOSxxFBPDQurmYJtCsY
         0DWBXQF6lkgRXelDczKoheFUVZu4wShsapT5v4Qz+emadhb6gMPTLeQxXkyzZhkzwt
         DCnsbaaUkOb5U4RsLDlkQ5OmHCMtW8yDZN0ig/0Y=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22VJ43KC093434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 14:04:03 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 14:04:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 14:04:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22VJ422p126927;
        Thu, 31 Mar 2022 14:04:03 -0500
Date:   Fri, 1 Apr 2022 00:34:02 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nathan Rossi <nathan@nathanrossi.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: core: Fix 16bit write sr_and_check status
 check
Message-ID: <20220331190402.d3fymx3msnzyycef@ti.com>
References: <20220324070004.225738-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220324070004.225738-1-nathan@nathanrossi.com>
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

Hi Nathan,

On 24/03/22 07:00AM, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> The spi_nor_write_16bit_sr_and_check function description describes that
> the function compares the value of the status and config registers after
> the write. However the function does not implement the status register
> compare only the config register check.
> 
> This causes the function to differ in behaviour to the equivalent
> spi_nor_write_sr1_and_check for non-16bit writes to the status register.
> This is important as other functions rely on the return code of
> spi_nor_write_sr_and_check. For example spi_nor_sr_unlock returns the
> result directly, which is returned to userspace such that failing to
> unlock the spi-nor device was resulting in a return code of 0 instead of
> the expected non-zero indicating the failure.
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> ---
>  drivers/mtd/spi-nor/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 04ea180118..d75d4f8a45 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1007,6 +1007,15 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
>  	if (ret)
>  		return ret;
>  
> +	ret = spi_nor_read_sr(nor, sr_cr);
> +	if (ret)
> +		return ret;
> +
> +	if (sr1 != sr_cr[0]) {
> +		dev_dbg(nor->dev, "SR: read back test failed\n");
> +		return -EIO;
> +	}
> +
>  	if (nor->flags & SNOR_F_NO_READ_CR)
>  		return 0;

This patch seems exactly like [0]. I will pick that one if it applies on 
the current tree since it already has one Reviewed-by.

[0] https://lore.kernel.org/linux-mtd/20220126073227.3401275-1-chentsung@chromium.org/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
