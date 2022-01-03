Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BFC482FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiACKBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:01:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45688 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiACKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:01:16 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AE1671F42012;
        Mon,  3 Jan 2022 10:01:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641204075;
        bh=Et8b/NcDRigM3tyqehgdl2dIO/mVrkHqSosk15k/ruQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gAf+AtMEzFaBQsOUdcibMaW/XktN1eaKqje+RtV/YVZLtGk2DA5jq/9xxFKpf6XtS
         9hqS/h0Eba2zuxmbDri6qSZ4jpP2PRnDUtD02kyB8YbHJyF3C6WaKARFHWbggUhiS+
         LE7rvUNex1su0mV01CtcyLqFp8yowBWO6zEh8ec2NamwI4ycodXynN5MjIIia/7oiC
         +Dk+5ZeX91gz4fVTUhOx2hVUayLnw0HzHUN3xVK1ctvnyPWmGwvwLecOtaUNp/g4gF
         pewNrVkSvo2xkW3VP6CeFuKJaPUVM/YCsBPadTJR3KBnLQeat8AmfC9roA6Cyl1uh0
         ADAKosqTLwalw==
Date:   Mon, 3 Jan 2022 11:01:07 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>
Subject: Re: [PATCH v3 05/17] mtd: spinand: Define ctrl_ops for non-page
 read/write op templates
Message-ID: <20220103110107.45594e78@collabora.com>
In-Reply-To: <20220101074250.14443-6-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-6-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jan 2022 13:12:38 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> 'ctrl_ops' are op templates for non-page read/write operations,
> which are: reset, get_feature, set_feature, write_enable, block_erase,
> page_read and program_execute ops. The 'ctrl_ops' struct contains in it
> op templates for each of this op, as well as enum spinand_protocol
> denoting protocol of all these ops.
> 
> We require these new op templates because of deviation in standard
> SPINAND ops by manufacturers and also due to changes when there is a
> change in SPI protocol/mode. This prevents the core from live-patching
> and vendor-specific adjustments in ops.
> 
> Define 'ctrl_ops', add macros to initialize it and add it in
> spinand_device.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  include/linux/mtd/spinand.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 439d8ce40e1d..e5df6220ec1e 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -356,6 +356,35 @@ struct spinand_op_variants {
>  			sizeof(struct spi_mem_op),			\
>  	}
>  
> +struct spinand_ctrl_ops {
> +	const struct {
> +		struct spi_mem_op reset;
> +		struct spi_mem_op get_feature;
> +		struct spi_mem_op set_feature;
> +		struct spi_mem_op write_enable;
> +		struct spi_mem_op block_erase;
> +		struct spi_mem_op page_read;
> +		struct spi_mem_op program_execute;
> +	} ops;
> +	const enum spinand_protocol protocol;

Do you really need that protocol field?

> +};
> +
> +#define SPINAND_CTRL_OPS(__protocol, __reset, __get_feature, __set_feature,	\
> +			 __write_enable, __block_erase, __page_read,		\
> +			 __program_execute)					\
> +	{									\
> +		.ops = {							\
> +			.reset = __reset,					\
> +			.get_feature = __get_feature,				\
> +			.set_feature = __set_feature,				\
> +			.write_enable = __write_enable,				\
> +			.block_erase = __block_erase,				\
> +			.page_read = __page_read,				\
> +			.program_execute = __program_execute,			\
> +		},								\
> +		.protocol = __protocol,						\
> +	}
> +
>  /**
>   * spinand_ecc_info - description of the on-die ECC implemented by a SPI NAND
>   *		      chip
> @@ -468,6 +497,8 @@ struct spinand_dirmap {
>   * @data_ops.read_cache: read cache op template
>   * @data_ops.write_cache: write cache op template
>   * @data_ops.update_cache: update cache op template
> + * @ctrl_ops: various SPI mem op templates for handling the flash device, i.e.
> + *	      non page-read/write ops.
>   * @select_target: select a specific target/die. Usually called before sending
>   *		   a command addressing a page or an eraseblock embedded in
>   *		   this die. Only required if your chip exposes several dies
> @@ -498,6 +529,8 @@ struct spinand_device {
>  		const struct spi_mem_op *update_cache;
>  	} data_ops;
>  
> +	const struct spinand_ctrl_ops *ctrl_ops;
> +

Okay, I had something slightly different in mind. First, I'd put all
templates in a struct:

struct spinand_op_templates {
	const struct spi_mem_op *read_cache;
	const struct spi_mem_op *write_cache;
	const struct spi_mem_op *update_cache;
	const struct spi_mem_op *reset;
	const struct spi_mem_op *get_feature;
	const struct spi_mem_op *set_feature;
	const struct spi_mem_op *write_enable;
	const struct spi_mem_op *block_erase;
	const struct spi_mem_op *page_load;
	const struct spi_mem_op *program_execute;
};

Then, at the spinand level, I'd define an array of templates:

enum spinand_protocol {
	SPINAND_1S_1S_1S,
	SPINAND_2S_2S_2S,
	SPINAND_4S_4S_4S,
	SPINAND_8S_8S_8S,
	SPINAND_8D_8D_8D,
	SPINAND_NUM_PROTOCOLS,
};

struct spinand_device {
	...
	enum spinand_protocol protocol;
	const struct spinand_op_templates *op_templates[SPINAND_NUM_PROTOCOLS];
	...
};

This way, you can easily pick the right set of operations based
on the protocol/mode you're in:

#define spinand_get_op_template(spinand, opname) \
	((spinand)->op_templates[(spinand)->protocol]->opname)

static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
{
	struct spi_mem_op op = *spinand_get_op_template(spinand, get_feature);
	int ret;

	...
}
