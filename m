Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8402A48FD2A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiAPNZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiAPNZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:25:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880CAC061574;
        Sun, 16 Jan 2022 05:25:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2475EB80D41;
        Sun, 16 Jan 2022 13:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07128C36AE7;
        Sun, 16 Jan 2022 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642339550;
        bh=Lv/w19RFsCS19dBN/BlA8nwdPb+A2tMMfa5vNemp8cg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d1nv9zD+266hAHl4cVgiZbXeRqsne/rut5/qaeDbgWWKRKsR486AqoJbG+5VbO2QZ
         CkWRujp+2pcF96XVnY2s8C0jNYrW9WHhtE//b8ps1aQJZFT3eprKgl++TqfBam05hx
         N+ikEhS0pYOeGkUmdtjZevvO8gYtxQAt4nwHWgVh0KjnHU4GvL+qiffyivndLepte3
         s5tTcl61bTjsLw3Vin19qIsKI1EEiQK6+Q52vQsXK19lvaTGYtWaE92MHrcPwxARtx
         nG7hz6UFim/aax6G9Nvv8b4scDDYrF4byo/xLzkXgsxY4HuVaJE3LE9ofSXyeLAJy1
         8jWc4KO4cvvxQ==
Date:   Sun, 16 Jan 2022 13:31:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio:frequency:admv1014: add support for ADMV1014
Message-ID: <20220116133151.0123633c@jic23-huawei>
In-Reply-To: <20220110145839.163998-1-antoniu.miclaus@analog.com>
References: <20220110145839.163998-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 16:58:37 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV1014 is a silicon germanium (SiGe), wideband,
> microwave downconverter optimized for point to point microwave
> radio designs operating in the 24 GHz to 44 GHz frequency range.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf
> 
No blank line here. Datasheet is part of the tag block.
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

I requested a full ABI listing and comments in the patches description in my v1
review because some elements (hardwaregain) are not particularly obvious and
I'd like to understand how they relate to the actual things going on in the
signal path.  I can figure it out from the datasheet, but much easier if you
provide an explanation for reviewers as that's a dense document!

Some of the controls look to be IQ or IF mode specific and we should only
expose those relevant to the mode from the dt bindings.


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
> index 000000000000..ed30b4f916b6
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1014.c
> @@ -0,0 +1,949 @@

...

> +
> +static const int mixer_vgate_table[] = {106, 107, 108, 110, 111, 112, 113, 114, 117, 118, 119, 120, 122, 123, 44, 45};

Too long. Add some line breaks to keep it below 80 chars.

> +

...


> +static int admv1014_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct admv1014_state *st = iio_priv(indio_dev);
> +	unsigned int data;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		ret = admv1014_spi_read(st, ADMV1014_REG_IF_AMP_BB_AMP, &data);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->channel2 == IIO_MOD_I)
> +			*val = FIELD_GET(ADMV1014_BB_AMP_OFFSET_I_MSK, data);
> +		else
> +			*val = FIELD_GET(ADMV1014_BB_AMP_OFFSET_Q_MSK, data);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PHASE:
> +		ret = admv1014_spi_read(st, ADMV1014_REG_LO_AMP_PHASE_ADJUST1, &data);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->channel2 == IIO_MOD_I)
> +			*val = FIELD_GET(ADMV1014_LOAMP_PH_ADJ_I_FINE_MSK, data);
> +		else
> +			*val = FIELD_GET(ADMV1014_LOAMP_PH_ADJ_Q_FINE_MSK, data);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = admv1014_spi_read(st, ADMV1014_REG_MIXER, &data);
> +		if (ret)
> +			return ret;
> +
> +		*val = FIELD_GET(ADMV1014_DET_PROG_MSK, data);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = admv1014_spi_read(st, ADMV1014_REG_BB_AMP_AGC, &data);

Not immediately obvious to me what this is... It might be a scale on the output
channel?  Also I think it only applies in in IQ mode rather than IF?

