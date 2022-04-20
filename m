Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3162850808F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350937AbiDTF0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiDTF0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:26:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E403B35DD7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:23:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23K5NbrJ038223;
        Wed, 20 Apr 2022 00:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650432217;
        bh=rFwevEypSSDlLRxZayU6YoEl3tm+CyBesGs27MNuqC4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DDGgGvbJjgxFmtWvGOdZ9WHZyWF33VCYYxitC9UJAUhetVWzEHNYr1JWQ7pcf9p00
         czhMg2V4dGhmk1jf4yl7QksdfkPaZy4gbSESZ786zJIMnPLHazJPWwOBtVrmPXtzw7
         BVBe9LK5cCQJep87hCmniIIpaK5zItqRhrfMqYRU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23K5Nbwk071873
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Apr 2022 00:23:37 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 20
 Apr 2022 00:23:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 20 Apr 2022 00:23:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23K5NauC070964;
        Wed, 20 Apr 2022 00:23:37 -0500
Date:   Wed, 20 Apr 2022 10:53:36 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v1 2/2] mtd: spi-nor: expose internal parameters via
 debugfs
Message-ID: <20220420052336.ixmk3spdowvprxmn@ti.com>
References: <20220418121044.2825448-1-michael@walle.cc>
 <20220418121044.2825448-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220418121044.2825448-2-michael@walle.cc>
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

On 18/04/22 02:10PM, Michael Walle wrote:
> There is no way to gather all information to verify support for a new
> flash chip. Also if you want to convert an existing flash chip to the
> new SFDP parsing, there is not enough information to determine if the
> flash will work like before. To ease this development, expose internal
> parameters via the debugfs.

A big +1 for this patch from me. I have too often added prints in the 
driver to find out all this information. This won't be very useful in 
case the probe fails, but I don't suppose we can do much about that.

> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/Makefile  |   1 +
>  drivers/mtd/spi-nor/core.c    |   4 +
>  drivers/mtd/spi-nor/core.h    |   8 ++
>  drivers/mtd/spi-nor/debugfs.c | 241 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h   |   2 +
>  5 files changed, 256 insertions(+)
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
> index 80d65cfcb88d..302331695d96 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3117,6 +3117,8 @@ static int spi_nor_probe(struct spi_mem *spimem)
>  	if (ret)
>  		return ret;
>  
> +	spi_nor_debugfs_register(nor);

I think you should register this after mtd_device_register() to be sure 
the probe would not fail with these debugfs entries still in place. Or 
clean up before returning errors in the code below. Otherwise access to 
the debugfs entires would cause you to access a nor struct that is no 
longer there.

> +
>  	/*
>  	 * None of the existing parts have > 512B pages, but let's play safe
>  	 * and add this logic so that if anyone ever adds support for such
> @@ -3148,6 +3150,8 @@ static int spi_nor_remove(struct spi_mem *spimem)
>  {
>  	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
>  
> +	spi_nor_debugfs_unregister(nor);
> +
>  	spi_nor_restore(nor);
>  
>  	/* Clean up MTD stuff. */
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 81c4bb7d3193..d042d745a1f6 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -589,4 +589,12 @@ static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
>  	return container_of(mtd, struct spi_nor, mtd);
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +void spi_nor_debugfs_register(struct spi_nor *nor);
> +void spi_nor_debugfs_unregister(struct spi_nor *nor);
> +#else
> +static inline void spi_nor_debugfs_register(struct spi_nor *nor) {}
> +static inline void spi_nor_debugfs_unregister(struct spi_nor *nor) {}
> +#endif
> +
>  #endif /* __LINUX_MTD_SPI_NOR_INTERNAL_H */
> diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
> new file mode 100644
> index 000000000000..61d6d90eda13
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/debugfs.c
> @@ -0,0 +1,241 @@
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

Huh, clever! Took me some time to get what this is doing. But I wonder 
if there is a way to do this so we don't have to update in 2 locations 
when adding a new flag. If not, please at least add a comment on enum 
spi_nor_option_flags to remind people to also add the flag here.

But I wonder if we really need this instead of doing just:

	static const char *snor_f_names[] = {
		"HAS_SR_TB",
		"NO_OP_CHIP_ERASE",
		...
	};

Since if we have to keep this and enum spi_nor_option_flags in sync, 
might as well keep things simple.

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

Okay. Though this reminds me that we have no way to specify mixed DTR 
modes like 1S-8D-8D. But that is a problem for another time.

