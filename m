Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961AC482FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiACKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiACKO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:14:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530DDC061761;
        Mon,  3 Jan 2022 02:14:28 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7F73B1F41D7C;
        Mon,  3 Jan 2022 10:14:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641204867;
        bh=IMW6UvrrsgagYb5Hjy5wGh/54TACYyMTtsxIHHS9AYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WE0yu8Q+cWTkBgQFY7ZELdiZ1nUdqSOmBD9RJuQ59WzyL4BzHUxm3HkQevoooV8rp
         krJ6vbQRwlsTdty0xaDcIxvT3NqvyJm6RyvhGvMqOopvhxoj7xM0noKRW2XOmRHM0B
         el4c+mBl4AFVaZumsEZ2SGUUoa3WdYuUDINPA4pP/Dsm9hVMHRLLzJfHECLEGedoLV
         jdz8TGRtvx6gwHL17IGxSDsAtD2zvEM56om6C8I8mrX0Ztgrow+U6E4lHVTuvoRPFL
         r7jfmydo3hYe2dii4x2zEUw915z8GhOrKcHbK8blQM7DvgTM4CwO4GN9wc2S0F2j2n
         ByLvMUZu1YW7g==
Date:   Mon, 3 Jan 2022 11:14:23 +0100
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
Subject: Re: [PATCH v3 11/17] mtd: spinand: Allow enabling/disabling Octal
 DTR mode in the core
Message-ID: <20220103111423.5c2b72c9@collabora.com>
In-Reply-To: <20220101074250.14443-12-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-12-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jan 2022 13:12:44 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> Enable Octal DTR SPI mode, i.e. 8D-8D-8D mode, if the SPI NAND flash
> device supports it. Mixed OSPI (1S-1S-8S & 1S-8S-8S), mixed DTR modes
> (1S-1D-8D), etc. aren't supported yet.
> 
> The method to switch to Octal DTR SPI mode may vary across
> manufacturers. For example, for Winbond, it is enabled by writing
> values to the volatile configuration register. So, let the
> manufacturer's code have their own implementation for switching to
> Octal DTR SPI mode.
> 
> Check for the SPI NAND device's support for Octal DTR mode using
> spinand flags, and if the data_ops and ctrl_ops are 8D-8D-8D, call
> change_mode() manufacturer op. If the SPI controller doesn't
> supports these modes, the selected data_ops and ctrl_ops will
> prevent switching to the Octal DTR mode. And finally update the
> spinand protocol and ctrl_ops on success. Similarly, for disabling
> Octal DTR mode, call change_mode(), and update protocol and ctrl_ops.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 79 +++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h |  1 +
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 1a602e4dd6bd..2fd08085db6f 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1067,6 +1067,81 @@ spinand_select_ctrl_ops_variant(struct spinand_device *spinand,
>  	return NULL;
>  }
>  
> +static bool spinand_op_is_octal_dtr(const struct spi_mem_op *op)
> +{
> +	return  op->cmd.buswidth == 8 && op->cmd.dtr &&
> +		op->addr.buswidth == 8 && op->addr.dtr &&
> +		op->data.buswidth == 8 && op->data.dtr;
> +}
> +
> +static int spinand_init_octal_dtr_enable(struct spinand_device *spinand)
> +{
> +	struct device *dev = &spinand->spimem->spi->dev;
> +	const struct spinand_ctrl_ops *octal_dtr_ctrl_ops;
> +	int ret;
> +
> +	if (!(spinand->flags & SPINAND_HAS_OCTAL_DTR_BIT))
> +		return 0;
> +
> +	if (!(spinand_op_is_octal_dtr(spinand->data_ops.read_cache) &&
> +	      spinand_op_is_octal_dtr(spinand->data_ops.write_cache) &&
> +	      spinand_op_is_octal_dtr(spinand->data_ops.update_cache)))
> +		return 0;
> +
> +	octal_dtr_ctrl_ops = spinand_select_ctrl_ops_variant(spinand,
> +					spinand->desc_entry->ctrl_ops_variants,
> +					SPINAND_8D_8D_8D);
> +
> +	if (!octal_dtr_ctrl_ops)
> +		return 0;
> +
> +	if (!spinand->manufacturer->ops->change_mode) {
> +		dev_dbg(dev,
> +			"Missing ->change_mode(), unable to switch mode\n");
> +		return -EINVAL;

Looks like something that's worth printing at the info level, and I
think returning EOPNOTSUPP would be more appropriate.

> +	}
> +
> +	ret = spinand->manufacturer->ops->change_mode(spinand,
> +						      SPINAND_8D_8D_8D);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to enable Octal DTR SPI mode (err = %d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	spinand->protocol = SPINAND_8D_8D_8D;
> +	spinand->ctrl_ops = octal_dtr_ctrl_ops;
> +
> +	dev_dbg(dev,
> +		"%s SPI NAND switched to Octal DTR SPI (8D-8D-8D) mode\n",
> +		spinand->manufacturer->name);
> +	return 0;
> +}
> +
> +static int spinand_init_octal_dtr_disable(struct spinand_device *spinand)

This function is never used. I guess it should be called in the
suspend/shutdown path, at least.

> +{
> +	struct device *dev = &spinand->spimem->spi->dev;
> +	int ret;
> +
> +	if (!spinand->manufacturer->ops->change_mode)
> +		return -EINVAL;
> +
> +	ret = spinand->manufacturer->ops->change_mode(spinand,
> +						      SPINAND_1S_1S_1S);
> +
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to disable Octal DTR SPI mode (err = %d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	spinand->protocol = SPINAND_1S_1S_1S;
> +	spinand->ctrl_ops = &spinand_default_ctrl_ops;
> +	return 0;
> +}
> +
>  /**
>   * spinand_match_and_init() - Try to find a match between a device ID and an
>   *			      entry in a spinand_info table
> @@ -1203,6 +1278,10 @@ static int spinand_init_flash(struct spinand_device *spinand)
>  			break;
>  	}
>  
> +	ret = spinand_init_octal_dtr_enable(spinand);
> +	if (ret)
> +		return ret;
> +
>  	if (ret)
>  		spinand_manufacturer_cleanup(spinand);
>  
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index a8c071983a27..f12aa4516fab 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -417,6 +417,7 @@ struct spinand_ecc_info {
>  
>  #define SPINAND_HAS_QE_BIT		BIT(0)
>  #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
> +#define SPINAND_HAS_OCTAL_DTR_BIT	BIT(2)

Do we really need a new flag for this? Isn't the template op
initialization enough to reflect whether the NAND and controller can do
8DTR or not?

>  
>  /**
>   * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure

