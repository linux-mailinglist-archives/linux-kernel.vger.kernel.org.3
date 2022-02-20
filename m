Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF44BCE5D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 13:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbiBTMHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 07:07:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBTMHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:07:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAC540E7E;
        Sun, 20 Feb 2022 04:07:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1E5CB80D44;
        Sun, 20 Feb 2022 12:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A244EC340E8;
        Sun, 20 Feb 2022 12:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645358845;
        bh=qIYqNkqbYg9a12Wje7xqZ23YRGPPYOaM6TBHWPMsTmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hXdd1RHH/37o9iwJYrMMk4SSFp7Gbzd/Bo81A3W/PeOocmOlGhd4g2ddemBYewlvW
         tB4EYbYNk0fHGGIMfjbjEyQtu+Z0EXTZ8+hiLrXMRz6tGIJoOtL2UTOAxjfyhTfohu
         jBGb9IbKpAe+5vGbqDz+beo7AUAJhHYbqOi54Jk5myhC8VJAvPeWl2spo0tINOc/Q3
         UDodrX/Yy5P/0F3iRD83KACA0phn4EgpxTmMfqrIl+G/Yjb8FUk5vwDWYTwrc8yWeR
         p14xGozYlNFR3lX7tQyjk62DA4Bs1z9tEPnPqyRlwQElkhdrybuFPECO3BlNVPgBIE
         521wxzM9ryKDA==
Date:   Sun, 20 Feb 2022 12:14:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/4] iio:frequency:admv1014: add support for ADMV1014
Message-ID: <20220220121414.48d7a3b6@jic23-huawei>
In-Reply-To: <20220215081216.67706-1-antoniu.miclaus@analog.com>
References: <20220215081216.67706-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 10:12:13 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV1014 is a silicon germanium (SiGe), wideband,
> microwave downconverter optimized for point to point microwave
> radio designs operating in the 24 GHz to 44 GHz frequency range.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu.

One really trivial point inline that I noticed whilst having 'one last look'.

I'll fix it up whilst applying but please check I didn't mess up!

Series applied to the togreg branch of iio.git and initially pushed out as
testing to let 0-day poke at it an see if it can find anything we missed.

Thanks,

Jonathan

> ---
> changes in v8:
>  - remove clk-provider header
>  drivers/iio/frequency/Kconfig    |  10 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv1014.c | 823 +++++++++++++++++++++++++++++++
>  3 files changed, 834 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv1014.c
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 2c9e0559e8a4..493221f42077 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -50,6 +50,16 @@ config ADF4371
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4371.
>  
> +config ADMV1014
> +	tristate "Analog Devices ADMV1014 Microwave Downconverter"
> +	depends on SPI && COMMON_CLK && 64BIT
> +	help
> +	  Say yes here to build support for Analog Devices ADMV1014
> +	  24 GHz to 44 GHz, Wideband, Microwave Downconverter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called admv1014.
> +
>  config ADRF6780
>          tristate "Analog Devices ADRF6780 Microwave Upconverter"
>          depends on SPI
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index ae3136c79202..5f0348e5eb53 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -7,4 +7,5 @@
>  obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
> +obj-$(CONFIG_ADMV1014) += admv1014.o
>  obj-$(CONFIG_ADRF6780) += adrf6780.o
> diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
> new file mode 100644
> index 000000000000..06a60c246161
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1014.c
> @@ -0,0 +1,823 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV1014 driver
> + *
> + * Copyright 2022 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/notifier.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +
> +/* ADMV1014 Register Map */
> +#define ADMV1014_REG_SPI_CONTROL		0x00
> +#define ADMV1014_REG_ALARM			0x01
> +#define ADMV1014_REG_ALARM_MASKS		0x02
> +#define ADMV1014_REG_ENABLE			0x03
> +#define ADMV1014_REG_QUAD			0x04
> +#define ADMV1014_REG_LO_AMP_PHASE_ADJUST1	0x05
> +#define ADMV1014_REG_MIXER			0x07
> +#define ADMV1014_REG_IF_AMP			0x08
> +#define ADMV1014_REG_IF_AMP_BB_AMP		0x09
> +#define ADMV1014_REG_BB_AMP_AGC			0x0A
> +#define ADMV1014_REG_VVA_TEMP_COMP		0x0B
> +
> +/* ADMV1014_REG_SPI_CONTROL Map */
> +#define ADMV1014_PARITY_EN_MSK			BIT(15)
> +#define ADMV1014_SPI_SOFT_RESET_MSK		BIT(14)
> +#define ADMV1014_CHIP_ID_MSK			GENMASK(11, 4)
> +#define ADMV1014_CHIP_ID			0x9
> +#define ADMV1014_REVISION_ID_MSK		GENMASK(3, 0)
> +
> +/* ADMV1014_REG_ALARM Map */
> +#define ADMV1014_PARITY_ERROR_MSK		BIT(15)
> +#define ADMV1014_TOO_FEW_ERRORS_MSK		BIT(14)
> +#define ADMV1014_TOO_MANY_ERRORS_MSK		BIT(13)
> +#define ADMV1014_ADDRESS_RANGE_ERROR_MSK	BIT(12)
> +
> +/* ADMV1014_REG_ENABLE Map */
> +#define ADMV1014_IBIAS_PD_MSK			BIT(14)
> +#define ADMV1014_P1DB_COMPENSATION_MSK		GENMASK(13, 12)
> +#define ADMV1014_IF_AMP_PD_MSK			BIT(11)
> +#define ADMV1014_QUAD_BG_PD_MSK			BIT(9)
> +#define ADMV1014_BB_AMP_PD_MSK			BIT(8)
> +#define ADMV1014_QUAD_IBIAS_PD_MSK		BIT(7)
> +#define ADMV1014_DET_EN_MSK			BIT(6)
> +#define ADMV1014_BG_PD_MSK			BIT(5)
> +
> +/* ADMV1014_REG_QUAD Map */
> +#define ADMV1014_QUAD_SE_MODE_MSK		GENMASK(9, 6)
> +#define ADMV1014_QUAD_FILTERS_MSK		GENMASK(3, 0)
> +
> +/* ADMV1014_REG_LO_AMP_PHASE_ADJUST1 Map */
> +#define ADMV1014_LOAMP_PH_ADJ_I_FINE_MSK	GENMASK(15, 9)
> +#define ADMV1014_LOAMP_PH_ADJ_Q_FINE_MSK	GENMASK(8, 2)
> +
> +/* ADMV1014_REG_MIXER Map */
> +#define ADMV1014_MIXER_VGATE_MSK		GENMASK(15, 9)
> +#define ADMV1014_DET_PROG_MSK			GENMASK(6, 0)
> +
> +/* ADMV1014_REG_IF_AMP Map */
> +#define ADMV1014_IF_AMP_COARSE_GAIN_I_MSK	GENMASK(11, 8)
> +#define ADMV1014_IF_AMP_FINE_GAIN_Q_MSK		GENMASK(7, 4)
> +#define ADMV1014_IF_AMP_FINE_GAIN_I_MSK		GENMASK(3, 0)
> +
> +/* ADMV1014_REG_IF_AMP_BB_AMP Map */
> +#define ADMV1014_IF_AMP_COARSE_GAIN_Q_MSK	GENMASK(15, 12)
> +#define ADMV1014_BB_AMP_OFFSET_Q_MSK		GENMASK(9, 5)
> +#define ADMV1014_BB_AMP_OFFSET_I_MSK		GENMASK(4, 0)
> +
> +/* ADMV1014_REG_BB_AMP_AGC Map */
> +#define ADMV1014_BB_AMP_REF_GEN_MSK		GENMASK(6, 3)
> +#define ADMV1014_BB_AMP_GAIN_CTRL_MSK		GENMASK(2, 1)
> +#define ADMV1014_BB_SWITCH_HIGH_LOW_CM_MSK	BIT(0)
> +
> +/* ADMV1014_REG_VVA_TEMP_COMP Map */
> +#define ADMV1014_VVA_TEMP_COMP_MSK		GENMASK(15, 0)
> +
> +/* ADMV1014 Miscellaneous Defines */
> +#define ADMV1014_READ				BIT(7)
> +#define ADMV1014_REG_ADDR_READ_MSK		GENMASK(6, 1)
> +#define ADMV1014_REG_ADDR_WRITE_MSK		GENMASK(22, 17)
> +#define ADMV1014_REG_DATA_MSK			GENMASK(16, 1)
> +#define ADMV1014_NUM_REGULATORS			9

...

> +
> +static int admv1014_init(struct admv1014_state *st)
> +{
> +	unsigned int chip_id, enable_reg, enable_reg_msk;
> +	struct spi_device *spi = st->spi;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ADMV1014_NUM_REGULATORS, st->regulators);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable regulators");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->regulators);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_clk_disable, st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	st->nb.notifier_call = admv1014_freq_change;
> +	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_powerdown, st);
> +	if (ret)
> +		return ret;
> +
> +	/* Perform a software reset */
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
> +					 ADMV1014_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 1));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV1014 SPI software reset failed.\n");
> +		return ret;
> +	}
> +
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
> +					 ADMV1014_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 0));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV1014 SPI software reset disable failed.\n");
> +		return ret;
> +	}
> +
> +	ret = __admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
> +	if (ret) {
> +		dev_err(&spi->dev, "Writing default Temperature Compensation value failed.\n");
> +		return ret;
> +	}
> +
> +	ret = __admv1014_spi_read(st, ADMV1014_REG_SPI_CONTROL, &chip_id);
> +	if (ret)
> +		return ret;
> +
> +	chip_id = (chip_id & ADMV1014_CHIP_ID_MSK) >> 4;

Trivial but this could be a FIELD_GET()