> +		if (ret)
> +			return ret;
> +
> +		*val = FIELD_GET(ADMV1014_BB_AMP_GAIN_CTRL_MSK, data);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +


...


> +
> +#define _ADMV1014_EXT_INFO(_name, _shared, _ident) { \
> +		.name = _name, \
> +		.read = admv1014_read, \
> +		.write = admv1014_write, \
> +		.private = _ident, \
> +		.shared = _shared, \
> +}
> +
> +static const struct iio_chan_spec_ext_info admv1014_ext_info[] = {
> +	_ADMV1014_EXT_INFO("calibscale_coarse", IIO_SEPARATE, ADMV1014_CALIBSCALE_COARSE),
> +	_ADMV1014_EXT_INFO("calibscale_fine", IIO_SEPARATE, ADMV1014_CALIBSCALE_FINE),
> +	{ },
Null terminator, so ideally no trailing comma.  We'll never add anything after this last
element.

As I read the datasheet (may well be wrong) these are only relevant in IF mode so we shouldn't
expose them if in IQ..

> +};
> +
> +#define ADMV1014_CHAN(_channel, rf_comp) {				\
> +	.type = IIO_ALTVOLTAGE,						\
> +	.modified = 1,							\
> +	.output = 0,							\
> +	.indexed = 1,							\
> +	.channel2 = IIO_MOD_##rf_comp,					\
> +	.channel = _channel,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE) |		\
> +		BIT(IIO_CHAN_INFO_OFFSET),				\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN)	\
> +	}
> +
> +#define ADMV1014_CHAN_CALIBSCALE(_channel, rf_comp, _admv1014_ext_info) {	\
> +	.type = IIO_ALTVOLTAGE,						\
> +	.modified = 1,							\
> +	.output = 0,							\
> +	.indexed = 1,							\
> +	.channel2 = IIO_MOD_##rf_comp,					\
> +	.channel = _channel,						\
> +	.ext_info = _admv1014_ext_info					\
> +	}
> +
> +static const struct iio_chan_spec admv1014_channels[] = {
> +	ADMV1014_CHAN(0, I),
> +	ADMV1014_CHAN(0, Q),
> +	ADMV1014_CHAN_CALIBSCALE(0, I, admv1014_ext_info),
> +	ADMV1014_CHAN_CALIBSCALE(0, Q, admv1014_ext_info),
> +	{
> +		.type = IIO_POWER,
> +		.modified = 1,
> +		.output = 0,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE)
> +	}
> +};
> +
> +static void admv1014_clk_disable(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static void admv1014_reg_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
> +static void admv1014_powerdown(void *data)
> +{
> +	unsigned int enable_reg, enable_reg_msk;
> +
> +	/* Disable all components in the Enable Register */
> +	enable_reg_msk = ADMV1014_IBIAS_PD_MSK |
> +			ADMV1014_IF_AMP_PD_MSK |
> +			ADMV1014_QUAD_BG_PD_MSK |
> +			ADMV1014_BB_AMP_PD_MSK |
> +			ADMV1014_QUAD_IBIAS_PD_MSK |
> +			ADMV1014_BG_PD_MSK;
> +
> +	enable_reg = FIELD_PREP(ADMV1014_IBIAS_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1014_QUAD_BG_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1014_QUAD_IBIAS_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1014_BG_PD_MSK, 1);
> +
> +	admv1014_spi_update_bits(data, ADMV1014_REG_ENABLE,
> +				 enable_reg_msk, enable_reg);
> +}
> +
> +static int admv1014_init(struct admv1014_state *st)
> +{
> +	int ret;
> +	unsigned int chip_id, enable_reg, enable_reg_msk;
> +	struct spi_device *spi = st->spi;
> +
> +	ret = regulator_enable(st->vcm_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable Common-Mode Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcm_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (regulator_get_voltage(st->vcc_if_bb_reg) != 3300000) {
> +		dev_err(&spi->dev, "Invalid BB and IF supply voltage value!\n");

See below.

> +		return -EINVAL;
> +	}
> +
> +	ret = regulator_enable(st->vcc_if_bb_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable BB and IF Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_if_bb_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (regulator_get_voltage(st->vcc_vga_reg) != 3300000) {
> +		dev_err(&spi->dev, "Invalid RF Amplifier supply voltage value!\n");

See below for why I don't think you should be doing this.

> +		return -EINVAL;
> +	}
> +
> +	ret = regulator_enable(st->vcc_vga_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable RF Amplifier Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_vga_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (regulator_get_voltage(st->vcc_vva_reg) != 1800000) {

This is an optional regulator in the dt spec, so you can't guarantee a read will give
you anything useful.   I'm also not sure that checking supply voltages are correct
is something a driver should be doing.

A regulator might only do 1800001 and that is probably within tolerances anyway so
this level of precision is not a good idea.

I would just drop these checks and stick to regulator enables.  Probably use the
bulk interfaces to cut down on code as well.

> +		dev_err(&spi->dev, "Invalid VVA Control Circuit voltage value!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regulator_enable(st->vcc_vva_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable VVA Control Circuit Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_vva_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (regulator_get_voltage(st->vcc_lna_3p3_reg) != 3300000) {
> +		dev_err(&spi->dev, "Invalid Low Noise Amplifier 3.3V voltage value!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regulator_enable(st->vcc_lna_3p3_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable Low Noise Amplifier 3.3V Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_lna_3p3_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (regulator_get_voltage(st->vcc_lna_1p5_reg) != 1500000) {
> +		dev_err(&spi->dev, "Invalid BB and Low Noise Amplifier 1.5V voltage value!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regulator_enable(st->vcc_lna_1p5_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable Low Noise Amplifier 1.5V Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_lna_1p5_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (regulator_get_voltage(st->vcc_bg_reg) != 3300000) {
> +		dev_err(&spi->dev, "Invalid Band Gap Circuit voltage value!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regulator_enable(st->vcc_bg_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable Band Gap Circuit Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_bg_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (regulator_get_voltage(st->vcc_quad_reg) != 3300000) {
> +		dev_err(&spi->dev, "Invalid BB and Quadruple voltage value!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regulator_enable(st->vcc_quad_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable Quadruple Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_quad_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (regulator_get_voltage(st->vcc_mixer_reg) != 3300000) {
> +		dev_err(&spi->dev, "Invalid Mixer supply voltage value!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regulator_enable(st->vcc_mixer_reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable Mixer Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->vcc_mixer_reg);
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
> +	ret = admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
> +	if (ret) {
> +		dev_err(&spi->dev, "Writing default Temperature Compensation value failed.\n");
> +		return ret;
> +	}
> +
> +	ret = admv1014_spi_read(st, ADMV1014_REG_SPI_CONTROL, &chip_id);

Mixing locked and unlocked calls in init doesn't make much sense.
It's fine to use either locked or unlocked throughout as we can't race
but it's not a fast path where the locks will matter.


> +	if (ret)
> +		return ret;
> +
> +	chip_id = (chip_id & ADMV1014_CHIP_ID_MSK) >> 4;
> +	if (chip_id != ADMV1014_CHIP_ID) {
> +		dev_err(&spi->dev, "Invalid Chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_QUAD,
> +					 ADMV1014_QUAD_SE_MODE_MSK,
> +					 FIELD_PREP(ADMV1014_QUAD_SE_MODE_MSK,
> +						    st->quad_se_mode));
> +	if (ret) {
> +		dev_err(&spi->dev, "Writing Quad SE Mode failed.\n");
> +		return ret;
> +	}
> +
> +	ret = admv1014_update_quad_filters(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Update Quad Filters failed.\n");
> +		return ret;
> +	}
> +
> +	ret = admv1014_update_vcm_settings(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Update VCM Settings failed.\n");
> +		return ret;
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
> +	return __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE, enable_reg_msk, enable_reg);

> +}
> +
> +static int admv1014_properties_parse(struct admv1014_state *st)
> +{
> +	const char *str;
> +	struct spi_device *spi = st->spi;
> +
> +	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");
> +
> +	st->p1db_comp = device_property_read_bool(&spi->dev, "adi,p1db-compensation-enable");
> +
> +	str = "iq";
> +	device_property_read_string(&spi->dev, "adi,input-mode", &str);
> +
> +	if (!strcmp(str, "iq"))
> +		st->input_mode = ADMV1014_IQ_MODE;
> +	else if (!strcmp(str, "if"))
> +		st->input_mode = ADMV1014_IF_MODE;
> +	else
> +		return -EINVAL;
> +
> +	str = "diff";
> +	device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
> +
> +	if (!strcmp(str, "diff"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_DIFF;
> +	else if (!strcmp(str, "se-pos"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_POS;
> +	else if (!strcmp(str, "se-neg"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_NEG;
> +	else
> +		return -EINVAL;
> +
> +	st->vcm_reg = devm_regulator_get(&spi->dev, "vcm");
> +	if (IS_ERR(st->vcm_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcm_reg),
> +				     "failed to get the common-mode voltage\n");
> +
> +	st->vcc_if_bb_reg = devm_regulator_get(&spi->dev, "vcc-if-bb");
> +	if (IS_ERR(st->vcc_if_bb_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_if_bb_reg),
> +				     "failed to get the BB and IF supply\n");
> +
> +	st->vcc_vga_reg = devm_regulator_get(&spi->dev, "vcc-vga");
> +	if (IS_ERR(st->vcc_vga_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_vga_reg),
> +				     "failed to get the RF Amplifier supply\n");
> +
> +	st->vcc_vva_reg = devm_regulator_get(&spi->dev, "vcc-vva");
> +	if (IS_ERR(st->vcc_vva_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_vva_reg),
> +				     "failed to get the VVA Control Circuit supply\n");
> +
> +	st->vcc_lna_3p3_reg = devm_regulator_get(&spi->dev, "vcc-lna-3p3");
> +	if (IS_ERR(st->vcc_lna_3p3_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_lna_3p3_reg),
> +				     "failed to get the Low Noise Amplifier 3.3V supply\n");
> +
> +	st->vcc_lna_1p5_reg = devm_regulator_get(&spi->dev, "vcc-lna-1p5");
> +	if (IS_ERR(st->vcc_lna_1p5_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_lna_1p5_reg),
> +				     "failed to get the Low Noise Amplifier 1.5V supply\n");
> +
> +	st->vcc_bg_reg = devm_regulator_get(&spi->dev, "vcc-bg");
> +	if (IS_ERR(st->vcc_lna_1p5_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_bg_reg),
> +				     "failed to get the Band Gap Circuit supply\n");
> +
> +	st->vcc_quad_reg = devm_regulator_get(&spi->dev, "vcc-quad");
> +	if (IS_ERR(st->vcc_quad_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_quad_reg),
> +				     "failed to get the Quadruple supply\n");
> +
> +	st->vcc_mixer_reg = devm_regulator_get(&spi->dev, "vcc-mixer");
> +	if (IS_ERR(st->vcc_quad_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->vcc_mixer_reg),
> +				     "failed to get the Mixer supply\n");
> +
> +	st->clkin = devm_clk_get(&spi->dev, "lo_in");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> +				     "failed to get the LO input clock\n");
> +
> +	return 0;
> +}
> +
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
> +	indio_dev->info = &admv1014_info;
> +	indio_dev->name = "admv1014";
> +	indio_dev->channels = admv1014_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(admv1014_channels);
> +
> +	st->spi = spi;
> +
> +	ret = admv1014_properties_parse(st);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&st->lock);
> +
> +	ret = admv1014_init(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_powerdown, st);
> +	if (ret)

Move this into init as it is undoing just one step of all the stuff done
in init rather than all of them.  If it were doing all the undos then it would
be fine at this level.

> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +

