Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1284A3619
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354731AbiA3L7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347001AbiA3L7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:59:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058F7C061714;
        Sun, 30 Jan 2022 03:59:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98ED56117E;
        Sun, 30 Jan 2022 11:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B95BC340E4;
        Sun, 30 Jan 2022 11:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643543986;
        bh=F8nXPz35OtP5OfBM7wHjBgHhU1ylr21DMNtrcEazCQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oo57PfTcGqR0UvSeDQb/ui2v8Oy9HzabNKeGbKUIEHXcETP8sBgslfFj+Th8/atyM
         09Vj9U9jE5h8DjYfZKqgE+WRtEsr4atrLW7X90IOHFQiJFAd97k2FGIwMIDxkXCWEq
         PH14jucciUZkSvZlJbLOQtPGJY+E0YNRUf4ow0LMT9JlWkAP6uQd3lY86xF/o9WINx
         bHQSuQ38BIUrpxiUMMWfvVTsojl8j6BLL/rm6c7iPr2Yljd9bCFsQEzr5EabY9GCse
         rGQTeboEVMtaLG5RAuiWzWUY5in/ot/JBEnU99wZywAZq36U/ihgUUGnvKD9uIxlov
         4w4wwxesnB+xQ==
Date:   Sun, 30 Jan 2022 12:06:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] iio:frequency:admv1014: add support for ADMV1014
Message-ID: <20220130120608.73ca3e1d@jic23-huawei>
In-Reply-To: <20220127105558.59567-1-antoniu.miclaus@analog.com>
References: <20220127105558.59567-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 12:55:55 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV1014 is a silicon germanium (SiGe), wideband,
> microwave downconverter optimized for point to point microwave
> radio designs operating in the 24 GHz to 44 GHz frequency range.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - make regulators mandatory
>  - use regulator bulk get/enable

The error handling and remove paths for these aren't correct. See inline.

So nearly there. I thought about fixing it up, but it's just beyond the boundary
of the sort of change I'll make whilst applying.  Sightly too complex.

Thanks,

Jonathan


>  drivers/iio/frequency/Kconfig    |  10 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv1014.c | 820 +++++++++++++++++++++++++++++++
>  3 files changed, 831 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv1014.c
> 
...

> diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
> new file mode 100644
> index 000000000000..4ae422bd9bf4
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1014.c
> @@ -0,0 +1,820 @@

...

> +static int admv1014_init(struct admv1014_state *st)
> +{
> +	int ret;
> +	unsigned int chip_id, enable_reg, enable_reg_msk;
> +	struct spi_device *spi = st->spi;
> +
> +	ret = regulator_bulk_enable(ADMV1014_NUM_REGULATORS, st->regulators);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable regulators");
> +		goto error_disable_reg;
Firstly, you shouldn't be calling regulator_bulk_disable() if regulator_bulk_enable()
has failed as like vast majority of such functions if it returns an error code
it should have done it's own cleanup (disabled any regulators it had enable before
the error happened)

Secondly there is no disabling of the regulators in error paths other than in this
function or in the module remove path.  Given everything else is managed
you need a devm_add_action_or_reset() with appropriate callback to disable
these regulators in both error and remove paths.

> +	}
> +
> +	ret = clk_prepare_enable(st->clkin);
> +	if (ret)
> +		goto error_disable_reg;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_clk_disable, st->clkin);
> +	if (ret)
> +		goto error_disable_reg;
> +
> +	st->nb.notifier_call = admv1014_freq_change;
> +	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
> +	if (ret)
> +		goto error_disable_reg;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_powerdown, st);
> +	if (ret)
> +		goto error_disable_reg;
> +
> +	/* Perform a software reset */
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
> +					 ADMV1014_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 1));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV1014 SPI software reset failed.\n");
> +		goto error_disable_reg;
> +	}
> +
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
> +					 ADMV1014_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 0));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV1014 SPI software reset disable failed.\n");
> +		goto error_disable_reg;
> +	}
> +
> +	ret = __admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
> +	if (ret) {
> +		dev_err(&spi->dev, "Writing default Temperature Compensation value failed.\n");
> +		goto error_disable_reg;
> +	}
> +
> +	ret = __admv1014_spi_read(st, ADMV1014_REG_SPI_CONTROL, &chip_id);
> +	if (ret)
> +		goto error_disable_reg;
> +
> +	chip_id = (chip_id & ADMV1014_CHIP_ID_MSK) >> 4;
> +	if (chip_id != ADMV1014_CHIP_ID) {
> +		dev_err(&spi->dev, "Invalid Chip ID.\n");
> +		ret = -EINVAL;
> +		goto error_disable_reg;
> +	}
> +
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_QUAD,
> +					 ADMV1014_QUAD_SE_MODE_MSK,
> +					 FIELD_PREP(ADMV1014_QUAD_SE_MODE_MSK,
> +						    st->quad_se_mode));
> +	if (ret) {
> +		dev_err(&spi->dev, "Writing Quad SE Mode failed.\n");
> +		goto error_disable_reg;
> +	}
> +
> +	ret = admv1014_update_quad_filters(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Update Quad Filters failed.\n");
> +		goto error_disable_reg;
> +	}
> +
> +	ret = admv1014_update_vcm_settings(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Update VCM Settings failed.\n");
> +		goto error_disable_reg;
> +	}
> +
> +	enable_reg_msk = ADMV1014_P1DB_COMPENSATION_MSK |
> +			 ADMV1014_IF_AMP_PD_MSK |
> +			 ADMV1014_BB_AMP_PD_MSK |
> +			 ADMV1014_DET_EN_MSK;
> +
> +	enable_reg = FIELD_PREP(ADMV1014_P1DB_COMPENSATION_MSK, st->p1db_comp ? 3 : 0) |
> +		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, !(st->input_mode)) |
> +		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, st->input_mode) |
> +		     FIELD_PREP(ADMV1014_DET_EN_MSK, st->det_en);
> +
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE, enable_reg_msk, enable_reg);
> +	if (ret)
> +		goto error_disable_reg;
> +
> +	return 0;
> +
> +error_disable_reg:
> +	regulator_bulk_disable(ADMV1014_NUM_REGULATORS, st->regulators);
This now doesn't happen in the remove path.

you need to use a devm_add_action_or_reset() with appropriate callback
to clean these up.

> +
> +	return ret;
> +}
> +

...

> +static int admv1014_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct admv1014_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	ret = admv1014_properties_parse(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &admv1014_info;
> +	indio_dev->name = "admv1014";
> +
> +	if (st->input_mode == ADMV1014_IQ_MODE) {
> +		indio_dev->channels = admv1014_channels_iq;
> +		indio_dev->num_channels = ARRAY_SIZE(admv1014_channels_iq);
> +	} else {
> +		indio_dev->channels = admv1014_channels_if;
> +		indio_dev->num_channels = ARRAY_SIZE(admv1014_channels_if);
> +	}
> +
> +	st->spi = spi;
> +
> +	mutex_init(&st->lock);
> +
> +	ret = admv1014_init(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);

If this call fails regulators are left on.  If you use
devm_add_action_or_reset() magic then they won't be as that callback
will get called in the error handling for the function that called
probe()


> +}
> +

