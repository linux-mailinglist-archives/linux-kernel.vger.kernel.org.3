Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF62F5141A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbiD2FBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiD2FBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:01:08 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4F4DF79
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:57:49 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23T4vXBG005471;
        Thu, 28 Apr 2022 23:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651208253;
        bh=0TEme5eDbaOmRzD/F/IiJHrzxTY/gXFTqT4rl9ovOyw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qKtvVzBfTQi1uGFBbzfeNT1pQm2NlPcJIScDCIqwxLXI101QMV++jdfQnGmvpXWyS
         a1ZvtUpdMa0KjnOkV+7pYUZzvxsb4s8EoG+w/ZwTEeLunnSp68PpwNP3WjzvYPQJ8e
         gSzMqYCUEKi4KFwAS6nT62kcECv5y5E1RCnRQ5nU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23T4vXjb019774
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Apr 2022 23:57:33 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 28
 Apr 2022 23:57:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 28 Apr 2022 23:57:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23T4vWFE097281;
        Thu, 28 Apr 2022 23:57:32 -0500
Date:   Fri, 29 Apr 2022 10:27:31 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: expose internal parameters via
 debugfs
Message-ID: <20220429045731.sjhlkyxfxw4zvfxt@ti.com>
References: <20220428122840.1496876-1-michael@walle.cc>
 <20220428122840.1496876-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220428122840.1496876-2-michael@walle.cc>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 28/04/22 02:28PM, Michael Walle wrote:
> There is no way to gather all information to verify support for a new
> flash chip. Also if you want to convert an existing flash chip to the
> new SFDP parsing, there is not enough information to determine if the
> flash will work like before. To ease this development, expose internal
> parameters via the debugfs.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since rfc (v1):
>  - rebase onto latest next
>  - drop spi_nor_debugfs_unregister() and use devm_add_action() instead
>  - output style fixes, (0x prefix, whitespace around '|')
> 
>  drivers/mtd/spi-nor/Makefile  |   1 +
>  drivers/mtd/spi-nor/core.c    |   2 +
>  drivers/mtd/spi-nor/core.h    |   6 +
>  drivers/mtd/spi-nor/debugfs.c | 248 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h   |   2 +
>  5 files changed, 259 insertions(+)
>  create mode 100644 drivers/mtd/spi-nor/debugfs.c
> 
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 6b904e439372..e347b435a038 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -17,6 +17,7 @@ spi-nor-objs			+= sst.o
>  spi-nor-objs			+= winbond.o
>  spi-nor-objs			+= xilinx.o
>  spi-nor-objs			+= xmc.o
> +spi-nor-$(CONFIG_DEBUG_FS)	+= debugfs.o
>  obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
>  
>  obj-$(CONFIG_MTD_SPI_NOR)	+= controllers/
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index dd2ead5ebe9f..9cf058d617a1 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3157,6 +3157,8 @@ static int spi_nor_probe(struct spi_mem *spimem)
>  	if (ret)
>  		return ret;
>  
> +	spi_nor_debugfs_register(nor);
> +
>  	/*
>  	 * None of the existing parts have > 512B pages, but let's play safe
>  	 * and add this logic so that if anyone ever adds support for such
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 74fc32067a32..078645ffd987 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -705,4 +705,10 @@ static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
>  	return container_of(mtd, struct spi_nor, mtd);
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +void spi_nor_debugfs_register(struct spi_nor *nor);
> +#else
> +static inline void spi_nor_debugfs_register(struct spi_nor *nor) {}
> +#endif
> +
>  #endif /* __LINUX_MTD_SPI_NOR_INTERNAL_H */
> diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
> new file mode 100644
> index 000000000000..2778733ed72c
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/debugfs.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/mtd/spi-nor.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +#include <linux/debugfs.h>
> +
> +#include "core.h"
> +
> +static struct dentry *rootdir;
> +
> +#define SNOR_F_NAME(name) [ilog2(SNOR_F_##name)] = #name
> +static const char *const snor_f_names[] = {
> +	SNOR_F_NAME(HAS_SR_TB),
> +	SNOR_F_NAME(NO_OP_CHIP_ERASE),
> +	SNOR_F_NAME(BROKEN_RESET),
> +	SNOR_F_NAME(4B_OPCODES),
> +	SNOR_F_NAME(HAS_4BAIT),
> +	SNOR_F_NAME(HAS_LOCK),
> +	SNOR_F_NAME(HAS_16BIT_SR),
> +	SNOR_F_NAME(NO_READ_CR),
> +	SNOR_F_NAME(HAS_SR_TB_BIT6),
> +	SNOR_F_NAME(HAS_4BIT_BP),
> +	SNOR_F_NAME(HAS_SR_BP3_BIT6),
> +	SNOR_F_NAME(IO_MODE_EN_VOLATILE),
> +	SNOR_F_NAME(SOFT_RESET),
> +	SNOR_F_NAME(SWP_IS_VOLATILE),
> +};
> +#undef SNOR_F_NAME

