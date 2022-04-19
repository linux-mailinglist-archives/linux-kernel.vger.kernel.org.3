Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F237A506B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351852AbiDSLsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351896AbiDSLsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:48:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541B2B198
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:45:33 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5505F2223A;
        Tue, 19 Apr 2022 13:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650368731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SPcEUcZ+YawrMSu3hoigcoMiMVmg9Z0F3USI6yNgGY=;
        b=uHsVX957RM6NxNVO7GGvp2lWbPzzK+2KNgU0Kjy650PlXcteHBX1Yx8Qe3pwWeXM5t54+U
        5fr6dpTvWPFeZHNiHfZaQoPAt2bxlTEjPVsSQ2Hw6wNn2x4fBzR+pJd4ecWndmduSC8ezh
        NrEXLZFmXepLrxg3vA7eYvydWRKOy88=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Apr 2022 13:45:31 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 9/9] mtd: spi-nor: Introduce templates for SPI NOR
 operations
In-Reply-To: <20220411091033.98754-10-tudor.ambarus@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-10-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d912d9834a219162ef46efad7d332ef3@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-11 11:10, schrieb Tudor Ambarus:
> Clean the op declaration and hide the details of each op. With this it
> results a cleanner, easier to read code. No functional change expected.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

I haven't gone through all of it.

Acked-by: Michael Walle <michael@walle.cc>

