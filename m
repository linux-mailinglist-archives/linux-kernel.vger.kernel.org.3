Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9860C4E3411
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiCUXVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiCUXVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:21:38 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2028B3E19E2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:13:13 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E8E4C22175;
        Tue, 22 Mar 2022 00:13:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647904391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d0xza72s8F6FNg0Fbb13ObxsvTsGPI8FF+13zzU0Pw8=;
        b=nfMtUOaRQPS1Ku1VXu9uHdN9PTrsF1hUFzWgRmsANEgXjQid3k3utpd0swizN13G1V6PGS
        2oaq9WN2xDhCspOwbkBP6KRpL8kSeOtFfR5FXByNiJl7Hy5QKzWsjbEErEA47eo8TqCO5Z
        v2Sw+iH/lL/i3hO4Q5HhVfAq/VXWo0U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Mar 2022 00:13:10 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 6/8] mtd: spi-nor: core: Add helpers to read/write any
 register
In-Reply-To: <20220228111712.111737-7-tudor.ambarus@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-7-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f3dcb594fbf512faa33361b8bfc7b98f@walle.cc>
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

Am 2022-02-28 12:17, schrieb Tudor Ambarus:
> There are manufacturers that use registers indexed by address. Some of
> them support "read/write any register" opcodes. Provide core methods 
> that
> can be used by all manufacturers. SPI NOR controller ops are 
> intentionally
> not supported as we intend to move all the SPI NOR controller drivers
> under the SPI subsystem.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/mtd/spi-nor/core.c | 41 ++++++++++++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/core.h |  4 ++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 281e3d25f74c..f1aa1e2ea7c9 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -307,6 +307,47 @@ ssize_t spi_nor_write_data(struct spi_nor *nor,
> loff_t to, size_t len,
>  	return nor->controller_ops->write(nor, to, len, buf);
>  }
> 
> +/**
> + * spi_nor_read_reg() - read register to flash memory
> + * @nor:        pointer to 'struct spi_nor'.
> + * @op:		SPI memory operation. op->data.buf must be DMA-able.
> + * @proto:	SPI protocol to use for the register operation.
> + *
> + * Return: zero on success, -errno otherwise
> + */
> +int spi_nor_read_reg(struct spi_nor *nor, struct spi_mem_op *op,
> +		     enum spi_nor_protocol proto)
> +{
> +	if (!nor->spimem)
> +		return -EOPNOTSUPP;
> +
> +	spi_nor_spimem_setup_op(nor, op, proto);
> +	return spi_nor_spimem_exec_op(nor, op);
> +}
> +
> +/**
> + * spi_nor_write_reg() - write register to flash memory
> + * @nor:        pointer to 'struct spi_nor'
> + * @op:		SPI memory operation. op->data.buf must be DMA-able.
> + * @proto:	SPI protocol to use for the register operation.
> + *
> + * Return: zero on success, -errno otherwise
> + */
> +int spi_nor_write_reg(struct spi_nor *nor, struct spi_mem_op *op,
> +		      enum spi_nor_protocol proto)
> +{
> +	int ret;
> +
> +	if (!nor->spimem)
> +		return -EOPNOTSUPP;
> +
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +	spi_nor_spimem_setup_op(nor, op, proto);
> +	return spi_nor_spimem_exec_op(nor, op);
> +}
> +
>  /**
>   * spi_nor_write_enable() - Set write enable latch with Write Enable 
> command.
>   * @nor:	pointer to 'struct spi_nor'.
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index f952061d5c24..7c704475946d 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -554,6 +554,10 @@ ssize_t spi_nor_read_data(struct spi_nor *nor,
> loff_t from, size_t len,
>  			  u8 *buf);
>  ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>  			   const u8 *buf);
> +int spi_nor_read_reg(struct spi_nor *nor, struct spi_mem_op *op,
> +		     enum spi_nor_protocol proto);
> +int spi_nor_write_reg(struct spi_nor *nor, struct spi_mem_op *op,
> +		      enum spi_nor_protocol proto);

These look rather odd. I'd expect to see an address and such for
such a "random register read/write". Looks like these functions
don't do much except calling spi_nor_spimem_setup_op() and
exec_op() and don't have anything to do with register access
(except maybe for the write enable). Can't we have a bit more
sophisticated interface in the core? Something that calls into
the flash driver to assemble the spi_mem_op automatically? Assuming
that this will be used more often to access registers in a flash.

-michael

>  int spi_nor_erase_sector(struct spi_nor *nor, u32 addr);
> 
>  int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t
> len, u8 *buf);
