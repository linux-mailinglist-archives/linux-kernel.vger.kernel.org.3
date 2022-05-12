Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93393524CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353775AbiELMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353727AbiELMcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:32:41 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ABB5A0B9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:32:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24CCWESM067393;
        Thu, 12 May 2022 07:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652358734;
        bh=MsVBxvyfgGwdtzvGgcuBz5n9dAHmwRvAG2ctFAEx0YE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uAz9oTYrCIN9LT2cx3D0A2LKdVIwQsxRVeVGUg+C/glF2ALLBGHCpF0u/X+EoPrsZ
         tHqBIRYlSEXmklkxJ15C9V/NEKfswZ8Nb1v4EirAn93p0WGmFG3mcMYkQ7TTfrj7WZ
         MOoTsl2/147S1S0jGVK+yds3lR+T8rkK91FbaOkc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24CCWEek051917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 May 2022 07:32:14 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 12
 May 2022 07:32:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 12 May 2022 07:32:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24CCWDK8094985;
        Thu, 12 May 2022 07:32:14 -0500
Date:   Thu, 12 May 2022 18:02:13 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mtd: spi-nor: debugfs: fix format specifier
Message-ID: <20220512123213.fzly4gollonlo27p@ti.com>
References: <20220512112027.3771734-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220512112027.3771734-1-michael@walle.cc>
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

Hi Michael,

On 12/05/22 01:20PM, Michael Walle wrote:
> The intention was to print the JEDEC ID in the following format:
>   nn nn nn
> 
> In this case format specifier has to be "%*ph". Fix it.
> 
> Fixes: 0257be79fc4a ("mtd: spi-nor: expose internal parameters via debugfs")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
> index bf9fda5d4d0b..4b972bd4b80d 100644
> --- a/drivers/mtd/spi-nor/debugfs.c
> +++ b/drivers/mtd/spi-nor/debugfs.c
> @@ -81,7 +81,7 @@ static int spi_nor_params_show(struct seq_file *s, void *data)
>  	int i;
>  
>  	seq_printf(s, "name\t\t%s\n", info->name);
> -	seq_printf(s, "id\t\t%*phn\n", SPI_NOR_MAX_ID_LEN, nor->id);
> +	seq_printf(s, "id\t\t%*ph\n", SPI_NOR_MAX_ID_LEN, nor->id);

Patch does not apply. Are you basing this on some other commits you 
have? This line is different on my tree:

	seq_printf(s, "id\t\t%*phn\n", info->id_len, info->id);

In fact, I do not have a nor->id at all in my tree. BTW, I have applied 
https://lore.kernel.org/r/20220429102018.2361038-2-michael@walle.cc

I am going to apply the below patch. Please ACK/NACK. I did a quick 
test, the output stays the same before and after this patch.

-- 8< --
From c47452194641b5d27c20e557c84a46c85fd7ce37 Mon Sep 17 00:00:00 2001
From: Michael Walle <michael@walle.cc>
Date: Thu, 12 May 2022 13:20:27 +0200
Subject: [PATCH] mtd: spi-nor: debugfs: fix format specifier

The intention was to print the JEDEC ID in the following format:
  nn nn nn

In this case format specifier has to be "%*ph". Fix it.

Fixes: 0257be79fc4a ("mtd: spi-nor: expose internal parameters via debugfs")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Link: https://lore.kernel.org/r/20220512112027.3771734-1-michael@walle.cc
---
 drivers/mtd/spi-nor/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index 1949905eefea..eaf84f7a0676 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -81,7 +81,7 @@ static int spi_nor_params_show(struct seq_file *s, void *data)
 	int i;
 
 	seq_printf(s, "name\t\t%s\n", info->name);
-	seq_printf(s, "id\t\t%*phn\n", info->id_len, info->id);
+	seq_printf(s, "id\t\t%*ph\n", info->id_len, info->id);
 	string_get_size(params->size, 1, STRING_UNITS_2, buf, sizeof(buf));
 	seq_printf(s, "size\t\t%s\n", buf);
 	seq_printf(s, "write size\t%u\n", params->writesize);

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