> ---
> v3: new patch taken from, no changes
> https://lore.kernel.org/lkml/20220304093011.198173-1-tudor.ambarus@microchip.com/
> 
>  drivers/mtd/spi-nor/core.c      | 101 ++++++-------------------------
>  drivers/mtd/spi-nor/core.h      | 102 ++++++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/micron-st.c |  24 ++++----
>  drivers/mtd/spi-nor/spansion.c  |  26 +++++---
>  drivers/mtd/spi-nor/xilinx.c    |  12 ++--
>  5 files changed, 158 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 42794328d3b6..fe853532204c 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -359,11 +359,7 @@ int spi_nor_write_enable(struct spi_nor *nor)
>  	int ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_NO_DATA);
> +		struct spi_mem_op op = SPI_NOR_WREN_OP;
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -390,11 +386,7 @@ int spi_nor_write_disable(struct spi_nor *nor)
>  	int ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_NO_DATA);
> +		struct spi_mem_op op = SPI_NOR_WRDI_OP;
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -454,11 +446,7 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
>  	int ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, sr, 0));
> +		struct spi_mem_op op = SPI_NOR_RDSR_OP(sr);
> 
>  		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
>  			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
> @@ -498,11 +486,7 @@ int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
>  	int ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, cr, 0));
> +		struct spi_mem_op op = SPI_NOR_RDCR_OP(cr);
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -531,14 +515,7 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor
> *nor, bool enable)
>  	int ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(enable ?
> -						  SPINOR_OP_EN4B :
> -						  SPINOR_OP_EX4B,
> -						  0),
> -				  SPI_MEM_OP_NO_ADDR,
> -				  SPI_MEM_OP_NO_DUMMY,
> -				  SPI_MEM_OP_NO_DATA);
> +		struct spi_mem_op op = SPI_NOR_EN4B_EX4B_OP(enable);
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -572,11 +549,7 @@ static int spansion_set_4byte_addr_mode(struct
> spi_nor *nor, bool enable)
>  	nor->bouncebuf[0] = enable << 7;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_BRWR, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 0));
> +		struct spi_mem_op op = SPI_NOR_BRWR_OP(nor->bouncebuf);
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -606,11 +579,7 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
>  	nor->bouncebuf[0] = ear;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 0));
> +		struct spi_mem_op op = SPI_NOR_WREAR_OP(nor->bouncebuf);
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -721,11 +690,7 @@ int spi_nor_global_block_unlock(struct spi_nor 
> *nor)
>  		return ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_GBULK, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_NO_DATA);
> +		struct spi_mem_op op = SPI_NOR_GBULK_OP;
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -760,11 +725,7 @@ int spi_nor_write_sr(struct spi_nor *nor, const
> u8 *sr, size_t len)
>  		return ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(len, sr, 0));
> +		struct spi_mem_op op = SPI_NOR_WRSR_OP(sr, len);
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -964,11 +925,7 @@ static int spi_nor_write_sr2(struct spi_nor *nor,
> const u8 *sr2)
>  		return ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(1, sr2, 0));
> +		struct spi_mem_op op = SPI_NOR_WRSR2_OP(sr2);
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -1000,11 +957,7 @@ static int spi_nor_read_sr2(struct spi_nor *nor, 
> u8 *sr2)
>  	int ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, sr2, 0));
> +		struct spi_mem_op op = SPI_NOR_RDSR2_OP(sr2);
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -1033,11 +986,7 @@ static int spi_nor_erase_chip(struct spi_nor 
> *nor)
>  	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CHIP_ERASE, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_NO_DATA);
> +		struct spi_mem_op op = SPI_NOR_CHIP_ERASE_OP;
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
> 
> @@ -1179,10 +1128,8 @@ int spi_nor_erase_sector(struct spi_nor *nor, 
> u32 addr)
> 
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->erase_opcode, 0),
> -				   SPI_MEM_OP_ADDR(nor->addr_width, addr, 0),
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_NO_DATA);
> +			SPI_NOR_SECTOR_ERASE_OP(nor->erase_opcode,
> +						nor->addr_width, addr);
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
> 
> @@ -1978,10 +1925,7 @@ static int spi_nor_spimem_check_op(struct 
> spi_nor *nor,
>  static int spi_nor_spimem_check_readop(struct spi_nor *nor,
>  				       const struct spi_nor_read_command *read)
>  {
> -	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(read->opcode, 0),
> -					  SPI_MEM_OP_ADDR(3, 0, 0),
> -					  SPI_MEM_OP_DUMMY(1, 0),
> -					  SPI_MEM_OP_DATA_IN(2, NULL, 0));
> +	struct spi_mem_op op = SPI_NOR_READ_OP(read->opcode);
> 
>  	spi_nor_spimem_setup_op(nor, &op, read->proto);
> 
> @@ -2004,10 +1948,7 @@ static int spi_nor_spimem_check_readop(struct
> spi_nor *nor,
>  static int spi_nor_spimem_check_pp(struct spi_nor *nor,
>  				   const struct spi_nor_pp_command *pp)
>  {
> -	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(pp->opcode, 0),
> -					  SPI_MEM_OP_ADDR(3, 0, 0),
> -					  SPI_MEM_OP_NO_DUMMY,
> -					  SPI_MEM_OP_DATA_OUT(2, NULL, 0));
> +	struct spi_mem_op op = SPI_NOR_PP_OP(pp->opcode);
> 
>  	spi_nor_spimem_setup_op(nor, &op, pp->proto);
> 
> @@ -2831,10 +2772,7 @@ static void spi_nor_soft_reset(struct spi_nor 
> *nor)
>  	struct spi_mem_op op;
>  	int ret;
> 
> -	op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRSTEN, 
> 0),
> -			SPI_MEM_OP_NO_DUMMY,
> -			SPI_MEM_OP_NO_ADDR,
> -			SPI_MEM_OP_NO_DATA);
> +	op = (struct spi_mem_op)SPINOR_SRSTEN_OP;
> 
>  	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> @@ -2844,10 +2782,7 @@ static void spi_nor_soft_reset(struct spi_nor 
> *nor)
>  		return;
>  	}
> 
> -	op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRST, 0),
> -			SPI_MEM_OP_NO_DUMMY,
> -			SPI_MEM_OP_NO_ADDR,
> -			SPI_MEM_OP_NO_DATA);
> +	op = (struct spi_mem_op)SPINOR_SRST_OP;
> 
>  	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 7c704475946d..8b7e597fd38c 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -18,6 +18,108 @@
>  		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
>  		   SPI_MEM_OP_DATA_IN(len, buf, 0))
> 
> +#define SPI_NOR_WREN_OP							\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_NO_DATA)
> +
> +#define SPI_NOR_WRDI_OP							\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_NO_DATA)
> +
> +#define SPI_NOR_RDSR_OP(buf)						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_IN(1, buf, 0))
> +
> +#define SPI_NOR_WRSR_OP(buf, len)					\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(len, buf, 0))
> +
> +#define SPI_NOR_RDSR2_OP(buf)						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
> +
> +#define SPI_NOR_WRSR2_OP(buf)						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
> +
> +#define SPI_NOR_RDCR_OP(buf)						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_IN(1, buf, 0))
> +
> +#define SPI_NOR_EN4B_EX4B_OP(enable)					\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B, 
> 0),	\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_NO_DATA)
> +
> +#define SPI_NOR_BRWR_OP(buf)						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_BRWR, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
> +
> +#define SPI_NOR_WREAR_OP(buf)						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
> +
> +#define SPI_NOR_GBULK_OP						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_GBULK, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_NO_DATA)
> +
> +#define SPI_NOR_CHIP_ERASE_OP						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CHIP_ERASE, 0),		\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_NO_DATA)
> +
> +#define SPI_NOR_SECTOR_ERASE_OP(opcode, addr_width, addr)		\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),				\
> +		   SPI_MEM_OP_ADDR(addr_width, addr, 0),		\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_NO_DATA)
> +
> +#define SPI_NOR_READ_OP(opcode)						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),				\
> +		   SPI_MEM_OP_ADDR(3, 0, 0),				\
> +		   SPI_MEM_OP_DUMMY(1, 0),				\
> +		   SPI_MEM_OP_DATA_IN(2, NULL, 0))
> +
> +#define SPI_NOR_PP_OP(opcode)						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),				\
> +		   SPI_MEM_OP_ADDR(3, 0, 0),				\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(2, NULL, 0))
> +
> +#define SPINOR_SRSTEN_OP						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRSTEN, 0),			\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DATA)
> +
> +#define SPINOR_SRST_OP							\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRST, 0),			\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DATA)
> +
>  enum spi_nor_option_flags {
>  	SNOR_F_HAS_SR_TB	= BIT(0),
>  	SNOR_F_NO_OP_CHIP_ERASE	= BIT(1),
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index a447762c0d78..26b9a1c2309d 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -35,6 +35,18 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
> 
> +#define MICRON_ST_RDFSR_OP(buf)						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_IN(1, buf, 0))
> +
> +#define MICRON_ST_CLFSR_OP						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_NO_DATA)
> +
>  static int micron_st_nor_octal_dtr_en(struct spi_nor *nor)
>  {
>  	struct spi_mem_op op;
> @@ -324,11 +336,7 @@ static int micron_st_nor_read_fsr(struct spi_nor
> *nor, u8 *fsr)
>  	int ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, fsr, 0));
> +		struct spi_mem_op op = MICRON_ST_RDFSR_OP(fsr);
> 
>  		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
>  			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
> @@ -363,11 +371,7 @@ static void micron_st_nor_clear_fsr(struct spi_nor 
> *nor)
>  	int ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_NO_DATA);
> +		struct spi_mem_op op = MICRON_ST_CLFSR_OP;
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c 
> b/drivers/mtd/spi-nor/spansion.c
> index 35d8edb515a3..952db7af6932 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -30,6 +30,18 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
> 
> +#define CYPRESS_NOR_RD_ANY_REG_OP(naddr, addr, buf)			\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 0),		\
> +		   SPI_MEM_OP_ADDR(naddr, addr, 0),			\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_IN(1, buf, 0))
> +
> +#define SPANSION_CLSR_OP						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_NO_DATA)
> +
>  static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
>  {
>  	struct spi_mem_op op;
> @@ -165,12 +177,12 @@ static int s28hs512t_post_bfpt_fixup(struct 
> spi_nor *nor,
>  	 * CFR3V[4] and set the correct size.
>  	 */
>  	struct spi_mem_op op =
> -		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
> -			   SPI_MEM_OP_ADDR(3, SPINOR_REG_CYPRESS_CFR3V, 1),
> -			   SPI_MEM_OP_NO_DUMMY,
> -			   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
> +		CYPRESS_NOR_RD_ANY_REG_OP(3, SPINOR_REG_CYPRESS_CFR3V,
> +					  nor->bouncebuf);
>  	int ret;
> 
> +	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> +
>  	ret = spi_mem_exec_op(nor->spimem, &op);
>  	if (ret)
>  		return ret;
> @@ -320,11 +332,7 @@ static void spansion_nor_clear_sr(struct spi_nor 
> *nor)
>  	int ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_NO_DATA);
> +		struct spi_mem_op op = SPANSION_CLSR_OP;
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> diff --git a/drivers/mtd/spi-nor/xilinx.c 
> b/drivers/mtd/spi-nor/xilinx.c
> index 9459ac2609dc..1d2f5db047bd 100644
> --- a/drivers/mtd/spi-nor/xilinx.c
> +++ b/drivers/mtd/spi-nor/xilinx.c
> @@ -15,6 +15,12 @@
>  #define XSR_PAGESIZE		BIT(0)	/* Page size in Po2 or Linear */
>  #define XSR_RDY			BIT(7)	/* Ready */
> 
> +#define XILINX_RDSR_OP(buf)						\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(XILINX_OP_RDSR, 0),			\
> +		   SPI_MEM_OP_NO_ADDR,					\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_IN(1, buf, 0))
> +
>  #define S3AN_INFO(_jedec_id, _n_sectors, _page_size)			\
>  		.id = {							\
>  			((_jedec_id) >> 16) & 0xff,			\
> @@ -72,11 +78,7 @@ static int xilinx_nor_read_sr(struct spi_nor *nor, 
> u8 *sr)
>  	int ret;
> 
>  	if (nor->spimem) {
> -		struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(XILINX_OP_RDSR, 0),
> -				   SPI_MEM_OP_NO_ADDR,
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, sr, 0));
> +		struct spi_mem_op op = XILINX_RDSR_OP(sr);
> 
>  		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);

-- 
-michael