You said you would add a comment here. Changed your mind?

> +
> +static const char *spi_nor_protocol_name(enum spi_nor_protocol proto)
> +{
> +	switch (proto) {
> +	case SNOR_PROTO_1_1_1:     return "1S-1S-1S";
> +	case SNOR_PROTO_1_1_2:     return "1S-1S-2S";
> +	case SNOR_PROTO_1_1_4:     return "1S-1S-4S";
> +	case SNOR_PROTO_1_1_8:     return "1S-1S-8S";
> +	case SNOR_PROTO_1_2_2:     return "1S-2S-2S";
> +	case SNOR_PROTO_1_4_4:     return "1S-4S-4S";
> +	case SNOR_PROTO_1_8_8:     return "1S-8S-8S";
> +	case SNOR_PROTO_2_2_2:     return "2S-2S-2S";
> +	case SNOR_PROTO_4_4_4:     return "4S-4S-4S";
> +	case SNOR_PROTO_8_8_8:     return "8S-8S-8S";
> +	case SNOR_PROTO_1_1_1_DTR: return "1D-1D-1D";
> +	case SNOR_PROTO_1_2_2_DTR: return "1D-2D-2D";
> +	case SNOR_PROTO_1_4_4_DTR: return "1D-4D-4D";
> +	case SNOR_PROTO_1_8_8_DTR: return "1D-8D-8D";
> +	case SNOR_PROTO_8_8_8_DTR: return "8D-8D-8D";
> +	}
> +
> +	return "<unknown>";
> +}
> +
[...]
> +
> +static void spi_nor_debugfs_unregister(void *data)
> +{
> +	struct spi_nor *nor = data;
> +
> +	debugfs_remove(nor->debugfs_root);
> +	nor->debugfs_root = NULL;
> +}
> +
> +void spi_nor_debugfs_register(struct spi_nor *nor)
> +{
> +	struct dentry *d;
> +	int ret;
> +
> +	/* Create rootdir once. Will never be deleted again. */
> +	if (!rootdir)
> +		rootdir = debugfs_create_dir("spi-nor", NULL);

If I compile SPI NOR as module, I insmod it, rmmod it, and then insmod 
it again, I get:

	[  360.623465] spi-nor spi0.0: mt35xu512aba (65536 Kbytes)
	[  360.623478] debugfs: Directory 'spi-nor' with parent '/' already present!
	[  360.632237] spi-nor spi1.0: mt25qu512a (65536 Kbytes)

I guess when you remove the module, rootdir also gets destroyed, and 
then gets re-initialized on probing again. I am not familiar enough with 
the debugfs APIs to suggest a fix though.

Patch looks good to me otherwise.

> +
> +	ret = devm_add_action(nor->dev, spi_nor_debugfs_unregister, nor);
> +	if (ret)
> +		return;
> +
> +	d = debugfs_create_dir(dev_name(nor->dev), rootdir);
> +	nor->debugfs_root = d;
> +
> +	debugfs_create_file("params", 0444, d, nor, &spi_nor_params_fops);
> +	debugfs_create_file("capabilities", 0444, d, nor,
> +			    &spi_nor_capabilities_fops);
> +}
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 5e25a7b75ae2..7d43447768ee 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -365,6 +365,7 @@ struct spi_nor_flash_parameter;
>   * @write_proto:	the SPI protocol for write operations
>   * @reg_proto:		the SPI protocol for read_reg/write_reg/erase operations
>   * @sfdp:		the SFDP data of the flash
> + * @debugfs_root:	pointer to the debugfs directory
>   * @controller_ops:	SPI NOR controller driver specific operations.
>   * @params:		[FLASH-SPECIFIC] SPI NOR flash parameters and settings.
>   *                      The structure includes legacy flash parameters and
> @@ -394,6 +395,7 @@ struct spi_nor {
>  	u32			flags;
>  	enum spi_nor_cmd_ext	cmd_ext_type;
>  	struct sfdp		*sfdp;
> +	struct dentry		*debugfs_root;
>  
>  	const struct spi_nor_controller_ops *controller_ops;
>  
> -- 
> 2.30.2
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