> +	}
> +
> +	return "<unknown>";
> +}
> +
> +static void spi_nor_print_flags(struct seq_file *s, unsigned long flags,
> +				const char *const *names, int names_len)

Do you see a need to make this generic? Why not just use snor_f_names 
directly?

> +{
> +	bool sep = false;
> +	int i;
> +
> +	for (i = 0; i < sizeof(flags) * BITS_PER_BYTE; i++) {
> +		if (!(flags & BIT(i)))
> +			continue;
> +		if (sep)
> +			seq_puts(s, "|");

I have not tried running this yet, but I think putting spaces around the 
'|' would make things easier to read.

> +		sep = true;
> +		if (i < names_len && names[i])
> +			seq_puts(s, names[i]);
> +		else
> +			seq_printf(s, "1<<%d", i);

Okay, so this is in case we _don't_ keep snor_f_names in sync.

> +	}
> +}
> +
> +static int spi_nor_params_show(struct seq_file *s, void *data)
> +{
> +	struct spi_nor *nor = s->private;
> +	struct spi_nor_flash_parameter *params = nor->params;
> +	struct spi_nor_erase_map *erase_map = &params->erase_map;
> +	struct spi_nor_erase_region *region;
> +	const struct flash_info *info = nor->info;
> +	char buf[16], *str;
> +	int i;
> +
> +	seq_printf(s, "name\t\t%s\n", info->name);
> +	seq_printf(s, "id\t\t%*phN\n", info->id_len, nor->info->id);
> +	string_get_size(params->size, 1, STRING_UNITS_2, buf, sizeof(buf));
> +	seq_printf(s, "size\t\t%s\n", buf);
> +	seq_printf(s, "write size\t%u\n", params->writesize);
> +	seq_printf(s, "page size\t%u\n", params->page_size);
> +	seq_printf(s, "address width\t%u\n", nor->addr_width);
> +
> +	seq_puts(s, "flags\t\t");
> +	spi_nor_print_flags(s, nor->flags, snor_f_names, sizeof(snor_f_names));
> +	seq_puts(s, "\n");
> +
> +	seq_puts(s, "\nopcodes\n");
> +	seq_printf(s, " read\t\t%02x\n", nor->read_opcode);

Should you prefix hex numbers with "0x" to clarify their base? If 
someone sees opcode is 12 they might not be sure if this is in decimal 
or hex. I am not sure what the convention for this usually is, if there 
even is one. Same for other hex numbers printed below.

> +	seq_printf(s, "  dummy cycles\t%d\n", nor->read_dummy);
> +	seq_printf(s, " erase\t\t%02x\n", nor->erase_opcode);
> +	seq_printf(s, " program\t%02x\n", nor->program_opcode);
> +
> +	switch (nor->cmd_ext_type) {
> +	case SPI_NOR_EXT_NONE:
> +		str = "none";
> +		break;
> +	case SPI_NOR_EXT_REPEAT:
> +		str = "repeat";
> +		break;
> +	case SPI_NOR_EXT_INVERT:
> +		str = "invert";
> +		break;
> +	default:
> +		str = "<unknown>";
> +		break;
> +	}
> +	seq_printf(s, " 8D extension\t%s\n", str);

You might only want to print this if the flash is 8D capable to avoid 
confusion. But I am not sure how easy/difficult that would be, so I 
leave that up to you.

> +
> +	seq_puts(s, "\nprotocols\n");
> +	seq_printf(s, " read\t\t%s\n",
> +		   spi_nor_protocol_name(nor->read_proto));
> +	seq_printf(s, " write\t\t%s\n",
> +		   spi_nor_protocol_name(nor->write_proto));
> +	seq_printf(s, " register\t%s\n",
> +		   spi_nor_protocol_name(nor->reg_proto));
> +
> +	seq_puts(s, "\nerase commands\n");
> +	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
> +		struct spi_nor_erase_type *et = &erase_map->erase_type[i];
> +
> +		if (et->size) {
> +			string_get_size(et->size, 1, STRING_UNITS_2, buf,
> +					sizeof(buf));
> +			seq_printf(s, " %02x (%s) [%d]\n", et->opcode, buf, i);
> +		}
> +	}
> +
> +	if (!(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
> +		string_get_size(params->size, 1, STRING_UNITS_2, buf, sizeof(buf));
> +		seq_printf(s, " %02x (%s)\n", SPINOR_OP_CHIP_ERASE, buf);
> +	}
> +
> +	seq_puts(s, "\nsector map\n");
> +	seq_puts(s, " region              | erase mask | flags\n");
> +	seq_puts(s, " --------------------+------------+----------\n");
> +	for (region = erase_map->regions;
> +	     region;
> +	     region = spi_nor_region_next(region)) {
> +		u64 start = region->offset & ~SNOR_ERASE_FLAGS_MASK;
> +		u64 flags = region->offset & SNOR_ERASE_FLAGS_MASK;
> +		u64 end = start + region->size - 1;
> +
> +		seq_printf(s, " %08llx - %08llx |     [%c%c%c%c] | %s\n",
> +			   start, end,
> +			   flags & BIT(0) ? '0' : ' ',
> +			   flags & BIT(1) ? '1' : ' ',
> +			   flags & BIT(2) ? '2' : ' ',
> +			   flags & BIT(3) ? '3' : ' ',
> +			   flags & SNOR_OVERLAID_REGION ? "overlaid" : "");
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(spi_nor_params);
> +
> +static void spi_nor_print_read_cmd(struct seq_file *s, u32 cap,
> +				   struct spi_nor_read_command *cmd)
> +{
> +	seq_printf(s, "%s%s\n", spi_nor_protocol_name(cmd->proto),
> +		   cap == SNOR_HWCAPS_READ_FAST ? " (fast read)" : "");
> +	seq_printf(s, "  opcode\t%02x\n", cmd->opcode);
> +	seq_printf(s, "  mode cycles\t%02x\n", cmd->num_mode_clocks);
> +	seq_printf(s, "  dummy cycles\t%02x\n", cmd->num_wait_states);
> +}
> +
> +static void spi_nor_print_pp_cmd(struct seq_file *s,
> +				 struct spi_nor_pp_command *cmd)
> +{
> +	seq_printf(s, "%s\n", spi_nor_protocol_name(cmd->proto));
> +	seq_printf(s, "  opcode\t%02x\n", cmd->opcode);
> +}
> +
> +static int spi_nor_capabilities_show(struct seq_file *s, void *data)
> +{
> +	struct spi_nor *nor = s->private;
> +	struct spi_nor_flash_parameter *params = nor->params;
> +	u32 hwcaps = params->hwcaps.mask;
> +	int i, cmd;
> +
> +	seq_puts(s, "Supported read modes by the flash\n");
> +	for (i = 0; i < sizeof(hwcaps) * BITS_PER_BYTE; i++) {
> +		if (!(hwcaps & BIT(i)))
> +			continue;
> +
> +		cmd = spi_nor_hwcaps_read2cmd(BIT(i));
> +		if (cmd < 0)
> +			continue;
> +
> +		spi_nor_print_read_cmd(s, BIT(i), &params->reads[cmd]);
> +		hwcaps &= ~BIT(i);
> +	}
> +
> +	seq_puts(s, "\nSupported page program modes by the flash\n");
> +	for (i = 0; i < sizeof(hwcaps) * BITS_PER_BYTE; i++) {
> +		if (!(hwcaps & BIT(i)))
> +			continue;
> +
> +		cmd = spi_nor_hwcaps_pp2cmd(BIT(i));
> +		if (cmd < 0)
> +			continue;
> +
> +		spi_nor_print_pp_cmd(s, &params->page_programs[cmd]);
> +		hwcaps &= ~BIT(i);
> +	}
> +
> +	if (hwcaps)
> +		seq_printf(s, "\nunknown hwcaps %x\n", hwcaps);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(spi_nor_capabilities);
> +
> +void spi_nor_debugfs_register(struct spi_nor *nor)
> +{
> +	struct dentry *d;
> +
> +	/* Create rootdir once. Will never be deleted again. */
> +	if (!rootdir)
> +		rootdir = debugfs_create_dir("spi-nor", NULL);
> +
> +	d = debugfs_create_dir(dev_name(nor->dev), rootdir);
> +	nor->debugfs_root = d;
> +
> +	debugfs_create_file("params", 0444, d, nor, &spi_nor_params_fops);
> +	debugfs_create_file("capabilities", 0444, d, nor,
> +			    &spi_nor_capabilities_fops);
> +}
> +
> +void spi_nor_debugfs_unregister(struct spi_nor *nor)
> +{
> +	debugfs_remove(nor->debugfs_root);
> +	nor->debugfs_root = NULL;
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
